Return-Path: <netdev+bounces-176940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF5EA6CCEB
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 22:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1767ACF8B
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 21:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02141E7C1E;
	Sat, 22 Mar 2025 21:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUVJJQMa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EE91BBBF7;
	Sat, 22 Mar 2025 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742680483; cv=none; b=eV6bMg4vdkn8VitEoooT2ioP1amKX6z+NJ3GJs2YVc6+0qOu4L+R+WctEBQX3a+lZIjk6ZaEBQzmiEsKbXwxc4UX5mQjKUE2QOMYPqVCf3+Yv8yfhb9Y0hAXf+uG978xXsydmLOlPBQl+iH5vEyksxKjAwaHI37PpuWDqNc9Opo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742680483; c=relaxed/simple;
	bh=0ZxExuljQvj3DUUB7dPOGCtNe9zxUAHutoDT6fytzDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q18g0Z2JvTYubgoossLKx76XGfZ5+1DukUnp4PIv5Ib+lZaD07m4+B7AI62eTk40kUUeOmXFw+U7ap8V0HelnRKN8/JX5uOf8vM2FyQtRMCXevWMvNr7sDVWxEkIsPuRlg01sbUECOvFIqqOI6KXeaQCfuB7HQhMe8DdS2fAarw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUVJJQMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E52C4CEDD;
	Sat, 22 Mar 2025 21:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742680481;
	bh=0ZxExuljQvj3DUUB7dPOGCtNe9zxUAHutoDT6fytzDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AUVJJQMaYVD2s0ElzQkI+RxxG+N5PVRlhdFhBnEESjijtstC3Aia/kAuI7JoUd2Li
	 KgP1rzCdcwfFJM8HmgFtlKzYi8B12JFgka4L9Iq72ntEJ+dR8J+gkmVpmJyzBmy086
	 9qmqXilHiAL9ChUlLwfrSilGyIQeeeoAeyWyeXh1MEb/NdB2kJmaNblhQU/bq5leAW
	 LjzJYuAutTk4Q2lbUoWpp9ZoieJJB3eTszy4pBCkdCLwIuCxll7bJ/xe5G/60bFu3b
	 4DC2XeH9FdD1EIvcIOeoQaKxUsCVlpNwEwhQb5InyUdU7Z3WFSzeVckBQ62D+G87QZ
	 d1hIWImiewp4w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Daniel Almeida
 <daniel.almeida@collabora.com>,  Boqun Feng <boqun.feng@gmail.com>,  Gary
 Guo <gary@garyguo.net>,  Fiona Behrens <me@kloenk.dev>,
  rust-for-linux@vger.kernel.org,  netdev@vger.kernel.org,  andrew@lunn.ch,
  hkallweit1@gmail.com,  tmgross@umich.edu,  ojeda@kernel.org,
  alex.gaynor@gmail.com,  bjorn3_gh@protonmail.com,
  benno.lossin@proton.me,  a.hindborg@samsung.com,  aliceryhl@google.com,
  anna-maria@linutronix.de,  frederic@kernel.org,  tglx@linutronix.de,
  arnd@arndb.de,  jstultz@google.com,  sboyd@kernel.org,  mingo@redhat.com,
  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  bsegall@google.com,  mgorman@suse.de,
  vschneid@redhat.com,  tgunders@redhat.com,  david.laight.linux@gmail.com
Subject: Re: [PATCH v11 4/8] rust: time: Introduce Instant type
In-Reply-To: <20250220070611.214262-5-fujita.tomonori@gmail.com> (FUJITA
	Tomonori's message of "Thu, 20 Feb 2025 16:06:06 +0900")
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-5-fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 22 Mar 2025 14:58:16 +0100
Message-ID: <87iko1b213.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:

> Introduce a type representing a specific point in time. We could use
> the Ktime type but C's ktime_t is used for both timestamp and
> timedelta. To avoid confusion, introduce a new Instant type for
> timestamp.
>
> Rename Ktime to Instant and modify their methods for timestamp.
>
> Implement the subtraction operator for Instant:
>
> Delta = Instant A - Instant B
>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


As Boqun mentioned, we should make this generic over `ClockId` when the
hrtimer patches land.

One question regarding overflow below.

> ---
>  rust/kernel/time.rs | 77 +++++++++++++++++++++++----------------------
>  1 file changed, 39 insertions(+), 38 deletions(-)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 622cd01e24d7..d64a05a4f4d1 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -5,6 +5,22 @@
>  //! This module contains the kernel APIs related to time and timers that
>  //! have been ported or wrapped for usage by Rust code in the kernel.
>  //!
> +//! There are two types in this module:
> +//!
> +//! - The [`Instant`] type represents a specific point in time.
> +//! - The [`Delta`] type represents a span of time.
> +//!
> +//! Note that the C side uses `ktime_t` type to represent both. However, timestamp
> +//! and timedelta are different. To avoid confusion, we use two different types.
> +//!
> +//! A [`Instant`] object can be created by calling the [`Instant::now()`] function.
> +//! It represents a point in time at which the object was created.
> +//! By calling the [`Instant::elapsed()`] method, a [`Delta`] object representing
> +//! the elapsed time can be created. The [`Delta`] object can also be created
> +//! by subtracting two [`Instant`] objects.
> +//!
> +//! A [`Delta`] type supports methods to retrieve the duration in various units.
> +//!
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
>  
> @@ -31,59 +47,44 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
>      unsafe { bindings::__msecs_to_jiffies(msecs) }
>  }
>  
> -/// A Rust wrapper around a `ktime_t`.
> +/// A specific point in time.
> +///
> +/// # Invariants
> +///
> +/// The `inner` value is in the range from 0 to `KTIME_MAX`.
>  #[repr(transparent)]
>  #[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
> -pub struct Ktime {
> +pub struct Instant {
>      inner: bindings::ktime_t,
>  }
>  
> -impl Ktime {
> -    /// Create a `Ktime` from a raw `ktime_t`.
> -    #[inline]
> -    pub fn from_raw(inner: bindings::ktime_t) -> Self {
> -        Self { inner }
> -    }
> -
> +impl Instant {
>      /// Get the current time using `CLOCK_MONOTONIC`.
>      #[inline]
> -    pub fn ktime_get() -> Self {
> -        // SAFETY: It is always safe to call `ktime_get` outside of NMI context.
> -        Self::from_raw(unsafe { bindings::ktime_get() })
> -    }
> -
> -    /// Divide the number of nanoseconds by a compile-time constant.
> -    #[inline]
> -    fn divns_constant<const DIV: i64>(self) -> i64 {
> -        self.to_ns() / DIV
> -    }
> -
> -    /// Returns the number of nanoseconds.
> -    #[inline]
> -    pub fn to_ns(self) -> i64 {
> -        self.inner
> +    pub fn now() -> Self {
> +        // INVARIANT: The `ktime_get()` function returns a value in the range
> +        // from 0 to `KTIME_MAX`.
> +        Self {
> +            // SAFETY: It is always safe to call `ktime_get()` outside of NMI context.
> +            inner: unsafe { bindings::ktime_get() },
> +        }
>      }
>  
> -    /// Returns the number of milliseconds.
> +    /// Return the amount of time elapsed since the [`Instant`].
>      #[inline]
> -    pub fn to_ms(self) -> i64 {
> -        self.divns_constant::<NSEC_PER_MSEC>()
> +    pub fn elapsed(&self) -> Delta {
> +        Self::now() - *self
>      }
>  }
>  
> -/// Returns the number of milliseconds between two ktimes.
> -#[inline]
> -pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
> -    (later - earlier).to_ms()
> -}
> -
> -impl core::ops::Sub for Ktime {
> -    type Output = Ktime;
> +impl core::ops::Sub for Instant {
> +    type Output = Delta;
>  
> +    // By the type invariant, it never overflows.
>      #[inline]
> -    fn sub(self, other: Ktime) -> Ktime {
> -        Self {
> -            inner: self.inner - other.inner,
> +    fn sub(self, other: Instant) -> Delta {
> +        Delta {
> +            nanos: self.inner - other.inner,

If this never overflows by invariant, would it make sense to use
`unchecked_sub` or `wraping_sub`? That would remove the overflow check.


Best regards,
Andreas Hindborg



