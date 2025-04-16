Return-Path: <netdev+bounces-183118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE74A8AE97
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 05:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C62C19013F7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD43D1D6DB6;
	Wed, 16 Apr 2025 03:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eqk+mUIY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C598115B543;
	Wed, 16 Apr 2025 03:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775202; cv=none; b=jREjUbHTz0MDeFTb2YJEEJrVeNbe98sIZGfQtmu33LSmtzKv5PankblML3oUe/KGHdtfJ2zhrZLhiHaR29BY06k174azoefpRfEjtUqEgEBxvScmpkzNTcIPoZF4nL35P0hi09K7ijcHgiC9SgRS7qMAALRWRjIz2VEXbWC8Gok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775202; c=relaxed/simple;
	bh=qfQGAx7ujA6mv9BqGg4+7VgDxR7WOgloe6QYeVhu6gw=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CiT8vo+Nh1R1py4NgnVoqo0/FsinG/fbY6bAHQJdTsUA1macWlDif+h6z6oN3ALeUPrhL/yuGLRRuUkCC9G1zSX1NxawiV0uCBxkCcf5TFNCvv1o7obUnD53Pe8BdrZ7jzGZftcRIBkxH6iPHoeW38j4s9LDPx6Bo9Cp4tSxvbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eqk+mUIY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22401f4d35aso72799285ad.2;
        Tue, 15 Apr 2025 20:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744775200; x=1745380000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EC5cRJ3DrdY8cRnwQGP/NwhxQE3eh7uMlEYNYdFTgqk=;
        b=Eqk+mUIYUvpFxCi9sbGLk1YHfvRXe1fetIiijqKC/tN99o656PRrHgMINiFcuHrwyq
         FpMlowHHE9aGreRFvFXCfq5ImxBOYNFy9c0IKXXwF11/Ug5eEWiH0OeWbxT8EExyMoT6
         rtGpGPOhl0s+Ee/jfCqAr0RBAT3NbaO9urohQA5Aq+kG+1s/9j2fKL+shcgKVRkVd5RG
         xj9CY/dVG2y0Iueoq9kqrBu3VMY74sE4kJmLrCP7SA2/+fOgwdUDj1ThJ21Q8/UYT/4k
         Y2bgF1iLNelx96Scz5GSOCHne8fpw+h99iN7tCzI/IZBnVBVSSb6am/TwdpW9YboL+hD
         220A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744775200; x=1745380000;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EC5cRJ3DrdY8cRnwQGP/NwhxQE3eh7uMlEYNYdFTgqk=;
        b=Yja/fmm7v5M1y65DCuU4/F/I7T4Vur9Hexu/c1YVbFt8GkYQBmeAu/sMSs/fdc2roS
         1cEzTRr51/94+6Xo0qw44/J2cAB4Jr0Tubikskf7Ug1DbVzXAou0WDrXJ0wljEzfELy3
         SIRg3kzbW/tciFmaWFqqtdN3dXYh2eCGJlmnM0w1MUfR76l793GIZunyCkpb8ixt4VV4
         nc4dHjVdCTd2SKPkAAbcPaO0T1TrAIor6Tku6+LC6voGzaKfJ9U3VWh/Odb0ktSU6tMI
         iA6KhRLxL0vE9ZtkERJDHcN+fwusigoji6XbW+/QzEh1jvHPt5JbN8EKIfoBHShuxOmu
         DAvw==
X-Forwarded-Encrypted: i=1; AJvYcCUl0oV65L+80JrWnw2Pc7ITFGP0l+1ZCNkQGoP6OxotbL3kXtvgNunl2lM7HOAoBa73hBlYhrWb@vger.kernel.org, AJvYcCXVCuFoupPi3ijsEVN3BhZyRAHp78YZQ50ieTYcjtI+8s2uEb5aaFMSr+62nLOkn5F5jBf6kCQBUUMty1k=@vger.kernel.org, AJvYcCXr9QnOkM3kBYq12qJ4rOIjbWKdkjwB4PEYB2b5kn+Zr5aAoUbHCeOI4o7iUUaVnTJDFE+D0YVehmSe16A7TaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPrmF9TU+fL7ntAMpi2JyKW0j5DV1vjDyWxuAwushkl4gqRje
	yTwfnDtQRMPC+kwxgtkMqppj5EtzekW3sk/gQaAufwzhC3qU/ZZB
X-Gm-Gg: ASbGncs0wcudXggRO7sVRco6et0OmUoGL6jC3XGGPzKHsALQio1b10CgU+/o7yCtXMu
	m3Rdb47t0DQENRUgMPnxy5FmwxD/jdPWR6DGbFtrHk/uPWO/Gf4LcBAQ7NdUFlRTHqvmPn9R7SI
	scigZ9ZB6M4+SxOnLKcYQv3iQJnC+mm4slB1wPrgQNi+U/stkJULY3a5Wfn5AxcLMhIxbUqk2Au
	TUbNAzXJTwk9+w3sqHDAyRYkb56p0Vv7YpBOxctLKFiZMQsmcbR33uy96i7ftCHNEoYvFTy/HDK
	ut4590o7Gdy+eLydknpOpSJRAVkcNIwRxjRMrhuQLQglaCX5BGB3zIocAeJk2lLAVt1SvhU7mg/
	ojkmVsmgvij72mPENhiVRsiEew0aKICP+4Q==
X-Google-Smtp-Source: AGHT+IGjrqlAd6Wb+ZXgS3zMNNwprjxMJ2s0Miw+SsiZpvGfwsIOpcwqiCXlp4hEzohHhkL8iDmH8A==
X-Received: by 2002:a17:902:d2ca:b0:224:1eaa:5de1 with SMTP id d9443c01a7336-22c358d9cecmr4645315ad.18.1744775199732;
        Tue, 15 Apr 2025 20:46:39 -0700 (PDT)
Received: from localhost (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd23332a3sm9347267b3a.161.2025.04.15.20.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 20:46:39 -0700 (PDT)
Date: Wed, 16 Apr 2025 12:46:24 +0900 (JST)
Message-Id: <20250416.124624.303652240226377083.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org, boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, rust-for-linux@vger.kernel.org,
 gary@garyguo.net, me@kloenk.dev, daniel.almeida@collabora.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com,
 david.laight.linux@gmail.com
Subject: Re: [PATCH v13 3/5] rust: time: Introduce Instant type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <67fe9efe.d40a0220.aa401.b05f@mx.google.com>
References: <87lds3cjgx.fsf@kernel.org>
	<20250414.205954.2258973048785103265.fujita.tomonori@gmail.com>
	<67fe9efe.d40a0220.aa401.b05f@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 11:01:30 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Mon, Apr 14, 2025 at 08:59:54PM +0900, FUJITA Tomonori wrote:
>> On Mon, 14 Apr 2025 09:04:14 +0200
>> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>> 
>> > "Boqun Feng" <boqun.feng@gmail.com> writes:
>> > 
>> >> On Sun, Apr 13, 2025 at 07:43:08PM +0900, FUJITA Tomonori wrote:
>> >>> Introduce a type representing a specific point in time. We could use
>> >>> the Ktime type but C's ktime_t is used for both timestamp and
>> >>> timedelta. To avoid confusion, introduce a new Instant type for
>> >>> timestamp.
>> >>>
>> >>> Rename Ktime to Instant and modify their methods for timestamp.
>> >>>
>> >>> Implement the subtraction operator for Instant:
>> >>>
>> >>> Delta = Instant A - Instant B
>> >>>
>> >>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>> >>
>> >> I probably need to drop my Reviewed-by because of something below:
>> >>
>> >>> Reviewed-by: Gary Guo <gary@garyguo.net>
>> >>> Reviewed-by: Fiona Behrens <me@kloenk.dev>
>> >>> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
>> >>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> >>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> >>> ---
>> >> [...]
>> >>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>> >>> index ce53f8579d18..27243eaaf8ed 100644
>> >>> --- a/rust/kernel/time/hrtimer.rs
>> >>> +++ b/rust/kernel/time/hrtimer.rs
>> >>> @@ -68,7 +68,7 @@
>> >>>  //! `start` operation.
>> >>>
>> >>>  use super::ClockId;
>> >>> -use crate::{prelude::*, time::Ktime, types::Opaque};
>> >>> +use crate::{prelude::*, time::Instant, types::Opaque};
>> >>>  use core::marker::PhantomData;
>> >>>  use pin_init::PinInit;
>> >>>
>> >>> @@ -189,7 +189,7 @@ pub trait HrTimerPointer: Sync + Sized {
>> >>>
>> >>>      /// Start the timer with expiry after `expires` time units. If the timer was
>> >>>      /// already running, it is restarted with the new expiry time.
>> >>> -    fn start(self, expires: Ktime) -> Self::TimerHandle;
>> >>> +    fn start(self, expires: Instant) -> Self::TimerHandle;
>> >>
>> >> We should be able to use what I suggested:
>> >>
>> >> 	https://lore.kernel.org/rust-for-linux/Z_ALZsnwN53ZPBrB@boqun-archlinux/
>> >>
>> >> to make different timer modes (rel or abs) choose different expire type.
>> >>
>> >> I don't think we can merge this patch as it is, unfortunately, because
>> >> it doesn't make sense for a relative timer to take an Instant as expires
>> >> value.
>> > 
>> > I told Tomo he could use `Instant` in this location and either he or I
>> > would fix it up later [1].
>> > 
> 
> I saw that, however, I don't think we can put `Instant` as the parameter
> for HrTimerPointer::start() because we don't yet know how long would the
> fix-it-up-later take. And it would confuse users if they need a put an
> Instant for relative time.
> 
>> > I don't want to block the series on this since the new API is not worse
>> > than the old one where Ktime is overloaded for both uses.
> 
> How about we keep Ktime? That is HrTimerPointer::start() still uses
> Ktime, until we totally finish the refactoring as Tomo show below?
> `Ktime` is much better here because it at least matches C API behavior,
> we can remove `Ktime` once the dust is settled. Thoughts?

Either is fine with me. I'll leave it to Andreas' judgment.

Andreas, if you like Boqun's approach, I'll replace the third patch
with the following one and send v14.

I added Ktime struct to hrtimer.rs so the well-reviewed changes to
time.rs remain unchanged.

---
rust: time: Introduce Instant type

Introduce a type representing a specific point in time. We could use
the Ktime type but C's ktime_t is used for both timestamp and
timedelta. To avoid confusion, introduce a new Instant type for
timestamp.

Rename Ktime to Instant and modify their methods for timestamp.

Implement the subtraction operator for Instant:

Delta = Instant A - Instant B

Note that hrtimer still uses the Ktime type for now. It will be
replaced with Instant and Delta types later.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs                 | 77 +++++++++++++++--------------
 rust/kernel/time/hrtimer.rs         | 17 ++++++-
 rust/kernel/time/hrtimer/arc.rs     |  2 +-
 rust/kernel/time/hrtimer/pin.rs     |  2 +-
 rust/kernel/time/hrtimer/pin_mut.rs |  4 +-
 rust/kernel/time/hrtimer/tbox.rs    |  2 +-
 6 files changed, 60 insertions(+), 44 deletions(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index e00b9a853e6a..a8089a98da9e 100644
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
 
@@ -33,59 +49,44 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
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
diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index ce53f8579d18..f46b41d3c31e 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -68,10 +68,25 @@
 //! `start` operation.
 
 use super::ClockId;
-use crate::{prelude::*, time::Ktime, types::Opaque};
+use crate::{prelude::*, types::Opaque};
 use core::marker::PhantomData;
 use pin_init::PinInit;
 
+/// A Rust wrapper around a `ktime_t`.
+#[repr(transparent)]
+#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
+pub struct Ktime {
+    inner: bindings::ktime_t,
+}
+
+impl Ktime {
+    /// Returns the number of nanoseconds.
+    #[inline]
+    pub fn to_ns(self) -> i64 {
+        self.inner
+    }
+}
+
 /// A timer backed by a C `struct hrtimer`.
 ///
 /// # Invariants
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
index 4a984d85b4a1..ccf1e66e5b2d 100644
--- a/rust/kernel/time/hrtimer/arc.rs
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -5,10 +5,10 @@
 use super::HrTimerCallback;
 use super::HrTimerHandle;
 use super::HrTimerPointer;
+use super::Ktime;
 use super::RawHrTimerCallback;
 use crate::sync::Arc;
 use crate::sync::ArcBorrow;
-use crate::time::Ktime;
 
 /// A handle for an `Arc<HasHrTimer<T>>` returned by a call to
 /// [`HrTimerPointer::start`].
diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
index f760db265c7b..293ca9cf058c 100644
--- a/rust/kernel/time/hrtimer/pin.rs
+++ b/rust/kernel/time/hrtimer/pin.rs
@@ -4,9 +4,9 @@
 use super::HrTimer;
 use super::HrTimerCallback;
 use super::HrTimerHandle;
+use super::Ktime;
 use super::RawHrTimerCallback;
 use super::UnsafeHrTimerPointer;
-use crate::time::Ktime;
 use core::pin::Pin;
 
 /// A handle for a `Pin<&HasHrTimer>`. When the handle exists, the timer might be
diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
index 90c0351d62e4..6033572d35ad 100644
--- a/rust/kernel/time/hrtimer/pin_mut.rs
+++ b/rust/kernel/time/hrtimer/pin_mut.rs
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use super::{
-    HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, RawHrTimerCallback, UnsafeHrTimerPointer,
+    HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, Ktime, RawHrTimerCallback,
+    UnsafeHrTimerPointer,
 };
-use crate::time::Ktime;
 use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
 
 /// A handle for a `Pin<&mut HasHrTimer>`. When the handle exists, the timer might
diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
index 2071cae07234..29526a5da203 100644
--- a/rust/kernel/time/hrtimer/tbox.rs
+++ b/rust/kernel/time/hrtimer/tbox.rs
@@ -5,9 +5,9 @@
 use super::HrTimerCallback;
 use super::HrTimerHandle;
 use super::HrTimerPointer;
+use super::Ktime;
 use super::RawHrTimerCallback;
 use crate::prelude::*;
-use crate::time::Ktime;
 use core::ptr::NonNull;
 
 /// A handle for a [`Box<HasHrTimer<T>>`] returned by a call to
-- 
2.43.0




