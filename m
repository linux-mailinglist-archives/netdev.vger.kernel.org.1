Return-Path: <netdev+bounces-153600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3E69F8CAB
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 07:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B93818989D9
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 06:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B5B1A76B6;
	Fri, 20 Dec 2024 06:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRnGaCiL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBD51A725C;
	Fri, 20 Dec 2024 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675696; cv=none; b=BJV9vGbyBXthXaIs/gZGGI9ejlHKzSb41zmwnhc5QRS86oMoJyMaqW0KX2OQpCdLrDcsk/t8lKnSyEbMHPt875EPpZ1+9B6kxa1gf/dh9vjDtt+6reteg49mI2+LnvQrk8T5aVlvkSXZtX43ZXU9zBuzdlsU7JB68Ju1j7aELN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675696; c=relaxed/simple;
	bh=QO5DFXeHoLyVGb/IMqVs6AT/hZAGuwg/W0w/y6jLTVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHWY+ZPFU9+NDWnpS5YW2wosFBXh4a3C+btfrFbcXk6UDqjTSAlrZC97UA4zQQYVMrn+c4xF+hOxQxep1uISooL+FFdN0UETlX1VXHEB6Za24NOdi5WDxuX8eawsEnObpcBJ+Q36AZ4mWfYgDOddk2QZVdyoAOdyKXrDJOt70Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRnGaCiL; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7f4325168c8so716741a12.1;
        Thu, 19 Dec 2024 22:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734675693; x=1735280493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xwzzWid3u7MZrtpWluzHF97H3+68wqUob3pBTAGo1U=;
        b=QRnGaCiLvAIDkG5go/U6w7Fky+0BkN0zjWqoKvJCJEKPqS8X8cDOBCaYCwmsGcXtQR
         kwI5cXS2LocoPZblQ+S8vZKHqFn0d4KSFswsbN+/zbEhNp8VSfC3TmTVGmaWB1SZGgf8
         yWDX8YVgl+6uBJ7pEJeEVbZatYW8RHL6UwxBg+h1uH8Y7qWLIsohOHmBaO1Ld9aBWdpg
         C5NwB98QcprRUr1jd9j1Zp5geDlxxF/TzH58bMQuDYP+yjktNddcvBVRF5SmMGFetQKU
         j4CMTGeYxxYTr0X/ZnmPVEuqeFKKTf9hUGYOvX5qxMzinro3WP7piegP5lk+e1+qrPmZ
         r5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734675693; x=1735280493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xwzzWid3u7MZrtpWluzHF97H3+68wqUob3pBTAGo1U=;
        b=HfwkJAMZiMaDKqNj1Judr+x2zjjDUg55asUnlFZoOmxFAst2Loz+LnhuOSSd2F8s2h
         C3Z3l2wE2bYvNBVJBT3D0lL2TkMYzGDNUamiKBL+WBKEgusddsmCS6v00GifZqnQ85Rf
         nk/x5E4KvvNsKDXLC2Qr3kVU/+IUi7/I9/hGZ3R1Bjfk6ZdleC3sbyekNFSJSygUKeeM
         BnCE9D3r+OT/OHH6f+Fck8b7r/jGn7+We8fI9eYK/ezKVL/ljxZD3PMN1JNp1ANl2ORx
         wLUx5FNvd33GmniPi/tVkmE9DS14/V/+n2atUGZZgsGtfVyRc42SZXALvPiHz0ckoeK/
         LRVw==
X-Forwarded-Encrypted: i=1; AJvYcCVJQZH+3YLXHOWaleEeY+mQGNwbq0juOmua4DJtgTj0vt+2cjcZ8N6nNOFSb6JAXgeeWlJnMrY=@vger.kernel.org, AJvYcCXsjCXVGQAPt8AsTc6NuWnnJijr72E0MhaaNllSDir1DpAFvJlR+pDp688o6cIRYqkfI1dEGFQKpYeFxjnDVPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdLxa79+eudG9QKBCSBSHeLZ1Vjs99Z7oABDabPwvTVyldscOp
	IlcNF92MhnkCSlxIMPKVdjya3/QQc1r5/w3le3AUtwcCaRpgtPmIsYHY+ME4
X-Gm-Gg: ASbGncsM9HVWx9Yw6FEjZCsX0v2k3bM/FTtJrZhLAv2V/eK/Z9xe4pQ2evKcRb41Y96
	TCltRHYdtcjrKxUHvd6B+Ew40T7D8Q4byqN7bkIEWFRen7xuFLSHYI8EBVoiFvoKKfqHIh/XSfC
	yBMlUsUdLNXQBJ466y/NwvVmTKNnUaFgI3fMvIq4/yppItMXXzKh7pjwr/7Ro+E3w4GzK2N9ZY9
	5Q+AsPPsWWgIAPZeInC8Ul4g9V+8valjGMLDauLTW4CZk3IZkUCgmLfI/uCROI56qwYZoEz3Ejp
	cAODApx34Nq5sebnBQ==
X-Google-Smtp-Source: AGHT+IF3xoqtwhAMgoGRMwnfx93l70e5GgMpVRyhFNC1M4KOLneogVXvtz4WQ0tcFQ8au8o3U69ikQ==
X-Received: by 2002:a05:6a20:a103:b0:1e1:ae68:d900 with SMTP id adf61e73a8af0-1e5e04a2e64mr3786366637.22.1734675693202;
        Thu, 19 Dec 2024 22:21:33 -0800 (PST)
Received: from snail23.. (p7659208-ipoefx.ipoe.ocn.ne.jp. [221.188.16.207])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01d3sm2158548a12.23.2024.12.19.22.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 22:21:32 -0800 (PST)
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
	vschneid@redhat.com
Subject: [PATCH v7 6/7] rust: Add read_poll_timeout functions
Date: Fri, 20 Dec 2024 15:18:52 +0900
Message-ID: <20241220061853.2782878-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220061853.2782878-1-fujita.tomonori@gmail.com>
References: <20241220061853.2782878-1-fujita.tomonori@gmail.com>
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
index 3e5a6bf587f9..6ed70c801172 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8670,7 +8670,10 @@ void __init sched_init(void)
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 
-void __might_sleep(const char *file, int line)
+extern inline void __might_resched_precision(const char *file, int len,
+					     int line, unsigned int offsets);
+
+void __might_sleep_precision(const char *file, int len, int line)
 {
 	unsigned int state = get_current_state();
 	/*
@@ -8684,7 +8687,14 @@ void __might_sleep(const char *file, int line)
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
 
@@ -8709,7 +8719,7 @@ static inline bool resched_offsets_ok(unsigned int offsets)
 	return nested == offsets;
 }
 
-void __might_resched(const char *file, int line, unsigned int offsets)
+void __might_resched_precision(const char *file, int len, int line, unsigned int offsets)
 {
 	/* Ratelimiting timestamp: */
 	static unsigned long prev_jiffy;
@@ -8732,8 +8742,8 @@ void __might_resched(const char *file, int line, unsigned int offsets)
 	/* Save this before calling printk(), since that will clobber it: */
 	preempt_disable_ip = get_preempt_disable_ip(current);
 
-	pr_err("BUG: sleeping function called from invalid context at %s:%d\n",
-	       file, line);
+	pr_err("BUG: sleeping function called from invalid context at %.*s:%d\n",
+	       len, file, line);
 	pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
 	       in_atomic(), irqs_disabled(), current->non_block_count,
 	       current->pid, current->comm);
@@ -8758,6 +8768,13 @@ void __might_resched(const char *file, int line, unsigned int offsets)
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
index d16aeda7a558..7ab71a6d4603 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -13,6 +13,7 @@
 #include "build_bug.c"
 #include "cred.c"
 #include "err.c"
+#include "kernel.c"
 #include "fs.c"
 #include "jump_label.c"
 #include "kunit.c"
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
index 914e8dec1abd..b5016083a115 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -63,6 +63,7 @@ macro_rules! declare_err {
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
index e1065a7551a3..2e9722f980bd 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -33,6 +33,7 @@
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 mod build_assert;
+pub mod cpu;
 pub mod cred;
 pub mod device;
 pub mod error;
@@ -40,6 +41,7 @@
 pub mod firmware;
 pub mod fs;
 pub mod init;
+pub mod io;
 pub mod ioctl;
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
-- 
2.43.0


