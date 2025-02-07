Return-Path: <netdev+bounces-163982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46469A2C39F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02373AC1AC
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3781F4178;
	Fri,  7 Feb 2025 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3SNEpfM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1FB1DFE25;
	Fri,  7 Feb 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935096; cv=none; b=p87BJ9R5kS5xzdRypqZiih+ZV5K/3vluNdQ1yHhfXQfxd851aD6tH7V6LjqTSjtqYDXJaWlxX6uV5gKq6azqBXQ9G/v2gs1vfKFZF/hyAgP1C8OU4PkWpw+0m6upSaDSI6ai+XN+3ANQ2+tnclNi6/V9K6KljpO13xLbJWx2mHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935096; c=relaxed/simple;
	bh=064mulaCi5LDzWlmhgPgjlBPoAcfLaq6k45Tym24phU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOr7TjPqUr+8xvfn5eJ4sTPkUgBipIQ8rCVItZZTNPOLKGt4X5mN+00X8mQtvC3nNpCfLcn1C7xUSCDrgiR2lfFy0qyWk8VNKaBeAqBk6abeLlDyNXmTOOaMND4YKRbv5MztLU77i1/ix4dioSYhtkD/cBUWlf9jJlgZXFV0xqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3SNEpfM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f0c4275a1so31588565ad.2;
        Fri, 07 Feb 2025 05:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738935094; x=1739539894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6Bli2BZjHS4ZZy20IyRSegYD0yjInLQaMwTFLH4pvs=;
        b=c3SNEpfMYVuhLci18kafLTvKwd9Z91mTcRox81FGs/CsFuLPLFqkHOIqUrSKJORbaI
         FmCqtvtI3iU4q/c3N4bxMmJ0nfg47rY9eUx76Gk7gBIPOmD+hsuH2l4zJXX3SYzSjDoP
         AvNtb0F6amR8j8S/P8HPlTINnXyQfgIlmhZEJaXXmgLKmTI+VDUbD/I92V+Vjn41+c0o
         +zUKmkZMuGtoNbf9KlxJ+ZJBijYaTsZqjkK07txABIhYGOnR2w0pyYwQopmRXGR8VSb5
         Pu9xxsaMe983FWPs3rYCoi24NdZXOFq1IUZM61s6wmH0J9NiLrVrIXForw6zWEHL2BBZ
         vfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738935094; x=1739539894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6Bli2BZjHS4ZZy20IyRSegYD0yjInLQaMwTFLH4pvs=;
        b=QOosjI6rfpMt5uGePgNPN2xqw05ONdbAlRUizimqQ7Z7lg7zAjSLlR6GT5DW1oO+a4
         MGK39tIulVzFekmrof8jiXWH7MylE7jj4uI4qnXPdTYoYvjLcqoctdm1qMTE8finEV/u
         DVnIV2l1l4V+J20tquVfl+VgUv94p5ZDLpDLKAkM55yEEpvui9HAz/C+FC9qvg1xkWen
         2H531sT11thjyHespX4KqIHh0GyWN0sVjiva9tEx7eZlfD8ZQRfcSuhTjeFHaUrwdqBQ
         e+LYXKnzintrer6NYhUI2Qw2Q39Si73mh1tWjMjmb3s882kCNvm5Dv/ImOBh/ZCtlhmD
         tcaA==
X-Forwarded-Encrypted: i=1; AJvYcCWPLiA+omB2lMhUgHmyBkSEGoWW7lGaffz86Es7WDHQ+FpEtpwJJlUMOhtF78abuMHBPuQJbRnE9IAsMcpm4f8=@vger.kernel.org, AJvYcCXAXv+gn6vINUFNMLgFQa2TnA4FksOcE3S5VSQaA44rpCqDbL5he5cNPigW9Hw2EEH2yPtuA2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKhzGPM2URAXkDOyFAMs5smEX8C61+o/imvpsu7EJgMZ7u5tsZ
	h4a61K22EHH9mwdf8mPFuLMnpWE17NK72GR4vmIY1E2SPIE8OTyaFsaTTSGf
X-Gm-Gg: ASbGncvjBEv3INZgGiFUAtnEaVPMgSAq5+5YAO6LXfIQPnMYcIeorFh8UGPQjMhSN7I
	SqlKZMuXmnPVfznpvD5tjd1JPadHgl4GVTfnyK3LQ2jxDb6/nitjZh8eCFbr2AtXEoIVOnsrp6e
	QvIKF5UYK2eAm6CeLfqrc6kAu60aKrqsPAuXZyPogSOaMdgnHJtCo3nMLAYejJwnyprITi6es3+
	hghmgD87RObFZzf2t0ThdqxIJBgLjfkwueiaKc3+1zXISYMYXDtuXAisKQ0q76qVX8dySa9bFIP
	UEaJPpJz8BBceFZPkA+XtDSDQcZfJPksIwTQV3Tnp9Lej+KYX6RUP1k6Rs8ZaG8In7k=
X-Google-Smtp-Source: AGHT+IFCuW2ciwOj/rz2+cvmiWr/LcPaS/VEVQxIfl+6LHNYR4w30O828TCtVfp6OU2E1J5y/KknAA==
X-Received: by 2002:a05:6a21:6e46:b0:1e1:b8bf:8e80 with SMTP id adf61e73a8af0-1ee03b70bb6mr7042645637.41.1738935093602;
        Fri, 07 Feb 2025 05:31:33 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51ea79a47sm2877843a12.76.2025.02.07.05.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:31:33 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	arnd@arndb.de,
	jstultz@google.com,
	sboyd@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tgunders@redhat.com,
	me@kloenk.dev
Subject: [PATCH v10 1/8] sched/core: Add __might_sleep_precision()
Date: Fri,  7 Feb 2025 22:26:16 +0900
Message-ID: <20250207132623.168854-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207132623.168854-1-fujita.tomonori@gmail.com>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __might_sleep_precision(), Rust friendly version of
__might_sleep(), which takes a pointer to a string with the length
instead of a null-terminated string.

Rust's core::panic::Location::file(), which gives the file name of a
caller, doesn't provide a null-terminated
string. __might_sleep_precision() uses a precision specifier in the
printk format, which specifies the length of a string; a string
doesn't need to be a null-terminated.

Modify __might_sleep() to call __might_sleep_precision() but the
impact should be negligible. strlen() isn't called in a normal case;
it's called only when printing the error (sleeping function called
from invalid context).

Note that Location::file() providing a null-terminated string for
better C interoperability is under discussion [1].

Link: https://github.com/rust-lang/libs-team/issues/466 [1]
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 include/linux/kernel.h |  2 ++
 kernel/sched/core.c    | 55 ++++++++++++++++++++++++++----------------
 2 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index be2e8c0a187e..086ee1dc447e 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -87,6 +87,7 @@ extern int dynamic_might_resched(void);
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 extern void __might_resched(const char *file, int line, unsigned int offsets);
 extern void __might_sleep(const char *file, int line);
+extern void __might_sleep_precision(const char *file, int len, int line);
 extern void __cant_sleep(const char *file, int line, int preempt_offset);
 extern void __cant_migrate(const char *file, int line);
 
@@ -145,6 +146,7 @@ extern void __cant_migrate(const char *file, int line);
   static inline void __might_resched(const char *file, int line,
 				     unsigned int offsets) { }
 static inline void __might_sleep(const char *file, int line) { }
+static inline void __might_sleep_precision(const char *file, int len, int line) { }
 # define might_sleep() do { might_resched(); } while (0)
 # define cant_sleep() do { } while (0)
 # define cant_migrate()		do { } while (0)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 165c90ba64ea..d308f2a8692e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8678,24 +8678,6 @@ void __init sched_init(void)
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 
-void __might_sleep(const char *file, int line)
-{
-	unsigned int state = get_current_state();
-	/*
-	 * Blocking primitives will set (and therefore destroy) current->state,
-	 * since we will exit with TASK_RUNNING make sure we enter with it,
-	 * otherwise we will destroy state.
-	 */
-	WARN_ONCE(state != TASK_RUNNING && current->task_state_change,
-			"do not call blocking ops when !TASK_RUNNING; "
-			"state=%x set at [<%p>] %pS\n", state,
-			(void *)current->task_state_change,
-			(void *)current->task_state_change);
-
-	__might_resched(file, line, 0);
-}
-EXPORT_SYMBOL(__might_sleep);
-
 static void print_preempt_disable_ip(int preempt_offset, unsigned long ip)
 {
 	if (!IS_ENABLED(CONFIG_DEBUG_PREEMPT))
@@ -8717,7 +8699,8 @@ static inline bool resched_offsets_ok(unsigned int offsets)
 	return nested == offsets;
 }
 
-void __might_resched(const char *file, int line, unsigned int offsets)
+static void __might_resched_precision(const char *file, int len, int line,
+				      unsigned int offsets)
 {
 	/* Ratelimiting timestamp: */
 	static unsigned long prev_jiffy;
@@ -8740,8 +8723,10 @@ void __might_resched(const char *file, int line, unsigned int offsets)
 	/* Save this before calling printk(), since that will clobber it: */
 	preempt_disable_ip = get_preempt_disable_ip(current);
 
-	pr_err("BUG: sleeping function called from invalid context at %s:%d\n",
-	       file, line);
+	if (len < 0)
+		len = strlen(file);
+	pr_err("BUG: sleeping function called from invalid context at %.*s:%d\n",
+	       len, file, line);
 	pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
 	       in_atomic(), irqs_disabled(), current->non_block_count,
 	       current->pid, current->comm);
@@ -8766,8 +8751,36 @@ void __might_resched(const char *file, int line, unsigned int offsets)
 	dump_stack();
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 }
+
+void __might_resched(const char *file, int line, unsigned int offsets)
+{
+	__might_resched_precision(file, -1, line, offsets);
+}
 EXPORT_SYMBOL(__might_resched);
 
+void __might_sleep_precision(const char *file, int len, int line)
+{
+	unsigned int state = get_current_state();
+	/*
+	 * Blocking primitives will set (and therefore destroy) current->state,
+	 * since we will exit with TASK_RUNNING make sure we enter with it,
+	 * otherwise we will destroy state.
+	 */
+	WARN_ONCE(state != TASK_RUNNING && current->task_state_change,
+			"do not call blocking ops when !TASK_RUNNING; "
+			"state=%x set at [<%p>] %pS\n", state,
+			(void *)current->task_state_change,
+			(void *)current->task_state_change);
+
+	__might_resched_precision(file, len, line, 0);
+}
+
+void __might_sleep(const char *file, int line)
+{
+	__might_sleep_precision(file, -1, line);
+}
+EXPORT_SYMBOL(__might_sleep);
+
 void __cant_sleep(const char *file, int line, int preempt_offset)
 {
 	static unsigned long prev_jiffy;
-- 
2.43.0


