Return-Path: <netdev+bounces-142182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EC79BDB54
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29D0284B24
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9DC18BC3B;
	Wed,  6 Nov 2024 01:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="BFwF31xQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1-06.simnet.is (smtp-out1-06.simnet.is [194.105.231.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E4C18BC03
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.231.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857271; cv=none; b=tBN/J9/94E4GVizv9g9i9TZwWX4/xxTXzDvj/pw/nhMbf1HoRu7fw6fFPKG9HoLfqlmq5DZb/LfvnqDD9F9wmbCJB1WKaxMeMvKDQBjRwFYA14422FBQoJg/mWxgdAy+HXSHlhUYJ2PK3sblhP4OlNQnX5hWXhok1rMCQEaLT/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857271; c=relaxed/simple;
	bh=gnqRah/z3WT+J3rgkxp48QI59Id2RdmGSzR4v9UQjUs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UEkBSazuXlMltmM4s+nGf1GT6IdUDoPHOHr2lGU/p/hyZQfVvmz5fgjm14eOSF6tzeY+6MqM0WtXGqTzJn/t1oDZMefz0WbkYOeiRdTserwWouHckD0FsUEPYLr/PBq3nistkG86w6W8TJuWTUG2v5R2FKMzmlHobYFqZ6tEop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=BFwF31xQ; arc=none smtp.client-ip=194.105.231.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1730857266; x=1762393266;
  h=date:from:to:subject:message-id:mime-version;
  bh=bdltZ8fUGpS3bhFyE/OLPHTB+LPp+xVwHWtXnuZXTr0=;
  b=BFwF31xQFpna2by5xi9jdT1p1l80x6pGbDeTi+2xxTXoE4p/LoJhu+tc
   RF5jlKxpdsbWlXTMGc59zhjmwa6gCH87bIr76vRSgaURTTOtbRamTlwMt
   iowz7gjCWwM7z3ED1/21gg+q6fdg/VGG/e5C0pRACI1lNaHQ5qd7H4+cY
   mXKpzk9V1agA0QDbScL53npacPZ4QkHQqymzXqnt9oYMN2QO34Nz4A3XT
   CF5/XDANohj/cYOILNXGag9pec2eWKAl/nzx1S1wvnUbU9CjmqTNtgqn7
   MqN82ywFDHOXYav7wjCSOnk16gW4DmdMcSjmOcIlCIp6ilhSJBQtGqf9x
   Q==;
X-CSE-ConnectionGUID: RwQSpw5MT46r9RYoEOcqGw==
X-CSE-MsgGUID: K8xVgxZJSbKjKFVC1CZeTQ==
Authentication-Results: smtp-out-06.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2EEEgCXxypnhVnoacJaHAECDi8BBAQBEAEHAQqBVYFaA?=
 =?us-ascii?q?j4ofYFkiCWOAh2BFoISnHYHAQEBDxQCAQIOChMEAQEEhVQBAQ+JVSg4EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQ4BAQYBAQEBAQEGBwIQAQEBAUAOO4U1Rg2FLCyCe?=
 =?us-ascii?q?1+DAQGCZK9cgTSBAYMc2xeBXRCBRgIBAYVogmIBhWmEdzwGgg2BFTWBBm1Kd?=
 =?us-ascii?q?osHBIJIfIIGgg4SJYIvgRCFVoglgleBTosvgWkDWSERAVUTFwsHBYF6A4NSg?=
 =?us-ascii?q?TmBUYMgSoNZgUJGPzeCE2lLOgINAjaCJH2CToMYggWEcIRpgSMdNgoDC209N?=
 =?us-ascii?q?RQbnzABRoI3L0MBAW4fC3ktEwMwBg8dASGTKUSPRIFEoB6BPoQkhluDMIILl?=
 =?us-ascii?q?UMzhASTOww6kkiYd6NhDRmFG4F+gX8sBxoIMDuCZwlJGQ+OKhmBDAEHhyK+N?=
 =?us-ascii?q?Hg7AgcLAQEDCZEDAQE?=
IronPort-PHdr: A9a23:JaR9KBPszb5Bgi1kgegl6ncoWUAX0o4cXyYO74Y/zrVTbuH7odL5P
 UnZ6OkrjUSaFYnY6vcRje3QvuigXGEb+p+OvTgEd4AETB4Kj8ga3kQgDceJBFe9LavsaCo3d
 Pk=
IronPort-Data: A9a23:HNA7yqgPB5DyOpYm+SNzO5H2X161lxAKZh0ujC45NGQN5FlGYwSz7
 tYtKTreYZDXMzzrLps0dtnlp1dE7NGX0N5T/DEc/3pjEnwa8pGbVY3IJUmvY3iZcJXKHB9s4
 s8XMNCZcZhlHi6Fr0/9P+awpHV33P6DTeqjWLCYZ3t/GwVvRXd+gHqP9wJBbqtA2LBVVCvQ5
 IityyGmBGKY5tJUDo41w/iN+EMysv2s4GIT4wQ0Ov4U4lOHx3UeV88TKfvrI3X2a4QFReTSq
 8TrlergpjyDl/sO5nJJtp6hLyXml5aLZVDmZkJ+AvXk2l4a4HVqjs7XDdJEAW9PkTKFgttt/
 9tEsJ20WG8BM7bF8Agne0Aw/xpWY+sfodcrHVDl6ZbPlhSeLiOwqxlTJBhe0bMwq7cf7V5mr
 ZT0GBhVBjifiuS/xq6MS+UErqzP++GyYevzElk5pd3oJa5OraLrGs0m1vcEtNsEvf2iKN6FD
 yYvhZWDWzybC/FHEg9/5JvTB45EjFGnG9FTgAr9SabafwE/ZeG+uVTgGIO9RzCEeSlatnyHn
 1ne4DncPk1ELo2l+D2o1Xm1qfCayEsXWKpKfFG53uBrm0HW1G0WEAcRRUr++aL/lE+lR5ReM
 CT4+AJ3/PR0rRT2CIOmBVvo8RZovTZFMzZUO+c1wBqMz6zZ/0CYHQDoSxYbNIN3659pGlTG0
 Heqz8PXCixdkoafanC+2Im/9BiANBQseDpqiSgsFldVsoay/OnflCnnSNt/HKOrpsP6FCu2w
 D2QqiU6wbIJgqY2O76T41Hcn3e+p53RVAkl90CPBSS77xhlIo++D2C11bTFxcxfFb2BUQSkg
 CRagZmk3ecjKpqUuzPYFY3hA4qVz/qCNTTdh3tmEJ8g6ymh9hafkWZ4vG4WyKBBbpZsRNP5X
 HI/rz+987dyBxOXgUJffYOqF4E4zK34D9P1R7WMNZxQY4NtMg6clM2PWaJy9z29+KTPufhuU
 Xt+TSpKJS1AYUiA5GHvL9rxKZdxmkgDKZr7HPgXNSiP37uEf2KyQrwYKlaIZe1RxPrb+12Fq
 I8DZ5fRlEk3vAjCjs//rdF7wbcicCBTOHwKg5wLHgJ+ClM6Qz94VZc9P5t7K9I490iqqgs41
 irhCh4HmQaXaYzvLASOYzhjZtvSsWVX8BoG0dgXFQ/wgRALON/zhI9BLMFfVed8q4ReIQtcF
 KJtlzOoWa8XEmyvFvV0RcWVkbGOgzzw2FLSYXv4PGFkF3OiLiSQkuLZksLU3HFmJkKKWQEW+
 dVMCiuzrUI/ejlf
IronPort-HdrOrdr: A9a23:IEk6lqMYep0ZS8BcTt6jsMiBIKoaSvp037AO7TEWdfU1SL3+qy
 nAppUmPHPP6Ar5O0tQ/exoWpPwJE80nKQdieJ6UNvMMjUO01HYTr2Kg7GSoAHdJw==
X-Talos-CUID: 9a23:wQfnLm3JvlGah4PYDYbN+bxfIN8cSWXCkVLsfxGiWFxYT5CyQka/5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3Am5c0Lw8aUF8og+Mx56nRPceQf+Q485qhGHIvqp8?=
 =?us-ascii?q?lueqqCwcpEAWQsA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="8'?scan'208";a="24797877"
Received: from vist-zimproxy-03.vist.is ([194.105.232.89])
  by smtp-out-06.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 01:40:57 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTP id 1D5FC4027CEA
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:40:57 +0000 (GMT)
Received: from vist-zimproxy-03.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-03.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id mcvr1EKofNKH for <netdev@vger.kernel.org>;
 Wed,  6 Nov 2024 01:40:56 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTP id 84074406C360
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:40:56 +0000 (GMT)
Received: from vist-zimproxy-03.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-03.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id qjW8FE2uaoPa for <netdev@vger.kernel.org>;
 Wed,  6 Nov 2024 01:40:56 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTPS id 6B98A4027CEA
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:40:56 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98)
	(envelope-from <bg@kassi.invalid.is>)
	id 1t8V2X-0000000016f-30dX
	for netdev@vger.kernel.org;
	Wed, 06 Nov 2024 01:40:57 +0000
Date: Wed, 6 Nov 2024 01:40:57 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: netdev@vger.kernel.org
Subject: dcb-rewr.8: some remarks and editorial changes for this manual
Message-ID: <ZyrJKT2g5m2jf5el@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YU6QhZ8BG83odT0m"
Content-Disposition: inline


--YU6QhZ8BG83odT0m
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

diff --git a/dcb-rewr.8 b/dcb-rewr.8.new
index 03b59cf..c4c338f 100644
--- a/dcb-rewr.8
+++ b/dcb-rewr.8.new
@@ -3,26 +3,25 @@
 dcb-rewr \- show / manipulate the rewrite table of
 the DCB (Data Center Bridging) subsystem
 .SH SYNOPSIS
-.sp
 .ad l
 .in +8
 
 .ti -8
 .B dcb
-.RI "[ " OPTIONS " ] "
+.RI "[ " OPTIONS " ]"
 .B rewr
 .RI "{ " COMMAND " | " help " }"
 .sp
 
 .ti -8
 .B dcb rewr " { " show " | " flush " } " dev
-.RI DEV
+.I DEV
 .RB "[ " prio-dscp " ]"
 .RB "[ " prio-pcp " ]"
 
 .ti -8
 .B dcb rewr " { " add " | " del " | " replace " } " dev
-.RI DEV
+.I DEV
 .RB "[ " prio-dscp " " \fIDSCP-MAP\fB " ]"
 .RB "[ " prio-pcp " " \fIPCP-MAP\fB " ]"
 
@@ -30,13 +29,13 @@ the DCB (Data Center Bridging) subsystem
 .IR DSCP-MAP " := [ " DSCP-MAP " ] " DSCP-MAPPING
 
 .ti -8
-.IR DSCP-MAPPING " := " \fIPRIO \fB:\fR "{ " DSCP " | " \fBall\fR " }"
+.IR DSCP-MAPPING " := " "PRIO\fB:\fR" "{ " DSCP " | " \fBall\fR " }"
 
 .ti -8
 .IR PCP-MAP " := [ " PCP-MAP " ] " PCP-MAPPING
 
 .ti -8
-.IR PCP-MAPPING " := " \fIPRIO \fB:\fR PCP\fR
+.IR PCP-MAPPING " := " PRIO \fB:\fR PCP
 
 .ti -8
 .IR DSCP " := { " \fB0\fR " .. " \fB63\fR " }"
@@ -73,7 +72,7 @@ and
 .B del
 commands. On the other hand, the command
 .B replace
-does what one would typically want in this situation--first adds the new
+does what one would typically want in this situation\(emfirst adds the new
 configuration, and then removes the obsolete one, so that only one
 rewrite rule is in effect for a given selector and priority.
 
@@ -126,7 +125,7 @@ will only use the higher six bits).
 .B dcb rewr show
 will similarly format DSCP values as symbolic names if possible. The
 command line option
-.B -N
+.B \-N
 turns the show translation off.
 
 .TP
@@ -135,8 +134,8 @@ turns the show translation off.
 .BR dcb (8)
 for details. Keys are priorities. Values are PCP/DEI for traffic with
 matching priority. PCP/DEI values are written as a combination of numeric- and
-symbolic values, to accommodate for both. PCP always in numeric form e.g 0 ..
-7 and DEI in symbolic form e.g 'de' (drop-eligible), indicating that the DEI
+symbolic values, to accommodate for both. PCP always in numeric form e.g.,
+0\~..\~7 and DEI in symbolic form, e.g., 'de' (drop-eligible), indicating that the DEI
 bit is 1 or 'nd' (not-drop-eligible), indicating that the DEI bit is 0.  In
 combination 1:2de translates to a mapping of priority 1 to PCP=2 and DEI=1.
 
@@ -155,7 +154,7 @@ Add a rule to rewrite DSCP to 25 for traffic with priority 3:
 .br
 prio-dscp 0:0 3:CS3 3:25 6:CS6
 .br
-# dcb -N rewr show dev eth0 prio-dscp
+# dcb \-N rewr show dev eth0 prio-dscp
 .br
 prio-dscp 0:0 3:24 3:25 6:48
 
@@ -165,7 +164,7 @@ priority 3.
 .P
 # dcb rewr replace dev eth0 prio-dscp 3:26
 .br
-# dcb rewr -N show dev eth0 prio-dscp
+# dcb rewr \-N show dev eth0 prio-dscp
 .br
 prio-dscp 0:0 3:26 6:48
 

--YU6QhZ8BG83odT0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chk_man.err.dcb-rewr.8"

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

Output from "mandoc -T lint dcb-rewr.8": (possibly shortened list)

mandoc: dcb-rewr.8:6:2: WARNING: skipping paragraph macro: sp after SH

-.-.

Change two HYPHEN-MINUSES (code 0x2D) to an em-dash (\(em),
if one is intended.
  " \(em " creates a too big gap in the text (in "troff").

An en-dash is usually surrounded by a space,
while an em-dash is used without spaces.
"man" (1 byte characters in input) transforms an en-dash (\(en) to one
HYPHEN-MINUS,
and an em-dash to two HYPHEN-MINUSES without considering the space
around it.
If "--" are two single "-" (end of options) then use "\-\-".

dcb-rewr.8:76:does what one would typically want in this situation--first adds the new

-.-.

Change -- in x--y to \(em (em-dash), or, if an
option, to \-\-

76:does what one would typically want in this situation--first adds the new

-.-.

Use the correct macro for the font change of a single argument or
split the argument into two.

19:.RI DEV
25:.RI DEV

-.-.

Change a HYPHEN-MINUS (code 0x2D) to a minus(-dash) (\-),
if it
is in front of a name for an option,
is a symbol for standard input,
is a single character used to indicate an option,
or is in the NAME section (man-pages(7)).
N.B. - (0x2D), processed as a UTF-8 file, is changed to a hyphen
(0x2010, groff \[u2010] or \[hy]) in the output.

129:.B -N
158:# dcb -N rewr show dev eth0 prio-dscp
168:# dcb rewr -N show dev eth0 prio-dscp

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

N.B.

  The number of lines affected can be too large to be in a patch.

58:ID, and priority. Selector is an enumeration that picks one of the
59:prioritization namespaces. Currently, only the DSCP and PCP selector namespaces
64:assignment for the same selector and priority. For example, the set of two
74:commands. On the other hand, the command
84:Display all entries with a given selector. When no selector is given, shows all
89:Remove all entries with a given selector. When no selector is given, removes all
102:present in the rewrite table yet. Then remove those entries, whose selector and
104:protocol ID. This has the effect of, for the given selector and priority,
111:\fBadd\fR, \fBdel\fR and \fBreplace\fR commands. For \fBshow\fR and
119:for details. Keys are priorities, values are DSCP points for traffic
120:with matching priority. DSCP points can be written either directly as numeric
127:will similarly format DSCP values as symbolic names if possible. The
136:for details. Keys are priorities. Values are PCP/DEI for traffic with
137:matching priority. PCP/DEI values are written as a combination of numeric- and
138:symbolic values, to accommodate for both. PCP always in numeric form e.g 0 ..

-.-.

No space is needed before a quote (") at the end of a line

12:.RI "[ " OPTIONS " ] "

-.-.

Add missing period (.) for "e.g"

138:symbolic values, to accommodate for both. PCP always in numeric form e.g 0 ..
139:7 and DEI in symbolic form e.g 'de' (drop-eligible), indicating that the DEI

-.-.

Output from "test-groff  -mandoc -t -K utf8 -rF0 -rHY=0 -ww -b -z ":

troff: backtrace: '/home/bg/git/groff/build/s-tmac/an.tmac':709: macro 'RI'
troff: backtrace: file '<stdin>':12
troff:<stdin>:12: warning: trailing space in the line


--YU6QhZ8BG83odT0m--

