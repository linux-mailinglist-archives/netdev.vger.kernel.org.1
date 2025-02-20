Return-Path: <netdev+bounces-168169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BA0A3DDD4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F469171FC4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD291E5B9F;
	Thu, 20 Feb 2025 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="C9PECO/N"
X-Original-To: netdev@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36231D61A3;
	Thu, 20 Feb 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063900; cv=none; b=VpRutEiyV8zjsN8PWZ9O4p45zuZbLhDWHpmd3TFt2E5KtDDekUcmiK8W6V84DWAHS3jmOMjodWw3Wdp2VuRE3CAVgqtS57yfcKhe9MZd5Vz7PVrhC9vGl4U7tNu27G0ZcND+WEqGDbK0ovQnrvMSPvQQ04b3IfqalYAWYX4uf/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063900; c=relaxed/simple;
	bh=C725kGToJoPoK2G0Lb1yujtgeuzXvOOs4p8Mky4Q6Jo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sRW7V0sg+ARmNvPEJQC/34r6q5yZIpumBCtyrdoY7IhQqWGingxAd5Torc0kwaRuyUsy9tH9We9RBhkaZBGjfDbLcVzr6A32IBVBZD6DRZyQ6c8brBDS25E872g4fjO9xK6VALVa/Z9ZajCftgRtw/nBbMPLEAR9zV5HlbSIooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=C9PECO/N; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1740063892; bh=xE7UPFqOCh2yzLVioDt6U+D3sE8g86i5EoCqXGfP4Os=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=C9PECO/NQF4RP2myoNM6V39SwYz0sLtIp0Ope7rh/jvYw36Qisepp3hljzprWD0Q8
	 nTvaL3MqJNrKM3SLGaTzNxtUX5RT2Er4GFXZ5TLfsOJhI3ElsUxWcOO5NGA7p+oOTn
	 px0grqC0IgbJFkwmzYkuNfz3UvjAP4g/aIgbFU1M=
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Daniel Almeida
 <daniel.almeida@collabora.com>,  rust-for-linux@vger.kernel.org,
  netdev@vger.kernel.org,  andrew@lunn.ch,  hkallweit1@gmail.com,
  tmgross@umich.edu,  ojeda@kernel.org,  alex.gaynor@gmail.com,
  gary@garyguo.net,  bjorn3_gh@protonmail.com,  benno.lossin@proton.me,
  a.hindborg@samsung.com,  aliceryhl@google.com,  anna-maria@linutronix.de,
  frederic@kernel.org,  tglx@linutronix.de,  arnd@arndb.de,
  jstultz@google.com,  sboyd@kernel.org,  mingo@redhat.com,
  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  bsegall@google.com,  mgorman@suse.de,
  vschneid@redhat.com,  tgunders@redhat.com,  david.laight.linux@gmail.com
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
In-Reply-To: <20250220070611.214262-8-fujita.tomonori@gmail.com> (FUJITA
	Tomonori's message of "Thu, 20 Feb 2025 16:06:09 +0900")
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-8-fujita.tomonori@gmail.com>
Date: Thu, 20 Feb 2025 16:04:50 +0100
Message-ID: <878qq064j1.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:

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
> The sleep_before_read argument isn't supported since there is no user
> for now. It's rarely used in the C version.
>
> read_poll_timeout() can only be used in a nonatomic context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [1] or a similar tool will be used to check it in the
> future.
>
> Link: https://rust-for-linux.com/klint [1]
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  rust/helpers/helpers.c |   1 +
>  rust/helpers/kernel.c  |  18 +++++++
>  rust/kernel/cpu.rs     |  13 +++++
>  rust/kernel/error.rs   |   1 +
>  rust/kernel/io.rs      |   2 +
>  rust/kernel/io/poll.rs | 120 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |   1 +
>  7 files changed, 156 insertions(+)
>  create mode 100644 rust/helpers/kernel.c
>  create mode 100644 rust/kernel/cpu.rs
>  create mode 100644 rust/kernel/io/poll.rs
>
> diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> new file mode 100644
> index 000000000000..5977b2082cc6
> --- /dev/null
> +++ b/rust/kernel/io/poll.rs
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! IO polling.
> +//!
> +//! C header: [`include/linux/iopoll.h`](srctree/include/linux/iopoll.h).
> +
> +use crate::{
> +    cpu::cpu_relax,
> +    error::{code::*, Result},
> +    time::{delay::fsleep, Delta, Instant},
> +};
> +
> +/// Polls periodically until a condition is met or a timeout is reached.
> +///
> +/// The function repeatedly executes the given operation `op` closure and
> +/// checks its result using the condition closure `cond`.
> +/// If `cond` returns `true`, the function returns successfully with the result of `op`.
> +/// Otherwise, it waits for a duration specified by `sleep_delta`
> +/// before executing `op` again.
> +/// This process continues until either `cond` returns `true` or the timeout,
> +/// specified by `timeout_delta`, is reached. If `timeout_delta` is `None`,
> +/// polling continues indefinitely until `cond` evaluates to `true` or an error occurs.
> +///
> +/// # Examples
> +///
> +/// ```rust,ignore
> +/// fn wait_for_hardware(dev: &mut Device) -> Result<()> {
> +///     // The `op` closure reads the value of a specific status register.
> +///     let op = || -> Result<u16> { dev.read_ready_register() };
> +///
> +///     // The `cond` closure takes a reference to the value returned by `op`
> +///     // and checks whether the hardware is ready.
> +///     let cond = |val: &u16| *val == HW_READY;
> +///
> +///     match read_poll_timeout(op, cond, Delta::from_millis(50), Some(Delta::from_secs(3))) {
> +///         Ok(_) => {
> +///             // The hardware is ready. The returned value of the `op`` closure isn't used.
> +///             Ok(())
> +///         }
> +///         Err(e) => Err(e),
> +///     }
> +/// }
> +/// ```
> +///
> +/// ```rust
> +/// use kernel::io::poll::read_poll_timeout;
> +/// use kernel::time::Delta;
> +/// use kernel::sync::{SpinLock, new_spinlock};
> +///
> +/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
> +/// let g = lock.lock();
> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Some(Delta::from_micros(42)));
> +/// drop(g);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +#[track_caller]
> +pub fn read_poll_timeout<Op, Cond, T>(
> +    mut op: Op,
> +    mut cond: Cond,
> +    sleep_delta: Delta,
> +    timeout_delta: Option<Delta>,

Fun idea I just had, though not sure it is of actuall use (probably not).
Instead of `Option<Delta> we could use `impl Into<Option<Delta>>`,
that enables to use both, so not having to write Some if we have a value.

> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: FnMut(&T) -> bool,
> +{
> +    let start = Instant::now();
> +    let sleep = !sleep_delta.is_zero();
> +
> +    if sleep {
> +        might_sleep();
> +    }
> +
> +    loop {
> +        let val = op()?;
> +        if cond(&val) {
> +            // Unlike the C version, we immediately return.
> +            // We know the condition is met so we don't need to check again.
> +            return Ok(val);
> +        }
> +        if let Some(timeout_delta) = timeout_delta {
> +            if start.elapsed() > timeout_delta {
> +                // Unlike the C version, we immediately return.
> +                // We have just called `op()` so we don't need to call it again.
> +                return Err(ETIMEDOUT);
> +            }
> +        }
> +        if sleep {
> +            fsleep(sleep_delta);
> +        }
> +        // fsleep() could be busy-wait loop so we always call cpu_relax().
> +        cpu_relax();
> +    }
> +}
> +
> +/// Annotation for functions that can sleep.
> +///
> +/// Equivalent to the C side [`might_sleep()`], this function serves as
> +/// a debugging aid and a potential scheduling point.
> +///
> +/// This function can only be used in a nonatomic context.
> +#[track_caller]
> +fn might_sleep() {
> +    #[cfg(CONFIG_DEBUG_ATOMIC_SLEEP)]
> +    {
> +        let loc = core::panic::Location::caller();
> +        // SAFETY: FFI call.
> +        unsafe {
> +            crate::bindings::__might_sleep_precision(
> +                loc.file().as_ptr().cast(),
> +                loc.file().len() as i32,
> +                loc.line() as i32,
> +            )
> +        }
> +    }
> +
> +    // SAFETY: FFI call.
> +    unsafe { crate::bindings::might_resched() }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 496ed32b0911..415c500212dd 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -40,6 +40,7 @@
>  pub mod block;
>  #[doc(hidden)]
>  pub mod build_assert;
> +pub mod cpu;
>  pub mod cred;
>  pub mod device;
>  pub mod device_id;

