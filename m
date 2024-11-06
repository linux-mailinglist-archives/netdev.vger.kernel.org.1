Return-Path: <netdev+bounces-142161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FBF9BDAE3
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709861C20E3D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D950F139D0A;
	Wed,  6 Nov 2024 01:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="MM9mifa8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1-04.simnet.is (smtp-out1-04.simnet.is [194.105.232.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACC3A1DB
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.232.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855115; cv=none; b=lpN+jcx3UvcA3N4o8xe3bj+9FWYTeS1kKwULV2eYTXsHTcODyXosp9brJzrqbxlJtoBGUvLdY0XOsUFTy4ZWP8pb8UbJnU4f+qBYrMhzib87XSrc0+xptUBdjfYCJ2ZwIPh7vzXBEMB3ArKnPfrd9PmvsqgAwC1zvSFoXJTQihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855115; c=relaxed/simple;
	bh=iED6R0ZwErvMgew881tE6M7BvBSH1LyTKvxR5yT715E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d3r+4L9pT4oJ16UtcT8tufHEvnZXTEE7qkFLPIQLJDUdL6avwAw/G4La8SmHvH6sXD2pozvWYKesiz+uZyMwGyk0wDry8DNQtFj4Y/v8QKc7MyeQnuXTuKaNxlu7LJjSs+bGgs4rzhf6BGqrg/6EiRS1gRs5NV7dzC91YFmt39E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=MM9mifa8; arc=none smtp.client-ip=194.105.232.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1730855112; x=1762391112;
  h=date:from:to:subject:message-id:mime-version;
  bh=X2ZlgwDHunUuJxa0KwoulzU4A+4WV04FrceCIRIXejo=;
  b=MM9mifa8NRW6lKK0t5nmZ5nL7fjZ5AxWlW2LI2KGmLgJM0Ox1ZnBU0NZ
   Qr1U1XkFM5/zHQgyoq8nmo/cY5HKrMh1AG3kszx27CvATpXYZum1dUh3C
   B3aa3TPOo5uwrI4mggOYun2ABay/uUBEwvdcTFnGrK8uXJOojV0rR12i+
   jbZwNe2dwGnenwXdkoAgdtd0ven59YT321PsmpBlb2W9iTK516fRxfvS9
   yvb0phnwjpzMt3lIG14eLrlM+3uE7ShwOfClMCX3xGmmOqIEHxaqfLyUt
   HyAA7PSWaQ93qWD56ohfxSDVo+B72yO7LzhNcppBQNlnz+1XzhuufxYMo
   A==;
X-CSE-ConnectionGUID: y5Jrlv0HTsqgKQC/JAzKbg==
X-CSE-MsgGUID: GZbTjQCDQUiyKt/01rq0mQ==
Authentication-Results: smtp-out-04.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2G6CACZuSpnhVnoacJaHQIOLwUFEAkKgVWCGih9gWSIJ?=
 =?us-ascii?q?Y4CHYEWghKcdgcBAQEPFAIBAg4KEwQBAQSFVAEBD4lVKDgTAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBDgEBBgEBAQEBAQYHAhABAQEBQA47hTVGDYUsLIJ7X4MBAYJkr?=
 =?us-ascii?q?2GBNIEBgxzbF4FdEIFIAYVpgmIBhWmEdzwGgg2BFTWBc0p2iwcEgkh8gXoMg?=
 =?us-ascii?q?g4SJYIvgRCFVoglhCWLL4FpA1khEQFVExcLBwWBegODUoE5gVGDIEqDWYFCR?=
 =?us-ascii?q?j83ghNpSzoCDQI2giR9gk6DGIIFhHCEaYEjHTYKAwttPTUUG58wAUaCNy9DA?=
 =?us-ascii?q?QEVJx00gQRAAzAGBAsePz2STkSPRIFEoVyEJIZbgzCCC5VDM4QEkzsMOpJIm?=
 =?us-ascii?q?HejbgEYhRuBfoF/LAcaCDA7gmcJSRkPjioZgQwBB4civld4OwIHCwEBAwmRA?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23:LuT3txN6H2qD1O34+3sl6ncoWUAX0o4cXyYO74Y/zrVTbuH7o9L5P
 UnZ6OkrjUSaFYnY6vcRje3QvuigXGEb+p+OvTgEd4AETB4Kj8ga3kQgDceJBFe9LavsaCo3d
 Pk=
IronPort-Data: A9a23:q7xuvagzX9WBGvrCdX/fSZfWX161lBAKZh0ujC45NGQN5FlGYwSz7
 tYtKTreYZDXMzzrLps0dtnlp1dG78XLxubXe3Jp/ns1EX5DoJSZXN+VJEqtYn3LJJycRx9qv
 pxANdfMdZBrEXON+hn1arKw8XJxj//XF7egUL6danksHwVqEHd44f4Pd5bVp6Yx6TTuK1/Q4
 oiaT7TjBWKYNx5I3kM8tqmI9Rpm5q78sWoWtQVhPfwS4AaByilOXMMRKfvvcyXRT9gPFIZWZ
 c6al+jhoTmxEzTBqz+BuuymGqHfaueKZWBislIPBu76xEAE/3RuukoCHKJ0QV9NjDmUlMxGx
 txItJihIS8kJaSkdN41CnG0KAkge/QfkFP7CSLn65DKlhWbKyeEL8hGVSnaA6VJq46bPkkWn
 RAoAGhlRgyOgeuw3IW6RoFE7ij0BJC2VG+3kigIIQDxVZ7Kc7iaK0n5zYMwMAMLuyx7Na22i
 /z1xtZYRE+ojxVnYj/7AX+l9QuiriGXnzZw8Dp5qUerioR6IcMYPLXFabLoltK2qcp9jxu6v
 GbYp0TFGQgVF+W0jhis4FGmibqa9c/7cNp6+LyQ6P9xnBiBx2kLEhoGRB7j+r+ni1WiHdNEQ
 6AW0nN/8e5rrBHtFIKnGU3pyJKHlkd0t954GeIS8wCIzKfIpQeCboQBZmQdM4d/6JNnLdAs/
 nC7le/rPBdDiYCUWFGBse/NtyrqPBFAeAfuYgdfEVtUvIi/yG0ptTrJQ8pvHbCdkNL4A3fzz
 iqMoSx4gK8c5fPnzI2l/EvbxiCto4DTSR4ko12MGHyk9R8/ZZXNi5GUBUbz/KtiNoKHFnm9p
 2ELuPG1q8InH7KHm3nYKAkSJ42B6/GAOTzapFdgGZg96jigk0JPm6gMv1mSw281Yq45lS/VX
 aPFhe9GzL5oVEZGgIdpYpmtTtYryLD6EsT0E6iPKMRPeYQ3dRTvEMBSiay4gjCFfKsEyPBX1
 XKnnSCEVixy5UNPl2Peegvl+eV3rh3SPEuKLXwB8zyp0KCFeFmeQqofPV2FY4gRtfzf+FWOq
 ooPa5DVl32ztdEShAGLrub/ynhXdRAG6Wze+5A/mhOre1Y9Rjh/YxMv6elxJdENc1tpehfgp
 S3tCxAJlDITdFXCKAGDInBtAI4Drr4ixU/XyRcEZA7ys1B6ONrHxPlELfMfI+J4nNGPONYvF
 JHpje3bWawXElwqOl01MfHAkWCVXE/21V7Qbnf5OWNXklwJb1Whx+IItzDHrEEmZhdbf+Nny
 1F8/ms3maY+ejk=
IronPort-HdrOrdr: A9a23:M3Ho3qtWj19EsMXeZ6jcwxAl7skDX9V00zEX/kB9WHVpmvTyrb
 HKoB17726WtN91YhpLpTnuAsS9qAznhOZICOUqUYtKJTOW3ldAdbsSircKoAeBJ8SdzIBgPM
 5bGsBD4bbLbGSS4/yU3OGeeOxQouVuy8uT9IPjJ04Hd3ASV0ho1XYDNjqm
X-Talos-CUID: 9a23:qtIya2CwDulLNaH6Ezg61lQQBJgFTmbEw1TpCAiaIHRKQrLAHA==
X-Talos-MUID: 9a23:BPBcZgTT0a9Q+IwYRXTDtjteNv5Dz52TCVEujdJe4tOdbSlJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="8'?scan'208";a="24331449"
Received: from vist-zimproxy-03.vist.is ([194.105.232.89])
  by smtp-out-04.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 01:05:09 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTP id 56488406C378
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:05:09 +0000 (GMT)
Received: from vist-zimproxy-03.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-03.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id daPuBKurps5d for <netdev@vger.kernel.org>;
 Wed,  6 Nov 2024 01:05:08 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTP id C41E14077B08
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:05:08 +0000 (GMT)
Received: from vist-zimproxy-03.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-03.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id cS0acxarSGPI for <netdev@vger.kernel.org>;
 Wed,  6 Nov 2024 01:05:08 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTPS id AB10D406C378
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:05:08 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98)
	(envelope-from <bg@kassi.invalid.is>)
	id 1t8UTt-000000000wE-2y99
	for netdev@vger.kernel.org;
	Wed, 06 Nov 2024 01:05:09 +0000
Date: Wed, 6 Nov 2024 01:05:09 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: netdev@vger.kernel.org
Subject: dcb-pfc.8: some remarks and editorial changes for this manual
Message-ID: <ZyrAxcsS04ppanYT@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="p5A1bFNqzksxKQea"
Content-Disposition: inline


--p5A1bFNqzksxKQea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  The man page is from Debian:

Package: iproute2
Version: 6.11.0-1
Severity: minor
Tags: patch

  Improve the layout of the man page according to the "man-page(7)"
guidelines, the output of "mandoc -lint T", the output of
"groff -mandoc -t -ww -b -z", that of a shell script, and typographical
conventions.

-.-

  Output from a script "chk_man" is in the attachment.

-.-

Signed-off-by: Bjarni Ingi Gislason <bjarniig@simnet.is>


diff --git a/dcb-pfc.8 b/dcb-pfc.8.new
index 735c16e..01fdb34 100644
--- a/dcb-pfc.8
+++ b/dcb-pfc.8.new
@@ -3,20 +3,19 @@
 dcb-pfc \- show / manipulate PFC (Priority-based Flow Control) settings of
 the DCB (Data Center Bridging) subsystem
 .SH SYNOPSIS
-.sp
 .ad l
 .in +8
 
 .ti -8
 .B dcb
-.RI "[ " OPTIONS " ] "
+.RI "[ " OPTIONS " ]"
 .B pfc
 .RI "{ " COMMAND " | " help " }"
 .sp
 
 .ti -8
 .B dcb pfc show dev
-.RI DEV
+.I DEV
 .RB "[ " pfc-cap " ]"
 .RB "[ " prio-pfc " ]"
 .RB "[ " macsec-bypass " ]"
@@ -26,7 +25,7 @@ the DCB (Data Center Bridging) subsystem
 
 .ti -8
 .B dcb pfc set dev
-.RI DEV
+.I DEV
 .RB "[ " prio-pfc " " \fIPFC-MAP " ]"
 .RB "[ " macsec-bypass " { " on " | " off " } ]"
 .RB "[ " delay " " \fIINTEGER\fR " ]"
@@ -35,7 +34,7 @@ the DCB (Data Center Bridging) subsystem
 .IR PFC-MAP " := [ " PFC-MAP " ] " PFC-MAPPING
 
 .ti -8
-.IR PFC-MAPPING " := { " PRIO " | " \fBall " }" \fB:\fR "{ "
+.IR PFC-MAPPING " := { " PRIO " | " \fBall " }" \fB:\fR {
 .IR \fBon\fR " | " \fBoff\fR " }"
 
 .ti -8
@@ -45,17 +44,22 @@ the DCB (Data Center Bridging) subsystem
 
 .B dcb pfc
 is used to configure Priority-based Flow Control attributes through Linux
-DCB (Data Center Bridging) interface. PFC permits marking flows with a
-certain priority as lossless, and holds related configuration, as well as
-PFC counters.
+DCB (Data Center Bridging) interface.
+PFC permits marking flows with a certain priority as lossless,
+and holds related configuration,
+as well as PFC counters.
 
 .SH PARAMETERS
 
-For read-write parameters, the following describes only the write direction,
-i.e. as used with the \fBset\fR command. For the \fBshow\fR command, the
-parameter name is to be used as a simple keyword without further arguments. This
-instructs the tool to show the value of a given parameter. When no parameters
-are given, the tool shows the complete PFC configuration.
+For read-write parameters,
+the following describes only the write direction,
+i.e., as used with the \fBset\fR command.
+For the \fBshow\fR command,
+the parameter name is to be used as a simple keyword without further
+arguments.
+This instructs the tool to show the value of a given parameter.
+When no parameters are given,
+the tool shows the complete PFC configuration.
 
 .TP
 .B pfc-cap
@@ -64,13 +68,13 @@ simultaneously support PFC.
 
 .TP
 .B requests
-A read-only count of the sent PFC frames per traffic class. Only shown when
--s is given, or when requested explicitly.
+A read-only count of the sent PFC frames per traffic class.
+Only shown when \-s is given, or when requested explicitly.
 
 .TP
 .B indications
-A read-only count of the received PFC frames per traffic class. Only shown
-when -s is given, or when requested explicitly.
+A read-only count of the received PFC frames per traffic class.
+Only shown when \-s is given, or when requested explicitly.
 
 .TP
 .B macsec-bypass \fR{ \fBon\fR | \fBoff\fR }
@@ -81,8 +85,10 @@ MACsec is disabled.
 .B prio-pfc \fIPFC-MAP
 \fIPFC-MAP\fR uses the array parameter syntax, see
 .BR dcb (8)
-for details. Keys are priorities, values are on / off indicators of whether
-PFC is enabled for a given priority.
+for details.
+Keys are priorities,
+values are on / off indicators of whether PFC is enabled for a given
+priority.
 
 .TP
 .B delay \fIINTEGER

--p5A1bFNqzksxKQea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chk_man.err.dcb-pfc.8"

  Any program (person), that produces man pages, should check the output
for defects by using (both groff and nroff)

[gn]roff -mandoc -t -ww -b -z -K utf8  <man page>

  The same goes for man pages that are used as an input.

  For a style guide use

  mandoc -T lint

-.-

  So any 'generator' should check its products with the above mentioned
'groff', 'mandoc',  and additionally with 'nroff ...'.

  This is just a simple quality control measure.

  The 'generator' may have to be corrected to get a better man page,
the source file may, and any additional file may.

  Common defects:

  Input text line longer than 80 bytes.

  Not removing trailing spaces (in in- and output).
  The reason for these trailing spaces should be found and eliminated.

  Not beginning each input sentence on a new line.
Lines should thus be shorter.

  See man-pages(7), item 'semantic newline'.

-.-

The difference between the formatted output of the original and patched file
can be seen with:

  nroff -mandoc <file1> > <out1>
  nroff -mandoc <file2> > <out2>
  diff -u <out1> <out2>

and for groff, using

"printf '%s\n%s\n' '.kern 0' '.ss 12 0' | groff -mandoc -Z - "

instead of 'nroff -mandoc'

  Add the option '-t', if the file contains a table.

  Read the output of 'diff -u' with 'less -R' or similar.

-.-.

  If 'man' (man-db) is used to check the manual for warnings,
the following must be set:

  The option "-warnings=w"

  The environmental variable:

export MAN_KEEP_STDERR=yes (or any non-empty value)

  or

  (produce only warnings):

export MANROFFOPT="-ww -b -z"

export MAN_KEEP_STDERR=yes (or any non-empty value)

-.-.

Output from "mandoc -T lint dcb-pfc.8": (possibly shortened list)

mandoc: dcb-pfc.8:6:2: WARNING: skipping paragraph macro: sp after SH

-.-.
Use the correct macro for the font change of a single argument or
split the argument into two.

19:.RI DEV
29:.RI DEV

-.-.

Change a HYPHEN-MINUS (code 0x2D) to a minus(-dash) (\-),
if it
is in front of a name for an option,
is a symbol for standard input,
is a single character used to indicate an option,
or is in the NAME section (man-pages(7)).
N.B. - (0x2D), processed as a UTF-8 file, is changed to a hyphen
(0x2010, groff \[u2010] or \[hy]) in the output.

68:-s is given, or when requested explicitly.
73:when -s is given, or when requested explicitly.

-.-.

Add a comma (or \&) after "e.g." and "i.e.", or use English words
(man-pages(7)).
Abbreviation points should be protected against being interpreted as
an end of sentence, if they are not, and that independent of the
current place on the line.

55:i.e. as used with the \fBset\fR command. For the \fBshow\fR command, the

-.-.

Wrong distance between sentences in the input file.

  Separate the sentences and subordinate clauses; each begins on a new
line.  See man-pages(7) ("Conventions for source file layout") and
"info groff" ("Input Conventions").

  The best procedure is to always start a new sentence on a new line,
at least, if you are typing on a computer.

Remember coding: Only one command ("sentence") on each (logical) line.

E-mail: Easier to quote exactly the relevant lines.

Generally: Easier to edit the sentence.

Patches: Less unaffected text.

Search for two adjacent words is easier, when they belong to the same line,
and the same phrase.

  The amount of space between sentences in the output can then be
controlled with the ".ss" request.

48:DCB (Data Center Bridging) interface. PFC permits marking flows with a
55:i.e. as used with the \fBset\fR command. For the \fBshow\fR command, the
56:parameter name is to be used as a simple keyword without further arguments. This
57:instructs the tool to show the value of a given parameter. When no parameters
67:A read-only count of the sent PFC frames per traffic class. Only shown when
72:A read-only count of the received PFC frames per traffic class. Only shown
84:for details. Keys are priorities, values are on / off indicators of whether

-.-.

No space is needed before a quote (") at the end of a line

12:.RI "[ " OPTIONS " ] "
38:.IR PFC-MAPPING " := { " PRIO " | " \fBall " }" \fB:\fR "{ "

-.-.

Output from "test-groff  -mandoc -t -K utf8 -rF0 -rHY=0 -ww -b -z ":

troff: backtrace: '/home/bg/git/groff/build/s-tmac/an.tmac':709: macro 'RI'
troff: backtrace: file '<stdin>':12
troff:<stdin>:12: warning: trailing space in the line
troff: backtrace: '/home/bg/git/groff/build/s-tmac/an.tmac':679: macro 'IR'
troff: backtrace: file '<stdin>':38
troff:<stdin>:38: warning: trailing space in the line


--p5A1bFNqzksxKQea--

