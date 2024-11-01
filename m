Return-Path: <netdev+bounces-140863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118409B8821
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3871281385
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA3113D50A;
	Fri,  1 Nov 2024 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlYeZ7DK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A613B2BB;
	Fri,  1 Nov 2024 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422965; cv=none; b=cnO85QNU2GEsM5s/MJm1V+554eP4vcJOBocsBt0EfY08weVBDuX6A7DKmXohnXogNy2Lv7XYpBb5bf/hyyd1ZwYp0C0a5gwjMlwcjvNwMVsHBdjEjX4DX4phLdWUiJPsGCyuwAiRk9DnWOfCZLpyODPMM5jv/vXo8A1p7jqQEmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422965; c=relaxed/simple;
	bh=uay9p/gCr6OW7dCyCbNlhab+NCYTxQsSdsnFjQ4S6yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zg9sMJHqSbciKrsxHTM0HMZN+hoAg46NVAKAgJUMBVJcxIWOt+LDU6fzdj9g7oy0bmsSaIfqGflOLwk/jJyl/EJkeCyb92P14B2+rNqtu0or32Q5Pfdw/b/KtT2OMYsT4O7s+uzpf/5qs1rwAATzVTPLATkQ70K3xPNKJEwfH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlYeZ7DK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7206304f93aso1321021b3a.0;
        Thu, 31 Oct 2024 18:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730422958; x=1731027758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56yzkoCbHMeW0kr62bZqoBqGxQ1mmiPy9d//hWnafTQ=;
        b=TlYeZ7DK7szPr9xpPV1NQ4KXAgxVBE0yr7Z/X0hPUKyTKEwv7otADS8hGwWdvX53zp
         sZ8iC5edFI7Y0No/8iEs/FDGAo/UY7m9Cu9fgYeUgHPv133hYv0FAWnZ9cFau97TqMp4
         akNgIRP9+jijBvJsrCbWdpyO2rpqLrGmq98+pd+K0IztYFsv672gLmx5WjDDehoY9J0i
         O9EOqCtM/mkiZUnbTbxPYGxBzDOci1uuEoHZ9JEsQ31FWlSIVwpgjQpo/IeVazaaODv0
         bAMXFrVBy7V+nRXJj9V2aCXb4lL/5oFOrbtx69urq4MOJDLbWqMb+QEqzpuQDHSnvqBt
         rlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422958; x=1731027758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56yzkoCbHMeW0kr62bZqoBqGxQ1mmiPy9d//hWnafTQ=;
        b=c/N1H2cIt6mJy0TR8+Y7bs9Vdg1SGkaJKo7Bz7PEY6rFgYG0t5hGci67tR3Y+Peixm
         apjUCQv7sw04nKfJlU/dt0Eox7Yr/WJIvFOwMT2fVxWH5qZqlV3Zm7fDZ+XoPtoC1dQ3
         KNp5NVjwjKbBRgkoUGd0BIuBdnWR+T8zYIywwyR2WVkgwjBTA0Gmzk2RZIDjWsVfQUAl
         jc8LX0wghFFjqPHAKJHQcM21a7CfRnZhCE6fMMR+2xhLrox3KdsPFa9D8W4uDogLe3qt
         ErU/LcRjBtjOHiplwOSrVYw5VfsCYg61Wg/zfquNhIP8FQjqZXB9XB1uELy4d6Fs8sSJ
         c4ug==
X-Forwarded-Encrypted: i=1; AJvYcCVN15pCFOyG8aGPrSKfQGFovJutfUh25Oac/NGuaEujUlUMBRuIYlzaK+5WG8yOjuYITzLxZtFvjcO1yAlRe1c=@vger.kernel.org, AJvYcCWLQtf4jowDPNAAmcG04Izf6kGK3PNQ+a1pFHChJezjcv76pW4H07gePpd/8rya2KSdpKc1iPaoNsMGBPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf7g46JKAJu2q6hQVA/xek8QOM34fxqBx79dOnL3kETFUZeAIr
	CRBv/ZBooRC/CMos3akmpGDdst4LXkF2+AZg11nSazyhGTq971jj
X-Google-Smtp-Source: AGHT+IEtwvME9HaiQrHAqd7RUCTTa2wd36EYhnoVoJiWkZoP6O6JD64TlBq66x+GV/bED9sKGO6yYA==
X-Received: by 2002:a05:6a00:a2a:b0:71d:d2a9:6ebf with SMTP id d2e1a72fcca58-720c98a1c80mr2713938b3a.6.1730422958338;
        Thu, 31 Oct 2024 18:02:38 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ea6a1sm1743403b3a.74.2024.10.31.18.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:02:37 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	jstultz@google.com,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org
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
	arnd@arndb.de
Subject: [PATCH v5 6/7] rust: Add read_poll_timeout functions
Date: Fri,  1 Nov 2024 10:01:20 +0900
Message-ID: <20241101010121.69221-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101010121.69221-1-fujita.tomonori@gmail.com>
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
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

For the proper debug info, readx_poll_timeout() and __might_sleep()
are implemented as a macro. We could implement them as a normal
function if there is a clean way to get a null-terminated string
without allocation from core::panic::Location::file().

readx_poll_timeout() can only be used in a nonatomic context. This
requirement is not checked by these abstractions, but it is
intended that klint [1] or a similar tool will be used to check it
in the future.

Link: https://rust-for-linux.com/klint [1]
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/helpers.c   |  1 +
 rust/helpers/kernel.c    | 13 ++++++
 rust/kernel/error.rs     |  1 +
 rust/kernel/io.rs        |  5 +++
 rust/kernel/io/poll.rs   | 95 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs       |  2 +
 rust/kernel/processor.rs | 13 ++++++
 7 files changed, 130 insertions(+)
 create mode 100644 rust/helpers/kernel.c
 create mode 100644 rust/kernel/io.rs
 create mode 100644 rust/kernel/io/poll.rs
 create mode 100644 rust/kernel/processor.rs

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
index 000000000000..da847059260b
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
+void rust_helper___might_sleep(const char *file, int line)
+{
+	__might_sleep(file, line);
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
index 000000000000..a8caa08f86f2
--- /dev/null
+++ b/rust/kernel/io/poll.rs
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! IO polling.
+//!
+//! C header: [`include/linux/iopoll.h`](srctree/include/linux/iopoll.h).
+
+use crate::{
+    error::{code::*, Result},
+    processor::cpu_relax,
+    time::{delay::fsleep, Delta, Instant},
+};
+
+/// Polls periodically until a condition is met or a timeout is reached.
+///
+/// Public but hidden since it should only be used from public macros.
+#[doc(hidden)]
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
+/// Print debug information if it's called inside atomic sections.
+///
+/// Equivalent to the kernel's [`__might_sleep`].
+#[macro_export]
+macro_rules! __might_sleep {
+    () => {
+        #[cfg(CONFIG_DEBUG_ATOMIC_SLEEP)]
+        // SAFETY: FFI call.
+        unsafe {
+            $crate::bindings::__might_sleep(
+                c_str!(::core::file!()).as_char_ptr(),
+                ::core::line!() as i32,
+            )
+        }
+    };
+}
+
+/// Polls periodically until a condition is met or a timeout is reached.
+///
+/// `op` is called repeatedly until `cond` returns `true` or the timeout is
+///  reached. The return value of `op` is passed to `cond`.
+///
+/// `sleep_delta` is the duration to sleep between calls to `op`.
+/// If `sleep_delta` is less than one microsecond, the function will busy-wait.
+///
+/// `timeout_delta` is the maximum time to wait for `cond` to return `true`.
+///
+/// This macro can only be used in a nonatomic context.
+#[macro_export]
+macro_rules! readx_poll_timeout {
+    ($op:expr, $cond:expr, $sleep_delta:expr, $timeout_delta:expr) => {{
+        if !$sleep_delta.is_zero() {
+            $crate::__might_sleep!();
+        }
+
+        $crate::io::poll::read_poll_timeout($op, $cond, $sleep_delta, $timeout_delta)
+    }};
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 22a3bfa5a9e9..b775fd1c9be0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -35,6 +35,7 @@
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
 pub mod init;
+pub mod io;
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
@@ -44,6 +45,7 @@
 pub mod page;
 pub mod prelude;
 pub mod print;
+pub mod processor;
 pub mod sizes;
 pub mod rbtree;
 mod static_assert;
diff --git a/rust/kernel/processor.rs b/rust/kernel/processor.rs
new file mode 100644
index 000000000000..eeeff4be84fa
--- /dev/null
+++ b/rust/kernel/processor.rs
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
-- 
2.43.0


