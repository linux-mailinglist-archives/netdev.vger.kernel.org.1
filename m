Return-Path: <netdev+bounces-153598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E4C9F8CA5
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 07:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203E3188F945
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 06:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267A61C175C;
	Fri, 20 Dec 2024 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgBkFtTB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8F19992E;
	Fri, 20 Dec 2024 06:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675684; cv=none; b=THIk9wKpO8Rkd21b5P2c3jKV9X9vhuh+kZMlpvP0KSZJZpAKePNlyyUH1eMsIE2pVp8I1hMfq0bnbZUko8/Vm0sQzXruRLYnrrzms7oZYurCPnHC7bUljospTSZN8Jnwdssetyf2p7WxFhWO/GoW6xwnw5E1MsUV0DXjLky8xdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675684; c=relaxed/simple;
	bh=O+kqL+5YpnCiY6731vR15kXmZyQfCfEoPbqW1DePO80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4Asa36GLZr9TIv+t8mAXIUqmhRW4fKTYwVkDWZfEmq5gC+yYKLciH1Yo5rTZni1KyG/XP7I5fvSwwiIsolSkKvrmakOL/7UgB6KPm8RJOrnDKcaCQb7k3YvTLT0M9WGLpQUCOOYbbdys5BirVjhn6e9KJ1LmwX3U/BQXe5MfEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgBkFtTB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728eccf836bso1392321b3a.1;
        Thu, 19 Dec 2024 22:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734675682; x=1735280482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG2rfgEzsdeXdQBcUUB2Ws17wlCYVB4wC33Z9prKhtg=;
        b=NgBkFtTBzxOww80uvHyrx5t4TvhEEqxOBIzucCyObGnEQsKw+aqCWGpjfhej5w+lCX
         lFQAoY9WDeblLETkksJdnsV7Gl3j7M7Sb9SanPaj1Y4j69bWwQRYoYK35JRdBKMRXDvi
         LcNyVeqcWvS01qf2RVqwgoxdp8pKZrhjjKkwaW3etz+VeurcrEwG/bQLyrrpWOc00pNA
         FgoRu4YbsKSB3AxomkjJLwL7KPp8CxejjlZXNpyPiVb9A4QENbqlu5k4Cq7Zi4fbeCKX
         gtTaA6rAosFe00rShRKztGUISW3qOfWjIylH8kez8rOAeihKeqm41gBh4WeGTHvQX7bG
         eSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734675682; x=1735280482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tG2rfgEzsdeXdQBcUUB2Ws17wlCYVB4wC33Z9prKhtg=;
        b=tGpFXgvYsEMSzFNBgnjLz3hzavuyI8whiv+BXPasKzWgQfY90eIRqe2o2PVB6ik2XP
         ObPCrCwRQYckFqJ3jcxeZYsWvcUJXHl6mZ0LRRlAjfH4WG+0BQkbb2beGaQFwBelGWms
         IYXHtVZHYclhyQ6vuRmQpEV9jTK+mQq0Zo6MQFYeL+zBFbG3C5vTN8KVq2IPLVPt+aWo
         967k4r87VvodqmneMkm2/9OAhiMAlIqbF0larkgPpSv4OScB4gNUrx4oZ2hb2Bm1gBLo
         7kILKtcLDfiT1zs6Lolfd4IsxJ8kcLudOakjfa48lxT2t/VFhgjC44SS77RtRlqxI0YW
         ldjg==
X-Forwarded-Encrypted: i=1; AJvYcCWtOkrIADIaR9ncJlKhUD/qXKU1YPI/EwCx9WOZSVBlDHht2vr6jtnpbYU8TF7RomKvQ0HHVrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6IppG4NQJ+mVIk65Xk14htNmV/KSaXfL8xwS42T9eCB1mlDyD
	9390UA8qrayuAqawOOfaUwXDqv+LDzTQkAl13tBTKEBLedrNfHqzYdfi+rsI
X-Gm-Gg: ASbGncsINLOFD3FZ2qfYmEmlNYPGR0ClGJgihMZApMKQgNV1jSQpAB7XolvT3lblupP
	5/0QGORecJ5zFsCOHR9UKjj0iUTXhrAZVF+Z3ECIZ9xHQWTG+/niyfZrrO/3uoe1dRwxBoT78Uf
	qBFVfTR4w+6Oqlt7xh2zfdqGt5M0yLug3nmR2UqC34VnHcrDkjsepcVuCxVjuTC5xFhjra3kN+8
	nHT7RyJS/sGZg8g+c5AeUm+yDUHSYt0QsnW5psTCrbMGQ1KZVlDN5ZJaDgiNHyDRFRZrmD2TVSt
	NNohbqsmQWfMPEYFHg==
X-Google-Smtp-Source: AGHT+IE1wG7gLPDsT2g+E96Z9HzGH5uyMJk3oD1PE18TWJfGKwR0wVEzlByk/HLfvXH9fiu1Nb62PQ==
X-Received: by 2002:a05:6a00:44c4:b0:725:e405:6df7 with SMTP id d2e1a72fcca58-72abdd7f683mr2540509b3a.10.1734675681495;
        Thu, 19 Dec 2024 22:21:21 -0800 (PST)
Received: from snail23.. (p7659208-ipoefx.ipoe.ocn.ne.jp. [221.188.16.207])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01d3sm2158548a12.23.2024.12.19.22.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 22:21:21 -0800 (PST)
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
	vschneid@redhat.com
Subject: [PATCH v7 4/7] rust: time: Add wrapper for fsleep function
Date: Fri, 20 Dec 2024 15:18:50 +0900
Message-ID: <20241220061853.2782878-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220061853.2782878-1-fujita.tomonori@gmail.com>
References: <20241220061853.2782878-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a wrapper for fsleep, flexible sleep functions in
`include/linux/delay.h` which typically deals with hardware delays.

The kernel supports several `sleep` functions to handle various
lengths of delay. This adds fsleep, automatically chooses the best
sleep method based on a duration.

`sleep` functions including `fsleep` belongs to TIMERS, not
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
 rust/helpers/time.c       |  8 ++++++++
 rust/kernel/time.rs       |  4 +++-
 rust/kernel/time/delay.rs | 43 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 1 deletion(-)
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
index da54a70f8f1f..3be2bf578519 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -2,12 +2,14 @@
 
 //! Time related primitives.
 //!
-//! This module contains the kernel APIs related to time and timers that
+//! This module contains the kernel APIs related to time that
 //! have been ported or wrapped for usage by Rust code in the kernel.
 //!
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
+pub mod delay;
+
 /// The number of nanoseconds per microsecond.
 pub const NSEC_PER_USEC: i64 = bindings::NSEC_PER_USEC as i64;
 
diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
new file mode 100644
index 000000000000..db5c08b0f230
--- /dev/null
+++ b/rust/kernel/time/delay.rs
@@ -0,0 +1,43 @@
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
+/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
+/// which automatically chooses the best sleep method based on a duration.
+///
+/// `delta` must be 0 or greater and no more than `u32::MAX / 2` microseconds.
+/// If a value outside the range is given, the function will sleep
+/// for `u32::MAX / 2` microseconds (= ~2147 seconds or ~36 minutes) at least.
+///
+/// This function can only be used in a nonatomic context.
+pub fn fsleep(delta: Delta) {
+    // The argument of fsleep is an unsigned long, 32-bit on 32-bit architectures.
+    // Considering that fsleep rounds up the duration to the nearest millisecond,
+    // set the maximum value to u32::MAX / 2 microseconds.
+    const MAX_DURATION: Delta = Delta::from_micros(u32::MAX as i64 >> 1);
+
+    let duration = if delta > MAX_DURATION || delta.is_negative() {
+        // TODO: add WARN_ONCE() when it's supported.
+        MAX_DURATION
+    } else {
+        delta
+    };
+
+    // SAFETY: FFI call.
+    unsafe {
+        // Convert the duration to microseconds and round up to preserve
+        // the guarantee; fsleep sleeps for at least the provided duration,
+        // but that it may sleep for longer under some circumstances.
+        bindings::fsleep(duration.as_micros_ceil() as c_ulong)
+    }
+}
-- 
2.43.0


