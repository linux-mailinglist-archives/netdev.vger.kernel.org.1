Return-Path: <netdev+bounces-176857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A4FA6C939
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 11:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897CB189010F
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 10:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400201F4CAF;
	Sat, 22 Mar 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAixLSS3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD22AD20;
	Sat, 22 Mar 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742639276; cv=none; b=CHGjch9HbZGZ33c7zu9rzSVCnA78ohs/SnGlASFBhUJxWmoJL9kwxyvP1YzO9NqhhbO7Qq0gV3KleGXszRZRyXMeiqd1KLy0879AnyEIXm7ax81cZ+5rfk+vJth/s7oJOq56kh1doGH4w/77sW9aStQW/w6gPJHqxx9boerJLdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742639276; c=relaxed/simple;
	bh=vLWfAQEsX8V/JhXcponrpJXR7sIl61gCbFDK1wZH7ZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ikjh1Siyvt50XA9kXhdqYSLuD9Ui05JLDVsNn0pxOboitC+he0tZ83O5Sn0yWz6Zn35w8bUQmLLIsJpG/0nopfix6hI3ROKxB/PtmDZ/Qybn2TozQRpeNNOkbrpcjQhKMT58JZsV/HK1EpwkBrwr/I710EKkq8fONsULqH8wDuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAixLSS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01179C4CEED;
	Sat, 22 Mar 2025 10:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742639275;
	bh=vLWfAQEsX8V/JhXcponrpJXR7sIl61gCbFDK1wZH7ZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XAixLSS3Kmb4bav7wKHDl16DBJM+KOO8A1Bj/akdC/Rzi1ifuKnKjFghzXtjyc31j
	 1QGOm5p8+750FEnvGEKGFSZSs+sb3r+qilu9Q5r42c077uabw2PyWotudk8ghDD9mt
	 3TKwbIgxeq7yLYHIMhMN/uvUMXa5SBu4X2ty7dcChKjB6xpj5gxTG1j4w2Ha9JlFLr
	 yrMGjbzDGkjLCF1fUqIwNi9nc4Hqno9eQmhzxphwAUQRBH4Agy1YMLt8IRNjvL22xL
	 3+C1YHVx9vZT4v0zMKCTiim1St6IHeVZwHHrfQ0aPUH8kszrF3fA0VYIcVkXMbQbPm
	 UEK1sYxZzMFyA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Daniel Almeida
 <daniel.almeida@collabora.com>,  Andrew Lunn <andrew@lunn.ch>,  Alice Ryhl
 <aliceryhl@google.com>,  Gary Guo <gary@garyguo.net>,  Fiona Behrens
 <me@kloenk.dev>,  rust-for-linux@vger.kernel.org,  netdev@vger.kernel.org,
  hkallweit1@gmail.com,  tmgross@umich.edu,  ojeda@kernel.org,
  alex.gaynor@gmail.com,  bjorn3_gh@protonmail.com,
  benno.lossin@proton.me,  a.hindborg@samsung.com,
  anna-maria@linutronix.de,  frederic@kernel.org,  tglx@linutronix.de,
  arnd@arndb.de,  jstultz@google.com,  sboyd@kernel.org,  mingo@redhat.com,
  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  bsegall@google.com,  mgorman@suse.de,
  vschneid@redhat.com,  tgunders@redhat.com,  david.laight.linux@gmail.com
Subject: Re: [PATCH v11 3/8] rust: time: Introduce Delta type
In-Reply-To: <20250220070611.214262-4-fujita.tomonori@gmail.com> (FUJITA
	Tomonori's message of "Thu, 20 Feb 2025 16:06:05 +0900")
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-4-fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 22 Mar 2025 09:50:48 +0100
Message-ID: <8734f5cutz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:

> Introduce a type representing a span of time. Define our own type
> because `core::time::Duration` is large and could panic during
> creation.
>
> time::Ktime could be also used for time duration but timestamp and
> timedelta are different so better to use a new type.
>
> i64 is used instead of u64 to represent a span of time; some C drivers
> uses negative Deltas and i64 is more compatible with Ktime using i64
> too (e.g., ktime_[us|ms]_delta() APIs return i64 so we create Delta
> object without type conversion.
>
> i64 is used instead of bindings::ktime_t because when the ktime_t
> type is used as timestamp, it represents values from 0 to
> KTIME_MAX, which is different from Delta.
>
> as_millis() method isn't used in this patchset. It's planned to be
> used in Binder driver.
>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Two suggestions below, take or leave.

> ---
>  rust/kernel/time.rs | 88 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 48b71e6641ce..622cd01e24d7 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -8,9 +8,15 @@
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
>  
> +/// The number of nanoseconds per microsecond.
> +pub const NSEC_PER_USEC: i64 = bindings::NSEC_PER_USEC as i64;
> +
>  /// The number of nanoseconds per millisecond.
>  pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
>  
> +/// The number of nanoseconds per second.
> +pub const NSEC_PER_SEC: i64 = bindings::NSEC_PER_SEC as i64;
> +
>  /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
>  pub type Jiffies = crate::ffi::c_ulong;
>  
> @@ -81,3 +87,85 @@ fn sub(self, other: Ktime) -> Ktime {
>          }
>      }
>  }
> +
> +/// A span of time.
> +///
> +/// This struct represents a span of time, with its value stored as nanoseconds.
> +/// The value can represent any valid i64 value, including negative, zero, and
> +/// positive numbers.
> +#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord, Debug)]
> +pub struct Delta {
> +    nanos: i64,
> +}
> +
> +impl Delta {
> +    /// A span of time equal to zero.
> +    pub const ZERO: Self = Self { nanos: 0 };
> +
> +    /// Create a new [`Delta`] from a number of microseconds.
> +    ///
> +    /// The `micros` can range from -9_223_372_036_854_775 to 9_223_372_036_854_775.

To make these numbers truly useful, it would be nice to have them as
constants, for example `Delta::MAX_MICROS`, `Delta::MIN_MICROS`.

> +    /// If `micros` is outside this range, `i64::MIN` is used for negative values,
> +    /// and `i64::MAX` is used for positive values due to saturation.
> +    #[inline]
> +    pub const fn from_micros(micros: i64) -> Self {
> +        Self {
> +            nanos: micros.saturating_mul(NSEC_PER_USEC),
> +        }
> +    }
> +
> +    /// Create a new [`Delta`] from a number of milliseconds.
> +    ///
> +    /// The `millis` can range from -9_223_372_036_854 to 9_223_372_036_854.
> +    /// If `millis` is outside this range, `i64::MIN` is used for negative values,
> +    /// and `i64::MAX` is used for positive values due to saturation.
> +    #[inline]
> +    pub const fn from_millis(millis: i64) -> Self {
> +        Self {
> +            nanos: millis.saturating_mul(NSEC_PER_MSEC),
> +        }
> +    }
> +
> +    /// Create a new [`Delta`] from a number of seconds.
> +    ///
> +    /// The `secs` can range from -9_223_372_036 to 9_223_372_036.
> +    /// If `secs` is outside this range, `i64::MIN` is used for negative values,
> +    /// and `i64::MAX` is used for positive values due to saturation.
> +    #[inline]
> +    pub const fn from_secs(secs: i64) -> Self {
> +        Self {
> +            nanos: secs.saturating_mul(NSEC_PER_SEC),
> +        }
> +    }
> +
> +    /// Return `true` if the [`Delta`] spans no time.
> +    #[inline]
> +    pub fn is_zero(self) -> bool {
> +        self.as_nanos() == 0
> +    }
> +
> +    /// Return `true` if the [`Delta`] spans a negative amount of time.
> +    #[inline]
> +    pub fn is_negative(self) -> bool {
> +        self.as_nanos() < 0
> +    }
> +
> +    /// Return the number of nanoseconds in the [`Delta`].
> +    #[inline]
> +    pub const fn as_nanos(self) -> i64 {
> +        self.nanos
> +    }
> +
> +    /// Return the smallest number of microseconds greater than or equal
> +    /// to the value in the [`Delta`].
> +    #[inline]
> +    pub const fn as_micros_ceil(self) -> i64 {
> +        self.as_nanos().saturating_add(NSEC_PER_USEC - 1) / NSEC_PER_USEC
> +    }
> +
> +    /// Return the number of milliseconds in the [`Delta`].

We might consider adding "rounded towards zero" to this doc string.


Best regards,
Andreas Hindborg



