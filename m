Return-Path: <netdev+bounces-70589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C6B84FAAC
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 18:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E4928DE42
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919C17BAFC;
	Fri,  9 Feb 2024 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="AFkylvNp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9257A7BAF7
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498447; cv=none; b=GcJT41aMqCZhnvFX3hdj+sjzAX7Rab9s2NEb7p7CKcyiDolf+YUCED9aCS46X4zo0u1LctHKwBXk7Y1ybhkytjdD3aPCRYVRWPaaqdeGChbSpsBbLMlB7mAJ0F9eNVtXWa7aosLl1nHNgB/l1b5QQMtRqkXJAC23vXeMCQr7lgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498447; c=relaxed/simple;
	bh=wxpmtpdcsNG/bJIFYrVStz/zsa6ghE4+Rr5a/1cV1x0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cPhi7IafwTViVRXa/UY9r6HfehY6NnumKI4YZpra+pIhKssKdTG3ldz8XRldx4kaEYyitrJWO0BU8WUDjY0dqjRKZ40Vlam8C7pZrOzRn+0IGcm0zUXGUIpzhZXWWsmTU2mCr/2pZiv/m8mBoDrLtt+TrfWOx0JO4lHte0819mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=AFkylvNp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d751bc0c15so11421305ad.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 09:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707498445; x=1708103245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BORMDkOxWaxqM2f/yLr8yjWxOnA256mgTqcT+xFVzIY=;
        b=AFkylvNp9jv+lrygK7mPUD1s5k+J8NiRLgcsWe815Hbqr9oePXisylzcohvp/TmsSs
         KV8sO9avzDbc/Ft9Oux3wNQ5cuLyUNl1Vrwmu1ZUc+o6967BSlR8trMzFUPtHFytXHiW
         i6KWGwaDCR9RxEK2wAQ03oTUPA/ut+b+Ya+ZahSf+f9UTOEW75B9A6wT6cno7EU1+vVf
         QtJmVp1HW113KEMlv6zPUUjz8To6yBKg0/y9sfxAV8r9sXQ7X7g3JPvLRPGChTMJIYAL
         HerD9dCNw4iZ4YrgksEMnY9j3Xp5ML+9urdadlVh7+oTakYA49AjssZ0GjhY3SgtLgOX
         VIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498445; x=1708103245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BORMDkOxWaxqM2f/yLr8yjWxOnA256mgTqcT+xFVzIY=;
        b=uS9oRRWz/4Q7LwJO7h3E9tqOiSew7lrbmbTmycOqtdPhU57MvxfgigFQzxhfVnPx8S
         AIIlxlwKcElM1eFQeLxiUSFRKu9Kevs23eGeellYyPN5jwYS9T7kQLFyfw8gjf7wxvMZ
         pDn5pZb3jdFmquHpm0Y6AxHa0s4YOoyo+U57G/clsVgCOkUj6qDCcwKrfuwL1wfqJvhS
         MOZ+//ab/E7FrDV7f6xl9LkmtKFcn8UUJFf8wpF+Z4qLzGIi8M3SjdfPUVvKxNDHCaZw
         F3U36o1tLEmC833GBwvbmlncwXq3tDP2mDZVneJtq/dRpr7jplGmdefnELwMxJYfVtvJ
         /N9Q==
X-Gm-Message-State: AOJu0Yw+oGthxT5nSSGK/7RdbY5SRaz4Qk+NMTT66qqORQTMbQAE7Jfk
	6qtSRB5tAkARyHKzgrvIwAcAetS1NQYAhA4DJ+da40+GawLmU4vJ4DFxL+mB5U3yfQssNXl6DuJ
	Th6Q=
X-Google-Smtp-Source: AGHT+IFc5xcCUXyOt0SAaHaQe4b972m5tO6nUU2F0lrcghde9l/rMEv6ddH+bFbpwWKf9axfoCEadw==
X-Received: by 2002:a17:902:d552:b0:1d9:6895:81c3 with SMTP id z18-20020a170902d55200b001d9689581c3mr3161182plf.22.1707498444821;
        Fri, 09 Feb 2024 09:07:24 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id kd5-20020a17090313c500b001d944e8f0fdsm1755728plb.32.2024.02.09.09.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:07:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC iproute2] tc/u32: use standard flexible array
Date: Fri,  9 Feb 2024 09:06:17 -0800
Message-ID: <20240209170714.370259-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code to parse selectors was depending on C extension to implement
the array of keys. This would cause warnings if built with clang.
Instead use ISO C99 flexible array.

Also the maximum number of keys was hardcoded already in two places.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/f_u32.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/tc/f_u32.c b/tc/f_u32.c
index 913ec1de435d..a6e699d53d24 100644
--- a/tc/f_u32.c
+++ b/tc/f_u32.c
@@ -21,6 +21,8 @@
 #include "utils.h"
 #include "tc_util.h"
 
+#define SEL_MAX_KEYS	128
+
 static void explain(void)
 {
 	fprintf(stderr,
@@ -129,7 +131,7 @@ static int pack_key(struct tc_u32_sel *sel, __u32 key, __u32 mask,
 		}
 	}
 
-	if (hwm >= 128)
+	if (hwm >= SEL_MAX_KEYS)
 		return -1;
 	if (off % 4)
 		return -1;
@@ -1017,10 +1019,7 @@ static __u32 u32_hash_fold(struct tc_u32_key *key)
 static int u32_parse_opt(struct filter_util *qu, char *handle,
 			 int argc, char **argv, struct nlmsghdr *n)
 {
-	struct {
-		struct tc_u32_sel sel;
-		struct tc_u32_key keys[128];
-	} sel = {};
+	struct tc_u32_sel *sel;
 	struct tcmsg *t = NLMSG_DATA(n);
 	struct rtattr *tail;
 	int sel_ok = 0, terminal_ok = 0;
@@ -1037,12 +1036,18 @@ static int u32_parse_opt(struct filter_util *qu, char *handle,
 	if (argc == 0)
 		return 0;
 
+	sel = alloca(sizeof(*sel) + SEL_MAX_KEYS * sizeof(struct tc_u32_key));
+	if (sel == NULL)
+		return -1;
+
+	memset(sel, 0, sizeof(*sel) + SEL_MAX_KEYS * sizeof(struct tc_u32_key));
+
 	tail = addattr_nest(n, MAX_MSG, TCA_OPTIONS);
 
 	while (argc > 0) {
 		if (matches(*argv, "match") == 0) {
 			NEXT_ARG();
-			if (parse_selector(&argc, &argv, &sel.sel, n)) {
+			if (parse_selector(&argc, &argv, sel, n)) {
 				fprintf(stderr, "Illegal \"match\"\n");
 				return -1;
 			}
@@ -1050,14 +1055,14 @@ static int u32_parse_opt(struct filter_util *qu, char *handle,
 			continue;
 		} else if (matches(*argv, "offset") == 0) {
 			NEXT_ARG();
-			if (parse_offset(&argc, &argv, &sel.sel)) {
+			if (parse_offset(&argc, &argv, sel)) {
 				fprintf(stderr, "Illegal \"offset\"\n");
 				return -1;
 			}
 			continue;
 		} else if (matches(*argv, "hashkey") == 0) {
 			NEXT_ARG();
-			if (parse_hashkey(&argc, &argv, &sel.sel)) {
+			if (parse_hashkey(&argc, &argv, sel)) {
 				fprintf(stderr, "Illegal \"hashkey\"\n");
 				return -1;
 			}
@@ -1072,7 +1077,7 @@ static int u32_parse_opt(struct filter_util *qu, char *handle,
 				return -1;
 			}
 			addattr_l(n, MAX_MSG, TCA_U32_CLASSID, &flowid, 4);
-			sel.sel.flags |= TC_U32_TERMINAL;
+			sel->flags |= TC_U32_TERMINAL;
 		} else if (matches(*argv, "divisor") == 0) {
 			unsigned int divisor;
 
@@ -1122,17 +1127,21 @@ static int u32_parse_opt(struct filter_util *qu, char *handle,
 		} else if (strcmp(*argv, "sample") == 0) {
 			__u32 hash;
 			unsigned int divisor = 0x100;
-			struct {
-				struct tc_u32_sel sel;
-				struct tc_u32_key keys[4];
-			} sel2 = {};
+			struct tc_u32_sel *sel2;
 
 			NEXT_ARG();
-			if (parse_selector(&argc, &argv, &sel2.sel, n)) {
+
+			sel2 = alloca(sizeof(*sel) + 4 * sizeof(struct tc_u32_key));
+			if (sel2 == NULL)
+				return -1;
+
+			memset(sel2, 0, sizeof(*sel2));
+
+			if (parse_selector(&argc, &argv, sel2, n)) {
 				fprintf(stderr, "Illegal \"sample\"\n");
 				return -1;
 			}
-			if (sel2.sel.nkeys != 1) {
+			if (sel2->nkeys != 1) {
 				fprintf(stderr, "\"sample\" must contain exactly ONE key.\n");
 				return -1;
 			}
@@ -1146,7 +1155,7 @@ static int u32_parse_opt(struct filter_util *qu, char *handle,
 				}
 				NEXT_ARG();
 			}
-			hash = u32_hash_fold(&sel2.keys[0]);
+			hash = u32_hash_fold(&sel2->keys[0]);
 			htid = ((hash % divisor) << 12) | (htid & 0xFFF00000);
 			sample_ok = 1;
 			continue;
@@ -1197,7 +1206,7 @@ static int u32_parse_opt(struct filter_util *qu, char *handle,
 
 	/* We don't necessarily need class/flowids */
 	if (terminal_ok)
-		sel.sel.flags |= TC_U32_TERMINAL;
+		sel->flags |= TC_U32_TERMINAL;
 
 	if (order) {
 		if (TC_U32_NODE(t->tcm_handle) &&
@@ -1212,8 +1221,7 @@ static int u32_parse_opt(struct filter_util *qu, char *handle,
 		addattr_l(n, MAX_MSG, TCA_U32_HASH, &htid, 4);
 	if (sel_ok)
 		addattr_l(n, MAX_MSG, TCA_U32_SEL, &sel,
-			  sizeof(sel.sel) +
-			  sel.sel.nkeys * sizeof(struct tc_u32_key));
+			  sizeof(*sel) + sel->nkeys * sizeof(struct tc_u32_key));
 	if (flags) {
 		if (!(flags ^ (TCA_CLS_FLAGS_SKIP_HW |
 			       TCA_CLS_FLAGS_SKIP_SW))) {
-- 
2.43.0


