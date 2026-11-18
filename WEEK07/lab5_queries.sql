-- ============================================
-- VUA-SEN307 Lab 5: SELECT, Filtering and Joins
-- Name: ISINTUME THANKGOD KOSISOCHUKWU   Matric: VUG/SEN/25/14777
-- ============================================

USE sen307_vug_sen_25_14777;

-- Task 1: Students in one department, sorted A-Z
SELECT s.student_id, s.full_name, d.dept_name
FROM Student s
INNER JOIN Department d ON s.dept_id = d.dept_id
WHERE d.dept_name = 'Software Engineering'
ORDER BY s.full_name ASC;
-- Explanation: This joins Student to Department using dept_id, keeps only
-- Software Engineering students with the WHERE clause, and sorts their
-- names from A to Z with ORDER BY.


-- Task 2: Courses with their lecturers (INNER JOIN)
SELECT c.course_title, l.full_name AS lecturer
FROM Course c
INNER JOIN CourseAllocation ca ON c.course_id = ca.course_id
INNER JOIN Lecturer l ON ca.lecturer_id = l.lecturer_id
ORDER BY c.course_title;
-- Explanation: Course and Lecturer are not directly linked, so this uses
-- two INNER JOINs through CourseAllocation. Only courses that have a
-- lecturer are returned. Database Systems (SEN307) appears twice because
-- it has two lecturers.


-- Task 3: Students and their courses (LEFT JOIN)
-- 3a: all students, including those with no enrolments
SELECT s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
ORDER BY s.full_name;
-- Explanation: LEFT JOIN keeps every student from the Student table, even
-- if they have no row in Enrolment. For those students, course_title
-- shows NULL.

-- 3b: only students with no courses
SELECT s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
WHERE c.course_title IS NULL
ORDER BY s.full_name;
-- Explanation: This is the same query with WHERE c.course_title IS NULL, so
-- it shows only the students who have no enrolments. IS NULL is used
-- because "= NULL" never matches anything in SQL.


-- Task 4: Filtering with AND / OR / IN / BETWEEN
SELECT s.full_name, s.gender, s.date_of_birth, s.dept_id
FROM Student s
WHERE s.gender = 'F'
  AND s.dept_id IN (1, 3)
  AND s.date_of_birth BETWEEN '2004-01-01' AND '2005-12-31'
ORDER BY s.full_name;
-- Explanation: This finds female students in department 1 or 3 (Software
-- Engineering or Artificial Intelligence) who were born between 2004-01-01
-- and 2005-12-31. AND means every condition must be true, IN checks a
-- list of values, and BETWEEN checks a range including both end dates.


-- Task 5: Paginating enrolments with LIMIT and OFFSET
-- Page 1 (rows 1-10)
SELECT * FROM Enrolment ORDER BY enrolment_id LIMIT 10 OFFSET 0;
-- Page 2 (rows 11-20)
SELECT * FROM Enrolment ORDER BY enrolment_id LIMIT 10 OFFSET 10;
-- Explanation: LIMIT 10 shows 10 rows at a time, and OFFSET skips the rows
-- already shown, so OFFSET 0 is page 1 and OFFSET 10 is page 2. ORDER BY
-- must always be used with LIMIT because without it SQL does not
-- guarantee the row order, so rows could repeat on both pages or be missed.


-- Challenge (optional): Task 3 using RIGHT JOIN
SELECT s.full_name, c.course_title
FROM Course c
RIGHT JOIN Enrolment e ON c.course_id = e.course_id
RIGHT JOIN Student s ON e.student_id = s.student_id
ORDER BY s.full_name;
-- Explanation: This gives the same result as the LEFT JOIN version because
-- Student is the table kept in full. The LEFT JOIN version is easier to
-- read because it starts from the main table (Student) and reads from
-- left to right, while the RIGHT JOIN version puts Student last.
