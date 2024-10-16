Return-Path: <netdev+bounces-136096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34479A04B5
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DECE1F22C70
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243D82038A4;
	Wed, 16 Oct 2024 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grwYDZXy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4DB1D8DF8
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068753; cv=none; b=T5IHgEX/RnqGeWAWeg3/cdp+XOyCHl7q1DMhOaWpI+Vi5di41aJtKlSfOMlq4jgMCyAr3/CNEXiLVDi9Tt8YjZa62hNM2M+eCIbP0ZlJLXasmIOlmdJwjn7Tf9e9m1XBl2EM/+a52B4CQs7yEXsE1M1MYHZJWyj06Ue2CvUf0mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068753; c=relaxed/simple;
	bh=cbpI01CorBSlhvSPRQMFhdScSdtWFnn1JWE+g2X3uiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSlRkRHx+FE3vAZlm66o845/v1IobVrXuqKkeHkHTKrBuvR7YXynVj4jMbjZvMrs30fYebO2uhDJk9yP0LeCj8TyTPRLoNA+npLI3vD+oQXt9c8BKou/f8M4xJcNsGdDzohWDgHYZBuOCV3NZZsytt1SiolbaHWNkR0ywhkAsKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grwYDZXy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d447de11dso4551026f8f.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729068750; x=1729673550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g93+jT/AcpHh66whjFnNI262tYol3GRMYyQ7fABKQ1E=;
        b=grwYDZXyXyJFLUnCQ07Aox/z9kTXey557+hUWkCBeLB2fC1NZhRo8ueRPOzeiw/bu1
         SPSX72aMok8dBVOKfOOEm27LZpyhMmapgTO8r6TixlF0/VNCZOBu9V1PD8+wrcavL3u+
         bZR1Ji7li76AjR51HyapJ3b5PQw5m/KrFJq5ImfFjRSBtIK2r1CoK75OvP7Hbs7ioiF0
         xhvftHtRiaFEQkffkprpZzl84ggrT+xQHSq5XxshAJTd75U5PZtKsD/9jwsIZGZAuP2A
         /RvVTAZagsrIkJ922ttm62X/koBDMNl0Wc8dXSFOxpRgyoh05R8PASy+d8ju/HWInywv
         HRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729068750; x=1729673550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g93+jT/AcpHh66whjFnNI262tYol3GRMYyQ7fABKQ1E=;
        b=Mwnnwzr/L8Ez4rk57yu3E+WNla8IcfHLofVwqyWtrD5nnUSHr+BAUHCrhOgft/zJMS
         10wGlJtCeb/QAY/bwlhq/wPPT2aoMwEMRKd2qU6XY5JhvjoqMQA23ullQBSbsXzuIxhz
         VeqDJ8Cg1jBwgMuq4UG4xpxfFDpg6bvhQ7ss0VJreu1PddGPOgeMrFURgaakV4C0oahO
         dwEH7l0PACCUxzTAcTvkpo2O3LxxhNRTLqjWa85nscrZgIEoFRXHhV0WckmpNgKadp/8
         3PsnBsfI3NL0mX9drNKuZD1WXzhe0EJzs5lreo6e08bczSqSUkeWAvV/TlMH87dgmUFP
         AcBQ==
X-Gm-Message-State: AOJu0YxhlQ39L5AP22IBkRg1kYmaNRFWpiM5PuJ/kY4b9C59mssSFe7t
	OU8hKSZ6SYr8+H3IRaHg+lomxPP+fHe0DSW8gDCTmzkFC4cttVM35BEHnddhELGTeQEusaJ3ADp
	Geo6CmnhMfsHVTPN/9Tc+hEUmseesOXeN+fhl
X-Google-Smtp-Source: AGHT+IGe4kv4L/EwUbCN/hDA83kADcD5XSTi2TLDBLcssrpynXzxO8MPXSc9nT4Dq1wix/vP8NV8PattQBIw+5GpyQI=
X-Received: by 2002:a05:6000:bd1:b0:37d:f4b:b6ab with SMTP id
 ffacd0b85a97d-37d5530a534mr11465247f8f.59.1729068749519; Wed, 16 Oct 2024
 01:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-8-fujita.tomonori@gmail.com> <CAH5fLgjk5koTwMOcdsnQjTVWQehjCDPoD2M3KboGZsxigKdMfA@mail.gmail.com>
In-Reply-To: <CAH5fLgjk5koTwMOcdsnQjTVWQehjCDPoD2M3KboGZsxigKdMfA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Oct 2024 10:52:17 +0200
Message-ID: <CAH5fLgi0dN+hkTb0a29XWaGO1xsmyyJMAQyFJDH+geWZwsfAHw@mail.gmail.com>
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

On Wed, Oct 16, 2024 at 10:45=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Wed, Oct 16, 2024 at 5:54=E2=80=AFAM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> > +/// Polls periodically until a condition is met or a timeout is reache=
d.
> > +///
> > +/// `op` is called repeatedly until `cond` returns `true` or the timeo=
ut is
> > +///  reached. The return value of `op` is passed to `cond`.
> > +///
> > +/// `sleep_delta` is the duration to sleep between calls to `op`.
> > +/// If `sleep_delta` is less than one microsecond, the function will b=
usy-wait.
> > +///
> > +/// `timeout_delta` is the maximum time to wait for `cond` to return `=
true`.
> > +///
> > +/// This macro can only be used in a nonatomic context.
> > +#[macro_export]
> > +macro_rules! readx_poll_timeout {
> > +    ($op:expr, $cond:expr, $sleep_delta:expr, $timeout_delta:expr) =3D=
> {{
> > +        #[cfg(CONFIG_DEBUG_ATOMIC_SLEEP)]
> > +        if !$sleep_delta.is_zero() {
> > +            // SAFETY: FFI call.
> > +            unsafe {
> > +                $crate::bindings::__might_sleep(
> > +                    ::core::file!().as_ptr() as *const i8,
> > +                    ::core::line!() as i32,
> > +                )
> > +            }
> > +        }
>
> I wonder if we can use #[track_caller] and
> core::panic::Location::caller [1] to do this without having to use a
> macro? I don't know whether it would work, but if it does, that would
> be super cool.
>
> #[track_caller]
> fn might_sleep() {
>     let location =3D core::panic::Location::caller();
>     // SAFETY: FFI call.
>     unsafe {
>         $crate::bindings::__might_sleep(
>             location.file().as_char_ptr(),
>             location.line() as i32,
>         )
>     }
> }

Actually, this raises a problem ... core::panic::Location doesn't give
us a nul-terminated string, so we probably can't pass it to
`__might_sleep`. The thing is, `::core::file!()` doesn't give us a
nul-terminated string either, so this code is probably incorrect
as-is.

Alice

