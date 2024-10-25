Return-Path: <netdev+bounces-138956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF8B9AF842
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2EC1C2159B
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387361AA7A2;
	Fri, 25 Oct 2024 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz7XP32d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A31ACDF0;
	Fri, 25 Oct 2024 03:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827276; cv=none; b=FqMSCJRWcY9H5ELAbuIqWJIdGN/beYt1rPvEx2Hegle9dTCHkc/4XWW+v49odj/sLbPRPFVffA/m/FsdJz6N/OSlQI3uKlE2haDBzk3D778HB6kcizq6xv9Aj5RD5qtnODI/EGyhF/HkYmAX7PSQJzHOZLXbQ9WJf/5SJBmbgj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827276; c=relaxed/simple;
	bh=pZsVeffyezjeq+ZCP4S1Z1TvMIkWwVO0ML0qhzsHTg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bf4hxavTUwKjbNnJTt543Xm1MA/p0XXuXpp4qt0zSbXVz8u/EAAmYEEoxVotTsqhmCG24qrUzaSdy24QREeecv2yqRQx0F7SepWvg0za2kt2Z3EuwiV0DPACcxZGmmaA0BUPFzCeDQiRwDGBvaYl7b4E6CjuqQPV8tf6i860HsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz7XP32d; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so1152372a12.0;
        Thu, 24 Oct 2024 20:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827273; x=1730432073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1q9ggByLgvF29xNghA+oLeekFn/dFvbYSRczZS/Rr0=;
        b=Nz7XP32dmmFSFZ4i2h7KnfPiYY7l8Z/T5F0YDuXnedc4VFICoBSOdW1gxw/Hbgvgl3
         gDC/sX7P5cbaa1YlgVsP1qpmwlDi4YBI1rjHlJ1GpMbQZ+1HoDQIhxjBCNM3vxA7WhLd
         ze/V0JyI3OfS20D776J6rxhm8AU+qwBU2rydDX8QEvY67CI+uSWC3euJ1v9KAmwpNpEy
         B1BRM72YHmniMvimCuoioSxMSZPFSeNh7GY1eRZaQZmji3kQg3ooxnlspFe8PC1OlfqC
         w6crVx+Z45OeyXnYZUSJK9SyKNz434pjWRZDWkbp/keSbFCXZaWHLAw/HteKFDP8uaF4
         s7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827273; x=1730432073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1q9ggByLgvF29xNghA+oLeekFn/dFvbYSRczZS/Rr0=;
        b=mrBJ1CiEYGoV40J5RIgFNdArzGO4rrJPGr8TRz0qVGDLOJi256ADV40WpFvxBYkocu
         sYclpVzUDZ5R+PVHp1OeqLEQ1BnniBZrmAZPj2kVx10LQvLf6mXEOyAEUmqTQOafi82E
         qbfbOQ1WEuDnRPZNCkHZgj5Z69TSJ1tehJyBcdgXs1A7+t1B32A+gOfodLp8iiXm/zER
         qwtBGn201f+EmYc5b67oIVFT1sshz1jBXdn3QWqD/ykHgUxqy+ogipHR/bVckTmZMHW4
         NyCxzIJAUEOixBmL+F9hIvuktA4m4COonSIaU4jjQg68SR4H5GBNUZ5xEL5Dlxn/r8Sk
         qIlg==
X-Forwarded-Encrypted: i=1; AJvYcCUXMrlhgkxlVSOZsz5ojhDm5MMIC9uYmfNKbEDo63KSjlJB0AR8uKMSghluNRN8PxSMsKSXTWZNaY9j5KQ=@vger.kernel.org, AJvYcCWNZsYu7PX7TAhlbD7ykn6B8gg0vn/f4einP+smBAu1Cf/ORK1mXe5xLiLqlhc6Nga06U9B7r3dBjmWrvCtkYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPSWObFYKFYv/LDwjrRk3tpGygJHJbc+S/Myk/90/wvKLOIL9+
	u1swub5IbrBUFXaRjKoGZbm5PBiRv6Jp34n1yAy1anyOe6XujQif
X-Google-Smtp-Source: AGHT+IGIUPkN+OqnxUUcmRWusqknbhO05BPVVFPbEuKkJIMkAd+D/2fn/uzB7S5maSTcz6zJeA8RPA==
X-Received: by 2002:a05:6a20:db0a:b0:1d9:a9b:28f0 with SMTP id adf61e73a8af0-1d989cc8f66mr5807282637.34.1729827272976;
        Thu, 24 Oct 2024 20:34:32 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791db5fsm180188b3a.11.2024.10.24.20.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:34:32 -0700 (PDT)
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
Subject: [PATCH v4 6/7] rust: Add read_poll_timeout functions
Date: Fri, 25 Oct 2024 12:31:17 +0900
Message-ID: <20241025033118.44452-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025033118.44452-1-fujita.tomonori@gmail.com>
References: <20241025033118.44452-1-fujita.tomonori@gmail.com>
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
 rust/kernel/io/poll.rs   | 93 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs       |  2 +
 rust/kernel/processor.rs | 13 ++++++
 7 files changed, 128 insertions(+)
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
index 000000000000..ef1f38b59fda
--- /dev/null
+++ b/rust/kernel/io/poll.rs
@@ -0,0 +1,93 @@
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
+            // wihout a sleep between? But we follow the C version. op() could
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


