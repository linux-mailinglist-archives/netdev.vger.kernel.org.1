Return-Path: <netdev+bounces-136094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B7A9A048D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E828628168C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6406720264E;
	Wed, 16 Oct 2024 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfKADv2m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE04F202632
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068353; cv=none; b=i/tVpzPfitkl2Ahytev/ZMH0qw1lX8mU/3g2d8kPoKyUxFh2fhR2Onq+hjp6MFWXUP5t8QIRpTBucqpPk4i0wLtmdnRnBvooeAksd7g5Cl3UpqQRzqHm0GE9NdyBgfVHYQUVzlchGNpRVmsJcP3h1vsnuk3SFAJDnDDdDp9sL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068353; c=relaxed/simple;
	bh=tPKp6FH8LM1Ajw5jVA0FwWcF7dwxBVDEain5oorsqTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cO7sJmezNGcO9DFkhKpiMlgT051Iy1xoeDHks253UOzc/3jb9/8rkPVWAsoifnWn+XO0HijGaYhgVELWks1rEUIv+HLIbnp9v8cKQQeH05/EE9DtjCC2vtCVIMW5izKjM1Ey8l3C2nNNXSK7bZeiE2KY/hJe/XZFp6f8W0x/trs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfKADv2m; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43140cadeaaso13776385e9.0
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729068350; x=1729673150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQiVeIaORBH2LY7uDomKs6E4i7KqxzjBgaxWXE9AZW0=;
        b=SfKADv2mKZRcNwzcOQ/67XtZzJQmZFvI7+VHEe74XlSDDFkb2vzTQ4RC5dm993B7xe
         fvINbtnVUAXyPOzV2WW9lqyxffP8eOYBzShaXzxUnhcN/Q+5KeXBOou0QnAjVIgpx6TB
         Gegb6YGU/Hi/0E9Kc9jAit4sTGREJbA09oAkpjIqYc+7drdnugv/7C2/GqOBG5Qsv/TD
         DMmaFFThsrqx+Ru0QkwpB4GbBgz3xazx6VYxNB4/vpcCkGxGwqTZ/pIgWThDLKwAgvqN
         kIeCMmw896wqU767tRzgwY2hoUib0o4CL5oajAOg8PLiCnfduH3S40GLSRNea/ZH88LB
         L7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729068350; x=1729673150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQiVeIaORBH2LY7uDomKs6E4i7KqxzjBgaxWXE9AZW0=;
        b=jgvFLxkun3CNH2zfUKf0WK75clcEu7qJ9PnM7NoMZ/pjNGhJP71vp0g27Qk+lVeT93
         DnDQLJkmwTbEnkZ5mOwFhSedDfDK/sy34jjpeycI3g9bkCfNdetc+WEG5Zsuf2pjhl+q
         tR1hK6pGUuLLjLfcZlnF5Fk1bOuDaYytRzCEFe83A6VdD8ZST+Z9PyEo2cZgixFEIMK4
         0tjfqlMG8bG/5fhJHDsGeRUv8fnkR57QWgbWhcRWVGEXKqlGJNW4301zAEz+QKzfiynJ
         e25hbsosv6JXc+Kl1EDXc9unU6fH6c6XKOZkMZGyZJFo2GufvpaJQWe4gYnvrF0By49t
         xmGQ==
X-Gm-Message-State: AOJu0YzlyalMM9wGeecaLYEQv3tq+Z4+pGv2gurNCzzeLw5OJqeafwJF
	Mcn4zBc2kmQqwb1kV85KzGCi+vyyRUE4IBw5F2pcih16H86o7rsvQx9NQ5BNiCWKI3Eh5wKAWnj
	Ohci5Pmtts7L98rpPhH4m/0C1Gs8s+V4Kb+ft
X-Google-Smtp-Source: AGHT+IEbvkLiD3zm7BxQJHYNEE6NWiMmGECFe/F6qDAJ/wKkj0TAQEjKK/20MFLf1QqFy6Y1NBbcy4BMRW1uYhU95hE=
X-Received: by 2002:a05:600c:384c:b0:42c:c1f6:6ded with SMTP id
 5b1f17b1804b1-4311df55df7mr156042515e9.29.1729068349781; Wed, 16 Oct 2024
 01:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com> <20241016035214.2229-8-fujita.tomonori@gmail.com>
In-Reply-To: <20241016035214.2229-8-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Oct 2024 10:45:36 +0200
Message-ID: <CAH5fLgjk5koTwMOcdsnQjTVWQehjCDPoD2M3KboGZsxigKdMfA@mail.gmail.com>
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
> +/// Polls periodically until a condition is met or a timeout is reached.
> +///
> +/// `op` is called repeatedly until `cond` returns `true` or the timeout=
 is
> +///  reached. The return value of `op` is passed to `cond`.
> +///
> +/// `sleep_delta` is the duration to sleep between calls to `op`.
> +/// If `sleep_delta` is less than one microsecond, the function will bus=
y-wait.
> +///
> +/// `timeout_delta` is the maximum time to wait for `cond` to return `tr=
ue`.
> +///
> +/// This macro can only be used in a nonatomic context.
> +#[macro_export]
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

I wonder if we can use #[track_caller] and
core::panic::Location::caller [1] to do this without having to use a
macro? I don't know whether it would work, but if it does, that would
be super cool.

#[track_caller]
fn might_sleep() {
    let location =3D core::panic::Location::caller();
    // SAFETY: FFI call.
    unsafe {
        $crate::bindings::__might_sleep(
            location.file().as_char_ptr(),
            location.line() as i32,
        )
    }
}

Alice

[1]: https://doc.rust-lang.org/nightly/core/panic/struct.Location.html#meth=
od.caller

