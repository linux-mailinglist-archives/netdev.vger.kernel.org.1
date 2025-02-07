Return-Path: <netdev+bounces-163986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D50A2C3AB
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B552E3ABD29
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E6214A7D;
	Fri,  7 Feb 2025 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQjcA6c9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318341EEA5D;
	Fri,  7 Feb 2025 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935126; cv=none; b=ARa4wBlz6ySNPmIYm4KI6SozsXetU9+6OQugdVBdEbBkkAzLGoq1c03IJxcRxFWFyzsdBQhDiD6sPiSZz4q4u99DjJmiVLZiuDoqIK85d7NJtjMnKj3geYGJV/Y1saXPspCO3JQMZhhvRoKx8B+QYmU85mpZT4o8AMlXKHZhxac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935126; c=relaxed/simple;
	bh=IjnSjBhWDp3CYU8cRoL5YbolvreL2c5kVU8dJdl02Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psbZpD06AwRkJ2TzqPjJ2cXJ1UZKUmLaldyCIeQ61UDA+dGdAgTLtwjCzU5dBl6rSMqSNT7XGUOLD4+sVVbCioYjcdJH5mTkGeZSvZBwT+gh72moacjHA+Pvf7VXrOoUe043kViFgvxppypwJWHvw6b0EXTsnNns4q0vbTN5lZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQjcA6c9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f6022c2c3so2776305ad.0;
        Fri, 07 Feb 2025 05:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738935124; x=1739539924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rznzjUgjcpczEk+LFFoCxRQeCpFrR9iS17ExxqZ9J80=;
        b=kQjcA6c9gn02RtLz8Z1w5EydkpQdZJSVjMtDtVn+UQuhNXiMq7uIyKTRMPcsr2ndeV
         lJcbqOee3OMPX2W8amRBAIGhS32Mhx1qxsFndqSggItQ7sGutCPryXcFiWctLnOwWo3n
         LjQeY71JFiQUfk+ZOwbTl6SdwxvUPwYnoiu9lYou/GWss7NLqfMTi377Ug+HZoAm8JtO
         b6Poue4BjKbBvAemm+W/BfLYwjlNkYkRi6WB3u9iLcqEkt+cPIuMNg4o/XvSoIxK+MBd
         6mYOtV8Igqnh2Z0QiVhfmyBqxhoFli6OHpQbrlTm5KjQDmNviyj4zmHCBYbkgT2adLbW
         x5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738935124; x=1739539924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rznzjUgjcpczEk+LFFoCxRQeCpFrR9iS17ExxqZ9J80=;
        b=P1ahY5UGdlKs+5Px09vQaudTMM0HW+58D9H2nPtZm7KIuLkvzCkZYzk9qq/yNsqWiU
         pF/eryPFYktw6i2IsSPyhIE0B20Kbdln8aZGCDA1ft0oED+tDEoBKHDpMPhyArzNH3wm
         5tjho6aHz2NNLnDpneMoxsSs8f0kmF4HbbYfedAOuos4e1fCG+CgvjJh8j35njCp34g2
         1rXIhpRvcnDYATpbof8p9mSVQXkHZyZiAfmQGyRG5w6WkLnFLBK3MwC5vhPvgWRelyOQ
         KiSwQ4i3iUbCD5FRtHwfB5e0KlXOSApCxn82lT/2xQ56yf0GaDFsWt2FJn/0TmbBb+/A
         3zqg==
X-Forwarded-Encrypted: i=1; AJvYcCU3wJHf12l4ZYk0KNqF4AXZhQOiDjCXMkdTu0m7xDo4x/F06zKaqCusvjwv//z+aRTMF8doW8I=@vger.kernel.org, AJvYcCWO9KA7iC3Egixkz1OSj4VMw03ColNo18z2EtWx9Yx8CAZ/GgFVoNVaqfZOIHYKAU4gpQTJqHNX4psEOW1ghJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWM3vkDB5lqMKkYSdrM3qkK4jEEq1v2YarKHFqomX3ILBi1JsR
	QeQGKfsBE3U6fHRXEfl33O7nmzw2E6j2ZjYbNGWOTwtvQRyg0rRjz2wa3GPo
X-Gm-Gg: ASbGncsiywPQzXwfXCvSnTixXdB0jOlUTCEV5bdAiQm/5iKyAhVi7SmDjxiBktl/0x4
	U+gNHMLGwwH67kU3Gj8QL+4GCreoGgBiEOy8DjF+QmudEDMhVuPt37vzCKYuAmv/el1H8LdhqXu
	6zb8SaW4tNanAye9aY3/wWyC1y2oxzB/S9RDfEmiu2JUfwfSGF6jSFFzyUzJsWI3A66reeisOCb
	dk7RPoPtAZOgnzJZcUIo/DGuGufR8pXjmLG0PqZilhoLEp1cbMG1/fQer5qVEanBnKjo96LPgdc
	Uap0/C4BgJ6hq3EAT+H2BcSzfH1hlp1/OfIkhbssxIp7Gw2IjCqYy22vsYinC4rWYRA=
X-Google-Smtp-Source: AGHT+IGHAtCViaosKSA5Fy1JfmUfgIKoMml9Skas8g/+z7GuA1L7Uo6D7OiMI7NignqrpBB5wC+bGg==
X-Received: by 2002:a17:902:cf05:b0:21f:58fd:d215 with SMTP id d9443c01a7336-21f58fdd3f8mr26923845ad.11.1738935124031;
        Fri, 07 Feb 2025 05:32:04 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51ea79a47sm2877843a12.76.2025.02.07.05.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:32:03 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Fiona Behrens <me@kloenk.dev>,
	rust-for-linux@vger.kernel.org,
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
	tgunders@redhat.com
Subject: [PATCH v10 5/8] rust: time: Add wrapper for fsleep() function
Date: Fri,  7 Feb 2025 22:26:20 +0900
Message-ID: <20250207132623.168854-6-fujita.tomonori@gmail.com>
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
index 0640b7e115be..9565485a1a54 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -31,6 +31,7 @@
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


