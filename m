Return-Path: <netdev+bounces-184684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19571A96D8C
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472F816DE71
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B710028A419;
	Tue, 22 Apr 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5Jw5g/l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F21827D780;
	Tue, 22 Apr 2025 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330115; cv=none; b=lb/I6L5Z89VIAAwwotF3GVjxCFtdrkSzWfUeczLmOB2IvLUaxK10Mo8hsGbCCqN2fNviLJieEkvCmDu1+stez6m4Lt4kbsOpXgI8pvum/CxZHprUIYi+Kram38+nvNhjk2Jyz9BHVmMoC3WM+gzSk0lRL4KKOPjB+8EVRxs8KCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330115; c=relaxed/simple;
	bh=62953lUYcscfyKpi4wPHSBLgcF5DMXPINCP9WoEw6jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5BSJxwG+ZRVhtdzXK64vWt3qVrSqdYYQYKTwpLK/pmL7PA2uRarKIbE0NGNJEbRmIYMXsIvdSMxI5gcLt579vBUqdU9HuflHdtybbNTDWs+ir1mM9f5ljK2VOe4qZJDFtwTUshDPZdPUDH1k012edLt2jGkvUPH/X1uJuMoets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5Jw5g/l; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736c277331eso5390536b3a.1;
        Tue, 22 Apr 2025 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745330113; x=1745934913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxUSMecqDIlfO6VWAeWQR2Ldtj/17E7F317+qGMycb8=;
        b=g5Jw5g/lnNgefWNyBVikXvAxzhqkqv4K+U/+xYn5uhDcu0hf3oFiUkogPkOOrELuCJ
         LmsQaxD3zHdyF1P350w71Wqm1Go5shYYwgo4/wGrb44x7ss2af8em6EWrloJuRPl6shB
         RzgTnQxgEreAKkwc9dLQNJW8JOP6FXYXwbZOj5uPFTe7u9G2L4CkJwFO/kCG5+ptwnvU
         0cqGyQaKyLNurnTAbXvWdS0i2U9H1dt8uS71GM5dQzEiEp8Vs2PXKk/T9CyemVUy+zky
         BX+vSYgFdmOGxxLjrALTdyVI13+jOhbJ9U6F/pr+cZaLfRfE+DFTlIdVJ6maRhAEGg47
         UhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330113; x=1745934913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxUSMecqDIlfO6VWAeWQR2Ldtj/17E7F317+qGMycb8=;
        b=t2O6qvBoaBTsECktir05cc9IeEm5imC2oFWJvUq/Zy4/zhmee/YygDdtWJR39XV9xD
         /S6eut1TWY5O22H7J58wLGnMsbKM/bT78wpFBvTKXgk8W06qbdwJgXP6h+6plUJiso0G
         qgHJTXWqWIvGBrLjhwYTFMPY/dsfrn7ItjZWRMOuekwWZZdwHAOWykiOI7r+pi/ZmNfr
         SSIh//9FQnkAhS+zSXdK0vU4hL1GJz/5C3z+NxGLT3zh0h+Vcjawgd0I2F4p1FsfU1gF
         NqinawhwRMtnIB3ex1rZWdbVhjNturpwqtmV8Tp+49Vi+GMZZwIkMWuDw0g7KNwdXgbw
         GpaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu0souSpngfuRp0TMUmLbSnwEq4+/kobdOL8bvVUCpucMO37lmpUDE4Vqn4ADvSGOv/qoGN9U3@vger.kernel.org, AJvYcCWyNzAj1cdT8qf9ScVPVPmYMQr965+4VM5LzuaIMAt3415+vt1a/xFt1NePUVom/ZzLXas9WSwD2NuDWgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwBPWmsTqPlzkYQGfkt4PP5I2iyRBa0gW/l4YiZuhFqiHg+Dm
	a+zZGMyUvRlDo0rUbohNvXYuE+iZ2IoqwmCM/PyiKgtiT3zLg5LpZs34c55l
X-Gm-Gg: ASbGnct88SSbLWxF2HHtSHEZBGXZ1Pv7C/fAjr1ylZ7Fs9pjoaaluSfnDa6wUwIAY6a
	C251SRKZxdUq/CliTFgTHa8LuQi5HERIVGYKeIdSCj/+kyYhDVkJqm4ZSSsGq9fStGeEs/N77Qs
	5Mos+loSCQX9xeJTZjjepPICrszDfSpXWnY1KewlzuRxVrZYFpAInzvmqdf9bLuYPSkii+6YIry
	b4kWyY6BDuDeelPv/Rp6RaRZlTnTk0j1A5jShOaTQw15Y42uTesjxDiRdsLylt10j9VHpmspmu8
	Q/favszP13bKtWMHpuCWsH0WMS+L/G2WX0uL9HLlw7M0NAAgke0Uj28F2iM+z7gSnClGq/g0nEI
	zn+e3M8YqUOPtGMdoxQ==
X-Google-Smtp-Source: AGHT+IGBsDdgg35veGgRti7dLSEh09UHcYWLLSDz9lQqfPNfNrRiKTle8KsKkaRncK8uq5OIMjjOCQ==
X-Received: by 2002:a62:e315:0:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-73dbe601c10mr19516830b3a.9.1745330112991;
        Tue, 22 Apr 2025 06:55:12 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaaba76sm8869650b3a.143.2025.04.22.06.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:55:12 -0700 (PDT)
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
	david.laight.linux@gmail.com
Subject: [PATCH v14 5/6] rust: time: Add wrapper for fsleep() function
Date: Tue, 22 Apr 2025 22:53:34 +0900
Message-ID: <20250422135336.194579-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422135336.194579-1-fujita.tomonori@gmail.com>
References: <20250422135336.194579-1-fujita.tomonori@gmail.com>
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


