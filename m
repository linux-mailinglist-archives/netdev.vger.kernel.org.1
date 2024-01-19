Return-Path: <netdev+bounces-64395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC7F832D5D
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 17:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FD22814CD
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF9D54FB3;
	Fri, 19 Jan 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="D+ovgMPo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9354FB0
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682480; cv=none; b=JgVAmb96YKv9PkNwRCeGTJ+VB6hrQVlxJ1hw0wkfK7r/Sc6wmb1Xf1sR6m0YxMuymGRqxt3pRUTo4GNFYK1l/0CALzDZ89QMzv10AZvkrK/mxDHoDVA3gV7jlVh5mLSFtsAptyhLwGhpllWr9wm3IqUzC5IcX8J2X1YOjqgTrbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682480; c=relaxed/simple;
	bh=O4EUkYG3Tjyt9UuqE/Lhs0PcSH/935IumzsXCkZK5h8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nebZK68D+3B73t7DMvoe/uRImcXjMM5mfpCiv+dTdwCcNJD2EDyLmAnvXAk/mPygJrff+oximmBhxdUeGsHTLZMNlXN3J3YPmxBWqmYrimmTzdCbxqPScXWMcZrxsCZfI27HUgvVdCf9k7yZnejD+saaejZbqr/42CyK+6NuC6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=D+ovgMPo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6db9e52bbccso731888b3a.3
        for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 08:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1705682477; x=1706287277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=85OKr8JEvXgChSExUYpaNKQcz1Gda9WsGBwuIRW+CG8=;
        b=D+ovgMPoFfiXG3v4fqt6dNqzmhzx2sbB+Fyg3kOb8VfMcmqAeOm94KHo+3Ww/KX00g
         wFyK7drQSHaj2TR+JD9tFZVQKIUe8UuYCOLcC6eBl0N8ZAS8eSJiEtWscvZX0YVVOD/v
         QEW92MHd7DT7smAk1MGwlWVwgpKv3bwKn6BHRv4xM0ArJCRp878oIfRDeqYXWOtk7vMQ
         1QuxCvvbRxnCsL0zx+t+0+p44+8x2sSbhYpLGTgUSy6HnnLmagg2d9uQLel6ebU7n6Ib
         aE7CBhx2OAw6ZcDybjbZBOkK1mPi3FRZjvRHJm+8PT1e89OquhF/QHpyrgesCRCNh2oT
         Dv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705682477; x=1706287277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85OKr8JEvXgChSExUYpaNKQcz1Gda9WsGBwuIRW+CG8=;
        b=Hgb474m6kOd/OGxpstAWEy4q11NQaACL5ixqR9LlBpijjHO78y5brOqpOkPd6sF8pe
         C6ABMHSeqomqCIUtz18f6UjWu9XVKn1yy28j+FmfU8W8XOSwiJyulVXPpauUCMsLW/X5
         +qBnfqmelOH0Huz8AzakqTl+WHVhOyI0EbtbRPXGv6avyrDlOlTx1OeEHzONuRr8K/+m
         hjm+xt+72s/D/x1mzprtDt4UXhqcWEGNs+UkYU56lWlLdidEs6cJMjZYTbTykx6hksau
         Bpzw0h3oN121sBEb2g7n7rrgoZHRIfmK2NMXo0mJ8eJPCh/qGe+iYzV0PLYpjMIKL6Qd
         OLMg==
X-Gm-Message-State: AOJu0Yy26nBxyQBOPMbM4FLOdFIHC3mLNZVfVRH/G347Y76N5IGU2Pkk
	9Y+jp2cPNc93e1yqVvbDJkMSr0ZTvgQSzlpl2xU1q5jtvSEt2CT/Zq7h/Q4435kXtRX/SZQO1Ll
	uGpI=
X-Google-Smtp-Source: AGHT+IFygixTXZ0Iys92BWyhcGW4yIowLMllmuL3GZo1FlCxhfwHpRmLnvQBX0A6HF5wawVtTgQ9Wg==
X-Received: by 2002:a05:6a00:1c8c:b0:6d9:8453:1b55 with SMTP id y12-20020a056a001c8c00b006d984531b55mr141249pfw.0.1705682477448;
        Fri, 19 Jan 2024 08:41:17 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78c56000000b006d8610fcb63sm5305148pfd.87.2024.01.19.08.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 08:41:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] tc: unify clockid handling
Date: Fri, 19 Jan 2024 08:40:20 -0800
Message-ID: <20240119164019.63584-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are three places in tc which all have same code for
handling clockid (copy/paste). Move it into tc_util.c.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
Motivated by (rejected) pull request to deal with missing
clockid's on really old versions of glibc.

 tc/m_gate.c   | 41 -----------------------------------------
 tc/q_etf.c    | 43 -------------------------------------------
 tc/q_taprio.c | 43 -------------------------------------------
 tc/tc_util.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 tc/tc_util.h  |  4 ++++
 5 files changed, 44 insertions(+), 127 deletions(-)

diff --git a/tc/m_gate.c b/tc/m_gate.c
index c091ae19c1cc..37afa426a2c8 100644
--- a/tc/m_gate.c
+++ b/tc/m_gate.c
@@ -20,18 +20,6 @@ struct gate_entry {
 	int32_t maxoctets;
 };
 
-#define CLOCKID_INVALID (-1)
-static const struct clockid_table {
-	const char *name;
-	clockid_t clockid;
-} clockt_map[] = {
-	{ "REALTIME", CLOCK_REALTIME },
-	{ "TAI", CLOCK_TAI },
-	{ "BOOTTIME", CLOCK_BOOTTIME },
-	{ "MONOTONIC", CLOCK_MONOTONIC },
-	{ NULL }
-};
-
 static void explain(void)
 {
 	fprintf(stderr,
@@ -78,35 +66,6 @@ struct action_util gate_action_util = {
 	.print_aopt = print_gate,
 };
 
-static int get_clockid(__s32 *val, const char *arg)
-{
-	const struct clockid_table *c;
-
-	if (strcasestr(arg, "CLOCK_") != NULL)
-		arg += sizeof("CLOCK_") - 1;
-
-	for (c = clockt_map; c->name; c++) {
-		if (strcasecmp(c->name, arg) == 0) {
-			*val = c->clockid;
-			return 0;
-		}
-	}
-
-	return -1;
-}
-
-static const char *get_clock_name(clockid_t clockid)
-{
-	const struct clockid_table *c;
-
-	for (c = clockt_map; c->name; c++) {
-		if (clockid == c->clockid)
-			return c->name;
-	}
-
-	return "invalid";
-}
-
 static int get_gate_state(__u8 *val, const char *arg)
 {
 	if (!strcasecmp("OPEN", arg)) {
diff --git a/tc/q_etf.c b/tc/q_etf.c
index 572e2bc89fc1..d16188daabbd 100644
--- a/tc/q_etf.c
+++ b/tc/q_etf.c
@@ -19,18 +19,6 @@
 #include "utils.h"
 #include "tc_util.h"
 
-#define CLOCKID_INVALID (-1)
-static const struct static_clockid {
-	const char *name;
-	clockid_t clockid;
-} clockids_sysv[] = {
-	{ "REALTIME", CLOCK_REALTIME },
-	{ "TAI", CLOCK_TAI },
-	{ "BOOTTIME", CLOCK_BOOTTIME },
-	{ "MONOTONIC", CLOCK_MONOTONIC },
-	{ NULL }
-};
-
 static void explain(void)
 {
 	fprintf(stderr,
@@ -51,37 +39,6 @@ static void explain_clockid(const char *val)
 		val);
 }
 
-static int get_clockid(__s32 *val, const char *arg)
-{
-	const struct static_clockid *c;
-
-	/* Drop the CLOCK_ prefix if that is being used. */
-	if (strcasestr(arg, "CLOCK_") != NULL)
-		arg += sizeof("CLOCK_") - 1;
-
-	for (c = clockids_sysv; c->name; c++) {
-		if (strcasecmp(c->name, arg) == 0) {
-			*val = c->clockid;
-
-			return 0;
-		}
-	}
-
-	return -1;
-}
-
-static const char* get_clock_name(clockid_t clockid)
-{
-	const struct static_clockid *c;
-
-	for (c = clockids_sysv; c->name; c++) {
-		if (clockid == c->clockid)
-			return c->name;
-	}
-
-	return "invalid";
-}
-
 static int etf_parse_opt(struct qdisc_util *qu, int argc,
 			 char **argv, struct nlmsghdr *n, const char *dev)
 {
diff --git a/tc/q_taprio.c b/tc/q_taprio.c
index ef8fc7a05fc2..c47fe244369f 100644
--- a/tc/q_taprio.c
+++ b/tc/q_taprio.c
@@ -29,18 +29,6 @@ struct sched_entry {
 	uint8_t cmd;
 };
 
-#define CLOCKID_INVALID (-1)
-static const struct static_clockid {
-	const char *name;
-	clockid_t clockid;
-} clockids_sysv[] = {
-	{ "REALTIME", CLOCK_REALTIME },
-	{ "TAI", CLOCK_TAI },
-	{ "BOOTTIME", CLOCK_BOOTTIME },
-	{ "MONOTONIC", CLOCK_MONOTONIC },
-	{ NULL }
-};
-
 static void explain(void)
 {
 	fprintf(stderr,
@@ -60,37 +48,6 @@ static void explain_clockid(const char *val)
 	fprintf(stderr, "It must be a valid SYS-V id (i.e. CLOCK_TAI)\n");
 }
 
-static int get_clockid(__s32 *val, const char *arg)
-{
-	const struct static_clockid *c;
-
-	/* Drop the CLOCK_ prefix if that is being used. */
-	if (strcasestr(arg, "CLOCK_") != NULL)
-		arg += sizeof("CLOCK_") - 1;
-
-	for (c = clockids_sysv; c->name; c++) {
-		if (strcasecmp(c->name, arg) == 0) {
-			*val = c->clockid;
-
-			return 0;
-		}
-	}
-
-	return -1;
-}
-
-static const char* get_clock_name(clockid_t clockid)
-{
-	const struct static_clockid *c;
-
-	for (c = clockids_sysv; c->name; c++) {
-		if (clockid == c->clockid)
-			return c->name;
-	}
-
-	return "invalid";
-}
-
 static const char *entry_cmd_to_str(__u8 cmd)
 {
 	switch (cmd) {
diff --git a/tc/tc_util.c b/tc/tc_util.c
index 8c0e19e452d5..a799a6299c04 100644
--- a/tc/tc_util.c
+++ b/tc/tc_util.c
@@ -596,6 +596,46 @@ char *sprint_linklayer(unsigned int linklayer, char *buf)
 	return buf;
 }
 
+static const struct clockid_table {
+	const char *name;
+	clockid_t clockid;
+} clockt_map[] = {
+	{ "REALTIME", CLOCK_REALTIME },
+	{ "TAI", CLOCK_TAI },
+	{ "BOOTTIME", CLOCK_BOOTTIME },
+	{ "MONOTONIC", CLOCK_MONOTONIC },
+	{ NULL }
+};
+
+int get_clockid(__s32 *val, const char *arg)
+{
+	const struct clockid_table *c;
+
+	if (strcasestr(arg, "CLOCK_") != NULL)
+		arg += sizeof("CLOCK_") - 1;
+
+	for (c = clockt_map; c->name; c++) {
+		if (strcasecmp(c->name, arg) == 0) {
+			*val = c->clockid;
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+const char *get_clock_name(clockid_t clockid)
+{
+	const struct clockid_table *c;
+
+	for (c = clockt_map; c->name; c++) {
+		if (clockid == c->clockid)
+			return c->name;
+	}
+
+	return "invalid";
+}
+
 void print_tm(FILE *f, const struct tcf_t *tm)
 {
 	int hz = get_user_hz();
diff --git a/tc/tc_util.h b/tc/tc_util.h
index c535dccbc200..aaf10e433fd1 100644
--- a/tc/tc_util.h
+++ b/tc/tc_util.h
@@ -121,6 +121,10 @@ int prio_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt);
 int cls_names_init(char *path);
 void cls_names_uninit(void);
 
+#define CLOCKID_INVALID (-1)
+int get_clockid(__s32 *val, const char *arg);
+const char *get_clock_name(clockid_t clockid);
+
 int action_a2n(char *arg, int *result, bool allow_num);
 
 bool tc_qdisc_block_exists(__u32 block_index);
-- 
2.43.0


