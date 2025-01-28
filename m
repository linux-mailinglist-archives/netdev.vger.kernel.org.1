Return-Path: <netdev+bounces-161303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 253A2A20904
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 11:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628D03A2197
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 10:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F51019E971;
	Tue, 28 Jan 2025 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="i7ZHd+8l"
X-Original-To: netdev@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B875119DF61;
	Tue, 28 Jan 2025 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738061569; cv=none; b=bmSLRJ+79BLRMTPZ0RJUISpaP7HztEyPGMVKxuF/BEcnbuIrRLXEtQuVo+qeJYr4QPBufPnO0CIuDw32hOrNN+79J0E/xKkC5alyMF579gIoIlEG/yUvCpVggTJeswkX14qZlkz78QPPd/jFEN3H4VuKyqYs6+aYmhvhVpp+jT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738061569; c=relaxed/simple;
	bh=PfCdzxsbws1eBdcw38huDK/jKhGdbdGpeOJKZkwLwKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMaPiV3TbsLKbUzSiL7EkWyVgl/OeOEBrskcJN2OmtjPHy5amvl6Gvnv8SAL77LsO7kXfEEbS2Ct2eJO1rWuf861uchVl24TkJpqtlN1zguwGI+e8ZgHGf8oABAu3QIap+M/DpgQy7h4uzMG+pu3srU2SaoqcytQce0OZ69S7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=i7ZHd+8l; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1738061564; bh=GVAB7md79HnKqybn7MqI9eX/+oFlbzYDCqZBX2HB8cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i7ZHd+8lqRITRgcHAjo9tgTaALap3ECpCiMw2MYGIUehtPe4nkOTf4ZLbXYNBgr5s
	 qqutonTK3jR+3Yk0kXTnPpWMfH9tx9ubASu4P/YlTutXCJbtitkbh4UfiQgOlNQ4Ag
	 YadB3juUQ6yJ1k/QvSiyo5Vi2LoVb+BwvByhOIbA=
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
Subject: Re: [PATCH v9 7/8] rust: Add read_poll_timeout functions
Date: Tue, 28 Jan 2025 11:52:42 +0100
Message-ID: <C466653B-D8DA-4176-8059-7FD60F76040E@kloenk.dev>
In-Reply-To: <20250125101854.112261-8-fujita.tomonori@gmail.com>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
 <20250125101854.112261-8-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 25 Jan 2025, at 11:18, FUJITA Tomonori wrote:

> Add read_poll_timeout functions which poll periodically until a
> condition is met or a timeout is reached.
>
> The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
> macro and a simple wrapper for Rust doesn't work. So this implements
> the same functionality in Rust.
>
> The C version uses usleep_range() while the Rust version uses
> fsleep(), which uses the best sleep method so it works with spans that
> usleep_range() doesn't work nicely with.
>
> Unlike the C version, __might_sleep() is used instead of might_sleep()
> to show proper debug info; the file name and line
> number. might_resched() could be added to match what the C version
> does but this function works without it.
>
> The sleep_before_read argument isn't supported since there is no user
> for now. It's rarely used in the C version.
>
> read_poll_timeout() can only be used in a nonatomic context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [1] or a similar tool will be used to check it in the
> future.
>
> Link: https://rust-for-linux.com/klint [1]
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/helpers/helpers.c |  1 +
>  rust/helpers/kernel.c  | 13 +++++++
>  rust/kernel/cpu.rs     | 13 +++++++
>  rust/kernel/error.rs   |  1 +
>  rust/kernel/io.rs      |  5 +++
>  rust/kernel/io/poll.rs | 79 ++++++++++++++++++++++++++++++++++++++++++=

>  rust/kernel/lib.rs     |  2 ++
>  7 files changed, 114 insertions(+)
>  create mode 100644 rust/helpers/kernel.c
>  create mode 100644 rust/kernel/cpu.rs
>  create mode 100644 rust/kernel/io.rs
>  create mode 100644 rust/kernel/io/poll.rs
>
(..)
> diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> new file mode 100644
> index 000000000000..7a503cf643a1
> --- /dev/null
> +++ b/rust/kernel/io/poll.rs
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! IO polling.
> +//!
> +//! C header: [`include/linux/iopoll.h`](srctree/include/linux/iopoll.=
h).
> +
> +use crate::{
> +    cpu::cpu_relax,
> +    error::{code::*, Result},
> +    time::{delay::fsleep, Delta, Instant},
> +};
> +
> +use core::panic::Location;
> +
> +/// Polls periodically until a condition is met or a timeout is reache=
d.
> +///
> +/// Public but hidden since it should only be used from public macros.=


This states the function should be hidden, but I don=E2=80=99t see a `#[d=
oc(hidden)]` in here so bit confused by that comment what part now is hid=
den.

Thanks,
Fiona

> +///
> +/// ```rust
> +/// use kernel::io::poll::read_poll_timeout;
> +/// use kernel::time::Delta;
> +/// use kernel::sync::{SpinLock, new_spinlock};
> +///
> +/// let lock =3D KBox::pin_init(new_spinlock!(()), kernel::alloc::flag=
s::GFP_KERNEL)?;
> +/// let g =3D lock.lock();
> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), De=
lta::from_micros(42));
> +/// drop(g);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +#[track_caller]
> +pub fn read_poll_timeout<Op, Cond, T: Copy>(
> +    mut op: Op,
> +    mut cond: Cond,
> +    sleep_delta: Delta,
> +    timeout_delta: Delta,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: FnMut(&T) -> bool,
> +{
> +    let start =3D Instant::now();
> +    let sleep =3D !sleep_delta.is_zero();
> +    let timeout =3D !timeout_delta.is_zero();
> +
> +    if sleep {
> +        might_sleep(Location::caller());
> +    }
> +
> +    loop {
> +        let val =3D op()?;
> +        if cond(&val) {
> +            // Unlike the C version, we immediately return.
> +            // We know the condition is met so we don't need to check =
again.
> +            return Ok(val);
> +        }
> +        if timeout && start.elapsed() > timeout_delta {
> +            // Unlike the C version, we immediately return.
> +            // We have just called `op()` so we don't need to call it =
again.
> +            return Err(ETIMEDOUT);
> +        }
> +        if sleep {
> +            fsleep(sleep_delta);
> +        }
> +        // fsleep() could be busy-wait loop so we always call cpu_rela=
x().
> +        cpu_relax();
> +    }
> +}
> +
> +fn might_sleep(loc: &Location<'_>) {
> +    // SAFETY: FFI call.
> +    unsafe {
> +        crate::bindings::__might_sleep_precision(
> +            loc.file().as_ptr().cast(),
> +            loc.file().len() as i32,
> +            loc.line() as i32,
> +        )
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 545d1170ee63..c477701b2efa 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -35,6 +35,7 @@
>  pub mod block;
>  #[doc(hidden)]
>  pub mod build_assert;
> +pub mod cpu;
>  pub mod cred;
>  pub mod device;
>  pub mod error;
> @@ -42,6 +43,7 @@
>  pub mod firmware;
>  pub mod fs;
>  pub mod init;
> +pub mod io;
>  pub mod ioctl;
>  pub mod jump_label;
>  #[cfg(CONFIG_KUNIT)]
> -- =

> 2.43.0

