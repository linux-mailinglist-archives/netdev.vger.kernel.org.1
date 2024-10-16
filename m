Return-Path: <netdev+bounces-136027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B10E99FFCB
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D751C24462
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673C918C90D;
	Wed, 16 Oct 2024 03:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwCHxMAs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B698718CC08;
	Wed, 16 Oct 2024 03:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050848; cv=none; b=tGnq4qpuDi23p0r0Jz5VRlV6SCdcxtZa+3Uma4vRoQOdPpUWYbo+J8/nNSmZ1T/exyUFzIDh8mluWunu1F8TpCICL+oaVJBYLarQL50HwDcggrmbhAHC0JJRpfjh1fVCOW7ravkmqOfdNf3HEd1AqOYedruKUNZnjMDfZGWmJEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050848; c=relaxed/simple;
	bh=GCzvw7ibLiDxSGnzi/RvsU+Em4kHjqiyYpGXRBJyP3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbYgR6kNjTM0Yfep8E4uHWY+MKEyZaOilr39PPauUAkK1GVKiknL0ce0/lNg4QoG8WczNn3ThecQeYRFvV3/UXuPPF9rI67w8BzuZxdMXtjjkSTT55bRhoOJu76RyERSlLJOAjybHkV5IsnDT+2FqCjm0c1+wgaGm+XtJbKY9zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwCHxMAs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2bd347124so4062111a91.1;
        Tue, 15 Oct 2024 20:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729050846; x=1729655646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewjM75y6/WI7rdufDQw0McoVQ3kSSWYYvv4Agerd34c=;
        b=YwCHxMAsGDwc1xKQ6tYWEy/7DQ/5xRseRZDRwkwQ7UHKqGtwM24d9NrL/En5DYpArT
         yk8odAjhd2ki0DtxmbQ/STymtxWLWeXJxn5qJTKmsb1Ebzno6belZ0yO+5VU+rmGPMkZ
         nKIg48uJn7OHmuSFcCENAQH975rm+yVzC5WpODIsCQltf1LSrKEDn+xk/s4vJiQdToED
         S1C/D/fYCdoO40OrpFnk6Jwe4zrJYrJtweg5MinYqCohK1NifhF8E6cJRj4Zoln7+Smg
         OEK4VPoa0+H2WX+OmIaLYnKpPhpq0i7NkfF2tomiWLZJZbYX+VusAkdsPCsqneg+8wI7
         NR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729050846; x=1729655646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewjM75y6/WI7rdufDQw0McoVQ3kSSWYYvv4Agerd34c=;
        b=KUu4267eQYle+fcmnLk5NdrZQacexm3WwLk8mRhjzHdNIRa4cVkf9aDoC2/JCAWd61
         gSxB7j4ijLBwdgoXpKa2KzDwg3JaBmQoHGAkIamXpHAI1ScMxbSKY4jOKy7O8NVQNQ0P
         N5oPncU5KqIdQ1M0LDBUN9WUDj+FEe71mlB/Ev9oUnmHBGaEsJ6asBe6R4W/0LvuMJba
         9Y2TYu4Tr2sxsgycVK2C8mcUQJsouGE82IYeP2h+4cVJXBOZwaCEOrKHGPDKLfc+k33M
         fgVJb8bL97I/lsrQakWgZkvYTCC/LpFtJfbXCBSoBWBgr88g9q129K16bQPZmvqOphOr
         1hAg==
X-Forwarded-Encrypted: i=1; AJvYcCUmrPZL5zsCc/Qtk3/9FDHMbnXFNaK1iosZleIFz7q5CXMfoPmAI37RRlhmM84Hj4FB5k+Ia9foeVvJAgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53kR8b5IBZqr8tQ7HjkNFdLyCmmx/zR/12oPdct6pz5pa1vi5
	TguhbPBv9corfm2zVqUK9Mta5C7CkxzBMz9yvXXlFN8LtPJCAjzj30nM+Ijk
X-Google-Smtp-Source: AGHT+IEFV09BdCjpt0eaoF+ix5VsqcfzYDWe6+Z7ZWqHpTtX/c7nJYEQE3SCOcVBhEKExYGxThv4qg==
X-Received: by 2002:a17:90a:6788:b0:2e2:ac13:6f7 with SMTP id 98e67ed59e1d1-2e3ab7c42cdmr3010451a91.4.1729050845654;
        Tue, 15 Oct 2024 20:54:05 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392ed1a4fsm2885691a91.17.2024.10.15.20.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 20:54:05 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 7/8] rust: Add read_poll_timeout functions
Date: Wed, 16 Oct 2024 12:52:12 +0900
Message-ID: <20241016035214.2229-8-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016035214.2229-1-fujita.tomonori@gmail.com>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
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

For the proper debug info, readx_poll_timeout() is implemented as a
macro.

readx_poll_timeout() can only be used in a nonatomic context. This
requirement is not checked by these abstractions, but it is
intended that klint [1] or a similar tool will be used to check it
in the future.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Link: https://rust-for-linux.com/klint [1]

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/helpers.c |  1 +
 rust/helpers/kernel.c  | 13 +++++++
 rust/kernel/error.rs   |  1 +
 rust/kernel/io.rs      |  5 +++
 rust/kernel/io/poll.rs | 84 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |  1 +
 6 files changed, 105 insertions(+)
 create mode 100644 rust/helpers/kernel.c
 create mode 100644 rust/kernel/io.rs
 create mode 100644 rust/kernel/io/poll.rs

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
index 000000000000..d4bb791f665b
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
+    bindings,
+    error::{code::*, Result},
+    time::{delay::fsleep, Delta, Ktime},
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
+    sleep_before_read: bool,
+) -> Result<T>
+where
+    Op: FnMut() -> Result<T>,
+    Cond: Fn(T) -> bool,
+{
+    let timeout = Ktime::ktime_get() + timeout_delta;
+    let sleep = !sleep_delta.is_zero();
+
+    if sleep_before_read && sleep {
+        fsleep(sleep_delta);
+    }
+
+    let val = loop {
+        let val = op()?;
+        if cond(val) {
+            break val;
+        }
+        if !timeout_delta.is_zero() && Ktime::ktime_get() > timeout {
+            break op()?;
+        }
+        if sleep {
+            fsleep(sleep_delta);
+        }
+        // SAFETY: FFI call.
+        unsafe { bindings::cpu_relax() }
+    };
+
+    if cond(val) {
+        Ok(val)
+    } else {
+        Err(ETIMEDOUT)
+    }
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
+        #[cfg(CONFIG_DEBUG_ATOMIC_SLEEP)]
+        if !$sleep_delta.is_zero() {
+            // SAFETY: FFI call.
+            unsafe {
+                $crate::bindings::__might_sleep(
+                    ::core::file!().as_ptr() as *const i8,
+                    ::core::line!() as i32,
+                )
+            }
+        }
+
+        $crate::io::poll::read_poll_timeout($op, $cond, $sleep_delta, $timeout_delta, false)
+    }};
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b5f4b3ce6b48..d5fd6aeb24ca 100644
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
-- 
2.43.0


