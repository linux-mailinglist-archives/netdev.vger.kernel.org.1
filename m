Return-Path: <netdev+bounces-182136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33853A87FE5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82843AB079
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C480325E440;
	Mon, 14 Apr 2025 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYwOd4PQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5019F133;
	Mon, 14 Apr 2025 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632020; cv=none; b=YX2g/W2VdzvOcXL/Fif8XjH2CZyatpPPZlxSmWBVutObDqtV6hdqmSuP8mxPNKoBqGKGJl5dOpYo1Jtv+8OCYXvWs0bJ8ydv5gAeDfYeGb/bQm9mk7QpZBn3KpU8xI0jOJUa7A1YYEGC3yfuR2IZZkkQcu0yQZD1v+T9QQzAiOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632020; c=relaxed/simple;
	bh=uJahjqeeXv2MBJnUZmTaf38PzTJLZnvQv3pc631zszo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TyI2cxVD4SvgOmVKrx54gX+4RxsM2mVsvaDbyftQVTjDvENk5tzv90d7zBlufjE5VUv1FUbe7A1PbpKpB/tlQvqzOJzNI1A+lG69IR2kGFAl2F3uwQGMNk3/6W+ocVGNn6mxcdGWxyOShooeh8vXeXm8k/08C4XILAPRUmIGskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYwOd4PQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso3931985b3a.2;
        Mon, 14 Apr 2025 05:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744632015; x=1745236815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbeT9PM7ADHEKYO28BBFtqSlJhnBf6bNwVb19VGAafU=;
        b=TYwOd4PQ0K7At8FA7/KRsZ+8Y/02V0E8VVm/8Pj4hOK2rjSVXg+AMZR+9uqW+eblmM
         6J5tR3m6pi/qvBZW00+0R2rqCcAdpuAB/AxNZV/4EbVjR5f9LqcICcitBdpFS+HU+LKt
         r6EJEIVQ2fVKV0uTSEzyqgBHjvK6aUeWkuEHKCLd0/OY46zPkkQqOQULvvhU0wVog2Se
         6pUke44+jukVI4OXkBuS3vBMEjl/iCyeupcJzVxy8ZG/Txu13exDYLvcpX6Sfx5APtSx
         L7ydGbri6PzKjEyUxZtX3w+I/p5X+FOE9DRLa22YsG44RSlCGB/sLT2s9PYllO9C27l8
         qdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744632015; x=1745236815;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TbeT9PM7ADHEKYO28BBFtqSlJhnBf6bNwVb19VGAafU=;
        b=H+aPtT9jRoDr1OlZfPon76uSSTaClE7/KYwEFjSd7Luu+11cTapmJVzvi/FYP5SFvK
         vl++AU1NYucUCePzCNv56KyIyMpp/YYfCoHtFWLu13+vaM6jECY+2fX+1nJQ4JSuhZ97
         tg6rxaUeLifLK7bTRaiY0cZEaF1GsfOuCw3H8pNWX1uMnvwjEndIcy4QXD8yvBFu8vAr
         C3FMPVXa9f7o3asdgiTJCb41ealw/z5Mamu1n5Qvd1pZZVK4+FHy66UvwIH6JT7ivNYE
         MhYs5+JtNzNg1Iq0nYbVJ/4e+38uV7wJjRCx+aFLkVX1EidZ7dU1kaNygKq0HnAxIvrC
         VqzA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Z5Us0AQNZ9hbuMjBJ9v1+PuWsTPXPUYIq9Gkqpd2/bl063ZWoAsyO0PgNxecbE+ucFbGFBYlhQFm6eQ=@vger.kernel.org, AJvYcCVkl5Wtn4yJ5CG1oQCjv4jkmagml5I+WSDL+2q1Hph0Q/vweyZS5cFGy55ireAsqOcUiIasCQrF@vger.kernel.org, AJvYcCXy0CwdD8BteCiJJ6nzbttKpufeB0s5Pbq15MEQnYf2fGkD8u0AxjNGos/sv5iIAWbVhjTMxDoJtxnXulGH7hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAUEVAYGinA6eDPxRijs3wqoHGNOAYQu4fRKlnc+YZCMChe7rV
	5qMejC49NmnPycayZqyHveBolI5rm9WKtf18ib6voflWo3njYztOmKk8ESL1
X-Gm-Gg: ASbGncsPpCpZ+ESTuz8GxqnXJ5PQSoqcV3EIcbp+yehxzd5vomNESmjZVReWUYcEnuY
	FMLxVd2KtT5VVUGdAI7YCueEzk5igIA9MqfJOyMCkENeN9L6xt11uHJickrO3X8j8NDCz3vy3jy
	8h1EeOzK21ESzxyWlS2efBbcFiZGeE9IKIzIRWedkf/hNp7B2KmgIEdaPnmW6QnMFqU4m9R7fSP
	5N862epNWgQNwKquaH4I/CVhbtpN0vftef9IS5aKCMwkJGeHSb7cA90xpA1MWZvLhq+lJeNdT/2
	ff9sEPCXQ7nQwoLoe4XxK6xNa5RFisMQHN6xD6OGk1QyRVvFcriUrBj2DeT7icuZXcgNbnNnvDk
	HchFR61o1o/NnNSlasDDKw5g=
X-Google-Smtp-Source: AGHT+IGIQL2yBJAEGGmpbmsximB+XhRCXSkhOqGrh6Qf16tDtrUy2NYI2DH7rM7thCUOVOwKfeP7kQ==
X-Received: by 2002:a05:6a00:1907:b0:736:a82a:58ad with SMTP id d2e1a72fcca58-73bd126b882mr12259801b3a.15.1744632014238;
        Mon, 14 Apr 2025 05:00:14 -0700 (PDT)
Received: from localhost (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e578sm6594845b3a.144.2025.04.14.05.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 05:00:13 -0700 (PDT)
Date: Mon, 14 Apr 2025 20:59:54 +0900 (JST)
Message-Id: <20250414.205954.2258973048785103265.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org
Cc: boqun.feng@gmail.com, fujita.tomonori@gmail.com,
 rust-for-linux@vger.kernel.org, gary@garyguo.net, me@kloenk.dev,
 daniel.almeida@collabora.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com, david.laight.linux@gmail.com
Subject: Re: [PATCH v13 3/5] rust: time: Introduce Instant type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <87lds3cjgx.fsf@kernel.org>
References: <gfamC5NjhLe9s4hmTvSZ7QKdHWaDanKv8IgocjF5GbeWMHvfFm0bGedvpqm5ZedrHFp-Nl6jEQC3618e3UQRrQ==@protonmail.internalid>
	<67fc517b.050a0220.301460.dfe7@mx.google.com>
	<87lds3cjgx.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 09:04:14 +0200
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> "Boqun Feng" <boqun.feng@gmail.com> writes:
> 
>> On Sun, Apr 13, 2025 at 07:43:08PM +0900, FUJITA Tomonori wrote:
>>> Introduce a type representing a specific point in time. We could use
>>> the Ktime type but C's ktime_t is used for both timestamp and
>>> timedelta. To avoid confusion, introduce a new Instant type for
>>> timestamp.
>>>
>>> Rename Ktime to Instant and modify their methods for timestamp.
>>>
>>> Implement the subtraction operator for Instant:
>>>
>>> Delta = Instant A - Instant B
>>>
>>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>>
>> I probably need to drop my Reviewed-by because of something below:
>>
>>> Reviewed-by: Gary Guo <gary@garyguo.net>
>>> Reviewed-by: Fiona Behrens <me@kloenk.dev>
>>> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
>>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>>> ---
>> [...]
>>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>>> index ce53f8579d18..27243eaaf8ed 100644
>>> --- a/rust/kernel/time/hrtimer.rs
>>> +++ b/rust/kernel/time/hrtimer.rs
>>> @@ -68,7 +68,7 @@
>>>  //! `start` operation.
>>>
>>>  use super::ClockId;
>>> -use crate::{prelude::*, time::Ktime, types::Opaque};
>>> +use crate::{prelude::*, time::Instant, types::Opaque};
>>>  use core::marker::PhantomData;
>>>  use pin_init::PinInit;
>>>
>>> @@ -189,7 +189,7 @@ pub trait HrTimerPointer: Sync + Sized {
>>>
>>>      /// Start the timer with expiry after `expires` time units. If the timer was
>>>      /// already running, it is restarted with the new expiry time.
>>> -    fn start(self, expires: Ktime) -> Self::TimerHandle;
>>> +    fn start(self, expires: Instant) -> Self::TimerHandle;
>>
>> We should be able to use what I suggested:
>>
>> 	https://lore.kernel.org/rust-for-linux/Z_ALZsnwN53ZPBrB@boqun-archlinux/
>>
>> to make different timer modes (rel or abs) choose different expire type.
>>
>> I don't think we can merge this patch as it is, unfortunately, because
>> it doesn't make sense for a relative timer to take an Instant as expires
>> value.
> 
> I told Tomo he could use `Instant` in this location and either he or I
> would fix it up later [1].
> 
> I don't want to block the series on this since the new API is not worse
> than the old one where Ktime is overloaded for both uses.

Here's the fix that I've worked on. As Boqun suggested, I added
`HrTimerExpireMode` trait since `HrTimerMode` is already used. It
compiles, but I'm not sure if it's what everyone had in mind.

Since many parts need to be made generic, I think the changes will be
complicated. Rather than including this in the instant and duration
patchset, I think it would be better to review this change separately.


diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 27243eaaf8ed..db3f99662222 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -68,10 +68,16 @@
 //! `start` operation.
 
 use super::ClockId;
-use crate::{prelude::*, time::Instant, types::Opaque};
+use crate::{prelude::*, types::Opaque};
 use core::marker::PhantomData;
 use pin_init::PinInit;
 
+pub trait HrTimerExpireMode {
+    type Expires; /* either Delta or Instant */
+
+    fn as_nanos(expires: Self::Expires) -> bindings::ktime_t;
+}
+
 /// A timer backed by a C `struct hrtimer`.
 ///
 /// # Invariants
@@ -176,7 +182,7 @@ pub(crate) unsafe fn raw_cancel(this: *const Self) -> bool {
 /// that more than one [`HrTimerHandle`] associated with a [`HrTimerPointer`] may
 /// exist. A timer can be manipulated through any of the handles, and a handle
 /// may represent a cancelled timer.
-pub trait HrTimerPointer: Sync + Sized {
+pub trait HrTimerPointer<Mode: HrTimerExpireMode>: Sync + Sized {
     /// A handle representing a started or restarted timer.
     ///
     /// If the timer is running or if the timer callback is executing when the
@@ -189,7 +195,7 @@ pub trait HrTimerPointer: Sync + Sized {
 
     /// Start the timer with expiry after `expires` time units. If the timer was
     /// already running, it is restarted with the new expiry time.
-    fn start(self, expires: Instant) -> Self::TimerHandle;
+    fn start(self, expires: Mode::Expires) -> Self::TimerHandle;
 }
 
 /// Unsafe version of [`HrTimerPointer`] for situations where leaking the
@@ -203,7 +209,7 @@ pub trait HrTimerPointer: Sync + Sized {
 /// Implementers of this trait must ensure that instances of types implementing
 /// [`UnsafeHrTimerPointer`] outlives any associated [`HrTimerPointer::TimerHandle`]
 /// instances.
-pub unsafe trait UnsafeHrTimerPointer: Sync + Sized {
+pub unsafe trait UnsafeHrTimerPointer<Mode: HrTimerExpireMode>: Sync + Sized {
     /// A handle representing a running timer.
     ///
     /// # Safety
@@ -220,7 +226,7 @@ pub unsafe trait UnsafeHrTimerPointer: Sync + Sized {
     ///
     /// Caller promises keep the timer structure alive until the timer is dead.
     /// Caller can ensure this by not leaking the returned [`Self::TimerHandle`].
-    unsafe fn start(self, expires: Instant) -> Self::TimerHandle;
+    unsafe fn start(self, expires: Mode::Expires) -> Self::TimerHandle;
 }
 
 /// A trait for stack allocated timers.
@@ -229,10 +235,10 @@ pub unsafe trait UnsafeHrTimerPointer: Sync + Sized {
 ///
 /// Implementers must ensure that `start_scoped` does not return until the
 /// timer is dead and the timer handler is not running.
-pub unsafe trait ScopedHrTimerPointer {
+pub unsafe trait ScopedHrTimerPointer<Mode: HrTimerExpireMode> {
     /// Start the timer to run after `expires` time units and immediately
     /// after call `f`. When `f` returns, the timer is cancelled.
-    fn start_scoped<T, F>(self, expires: Instant, f: F) -> T
+    fn start_scoped<T, F>(self, expires: Mode::Expires, f: F) -> T
     where
         F: FnOnce() -> T;
 }
@@ -240,11 +246,12 @@ fn start_scoped<T, F>(self, expires: Instant, f: F) -> T
 // SAFETY: By the safety requirement of [`UnsafeHrTimerPointer`], dropping the
 // handle returned by [`UnsafeHrTimerPointer::start`] ensures that the timer is
 // killed.
-unsafe impl<T> ScopedHrTimerPointer for T
+unsafe impl<T, Mode> ScopedHrTimerPointer<Mode> for T
 where
-    T: UnsafeHrTimerPointer,
+    T: UnsafeHrTimerPointer<Mode>,
+    Mode: HrTimerExpireMode,
 {
-    fn start_scoped<U, F>(self, expires: Instant, f: F) -> U
+    fn start_scoped<U, F>(self, expires: Mode::Expires, f: F) -> U
     where
         F: FnOnce() -> U,
     {
@@ -319,6 +326,7 @@ pub unsafe trait HrTimerHandle {
 /// their documentation. All the methods of this trait must operate on the same
 /// field.
 pub unsafe trait HasHrTimer<T> {
+    type Mode: HrTimerExpireMode;
     /// Return a pointer to the [`HrTimer`] within `Self`.
     ///
     /// This function is useful to get access to the value without creating
@@ -366,12 +374,15 @@ unsafe fn c_timer_ptr(this: *const Self) -> *const bindings::hrtimer {
     /// - `this` must point to a valid `Self`.
     /// - Caller must ensure that the pointee of `this` lives until the timer
     ///   fires or is canceled.
-    unsafe fn start(this: *const Self, expires: Instant) {
+    unsafe fn start(
+        this: *const Self,
+        expires: <<Self as HasHrTimer<T>>::Mode as HrTimerExpireMode>::Expires,
+    ) {
         // SAFETY: By function safety requirement, `this` is a valid `Self`.
         unsafe {
             bindings::hrtimer_start_range_ns(
                 Self::c_timer_ptr(this).cast_mut(),
-                expires.as_nanos(),
+                Self::Mode::as_nanos(expires),
                 0,
                 (*Self::raw_get_timer(this)).mode.into_c(),
             );
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
index acc70a0ea1be..90cf0edf4509 100644
--- a/rust/kernel/time/hrtimer/arc.rs
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -3,12 +3,12 @@
 use super::HasHrTimer;
 use super::HrTimer;
 use super::HrTimerCallback;
+use super::HrTimerExpireMode;
 use super::HrTimerHandle;
 use super::HrTimerPointer;
 use super::RawHrTimerCallback;
 use crate::sync::Arc;
 use crate::sync::ArcBorrow;
-use crate::time::Instant;
 
 /// A handle for an `Arc<HasHrTimer<T>>` returned by a call to
 /// [`HrTimerPointer::start`].
@@ -47,7 +47,7 @@ fn drop(&mut self) {
     }
 }
 
-impl<T> HrTimerPointer for Arc<T>
+impl<T> HrTimerPointer<<T as HasHrTimer<T>>::Mode> for Arc<T>
 where
     T: 'static,
     T: Send + Sync,
@@ -56,7 +56,10 @@ impl<T> HrTimerPointer for Arc<T>
 {
     type TimerHandle = ArcHrTimerHandle<T>;
 
-    fn start(self, expires: Instant) -> ArcHrTimerHandle<T> {
+    fn start(
+        self,
+        expires: <<T as HasHrTimer<T>>::Mode as HrTimerExpireMode>::Expires,
+    ) -> ArcHrTimerHandle<T> {
         // SAFETY:
         //  - We keep `self` alive by wrapping it in a handle below.
         //  - Since we generate the pointer passed to `start` from a valid
diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
index dba22d11a95f..5b79cbcaca3f 100644
--- a/rust/kernel/time/hrtimer/pin.rs
+++ b/rust/kernel/time/hrtimer/pin.rs
@@ -3,6 +3,7 @@
 use super::HasHrTimer;
 use super::HrTimer;
 use super::HrTimerCallback;
+use super::HrTimerExpireMode;
 use super::HrTimerHandle;
 use super::RawHrTimerCallback;
 use super::UnsafeHrTimerPointer;
@@ -48,7 +49,7 @@ fn drop(&mut self) {
 
 // SAFETY: We capture the lifetime of `Self` when we create a `PinHrTimerHandle`,
 // so `Self` will outlive the handle.
-unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a T>
+unsafe impl<'a, T> UnsafeHrTimerPointer<<T as HasHrTimer<T>>::Mode> for Pin<&'a T>
 where
     T: Send + Sync,
     T: HasHrTimer<T>,
@@ -56,7 +57,10 @@ unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a T>
 {
     type TimerHandle = PinHrTimerHandle<'a, T>;
 
-    unsafe fn start(self, expires: Instant) -> Self::TimerHandle {
+    unsafe fn start(
+        self,
+        expires: <<T as HasHrTimer<T>>::Mode as HrTimerExpireMode>::Expires,
+    ) -> Self::TimerHandle {
         // Cast to pointer
         let self_ptr: *const T = self.get_ref();
 
diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
index aeff8e102e1d..82d7ecdbbfb6 100644
--- a/rust/kernel/time/hrtimer/pin_mut.rs
+++ b/rust/kernel/time/hrtimer/pin_mut.rs
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use super::{
-    HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, RawHrTimerCallback, UnsafeHrTimerPointer,
+    HasHrTimer, HrTimer, HrTimerCallback, HrTimerExpireMode, HrTimerHandle, RawHrTimerCallback,
+    UnsafeHrTimerPointer,
 };
 use crate::time::Instant;
 use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
@@ -46,7 +47,7 @@ fn drop(&mut self) {
 
 // SAFETY: We capture the lifetime of `Self` when we create a
 // `PinMutHrTimerHandle`, so `Self` will outlive the handle.
-unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a mut T>
+unsafe impl<'a, T> UnsafeHrTimerPointer<<T as HasHrTimer<T>>::Mode> for Pin<&'a mut T>
 where
     T: Send + Sync,
     T: HasHrTimer<T>,
@@ -54,7 +55,10 @@ unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a mut T>
 {
     type TimerHandle = PinMutHrTimerHandle<'a, T>;
 
-    unsafe fn start(mut self, expires: Instant) -> Self::TimerHandle {
+    unsafe fn start(
+        mut self,
+        expires: <<T as HasHrTimer<T>>::Mode as HrTimerExpireMode>::Expires,
+    ) -> Self::TimerHandle {
         // SAFETY:
         // - We promise not to move out of `self`. We only pass `self`
         //   back to the caller as a `Pin<&mut self>`.
diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
index 3df4e359e9bb..21aa0aa61cc8 100644
--- a/rust/kernel/time/hrtimer/tbox.rs
+++ b/rust/kernel/time/hrtimer/tbox.rs
@@ -3,6 +3,7 @@
 use super::HasHrTimer;
 use super::HrTimer;
 use super::HrTimerCallback;
+use super::HrTimerExpireMode;
 use super::HrTimerHandle;
 use super::HrTimerPointer;
 use super::RawHrTimerCallback;
@@ -56,7 +57,7 @@ fn drop(&mut self) {
     }
 }
 
-impl<T, A> HrTimerPointer for Pin<Box<T, A>>
+impl<T, A> HrTimerPointer<<T as HasHrTimer<T>>::Mode> for Pin<Box<T, A>>
 where
     T: 'static,
     T: Send + Sync,
@@ -66,7 +67,10 @@ impl<T, A> HrTimerPointer for Pin<Box<T, A>>
 {
     type TimerHandle = BoxHrTimerHandle<T, A>;
 
-    fn start(self, expires: Instant) -> Self::TimerHandle {
+    fn start(
+        self,
+        expires: <<T as HasHrTimer<T>>::Mode as HrTimerExpireMode>::Expires,
+    ) -> Self::TimerHandle {
         // SAFETY:
         //  - We will not move out of this box during timer callback (we pass an
         //    immutable reference to the callback).

