Return-Path: <netdev+bounces-283061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wINMFW7/82n99QEAu9opvQ
	(envelope-from <netdev+bounces-283061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:18:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 581E04A98C1
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E3543022BA3
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5552D47FF;
	Fri,  1 May 2026 01:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfPaSNie"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E52D5922
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598189; cv=none; b=rFFl0NAJ8XOxpQ2Hr7HYqiFw2jprb7gIddNgA7hvlgFO7HjGv+wrUFHE5sAQ6kbpuZNFagHWmG7mw0Lus3FJ7M1K9jmH06My2xvBOWQkOSWnDah/lTAvc5YBylvojaXkCO/DeI31D+Xsb4o5bNUjNPLVK8SFsQuYuwFswrbKLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598189; c=relaxed/simple;
	bh=byQFo/IeCTb0iWtfVn6zuHBqUZZNlkZ8P9Vf9AJQ6V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAxY9GJK2+6FJr3U3nIjByQYkQJLLCS/PtS13/ePBJRKG4cyervGmPAuQ+s23Rv5zUF/VCJtu022q5C95r14nrB43lduwlB0lCKv/C95MkoKbmm5IFI52Ghr45qycYaU8wGRY0NVhUSzCncvg1+Gt0aTIEP9b1dY1bS1C2o/C7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfPaSNie; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d75312379so1526278f8f.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 18:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777598186; x=1778202986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeK6LeyKPZtXzud0mkOm3PGowECecLumlpAAyVOseB0=;
        b=QfPaSNieX9rmXanqBOzXjE/WvOuDTmcfOWI5keDArh0jOzYkKiHVKNxtbJjhtnsaQq
         InLtkl2i4bLG7vklQVU/f4r6KtS7/9+cAGq/gaRwuQwMUB2tVAGWZpi4vduEkvaMp4VX
         O7EinFGWivgYQpfW31LnfKbEzyPZCW2/4+JI2IDnaNYXMPXNhAKURdXJsMepPNuZq4QV
         2nTb52SrV3wbD4dFNIhM8iC1o9EHcH2k9UyyC6AAGvy8x/U4A6lcSCukMIGLwa+I6G8Z
         1vz3bIugCXzZJOjcjxb379v4hPcIjeD7NqOJwE0I4bkdcm14BHrfRVrjVQ7NA7+JL2ai
         CwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777598186; x=1778202986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aeK6LeyKPZtXzud0mkOm3PGowECecLumlpAAyVOseB0=;
        b=XSHQKEWxOiE8LD5LCEJOaB3PRFbf+/CcJdNpOzNbsR6N0gFYqiaZnFvJLsuM9eemmR
         f0KWhRbMX0yD1KSjiA9HyULybsLZVMTuVj5awP/Zdo6OVL4TTDnloo+7/J0+gCZxbVqd
         HcFNo48jg4mQBIulFPkXV5EGh+WJtjVzU5f5i2zR+pAy8Fl/10QMxRpIuQnwxQjjdckf
         eFL0doKGI35p/mpkKZrzewqzdop9tSjljDbbTTCGekvZhqviT7JXzx7KFC5zA5gQEACr
         sv73K4AXbD3D9kybRtlSf+8VU5u3YNRY8ibJJoqSTy4ZBW3Gs/6w88xf0cJg4NBT8sUw
         rKnQ==
X-Gm-Message-State: AOJu0YzVFDiRvrSqP6glvq+M3Xa9PaNABa1nXCnUU6npMppOIJ/1UnJZ
	VaEp09d6IOeHZw4lAIGTHNJJs5P0FhiwY4b2jT8n2NK49qmmE1OFB60z/0PkVSX4
X-Gm-Gg: AeBDievsTW0v3twWs7/YnYuix60gkBnkJkWIjkReo5p05a4Adv3wLt6DSQ4TYHKSU7S
	3Jros/BKe5Razw0ldzJp5wh07gPm6mRuonDQapb3yezSQIWeoS0xe121GNp21/o3/ogdRErWLsz
	D2MXNqd+An7XKLjRiOBYnNpf7bIT2uQhg9UgeGujPqln85+ZDH+ijbq3ToQonmh0IoNNqlPDHQm
	z//X8CT7ag1txV7/viwJs9LN1nnZ0hUE865nLQ+gf3hwwIdsCU3qOxMzviIsGlWHPKBCBDD+kFh
	571Rkk5qHsTXS5lrpySvKW7xqlkolk9dsWsqwSAuA8dtXgpLPlvG+DUN9y+2KTScS1o7HURYESH
	BnLMz027zgMp5NuyM40bfhI7Dohz8Qm/W+/UJIOTGbxDR7aGaAb8xrLUfg94mB3TmOpMElX3uaO
	Ln28jyzT+xjLzJpBvEOX9eygD5vbYYJA==
X-Received: by 2002:a05:600c:c098:b0:489:1d7a:4537 with SMTP id 5b1f17b1804b1-48a85e172e2mr52537615e9.3.1777598185716;
        Thu, 30 Apr 2026 18:16:25 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:c::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eba6f83sm16662475e9.9.2026.04.30.18.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 18:16:24 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [PATCH iproute2-next 4/5] netshaper: Make handle id optional for node scope
Date: Thu, 30 Apr 2026 18:16:10 -0700
Message-ID: <20260501011611.3533573-5-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
References: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 581E04A98C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283061-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]

Make handle id optional for node scope so that omitting it tells
the kernel to create a new node and assign an id automatically,
while providing it updates an existing node. Queue scope still
requires an explicit id since it maps to a specific TX queue.
Only send the handle id in the netlink message when the user
explicitly provides one.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 netshaper/netshaper.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 53a5eae3..fc68e735 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -152,6 +152,7 @@ static int do_cmd(int argc, char **argv, int cmd)
 	__u64 bw_max_bps = 0, bw_min_bps = 0;
 	__u32 handle_id = 0, weight = 0;
 	bool handle_present = false;
+	bool has_handle_id = false;
 	struct nlmsghdr *answer;
 	int err, ifindex = -1;
 
@@ -193,18 +194,8 @@ static int do_cmd(int argc, char **argv, int cmd)
 				return -1;
 			}
 
-			if (handle_scope == NET_SHAPER_SCOPE_NETDEV) {
-				/* For netdev scope, id is optional */
-				if (argc > 1 && strcmp(argv[1], "id") == 0) {
-					NEXT_ARG();
-					NEXT_ARG();
-					if (get_unsigned(&handle_id, *argv, 10)) {
-						fprintf(stderr, "Invalid handle id\n");
-						return -1;
-					}
-				}
-			} else {
-				/* For queue/node scope, id is required */
+			if (handle_scope == NET_SHAPER_SCOPE_QUEUE) {
+				/* For queue scope, id is required */
 				NEXT_ARG();
 				if (strcmp(*argv, "id") != 0) {
 					fprintf(stderr, "What is \"%s\"\n", *argv);
@@ -216,6 +207,16 @@ static int do_cmd(int argc, char **argv, int cmd)
 					fprintf(stderr, "Invalid handle id\n");
 					return -1;
 				}
+				has_handle_id = true;
+			} else if (argc > 1 && strcmp(argv[1], "id") == 0) {
+				/* For netdev and node scope, id is optional */
+				NEXT_ARG();
+				NEXT_ARG();
+				if (get_unsigned(&handle_id, *argv, 10)) {
+					fprintf(stderr, "Invalid handle id\n");
+					return -1;
+				}
+				has_handle_id = true;
 			}
 		} else {
 			fprintf(stderr, "What is \"%s\"\n", *argv);
@@ -240,7 +241,8 @@ static int do_cmd(int argc, char **argv, int cmd)
 	struct rtattr *handle = addattr_nest(&req.n, sizeof(req),
 					     NET_SHAPER_A_HANDLE | NLA_F_NESTED);
 	addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_SCOPE, handle_scope);
-	addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_ID, handle_id);
+	if (has_handle_id)
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_ID, handle_id);
 	addattr_nest_end(&req.n, handle);
 
 	if (has_bw_max)
-- 
2.52.0


