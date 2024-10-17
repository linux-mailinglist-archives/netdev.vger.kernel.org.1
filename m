Return-Path: <netdev+bounces-136457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE339A1D14
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802341C204FB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4FE1CEAA3;
	Thu, 17 Oct 2024 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBCxnL6B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034CB199944
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729153357; cv=none; b=YRlWEJD8FVGBF8q2JQ2OwHgFmbXIkE1S1+H+yCWqZ6DZnWWSkDbO9hWKCBRxNrJxPofauB6aBlqvOaH6EAYj2UYEUFCB4hAp9fLA0cdvY8Dzb6XAEk19kMTctmPnMGitFy7DhPthi1cqvMw6has7RDq4oPiyBIixcNHVvvjfEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729153357; c=relaxed/simple;
	bh=LHpKCji377DFMvaRbAFReZQaRgC0Kh3loXnkIDQ8RYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBjxNjNIC5czW44qOVIH9AOSQ3kken+3HLc5qnMjV3vQViZqb4u4XPRqNPcqI+hBaWxRii7LBs8ppzQ1RP1ymZqY/WT7QqqO7WUuqCiZf6C0fQuZ8mV+M2VtzCf8y6MtHdFU3d9ZYN+OIcjZrwP60Qe70ypg/aJL3bdt6Wcp4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBCxnL6B; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4ba20075so461273f8f.0
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 01:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729153354; x=1729758154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsXxx6/wl/PtaXF1WXd5AaVkjicmsyDuglgPitrvJwM=;
        b=DBCxnL6BNJPyNMaomba0nAcsynBzaLsji6TDxlPIDEYv1j6DSCcVWgHqxIVBC9Iohs
         9vQrA8fpGyked8GzHKaHaTMi9hr4LR7hwYnySmzkbRpOwWV1C4M8+6apffMaj6m9RQzP
         XUbkZCpORuukhfL1e3Sy3LtVFeLXVBQTkTgrU0SDz9vOBCVrK+2ZJBCAHgndioDVQ04N
         XjCvkc2o9llj8bJUjnoWciu+CZaPfqEfOgiDT99vhFIrYWSv9h1JeqdIqrnJr1xBHtP2
         8dHdTiv4GLqQPi7gFeSOMt1U/qwrjljpZ1hM8aGYvUBk9FQC44b1ZHBoJSfQ1AS4zB1q
         GF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729153354; x=1729758154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsXxx6/wl/PtaXF1WXd5AaVkjicmsyDuglgPitrvJwM=;
        b=PNzoPMjuNe952uZ1dTGLIk0XVSJABq2vpb3K7sXTuoaJNwRpONMVh9YVW7wmU5PYb3
         M+bd5CKwq89u9B3/Jt8gT/26cWLUQWl1OCvGjGQYN+ZFVvcUiLBhaqk5NDOUfkWuwpBh
         TX5ABesbuzZf1kJAd0rh4ABYIO9nWVvlk9zetXxxDXm7VPoshGvFsh6DT1uC0BKWgj/z
         UN4IjGSTmmzEF1GGnuoBH2XAV1rglZcSawCDWXtYDclqm4DpCnPDNkSNgcNiA2HEbqc+
         7mC8UnhhPoPGyOiUz8BnmkNJXj7ojJB3tVhVb15ApjJpZxDnuhzD72o/sF7xovpJXfXD
         Bb2g==
X-Gm-Message-State: AOJu0Yx/+sKDO7+r7cgXdVPWvEoMs+R4k+yVcPWgNEm1FymO/P+7lZvv
	NVjmMZKg3VmH8jL8FDYwkO7ofunihXH6DfNOTBEg1u0ujPicJdiiNDCDccXJHZl+nSijtplP6FG
	vgaiecb41waAxwyWbDlyDpmbIbpwjHPAfzawg
X-Google-Smtp-Source: AGHT+IFP0+h2AsfG6hM/KnGPmpu8BMbSpOOTSaL3KNMUlPYqSuiL84qJGLwymSL6TV65MTUPfPFzY2cx7qmxGe21PDM=
X-Received: by 2002:a05:6000:12cc:b0:37d:41df:136b with SMTP id
 ffacd0b85a97d-37d551ca167mr12503719f8f.13.1729153354030; Thu, 17 Oct 2024
 01:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-4-fujita.tomonori@gmail.com> <CAH5fLgjKH_mQcAjwtAWAxnFYXvL6z24=Zcp-ou188-c=eQwPBw@mail.gmail.com>
 <20241017.161050.543382913045883751.fujita.tomonori@gmail.com>
In-Reply-To: <20241017.161050.543382913045883751.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 17 Oct 2024 10:22:20 +0200
Message-ID: <CAH5fLgiPztunRXrEKF1=sCB16QfbFhQ19p_EorA2f1Xnfu3-zA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/8] rust: time: Change output of Ktime's sub
 operation to Delta
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 9:11=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Wed, 16 Oct 2024 10:25:11 +0200
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > On Wed, Oct 16, 2024 at 5:53=E2=80=AFAM FUJITA Tomonori
> > <fujita.tomonori@gmail.com> wrote:
> >>
> >> Change the output type of Ktime's subtraction operation from Ktime to
> >> Delta. Currently, the output is Ktime:
> >>
> >> Ktime =3D Ktime - Ktime
> >>
> >> It means that Ktime is used to represent timedelta. Delta is
> >> introduced so use it. A typical example is calculating the elapsed
> >> time:
> >>
> >> Delta =3D current Ktime - past Ktime;
> >>
> >> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> >
> > So this means that you are repurposing Ktime as a replacement for
> > Instant rather than making both a Delta and Instant type? Okay. That
> > seems reasonable enough.
>
> Yes.
>
> Surely, we could create both Delta and Instant. What is Ktime used
> for? Both can simply use bindings::ktime_t like the followings?
>
> pub struct Instant {
>     inner: bindings::ktime_t,
> }
>
> pub struct Delta {
>     inner: bindings::ktime_t,
> }

What you're doing is okay. No complaints.

Alice

