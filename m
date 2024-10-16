Return-Path: <netdev+bounces-136089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37439A0443
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756BD288582
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCED1D90BE;
	Wed, 16 Oct 2024 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8u1dmxJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777961D90B1
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067368; cv=none; b=S2Xx28y3BMdwDvotOamXIbgXbEUwHVOK7JfpTIda2QXxZEF5q2ElJEw8ywGugk9MnbVAKtcgp3kXXNU2yvMrJBWYwPe/KzSlVsrodJfjgOlNVYFdon7dVnV4U8CCQqGNH0l4diI6mCnYCsJixegymNw0mwKshR5vYc6n8Se+4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067368; c=relaxed/simple;
	bh=6U/YYe3uj2oCorqVoEzUs7byRWbSLdPBdXWSj51N1Y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOw+KOudboXqUiTvNYQCKY94BiPSvUMfLe3RFycRZ6E2zpB8qyjPCHD8TstClYCIxowfZvJsCrwMCitm2fu2fJ9XCmQDgQRBuZigAUtAWD0s4ecY0RwS1I52GO2AbKiiMUjxFk0F1DChEooIdIYK6MJzNmty6B0XD4oHrBduIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8u1dmxJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43152b79d25so2693195e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729067365; x=1729672165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qONR6PhzFfCaPdOjWZuY/fyEqCmza+5NO3GwnhyETRQ=;
        b=R8u1dmxJUaCMiZQ2xCwdkkyMRe4t3L2Ho47a/fMni1r1/1cARNU+dUELJje1z07QeM
         9MgEe3ydX0neAJ2X8BMRVT++PguvJuuQkffSz/FhS7IQ5BxDepHGell9ksepPlaCtnBD
         y7pw56HZO4CT20BQR21OLJ/fJ8b4iuhjd9Cf9T9BpBeZsGNgmzHCIIdD0bmKl2F4iQEu
         skqIk/xTSWreZHHlky0Cgf0TY0I5u10oP6x6neZhTzpHQ3oMmWB8ztlgQrol47PwET98
         NI65QVNXX/3s7eGC9X0SO4x5b00COw4wxX3oeJyMaAykLgwMbU3XjA9HKj5PYWLzFRd6
         pfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067365; x=1729672165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qONR6PhzFfCaPdOjWZuY/fyEqCmza+5NO3GwnhyETRQ=;
        b=QtBAhv/q6RKPm155AyaWROwWW5P7MBf0OpQootAzlpUQQPrRNhO1eQqs2arz14StXf
         0dg839uX51ZwKWsMEmlJqN9/PJqlp49nACUjD1lvBICDIv5HeceB+NjpzRLe347hPmZv
         Z2ilAjNwNZcvBBmLiJLIzETswOlo/9V70IreOpoFSZcso0qdcCVW0cEhMxY1Xwhtfqhu
         BfrzDbza41om9RS4Diyj85TORzop2qAuQNa0QQ90KIdGDKuPOMPkRiokaAgFqzYFXe/M
         ZbSji2keEBUo2MwFI3/ks/dPE/EKSL7TkkMDecke/HhGK17jKjN6ALalvHNfuuYDts2U
         gZ6A==
X-Gm-Message-State: AOJu0YwsQqvH2RnSbm0mkerwoqLgY9WHuS+HAIrwjJ0mf5njjrXI03ES
	FnmWJKbCLuBmX7q/k3txd7QcFTFLbWtinfSdO9NxOhQHenW2LmjgXyB/eEMy550ift5FCCXyEtQ
	qgjwYyGnc2wVQzi2ZhakRni+MYkM640UwtH6Z
X-Google-Smtp-Source: AGHT+IFVaAHMcybvKte3ah0JD/NM2uJw5lDjEjl778BaNy/DBMka/sH24c3hWHtGm+Iuux1NFukr320AygGuKTrsbog=
X-Received: by 2002:a05:600c:3b83:b0:426:6710:223c with SMTP id
 5b1f17b1804b1-4311ded1fdfmr156216795e9.9.1729067364603; Wed, 16 Oct 2024
 01:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com> <20241016035214.2229-6-fujita.tomonori@gmail.com>
In-Reply-To: <20241016035214.2229-6-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Oct 2024 10:29:12 +0200
Message-ID: <CAH5fLgjTGmD0=9wJRP+aNtHC2ab7e9tuRwnPZZt8RN3wpmZHBg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/8] rust: time: Add wrapper for fsleep function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:54=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add a wrapper for fsleep, flexible sleep functions in
> `include/linux/delay.h` which typically deals with hardware delays.
>
> The kernel supports several `sleep` functions to handle various
> lengths of delay. This adds fsleep, automatically chooses the best
> sleep method based on a duration.
>
> `sleep` functions including `fsleep` belongs to TIMERS, not
> TIMEKEEPING. They are maintained separately. rust/kernel/time.rs is an
> abstraction for TIMEKEEPING. To make Rust abstractions match the C
> side, add rust/kernel/time/delay.rs for this wrapper.
>
> fsleep() can only be used in a nonatomic context. This requirement is
> not checked by these abstractions, but it is intended that klint [1]
> or a similar tool will be used to check it in the future.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Link: https://rust-for-linux.com/klint [1]
> ---
>  rust/helpers/helpers.c    |  1 +
>  rust/helpers/time.c       |  8 ++++++++
>  rust/kernel/time.rs       |  4 +++-
>  rust/kernel/time/delay.rs | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 43 insertions(+), 1 deletion(-)
>  create mode 100644 rust/helpers/time.c
>  create mode 100644 rust/kernel/time/delay.rs
>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 30f40149f3a9..c274546bcf78 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -21,6 +21,7 @@
>  #include "slab.c"
>  #include "spinlock.c"
>  #include "task.c"
> +#include "time.c"
>  #include "uaccess.c"
>  #include "wait.c"
>  #include "workqueue.c"
> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
> new file mode 100644
> index 000000000000..7ae64ad8141d
> --- /dev/null
> +++ b/rust/helpers/time.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/delay.h>
> +
> +void rust_helper_fsleep(unsigned long usecs)
> +{
> +       fsleep(usecs);
> +}
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 9b0537b63cf7..d58daff6f928 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -2,12 +2,14 @@
>
>  //! Time related primitives.
>  //!
> -//! This module contains the kernel APIs related to time and timers that
> +//! This module contains the kernel APIs related to time that
>  //! have been ported or wrapped for usage by Rust code in the kernel.
>  //!
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.=
h).
>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
>
> +pub mod delay;
> +
>  /// The number of nanoseconds per microsecond.
>  pub const NSEC_PER_USEC: i64 =3D bindings::NSEC_PER_USEC as i64;
>
> diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
> new file mode 100644
> index 000000000000..dc7e2b3a0ab2
> --- /dev/null
> +++ b/rust/kernel/time/delay.rs
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Delay and sleep primitives.
> +//!
> +//! This module contains the kernel APIs related to delay and sleep that
> +//! have been ported or wrapped for usage by Rust code in the kernel.
> +//!
> +//! C header: [`include/linux/delay.h`](srctree/include/linux/delay.h).
> +
> +use crate::time;
> +use core::ffi::c_ulong;
> +
> +/// Sleeps for a given duration at least.
> +///
> +/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
> +/// which automatically chooses the best sleep method based on a duratio=
n.
> +///
> +/// `Delta` must be longer than one microsecond.

Why is this required? Right now you just round up to one microsecond,
which seems okay.

> +/// This function can only be used in a nonatomic context.
> +pub fn fsleep(delta: time::Delta) {
> +    // SAFETY: FFI call.
> +    unsafe {
> +        // Convert the duration to microseconds and round up to preserve
> +        // the guarantee; fsleep sleeps for at least the provided durati=
on,
> +        // but that it may sleep for longer under some circumstances.
> +        bindings::fsleep(
> +            ((delta.as_nanos() + time::NSEC_PER_USEC - 1) / time::NSEC_P=
ER_USEC) as c_ulong,

You probably want this:

delta.as_nanos().saturating_add(time::NSEC_PER_USEC - 1) / time::NSEC_PER_U=
SEC

This would avoid a crash if someone passes i64::MAX nanoseconds and
CONFIG_RUST_OVERFLOW_CHECKS is enabled.

Alice

