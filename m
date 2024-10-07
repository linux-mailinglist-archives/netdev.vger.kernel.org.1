Return-Path: <netdev+bounces-132660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC5A992B9A
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D6D6B231AA
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28181D2716;
	Mon,  7 Oct 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOrKqUFV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244141D26EE
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303859; cv=none; b=s4AsqSfkGzEkD108a3nOBjlsPv6zD+0r36pXQojGMhV+HDhRva3YH233ltg/m+iuiEbYPiRipGwwChR/5vrPaBwG1bv61LeGH8zMMAyAKkDsXlKQQf5IorrvzcleY3zfXzne3DQ7SEuN8emD02mHxptjF7qmp7S3IShrOmP8MEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303859; c=relaxed/simple;
	bh=t8H6KKTU1kUFSyofCbDB6hb4GjQoj/UNpvlIreQ4WHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svvPirOinidyT6DXu3apO4i15QA7G7QzN7Hf+VuC99vzYjVrrH1UgwZz7IXhrIHtoFQmE6zwGyiaEVNHPiLQGHLRVXDCdywnZU45l8t4492tAjCdX+k6HcJx6ppVDXXqbTEoKuhAAfyo7GIguE3gVQDqI1nltJTSlb8xO3o8nSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOrKqUFV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cd26c6dd1so4364744f8f.3
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 05:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728303856; x=1728908656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ku7dHoXpcBGzxmDwFlzy5O2yX7mMKyvUeFGB5ab/Z98=;
        b=OOrKqUFVGN+til1KTL10MXwaAlvqfhdBAA8OaV/VrMm2yGAP2b+K+rBLws5vWOHClL
         ysNc9YSd83jY9R+nvpyM16sgL51fZuB4lSgLcGPHKLKNljiOJqu+6eFiIZSM5lLYkNA8
         ipzPteLU7kLOh6v+kFFqkcJ64PNn4JPqRzxjp7UdAJ/CZCgOAzDUZZQ/suNyknQIli93
         9frkwkis11dzWOdgunlLuqd37ysfAm+XCAVrD+EGCemfJBxrZYeP0JmxuRdAyYaecUCm
         oR6RbUoYasV6Nzd4Bf2OxK0wsMBc4FQ7X+Cl95JzEOByYKs4DCxhV2P1GLHkxLTfEQOP
         kTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728303856; x=1728908656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ku7dHoXpcBGzxmDwFlzy5O2yX7mMKyvUeFGB5ab/Z98=;
        b=Nvg+TZG1eaK/sDHLQVwhWtYw/QNTaG2i+J+HQ3LsWL2pIERbGde95PZIYFYp6UuH/0
         8y3BxARabqFiUxG54W8zBwzu8Q4lUyotXr5V9V9HV1OQzXoMHjcxTJkU2svpPsVQyAwC
         ywibTgxAh8J8JZSVMnAhKKX2Bs+BBjlKjgMEd56qFSr305S0RKH9nqUZDeLapNezq93/
         k4ecraQzMCBZs8riJmntbpSR/i4EXffxfPfWZlhjw0nXK6kjtnxPER1SHKc1vPzryNF4
         a3hjzGysStFX3ZVLuV/tCY1BHQDvYjdjNqzkL+VtPRRjZX7B+ydhwaD6il+BezrpB5aL
         dVUw==
X-Gm-Message-State: AOJu0YyB0bHLetsZ9bI0xkfx2ZWEYpb+mB8C8Arw2MTzOlwyb1ZbpBGF
	yj2qgKnZ+UaFLODEhfMbIR0+C0XtTyzwzEo6WlTqICHRlVYqNOVmVpVart98pivEJaWvWQQ7n9L
	D4qt5qx3p3a9LZ609dq1QAUCP8PRL5lVPqJRyy6SRM+Jum07TbQ==
X-Google-Smtp-Source: AGHT+IH8HYWMusOnnggysgcNaVoQpA7Kkf52UHiKBHrYYgnQi3e5Rs2SF/yP/clJCEOjCdyXWS+b5b1JKOiSHyD1iX0=
X-Received: by 2002:a5d:61ca:0:b0:37c:fbf8:fc4 with SMTP id
 ffacd0b85a97d-37d0eaea686mr9189645f8f.59.1728303856278; Mon, 07 Oct 2024
 05:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005122531.20298-1-fujita.tomonori@gmail.com> <20241005122531.20298-5-fujita.tomonori@gmail.com>
In-Reply-To: <20241005122531.20298-5-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Oct 2024 14:24:03 +0200
Message-ID: <CAH5fLgjTifsDKrxZTUTo74HR34X1zusO_7h0ftWWH-iZR_NXNA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/6] rust: time: add wrapper for fsleep function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 2:26=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add a wrapper for fsleep, flexible sleep functions in
> `include/linux/delay.h` which deals with hardware delays.
>
> The kernel supports several `sleep` functions to handle various
> lengths of delay. This adds fsleep, automatically chooses the best
> sleep method based on a duration.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/helpers/time.c |  6 ++++++
>  rust/kernel/time.rs | 16 ++++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
> index 60dee69f4efc..0c85bb06af63 100644
> --- a/rust/helpers/time.c
> +++ b/rust/helpers/time.c
> @@ -1,7 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include <linux/delay.h>
>  #include <linux/ktime.h>
>
> +void rust_helper_fsleep(unsigned long usecs)
> +{
> +       fsleep(usecs);
> +}
> +
>  ktime_t rust_helper_ktime_add_ns(const ktime_t kt, const u64 nsec)
>  {
>         return ktime_add_ns(kt, nsec);
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 3e00ad22ed89..5cca9c60f74a 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -5,9 +5,12 @@
>  //! This module contains the kernel APIs related to time and timers that
>  //! have been ported or wrapped for usage by Rust code in the kernel.
>  //!
> +//! C header: [`include/linux/delay.h`](srctree/include/linux/delay.h).
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.=
h).
>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
>
> +use core::ffi::c_ulong;
> +
>  /// The number of nanoseconds per microsecond.
>  pub const NSEC_PER_USEC: i64 =3D bindings::NSEC_PER_USEC as i64;
>
> @@ -178,3 +181,16 @@ fn add(self, delta: Delta) -> Ktime {
>          Ktime::from_raw(t)
>      }
>  }
> +
> +/// Sleeps for a given duration.
> +///
> +/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
> +/// which automatically chooses the best sleep method based on a duratio=
n.
> +///
> +/// `Delta` must be longer than one microsecond.
> +///
> +/// This function can only be used in a nonatomic context.
> +pub fn fsleep(delta: Delta) {
> +    // SAFETY: FFI call.
> +    unsafe { bindings::fsleep(delta.as_micros() as c_ulong) }
> +}

This rounds down. Should this round it up to the nearest microsecond
instead? It's generally said that fsleep should sleep for at least the
provided duration, but that it may sleep for longer under some
circumstances. By rounding up, you preserve that guarantee.

Also, the note about always sleeping for "at least" the duration may
be a good fit for the docs here as well.

Alice

