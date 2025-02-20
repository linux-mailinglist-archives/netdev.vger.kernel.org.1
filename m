Return-Path: <netdev+bounces-168001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6A8A3D1D9
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705531782A4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4914F1E766E;
	Thu, 20 Feb 2025 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNuJvXrb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847361E5729;
	Thu, 20 Feb 2025 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035455; cv=none; b=fD5oUmE+Lj3SaH3XHaZe4zdvTv2yYpLucTos/8Lhdmf1iZ4UXDPMdx9gl6NdoYK6yt+EPwTCY1p9euT4C/N2JvWc3lc2c4cPAhyIBxmDX5k2/xCkYyootDmixJWyKFclgjFmEDxE2wr3xg6EY626kVjqDw5nMNWkYLsiqcBLKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035455; c=relaxed/simple;
	bh=/RRpGKVyayfJ/YcifSTuCj6GHejOlGyYDsd4DuurJ98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJ+h0N+mMKagqwQbtCfL+IEk/VlfnVFCJzkblAaHqrysZoD0ys/OY5Ls8um73LMrqad9Pu0paSO4BMnJvo0fzGS8ltEx6K8wPWNWsHbGat+ML2Up8FoYmPGvX48FSa6b6OacNS/IfPWOPMjP12bT8TQl8w8iRiNN6z0pA4OxpjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNuJvXrb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220e83d65e5so9806705ad.1;
        Wed, 19 Feb 2025 23:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740035452; x=1740640252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nsssdj1VdtbuAV0DR/KXzdfz8e0FeahT0VjJxd+Xp6Q=;
        b=JNuJvXrb4TshnAJzw9CZcNu23BxGRQVBiQgVwZhkYpPsrTRt9d3/NfGy+lec7bOmjg
         mfKPHnAuMf9quJYZYy7cGGHFvERBBxu7u7NxE3WnoZkEEGMNi9kvpq8GayS4y0VkB3jV
         LYW8kyP975y4nRxKP7c2X7TkfAsyZQFLfSaeRVU99dptQI46ftbkT0tI3k6Di3DGnH3P
         L12BQR+P2dAryTgVEeumJ/Hlof3PZ/6TvtcPlYYbh4XlfbOAzPLpo4hqnJhP+d3LVuwr
         Th9deSSaRlL+e8/TDZfUXPNSIGBvj+1LqEmkBZUOMFB1aD0lxG3a+8dHUVkvcDcUowpC
         0Wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740035452; x=1740640252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nsssdj1VdtbuAV0DR/KXzdfz8e0FeahT0VjJxd+Xp6Q=;
        b=vVA//ZodruWN6Pbkgc1zCvxi4U+C1sUVUZ1l8JrT4pjuJhbdqh/Urj+NcuXRiB0uzK
         ArqquxjJxU+bzbSXnkexKI8rXD/+QQ3bbEj5wm9FEh2kRkLxKd/4QZgw6LsNyOR2NENQ
         N37J+7lJeca+F+u/kO6XpC/B1e3n+l2sDtZh0DW7kzbA5gl5oplROaQ/ZYJMrKmDBNoD
         nwCQ6Bub4ceAz71q+NZiKdP/A6aE7Iy3znk0p6KAb7olj+jKu/aX++AVSbm/s5zqo4Ym
         NTftZio0QauSm9b3sA7hqr2bvB/jA270APQyEFzHcn4BBuG3Ho1k2NW9BJ8n16BKPCbE
         0B/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtp+UMqRp67mt6nUqZII+WcLuDrqW8v/QI0Nyz5R2YVCmxwb5HkLGZ8pgK+YOcINsgXbwQOVjbw+5CL/6pZkY=@vger.kernel.org, AJvYcCXo6OE8L3qDKHdMpXu4ynjfyWJOZ5+Pk5/rEpO46wINiiBT3w6teyxVtElbhXMtcU717ngh3S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxRVnt2k2qsEQAGyRGi3fS8p/oZENM5QOfFUI2lISE/5tkBEM4
	zdwzDPQIoZSwHh87CbWb/LUHbHOwodDhSPd/GyqlTQV70dXme9gxo3/BWgww
X-Gm-Gg: ASbGncuKi7mV5binStDZXaEWMO2qllA0F8lAXPTD+ZFT0OTO8JlYqfHcana3JkllMIX
	w83/DWXCSSz+mNGj44JcJoW+bCLol0s6GjrAn2PZqh0jxQUAMyx6sspeQDlO3msdPIeSG2lDl+k
	F/VruGnUXYcU4mRpfJnv9S4UqxSphH+92yjnRqG1ltBPP60ayPjF1LQKhjeUs6Q5ZXLfN7/sTCx
	6GFIpCjwltJ2dH9GY09yU3jSs1YNGWUJrjm9frGUAh5rEjb9mH/ncuZHnGf8JTzesE6Xb41xRO1
	c9dsUsDOUFF573DiqlybTvavVozZfXp2P5p+SvfMJT3alCDZpP0KsduwIXtqQdW57/E=
X-Google-Smtp-Source: AGHT+IE+k6dC2A4/3RTkXs+kV0CV5XWP+hMywbAJpwGF7oaJMZm9MPO0W9QhCPndxkYVluZqfSScFg==
X-Received: by 2002:a05:6a00:e1a:b0:732:2170:b6a3 with SMTP id d2e1a72fcca58-7329df287c1mr10200372b3a.21.1740035452416;
        Wed, 19 Feb 2025 23:10:52 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568af8sm13059672b3a.48.2025.02.19.23.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:10:52 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Gary Guo <gary@garyguo.net>,
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
	tgunders@redhat.com,
	david.laight.linux@gmail.com
Subject: [PATCH v11 5/8] rust: time: Add wrapper for fsleep() function
Date: Thu, 20 Feb 2025 16:06:07 +0900
Message-ID: <20250220070611.214262-6-fujita.tomonori@gmail.com>
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
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
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


