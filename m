Return-Path: <netdev+bounces-167997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECA1A3D1CD
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91206189D298
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD14B1E4937;
	Thu, 20 Feb 2025 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLKtfbhl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3801E3DEF;
	Thu, 20 Feb 2025 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035422; cv=none; b=jbmckFMGxoLNshsLmF38fl4L14PCl6YM58LyJAhoCN/9Zj3eUJv95e118vQUwsaoL//TJRX0tSwByexyQCUR7VOg3q5VX5/0lhsRGrmT857PHpAkhuQSen8JEDx+ilW9RriPRGlDuIUd+2a/gkCUQvfNX7ePrPZftRyevleZR9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035422; c=relaxed/simple;
	bh=Rkh6ndSceSynog0AU/kr8BvXWRW8K2KzzGx5hds8B9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q184d3gbyAYzzMeO6hwxEN7COn0COm+lAajkM8jYywiuweDSmX84zwdcVmzLpZdy38s8QmvJxOhINQHtuLQNPZJNNI43phaKuDYFQnMjhi7i0Eo9HLisZd+I5ihWrVZXTnruGvH4sGjGI81sSFvtC1NjnEVkASbPHhkf+PW9C88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLKtfbhl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220d39a5627so8451495ad.1;
        Wed, 19 Feb 2025 23:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740035420; x=1740640220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3mkDtg1XWCj0JInAia08UGBi51YLWhiTTVLJLbItqg=;
        b=XLKtfbhlhH9ynLbRkjkOVmEk9mvec5TB0CNu2LolTClx5q6CPydFIvaRY/3rlRcR9T
         2W6RADnyvHn/KHVA/bwCwHc/kz2t/10tZyvG6w1Tid+OixXZZ4OYyRzkXpzdzOfxCncT
         kV5GYnA2bU+Rfahloy2bRKoEdelCjOvJeqeBL8ln3gfdx+Y+TggoZgvwSjskT88zy0O6
         GvA/6cYYH7v3D0cvcYyW3rRAqQFFuUQCN8GXfEVrnkH+AiTe2jg1V+2LKRoXQ3HyaFbw
         +/fGsAyxS2t8f1OBMRtmHpRhz807gHLf4M18btxPEX2elNCt6x9is+oCX9mB5iXi9eGQ
         lT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740035420; x=1740640220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3mkDtg1XWCj0JInAia08UGBi51YLWhiTTVLJLbItqg=;
        b=WkmaWTkwhRLEamwvNsna/skmoiGdt1lT6vJxScg/UdUMPipaaFxUCA3kyVzJp4SGJF
         l/J5VtAdG0BaKd6VC//FbHueHPYi3xYdyFfPTW7V75euHV4S99Wygs7EbrZy9IMf3cTH
         QL+fKkkUCj0O9VU/CxCPUzRtiyFi/tzn8sI5sQZInu0Lc1qTA2MUEdy/24CssCnI2Tl/
         KzpqlgbiclQAM/SQOAy4ZBb/rJLluur28ysaRgp/8q1YJU9HBxpMyA8l9DoZ9MDbPqke
         dYKolSCelDWuYVO8wxDDHPpz24otl7dyPFgNP2PT5HLJZZ/vlU1buaG78fsJc+NnGMDG
         BmSg==
X-Forwarded-Encrypted: i=1; AJvYcCV0ssroOj3qI53cMm81ou0f7QgR2B55UdCULZ0NXm6m6ekPe3TXz2G5/W+NGdsfP9fX8YUKqjc=@vger.kernel.org, AJvYcCXZGusC+bSNIKZ6nDM3CT7sT0SOc3ABkXzgnUaD8J4mmYrMJWI2+2xpnBaxeRjHuX5m365mcdzrwZJ1DMyr17Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRIEbYTcfKkLrfSPArUbSR8VEBycd4EmrXWO8roqQRC/LGgaNX
	+onQuvf3+D0JBPktY+83PUpOFGTuQ+64K7EiSBh0IZ20IyWb2fADDW8j+H2e
X-Gm-Gg: ASbGnctkVZ/VjYSAxLsGz6wiOiFDZjIJNMlL81DGDI0ksZknoYhKpcPOH0Klj+OmGAk
	1yDiSwaUFInWexrbg0B7a7JCB/BVv0V1XAJsrinTGLITVcVa5uVjhS3R3eerADr5u5xdGkV8qyD
	zR5uQC4vHGKEUgbGCuyxkfg56baXSHvZDRGhSirBZ7IMD8fAsz1CJl7lGWI+LYYJ0Fqb41UEnrg
	ZvXzZzNRSnTxZgLFZKHWFXx85hycaswDuFzXbwsJ/jKzXQQTEqihTxyxZllXkoDPI9vr+x357QD
	LwX5rD+pnZV64e2vbsaNQ5+TysMrKrRJ0Mv0QW26zfAIrSCy5DPNSOXNYp30MR5Pi4w=
X-Google-Smtp-Source: AGHT+IHYZsgaPYQx2FdMAsV+vsquysI7f3kod6flfQmC9QzDnSxmST3+dXSeVvKnFPe4OsQYvITBbQ==
X-Received: by 2002:a05:6a20:b418:b0:1ee:abce:226f with SMTP id adf61e73a8af0-1eee5dabb6amr2402693637.42.1740035419816;
        Wed, 19 Feb 2025 23:10:19 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568af8sm13059672b3a.48.2025.02.19.23.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:10:19 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Alice Ryhl <aliceryhl@google.com>,
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
	me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: [PATCH v11 1/8] sched/core: Add __might_sleep_precision()
Date: Thu, 20 Feb 2025 16:06:03 +0900
Message-ID: <20250220070611.214262-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220070611.214262-1-fujita.tomonori@gmail.com>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
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
impact should be negligible. When printing the error (sleeping
function called from invalid context), the precision string format is
used instead of the simple string format; the precision specifies the
the maximum length of the displayed string.

Note that Location::file() providing a null-terminated string for
better C interoperability is under discussion [1].

[1]: https://github.com/rust-lang/libs-team/issues/466

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 include/linux/kernel.h |  2 ++
 kernel/sched/core.c    | 61 +++++++++++++++++++++++++++---------------
 2 files changed, 42 insertions(+), 21 deletions(-)

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
index 165c90ba64ea..6643e03eafa4 100644
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
+static void __might_resched_precision(const char *file, int file_len, int line,
+				      unsigned int offsets)
 {
 	/* Ratelimiting timestamp: */
 	static unsigned long prev_jiffy;
@@ -8740,8 +8723,8 @@ void __might_resched(const char *file, int line, unsigned int offsets)
 	/* Save this before calling printk(), since that will clobber it: */
 	preempt_disable_ip = get_preempt_disable_ip(current);
 
-	pr_err("BUG: sleeping function called from invalid context at %s:%d\n",
-	       file, line);
+	pr_err("BUG: sleeping function called from invalid context at %.*s:%d\n",
+	       file_len, file, line);
 	pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
 	       in_atomic(), irqs_disabled(), current->non_block_count,
 	       current->pid, current->comm);
@@ -8766,8 +8749,44 @@ void __might_resched(const char *file, int line, unsigned int offsets)
 	dump_stack();
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 }
+
+/*
+ * The precision in vsnprintf() specifies the maximum length of the
+ * displayed string. The precision needs to be larger than the actual
+ * length of the string, so a sufficiently large value should be used
+ * for the filename length.
+ */
+#define MAX_FILENAME_LEN (1<<14)
+
+void __might_resched(const char *file, int line, unsigned int offsets)
+{
+	__might_resched_precision(file, MAX_FILENAME_LEN, line, offsets);
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
+	__might_sleep_precision(file, MAX_FILENAME_LEN, line);
+}
+EXPORT_SYMBOL(__might_sleep);
+
 void __cant_sleep(const char *file, int line, int preempt_offset)
 {
 	static unsigned long prev_jiffy;
-- 
2.43.0


