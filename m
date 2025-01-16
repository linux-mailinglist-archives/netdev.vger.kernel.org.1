Return-Path: <netdev+bounces-158821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE28A13691
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8321C18861F2
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7971D90D9;
	Thu, 16 Jan 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mO6jF4so"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0C1D89FA
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019637; cv=none; b=hOP3G64gRSbJjYW69AyLBjr1VmcdOmWIZogML/wQzHQb4kCcoLtwdmrqtV5i1b2dezv1FV86wfnCTXFLNO1pvPV20kbuXpKmXNkPr6sa8zkH1UVvyV3B7PEYnIkchCVcKydLe/rUnBdfWC1BWy0Ys1bjAI7W5lAj+thB51jFhS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019637; c=relaxed/simple;
	bh=8A2uxvLbaoFMf98+gLXCkMe2tYAY4EUXdUEwF6zYYbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAGOUo11skbV/8tpr06L+RBkon8OKiNzOC1+kCOuPx8KKutcMjNCk++USe2akELBNgxSYhRGcX4FfGfykjpkxIC4iCg0fXeFpvnnnBipUazqf9d/IiHD4VKnPh21gNFBAP5iXg47442UZpGVkcY1HqPIPNF6Xo3RgFZcejfmikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mO6jF4so; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e0e224cbso324836f8f.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 01:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737019634; x=1737624434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2BkcpR9ZNDjiY2SGqBk4X0G8WoExR4/1BngbjAHdnk=;
        b=mO6jF4so6Wwgd79VR3nQoMGcJ9tn/W1fJter/n3JD0uqVpTXh5iuRNSNXLET0yFBk1
         FT/r/z/+r7GijK5gvucEfNX+PK0zLjJiPHk+UzpQPzOo2lFN5a8vzQF9lpYJt7SVxxVL
         ZZk4rroGCbEM0oDKqDy4zXKK/KDJmqO8Cwh707x2h+gh0SduhtIzMMwp9SkwQYF0ltMK
         uvGlsEmuVDKzk/cslfK7GfcUO3NdDi2B1WB9g98K9lnQX3l1BraNwaj5+DKmBgTBiVy9
         nd+lhI8OwugJVAbeCoILhb7RqVYEQ+vr0G8y7drpC7Wj4ejbV5itSlnKKPnUYoP7c3P2
         9n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737019634; x=1737624434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2BkcpR9ZNDjiY2SGqBk4X0G8WoExR4/1BngbjAHdnk=;
        b=QnL0H6Jsf1V3Xt5KqASHr4+sK0Nt6NZBzUqZKY5UK2X07pWfEbvYaJQf49vCQEq1Fp
         3WJIdpdZZaeTMt44KXDFD0KR43dffEt+pyr2lGxW0GlOs0v2aoQ0zfduN1OtQ0IecXiK
         ozlJL9jA8PaeHTQVbMKVTivAJIyMcMWsvZm4vzDmd7LMuesU85bCz2IPWeJ+lZMhCyV9
         psp1597DLnd8hESdwKdzsyNluDxIPrijbXK4khXUqqdRd8ESrET6uzAfRSABfzvKRvzi
         p7YV6kWV3aMd2+chxIgolTB8uyKtpCL/LXeZJeARwWdNnedzb55zGMf3YqgUwZsghRnp
         rBdg==
X-Forwarded-Encrypted: i=1; AJvYcCU/iT2gnMQuthn/mEnlDYIErxq9Aj0PVuMHfFvVNifCV2XQNJM0AJApJXwpR60iODllwSBu5G0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3qoAxyFoEx4GuBYVHybgLgKcCkdHJ38XgXItq8gYf5Qzdi7Fy
	fdCfd4AXOoHQVD+tKw9PEHEHpmAsnTFgFoPg/LC/IW0JiaSYbM6T5zLIwekFV31cJT/sQ/VBTxA
	GZiTaJrShp+RqnywLCkkYMM5Os+LBxXqUY1Fa
X-Gm-Gg: ASbGncumuglFs19QTsQUklILWbkdLX6rCoucOha3i2OPOmSLP6EQJdu5T9NUtH7Ccuz
	BGL0J6ud+S4ByUr7fIvqKT+M2UfRb0RQ1rf+Rc65gLKACkJ6/TJwr8xoA0XccpBRKRZ0=
X-Google-Smtp-Source: AGHT+IEFd23o/wtcJ/YCAvMujZ+C/kgb/VwG4jXEsI/rLEUzdQ2WXPdPhh+U0sXcpIFAevzkICPJwNDu4HldPTLWjg8=
X-Received: by 2002:a5d:64af:0:b0:38a:8e2e:9fcc with SMTP id
 ffacd0b85a97d-38a8e2ea11cmr26469619f8f.45.1737019633585; Thu, 16 Jan 2025
 01:27:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com> <20250116044100.80679-5-fujita.tomonori@gmail.com>
In-Reply-To: <20250116044100.80679-5-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 16 Jan 2025 10:27:02 +0100
X-Gm-Features: AbW1kvZubuIwHq17qBZNngiLdEqrngBZd4SbfaDXg514yHDc1F3iVbk6WkQ2Vzo
Message-ID: <CAH5fLgjwTiR+qX0XbTrtv71UnKorSJKW26dTt2nPro6DmZiJ-g@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:42=E2=80=AFAM FUJITA Tomonori
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
> Link: https://rust-for-linux.com/klint [1]
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/helpers/helpers.c    |  1 +
>  rust/helpers/time.c       |  8 ++++++++
>  rust/kernel/time.rs       |  4 +++-
>  rust/kernel/time/delay.rs | 43 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 55 insertions(+), 1 deletion(-)
>  create mode 100644 rust/helpers/time.c
>  create mode 100644 rust/kernel/time/delay.rs
>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index dcf827a61b52..d16aeda7a558 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -26,6 +26,7 @@
>  #include "slab.c"
>  #include "spinlock.c"
>  #include "task.c"
> +#include "time.c"
>  #include "uaccess.c"
>  #include "vmalloc.c"
>  #include "wait.c"
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
> index da54a70f8f1f..3be2bf578519 100644
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
> index 000000000000..db5c08b0f230
> --- /dev/null
> +++ b/rust/kernel/time/delay.rs
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Delay and sleep primitives.
> +//!
> +//! This module contains the kernel APIs related to delay and sleep that
> +//! have been ported or wrapped for usage by Rust code in the kernel.
> +//!
> +//! C header: [`include/linux/delay.h`](srctree/include/linux/delay.h).
> +
> +use super::Delta;
> +use crate::ffi::c_ulong;
> +
> +/// Sleeps for a given duration at least.
> +///
> +/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
> +/// which automatically chooses the best sleep method based on a duratio=
n.
> +///
> +/// `delta` must be 0 or greater and no more than `u32::MAX / 2` microse=
conds.
> +/// If a value outside the range is given, the function will sleep
> +/// for `u32::MAX / 2` microseconds (=3D ~2147 seconds or ~36 minutes) a=
t least.
> +///
> +/// This function can only be used in a nonatomic context.
> +pub fn fsleep(delta: Delta) {
> +    // The argument of fsleep is an unsigned long, 32-bit on 32-bit arch=
itectures.
> +    // Considering that fsleep rounds up the duration to the nearest mil=
lisecond,
> +    // set the maximum value to u32::MAX / 2 microseconds.
> +    const MAX_DURATION: Delta =3D Delta::from_micros(u32::MAX as i64 >> =
1);

Hmm, is this value correct on 64-bit platforms?

> +    let duration =3D if delta > MAX_DURATION || delta.is_negative() {
> +        // TODO: add WARN_ONCE() when it's supported.
> +        MAX_DURATION
> +    } else {
> +        delta
> +    };
> +
> +    // SAFETY: FFI call.
> +    unsafe {

This safety comment is incomplete. You can say this:

// SAFETY: It is always safe to call fsleep with any duration.

Alice

