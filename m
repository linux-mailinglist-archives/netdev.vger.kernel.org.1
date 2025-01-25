Return-Path: <netdev+bounces-160918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF80A1C2B8
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 11:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8BC188A9BD
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 10:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18752080CB;
	Sat, 25 Jan 2025 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR19NQsc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2752B20767A;
	Sat, 25 Jan 2025 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737800438; cv=none; b=kbX0VjPCrv+3D0Dt1+urA+zvDb1mEkUelwkNO2W+B5rm6ChU4SY1twLHNlJj5/TA1HNWtr5Zz3DIvd6FGnJ+Joxnd+yO/NIBkT4yDi/QGmNJh1WUTenQ/GmGRSrzvrWHpfii9SvzdHkGKnEhzQipsOabw/x6ZwZG6ubY28PKKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737800438; c=relaxed/simple;
	bh=ReVL26aH6p26mZ26kw6xQ9IoO9iV2Bv4A9ApO1HmIo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMQMbkYqk7CsqTVurOUncsyr7V4Z+UK7BgwZFvckwEYbP3o/iBpbaN64wMFT9gblwzIYPLECTJY0V6IAdM5phExombDANqWaGlIpvXYQn+2c72pG2MtEGiypoBmyy4SX8BpCkTmLMWh/WQAUx3m2gFJDStJMKqez60zbIGFy5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VR19NQsc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21c2f1b610dso66426005ad.0;
        Sat, 25 Jan 2025 02:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737800436; x=1738405236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkbKHzExAW0fQ/U6FarCKCDLHrJfi9LS3u9zqTKNql4=;
        b=VR19NQscUgDSySJLDcxXhxKZ+ud4uHhd1efcQCOY4lBCpD6ZgZXFBcpVWyibPeCKn+
         zPBYbJZYXZrv4jrIHLq+UbSIfSeevRgPyIMChKLUbxpQdm//cjhgjqn6HMM9SITYm7ga
         P1AMpt5W95HndaLH9uYsVPblCW1Tfj5f2YLkYgG4iPHIjdO67jJpXua6WQIJd3HAf5zT
         Y/5zj1FdSnaDr/+9b+t7L0P3Na58hWBHZNogpt1n46BDkn8Sx/tbp3oPECMtv4I5xtTI
         TtCtVq+sDhxDSKhUnzbZnSI2bBptuUHaAI0TI4AKtQDLsP4w/zA/Xp3uUew7tjs5EBki
         PA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737800436; x=1738405236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkbKHzExAW0fQ/U6FarCKCDLHrJfi9LS3u9zqTKNql4=;
        b=W+N2+tzsJeuY3j0J8DgmkYLpSgB6OCzV8RhBlvZ45j0+fPU0QoYU68V9sdLM7GssJC
         v0M87kjh/kKeL7frwBdvNpxOkxO2eqsFrW+U9YxG61nrFXmO5xc2d72T62DOTwzluRpa
         VtCbUK3x7h2GCRkQtXvc5Mc2IyC8WRjAn7tT239yQXL3VAP1oyAeK8Wj9JkVwiZSoSad
         0kThvcFAPXYAkCmY9mQiy/EY7Pe68YVZRRB5OrRCIfl9vzn8UMI/p3wO56CZtSgA1rEF
         qAR3UAaX5QfEs8VtwcBxRS3sPo8DO1GKLDDHI3Qd2vpssJBRghujZH1Zn600hqUcFcQT
         vgHw==
X-Forwarded-Encrypted: i=1; AJvYcCX5Ltfxho6wUwHVZPJdtuJRn9E43bMCWP9BABa6fXguIblfG/liVJ+mbS4wmZrX26B7LmQycwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9rOa/32VdxqhfBHzThLc650JrXCaFjotPdkoP+G2DNjpFIQI+
	BqSYeHklgC3E6/9d/b7M1oqJOY/57hR09CGWikW6UxVPzTW0UN8qVSp8ChUg
X-Gm-Gg: ASbGncvGL8V1uGUVCx2cAqyre6daH+/KWIVcIwf8ZwFB8FBbO/AvO1wdh3a3IUh8Ult
	JbnBvfOD5CBdT59R437aISArV29ACCdocRjnsXYmSkdpnMm99UJa/YqMsJU02wUDOkLuPPge3/0
	eMJ6l25h8vg2tOWtmzv/K2o5oNyhDmVVbmLC54IG9mSeCQYBy6W3rhP4JvLu6GWc1rKPESK8MXH
	5wwhLzsQTjqHkiQTgx0Q7LZUJpT8jMjP5ycAadwRd7lXJrrtHntZ+sc5bZx5Pc2DIOYddjmEBSZ
	MQVntprOxWRwxd9nByynccXnAwaHnG4XbEcgHIlgoa3F0IP7jrvDphmw5bS6GVew9MQ=
X-Google-Smtp-Source: AGHT+IEL+mIPaebwamtGa27uOdF/FkrLTiTyKWZitH97Ao290Y78qu2TxCJGyzVQKtvEHrrkvpoxmg==
X-Received: by 2002:a17:902:ea10:b0:216:4e9f:4ec9 with SMTP id d9443c01a7336-21c355c2906mr536597425ad.38.1737800436067;
        Sat, 25 Jan 2025 02:20:36 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424f344sm29461155ad.232.2025.01.25.02.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 02:20:35 -0800 (PST)
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
Subject: [PATCH v9 5/8] rust: time: Add wrapper for fsleep() function
Date: Sat, 25 Jan 2025 19:18:50 +0900
Message-ID: <20250125101854.112261-6-fujita.tomonori@gmail.com>
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
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/helpers.c    |  1 +
 rust/helpers/time.c       |  8 +++++++
 rust/kernel/time.rs       |  2 ++
 rust/kernel/time/delay.rs | 49 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/time/delay.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index dcf827a61b52..d16aeda7a558 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -26,6 +26,7 @@
 #include "slab.c"
 #include "spinlock.c"
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
index d64a05a4f4d1..eeb0f6a7e5d4 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -24,6 +24,8 @@
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
+pub mod delay;
+
 /// The number of nanoseconds per microsecond.
 pub const NSEC_PER_USEC: i64 = bindings::NSEC_PER_USEC as i64;
 
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


