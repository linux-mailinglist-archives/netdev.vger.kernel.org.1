Return-Path: <netdev+bounces-179448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6771BA7CC78
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 03:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE66F176A92
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 01:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3767DA95;
	Sun,  6 Apr 2025 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeUAyEHm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD85F70814;
	Sun,  6 Apr 2025 01:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743903341; cv=none; b=ZB/vbCbqT00VgNF9iRW5l9hMWUlDuJ13a4n03GQWdHozW7xMlrT36iwPGsprwZCNz384L4rmsUYL/0kOmRhoZFeqKSGJF2va9Px31YgbVgbKxR7+jAHzJ9Ac+ETfDANgzpU34+kYxJb2VyM0lm4yF/+rLMhwqM2REHI75Q+WJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743903341; c=relaxed/simple;
	bh=7bbHq9b3raLhQY2lmc4D0BL+dx4bchO30xoDbujLTaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqzU7SsXCfq2KX/nBEOuP/NUDfdo541tGsHErgsXfTqkpa9y5IckjO65u/G7XlMsXz3dedWydZ2kKj7AxnBMr/jG9xffaJ9/BGvKgXeLX5HeVnwAMrCWvcjZJcNcjMmq+Hu6MAxEKu35lUXzDnCznhHwK9AKDX/6XjI4xL54TiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeUAyEHm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2260c91576aso26098425ad.3;
        Sat, 05 Apr 2025 18:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743903337; x=1744508137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHTGzVejhCWva0144p2G2kUfqECExts/ex9G9JHIPyU=;
        b=MeUAyEHm1mXi5O42d2HapphrQeuaJfndBAnY+hxS7waeigYjwbfULfAC/f/oNlWltH
         BPqeIKJ0SHl/9A4qA1wx68DPOlmwlfVk6DkaRYvKNGJ8Yejkt7KbiYCvOfT6lIbAeRSW
         EjNmoXFL397Jb5UYL58Z/EqgirbJmR4tdMsicmwzU7SJ0SmSPUnXxMj9F1TBFHUuaCPd
         aUe0b/gLMKw6h+UT8oXf6S8de5U2P1xHIq8RtwkVC/LneEmdT8jRF08dTdxKNvRrI6S5
         fUJGQeEKYmwDxEuC8oJg6CI7mIqDx8eNl2LS2rD1AR1/Kru7z/DL8HeQGQxuPsU+seGD
         N7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743903337; x=1744508137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHTGzVejhCWva0144p2G2kUfqECExts/ex9G9JHIPyU=;
        b=isvQCwkoWU4AA0tMm2+TlStzIcseMzyBHttpyPBJFaKmEBqhZlAjaYn+/2CUqv7I6g
         5TEahMFSeglDnRLouJGTUHd0wsdZVqG3zN3UCfK2xCodvuiyXqV77ZPOrFIvRYDeDbr+
         uLfkNs49nc1EcvoaIYCAr8KgvbZbRQypf0+VcSegQ7x/+hFIQkBMtWDuh393kX/Fxi3U
         XkA3+A4CS5naqNhNFFDvWy55x5H6AGV5oDiZvuYr7vHIkGWAlzvJJUn/VfGSMkCDXxq0
         kih6cpgPlaakIKExF8FO9hGNKKoTktidKD4ZHziUvUQ6w3i429RZSIwOvesJmmV9t6Qz
         tiqg==
X-Forwarded-Encrypted: i=1; AJvYcCXgG4jEf04iQn2/EbQ7eUfMb8+AvHqdo2Sk3tF11IJmS5/1OLxD7PWTRiFdzIS9szySBr8tjUf545u4xzQ=@vger.kernel.org, AJvYcCXgRvm3/pZ0iih826nTQ73iiq90QyjBGur4uP8C4Pre08f930IqO1cKat0LJL8OxJ/g7io/uDn/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OuT5cctfwH+qZvfMoMfhkWeD7nP0NML5n4bUVmzGMUjNoa+2
	a6nk7ibG2vjNNTk2+o1VKgbYZF6Ii3wf5RCGuCBI5gvXnNz/N6Zw6rtuMPNl
X-Gm-Gg: ASbGnct5tdO0Et9eghGyXcXuQp8hQ/uh+3xSz083Kmo9lBflHeA4+j3Hdraitiuf7j3
	pIUgywf7o7lVeM1rRQIlYVOUM884kQw7XXWrxaS/gISERjQn49Kiw144YmKBA0LLxHkQjPBNmRq
	Cl68cbR+G/s8QfNneewpKPr3Li24IIllxfbUpTTZCIEpPD8WdqKcf/4XZ73FyPyxIU53+qTcXQs
	xRJB97WDJcaMxD3j55ozegdLxwb++dOGnTOUgldt0WlLK+r/rlST4tlBUMspzkbV7UJSs4FrHaE
	gAR6XDaxInnbSraJgv9jN3TY3McrDlaLY9DT9E11PkxyYfs0Syt3bY4ru18o2qBMvk9tNLXy1mo
	ioKcAtuFtrf/DKcXP3gW/6Q==
X-Google-Smtp-Source: AGHT+IGUd7xiJH6zoiTKkAidl0ZaDrSGipBvNZnAw55xHaEbYZq5J6Sco0D+dmO0D21XIhKATyTNGA==
X-Received: by 2002:a17:902:da8f:b0:21f:85d0:828 with SMTP id d9443c01a7336-22a8a1bb664mr117156115ad.41.1743903336503;
        Sat, 05 Apr 2025 18:35:36 -0700 (PDT)
Received: from mew.. (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0bc052sm5846849b3a.156.2025.04.05.18.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 18:35:36 -0700 (PDT)
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
Subject: [PATCH v12 3/5] rust: time: Introduce Instant type
Date: Sun,  6 Apr 2025 10:34:43 +0900
Message-ID: <20250406013445.124688-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250406013445.124688-1-fujita.tomonori@gmail.com>
References: <20250406013445.124688-1-fujita.tomonori@gmail.com>
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


