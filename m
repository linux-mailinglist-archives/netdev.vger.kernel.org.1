Return-Path: <netdev+bounces-160921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5EFA1C2BD
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 11:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B17169AE6
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 10:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E7F20A5C7;
	Sat, 25 Jan 2025 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCwdKmO3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E4920A5C2;
	Sat, 25 Jan 2025 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737800453; cv=none; b=MOni8Rw8LK4WCq77P/kqSOh0ebhLVM2dnT+dcUHLHYG7IwasiyGlg7TZUHzG+z+sNL49g01XRz2+6GMQRSJPTplJgDiFn0bkes1LjZ6ZF1KqBA9rFn+vwiEtbQDSjBVxvuDHxTkYEcbAMl9N7iwcFAcrFYGAyw8MOB8JLFmFMkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737800453; c=relaxed/simple;
	bh=I0HU++TiIi/bjwfayKjc8D6SR4E6d+5vz6vuwMPJ3I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUFRgYZHgrdWC21QR2YogZkkFkyP3wlEB0D9tLRWr3gEMUChFAeiNAl5WOZvNfE4EbkeMEoiURbIDVIi/yEFhWRDTgcJ8ov9fdi9OOrS8i59o5EC5/5/L8GP39jtCir1KDAxRVthU+ImByOby6Bifdj526GmTq3S1aXeSJDSZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCwdKmO3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-219f8263ae0so54155465ad.0;
        Sat, 25 Jan 2025 02:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737800451; x=1738405251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7PYttLtBbsdK/gZ6kIbMnSJ3NKWcgkxmnzIQ8mz2TQ=;
        b=FCwdKmO37oSDg5XkuBlQLwuMbhHk9ONoEVPtshYzPoqoc+fzaQYaPo0woFjYvBRD2Y
         itx7H1KQTRgV9/m6L8V4RMoG+rbCaGIkVjvly9zqRkgXv1zeQAZgITse+j5Js6hPW2J2
         mRDAGds9Ywn64wlQoK36SyaJdM+LKIrfqvuc9jm61/JrM6pfwd2jDTvzH07aTThtroSY
         C+WusOHfNJ4yQMy77EL91LGvkVaz+9r4fWH+kXDj1OXgtloZ/nQrQjX6cbhz9Urhyhl+
         QVeWblniPvIms+iSukbkzUx0cSqfw1CH23+pkBY54UIxmBXMQBwL5wHeqhRuuw4tqR1y
         1X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737800451; x=1738405251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7PYttLtBbsdK/gZ6kIbMnSJ3NKWcgkxmnzIQ8mz2TQ=;
        b=UEeTh49XkFumE+OZ6UiWDMwQCyYv4SzT5x4juGJgHPSGIpbMAdV2A0uA0NfQt3nkG8
         tjPDPTlE2DWi+Lp/yPJ+mN3vwHwAUSRS20FyZaTaL0z6xQzS6Bap8sqDKJGo2ijTpU6m
         YWvNsmSdsPQ/eSEoL5X0jo4I6U3epwd+XnrCEFSfq5zOgTUSQhrgTmU38z58gkPcW3Yj
         qlcGC7OBbKdtHnCDQ0OO/ku04C7vF89UMapp7NxPxJmkwdYnSi0S+aJurEtmzDhkzY3I
         T4svA0rik0NCgGZjueYcWJSMl50tySseW3833SG29opY1UPHWYjfe9SG2/Td6eGBwed/
         Akmw==
X-Forwarded-Encrypted: i=1; AJvYcCVH58bueHD550H71tiV7Zk3ZWdeYW1iVRxabLGTrj2lLi+t9bfEhtGZ6u5GbnnqREt6pwrILRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpNfE1Y05a5pLfp/a6mIpAwdHxYO+qbvhUcsq4AhIU7hN6bWWX
	AqCZgrKMV/F4asl0lLnMwmXqv7EKXKn8XdDZQABKeu/C0+FSX2/xJHyUQMSF
X-Gm-Gg: ASbGncsorIc/PAKM3lRRrVwGRzY0Z70wujYqyXSDncImWfl9EWg/WrnZ9ZYaKnBUeUo
	eWzEkPqUzQRGjG5dqP/y2B9iyS8XVLjD5eUs2necDK+RdIOjKvk1b2QT5uxyUkUbMBCHeJWEmoJ
	0YyQFFBlG6IQpyvxHv9MFqRkTOPggfMgFLfUjFTsVN207nyLzXH44r1uu0ocipqzr5uFIxgPa/b
	6/tvDqFYnmcjN9LP/Lou49RVo3oAidGeA1D7R+2ivMQnRNlDV/dy+2c43atRHkGa2lBALMuwTBQ
	3AbtyghZYardTbRyVZirEmHeZgphFa0+XZvWi+AvGBBOk3CxVlCDwKw4
X-Google-Smtp-Source: AGHT+IEew27tHyn3byUsCXwKbwCRMB7Xk82wvoYBvjshYg++NuADnORNnU736Vpc+7NZKPHoEMWCUg==
X-Received: by 2002:a17:902:f644:b0:211:8404:a957 with SMTP id d9443c01a7336-21c355f6aa9mr579549235ad.41.1737800450601;
        Sat, 25 Jan 2025 02:20:50 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424f344sm29461155ad.232.2025.01.25.02.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 02:20:50 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
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
Subject: [PATCH v9 7/8] rust: Add read_poll_timeout functions
Date: Sat, 25 Jan 2025 19:18:52 +0900
Message-ID: <20250125101854.112261-8-fujita.tomonori@gmail.com>
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

Add read_poll_timeout functions which poll periodically until a
condition is met or a timeout is reached.

The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
macro and a simple wrapper for Rust doesn't work. So this implements
the same functionality in Rust.

The C version uses usleep_range() while the Rust version uses
fsleep(), which uses the best sleep method so it works with spans that
usleep_range() doesn't work nicely with.

Unlike the C version, __might_sleep() is used instead of might_sleep()
to show proper debug info; the file name and line
number. might_resched() could be added to match what the C version
does but this function works without it.

The sleep_before_read argument isn't supported since there is no user
for now. It's rarely used in the C version.

read_poll_timeout() can only be used in a nonatomic context. This
requirement is not checked by these abstractions, but it is intended
that klint [1] or a similar tool will be used to check it in the
future.

Link: https://rust-for-linux.com/klint [1]
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/helpers.c |  1 +
 rust/helpers/kernel.c  | 13 +++++++
 rust/kernel/cpu.rs     | 13 +++++++
 rust/kernel/error.rs   |  1 +
 rust/kernel/io.rs      |  5 +++
 rust/kernel/io/poll.rs | 79 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |  2 ++
 7 files changed, 114 insertions(+)
 create mode 100644 rust/helpers/kernel.c
 create mode 100644 rust/kernel/cpu.rs
 create mode 100644 rust/kernel/io.rs
 create mode 100644 rust/kernel/io/poll.rs

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
index f6ecf09cb65f..8858eb13b3df 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -64,6 +64,7 @@ macro_rules! declare_err {
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
index 000000000000..7a503cf643a1
--- /dev/null
+++ b/rust/kernel/io/poll.rs
@@ -0,0 +1,79 @@
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
+    mut cond: Cond,
+    sleep_delta: Delta,
+    timeout_delta: Delta,
+) -> Result<T>
+where
+    Op: FnMut() -> Result<T>,
+    Cond: FnMut(&T) -> bool,
+{
+    let start = Instant::now();
+    let sleep = !sleep_delta.is_zero();
+    let timeout = !timeout_delta.is_zero();
+
+    if sleep {
+        might_sleep(Location::caller());
+    }
+
+    loop {
+        let val = op()?;
+        if cond(&val) {
+            // Unlike the C version, we immediately return.
+            // We know the condition is met so we don't need to check again.
+            return Ok(val);
+        }
+        if timeout && start.elapsed() > timeout_delta {
+            // Unlike the C version, we immediately return.
+            // We have just called `op()` so we don't need to call it again.
+            return Err(ETIMEDOUT);
+        }
+        if sleep {
+            fsleep(sleep_delta);
+        }
+        // fsleep() could be busy-wait loop so we always call cpu_relax().
+        cpu_relax();
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
index 545d1170ee63..c477701b2efa 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -35,6 +35,7 @@
 pub mod block;
 #[doc(hidden)]
 pub mod build_assert;
+pub mod cpu;
 pub mod cred;
 pub mod device;
 pub mod error;
@@ -42,6 +43,7 @@
 pub mod firmware;
 pub mod fs;
 pub mod init;
+pub mod io;
 pub mod ioctl;
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
-- 
2.43.0


