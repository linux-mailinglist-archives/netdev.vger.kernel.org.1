Return-Path: <netdev+bounces-136894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34219A388C
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205B71C21C86
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 08:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B5918CBE1;
	Fri, 18 Oct 2024 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MbJV7qCt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D517CA17
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729240228; cv=none; b=ozVySYWcsjeKzknFJfrVIKRF6+QuIPQUD5MOLuFMWAobIfSI6gb3mKnNyLSaZu6l00FNnCptbFN+jqc4hgzGFzijSrEOdpTpsypJGvRFvE2wvColNxc8VvthPybrgbzwARqm7DiKiDDM9uikLcKGo9AqjWBjVEqTHrmE6+wXKRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729240228; c=relaxed/simple;
	bh=8qAPzqP3dKhXme2g3jDdAIPzAnjvRH1S8Phw3+rnUV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaN2AP9jHBXmdpnyWt+xEo/Y0wCzLiDV2zI1uUq1/62eanDZbTvO/Cc/CH4dc0Tq1A9zEW+TTK/FKy8CemJ/tEKxgsEGIVnD73P0baboDdpC5Y2agUtrd5IY/tXcPm1sC10c09BM8+tTsUsm62hb6e/SNIv6z/WUr4kuqt3QocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MbJV7qCt; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d462c91a9so1264400f8f.2
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729240225; x=1729845025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbAMcSp9yyDfnxGCGeMEKOhblZceCEfJ/csOCXnKJaE=;
        b=MbJV7qCtpaaKSmDIyfXsB0DE6bKIrBZgLIT+z9VMu6XFtmkBzuqMzKri5lRMcfD3ec
         pxR1RxfgXb+Y6H8zs5pH6a54KJ4EfMi+ydhM7NjKO9TG6QbgYJF4azgmmdTIybfZ4rd/
         QOs1WaVMOiGjIpYdOmHAzRBlOEd11VMa2w8IWnn+JrMQvwb7foY2MLbTQDD24offd7uL
         n6fcq4l7OEY0yjkNIBYygg2ci1Lk6UkdHYCsuwJh47lmEAw1b68NgJ4Pg6G2joE6Z8aK
         UsiMqenM3Y8QePSUGDQVzX0Nwa8p0S57bcB1tqsTGRyqDu6h+Bib4f4s9Us8cK0v6dE2
         sLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729240225; x=1729845025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbAMcSp9yyDfnxGCGeMEKOhblZceCEfJ/csOCXnKJaE=;
        b=Nwh7vXTfFVz2QZRagwtOBfYRVU0sP1x592UUrbZwhHEFkeuNadHr+uALCDfJH9VKgG
         d9HhCS0YjOAWwzOV9SPb3zoBn12oxhk4IA3tMiBpTIvsvsDXpjQre5Hpz59HOhIciwuM
         YQMBjg/vkUrTHiDnhke9xcLP/N+0k6U4T92+L4OYJA+63LTmxJxMSwGRAW+MB9bVOlZU
         aBvxOdHjQXbCH7X5Cplu5Nlphej+Pa9BVKQ0UfB+4i5/ri3K9x097XUa3xpQBGbGXi8l
         GW09u5/cZv8VgKlpsJPfVUf80kZi1GRSeEL8kQ3pHtM6R1jbWHTBiyxMb164H65puoNU
         i07Q==
X-Gm-Message-State: AOJu0YyvP/ArHzzVF2dYUp9H+c8+ibyVVBeaqDpMkP+Mzy0n9HdH7dPS
	sf4npXFVQwRhAeuNvz0uZyOEnVgoY1nJEoW0fWA6Kg9eZwjb3FvOAjvxIjmyIjI0uYj3526bMCx
	OU9gYtVFll+xHkyiI1ULX+NXslk9d/nzT8eIT
X-Google-Smtp-Source: AGHT+IHwNr1+oRgTPwtFuJrqUyGYR7XLK2TuDM5nSLj+twYMcIpk3cM45DuvXTdz13pykl0V1RuUBQqr9zWbtjSn338=
X-Received: by 2002:a05:6000:1cd:b0:374:c059:f2c5 with SMTP id
 ffacd0b85a97d-37eab6e38cfmr1254424f8f.22.1729240225355; Fri, 18 Oct 2024
 01:30:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-8-fujita.tomonori@gmail.com>
 <CAH5fLgjk5koTwMOcdsnQjTVWQehjCDPoD2M3KboGZsxigKdMfA@mail.gmail.com>
 <CAH5fLgi0dN+hkTb0a29XWaGO1xsmyyJMAQyFJDH+geWZwsfAHw@mail.gmail.com> <20241018.171026.271950414623402396.fujita.tomonori@gmail.com>
In-Reply-To: <20241018.171026.271950414623402396.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 18 Oct 2024 10:30:13 +0200
Message-ID: <CAH5fLghpBDKEwW9maYD57O9+FuMDtVUJm7Dx6JdvjS2p5ZQNbQ@mail.gmail.com>
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

On Fri, Oct 18, 2024 at 10:10=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Wed, 16 Oct 2024 10:52:17 +0200
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > On Wed, Oct 16, 2024 at 10:45=E2=80=AFAM Alice Ryhl <aliceryhl@google.c=
om> wrote:
> >>
> >> On Wed, Oct 16, 2024 at 5:54=E2=80=AFAM FUJITA Tomonori
> >> <fujita.tomonori@gmail.com> wrote:
> >> > +/// Polls periodically until a condition is met or a timeout is rea=
ched.
> >> > +///
> >> > +/// `op` is called repeatedly until `cond` returns `true` or the ti=
meout is
> >> > +///  reached. The return value of `op` is passed to `cond`.
> >> > +///
> >> > +/// `sleep_delta` is the duration to sleep between calls to `op`.
> >> > +/// If `sleep_delta` is less than one microsecond, the function wil=
l busy-wait.
> >> > +///
> >> > +/// `timeout_delta` is the maximum time to wait for `cond` to retur=
n `true`.
> >> > +///
> >> > +/// This macro can only be used in a nonatomic context.
> >> > +#[macro_export]
> >> > +macro_rules! readx_poll_timeout {
> >> > +    ($op:expr, $cond:expr, $sleep_delta:expr, $timeout_delta:expr) =
=3D> {{
> >> > +        #[cfg(CONFIG_DEBUG_ATOMIC_SLEEP)]
> >> > +        if !$sleep_delta.is_zero() {
> >> > +            // SAFETY: FFI call.
> >> > +            unsafe {
> >> > +                $crate::bindings::__might_sleep(
> >> > +                    ::core::file!().as_ptr() as *const i8,
> >> > +                    ::core::line!() as i32,
> >> > +                )
> >> > +            }
> >> > +        }
> >>
> >> I wonder if we can use #[track_caller] and
> >> core::panic::Location::caller [1] to do this without having to use a
> >> macro? I don't know whether it would work, but if it does, that would
> >> be super cool.
>
> Seems it works, no need to use macro. Thanks a lot!
>
> >> #[track_caller]
> >> fn might_sleep() {
> >>     let location =3D core::panic::Location::caller();
> >>     // SAFETY: FFI call.
> >>     unsafe {
> >>         $crate::bindings::__might_sleep(
> >>             location.file().as_char_ptr(),
> >>             location.line() as i32,
> >>         )
> >>     }
> >> }
> >
> > Actually, this raises a problem ... core::panic::Location doesn't give
> > us a nul-terminated string, so we probably can't pass it to
> > `__might_sleep`. The thing is, `::core::file!()` doesn't give us a
> > nul-terminated string either, so this code is probably incorrect
> > as-is.
>
> Ah, what's the recommended way to get a null-terminated string from
> &str?

In this case, you should be able to use the `c_str!` macro.

`kernel::c_str!(core::file!()).as_char_ptr()`

Alice

