Return-Path: <netdev+bounces-65116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B006839461
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802531C21D22
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A616166F;
	Tue, 23 Jan 2024 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0lwUuJH8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE44F6166E
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026286; cv=none; b=uFUAvOXru6V/9XufWIV6rIwf1JOS20eGyA22KwR/JWOj1vQ7yGQYUx/jHORFvgsZyBCXz/gH1sZx3O6Xaf+oyW2S0pMJbMvabQzARBATVWERS8JYCvD9xAjAF9/SkYenxvOC1tQQrKEUbVblkH+Y5yU+/h8NR/BbtrK8Ez7jbks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026286; c=relaxed/simple;
	bh=hZyI/cWfBckEc4+7lbD6clJO+tt6oY5HkOyVi1sCO7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NxATKoWgbasisn2xXNptW1OKTTOAJbxaQDl/7rOEv8AcTp6zjzJw6c8kDvKs8FhcLQaiuufybqGLz3VG+B0cmLLxbiK6QerUHeBMcWRoffpgyXdekhnBGzNjMMsQ6PhJpR7IG69NgMwBNBRfbtfUJWtc5dU9kp2CY0UZxwIauZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=0lwUuJH8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dbd146c76cso1833217b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706026283; x=1706631083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGqD/IheuVjieznZzqApe3mbT2MLtI/DQdG08i03tzg=;
        b=0lwUuJH8iMdpy0p3sHdu8Z5re7/eNdfXdqh/x8aV6Vs3d35Qgu9RYH6hnk++UGbTVI
         zzMobDotGvZdanvkSF4DITXh1HZx8k54LLjmMb8Jfm3ZF6l1OK1autRrA0n1pmYweV8n
         zhnBp7jZ55venGy33YoMFaR/Ws73/x/Q/IwGOZhkeoz3ac53dQG/N1bcgS2canhQpi6O
         nQLDi7TkEl79mw5FI2hMCab3E4xyeu2m/+hVwaQyaeobY1mVIDs3bzasc4abSi1EJsRj
         XcZQVDp1y1ReSiSTDvOcvHyalURQZ0SCmMzDMjP/qfAIxERK1OIZtuDr2k9KcIR385s8
         xsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706026283; x=1706631083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGqD/IheuVjieznZzqApe3mbT2MLtI/DQdG08i03tzg=;
        b=TJvXcgOYwAPqDcTw7hW5615oUdHDUSuQU0kMfHcE0bd/eoJxV4GpIDulApuWkm2RjK
         fEmo6J3Jp06ll8155px83Putm84D1lZ++YFr3XP0q+lv61y47ILzES73iRUa6e+uqXDI
         KZLqBGK5RSnrKd/GA64xVJOg5ST0RltSsWAdSCFIzC+DEtN7L/r+Ia0L3Cdu8PwKlofF
         pwLY27APIzWDTweE6vKKZEQj5sUD0Z+XphRU87seZKNu4dgRbmkJrSFoNuKUCE575hr2
         6QBBZmxNbQW9YKY0i/LPSDxdY3uhBZpYoixYHjXbcV2x+JsFJ+2Ju7nSiDeZXXX/MWpD
         N3JA==
X-Gm-Message-State: AOJu0Yw6hPWCQwveD7cCgK5ky5rEI2K2IJaPanyuOvTPa2b/eNANoUf+
	lB4eQzqhsolneWwCHsE8GBtXvorp7lHUI7/dB5kssLjbZLV0o4+jpL6u0dZOxmn5eMbOpDVL17o
	tUg==
X-Google-Smtp-Source: AGHT+IFSfsSjiENoIHCYs8V5+0GG1aIcQMb0VmyfgorMOsHI4Lft6MFvbBGYUCSg3u0BmHUAe2Tq8g==
X-Received: by 2002:a05:6a20:e127:b0:19a:3f14:5a2e with SMTP id kr39-20020a056a20e12700b0019a3f145a2emr3863609pzb.85.1706026281733;
        Tue, 23 Jan 2024 08:11:21 -0800 (PST)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c1:2229:1771:59f5:c218:f604])
        by smtp.gmail.com with ESMTPSA id y3-20020a62ce03000000b006dd844e7c2bsm595071pfg.171.2024.01.23.08.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:11:21 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org
Cc: kernel@mojatatu.com
Subject: [PATCH iproute2-next] m_mirred: Allow mirred to block
Date: Tue, 23 Jan 2024 13:11:15 -0300
Message-ID: <20240123161115.69729-1-victor@mojatatu.com>
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
 tc/m_mirred.c | 60 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 11 deletions(-)

diff --git a/tc/m_mirred.c b/tc/m_mirred.c
index e5653e67f..db847b1a3 100644
--- a/tc/m_mirred.c
+++ b/tc/m_mirred.c
@@ -29,7 +29,11 @@ explain(void)
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
+				if (matches(*argv, "blockid") == 0) {
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


