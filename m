Return-Path: <netdev+bounces-159327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7524BA151D9
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC267A2D2E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8482A155CBD;
	Fri, 17 Jan 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSxBdML6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C36C1547F5
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124282; cv=none; b=LhLadMj/11GOmG3IylRfgodgMoTTPaQPYnSZ6PzZ7RfrBBj0bRv8YDDfDzsn+hZLKaxtZhw6fFEnD+maKxTYbk7z3mo/yHPA2BPx0e5QUvucpXGONSATzsy6XySo2iBwomsniZvzXMYq/IAHlOotzyNq34ZFwk9IQ6vdGjkWgYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124282; c=relaxed/simple;
	bh=3ao/GWH5Tc2xAnwaRzHtnnwvVkVRW9lwqtS8ByvomIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CulZP51vozMG7fJV0LQXqPFNKfrXDVVJGbpvKgsed6BwczdTt39Y1lZ4Sy/FnATC+Vjk9dfptC3XiXKuDN9uNjitkRzzMKXb0UD1PYuIffV6gh58BzJSHI/CXewbQNcmTinTAXEoHxgnsJO3qd/dxjfARrjOJXBpCme1NK1olcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSxBdML6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385d7f19f20so1108283f8f.1
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 06:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737124279; x=1737729079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR55i3HkYctE7pnXIlYdROvAQkAqVIwUg/mFNkzAzc0=;
        b=rSxBdML6vUtDXjGNOQefMmw+vp2iczk7QX6SeqbM2/iRpEuEc740x6SMjVwL0osccM
         0RM8metTvwvQA8DwgfGaHcHhY0crrDMwFKHio0PF+49TJCHkz+JW3KMlcsO64fUUzAco
         URBr8G4wEumubQRwJcjyLHLLosyrkIGJpSvuXnP/hODVm92IobrmkGvpmqaZHLPna8w2
         kNujZDyHxDQZdcC4XIhyQq6AgT06IPjTunWC9s29uRkJKSVdykCT7mQSVEU2lwlBwpOV
         NgpgMuW5QfkdPuXV1kEg2YbZDKRSDOxMgfKQ++QnF5JU+HrG8P8pOw7kVRvs3sRVQHQ5
         YS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737124279; x=1737729079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SR55i3HkYctE7pnXIlYdROvAQkAqVIwUg/mFNkzAzc0=;
        b=Dto3hsyQTZZmpMrRnUicvFSlpPfeL3UenqbqF/6ijtuIsrxcg6GWClQenshLP1BW5Y
         QJ2yvD8bViELfnAqbKRolinmvQCa2IPtdndxiZA3C6MsALGttlUSlaT96KLXFF0gU+fu
         75nNtfb73pu5n++wPLa3RkXVneAea80x01NN2op8ag9TmHzOk5+QvPYkz9LIR16GGq9x
         jm72hSgzltcLs0qdKXuL8fUFeyi9hSbOMWzYNcLICMMbtFwkGVrKxEXz6/E/x6H12IRo
         2Rg7c14zAF4Nka+uAYHgDaAkGmWboWhisw4n6f+Q3LUP9VwG2tYTpQrtb+46vuYfNDkn
         Vyzg==
X-Forwarded-Encrypted: i=1; AJvYcCXO3m1BglIQcFyrV3bqj4G2M1Mk3ht6rurhOirLuLjI+466FqJWdVMQb3gVvYS/NGivdyKsQAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF42gJGKTBJP4vXQT4hhqPs1BIGcMGEvA/9IIWaGdQDpFVjAx0
	MmiEnA7mJFZXdD+Fz/URuv+sb8GAyEEoTi1geIqDFAIBQUSFCnQbM7RIzTZr/96wPyGGCApiuyW
	yJaGgowX2sUDmiFRZZ9LFqrFFZidbSg5SrTmR
X-Gm-Gg: ASbGncsihkVEQI0w5CwTaYWGPSmFdgCr3AE8/I8h4HvSQFZqzpQCSPwPfmeHacj7ixQ
	H0W1ZlLut9xOk6dFrECVCwB5RA6bFo0WpPZPUQhc=
X-Google-Smtp-Source: AGHT+IGODadZTBAPzKwgax05vY9NUHUfkPNs+7IG+444xS58i4EJ6Pre/dh+yQmUcOszmxuzeJpeMHnIsaQ/pkp5F+c=
X-Received: by 2002:a5d:508d:0:b0:38a:673b:3738 with SMTP id
 ffacd0b85a97d-38bf5688e01mr2489905f8f.33.1737124278795; Fri, 17 Jan 2025
 06:31:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH5fLggUGT83saC++M-kd57bGvWj5dwAgbWZ95r+PHz_B67NLQ@mail.gmail.com>
 <20250117.185501.1171065234025373111.fujita.tomonori@gmail.com>
 <CAH5fLghqbY4UKQ2n1XVKPtvnLfJ4ceh+2aNpVmm9WxbUTu8-GQ@mail.gmail.com> <20250117.232015.1047782190952648538.fujita.tomonori@gmail.com>
In-Reply-To: <20250117.232015.1047782190952648538.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 17 Jan 2025 15:31:07 +0100
X-Gm-Features: AbW1kvYSufSejqtJamYDlgBaixJFLn8sr1F6oBphlqAd7AYJWrHcRO2_8GhIn5w
Message-ID: <CAH5fLgh7jpDyOGJPpasSK8E126YUUL+gj37_2RQr8m2fE9ifVw@mail.gmail.com>
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

On Fri, Jan 17, 2025 at 3:20=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Fri, 17 Jan 2025 14:05:52 +0100
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > On Fri, Jan 17, 2025 at 10:55=E2=80=AFAM FUJITA Tomonori
> > <fujita.tomonori@gmail.com> wrote:
> >>
> >> On Fri, 17 Jan 2025 10:13:08 +0100
> >> Alice Ryhl <aliceryhl@google.com> wrote:
> >>
> >> > On Fri, Jan 17, 2025 at 10:01=E2=80=AFAM FUJITA Tomonori
> >> > <fujita.tomonori@gmail.com> wrote:
> >> >>
> >> >> On Fri, 17 Jan 2025 16:53:26 +0900 (JST)
> >> >> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> >> >>
> >> >> > On Thu, 16 Jan 2025 10:27:02 +0100
> >> >> > Alice Ryhl <aliceryhl@google.com> wrote:
> >> >> >
> >> >> >>> +/// This function can only be used in a nonatomic context.
> >> >> >>> +pub fn fsleep(delta: Delta) {
> >> >> >>> +    // The argument of fsleep is an unsigned long, 32-bit on 3=
2-bit architectures.
> >> >> >>> +    // Considering that fsleep rounds up the duration to the n=
earest millisecond,
> >> >> >>> +    // set the maximum value to u32::MAX / 2 microseconds.
> >> >> >>> +    const MAX_DURATION: Delta =3D Delta::from_micros(u32::MAX =
as i64 >> 1);
> >> >> >>
> >> >> >> Hmm, is this value correct on 64-bit platforms?
> >> >> >
> >> >> > You meant that the maximum can be longer on 64-bit platforms? 214=
7484
> >> >> > milliseconds is long enough for fsleep's duration?
> >> >> >
> >> >> > If you prefer, I use different maximum durations for 64-bit and 3=
2-bit
> >> >> > platforms, respectively.
> >> >>
> >> >> How about the following?
> >> >>
> >> >> const MAX_DURATION: Delta =3D Delta::from_micros(usize::MAX as i64 =
>> 1);
> >> >
> >> > Why is there a maximum in the first place? Are you worried about
> >> > overflow on the C side?
> >>
> >> Yeah, Boqun is concerned that an incorrect input (a negative value or
> >> an overflow on the C side) leads to unintentional infinite sleep:
> >>
> >> https://lore.kernel.org/lkml/ZxwVuceNORRAI7FV@Boquns-Mac-mini.local/
> >
> > Okay, can you explain in the comment that this maximum value prevents
> > integer overflow inside fsleep?
>
> Surely, how about the following?
>
> pub fn fsleep(delta: Delta) {
>     // The argument of fsleep is an unsigned long, 32-bit on 32-bit archi=
tectures.
>     // Considering that fsleep rounds up the duration to the nearest mill=
isecond,
>     // set the maximum value to u32::MAX / 2 microseconds to prevent inte=
ger
>     // overflow inside fsleep, which could lead to unintentional infinite=
 sleep.
>     const MAX_DURATION: Delta =3D Delta::from_micros(u32::MAX as i64 >> 1=
);

Hmm ... this is phrased as-if the problem is on 32-bit machines, but
the problem is that fsleep casts an `unsigned long` to `unsigned int`
which can overflow on 64-bit machines. I would instead say this
prevents overflow on 64-bit machines when casting to an int.

Also, it might be cleaner to just use `i32::MAX as i64` instead of u32.

Alice

