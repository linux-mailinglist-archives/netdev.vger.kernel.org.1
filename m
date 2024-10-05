Return-Path: <netdev+bounces-132368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACB99916C4
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 14:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E641A1F22D9B
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 12:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6C715820C;
	Sat,  5 Oct 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtnKjnjf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65810158543;
	Sat,  5 Oct 2024 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728131197; cv=none; b=jPHLuSbDiENbd8QifnW8UEGtoTFiMQ4SeXn8kC9hxUUSTEBpRU2ZPlCnds1DWqV3Ii3Soy5iYm3nwNMPXrOox7mz+EtK6vASeNd7wTEFQsDBzUVhonfsV3FYWG01w9FapIdV1jgNOyBNGrZQqOVXc/ewPi8JVQDsnmB5nocS6Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728131197; c=relaxed/simple;
	bh=wmifuArjCCTGvjSdMIu1qn48E23mkhTjGw32XsdaHWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhD4tCO8uzWhbYAFarOGeuefGLc37HRsGYIhX6WmgKHHYow7gOcy+VOfaKqrwecCZfK6Q+g8laZ6PJ7lmd2U/Bx9eBqMjjdCfPR4YgpXy6ND6dryiAC1h5TSqryl7IfqtVfo3FeA9SgGCbEqiAYuaKtZNcC9Q1C+d1vf84G8LVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtnKjnjf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718d704704aso2728006b3a.3;
        Sat, 05 Oct 2024 05:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728131194; x=1728735994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ouHlAeMaJ48AE4PPh3HomWVu44dqd04FLhO9b4zhps=;
        b=HtnKjnjfA6aiJvaIgJnW0VhxQrfMb0TBGdWgpQxmKiMP896DMYFkkHcVgcsRAMXcfk
         7Dj6TNstyWDVSLlNGcXasLf0DVqPQvTVURzOsogAXnWWtFUKBOauucuXgB70Gp/QsJBS
         Aa8DADs+Doft7AMkwfHDNHiZXHT+EGlxzxk3CwRJEx7N8CO0rmRrLtCGieTPAivIIj6x
         OmwPngVrh0a6Xbw/lRpAHxLyD/nK5t09T48PKXfjFHVzrN5bkA2mANUGlva/sc77DeAO
         05zqaL0Fczh/HoQz3P2mCyZrTnh3g38y3B3AgUtorG/63C9w2WhBjgW6AnNj7yqDaLlT
         7sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728131194; x=1728735994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ouHlAeMaJ48AE4PPh3HomWVu44dqd04FLhO9b4zhps=;
        b=NwRaQcMmjYCxB591BveVRUL3ZwA35rWS7rl3KJiPhtmqAbktRFhFhsweR6JEPFU6Te
         Rit83u9WEknLZlWVMgFLNNpBD8+nArtHgYr0CixVe9BvvhQxLEO/PBMM4QqlqmagwOk3
         JZQZYoH7jn6xXLbMGTJRO/db/wKVoM5VqUif3dm1TRY3xwmm/OwShnKJbF3Y6P2PCbdy
         DyxHAo5NYl5xhJtTUqnNYkS6loJNRW7g3L1Zo1/rJpfVzVAY1uxfxxjZkm1OPzb9+GNr
         ifn/leQdkTdrWotnz+s5npcBuU3Y3rQLCj7ldbjpUv6JHDAYuLmRnlA2KBx44Kgo+kNO
         xNNg==
X-Forwarded-Encrypted: i=1; AJvYcCUCWOksICo/vmLvV8IT9LcpczppeFKHcP8M3/B7vbRMUOfXpZy7DD0pk/vA7TLDl28ccLjE8imoOdsYwr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7KR47D2kDAG+R4Jb5eHqpBIohDvh3qMjLu85YjsOkFysJmykW
	l8cX9WfZJnV1+46a1SVzWPcs8n696fLpp9CtZ3Cd42s+XqDzpYs/Fl7jZ0KJ
X-Google-Smtp-Source: AGHT+IFsB+9ZpruAyYt2o9loiV34xg9sF7pGzkPdB1Fsmt7tD4LbtvtKfFEblIBhaeWRf6bRrxtyEA==
X-Received: by 2002:a05:6a20:43a0:b0:1d3:293d:4c5a with SMTP id adf61e73a8af0-1d6dfa4278bmr8562405637.22.1728131194349;
        Sat, 05 Oct 2024 05:26:34 -0700 (PDT)
Received: from mew.. (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd08besm1397878b3a.79.2024.10.05.05.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 05:26:34 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Date: Sat,  5 Oct 2024 21:25:30 +0900
Message-ID: <20241005122531.20298-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005122531.20298-1-fujita.tomonori@gmail.com>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add read_poll_timeout function which polls periodically until a
condition is met or a timeout is reached.

C's read_poll_timeout (include/linux/iopoll.h) is a complicated macro
and a simple wrapper for Rust doesn't work. So this implements the
same functionality in Rust.

The C version uses usleep_range() while the Rust version uses
fsleep(), which uses the best sleep method so it works with spans that
usleep_range() doesn't work nicely with.

might_sleep() is called via a wrapper so the __FILE__ and __LINE__
debug info with CONFIG_DEBUG_ATOMIC_SLEEP enabled isn't what we
expect; the wrapper instead of the caller.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/helpers.c |  1 +
 rust/helpers/kernel.c  | 13 ++++++++
 rust/kernel/error.rs   |  1 +
 rust/kernel/io.rs      |  5 +++
 rust/kernel/io/poll.rs | 70 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |  1 +
 6 files changed, 91 insertions(+)
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
index 000000000000..5b9614974c76
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
+void rust_helper_might_sleep(void)
+{
+	might_sleep();
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
index 000000000000..d248a16a7158
--- /dev/null
+++ b/rust/kernel/io/poll.rs
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! IO polling.
+//!
+//! C header: [`include/linux/iopoll.h`](srctree/include/linux/iopoll.h).
+
+use crate::{
+    bindings,
+    error::{code::*, Result},
+    time::{fsleep, Delta, Ktime},
+};
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
+/// If `sleep_before_read` is `true`, the function will sleep for `sleep_delta`
+/// first.
+///
+/// This function can only be used in a nonatomic context.
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
+    let sleep = sleep_delta.as_micros() != 0;
+
+    if sleep {
+        // SAFETY: FFI call.
+        unsafe { bindings::might_sleep() }
+    }
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
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 22a3bfa5a9e9..7b6888723fc4 100644
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
2.34.1


