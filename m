Return-Path: <netdev+bounces-136517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 162699A1F95
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA7D28BF68
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D4B1D958E;
	Thu, 17 Oct 2024 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="f57/N+uw"
X-Original-To: netdev@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4CC1D934D;
	Thu, 17 Oct 2024 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160255; cv=none; b=R3E+j4MRs05za4EqRK32D9afIsNnn8ja7s2Nm+RuO2ZRjfv+MOfMJozXiMcWu4TVL078Cul30mZHkm+HGev3D2vCx7TeuslC5tBBHVc3Vz1rJ1cYr9Q2e6oyXHI6gQb/04taCLOwACtSxoAowD+uHvT2jiK0/G9IHDhiEYnp7Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160255; c=relaxed/simple;
	bh=EwWDEYXey4WDoGsLOcsVgmZ9iPzA8QJbBaHFfctEqKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGlvdiFM3YMcHh+0r46zU430P8P7oQ/dqwU2stt3NNua3MTToZdHZ/inOpXvuLxrqH6RPKYJtKS60bAtK4TgJ7KiUr9qqQU1A7d5XxmfBHAfwEO8IM9XUtGEWYz1osAPTqi8qAYv8n17xLS8KbHqgPrRRjsX2Zuk9v9Fc9iDQRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=f57/N+uw; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1729160240; bh=02VH0LcaXYOSt5Ygu+ODELH9eyHzbdRPgQj7dW0zZC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f57/N+uwS/kEYp2WGLhAKtqghOOt+0qganLxeYpqOG1aH6OnakUAyjYlkRZGqz4kP
	 7qCnVDW3k2oj0cBP8/HzW1buVFFlWXseY/+oRzkUFVsrb58qOPU8fjOPx3QgtFaQXA
	 NDs4fnFbrhACQPOHXSh9L5+RhzczmEITsPbfmclI=
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] rust: time: Introduce Delta type
Date: Thu, 17 Oct 2024 12:17:18 +0200
Message-ID: <89854EA9-63AC-447C-807C-964BB61FF0D6@kloenk.dev>
In-Reply-To: <20241016035214.2229-3-fujita.tomonori@gmail.com>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 16 Oct 2024, at 5:52, FUJITA Tomonori wrote:

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
> Delta::from_[micro|millis|secs] APIs take i64. When a span of time
> overflows, i64::MAX is used.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/time.rs | 74 +++++++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 74 insertions(+)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 4a7c6037c256..38a70dc98083 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -8,9 +8,15 @@
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffie=
s.h).
>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h)=
=2E
>
> +/// The number of nanoseconds per microsecond.
> +pub const NSEC_PER_USEC: i64 =3D bindings::NSEC_PER_USEC as i64;
> +
>  /// The number of nanoseconds per millisecond.
>  pub const NSEC_PER_MSEC: i64 =3D bindings::NSEC_PER_MSEC as i64;
>
> +/// The number of nanoseconds per second.
> +pub const NSEC_PER_SEC: i64 =3D bindings::NSEC_PER_SEC as i64;
> +
>  /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
>  pub type Jiffies =3D core::ffi::c_ulong;
>
> @@ -81,3 +87,71 @@ fn sub(self, other: Ktime) -> Ktime {
>          }
>      }
>  }
> +
> +/// A span of time.
> +#[derive(Copy, Clone)]

Could we also derive PartialEq and Eq (maybe also PartialOrd and Ord)? Wo=
uld need that to compare deltas in my LED driver.

> +pub struct Delta {
> +    nanos: i64,
> +}
> +

I think all this functions could be const (need from_millis as const for =
LED, but when at it we could probably make all those const?)

 - Fiona

> +impl Delta {
> +    /// Create a new `Delta` from a number of nanoseconds.
> +    #[inline]
> +    pub fn from_nanos(nanos: i64) -> Self {
> +        Self { nanos }
> +    }
> +
> +    /// Create a new `Delta` from a number of microseconds.
> +    #[inline]
> +    pub fn from_micros(micros: i64) -> Self {
> +        Self {
> +            nanos: micros.saturating_mul(NSEC_PER_USEC),
> +        }
> +    }
> +
> +    /// Create a new `Delta` from a number of milliseconds.
> +    #[inline]
> +    pub fn from_millis(millis: i64) -> Self {
> +        Self {
> +            nanos: millis.saturating_mul(NSEC_PER_MSEC),
> +        }
> +    }
> +
> +    /// Create a new `Delta` from a number of seconds.
> +    #[inline]
> +    pub fn from_secs(secs: i64) -> Self {
> +        Self {
> +            nanos: secs.saturating_mul(NSEC_PER_SEC),
> +        }
> +    }
> +
> +    /// Return `true` if the `Detla` spans no time.
> +    #[inline]
> +    pub fn is_zero(self) -> bool {
> +        self.nanos =3D=3D 0
> +    }
> +
> +    /// Return the number of nanoseconds in the `Delta`.
> +    #[inline]
> +    pub fn as_nanos(self) -> i64 {
> +        self.nanos
> +    }
> +
> +    /// Return the number of microseconds in the `Delta`.
> +    #[inline]
> +    pub fn as_micros(self) -> i64 {
> +        self.nanos / NSEC_PER_USEC
> +    }
> +
> +    /// Return the number of milliseconds in the `Delta`.
> +    #[inline]
> +    pub fn as_millis(self) -> i64 {
> +        self.nanos / NSEC_PER_MSEC
> +    }
> +
> +    /// Return the number of seconds in the `Delta`.
> +    #[inline]
> +    pub fn as_secs(self) -> i64 {
> +        self.nanos / NSEC_PER_SEC
> +    }
> +}
> -- =

> 2.43.0

