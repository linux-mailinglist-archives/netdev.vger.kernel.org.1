Return-Path: <netdev+bounces-160917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179B8A1C2B6
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 11:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4210416A734
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 10:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9B9207E18;
	Sat, 25 Jan 2025 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Okeb/j+v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072ED207E10;
	Sat, 25 Jan 2025 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737800431; cv=none; b=F8QXECDBiiahiXPBQFoZ18vA+trScf7tN5hRnINrgegWTwpALJwRfupJnQktOrHHwMPyHWl8yTJITgj8REIvmXUI0tIylewaCG835Rpwjzi5LDCG0HmuYCqN1SY9MRFeuTFy9vK+kC74iRBvyLxU+A90cDbA6Zeme/z23akuaeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737800431; c=relaxed/simple;
	bh=HeEtOL3k54zb89/FWTsjNFuw4q/j8Gt5GdjLU3lTzP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+4sMEhUS5985TELYAVDhijNIw1SzkBwiW+dLLMU202PP7j289OjF949VLYxKN6Qh+JtcYYdN4cber1JXwLGjPWAaBJo1SO8HPHyZR9opODK4VT61AOL5gojsZw2pD8JAAdGfIcVPITgAHOPMTpGEzIqmGwtpyVq+rjXy1VVwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Okeb/j+v; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2165cb60719so51509375ad.0;
        Sat, 25 Jan 2025 02:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737800429; x=1738405229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYF/+WEcHUxYz6LUGWyjprMe9I73XNctlPRWKUzX670=;
        b=Okeb/j+vHe+Pnb13jex9hSqHlxbU0yrEo+RVGU98ikqhRMVY7t5jFaHWcVCb+YfbS0
         ENyt/I5O4lHreqrgwNlQklBglF0DX4PJxSD/5z5uuTpEH3um4BvJ/tCSXjFeMjO0D1cx
         2uNHC6u3zrz6XGaNbaqiutS0W6Pi59HH/UlbBOlGn0ZazZINOaQ8hUDZ61m3zsuCHHAd
         W/bPtA5VkVmZRB9tz8FUG6w+Qd2Y0YdBIxlBSSKgW3ws4kN/vBKm0gdVuDiLjJloMcm2
         mNFLvOXgPysfeoN05A7/RPmOI8+oYyjac2qC8kFqM1uCuKIMeHV0+Jtd3giId6FXo8Q+
         MKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737800429; x=1738405229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYF/+WEcHUxYz6LUGWyjprMe9I73XNctlPRWKUzX670=;
        b=VQxncmdtBLX1ueu5C5WZWLtxfCS4CUP0/xZCvIGTIQgefeLaBojiGo9ie2S1teAx5c
         +67ktGvqJAaUpjB3UJUGyQ+AcA0EI37BjIALVQQ929+y9FXmBFTT58CCHpHrZrPwMClI
         KNBe8MMVqGWTXxOg9wC2VjE+J2s1bYcVU090jysXy3/oor9uCLobdK+4to3qaCB8h4+P
         ndd04y+IASX4OyAuNo72p7VbxQcz8+9AAOi4hoIoOlY3VyWUCrsVsFTYbmMJWwcJDGqY
         Dks12AlIfG5gDmWU/sm8kkLk4DhaoS/kXkZTkhsaBthVFuN9TbjudLC3qj1E53Xzx/m8
         wZsA==
X-Forwarded-Encrypted: i=1; AJvYcCW/cEC0j5gIRnozSvyxzavrukdE8GzQxKnC+VPIVd+SQg5v19vShjTqLbOGc79sE/ZoaCkeyDQ=@vger.kernel.org, AJvYcCXfDQMbNxqgnkDFqPCTXAMc88+A6MsxbJ+m+WjU+7OBHtmVjoSHUMAlfTG5HrHTAFCG9iXGdbcabbxzwgoVNDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB/jDC1LGnKPcyRziSy9GLRsSi2Fw6EudHZcRpFpFSYoe+ayjE
	KN0TDn1FF68WQSsKzThNEk/nMmtzgQJKypgbYGMs1vH+KwJQymVBZxbBK02b
X-Gm-Gg: ASbGncuZc5l4VNpSivUCAMBWgnC/pkh3SDL926OqztxjLrKgqc/kZ7OcuAjZvkAT29w
	MnXQ55BFsny7FahDwzsRKJr/MldojPrGz+GnkGI69/Kj7DK9s6Z/B352o7iTErfkuL0cAyKiFxs
	a2/MzYhv/zi/ymzHl2GlbiT6DdELzkwTbZsiXUYoTVPTxT0gKXwSHTyNR3iTCldZFXedU2vo5e5
	EOFXIGFmF9kf1LV797m7ypEt0wlqzC7+fP/38qJ4HLjjZHV1bQxJj1TuenLJwS2yiS0e/2f1IKP
	C38iBvYxWYOPj+tutOq0D9Uyza2y2QEsbwbPNsJHXSCkDExXXi6N+Afz
X-Google-Smtp-Source: AGHT+IGzBwoEOlcBY+G0bOmX/uS2sidJTNzJK39POICAA2N1Fqhiu3ASMl2yF0YdgtDQ2XrN91MAmg==
X-Received: by 2002:a17:902:db0e:b0:215:522d:72d6 with SMTP id d9443c01a7336-21c355bae02mr538611245ad.38.1737800428799;
        Sat, 25 Jan 2025 02:20:28 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424f344sm29461155ad.232.2025.01.25.02.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 02:20:28 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	rust-for-linux@vger.kernel.org,
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
Subject: [PATCH v9 4/8] rust: time: Introduce Instant type
Date: Sat, 25 Jan 2025 19:18:49 +0900
Message-ID: <20250125101854.112261-5-fujita.tomonori@gmail.com>
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

Introduce a type representing a specific point in time. We could use
the Ktime type but C's ktime_t is used for both timestamp and
timedelta. To avoid confusion, introduce a new Instant type for
timestamp.

Rename Ktime to Instant and modify their methods for timestamp.

Implement the subtraction operator for Instant:

Delta = Instant A - Instant B

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
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


