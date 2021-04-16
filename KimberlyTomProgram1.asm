TITLE Elementary Arithmetic    (KimberlyTomProgram1.asm)

; Author: Kimberly Tom
; Last Modified: 10/7/18
; OSU email address: tomki@oregonstate.edu
; Course number/section: 271_400
; Project Number:     01            Due Date: 10/7/18
; Description: This program asks for two integers from the user, and provides the sum, difference, product,
; quotient, and remainder.

INCLUDE Irvine32.inc


.data

number_1	DWORD	?			  ;integer to be entered by user
number_2	DWORD	?			  ;integer to be entered by user	
again_num	DWORD	?			  ;integer to be entered by user, 1 is yes, 2 is no
num_add 	DWORD	?			  ;addition answer
num_sub		DWORD   ?			  ;subtraction answer
num_mul		DWORD	?			  ;multiplication answer
num_div		DWORD   ?			  ;division answer
num_rem		DWORD	?			  ;remainder answer
thousand	DWORD	1000	      ;used to multiple by 1000	
FPx1000		DWORD	0			  ;to store number multiplied by 1000	
decimal1	BYTE	".", 0		  ;decimal point
leftDec		DWORD	?			  ;number to left of decimal point
rightDec	DWORD	?			  ;number to right of decimal point
temporary	DWORD	?			  ;holds a temporary value
again1		BYTE	"Do you want to perform the program with different numbers? Please enter 1 for yes, or 2 to exit. ", 0	
invalid1	BYTE	"The second number must be less than the first.", 0
title_1		BYTE	"Elementary Arithmetic		by Kimberly Tom", 0
EC1			BYTE	"**EC: Program will loop until user wants to exit.", 0
EC2			BYTE	"**EC: Program will ask user to run program again if second integer is not less than the first number.", 0
EC3			BYTE	"**EC: Program will display quotient as floating point number to the nearest .001.", 0
intro		BYTE	"Enter 2 numbers, and I will provide the sum, difference, product, quotient and remainder. ", 0
intro2		BYTE	"The first number must be greater than the second number or program will exit. ", 0
prompt_1	BYTE	"First number: ", 0
prompt_2	BYTE	"Second number: ", 0
equalSign	BYTE	" = ", 0
addSign		BYTE	" + ", 0
subSign		BYTE	" - ", 0
mulSign		BYTE	" * ", 0
divSign		BYTE	" / ", 0
remainder	BYTE	" remainder: ", 0
FPmessage	BYTE	"Floating Point quotient: ", 0
goodBye		BYTE	"Bye.", 0


.code
main PROC

;Begining of program, will loop back to Top if user selects 1 when prompted to repeat program

Top:

;Introduction
	mov		edx, OFFSET title_1
	call	WriteString
	call	CrLf
	mov		edx, OFFSET EC1
	call	WriteString
	call	CrLf
	mov		edx, OFFSET EC2
	call	WriteString
	call	CrLf
	mov		edx, OFFSET EC3
	call	WriteString
	call	CrLf
	call	CrLf
	mov		edx, OFFSET intro
	call	WriteString
	call	CrLf
	mov		edx, OFFSET intro2
	call	WriteString
	call	CrLf
	call	CrLf

;Get the first integer
	mov		edx, OFFSET prompt_1
	call	WriteString
	call	ReadInt
	mov		number_1, eax

;Get the second integer
	mov		edx, OFFSET prompt_2
	call	WriteString
	call	ReadInt
	mov		number_2, eax
	call	CrLf

;if second number is not less than the first number, tell user it is invalud and ask if want to run program again
	cmp		eax, number_1
	jge		invalidNum
	

;Calculations
	;addition
	mov		eax, number_1
	add		eax, number_2
	mov		num_add, eax		;store sum

	;subtraction
	mov		eax, number_1
	sub		eax, number_2
	mov		num_sub, eax		;store difference

	;multiplication
	mov		eax, number_1
	mul		number_2
	mov		num_mul, eax		;store product

	;division
	mov		edx, 0
	mov		eax, number_1
	mov		ebx, number_2
	div		ebx
	mov		num_div, eax		;store quotient
	mov		num_rem, edx		;store remainder

	;floating point division
	fld		number_1		
	fdiv	number_2		
	fimul	thousand		
	frndint
	fist	FPx1000				;floating point answer multipled by 1000

;Display the results

	;print addition results
	mov		eax, number_1
	call	WriteDec
	mov		edx, OFFSET addSign
	call	WriteString
	mov		eax, number_2
	call	WriteDec
	mov		edx, OFFSET equalSign
	call	WriteString
	mov		eax, num_add
	call	WriteDec
	call	CrLf
	
	;print subtraction results
	mov		eax, number_1
	call	WriteDec
	mov		edx, OFFSET subSign
	call	WriteString
	mov		eax, number_2
	call	WriteDec
	mov		edx, OFFSET equalSign
	call	WriteString
	mov		eax, num_sub
	call	WriteDec
	call	CrLf
	
	;print multiplication results
	mov		eax, number_1
	call	WriteDec
	mov		edx, OFFSET mulSign
	call	WriteString
	mov		eax, number_2
	call	WriteDec
	mov		edx, OFFSET equalSign
	call	WriteString
	mov		eax, num_mul
	call	WriteDec
	call	CrLf

	;print division results
	mov		eax, number_1
	call	WriteDec
	mov		edx, OFFSET divSign
	call	WriteString
	mov		eax, number_2
	call	WriteDec
	mov		edx, OFFSET equalSign
	call	WriteString
	mov		eax, num_div
	call	WriteDec
	mov		edx, OFFSET	remainder
	call	WriteString
	mov		eax, num_rem
	call	WriteDec
	call	CrLf

	;print floating point division results
	mov		edx, OFFSET FPmessage
	call	WriteString
	mov		edx, 0
	mov		eax, FPx1000
	cdq
	mov		ebx, 1000
	cdq
	div		ebx
	mov		leftDec, eax			
	mov		eax, leftDec
	call	WriteDec					;display numbers left a decimal point
	mov		edx, OFFSET decimal1	
	call	WriteString					;display decimal point
	mov		eax, leftDec			
	mul		thousand
	mov		temporary, eax
	mov		eax, FPx1000
	sub		eax, temporary				;subtract to be only left with the right hand portion (gets rid of left hand portion)
	mov		rightDec, eax	
	call	WriteDec					;display numbers right of decimal point
	call	CrLf
	call	CrLf

	
;Ask if user wants to run simulation again
RunAgain:
	mov		edx, OFFSET again1
	call	WriteString
	call	CrLf
	call	ReadInt
	mov		again_num, eax
	cmp		again_num, 1
	je		Top
	jmp		TheEnd

;If second number is not smaller than the first number, show invalid error
InvalidNum:
	mov		edx, OFFSET	invalid1
	call	WriteString
	call	CrLf
	jmp		RunAgain

TheEnd:

;Say goodbye
	call	CrLf
	mov		edx, OFFSET goodBye
	call	WriteString
	call	CrLf

	

	exit								;exit to operating system
main ENDP


END main
