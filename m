Return-Path: <netdev+bounces-181961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FBFA871A8
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 12:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F67E3BF98E
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 10:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA6F1A2872;
	Sun, 13 Apr 2025 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK5v9il8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958FE20EB;
	Sun, 13 Apr 2025 10:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744541043; cv=none; b=MOXJ7KjLKzdtoQWmlNRR5MqXbiNKyJT+H8tb/8rFF0cYMOzBOs+jAjgDmLyWcUn+9PV3SQJvuVdsbsWyr41kPkfb25R2dcZ/d9wXLmz1GLaW2kJWKxpj33o2314El7tv+WDhLtv7y75Gp4HKmE4gP356iiBlvPFa3uMHXbYuGT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744541043; c=relaxed/simple;
	bh=7bbHq9b3raLhQY2lmc4D0BL+dx4bchO30xoDbujLTaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8LgqYNsDISOcSMj9abFc/h8pTZinuwJQCmwVjvpFBY+tZ9k9t2qe+hYv0THeaLBBbJCz73nCHNMCBV6CDwWsFJ2ZquEC9VzpJj8zuZNfMqZc6TqXvC4munY6QVZpx5eU23KOMn2CNp9eDqmmaoEHAUc3WLxJRUxKcWzoP5CPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK5v9il8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22435603572so31503915ad.1;
        Sun, 13 Apr 2025 03:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744541041; x=1745145841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHTGzVejhCWva0144p2G2kUfqECExts/ex9G9JHIPyU=;
        b=FK5v9il8zhN0TX1IOWCA7EFMyEQ4LEP+ngXuIN07ah9wMNYaGncsMnp5Puu5VuFFbj
         qT5J2CfN56oUWUNVakC+n4qPJy/x82OKgAqniAf4YepSFgNg0ryIZjwCUTqchzsdURUy
         /IcwJimVvvva1KZLiMH3WtU3MmitA7prOcGhfJ8rODMhGGkQtuut5jSjseOBBHlaZuVl
         +HZMOyFLyRgrozdQ7zeYOFuxusgNgsRdNc5nvuHbbywwU6L41uGkro0bIPZVMSPRU1Zy
         KfEvAJ2jNJOKgGeZdmZcQVboNHN0vg0Ri8yKGqc7Ovi1YF8xyRAEZN6HuArX9k80rmo7
         UdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744541041; x=1745145841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHTGzVejhCWva0144p2G2kUfqECExts/ex9G9JHIPyU=;
        b=NyH5nfSb7RA8vwjcBw46iwB19mLbEKIe/NVICv2R1PEoeoGJQZl/V354vtYbqr5o1w
         tcXP+ihM6+UVFPLobw9z0Qgx0VxThnjni93ogDSPN+z+oImj9pNsYvDj7WNJUBIDjWfG
         +pO42+ntaAknIK10QQukM8twnbb90SerTbJF+ijkQ70wVielNPTy0pj58Yh7fJE+Pxwl
         xeo1/VCVwahgWa3zuyUJRGER7g4WxNY1mceL0e4JeQmCzttLUd+r9glisfv0RTqHxo6J
         ePfwWg0qfZrgsS+iTnuQLPL4G+U4+iosVdixi98zSQo4fvRJ1b/tkfZparom2q+28SWy
         cQnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIaeOW22DsfkyRf1RDqtVCW4RgOsxOYkVW6sGGHt1dzS+nZrZ/Kxg5oAHD0B+3fJnRjcU6BbNxY9TUpHs=@vger.kernel.org, AJvYcCVA3+MfQdG/oZobD/Qi19lrCH6ILw2FXYsZWVjvyBzX9PRI6wBMdOv4Lse+dKskMnZRGOTV6Ryp@vger.kernel.org
X-Gm-Message-State: AOJu0YxpPFTGbFNsUYyen3HEMCjnA2QrzJjjrkoh9DFyls40oYkqcaJU
	P+cUDcmFvz3FSAw+SChKpx/DGNBAS5wRbu9S1AltmMl0CTtBIgW/Yzd2XoPM
X-Gm-Gg: ASbGncuThLnNi3ovDwLNvAoLXfp73nWTLReRsESV/0jnMyErGXUyvnhtmAFBUqrXiIq
	9EHXMbDB040z+eHsOoukyGeli3uRgqyWLqnsT25tQobFJ7XhYKYMuYagh0L2eZjryIfSK6HLb24
	MDZctj2zR/xHDuHRp9n/E51YU3wXLN+A8hGUvRfMvgte1vQsWWUPIXiX/U+Lu+uXGJYuiOQ8IFq
	nOPesaZ/EYL0clTR55iXEwWIeCXl0Qrn5lExS9h10VsQVAfKZj41CeqOB5xVpsEVeFWwYT22cqP
	m4kDAGYauGB49+7Qb0ypRtaiY7ShpNFIiXLIip1uUJcdToutINv75tuJqsL/B18hiRGsAYjfqU0
	Bh5ZjLujkyyRDO0Rv82ge17VnRnij
X-Google-Smtp-Source: AGHT+IHDXKIT3AHcch7lbyPUnsfZnPfynlAnueHGOCE6rtjvFJ+aBdHKcgJRLH528MdScmjC6QgQrA==
X-Received: by 2002:a17:903:8ce:b0:226:5dbf:373f with SMTP id d9443c01a7336-22bea4954b0mr154157335ad.10.1744541040328;
        Sun, 13 Apr 2025 03:44:00 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8af56sm80160885ad.66.2025.04.13.03.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 03:43:59 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
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
Subject: [PATCH v13 3/5] rust: time: Introduce Instant type
Date: Sun, 13 Apr 2025 19:43:08 +0900
Message-ID: <20250413104310.162045-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250413104310.162045-1-fujita.tomonori@gmail.com>
References: <20250413104310.162045-1-fujita.tomonori@gmail.com>
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
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs                 | 74 ++++++++++++++++-------------
 rust/kernel/time/hrtimer.rs         | 14 +++---
 rust/kernel/time/hrtimer/arc.rs     |  4 +-
 rust/kernel/time/hrtimer/pin.rs     |  4 +-
 rust/kernel/time/hrtimer/pin_mut.rs |  4 +-
 rust/kernel/time/hrtimer/tbox.rs    |  4 +-
 6 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index e00b9a853e6a..bc5082c01152 100644
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
 
@@ -33,59 +49,49 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
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
+    pub fn now() -> Self {
+        // INVARIANT: The `ktime_get()` function returns a value in the range
+        // from 0 to `KTIME_MAX`.
+        Self {
+            // SAFETY: It is always safe to call `ktime_get()` outside of NMI context.
+            inner: unsafe { bindings::ktime_get() },
+        }
     }
 
-    /// Divide the number of nanoseconds by a compile-time constant.
+    /// Return the amount of time elapsed since the [`Instant`].
     #[inline]
-    fn divns_constant<const DIV: i64>(self) -> i64 {
-        self.to_ns() / DIV
+    pub fn elapsed(&self) -> Delta {
+        Self::now() - *self
     }
 
-    /// Returns the number of nanoseconds.
     #[inline]
-    pub fn to_ns(self) -> i64 {
+    pub(crate) fn as_nanos(self) -> i64 {
         self.inner
     }
-
-    /// Returns the number of milliseconds.
-    #[inline]
-    pub fn to_ms(self) -> i64 {
-        self.divns_constant::<NSEC_PER_MSEC>()
-    }
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
diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index ce53f8579d18..27243eaaf8ed 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -68,7 +68,7 @@
 //! `start` operation.
 
 use super::ClockId;
-use crate::{prelude::*, time::Ktime, types::Opaque};
+use crate::{prelude::*, time::Instant, types::Opaque};
 use core::marker::PhantomData;
 use pin_init::PinInit;
 
@@ -189,7 +189,7 @@ pub trait HrTimerPointer: Sync + Sized {
 
     /// Start the timer with expiry after `expires` time units. If the timer was
     /// already running, it is restarted with the new expiry time.
-    fn start(self, expires: Ktime) -> Self::TimerHandle;
+    fn start(self, expires: Instant) -> Self::TimerHandle;
 }
 
 /// Unsafe version of [`HrTimerPointer`] for situations where leaking the
@@ -220,7 +220,7 @@ pub unsafe trait UnsafeHrTimerPointer: Sync + Sized {
     ///
     /// Caller promises keep the timer structure alive until the timer is dead.
     /// Caller can ensure this by not leaking the returned [`Self::TimerHandle`].
-    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle;
+    unsafe fn start(self, expires: Instant) -> Self::TimerHandle;
 }
 
 /// A trait for stack allocated timers.
@@ -232,7 +232,7 @@ pub unsafe trait UnsafeHrTimerPointer: Sync + Sized {
 pub unsafe trait ScopedHrTimerPointer {
     /// Start the timer to run after `expires` time units and immediately
     /// after call `f`. When `f` returns, the timer is cancelled.
-    fn start_scoped<T, F>(self, expires: Ktime, f: F) -> T
+    fn start_scoped<T, F>(self, expires: Instant, f: F) -> T
     where
         F: FnOnce() -> T;
 }
@@ -244,7 +244,7 @@ unsafe impl<T> ScopedHrTimerPointer for T
 where
     T: UnsafeHrTimerPointer,
 {
-    fn start_scoped<U, F>(self, expires: Ktime, f: F) -> U
+    fn start_scoped<U, F>(self, expires: Instant, f: F) -> U
     where
         F: FnOnce() -> U,
     {
@@ -366,12 +366,12 @@ unsafe fn c_timer_ptr(this: *const Self) -> *const bindings::hrtimer {
     /// - `this` must point to a valid `Self`.
     /// - Caller must ensure that the pointee of `this` lives until the timer
     ///   fires or is canceled.
-    unsafe fn start(this: *const Self, expires: Ktime) {
+    unsafe fn start(this: *const Self, expires: Instant) {
         // SAFETY: By function safety requirement, `this` is a valid `Self`.
         unsafe {
             bindings::hrtimer_start_range_ns(
                 Self::c_timer_ptr(this).cast_mut(),
-                expires.to_ns(),
+                expires.as_nanos(),
                 0,
                 (*Self::raw_get_timer(this)).mode.into_c(),
             );
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
index 4a984d85b4a1..acc70a0ea1be 100644
--- a/rust/kernel/time/hrtimer/arc.rs
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -8,7 +8,7 @@
 use super::RawHrTimerCallback;
 use crate::sync::Arc;
 use crate::sync::ArcBorrow;
-use crate::time::Ktime;
+use crate::time::Instant;
 
 /// A handle for an `Arc<HasHrTimer<T>>` returned by a call to
 /// [`HrTimerPointer::start`].
@@ -56,7 +56,7 @@ impl<T> HrTimerPointer for Arc<T>
 {
     type TimerHandle = ArcHrTimerHandle<T>;
 
-    fn start(self, expires: Ktime) -> ArcHrTimerHandle<T> {
+    fn start(self, expires: Instant) -> ArcHrTimerHandle<T> {
         // SAFETY:
         //  - We keep `self` alive by wrapping it in a handle below.
         //  - Since we generate the pointer passed to `start` from a valid
diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
index f760db265c7b..dba22d11a95f 100644
--- a/rust/kernel/time/hrtimer/pin.rs
+++ b/rust/kernel/time/hrtimer/pin.rs
@@ -6,7 +6,7 @@
 use super::HrTimerHandle;
 use super::RawHrTimerCallback;
 use super::UnsafeHrTimerPointer;
-use crate::time::Ktime;
+use crate::time::Instant;
 use core::pin::Pin;
 
 /// A handle for a `Pin<&HasHrTimer>`. When the handle exists, the timer might be
@@ -56,7 +56,7 @@ unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a T>
 {
     type TimerHandle = PinHrTimerHandle<'a, T>;
 
-    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle {
+    unsafe fn start(self, expires: Instant) -> Self::TimerHandle {
         // Cast to pointer
         let self_ptr: *const T = self.get_ref();
 
diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
index 90c0351d62e4..aeff8e102e1d 100644
--- a/rust/kernel/time/hrtimer/pin_mut.rs
+++ b/rust/kernel/time/hrtimer/pin_mut.rs
@@ -3,7 +3,7 @@
 use super::{
     HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, RawHrTimerCallback, UnsafeHrTimerPointer,
 };
-use crate::time::Ktime;
+use crate::time::Instant;
 use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
 
 /// A handle for a `Pin<&mut HasHrTimer>`. When the handle exists, the timer might
@@ -54,7 +54,7 @@ unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a mut T>
 {
     type TimerHandle = PinMutHrTimerHandle<'a, T>;
 
-    unsafe fn start(mut self, expires: Ktime) -> Self::TimerHandle {
+    unsafe fn start(mut self, expires: Instant) -> Self::TimerHandle {
         // SAFETY:
         // - We promise not to move out of `self`. We only pass `self`
         //   back to the caller as a `Pin<&mut self>`.
diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
index 2071cae07234..3df4e359e9bb 100644
--- a/rust/kernel/time/hrtimer/tbox.rs
+++ b/rust/kernel/time/hrtimer/tbox.rs
@@ -7,7 +7,7 @@
 use super::HrTimerPointer;
 use super::RawHrTimerCallback;
 use crate::prelude::*;
-use crate::time::Ktime;
+use crate::time::Instant;
 use core::ptr::NonNull;
 
 /// A handle for a [`Box<HasHrTimer<T>>`] returned by a call to
@@ -66,7 +66,7 @@ impl<T, A> HrTimerPointer for Pin<Box<T, A>>
 {
     type TimerHandle = BoxHrTimerHandle<T, A>;
 
-    fn start(self, expires: Ktime) -> Self::TimerHandle {
+    fn start(self, expires: Instant) -> Self::TimerHandle {
         // SAFETY:
         //  - We will not move out of this box during timer callback (we pass an
         //    immutable reference to the callback).
-- 
2.43.0


