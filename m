Return-Path: <netdev+bounces-163988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0359DA2C3AC
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE7916B29A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D46D1F892E;
	Fri,  7 Feb 2025 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uxe451xQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFAD1F8AC5;
	Fri,  7 Feb 2025 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935142; cv=none; b=ZdYAjZZUWg8nbKx+3gxTpgSo4CqPrMP6lGoxrgB36gzLCm9idfNSqrWyQ2IJmxU5zQuRvUeBs7glFRVs8ZHhPZ3Hn2sUeOG3vKqiDD2S1yzNfNDHd252AGQIPA4YHHIP5pu3PuIYAd4KY6f2lEjlkTnjP047tdrwu7e1nK2ol08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935142; c=relaxed/simple;
	bh=v0/zs/7L8bwSFmjJxmLHdRbKmb6DzaP8vuBcY/3qOd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cY6qCBIlUXlO3mBL1cI7F2rY5qVFHaHhhU4ouwbV0aK9RIAM3LKMn7/piP/CvnCFXGt/9S3dVll0KuXvMs8TstEc3IwhFN7+6r8DWRTcXioXw3B9ynbPgTRwuPgUq0T/lQGkGEERSqXJW7tWjkHDfRi2vGtJwgB3QSp1O0D/U3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uxe451xQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fa286ea7e8so890167a91.2;
        Fri, 07 Feb 2025 05:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738935139; x=1739539939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/CQPGUILpT2aVlfr51p5lQWXt1hrLdHEOmb9TvWFrc=;
        b=Uxe451xQrhoeKn6KhxXzGbGhMNL3zjkPjtGMIA5tLjmGOQBZpioRtLwqL7vAbLaRlm
         sqt9gMEf3kCGnfoOF2U9LOkoax0lMyz7a+GahZRLpv0lXUXTwK4y5wlnVtJfXgIXvTk4
         zp/kN1RIiqq/Xh44VYtdL1gSMY5ryLoGUVjT8xPvxqlQ6K+nD44jgJU3QL2+WM52Gb8n
         pH47t9umD6KxPvXJ7ZPa16/sVjhDpyxhmgME3g3BasrlT/Ep5Pz100wrMHa6X8L1mmph
         XTRtRAefyOpXIYJJBuNYnBgmbHViY9DRws86BbjmaSDWQB2m1BM7rTuHQprtcpXzFXT5
         rBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738935139; x=1739539939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/CQPGUILpT2aVlfr51p5lQWXt1hrLdHEOmb9TvWFrc=;
        b=uMKkAhgHLjc2r4m9c0sYsKrrIJsT5ChI7L4/y64di/L4OrByQ7uDlgCbW9QKsjnbYd
         9yKVLiUfzdz9EeN1u6IYOmyi3Bi3QgHj5UOX98CtKztDpRZFAfV4zxf7jq/gK73N11AR
         ECZeSruKDr+8tQbDy0YuMm8Ib8z8pL/neSEHUgbJqHWUR3VnrkGtfbigP9YJEwHHcRyU
         d59dEhad7zpjlqN7cv0ujY2+CUo5Rp82KE8xtiau1hmDdfLPcFtGIyczppkCjlR03GCC
         HBENljF1zoAubDqv3A7mx7mzHwX0yT2wKLF1F8veaKgxcoec979pXAWURflXs7Y0ZiKu
         yTMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSlJC9GTsWkT1MzarDetkIt7soAIVeekZYC74vNEHOyj3MFvupPm2lUcoGq7DMGL3xIxKgcXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkdlGpRWo4i4p0FomAn8kgaLcq/l2mCyLwU/ZFj4Mg8p6D7DFm
	JhLad6Q4IsrSTzKG2EvGcn8ybcp5h+56WI3E6fUr3048GWaJ03zrF+X8aSo7
X-Gm-Gg: ASbGnctXvJwWLKlZXlvuDvppu5KQUKtYcQL4PCYHZM7gh8EKb54p4uqTqEEi2HZOCXv
	+09xzF2Q48ps/U+L9O8W5P+aext6lcMRW6hLGNk2M0b3xMMdB2PAVGLQ94Uh9knIXgDEFV6EgcA
	YnxKQIodpY6OZcQxzBSh0EvotdHGzrbxgI3WDcq2wC9o7P3VzZpcJOrrjxgqdzNIdZyhrCa38Do
	XUrGfFUhBti/kIDw1MAf1ahgRVJ8bPdtU6FbI0wBUolum049ILUK9DTJgL4KQqpNvAYStjcC4+a
	U3bgMdeeuRUJk+WsGdx3YFHvs9VWePy46TavOS+AQnV2og+/PUnvQcwNE/E5xr8MuZo=
X-Google-Smtp-Source: AGHT+IHgviYp4+ArDLcILpmI3kJBYqbvyXTD6Y0du8v7EkUsIDf6r1GVgzuDg4DXX4ibVkBWm6q+5g==
X-Received: by 2002:aa7:88cb:0:b0:72f:d7ce:500f with SMTP id d2e1a72fcca58-7305d525eb4mr5269278b3a.21.1738935139220;
        Fri, 07 Feb 2025 05:32:19 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51ea79a47sm2877843a12.76.2025.02.07.05.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:32:18 -0800 (PST)
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
	tgunders@redhat.com,
	me@kloenk.dev
Subject: [PATCH v10 7/8] rust: Add read_poll_timeout functions
Date: Fri,  7 Feb 2025 22:26:22 +0900
Message-ID: <20250207132623.168854-8-fujita.tomonori@gmail.com>
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
 rust/kernel/io.rs      |  2 ++
 rust/kernel/io/poll.rs | 78 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |  1 +
 7 files changed, 109 insertions(+)
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
index 000000000000..bed5b693402e
--- /dev/null
+++ b/rust/kernel/io/poll.rs
@@ -0,0 +1,78 @@
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


