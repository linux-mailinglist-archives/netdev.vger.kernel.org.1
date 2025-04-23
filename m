Return-Path: <netdev+bounces-185266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2B2A998D1
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 21:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC65C920D6C
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 19:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29C52951D9;
	Wed, 23 Apr 2025 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnBp6MBp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3C62951D1;
	Wed, 23 Apr 2025 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437327; cv=none; b=WlcfIWuD5KuaXSjMprAzxMuIsb+glakRBpal5YCd86+HYSAEzqJ1lyJ75LutmzLk455SUzRboiEjIzJg1Z9EJovnipiS7pck+DYvFbL2uFXatZbV6BcP0MKN8DyMNacdqddx1Tw/9v7Ai+WYbQSTQ1Tlgp7DEbxu1K+JfzQaOnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437327; c=relaxed/simple;
	bh=62953lUYcscfyKpi4wPHSBLgcF5DMXPINCP9WoEw6jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmwgJObtYr0vxEElc1z3gytANntyvDE6YskARVk00shjyPs5hL5j945vZuZb4rngj664NqVdJNKRZJaNYLvlVrwmQwwlYq0itK1ZD4jqBtyEolw+nl3qr8n7JLEnigysSynjMubAfVzqW5pVcdjtL2c43ajxiCRmP9tUwzwTNHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnBp6MBp; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso184504a12.2;
        Wed, 23 Apr 2025 12:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745437325; x=1746042125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxUSMecqDIlfO6VWAeWQR2Ldtj/17E7F317+qGMycb8=;
        b=UnBp6MBpF+7OAwEDD91rekrBJ+sn/3XgdgVbjdxBtht/G9/ae2TKW9CeTTB9LQtDgE
         a4yU4IrQCsw63/Vxh0mdkPz7OGG23Ynt+xczAKoYfrRNrZ8GTxTBBVMbwN4WgE4pkDC2
         AgPV8KXR/NZzSQCPCVrV5i1xkio2vQl+CL3YJIB1Ruirgg8UeT9GU0RbfiHn9qLWbFVx
         5aJfl8LMpH6e4NY0Xf2qmLVKn3KixMCa2J8VXQiP+Y3KviI9f2Vh+YaEac91a1BTkWJS
         fAq12cK1IA1jPpl4evsoWA/zxeblSH0yBIYAzZM80fdsHmasiLJv9nIHeB0fKEueDZ1M
         oiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745437325; x=1746042125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxUSMecqDIlfO6VWAeWQR2Ldtj/17E7F317+qGMycb8=;
        b=C5+oe1CmxFAmZtWdLU3KJsjfIceafkFubSC5aPjJYbyCPaLB3rlH3EtmhoAFlXPsEM
         RpHWigBFaTl/PcQ/Q3AqSxFFdhX5bJSsOQIsuqaklgEuuWq384zpKpFPIc7YNCfQCEQY
         S1xL/G0otzu8fhiYPY+lIR9b5tQUfgUHLe+SWuV+3hCFQilYpAUTZNbpyES2GclXm84e
         qmmqaTqX/9rqic2WI49pTvDUghVeeSNIR6mhzqUrQjoEWuHqG+8gld3psAPrcRG5uvBb
         27YSxmNfRUsZrE0CXkiwOXyRU25dlhG2b2y9JRR2GyEKaCIrH9N8/LwFKuWBZjg5falN
         DTwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQcqXl6+qpMdqd/cl9w+eyywIapZXCDiup9Xh2ODJ5qM7pFG3DXDtK30AqiVgr4PZpMjaxAEpBTwxg56c=@vger.kernel.org, AJvYcCXe9ki124EhvNeaeNAGS2Rt9HIK7AXzHWaigt507vgyt0Km65nOqJuq88qfI4f1Gndl6t5r+Ktk@vger.kernel.org
X-Gm-Message-State: AOJu0YzWnn+JkH/Ve8wNS8AKaPl2S7jymdKMcxvYTq0fX4+7prHei05d
	zoOF46KgEoxQ+3Yl/Yd6KmDimQ3efQq810Plr7KXOH+vw0JRz531WN/OElbg
X-Gm-Gg: ASbGncs7TPH4M1kWXcUsuBmjdi0VFMHZoisRtIoybmcZjLihAGF56JfaDaqpDUUlpHn
	E2NehhgGXotkN9qEEeMrKDCXhdVI2pqUZ5bxzn+7WNvwv3PcGWp0aGX5PkRKBkuJ7ARkxtPaU72
	JJx7hOzuInw1E9Viod1/Dw59hz+VtTWg6Ylv5QkvXYBVW0bqZpQrPgeya2Oq7m3MJH86X67ydEg
	0ZYjm56JRD16JAZ1qwyiFqIFI8hoCzKm5oj8+9H0hyCwMegf3KCH+pRQiHajMDL8mirB9FKpqzn
	DklR5X5KhkRpaHlaAidDAC5vFcOBQ4E32IsspbA4LzstWjCP9IPgki8zt11dhzSy0s8KfDB6JSh
	zWQBvAR87vYkoAPygPA==
X-Google-Smtp-Source: AGHT+IHTEvY9l8Uobq5zmPuTQKQt3tM0kqdxOkWm7RnrCRSPC0sPKAtkt3F/M3fIZ33NGxGb4i75Rg==
X-Received: by 2002:a17:90a:d648:b0:2ff:58b8:5c46 with SMTP id 98e67ed59e1d1-309ed271080mr82543a91.8.1745437325262;
        Wed, 23 Apr 2025 12:42:05 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309df9ef918sm2056475a91.7.2025.04.23.12.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:42:04 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Fiona Behrens <me@kloenk.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
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
	david.laight.linux@gmail.com,
	boqun.feng@gmail.com
Subject: [PATCH v15 5/6] rust: time: Add wrapper for fsleep() function
Date: Thu, 24 Apr 2025 04:28:55 +0900
Message-ID: <20250423192857.199712-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423192857.199712-1-fujita.tomonori@gmail.com>
References: <20250423192857.199712-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a wrapper for fsleep(), flexible sleep functions in
include/linux/delay.h which typically deals with hardware delays.

The kernel supports several sleep functions to handle various lengths
of delay. This adds fsleep(), automatically chooses the best sleep
method based on a duration.

sleep functions including fsleep() belongs to TIMERS, not
TIMEKEEPING. They are maintained separately. rust/kernel/time.rs is an
abstraction for TIMEKEEPING. To make Rust abstractions match the C
side, add rust/kernel/time/delay.rs for this wrapper.

fsleep() can only be used in a nonatomic context. This requirement is
not checked by these abstractions, but it is intended that klint [1]
or a similar tool will be used to check it in the future.

Link: https://rust-for-linux.com/klint [1]
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/helpers.c    |  1 +
 rust/helpers/time.c       |  8 +++++++
 rust/kernel/time.rs       |  1 +
 rust/kernel/time/delay.rs | 49 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/time/delay.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index e1c21eba9b15..48143cdd26b3 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -33,6 +33,7 @@
 #include "spinlock.c"
 #include "sync.c"
 #include "task.c"
+#include "time.c"
 #include "uaccess.c"
 #include "vmalloc.c"
 #include "wait.c"
diff --git a/rust/helpers/time.c b/rust/helpers/time.c
new file mode 100644
index 000000000000..7ae64ad8141d
--- /dev/null
+++ b/rust/helpers/time.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/delay.h>
+
+void rust_helper_fsleep(unsigned long usecs)
+{
+	fsleep(usecs);
+}
diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index a8089a98da9e..863385905029 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -24,6 +24,7 @@
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
+pub mod delay;
 pub mod hrtimer;
 
 /// The number of nanoseconds per microsecond.
diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
new file mode 100644
index 000000000000..02b8731433c7
--- /dev/null
+++ b/rust/kernel/time/delay.rs
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Delay and sleep primitives.
+//!
+//! This module contains the kernel APIs related to delay and sleep that
+//! have been ported or wrapped for usage by Rust code in the kernel.
+//!
+//! C header: [`include/linux/delay.h`](srctree/include/linux/delay.h).
+
+use super::Delta;
+use crate::ffi::c_ulong;
+
+/// Sleeps for a given duration at least.
+///
+/// Equivalent to the C side [`fsleep()`], flexible sleep function,
+/// which automatically chooses the best sleep method based on a duration.
+///
+/// `delta` must be within `[0, i32::MAX]` microseconds;
+/// otherwise, it is erroneous behavior. That is, it is considered a bug
+/// to call this function with an out-of-range value, in which case the function
+/// will sleep for at least the maximum value in the range and may warn
+/// in the future.
+///
+/// The behavior above differs from the C side [`fsleep()`] for which out-of-range
+/// values mean "infinite timeout" instead.
+///
+/// This function can only be used in a nonatomic context.
+///
+/// [`fsleep`]: https://docs.kernel.org/timers/delay_sleep_functions.html#c.fsleep
+pub fn fsleep(delta: Delta) {
+    // The maximum value is set to `i32::MAX` microseconds to prevent integer
+    // overflow inside fsleep, which could lead to unintentional infinite sleep.
+    const MAX_DELTA: Delta = Delta::from_micros(i32::MAX as i64);
+
+    let delta = if (Delta::ZERO..=MAX_DELTA).contains(&delta) {
+        delta
+    } else {
+        // TODO: Add WARN_ONCE() when it's supported.
+        MAX_DELTA
+    };
+
+    // SAFETY: It is always safe to call `fsleep()` with any duration.
+    unsafe {
+        // Convert the duration to microseconds and round up to preserve
+        // the guarantee; `fsleep()` sleeps for at least the provided duration,
+        // but that it may sleep for longer under some circumstances.
+        bindings::fsleep(delta.as_micros_ceil() as c_ulong)
+    }
+}
-- 
2.43.0


