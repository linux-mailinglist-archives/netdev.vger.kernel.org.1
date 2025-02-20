Return-Path: <netdev+bounces-168003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01F8A3D1DB
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B3D17D1F4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8461E5B83;
	Thu, 20 Feb 2025 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfki2ASe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB91E5B6F;
	Thu, 20 Feb 2025 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035471; cv=none; b=aa1WsLb2jTotfqPFwj+EqU8MiQeS6dENM9rL54o07CYF/EJbpMd7GCh9YlPdA8FhVeuh3m2TgwTGqgLExt7uVkNEMG/9kfKSFpdMtxk8UjXAxTiWHefeQWo7VI+CROmmUVQl0ZAlcC4q+n9ABQ4KW2nT/OHj7rAE3tf2Nwf8lHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035471; c=relaxed/simple;
	bh=w4iGBvNOz+zD7SL3U+67uQljwCududwg6tU10OLcju4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnxOsUH2Ku0ng6EUgg/cInvUl43SX9ds057tRfxePAuZU/03clyCPm+SAiZf0QMHTddcJaVJgdmHP9KfJLp5J+ynq8eTa4GI61HkoBdR6HXs/sEwpVA2w0wRhNiuASMCV5RIEJPX6hl1TrU1HSDT69cMxL4UTshXgt7g3qJaMYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfki2ASe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22128b7d587so9656135ad.3;
        Wed, 19 Feb 2025 23:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740035468; x=1740640268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+MBuGWnj96pqN8g4XrjCHzKJT0duecX7mmWDcQ6My8=;
        b=kfki2ASe1uB1S4l95v1V9ym2hd7E4YOEq1v6lnys1uyrRWbKfzQZ5+mXTyx+85p7u7
         CiClbrx7YoqH5eeN4zwkEVQrEFLCsHVpKCQ5abZdQ8l4Zn3R0YIHjluqCHK9NfGGSct9
         S4oA5bef7MP8Myu3BebttG8n3r/wR4prEz3od78yv0Vpbg5brAQT2SeYSLQvEj6EsgCt
         aWqdcBHIp6Qn7EXcGXkLvKLWl3CV+TqI255gTuDB+Eu4baN7bx3wG5VWcIiCJo3UicBK
         8qKwl8rB+S1Thpl1cDlgP6SGiptNHDZKHGCPE8b8pF0kAXv4h0AtHdEFu5JRPTSVBR3D
         5zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740035468; x=1740640268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+MBuGWnj96pqN8g4XrjCHzKJT0duecX7mmWDcQ6My8=;
        b=Vzuv3Sdet2tQPNqVpjAFkjG5rqaJSSDd9+yiUl7BdcW9/PZFGP6puwOaDoYY5HCUIt
         GvN10eTRYXpx7+M8C3ne0AM+tds7HX0sNcG2Btc+C6uL7Fj4DbcR5/Zvh2uEaOjGYkCP
         k19UTxjWS9ARvnkbGJy0yDO3w/8QNMtL4/ARFtNzQzkcymtHlLyzrcn/1e5WkjUsHbv9
         WWo+IGKd30nYX/dofi8/8KsCNld7ri2eIvp69j+wpU3CzHXFMXvMwVeeqTT5NgF0TdFR
         3+DaeCJxeWIQuJIiB0TA/mj0i17qDSWRGWfuxFhjQTUnwXZBHYRFYIrotnkvpIPhPIoH
         AZTg==
X-Forwarded-Encrypted: i=1; AJvYcCUToYX1hBYKP+FbJupse2SCCD28PAMLeuZ62V+j1k8Ppf9z0lHaOWDsrlsntFiiQ82owZLzsms=@vger.kernel.org, AJvYcCUsc5XJeE7XpRQqOQcsI5qNwaAOCUh5UykJAhqtN2JlOI0/K3k0FkE9HDr85bChCBcoXPXOYlVB0hNHAiv4IY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHZjMqsqwZIpHwvmz3FDDUR1d7r+BWcV/zQXwJRONNF1MvQWcV
	J5EXmmz0rIfdX1VgSbHbai9h50xJ6KDaV3z7fAgR9xPugIMOatFySIMBk+6J
X-Gm-Gg: ASbGncsT59Hm6oRD6/tBYPfIs5BE/+91in1qVAFRC7n8NlpGROjmf1o2Gmf9tRU6Z14
	5xSlkJqlBUNbb3Io//joRyZHxrMGGLRyQVL2R5gWjQFespCvloabcVchIqRjBczPLBi+bJ6cmBT
	W8PqtvrvjHWks+jMnYdxhYk2H4aQ+jgQijkek8uywwQNTGxoAohkwnqworHfPrKh/cMoOQKwaTI
	r3Sgizh1HW0T47D67BHx4JljGbBKUFlzi5luqLjMTRpARyzPU6BOnsL1pp6WLomAk4ieKpF4J9d
	voZzMLFG86Vm8fzKfuJDr0VN2zNP/NEHjmTyd0ZehK8RqdNsRJgVeCiPcozogwew0qo=
X-Google-Smtp-Source: AGHT+IFvFieXVEzkxe7DkLDLt58IN6h8T4TU6a3jR2yOsz3aSd18Bp/NvUa/gEsW6sY+pOCRgd5M5g==
X-Received: by 2002:a05:6a21:6b11:b0:1ee:cfaa:f174 with SMTP id adf61e73a8af0-1eed505be52mr10573169637.42.1740035468382;
        Wed, 19 Feb 2025 23:11:08 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568af8sm13059672b3a.48.2025.02.19.23.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:11:08 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
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
	tgunders@redhat.com,
	me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: [PATCH v11 7/8] rust: Add read_poll_timeout functions
Date: Thu, 20 Feb 2025 16:06:09 +0900
Message-ID: <20250220070611.214262-8-fujita.tomonori@gmail.com>
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

Add read_poll_timeout functions which poll periodically until a
condition is met or a timeout is reached.

The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
macro and a simple wrapper for Rust doesn't work. So this implements
the same functionality in Rust.

The C version uses usleep_range() while the Rust version uses
fsleep(), which uses the best sleep method so it works with spans that
usleep_range() doesn't work nicely with.

The sleep_before_read argument isn't supported since there is no user
for now. It's rarely used in the C version.

read_poll_timeout() can only be used in a nonatomic context. This
requirement is not checked by these abstractions, but it is intended
that klint [1] or a similar tool will be used to check it in the
future.

Link: https://rust-for-linux.com/klint [1]
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/helpers.c |   1 +
 rust/helpers/kernel.c  |  18 +++++++
 rust/kernel/cpu.rs     |  13 +++++
 rust/kernel/error.rs   |   1 +
 rust/kernel/io.rs      |   2 +
 rust/kernel/io/poll.rs | 120 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 7 files changed, 156 insertions(+)
 create mode 100644 rust/helpers/kernel.c
 create mode 100644 rust/kernel/cpu.rs
 create mode 100644 rust/kernel/io/poll.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 9565485a1a54..16d256897ccb 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -14,6 +14,7 @@
 #include "cred.c"
 #include "device.c"
 #include "err.c"
+#include "kernel.c"
 #include "fs.c"
 #include "io.c"
 #include "jump_label.c"
diff --git a/rust/helpers/kernel.c b/rust/helpers/kernel.c
new file mode 100644
index 000000000000..f04c04d4cc4f
--- /dev/null
+++ b/rust/helpers/kernel.c
@@ -0,0 +1,18 @@
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
+
+void rust_helper_might_resched(void)
+{
+	might_resched();
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
index d4a73e52e3ee..be63742f517b 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -7,6 +7,8 @@
 use crate::error::{code::EINVAL, Result};
 use crate::{bindings, build_assert};
 
+pub mod poll;
+
 /// Raw representation of an MMIO region.
 ///
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
new file mode 100644
index 000000000000..5977b2082cc6
--- /dev/null
+++ b/rust/kernel/io/poll.rs
@@ -0,0 +1,120 @@
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
+/// Polls periodically until a condition is met or a timeout is reached.
+///
+/// The function repeatedly executes the given operation `op` closure and
+/// checks its result using the condition closure `cond`.
+/// If `cond` returns `true`, the function returns successfully with the result of `op`.
+/// Otherwise, it waits for a duration specified by `sleep_delta`
+/// before executing `op` again.
+/// This process continues until either `cond` returns `true` or the timeout,
+/// specified by `timeout_delta`, is reached. If `timeout_delta` is `None`,
+/// polling continues indefinitely until `cond` evaluates to `true` or an error occurs.
+///
+/// # Examples
+///
+/// ```rust,ignore
+/// fn wait_for_hardware(dev: &mut Device) -> Result<()> {
+///     // The `op` closure reads the value of a specific status register.
+///     let op = || -> Result<u16> { dev.read_ready_register() };
+///
+///     // The `cond` closure takes a reference to the value returned by `op`
+///     // and checks whether the hardware is ready.
+///     let cond = |val: &u16| *val == HW_READY;
+///
+///     match read_poll_timeout(op, cond, Delta::from_millis(50), Some(Delta::from_secs(3))) {
+///         Ok(_) => {
+///             // The hardware is ready. The returned value of the `op`` closure isn't used.
+///             Ok(())
+///         }
+///         Err(e) => Err(e),
+///     }
+/// }
+/// ```
+///
+/// ```rust
+/// use kernel::io::poll::read_poll_timeout;
+/// use kernel::time::Delta;
+/// use kernel::sync::{SpinLock, new_spinlock};
+///
+/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
+/// let g = lock.lock();
+/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Some(Delta::from_micros(42)));
+/// drop(g);
+///
+/// # Ok::<(), Error>(())
+/// ```
+#[track_caller]
+pub fn read_poll_timeout<Op, Cond, T>(
+    mut op: Op,
+    mut cond: Cond,
+    sleep_delta: Delta,
+    timeout_delta: Option<Delta>,
+) -> Result<T>
+where
+    Op: FnMut() -> Result<T>,
+    Cond: FnMut(&T) -> bool,
+{
+    let start = Instant::now();
+    let sleep = !sleep_delta.is_zero();
+
+    if sleep {
+        might_sleep();
+    }
+
+    loop {
+        let val = op()?;
+        if cond(&val) {
+            // Unlike the C version, we immediately return.
+            // We know the condition is met so we don't need to check again.
+            return Ok(val);
+        }
+        if let Some(timeout_delta) = timeout_delta {
+            if start.elapsed() > timeout_delta {
+                // Unlike the C version, we immediately return.
+                // We have just called `op()` so we don't need to call it again.
+                return Err(ETIMEDOUT);
+            }
+        }
+        if sleep {
+            fsleep(sleep_delta);
+        }
+        // fsleep() could be busy-wait loop so we always call cpu_relax().
+        cpu_relax();
+    }
+}
+
+/// Annotation for functions that can sleep.
+///
+/// Equivalent to the C side [`might_sleep()`], this function serves as
+/// a debugging aid and a potential scheduling point.
+///
+/// This function can only be used in a nonatomic context.
+#[track_caller]
+fn might_sleep() {
+    #[cfg(CONFIG_DEBUG_ATOMIC_SLEEP)]
+    {
+        let loc = core::panic::Location::caller();
+        // SAFETY: FFI call.
+        unsafe {
+            crate::bindings::__might_sleep_precision(
+                loc.file().as_ptr().cast(),
+                loc.file().len() as i32,
+                loc.line() as i32,
+            )
+        }
+    }
+
+    // SAFETY: FFI call.
+    unsafe { crate::bindings::might_resched() }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 496ed32b0911..415c500212dd 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -40,6 +40,7 @@
 pub mod block;
 #[doc(hidden)]
 pub mod build_assert;
+pub mod cpu;
 pub mod cred;
 pub mod device;
 pub mod device_id;
-- 
2.43.0


