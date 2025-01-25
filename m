Return-Path: <netdev+bounces-160914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBA8A1C2B0
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 11:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4283A4358
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 10:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F431E7C08;
	Sat, 25 Jan 2025 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIyHRDff"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBFD13C9B3;
	Sat, 25 Jan 2025 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737800408; cv=none; b=Jup+5HGuKrqQxmLXV6va/gyK1Gmakeu0pX628hEYozmw9v0pmryPNV3CG/T8q4dXrJZjuux4cAnMIoIHXh9uw7E8ooUxuoXULW71ETVXntwfZ/gCreYovxFCC6eZ0l2KU5MG8ztG3koVfqKsOpE+umpC6Ya6D/HVmL1styiTNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737800408; c=relaxed/simple;
	bh=5oz9sIjw/o0ZjqC8hTqxUM3NwZQ1hLqZIqcLUVdkDLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxwZAevWbARuJwInW1vAwi3GdCKMQGpQmLn9TPNesu8EtCKdaYgbX9mg7ng2Ob5hdmhPZD02/MMbNV+xpjIY6Iavo81aXBWr6rdE/aCMxGdX2iqsopiELVkR3FGXk/nwz/4Jbsah5MFBPC0xDZ5henr8CKlnfBYCKMgPw1A21G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIyHRDff; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216281bc30fso69226655ad.0;
        Sat, 25 Jan 2025 02:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737800406; x=1738405206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ug7H6Tg9hQrupRnAyu5Tv5PLt5bLM7m9t9K7+m86s68=;
        b=gIyHRDffddh5zD5IxXzA7S9O83fHTODOrZIyhOVCz1q7eKde0OvlBkoVrt8eREWY/t
         kSw491UpSAR0VREeg562lzkzGVPAv5FouY7tIK/FSOQYpMsLmNh7tVo2rhvdon0Zspg7
         Ia53X4Ij8EB8C42LBYo8HQsOoidCy17Da6fNHN3khgbRNCBFkiTeGqFPFeHz6osHNV/E
         2QDFp6f+Fd/W6/274JrV3xGU+iRWyfYqYnvi8sfZ0Q17cxPQWeoFyzrp/QbU2og5hcNe
         QvDrUfXljd9iPlkA16R1ZK3TTwZlKM8+d95sx2dmDVqUbN8KdNHUmQEuauGsXJP0CZvS
         187g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737800406; x=1738405206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ug7H6Tg9hQrupRnAyu5Tv5PLt5bLM7m9t9K7+m86s68=;
        b=sbGvSr/rnFrhzlC8Rl33Mf+tJGgQUrNaOwZf0NCgPIBp5l3daI4frSbADh7bNvqPmq
         w52Ys+eadkdIMON+i/BE6N+BOkqsGCRwwE7ARd6dLLaLz2k/Y5oFEHsFyUNS1bpRMzwx
         B9bnGsekhJ2Onw3sv4XS6Pum92pxvvO7bhuVv6UOzo5nEn4u0P6YZl4O9K/7JzqPMDgV
         FnrteaiQsphZkCaNEXK7u4VHrpLfqHwyCpy97TjQmA31LsCLn33rgpOIo1a9jkzVPriH
         wvFNyxZo69fje2ebG7TJ4B+jpfFsgusMucTLuPlMSUdg4SZJ1Sv1leZZhBX/Ye5/UrMk
         AAcw==
X-Forwarded-Encrypted: i=1; AJvYcCXF2MwKIeHZof6KHKw8A3kGCM5MHkTiraGWsPuVNLKuKnlL1uF4PepOg7TqsIGXzfZDxUHWuO0griYpfyd1ByM=@vger.kernel.org, AJvYcCXLvoV7tpaOOhosTcdhP2TEL8IMcP6mTmUO+hbl8c0QL25EoyQrsh28YWy/SZyTcgenVLeaA8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfuUz/ki9C8vfMUMSw2Uqc0INwmgu9Fd9MhZNjhz66rf81PBdY
	caGo6sfoU4XqRQFWxe3ps42sbPAUYDbwVoVIBeihf0j4tAvzKM4yZbGlDWLU
X-Gm-Gg: ASbGncvQ1xWtplfkQnmI3aPsco+IYbK2NSYPWuawn+wwmqzi6UU0KiV8h5hSUFLF06f
	sJY+JFj0P8Xe1NIyqhyLnFS15Ix2hDt0o5rBcAVwMV7CJui+WEsoM9Prj/DdmMeBF4PTrD7ev14
	MIEcsTjNnwhMsIAvyPgza3QqxRoFmkJHjzIC+j8Kwi2dg0SVef7aBQsB15eo6ts8yBdPpEP/aSU
	hKqV25rdSens5FHRmk3YmHjougVClC69Bk17miokfltDlyHH/uYRviNRgsseJnvE0hTXC+fcrrO
	9yMYJReRPRnyycnfYnbnqTM5eVs9XrOi4XI+vNVYk3wAaY6THEZzQO3r
X-Google-Smtp-Source: AGHT+IHCCIlprRg4YscGaB/p+BlLhJxnEKb2Nxo4CInGgZ2U7G89kCOHyV2cTRQSOW/Ag71I2TrLOA==
X-Received: by 2002:a17:902:ccc2:b0:216:3e86:1cb9 with SMTP id d9443c01a7336-21c357a608dmr481655415ad.50.1737800406177;
        Sat, 25 Jan 2025 02:20:06 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424f344sm29461155ad.232.2025.01.25.02.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 02:20:05 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
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
	aliceryhl@google.com,
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
	tgunders@redhat.com
Subject: [PATCH v9 1/8] sched/core: Add __might_sleep_precision()
Date: Sat, 25 Jan 2025 19:18:46 +0900
Message-ID: <20250125101854.112261-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250125101854.112261-1-fujita.tomonori@gmail.com>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
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

[1]: https://github.com/rust-lang/libs-team/issues/466
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
index 88a9a515b2ba..69d77c14ad33 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8666,24 +8666,6 @@ void __init sched_init(void)
 
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
@@ -8705,7 +8687,8 @@ static inline bool resched_offsets_ok(unsigned int offsets)
 	return nested == offsets;
 }
 
-void __might_resched(const char *file, int line, unsigned int offsets)
+static void __might_resched_precision(const char *file, int len, int line,
+				      unsigned int offsets)
 {
 	/* Ratelimiting timestamp: */
 	static unsigned long prev_jiffy;
@@ -8728,8 +8711,10 @@ void __might_resched(const char *file, int line, unsigned int offsets)
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
@@ -8754,8 +8739,36 @@ void __might_resched(const char *file, int line, unsigned int offsets)
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


