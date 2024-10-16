Return-Path: <netdev+bounces-136092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC1B9A0474
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558B11F263A0
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7E01FDFB3;
	Wed, 16 Oct 2024 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vz2hSlhG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948101FDFAB
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067882; cv=none; b=B3dpIT85l+nZ8dqPNRQ7hZr38gdjSoNT5d5lSo6BaylFyU0CfFbt1LYVx1zp0jTS4TrVG8QILd7CS3UN4JMrfyEbe4WyL0guKzBnMFW0xnSC9wwZKDv2OpxOnrtPHHNRn5BJbm9lDlpUnL08mqI4CXmYsIWBUj2p344hmvTZtaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067882; c=relaxed/simple;
	bh=7mSyqukGBIpCmay8QT2V728qhVZnc5Gk5vx+ah5E968=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJQk/DC0InM7LX0uJ/yS+hD1mbXGXBTT6fh3tSSVz3YhkJesPl/+PCbE5Sag8e98baLVELOdYTMsmu+Hd/UBq97cg4XUdOb3nCzJbSWEhD59groO5PhbGDopx+dNoQIr8946wFugtNNLMjreMuSAanvxC/hNrVQ1BbQQoXQWR0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vz2hSlhG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d47eff9acso3728857f8f.3
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729067879; x=1729672679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os7rW/WsJREBniJI2Ek1CEyJc60qK11pTVrWpv5Tjf4=;
        b=vz2hSlhGXMo7sq89w121E4otwC5bmH089st3UXKOekHf8YNoR4yzFcn0keh48cS4/B
         D2gE+91DM5RT1yqXH4Y2UHzCl+JHQt1s9FpKysf+NJD537e9FUkyMDjbqRTnQgoRcWh2
         o8NXOMfpr8dfVTMmVzw/Mbd54+Qkl4UELrY4NA3UG2PlsPB3FQ+YOIWP7d8hZD2zLhTS
         d8wPcaZpL4Njef87sQ1Iv09fM5ULcmOULfYcXB1zbUVKGpD39bb1TB8nqgomdDvtQumt
         XAHFioNzJW8sr3L+JdKEzIwAwiPlNhKNtck0MdFR1gfc6dYKvouXij9Rr+QhimtRi4qZ
         urZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067879; x=1729672679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=os7rW/WsJREBniJI2Ek1CEyJc60qK11pTVrWpv5Tjf4=;
        b=wUsixDoivtTFOLB+aoHkAbN/hDLvQH99m+Cz7ospgU5dVJgTdx21sXXXAWyrHSLTCC
         cZSocp7b57FVBq7kwbhh7jqBZuAMV+IPvhepkaBElg0d6x/rlqOcYPpf7xCBMuzmUZi+
         bLbFmfBiVxG97ruQkczPwkVZjrCi8Ea3J57qU1b8G8uBfxwPxfvFt+zM1qyURUxsPoPR
         Uls1JflPSh3Ni5t4d5oHY3loIUiFi3DT+0Jf9l6TnS6zRCS/R2mcEBWBgrMGN55nrWIW
         s1XssSDPa004nTH8++Oz/aWb7Pvt0At7Wb+WsKaKpVQQ6MRYHWa01n01vtpHxgnw5Mbe
         yJ4w==
X-Gm-Message-State: AOJu0Yy1YAnPFcB8cD2mbyfufLaHDtLlZtNxewJSVV4zmcEYVG6+Yi2g
	KwZ/XKit4afJzPgRkbVk4PcDyO/sFMco/ERNSQYAmcBdmFtBE5fmdBBFIFikQR4z0Ev+zVfs8C3
	0NdWYB4yaWZe2oURuI11OHWSWPD2Th3pFc7dD6scOgdoP0QOFkKSGToo=
X-Google-Smtp-Source: AGHT+IFtqFr8sAA3n5PIT0gMS+hHwcyB4XYLtQMFXrhL+hF2dIVZULC0RiaS0vkrRZOcXCMWIFMbLLtpWE9aZ8l4Hkc=
X-Received: by 2002:a05:6000:b03:b0:37d:4cee:55b with SMTP id
 ffacd0b85a97d-37d600c927bmr9358470f8f.59.1729067878806; Wed, 16 Oct 2024
 01:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com> <20241016035214.2229-8-fujita.tomonori@gmail.com>
In-Reply-To: <20241016035214.2229-8-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Oct 2024 10:37:46 +0200
Message-ID: <CAH5fLgg1G4++B+AoXrDc-QxiNL8T4zRV3ChbwN1LsG=urcMJmw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/8] rust: Add read_poll_timeout functions
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
> Add read_poll_timeout functions which poll periodically until a
> condition is met or a timeout is reached.
>
> C's read_poll_timeout (include/linux/iopoll.h) is a complicated macro
> and a simple wrapper for Rust doesn't work. So this implements the
> same functionality in Rust.
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
> For the proper debug info, readx_poll_timeout() is implemented as a
> macro.
>
> readx_poll_timeout() can only be used in a nonatomic context. This
> requirement is not checked by these abstractions, but it is
> intended that klint [1] or a similar tool will be used to check it
> in the future.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Link: https://rust-for-linux.com/klint [1]
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Duplicated SOB? This should just be:

Link: https://rust-for-linux.com/klint [1]
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

> +/// Polls periodically until a condition is met or a timeout is reached.
> +///
> +/// Public but hidden since it should only be used from public macros.
> +#[doc(hidden)]
> +pub fn read_poll_timeout<Op, Cond, T: Copy>(
> +    mut op: Op,
> +    cond: Cond,
> +    sleep_delta: Delta,
> +    timeout_delta: Delta,
> +    sleep_before_read: bool,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: Fn(T) -> bool,
> +{
> +    let timeout =3D Ktime::ktime_get() + timeout_delta;
> +    let sleep =3D !sleep_delta.is_zero();
> +
> +    if sleep_before_read && sleep {
> +        fsleep(sleep_delta);
> +    }

You always pass `false` for `sleep_before_read` so perhaps just remove
this and the argument entirely?

> +        if cond(val) {
> +            break val;
> +        }

This breaks out to another cond(val) check below. Perhaps just `return
Ok(val)` here to avoid the double condition check?

> +        if !timeout_delta.is_zero() && Ktime::ktime_get() > timeout {
> +            break op()?;
> +        }

Shouldn't you just return `Err(ETIMEDOUT)` here? I don't think you're
supposed to call `op` twice without a sleep in between.

> +        if sleep {
> +            fsleep(sleep_delta);
> +        }
> +        // SAFETY: FFI call.
> +        unsafe { bindings::cpu_relax() }

Should cpu_relax() be in an else branch? Also, please add a safe
wrapper function around cpu_relax.

> +macro_rules! readx_poll_timeout {
> +    ($op:expr, $cond:expr, $sleep_delta:expr, $timeout_delta:expr) =3D> =
{{
> +        #[cfg(CONFIG_DEBUG_ATOMIC_SLEEP)]
> +        if !$sleep_delta.is_zero() {
> +            // SAFETY: FFI call.
> +            unsafe {
> +                $crate::bindings::__might_sleep(
> +                    ::core::file!().as_ptr() as *const i8,
> +                    ::core::line!() as i32,
> +                )
> +            }
> +        }

It could be nice to introduce a might_sleep macro that does this
internally? Then we can reuse this logic in other places.

Alice

