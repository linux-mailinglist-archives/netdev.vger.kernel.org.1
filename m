Return-Path: <netdev+bounces-136715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE609A2BC3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024161C22CA3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339661E0492;
	Thu, 17 Oct 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5rqbdZ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84DE1E0488;
	Thu, 17 Oct 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188632; cv=none; b=tND4gMkClzfbiClmY/gtEtc6f+QSZDlOCfcpyTFuQDaCObBq9lzY3NCMDFfwy+uhsM7gEwLj6JdqKXYk0q/fHNKXXrm4kMTK1h9AcCTWbNHWT74xDX494RMbdH6mx5BMr84+RdENA2boZnJCaR7AcC9Ym8tk2NAPhnDkMzM9zxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188632; c=relaxed/simple;
	bh=Bh99JxM9q54zziB/cnIKlH6IL9DaAqVimCRaGd+lvJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fd1r/emlxV0aGK8Ut/mjQeoM+oDqjSBjIQmEW3PXdzT8GVDGlS5Faeyl4Rc5Wu8+sV/P0jEFFBsSNbYUI9MM2a+TkmIuDRcIvJPhLFvEisgVUL0zJ0vixL6ZqC7FVNvfuP0pphUUWA+Kok3AtdwJrLby5vfhfZXGm1g9Azy/aZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5rqbdZ7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2ab5bbc01so178686a91.2;
        Thu, 17 Oct 2024 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729188630; x=1729793430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLYg/PrE7d8ZEcksHh1Keo/M0pUeENGxqn8BH7XJq/8=;
        b=C5rqbdZ7BkIz20OPqzxNPHtCO+mqoWy6UmaNI9P+IA1uaSGMP3DbDFRXZl6n6eTNQb
         bdHOfh11yis6TPca5f4JcoLjnkUf5qYnOPEFCzkSRhboSoWrJSkm9f0zvcX32CJx7tBH
         mwjEddUYVdrUYKvw+vBevfnDptVRvc5LIHBa+aZPWQ8lknzkAk11XcVMlr4omOrkCQ4T
         5La2XX0/iqW5ad26j2L0zdbFc/6zBTbVW5bLDMFuIyig7SiEqUMtzTXckKQml6ANBgDN
         tE5bwJNHpFt2tKuxeRjlzErWDtP9Plz99yBdfy+mrlwlRJfkaq11viymLjheGEbjA6xc
         Eaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729188630; x=1729793430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLYg/PrE7d8ZEcksHh1Keo/M0pUeENGxqn8BH7XJq/8=;
        b=KUMZQWztHIkUoSUf6uyWMhYfOlOcSsXGX80a7U9Og0mDXRHWowXGmXaGi0laGqQujD
         nscPIIsSaIks1HoejO4mKLT0YaQvCz0TolkJUi3OugstUZHr5V2PWMIfF6qPSl10FUsV
         i3vOE/cN3aWwbmt3wxvaG/wORL0desZLn/FM3nlLHbQPL+gvdvlXTBUSkGMezBymmQD1
         SB4R6t/5PtY3+/U8QpwtqtvGeFkk9fULtAEHVbKc7otl38nSZDF/9Bv8lGTcQGFUedbe
         VC1cQDHvEp0Ed8aq1M5nuqZDSFAX3uYwaXbReFpXp/h4DI5xnCrNsHBFA4faRIyU12cK
         FfdA==
X-Forwarded-Encrypted: i=1; AJvYcCUgMXZ4d8Vz3i5sUdWEAvW+YwCQcI+iN52BOq6RUZF5HDVFdVWl57Nf8N5Jtrv30UXH6S6be/MmrLZ4IIrwiYo=@vger.kernel.org, AJvYcCXc/8ip8XVkhTWRs78i5X9WQDDqEcGRCz0rM2oLWeiGLs0D0Yb9sTiGf5SP8+ThYFi7i6ND+Zx5@vger.kernel.org, AJvYcCXdpJ5xxwRfLFLza82mBfElOONXms0s9u8Tvbvd4u2J+8GoLzaU58jDaZQBgkuX1KSc+sklkhNgnJEd0WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNTwsUb1+liDp2spmLqmXKTDfhcKq8EPHXN8BKpskPAGbK+6uU
	Td3/9XvFT3lqSnRMNp3rSQpCDE44WU7C6XfuOgw3wpbXjxPiim83lodskMfu/0DisaIAhuYy+qY
	V2HMLCXSJ3rZ50ceAjrUVeGxp3/0=
X-Google-Smtp-Source: AGHT+IFsGsMgqqxSupUxYY0sqOKeWzeZazz5rAcSHXcWyJE/FcWXIh1/40qdfPjCKMoMk/8XHsyf1FrR7OO7plvVdGI=
X-Received: by 2002:a17:90a:1582:b0:2e2:e860:f69d with SMTP id
 98e67ed59e1d1-2e55dd3b524mr138810a91.7.1729188629897; Thu, 17 Oct 2024
 11:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-5-fujita.tomonori@gmail.com> <ZxAZ36EUKapnp-Fk@Boquns-Mac-mini.local>
 <20241017.183141.1257175603297746364.fujita.tomonori@gmail.com>
 <CANiq72mbWVVCA_EjV_7DtMYHH_RF9P9Br=sRdyLtPFkythST1w@mail.gmail.com> <ZxFDWRIrgkuneX7_@boqun-archlinux>
In-Reply-To: <ZxFDWRIrgkuneX7_@boqun-archlinux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Oct 2024 20:10:17 +0200
Message-ID: <CANiq72kAL8OWCerpXYOeJDcHZNdT+QRj6Vw3YUBYiQG+hgYcVA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/8] rust: time: Implement addition of Ktime
 and Delta
To: Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 7:03=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> The point I tried to make is that `+` operator of Ktime can cause
> overflow because of *user inputs*, unlike the `-` operator of Ktime,
> which cannot cause overflow as long as Ktime is implemented correctly
> (as a timestamp). Because the overflow possiblity is exposed to users,
> then we need to 1) document it and 2) provide saturating_add() (maybe
> also checked_add() and overflowing_add()) so that users won't need to do
> the saturating themselves:

Generally, operators are expected to possibly wrap/panic, so that
would be fine, no?

It may be surprising to `ktime_t` users, and that is bad. It is one
more reason to avoid using the same name for the type, too.

My only concern is that people may expect this sort of thing (timing
related) to "usually/just work" and not expect panics. That is bad,
but if we remain consistent, it may be best to pay the cost now. In
other words, when someone sees an operator, it is saying it is never
supposed to wrap, and that is easy to remember. Perhaps some types
could avoid providing the operators if it is too dangerous to use
them.

The other option is be inconsistent in our use of operators, and
instead give operators the "best" semantics for each type. That can
definitely provide better ergonomics in some cases, but there is a
high risk of forgetting what each operator does for each type --
operator overloading can be quite risky.

So that is why I think it may be best/easier to generally say "we
don't do operator overloading in general unless the operator really
behaves like a core one", especially early on.

>         kt =3D kt.saturating_add(d);

Yeah, that is what we want (I may be missing something in your argument tho=
ugh).

> but one thing I'm not sure is since it looks like saturating to
> KTIME_SEC_MAX is the current C choice, if we want to do the same, should
> we use the name `add_safe()` instead of `saturating_add()`? FWIW, it
> seems harmless to saturate at KTIME_MAX to me. So personally, I like
> what Alice suggested.

Do you mean it would be confusing to not saturate to the highest the
lower/inner level type can hold?

I mean, nothing says we need to saturate to the highest -- we could
have a type invariant. (One more reason to avoid the same name).

Worst case, we can have two saturating methods, or two types, if really nee=
ded.

Thomas can probably tell us what are the most important use cases
needed, and whether it is a good opportunity to clean/redesign this in
Rust differently.

Cheers,
Miguel

