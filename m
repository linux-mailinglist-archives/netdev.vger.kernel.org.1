Return-Path: <netdev+bounces-168000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75966A3D1D5
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41CC5189D52B
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EED1E7C18;
	Thu, 20 Feb 2025 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhXcnZKU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A631E766E;
	Thu, 20 Feb 2025 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035447; cv=none; b=CYaoI6BxzTLYLLZWcvyP5fySnvEdm4wRcAhxw0xRr4Q3pYh84c/DnphxLocYWmUsLJfwwg7uJ3FpFb6b+z/AJ/wl+UL81zxXMiBcsDAtbMISubSVXhJTqbbsd6X5Fbv1BY9DKPxgAUwzItvDRhp9W6H+IeEh3XoH6KlNvLf4ifM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035447; c=relaxed/simple;
	bh=cQ340EQRb+JwkfoITetc/kRTqFCH9Dx8D0nhzsT/24s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghGu0M+Q6phYYY4nzMrJzdQ19Q/VRnpM0+WvNhJ1lPoqQ0uZo+eDPISeXDQzDjZRv5ff1Ze8nra4jQ2Ylfe4cuJNS0UhDC9HKaYcgTT9Gjo7LxFg6cZn0hiDmDdaeVJpHt+7CN5Tnih5XsPFe7LPUBs59wRlSzfK3+7+TtdvYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhXcnZKU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c8f38febso10462585ad.2;
        Wed, 19 Feb 2025 23:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740035444; x=1740640244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKT6vKHpCFtbPYTy0cNxWdMoBAaxxzfIYLpKqSCQI9Y=;
        b=LhXcnZKUS5bSgh4TjkB8FCSlcocdI7eXkNw62IyJWyu/YxpIyq1N5WGLh9ny6t0RUn
         Vt1KEtRVuL2/hUzQFtb9ydgEttAAi/+xNsol+oWfu8AhvszdrIwQh0F0cLpw+q4xOu2B
         TLmTv3gIG2+NztjqztZl9kGoajc4rI/s0yqdLQxDmAwM0lO1d0EBljlgR+qEPM3PuBBX
         zq6JWL8oaJaKkBgwePINWbm6FM8UhzCmHlJdA4AiYmnD3QV7MFCA1cmvyslof9drB+0i
         cPGBzgSHdrhaFHQ/zJf/IH+nB7KhJciJ4dqsga9qYnh+EJLFibkAz88fQEJrsuq3oV9c
         qlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740035444; x=1740640244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKT6vKHpCFtbPYTy0cNxWdMoBAaxxzfIYLpKqSCQI9Y=;
        b=gG0bS/w15cGYjWNcJ1FFm/qyYGLjGbTKgTiWxjqcYhp286PMnuXlQrNOkSJ3Axc9cY
         dXN8lLwFgJxdZCkHq4YxU7pbubdxLYbcybvBTac0kUh3x65bJmgtynQ2W96jqELx7ew/
         FfX3ZrnErAArePxp+M0i3wYGYrZOAoFMiSIRwnv2F5ZKpWu//sVmdKt5OrSI1tsgxDeG
         e0I5J1D+ENsck5MoHwJnkLk+Qb/nUVDzVFe/a9KhnG3qPHBzdSY+ClnPZ0u1PkvaE0dO
         Fnxr4yml5kXK0ci505j5uqkNsVOiRAYz6Sh3JCxkStVTJGArOdx3T+v5inWzrqfgJPU8
         MvrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf+wmRfXmwenssYGAyhtXCorDDrekm//2eHXCYG9SS1vl/d0LpO3m25lKL9IntX+zDa+pU43WrzmoR0ywZVJA=@vger.kernel.org, AJvYcCWmTYm7rc2rVld4DDazBe1RIYoqZysGGajLAcniFksSZuAR0Y3YrWaJ7//7a6+9g+kHA+ykxRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCfn3/vzryFI1KCQsWonE6/WphCNd7hcSwt24yqOSJfAixsgw5
	sXgDViiG/Vzb7EjGU0c327c9Fv411isIsL0cnPdkyi3VTJH/vF1rMBcBwYcy
X-Gm-Gg: ASbGncs6R/g1RcEAFsaKo/esBfZI+bsVRaLUe7WueQ8hIcx4T5VcbGyET0ctS+XaOqM
	eKz6IhjVwJ4rsAGG1GHX76+yx+y1lAg2IMvVnQoFE9rUKzWYoXAo+Wmpx/Pwbb+rhyzS2VNVJjF
	8wz3GZX3JqmTbWZhL9yiHGxVpNR74xAM6RU2D8BEsGLDTFu/GX6A1CmcEt/bckzxu3iF2yJmxzq
	CC3N5qYsN2JBtMZo8+2ERTnh4UZ2rzlJ1jvP70SXM46GOZhABcHraMEGdRoZvtRzxzMZ7r1Esl1
	OETvs/n0KPiNHGAwu07ehrIx/HQ+VEP8LxS8ZAPdGUSVghwpl4rHgs+DgVLqyI9kLgI=
X-Google-Smtp-Source: AGHT+IE3S1jZXIXxjrEblsh5peZaZj1Io/lUfdB+7IROxH19yodlQGg/oLUmu8fFv+vpgDv7G2dO6A==
X-Received: by 2002:a05:6a21:339e:b0:1ee:b583:1b44 with SMTP id adf61e73a8af0-1eee5c25481mr2634566637.4.1740035444412;
        Wed, 19 Feb 2025 23:10:44 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568af8sm13059672b3a.48.2025.02.19.23.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:10:44 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
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
	david.laight.linux@gmail.com
Subject: [PATCH v11 4/8] rust: time: Introduce Instant type
Date: Thu, 20 Feb 2025 16:06:06 +0900
Message-ID: <20250220070611.214262-5-fujita.tomonori@gmail.com>
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

Introduce a type representing a specific point in time. We could use
the Ktime type but C's ktime_t is used for both timestamp and
timedelta. To avoid confusion, introduce a new Instant type for
timestamp.

Rename Ktime to Instant and modify their methods for timestamp.

Implement the subtraction operator for Instant:

Delta = Instant A - Instant B

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 77 +++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 38 deletions(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 622cd01e24d7..d64a05a4f4d1 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -5,6 +5,22 @@
 //! This module contains the kernel APIs related to time and timers that
 //! have been ported or wrapped for usage by Rust code in the kernel.
 //!
+//! There are two types in this module:
+//!
+//! - The [`Instant`] type represents a specific point in time.
+//! - The [`Delta`] type represents a span of time.
+//!
+//! Note that the C side uses `ktime_t` type to represent both. However, timestamp
+//! and timedelta are different. To avoid confusion, we use two different types.
+//!
+//! A [`Instant`] object can be created by calling the [`Instant::now()`] function.
+//! It represents a point in time at which the object was created.
+//! By calling the [`Instant::elapsed()`] method, a [`Delta`] object representing
+//! the elapsed time can be created. The [`Delta`] object can also be created
+//! by subtracting two [`Instant`] objects.
+//!
+//! A [`Delta`] type supports methods to retrieve the duration in various units.
+//!
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
@@ -31,59 +47,44 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
     unsafe { bindings::__msecs_to_jiffies(msecs) }
 }
 
-/// A Rust wrapper around a `ktime_t`.
+/// A specific point in time.
+///
+/// # Invariants
+///
+/// The `inner` value is in the range from 0 to `KTIME_MAX`.
 #[repr(transparent)]
 #[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
-pub struct Ktime {
+pub struct Instant {
     inner: bindings::ktime_t,
 }
 
-impl Ktime {
-    /// Create a `Ktime` from a raw `ktime_t`.
-    #[inline]
-    pub fn from_raw(inner: bindings::ktime_t) -> Self {
-        Self { inner }
-    }
-
+impl Instant {
     /// Get the current time using `CLOCK_MONOTONIC`.
     #[inline]
-    pub fn ktime_get() -> Self {
-        // SAFETY: It is always safe to call `ktime_get` outside of NMI context.
-        Self::from_raw(unsafe { bindings::ktime_get() })
-    }
-
-    /// Divide the number of nanoseconds by a compile-time constant.
-    #[inline]
-    fn divns_constant<const DIV: i64>(self) -> i64 {
-        self.to_ns() / DIV
-    }
-
-    /// Returns the number of nanoseconds.
-    #[inline]
-    pub fn to_ns(self) -> i64 {
-        self.inner
+    pub fn now() -> Self {
+        // INVARIANT: The `ktime_get()` function returns a value in the range
+        // from 0 to `KTIME_MAX`.
+        Self {
+            // SAFETY: It is always safe to call `ktime_get()` outside of NMI context.
+            inner: unsafe { bindings::ktime_get() },
+        }
     }
 
-    /// Returns the number of milliseconds.
+    /// Return the amount of time elapsed since the [`Instant`].
     #[inline]
-    pub fn to_ms(self) -> i64 {
-        self.divns_constant::<NSEC_PER_MSEC>()
+    pub fn elapsed(&self) -> Delta {
+        Self::now() - *self
     }
 }
 
-/// Returns the number of milliseconds between two ktimes.
-#[inline]
-pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
-    (later - earlier).to_ms()
-}
-
-impl core::ops::Sub for Ktime {
-    type Output = Ktime;
+impl core::ops::Sub for Instant {
+    type Output = Delta;
 
+    // By the type invariant, it never overflows.
     #[inline]
-    fn sub(self, other: Ktime) -> Ktime {
-        Self {
-            inner: self.inner - other.inner,
+    fn sub(self, other: Instant) -> Delta {
+        Delta {
+            nanos: self.inner - other.inner,
         }
     }
 }
-- 
2.43.0


