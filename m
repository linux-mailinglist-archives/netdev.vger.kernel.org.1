Return-Path: <netdev+bounces-161299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC402A208A9
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 11:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF86E188797E
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 10:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C6F19D087;
	Tue, 28 Jan 2025 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="WHGNPrCL"
X-Original-To: netdev@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBC919D8A2;
	Tue, 28 Jan 2025 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060668; cv=none; b=KgfAvwSw+LzlDWAC6lEDWL0QV9tVbdsSl3hY3fHCOLYMsJE5GpecVLMdiTWJ9YUHfYv29i9vdsDCSS/KykVUhF/d2yyy0CaWmyOJfjGkrrSR7ZoCkpa9Bv1d0isAEYNVe/lxbLET9UWm7TTcIJebRMqJmzEpS3bmbkPRJfzilXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060668; c=relaxed/simple;
	bh=J5/Vx9QGK/5guF29mxCjOCY3nClAAPUBwwr9t9b2Ts8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tutlhXW/J1vOtvUxcJtIdtjWllLgEP7wVIT1GNdP9SLWCuG9azAnRa0jriZP8rqwniqw64CBwC5Fv7ikLZJZdyPUAD4cdVWpdFS40SZe5n1NqVr9N9EwP+BdYJXI8uVpaodrw3vQyfiRS8XxoZYmMuonYKU6HprhCxN0ZQXOTt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=WHGNPrCL; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1738060663; bh=wllYclaLxUYQNyuG1jr38OF3SHspdtratLV3VjnhYdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WHGNPrCL/J2vpGe7lXoQK7IR7druK4V6JSkL8CSuOXUIINzXZEgxLboSUKdHYItsZ
	 7SFbC1nQiQdT67lwZspLEqDlfN6UrWC7Dd0GOjPVU5iGW5OTJx65VLHDtdv7XXbgDs
	 Ro50G4d1/0Cbpqk9ssuPoQFnb2Cw2CGIK8iS8bG8=
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com
Subject: Re: [PATCH v9 5/8] rust: time: Add wrapper for fsleep() function
Date: Tue, 28 Jan 2025 11:37:41 +0100
Message-ID: <EED019B1-8DEB-43BF-8F59-1A71520F5ABB@kloenk.dev>
In-Reply-To: <20250125101854.112261-6-fujita.tomonori@gmail.com>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
 <20250125101854.112261-6-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 25 Jan 2025, at 11:18, FUJITA Tomonori wrote:

> Add a wrapper for fsleep(), flexible sleep functions in
> include/linux/delay.h which typically deals with hardware delays.
>
> The kernel supports several sleep functions to handle various lengths
> of delay. This adds fsleep(), automatically chooses the best sleep
> method based on a duration.
>
> sleep functions including fsleep() belongs to TIMERS, not
> TIMEKEEPING. They are maintained separately. rust/kernel/time.rs is an
> abstraction for TIMEKEEPING. To make Rust abstractions match the C
> side, add rust/kernel/time/delay.rs for this wrapper.
>
> fsleep() can only be used in a nonatomic context. This requirement is
> not checked by these abstractions, but it is intended that klint [1]
> or a similar tool will be used to check it in the future.
>
> Link: https://rust-for-linux.com/klint [1]
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

One question below, but fine with this as well

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  rust/helpers/helpers.c    |  1 +
>  rust/helpers/time.c       |  8 +++++++
>  rust/kernel/time.rs       |  2 ++
>  rust/kernel/time/delay.rs | 49 +++++++++++++++++++++++++++++++++++++++=

>  4 files changed, 60 insertions(+)
>  create mode 100644 rust/helpers/time.c
>  create mode 100644 rust/kernel/time/delay.rs
>
(..)
> diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
> new file mode 100644
> index 000000000000..02b8731433c7
> --- /dev/null
> +++ b/rust/kernel/time/delay.rs
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Delay and sleep primitives.
> +//!
> +//! This module contains the kernel APIs related to delay and sleep th=
at
> +//! have been ported or wrapped for usage by Rust code in the kernel.
> +//!
> +//! C header: [`include/linux/delay.h`](srctree/include/linux/delay.h)=
=2E
> +
> +use super::Delta;
> +use crate::ffi::c_ulong;
> +
> +/// Sleeps for a given duration at least.
> +///
> +/// Equivalent to the C side [`fsleep()`], flexible sleep function,
> +/// which automatically chooses the best sleep method based on a durat=
ion.
> +///
> +/// `delta` must be within `[0, i32::MAX]` microseconds;
> +/// otherwise, it is erroneous behavior. That is, it is considered a b=
ug
> +/// to call this function with an out-of-range value, in which case th=
e function
> +/// will sleep for at least the maximum value in the range and may war=
n
> +/// in the future.
> +///
> +/// The behavior above differs from the C side [`fsleep()`] for which =
out-of-range
> +/// values mean "infinite timeout" instead.
> +///
> +/// This function can only be used in a nonatomic context.
> +///
> +/// [`fsleep`]: https://docs.kernel.org/timers/delay_sleep_functions.h=
tml#c.fsleep
> +pub fn fsleep(delta: Delta) {
> +    // The maximum value is set to `i32::MAX` microseconds to prevent =
integer
> +    // overflow inside fsleep, which could lead to unintentional infin=
ite sleep.
> +    const MAX_DELTA: Delta =3D Delta::from_micros(i32::MAX as i64);
> +
> +    let delta =3D if (Delta::ZERO..=3DMAX_DELTA).contains(&delta) {
> +        delta
> +    } else {
> +        // TODO: Add WARN_ONCE() when it's supported.
> +        MAX_DELTA
> +    };

Did you try that with std::cmp::Ord you derived on Delta? This `.contains=
` looks a bit weird, maybe it also works with `delta <=3D MAX_DELTA`?

> +
> +    // SAFETY: It is always safe to call `fsleep()` with any duration.=

> +    unsafe {
> +        // Convert the duration to microseconds and round up to preser=
ve
> +        // the guarantee; `fsleep()` sleeps for at least the provided =
duration,
> +        // but that it may sleep for longer under some circumstances.
> +        bindings::fsleep(delta.as_micros_ceil() as c_ulong)
> +    }
> +}
> -- =

> 2.43.0

