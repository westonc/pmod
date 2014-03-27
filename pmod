#!/usr/bin/python

import os
import sys
import stat

def main():
	path = cwdlist()
	runningPath = "";
	for d in path:
		runningPath = runningPath + os.path.sep + d
		print os.path.sep, d, modestr(runningPath)
	

def cwdlist():
	cwd = os.getcwd()
	cwdlist = cwd.split(os.path.sep)

	while not cwdlist[0]:
		cwdlist.pop(0)
	return cwdlist

if sys.version_info < (3, 3):

	# https://github.com/python/cpython/blob/master/Lib/stat.py	
	_filemode_table = (
		((stat.S_IFLNK,         	"l"),
		( stat.S_IFREG,         	"-"),
		( stat.S_IFBLK,         	"b"),
		( stat.S_IFDIR,         	"d"),
		( stat.S_IFCHR,         	"c"),
		( stat.S_IFIFO,         	"p")),

		((stat.S_IRUSR,         	"r"),),
		((stat.S_IWUSR,         	"w"),),
		((stat.S_IXUSR|stat.S_ISUID,"s"),
		( stat.S_ISUID,         	"S"),
		( stat.S_IXUSR,         	"x")),

		((stat.S_IRGRP,         	"r"),),
		((stat.S_IWGRP,         	"w"),),
		((stat.S_IXGRP|stat.S_ISGID,"s"),
		( stat.S_ISGID,         	"S"),
		( stat.S_IXGRP,         	"x")),

		((stat.S_IROTH,         	"r"),),
		((stat.S_IWOTH,         	"w"),),
		((stat.S_IXOTH|stat.S_ISVTX,"t"),
		( stat.S_ISVTX,         	"T"),
		( stat.S_IXOTH,         	"x"))
	)

	def mode2str(mode):
		"""Convert a file's mode to a string of the form '-rwxrwxrwx'."""
		perm = []
		for table in _filemode_table:
			for bit, char in table:
				if mode & bit == bit:
					perm.append(char)
					break
				else:
					perm.append("-")
		return "".join(perm)

	def modestr(file):
		st = os.stat(file)
		return mode2str(st.st_mode)

else:

	def mode2str(mode):
		return stat.filemode(mode)

	def modestr(file):
		st = os.stat(file)
		return mode2str(st.st_mode)

if __name__ == "__main__":
    main()
