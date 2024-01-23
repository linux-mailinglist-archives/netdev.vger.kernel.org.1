Return-Path: <netdev+bounces-65221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740BA839B3E
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DB2286C62
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0FD1EA85;
	Tue, 23 Jan 2024 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="m0y/y78p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D13EA64
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045897; cv=none; b=BmiWYx6meL7lRmh2SIEG90w1D1XbCO+yEjCYFdzS5u6Z+HjoH22/r0oBOoLzC7ww/LKj0Q7lv5ctnj4Mlsst53I8b5vuLMq9zoWdtzbR+I60yrLAxiZxfvTtS6/fIktq7Uaxk0urXmPf5I7d60PQ17AjlmSnD2Bc5r4SVJcP3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045897; c=relaxed/simple;
	bh=lvEWjWT5z2xncHG8lz9JdPW87AcmlZz69sV7YVD5Vh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jRkkbaS8Q1OGt+2pbbC+vWzHBZMxq/C0A0+onMp2EGHw8RLETl2RuQO8TKlMf20yfm7bdNak/NWeyBZKosJogJsq3bUXqsZTLGcIx9s5mna74Q5hpIGGMT0mYqwoBH81uMrMBuyeVGR4L50G7SEsKra+kPu6LMwz3Vx5EZhYO0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=m0y/y78p; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d51ba18e1bso43023605ad.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706045895; x=1706650695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mFycDsXJgr2VoyM2fTYEUpPiKStJcIVoN5sBfA7rSJk=;
        b=m0y/y78pIw93Ka66GQqZv96l/DIbiqBleE3p0wvvRe6xuwcCxDlIJN+LPCQ2eH/JE0
         t5bSNl2lklQOFfFdO7rem9m+rkD4rXJMUQ/q3KHnqR/G0pLxh7rP/9QsJ/FR0Knx0Z4X
         XWg2J54y2JZjdNYaJNzGiAOdpqvsl76sxu8QEvgbnhsLhs0fyN1U5sVcr7J+uqn3Os+U
         3b8mDWdQZJLwcUIBhAGuoYJy+rbC1JGBTndPpOjUxmd6s4uGi93w7UhwWpvZ/cKQVyIq
         llpKlCej9CtuwyQ6PBHsdDiyVydCUIiLjAWavS630116FB8dzhklDXbcHlGWFa6YHaUJ
         9rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706045895; x=1706650695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFycDsXJgr2VoyM2fTYEUpPiKStJcIVoN5sBfA7rSJk=;
        b=PSLVKG8zHaof3JRAsQAWQ8FC13ij/UqG7jZzj1d/g9UV8uG/Wgv3AnXoaA0DVLcZlP
         RycV22Qa4Kk3G6YKQ3vijZjjSaRLqfgs4Q+aXulDbk+WejUr85DmtMOVBeljfK9FInH3
         RJBC6H+EWrng/wZoFyLvKTKJwklBFBeC3ows8keIij3Mh92pk9Y/yxZWsMvlXN5W/HUF
         DsN0IGeWTJWsojp8vvXeO4UmY2fJLzDIGV9KmRLtvo0mQgk4fUEyFDR+09ulN8BmnI3r
         zsztZGwgjWWHaI1Cqq+5PciyHb9Hg5iW2NdZFl0RkWX+ekRXVBEmeKL0Lv6nrx6G9Oaf
         6oxQ==
X-Gm-Message-State: AOJu0YynJp0auQVARwhwFODpPWwkwkUxm61367iaUS9fJrs5sn+1x3gd
	18Wwau31OW7DDk8MNLlRHvTxYDiqMRONKOE+3/nnnTZIUBvdWv8ziUkjEvm1Tna6RbT3S2l5MtM
	5UQ==
X-Google-Smtp-Source: AGHT+IGtavRvLOK7PtwNHYE5NQAy5Sb2WDan4h9zOutlyusHoFM3+Xoyf1PQvJpNnopSgbr3EMU6Rg==
X-Received: by 2002:a17:903:2303:b0:1d7:4816:5875 with SMTP id d3-20020a170903230300b001d748165875mr5579416plh.110.1706045895319;
        Tue, 23 Jan 2024 13:38:15 -0800 (PST)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c1:2229:1771:59f5:c218:f604])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902e31200b001d73416d35csm5617199plc.307.2024.01.23.13.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:38:14 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org
Cc: kernel@mojatatu.com
Subject: [PATCH iproute2-next v2] m_mirred: Allow mirred to block
Date: Tue, 23 Jan 2024 18:38:11 -0300
Message-ID: <20240123213811.81337-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far the mirred action has dealt with syntax that handles
mirror/redirection for netdev. A matching packet is redirected or mirrored
to a target netdev.

In this patch we enable mirred to mirror to a tc block as well.
IOW, the new syntax looks as follows:
... mirred <ingress | egress> <mirror | redirect> [index INDEX] < <blockid BLOCKID> | <dev <devname>> >

Examples of mirroring or redirecting to a tc block:
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action mirred egress mirror blockid 22

$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 10.10.10.10/32 action mirred egress redirect blockid 22

Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
v1 -> v2:

- Add required changes to mirred's man page
- Drop usage of the deprecated matches function in new code

 man/man8/tc-mirred.8 | 24 +++++++++++++++--
 tc/m_mirred.c        | 62 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/man/man8/tc-mirred.8 b/man/man8/tc-mirred.8
index e529fa6a0..ea408467f 100644
--- a/man/man8/tc-mirred.8
+++ b/man/man8/tc-mirred.8
@@ -9,12 +9,23 @@ mirred - mirror/redirect action
 .I DIRECTION ACTION
 .RB "[ " index
 .IR INDEX " ] "
-.BI dev " DEVICENAME"
+.I TARGET
 
 .ti -8
 .IR DIRECTION " := { "
 .BR ingress " | " egress " }"
 
+.ti -8
+.IR TARGET " := { " DEV " | " BLOCK " }"
+
+.ti -8
+.IR DEV " :=  "
+.BI dev " DEVICENAME"
+
+.ti -8
+.IR BLOCK " :=  "
+.BI blockid " BLOCKID"
+
 .ti -8
 .IR ACTION " := { "
 .BR mirror " | " redirect " }"
@@ -24,6 +35,12 @@ The
 action allows packet mirroring (copying) or redirecting (stealing) the packet it
 receives. Mirroring is what is sometimes referred to as Switch Port Analyzer
 (SPAN) and is commonly used to analyze and/or debug flows.
+When mirroring to a tc block, the packet will be mirrored to all the ports in
+the block with exception of the port where the packet ingressed, if that port is
+part of the tc block. Redirecting is simillar to mirroring except that the
+behaviour is to mirror to the first N - 1 ports in the block and redirect to the
+last one (note that the port in which the packet arrived is not going to be
+mirrored or redirected to).
 .SH OPTIONS
 .TP
 .B ingress
@@ -39,7 +56,7 @@ Define whether the packet should be copied
 .RB ( mirror )
 or moved
 .RB ( redirect )
-to the destination interface.
+to the destination interface or block.
 .TP
 .BI index " INDEX"
 Assign a unique ID to this action instead of letting the kernel choose one
@@ -49,6 +66,9 @@ is a 32bit unsigned integer greater than zero.
 .TP
 .BI dev " DEVICENAME"
 Specify the network interface to redirect or mirror to.
+.TP
+.BI blockid " BLOCKID"
+Specify the tc block to redirect or mirror to.
 .SH EXAMPLES
 Limit ingress bandwidth on eth0 to 1mbit/s, redirect exceeding traffic to lo for
 debugging purposes:
diff --git a/tc/m_mirred.c b/tc/m_mirred.c
index e5653e67f..7591ab55b 100644
--- a/tc/m_mirred.c
+++ b/tc/m_mirred.c
@@ -24,12 +24,16 @@ static void
 explain(void)
 {
 	fprintf(stderr,
-		"Usage: mirred <DIRECTION> <ACTION> [index INDEX] <dev DEVICENAME>\n"
+		"Usage: mirred <DIRECTION> <ACTION> [index INDEX] <TARGET>\n"
 		"where:\n"
 		"\tDIRECTION := <ingress | egress>\n"
 		"\tACTION := <mirror | redirect>\n"
 		"\tINDEX  is the specific policy instance id\n"
-		"\tDEVICENAME is the devicename\n");
+		"\tTARGET := <BLOCK | DEVICE>\n"
+		"\tDEVICE := dev DEVICENAME\n"
+		"\tDEVICENAME is the devicename\n"
+		"\tBLOCK := blockid BLOCKID\n"
+		"\tBLOCKID := 32-bit unsigned block ID\n");
 }
 
 static void
@@ -94,6 +98,7 @@ parse_direction(struct action_util *a, int *argc_p, char ***argv_p,
 	struct tc_mirred p = {};
 	struct rtattr *tail;
 	char d[IFNAMSIZ] = {};
+	__u32 blockid = 0;
 
 	while (argc > 0) {
 
@@ -162,15 +167,38 @@ parse_direction(struct action_util *a, int *argc_p, char ***argv_p,
 					TCA_INGRESS_REDIR;
 				p.action = TC_ACT_STOLEN;
 				ok++;
-			} else if ((redir || mirror) &&
-				   matches(*argv, "dev") == 0) {
-				NEXT_ARG();
-				if (strlen(d))
-					duparg("dev", *argv);
-
-				strncpy(d, *argv, sizeof(d)-1);
-				argc--;
-				argv++;
+			} else if ((redir || mirror)) {
+				if (strcmp(*argv, "blockid") == 0) {
+					if (strlen(d)) {
+						fprintf(stderr,
+							"Mustn't specify blockid and dev simultaneously\n");
+						return -1;
+					}
+					NEXT_ARG();
+					if (get_u32(&blockid, *argv, 0) ||
+					    !blockid) {
+						fprintf(stderr,
+							"invalid block ID index value %s",
+							*argv);
+						return -1;
+					}
+					argc--;
+					argv++;
+				}
+				if (argc && matches(*argv, "dev") == 0) {
+					if (blockid) {
+						fprintf(stderr,
+							"Mustn't specify blockid and dev simultaneously\n");
+						return -1;
+					}
+					NEXT_ARG();
+					if (strlen(d))
+						duparg("dev", *argv);
+
+					strncpy(d, *argv, sizeof(d)-1);
+					argc--;
+					argv++;
+				}
 
 				break;
 
@@ -220,6 +248,8 @@ parse_direction(struct action_util *a, int *argc_p, char ***argv_p,
 
 	tail = addattr_nest(n, MAX_MSG, tca_id);
 	addattr_l(n, MAX_MSG, TCA_MIRRED_PARMS, &p, sizeof(p));
+	if (blockid)
+		addattr32(n, MAX_MSG, TCA_MIRRED_BLOCKID, blockid);
 	addattr_nest_end(n, tail);
 
 	*argc_p = argc;
@@ -299,7 +329,15 @@ print_mirred(struct action_util *au, FILE *f, struct rtattr *arg)
 		     mirred_action(p->eaction));
 	print_string(PRINT_JSON, "direction", NULL,
 		     mirred_direction(p->eaction));
-	print_string(PRINT_ANY, "to_dev", " to device %s)", dev);
+	if (tb[TCA_MIRRED_BLOCKID]) {
+		const __u32 *blockid = RTA_DATA(tb[TCA_MIRRED_BLOCKID]);
+
+		print_uint(PRINT_ANY, "to_blockid", " to blockid %u)",
+			   *blockid);
+	} else {
+		print_string(PRINT_ANY, "to_dev", " to device %s)", dev);
+	}
+
 	print_action_control(f, " ", p->action, "");
 
 	print_nl();
-- 
2.25.1


