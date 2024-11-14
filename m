Return-Path: <netdev+bounces-144701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB4D9C83BB
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08781F23914
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DBD1F427B;
	Thu, 14 Nov 2024 07:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjhbneQQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B21F470B;
	Thu, 14 Nov 2024 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568038; cv=none; b=L/Gt4g905tBtP9M+UyfWP+4ByD7bdlBRhoqF5oUPGBSC+fTumTG2OWXMaxOHUYRV0EhiCc+QWu9RSjFTzTykmdv3HFeU4MmHvwVN2RTHBkzhRvrQSooNNXa4tv/BPtTE9F2L8LKadc8zcEIcN7anZsqHQ8YpEFCVjSXcCQlKR+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568038; c=relaxed/simple;
	bh=o13rF7xXb2nrxZLvzkhhe0RZrCFicG3sT7cryBqCQeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1B9iYNuYuo/RL287HAKKGxvLqzWhRtkDZq+0/MBjnlfUpAOF9p8sl7Hl0fWBHHQiakjejJYEm7ZNQSXQU2sPJeZdvHAiPX9zGvpC25SIzW211I1Ob3YhJ+QLjHOpQfS4q0XnzAMM+79pANvXshJhMd02FQvUYHZxgPa3a68lZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjhbneQQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2113da91b53so1698815ad.3;
        Wed, 13 Nov 2024 23:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731568035; x=1732172835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izx/1TmaWdZTGGVem4OBbdFm7p18B6BW1T/W5pkcSJM=;
        b=FjhbneQQf5Ib+j+T6y96pUWVPjAMUVFMQ2EaSNO6KReuR5BK4TjLkftvFC6Wgkxikl
         GZ6V7UZTtSts4DUWFZd3N62lhFr/raeIXsZ8qnoa2c/r6Mfcgaa5C5s9ZKTJth7iE3lc
         8hv26tpTifycoyYa7HO4O8Xt5Yai/oqOK8xuIG5IOfcgD8/xvVf3wXgvfIZX7TyO2qn9
         Mhpqla+xEP8P0OleIrNe8jUA9wU4WK/XF/oBnjG0krwfw0QaHBHRKlfZEdQRYEP+x46Q
         07j18CCiHsR5sAIzqfKPuquAqqv3mXNCcbVa2n1MC+g4KLP9o0ymvm9U51yp5RmXGVSp
         dsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731568035; x=1732172835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izx/1TmaWdZTGGVem4OBbdFm7p18B6BW1T/W5pkcSJM=;
        b=ZTR0AuUHihph5eP6BAi7c8b+USJs32eUqXF9L4n2x8bMi3MvCX7hHPrf4FsLdFxVKG
         VmZ4GsBFWm1wmzJz2ljkjskX5xMGHvw+PoV/6muUndsoGlcD9QaFfrQk0hJj0Whgu+Ve
         +owuaOSTHiai8zKquq4LR8lUrB3wY+8Z2/AF3CbJl0+7gyr9v9D/ZRrNVddLQ6y9A9FQ
         ho3V1L+N3N8caNSRtYocRp1ybgQiNTSvfbgJcHR3Cx5bp3FTcvGsKElAYZo9z+zD7ITE
         IgQJFjWvP5sCZh6H1ey6QAA4cWJnronAscIXLAw3+bEe75vAXDaBUWsBp1SJ9KUKHBT7
         hpTw==
X-Forwarded-Encrypted: i=1; AJvYcCVTrI8Qo8SzKm+iYvELZuHJ9HbI57wewP4f/3dAoHJNCm5EB29/sjqgAsj5e5JPHSOHXbUuWN8ARkcB3YRwsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoO1CxUqwfuL+7hp+Ucyp70spTIHt2fHOpSCGQ+UoemwgVp56C
	EFcizGSWjPM7HInnPbBO2gechQqaMFYmNvprkQL/cAwf9T1ymxCSLCQwAyoB
X-Google-Smtp-Source: AGHT+IEkIVBz2fIYq8pIW7ZUyR0JdkO0+sHq7ppSxlZwzZcAXzN07PIqAsvlcNq/b6aViKcM2uHpmQ==
X-Received: by 2002:a17:902:ecd2:b0:20c:98f8:e0fa with SMTP id d9443c01a7336-21183ccf7camr301661955ad.11.1731568035039;
        Wed, 13 Nov 2024 23:07:15 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d24a00sm4260315ad.244.2024.11.13.23.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:07:14 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
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
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v6 6/7] rust: Add read_poll_timeout functions
Date: Thu, 14 Nov 2024 16:02:33 +0900
Message-ID: <20241114070234.116329-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114070234.116329-1-fujita.tomonori@gmail.com>
References: <20241114070234.116329-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add read_poll_timeout functions which poll periodically until a
condition is met or a timeout is reached.

C's read_poll_timeout (include/linux/iopoll.h) is a complicated macro
and a simple wrapper for Rust doesn't work. So this implements the
same functionality in Rust.

The C version uses usleep_range() while the Rust version uses
fsleep(), which uses the best sleep method so it works with spans that
usleep_range() doesn't work nicely with.

Unlike the C version, __might_sleep() is used instead of might_sleep()
to show proper debug info; the file name and line
number. might_resched() could be added to match what the C version
does but this function works without it.

The sleep_before_read argument isn't supported since there is no user
for now. It's rarely used in the C version.

core::panic::Location::file() doesn't provide a null-terminated string
so add __might_sleep_precision() helper function, which takes a
pointer to a string with its length.

read_poll_timeout() can only be used in a nonatomic context. This
requirement is not checked by these abstractions, but it is intended
that klint [1] or a similar tool will be used to check it in the
future.

Link: https://rust-for-linux.com/klint [1]
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 include/linux/kernel.h |  2 +
 kernel/sched/core.c    | 27 +++++++++++---
 rust/helpers/helpers.c |  1 +
 rust/helpers/kernel.c  | 13 +++++++
 rust/kernel/cpu.rs     | 13 +++++++
 rust/kernel/error.rs   |  1 +
 rust/kernel/io.rs      |  5 +++
 rust/kernel/io/poll.rs | 84 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |  2 +
 9 files changed, 143 insertions(+), 5 deletions(-)
 create mode 100644 rust/helpers/kernel.c
 create mode 100644 rust/kernel/cpu.rs
 create mode 100644 rust/kernel/io.rs
 create mode 100644 rust/kernel/io/poll.rs

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
index 43e453ab7e20..78e9fef29616 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8543,7 +8543,10 @@ void __init sched_init(void)
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 
-void __might_sleep(const char *file, int line)
+extern inline void __might_resched_precision(const char *file, int len,
+					     int line, unsigned int offsets);
+
+void __might_sleep_precision(const char *file, int len, int line)
 {
 	unsigned int state = get_current_state();
 	/*
@@ -8557,7 +8560,14 @@ void __might_sleep(const char *file, int line)
 			(void *)current->task_state_change,
 			(void *)current->task_state_change);
 
-	__might_resched(file, line, 0);
+	__might_resched_precision(file, len, line, 0);
+}
+
+void __might_sleep(const char *file, int line)
+{
+	long len = strlen(file);
+
+	__might_sleep_precision(file, len, line);
 }
 EXPORT_SYMBOL(__might_sleep);
 
@@ -8582,7 +8592,7 @@ static inline bool resched_offsets_ok(unsigned int offsets)
 	return nested == offsets;
 }
 
-void __might_resched(const char *file, int line, unsigned int offsets)
+void __might_resched_precision(const char *file, int len, int line, unsigned int offsets)
 {
 	/* Ratelimiting timestamp: */
 	static unsigned long prev_jiffy;
@@ -8605,8 +8615,8 @@ void __might_resched(const char *file, int line, unsigned int offsets)
 	/* Save this before calling printk(), since that will clobber it: */
 	preempt_disable_ip = get_preempt_disable_ip(current);
 
-	pr_err("BUG: sleeping function called from invalid context at %s:%d\n",
-	       file, line);
+	pr_err("BUG: sleeping function called from invalid context at %.*s:%d\n",
+	       len, file, line);
 	pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
 	       in_atomic(), irqs_disabled(), current->non_block_count,
 	       current->pid, current->comm);
@@ -8631,6 +8641,13 @@ void __might_resched(const char *file, int line, unsigned int offsets)
 	dump_stack();
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 }
+
+void __might_resched(const char *file, int line, unsigned int offsets)
+{
+	long len = strlen(file);
+
+	__might_resched_precision(file, len, line, offsets);
+}
 EXPORT_SYMBOL(__might_resched);
 
 void __cant_sleep(const char *file, int line, int preempt_offset)
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index c274546bcf78..f9569ff1717e 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -12,6 +12,7 @@
 #include "build_assert.c"
 #include "build_bug.c"
 #include "err.c"
+#include "kernel.c"
 #include "kunit.c"
 #include "mutex.c"
 #include "page.c"
diff --git a/rust/helpers/kernel.c b/rust/helpers/kernel.c
new file mode 100644
index 000000000000..9dff28f4618e
--- /dev/null
+++ b/rust/helpers/kernel.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+
+void rust_helper_cpu_relax(void)
+{
+	cpu_relax();
+}
+
+void rust_helper___might_sleep_precision(const char *file, int len, int line)
+{
+	__might_sleep_precision(file, len, line);
+}
diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
new file mode 100644
index 000000000000..eeeff4be84fa
--- /dev/null
+++ b/rust/kernel/cpu.rs
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Processor related primitives.
+//!
+//! C header: [`include/linux/processor.h`](srctree/include/linux/processor.h).
+
+/// Lower CPU power consumption or yield to a hyperthreaded twin processor.
+///
+/// It also happens to serve as a compiler barrier.
+pub fn cpu_relax() {
+    // SAFETY: FFI call.
+    unsafe { bindings::cpu_relax() }
+}
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 6f1587a2524e..d571b9587ed6 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -58,6 +58,7 @@ macro_rules! declare_err {
     declare_err!(EPIPE, "Broken pipe.");
     declare_err!(EDOM, "Math argument out of domain of func.");
     declare_err!(ERANGE, "Math result not representable.");
+    declare_err!(ETIMEDOUT, "Connection timed out.");
     declare_err!(ERESTARTSYS, "Restart the system call.");
     declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
     declare_err!(ERESTARTNOHAND, "Restart if no handler.");
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
new file mode 100644
index 000000000000..033f3c4e4adf
--- /dev/null
+++ b/rust/kernel/io.rs
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Input and Output.
+
+pub mod poll;
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
new file mode 100644
index 000000000000..da8e975d8e50
--- /dev/null
+++ b/rust/kernel/io/poll.rs
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! IO polling.
+//!
+//! C header: [`include/linux/iopoll.h`](srctree/include/linux/iopoll.h).
+
+use crate::{
+    cpu::cpu_relax,
+    error::{code::*, Result},
+    time::{delay::fsleep, Delta, Instant},
+};
+
+use core::panic::Location;
+
+/// Polls periodically until a condition is met or a timeout is reached.
+///
+/// Public but hidden since it should only be used from public macros.
+///
+/// ```rust
+/// use kernel::io::poll::read_poll_timeout;
+/// use kernel::time::Delta;
+/// use kernel::sync::{SpinLock, new_spinlock};
+///
+/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
+/// let g = lock.lock();
+/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Delta::from_micros(42));
+/// drop(g);
+///
+/// # Ok::<(), Error>(())
+/// ```
+#[track_caller]
+pub fn read_poll_timeout<Op, Cond, T: Copy>(
+    mut op: Op,
+    cond: Cond,
+    sleep_delta: Delta,
+    timeout_delta: Delta,
+) -> Result<T>
+where
+    Op: FnMut() -> Result<T>,
+    Cond: Fn(T) -> bool,
+{
+    let start = Instant::now();
+    let sleep = !sleep_delta.is_zero();
+    let timeout = !timeout_delta.is_zero();
+
+    might_sleep(Location::caller());
+
+    let val = loop {
+        let val = op()?;
+        if cond(val) {
+            // Unlike the C version, we immediately return.
+            // We know a condition is met so we don't need to check again.
+            return Ok(val);
+        }
+        if timeout && start.elapsed() > timeout_delta {
+            // Should we return Err(ETIMEDOUT) here instead of call op() again
+            // without a sleep between? But we follow the C version. op() could
+            // take some time so might be worth checking again.
+            break op()?;
+        }
+        if sleep {
+            fsleep(sleep_delta);
+        }
+        // fsleep() could be busy-wait loop so we always call cpu_relax().
+        cpu_relax();
+    };
+
+    if cond(val) {
+        Ok(val)
+    } else {
+        Err(ETIMEDOUT)
+    }
+}
+
+fn might_sleep(loc: &Location<'_>) {
+    // SAFETY: FFI call.
+    unsafe {
+        crate::bindings::__might_sleep_precision(
+            loc.file().as_ptr().cast(),
+            loc.file().len() as i32,
+            loc.line() as i32,
+        )
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 22a3bfa5a9e9..dd02acfed6df 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -30,11 +30,13 @@
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 mod build_assert;
+pub mod cpu;
 pub mod device;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
 pub mod init;
+pub mod io;
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
-- 
2.43.0


