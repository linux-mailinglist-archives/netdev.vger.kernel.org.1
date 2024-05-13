Return-Path: <netdev+bounces-96139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E00278C4731
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 20:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFC128211A
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A9C3BB24;
	Mon, 13 May 2024 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh4k1GU+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6163A1BB
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626351; cv=none; b=eJa05VZYY4AJcyvWHLzyvNrmkuS3c3LPCeF33FXYjtFR77B1OUglVcBD0YUd17Q19vRl6kcFOplTx/IbaHeeMfMeac+mHMBrgSoAzpo4pWO4ShvSo7qSevIVyXR8etWw3RAqQRiQYsVjRKkt73R/c2jxF/dug3dyugd09Ei1UWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626351; c=relaxed/simple;
	bh=RHFxF++MdlcifyUKUTPD5PlJXCL9xvyKsliGs+ma++s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oibDgCSfipd/plBmygdR1whef+HQULMTs/HnqYjWnLfE1ImnyibnGwT/XxzC9ys4sXTMeHuBVD6o/hOIoCUrz5dx3eftWiTlQKzBNjKBFLfQkV+Ez/WfJzVWKomh9U8e37K8CXAZu1RyhzFMGdlMqSEP6W1iFFB2XE/S/hcnYbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh4k1GU+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-420104e5390so21653625e9.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715626347; x=1716231147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QlvjfWk3Cg8lMMByaTZxOZWwgPplDnEQz1EYH4IRBaM=;
        b=eh4k1GU+Pr/PjEkXfaeENb53ejvamF3CtF7W/gYkRu0jRmFIJtIFHe+HxZCNE0TXog
         qvl3S9xV8uG27ZSv7UdUmKvz0vjk6ct8GhT7H+B9mRZWRNun9dM4IWkhSHZf8Vy3sKSJ
         ouZYKu3fGMmn1nSP/8HBN7P/sPaXD5RspRAwZPB427p5FMPI6UnO14xUt+u8glsLMmbP
         dOMi6Pz5Syi1RRkGickst938JMbCr4DB+eRMBq33Hrw57x2IB/JoaKrv61v7Lyut3oSw
         I75WRlISuWXXgffVw4DU7pRC1YQCTz8EArqEevjgSO7zDBfP429xvySBhBW7hdjODQ4p
         MfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715626347; x=1716231147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlvjfWk3Cg8lMMByaTZxOZWwgPplDnEQz1EYH4IRBaM=;
        b=uLXEknxItl53JJvbUrHx3cfezv1JxSBEAW6roAKHlDWgDMwVDdm/LJP82/ZUOEGKP7
         6CWGZSbX/JbFZw6ZU3d8H9SmfInSEqFbxR0BOYB7dSmsgLww4J5zVQi7u+TpfVd3P1bd
         lBJxf1Z9h/YJK6ktD/M72L/xpidxWYkb8dTdmZ8t5/8yCs2DqAk4MGed+7UATYkjpyoG
         wQM4jcl+2rM6Epo4X8oh0wkMlomfsNjfXDvT1KS7vVDucdNfCg3NGfYAtUN7OsogdeRa
         H3Z+M752e8wNE/WkNnbWjIXXRZjGHO32R/wTAdE1OuJl1qgWtZ0Qw05+tNM1ff+XaGOT
         CkmA==
X-Gm-Message-State: AOJu0YwkDYxjPxgyoP6N0yWVRmaV4u/5Kirb2dECnWyqOz8DjUz3zhxa
	hcEkCcpIT1QNv5Ytk+CUhr2s1RY9clyAyjL4m9l9t7eEDTZGfJC8zkFTlsj+
X-Google-Smtp-Source: AGHT+IHjHfgQAcUDXPphj32sijqAAQ1DtlnIEXSvHbvjSvuiSxCPG3JerM7ZNtUMN6uhpopoR6eL6g==
X-Received: by 2002:a05:600c:3d87:b0:420:182e:eb46 with SMTP id 5b1f17b1804b1-420182ef112mr30441315e9.38.1715626346362;
        Mon, 13 May 2024 11:52:26 -0700 (PDT)
Received: from lenovo-lap.localdomain (89-139-137-21.bb.netvision.net.il. [89.139.137.21])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3502bbbc082sm11772308f8f.107.2024.05.13.11.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:52:25 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH] rtmon: Align usage with ip help
Date: Mon, 13 May 2024 21:52:17 +0300
Message-Id: <20240513185217.13925-1-yedaya.ka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also update the man page accordingly, and add ip-monitor to see also

Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 ip/rtmon.c       |  4 ++--
 man/man8/rtmon.8 | 31 +++++++++++++++++++++++++------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/ip/rtmon.c b/ip/rtmon.c
index 08105d686c08..470f4ba641dc 100644
--- a/ip/rtmon.c
+++ b/ip/rtmon.c
@@ -58,10 +58,10 @@ static int dump_msg2(struct nlmsghdr *n, void *arg)
 static void usage(void)
 {
 	fprintf(stderr,
-		"Usage: rtmon [ OPTIONS ] file FILE [ all | LISTofOBJECTS ]\n"
+		"Usage: rtmon [ OPTIONS ] file FILE [ all | OBJECTS ]\n"
 		"OPTIONS := { -f[amily] { inet | inet6 | link | help } |\n"
 		"             -4 | -6 | -0 | -V[ersion] }\n"
-		"LISTofOBJECTS := [ link ] [ address ] [ route ]\n");
+		"OBJECTS := [ link ] [ address ] [ route ]\n");
 	exit(-1);
 }
 
diff --git a/man/man8/rtmon.8 b/man/man8/rtmon.8
index 38a2b77470e6..f3b9f774413f 100644
--- a/man/man8/rtmon.8
+++ b/man/man8/rtmon.8
@@ -1,9 +1,27 @@
 .TH RTMON 8
-.SH NAME
+.SH "NAME"
 rtmon \- listens to and monitors RTnetlink
-.SH SYNOPSIS
-.B rtmon
-.RI "[ options ] file FILE [ all | LISTofOBJECTS ]"
+.SH "SYNOPSIS"
+.sp
+.ad l
+.in +8
+.ti -8
+.B "rtmon"
+.RI "[ " OPTIONS " ] "
+.BI "file " FILE
+.BR "[ " all
+.RI "| " OBJECTS
+.RB "]"
+
+.ti -8
+.IR OPTIONS
+.RI ":= { f[amily] { inet | inet6 | link | help } |"
+.RI "-4 | -6 | -0 | -V[ersion] }"
+
+.ti -8
+.I OBJECTS
+.B ":= [" link "]" "[" address "]" "[" route "]"
+
 .SH DESCRIPTION
 This manual page documents briefly the
 .B rtmon
@@ -32,8 +50,8 @@ Print version and exit.
 .B help
 Show summary of options.
 .TP
-.B file FILE [ all | LISTofOBJECTS ]
-Log output to FILE. LISTofOBJECTS is the list of object types that we
+.B file FILE [ all | OBJECTS ]
+Log output to FILE. OBJECTS is the list of object types that we
 want to monitor. It may contain 'link', 'address', 'route'
 and 'all'. 'link' specifies the network device, 'address' the protocol
 (IP or IPv6) address on a device, 'route' the routing table entry
@@ -60,6 +78,7 @@ Log to file /var/log/rtmon.log, then run:
 to display logged output from file.
 .SH SEE ALSO
 .BR ip (8)
+.BR ip-monitor (8)
 .SH AUTHOR
 .B rtmon
 was written by Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>.
-- 
2.34.1


