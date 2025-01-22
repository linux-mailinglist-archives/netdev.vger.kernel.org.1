Return-Path: <netdev+bounces-160209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6722A18D92
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 09:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5992F1883DD8
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 08:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4645B1C461F;
	Wed, 22 Jan 2025 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5Jxdo4E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675CA1C3C1A
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737534230; cv=none; b=BoXIBzo8AlJCYHQ2QS8wK5wOo8oWFtk4lsiV9w3dMds1bZDHPse9nJoqWGUljjVmSR8g32dJdwkRfZdwW0cJBznieFxh8LOm8slDCTmF8pAREdCCYtvFWYgmCiBqbir1S8HdBTdVIpTBwRiwsr5ilBMMsrdLhBuzz2TKHDdkLC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737534230; c=relaxed/simple;
	bh=UWEKk0/IajddWYr4MmXpzVVsoY8VGZOwDpU8j3Zg6A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y02/zA1+fn3rdRDKPdA3jkmWbV72O+6IDzCMbCvUQmTk/fp2yMctSuR+pEEdS5JP3x0uaqJ4ai3L6CqHas31YFVL7Xl6YhEzTCJTzGa1p1q3neU81fUsbdWGXMF2ep/vgCPnzKdrTiDNLoyOq3KrnlaK8vhU1nX/jQWVaXZb+Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X5Jxdo4E; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso45666155e9.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 00:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737534227; x=1738139027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcEI1cNhN+P7WzD6tOAkMg6iUZz4y1VQgFqyHXgPSKM=;
        b=X5Jxdo4E6YppxR9V87Qw65nSn6hRnJjL+3KukqZjRXGWExP5LN76+9mpCVt891R4NL
         ezuNs3f1ksL3m0fmjd2e1cXruwwyg5onK1FfbHLsRYz6ZYudSHfs1g04l7S0Yyws2QMZ
         dCtDkqDpJ7LEisf9KKH8wLSufM+LkIYxU2ZRjvQF296LVpTz5YGsqQCmNxcQHSyxZEfd
         Zl2NccYgKuFuRpbAZHBlxEofa9AQXHqb1ztPllYbJyRG0lHGMM/gSTELT+Y3424GF3Ps
         LlUjQONdfHsyqHxHExJ9TdI7B2ZTKjMP+MfxxK0HIwJvCLQXLtklHMicuysTE6TuLx76
         OzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737534227; x=1738139027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcEI1cNhN+P7WzD6tOAkMg6iUZz4y1VQgFqyHXgPSKM=;
        b=WFZxMTFo+bcC3qRybKTAARoENGS2Zbz8WxJNea3KVOOGQUXc/oPcyUAdRF/jyAkePZ
         4LaSQvOhv3znc0/zv2eT7OuIbSxr/kvkDaSKZgcWIiick3lfYpD7j9G6xA75v0TlTyFR
         30Q5bB71xXC69e3SGtfTSIHGZq3cKtYSSZCkxZ/pK6ZHc3iGQmuri17wInsEXaOuEf3c
         pGLLB7WR5ZT0j2L1von+y2yMIcJyyM1CaJhF6mU6N91Y6pUQIOW5mBdFJWAVpxEu2eQk
         hUn/eeXlZCHUqoZyFs+ZfDCCq4v14EebUI2b2s7UYTHP2WW6IXXIwzbQ6bVV7IKWKXxZ
         56QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTWpILetoy8PALtwTv2y57xZ8SRU5bRu6ONBKOxz2jYG0zq9mtekv32RQ0wj/xT2vckR8Nn88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGFe6mp9NxNuJ65H4D6LOrNhz9UJaQUNYBV0qkQYKw1WplYIF
	H3dHOsBB0+ErVVfy2beTVTZZtLO1kMJDvCw72OERB6PeoTxR4SfcXklyXZXWvjl+IdXoIuoy4Tp
	PedMbUO9/0ZjeBo4vwkU/04S9zRFLm0anj20M
X-Gm-Gg: ASbGnctcvicDWq3MQHlYCJoCzj7mJRiW2NpREptfW1k/vJPKDimyWYbSt5xLAR0caO3
	o8MPPrYY14QPirbReIajgWFFZFMKwxUzHuUQCgUyymf6l+rcdCO2jljb7FBKAyGzEwJdC5J/F3A
	q0POFf
X-Google-Smtp-Source: AGHT+IGLhcoLGibp60qeyppb6Y4slI01E6V64KDqpYcBLyjS2JRjLl/fT2k0OancRcx0JWo/ju/1iHpMauZS/9Lsk2E=
X-Received: by 2002:a5d:6d86:0:b0:385:e38f:8cc with SMTP id
 ffacd0b85a97d-38bf59e1e56mr24039806f8f.38.1737534225084; Wed, 22 Jan 2025
 00:23:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72nNsmuQz1mEx2ov8SXj_UAEURDZFtLotf4qP2pf+r97eQ@mail.gmail.com>
 <20250118.170224.1577745251770787347.fujita.tomonori@gmail.com>
 <CANiq72kqu7U6CR30T5q=PvRam919eMTXNOfJHKXKJ0Z60U0=uw@mail.gmail.com> <20250122.155702.1385101290715452078.fujita.tomonori@gmail.com>
In-Reply-To: <20250122.155702.1385101290715452078.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 22 Jan 2025 09:23:33 +0100
X-Gm-Features: AbW1kvaYoDa6HCJU-y7gMRZCEOShJlhUhzZjI1chC4RAjHWOFxFe9aV4LXFN85Y
Message-ID: <CAH5fLghgcJV6gLvPxJVvn8mq4ZN0jGF16L5w-7nDo9TGNAA86w@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: miguel.ojeda.sandonis@gmail.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 7:57=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Sat, 18 Jan 2025 13:17:29 +0100
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>
> > On Sat, Jan 18, 2025 at 9:02=E2=80=AFAM FUJITA Tomonori
> > <fujita.tomonori@gmail.com> wrote:
> >>
> >> /// The above behavior differs from the kernel's [`fsleep`], which cou=
ld sleep
> >> /// infinitely (for [`MAX_JIFFY_OFFSET`] jiffies).
> >>
> >> Looks ok?
> >
> > I think if that is meant as an intra-doc link, it would link to this
> > function, rather than the C side one, so please add a link target to
> > e.g. https://docs.kernel.org/timers/delay_sleep_functions.html#c.fsleep=
.
>
> Added.
>
> > I would also say "the C side [`fsleep()`] or similar"; in other words,
> > both are "kernel's" at this point.
>
> Agreed that "the C side" is better and updated the comment. I copied
> that expression from the existing code; there are many "kernel's" in
> rust/kernel/. "good first issues" for them?
>
> You prefer "[`fsleep()`]" rather than "[`fsleep`]"? I can't find any
> precedent for the C side functions.

I think that's a matter of taste. In the Rust ecosystem, fsleep is
more common, in the kernel ecosystem, fsleep() is more common. I've
seen both in Rust code at this point.

> > And perhaps I would simplify and say something like "The behavior
> > above differs from the C side [`fsleep()`] for which out-of-range
> > values mean "infinite timeout" instead."
>
> Yeah, simpler is better. After applying the above changes, it ended up
> as follows.
>
> /// Sleeps for a given duration at least.
> ///
> /// Equivalent to the C side [`fsleep`], flexible sleep function,
> /// which automatically chooses the best sleep method based on a duration=
.
> ///
> /// `delta` must be within [0, `i32::MAX`] microseconds;

I'd do `[0, i32::MAX]` instead for better rendering.

> /// otherwise, it is erroneous behavior. That is, it is considered a bug
> /// to call this function with an out-of-range value, in which case the
> /// function will sleep for at least the maximum value in the range and
> /// may warn in the future.
> ///
> /// The behavior above differs from the C side [`fsleep`] for which out-o=
f-range
> /// values mean "infinite timeout" instead.
> ///
> /// This function can only be used in a nonatomic context.
> ///
> /// [`fsleep`]: https://docs.kernel.org/timers/delay_sleep_functions.html=
#c.fsleep
> pub fn fsleep(delta: Delta) {
>
>
> >> A range can be used for a custom type?
> >
> > I was thinking of doing it through `as_nanos()`, but it may read
> > worse, so please ignore it if so.
>
> Ah, it might work. The following doesn't work. Seems that we need to
> add another const like MAX_DELTA_NANOS or something. No strong
> preference but I feel the current is simpler.
>
> let delta =3D match delta.as_nanos() {
>     0..=3DMAX_DELTA.as_nanos() as i32 =3D> delta,
>     _ =3D> MAX_DELTA,
> };

Could you do Delta::min(delta, MAX_DELTA).as_nanos() ?

Alice

