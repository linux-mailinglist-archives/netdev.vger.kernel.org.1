Return-Path: <netdev+bounces-160253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD2DA19022
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEC9162C6F
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B892C21148F;
	Wed, 22 Jan 2025 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sz0oUUgb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE131C4604
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737542874; cv=none; b=Bb3hykhhFJANiUA4u1yfAg0SS9+Kufn3rwa1JE9t3JDAskd+ma1+AhKiZtbHarrkB22PLve41U4+BgD//Nn5C3dPqe4hmEDv34GvTLs3C6tlEmSGLB5/cf1gPWXSc42sZhlyOmeJj1WwMN1jf7KCZL+X7cAdHbXL+hPdbcW3gmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737542874; c=relaxed/simple;
	bh=YiEVAGJjaoNTHegqcY0gFKrNQ+Six7SlC5lmq+DYv20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aV3I8R80GZrtY60lw4lCo3L1DMmErDzrXtaYI2pfrFm2t7TPHlO9DjGxbBkF+Oiut09Qos0s4xV5p+uLuRKPcLpQB5TsLjyTYPsM5QxOiW2YwBks/Nsy9v9uMduUlHblhW+dQymzsoiWa3RNvgzM2H2V+ANsaItoBe0jtO+xU7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sz0oUUgb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-386329da1d9so3713547f8f.1
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 02:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737542871; x=1738147671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAMlvwzH+Ng/xl8muCU+t8wbB02LbrBAfMtlAQeLQ9M=;
        b=sz0oUUgbC7IqK5ZkxsftRW7pzh8cqxL3J5GYBA5Hb3J0BC4yVCP36mTvqcJHIMd9Rw
         3OS+EpklNFw7ebYd69EUN5QaSCQ2uEGG8RuN5wR+yB8CvOfGIxNqU+zLB+YdjAaQvZEX
         Om4ZOklIroW6k1XOrtgqK2VEUreFKQ5tr5A5gztEU/jwPcFX0Tg3Igt35Ia1ROPdw8KS
         aSVxFThTK1D2CuTLeJcU/JkAmqSZEkd6OJwJTdWzHhIt5tUGBNcprjaRmsoud6G7v+1p
         G+BfhQ+4QfjuJ5STA1HVaLqW0LNhK5iZQ6JM0MqYKsFpErhTlBxFwtrxWmM8cxBSzPf3
         u5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737542871; x=1738147671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAMlvwzH+Ng/xl8muCU+t8wbB02LbrBAfMtlAQeLQ9M=;
        b=VNFtxY+68H4dupzH/SkG+xi27XJBUiTMFLBORjjJ/T2Mxg2s3K61Bi6ZVoMAM3LeoP
         kgF/AiKMalH1Cd2lj1twNW7oWleQR+2faT9CMciXI0dea/OWhZbI1mrcEulHkw0ZmSlw
         8uQN5HdNvL6zGsPKPfYl2X66h6FXGZF6TEK1pGkf8lqyXcsyNZRLiyN2A3kHPM8fFklV
         Exw9qtsIg2y+aKh3wIMZjJpKJMNOJ+d1QRzpbUOyOInMtWbNZYQtWkniqwITikvT0xU5
         symzFeg/b3clsdxoEveMa6GP5T33idSZdU1Xdac92RM5H/800OjevPp+P/euwapp6Eri
         OFLw==
X-Forwarded-Encrypted: i=1; AJvYcCWOHtUbMTxu1kwWrNL4jZ8DaF6wMjZMJAb7Em/aIBumEfFincuSvwZlUs4wYOEYuKYJpYa2/Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1iLFZk1ws/OA7RsPaxbNwNYYdGp3HN2PMWRCC3UYl5NDMTU5+
	//E8ferxszPCstNcFJIU00hwfgsSXymj+wuigHoclCE5THlbLyBi8ATLBfa0ObInf5YyJhe59NJ
	5ZXUfZizfaAFhT7lcw/Qy9z449ct6+2cuGswx
X-Gm-Gg: ASbGncsZCyCCAj0+P4K35OAH4IDMbs1FBiaApiIQ2PBnG4cXBJ6VLoqMeJj6TqnyOtr
	9hNYpya0VX1Id50o2I6lzDpSblN/AY3zWUUQy1s4NG0N3M2z1fqtTrMb6KfwZATl4vXC2TUUxYS
	WAARDY
X-Google-Smtp-Source: AGHT+IFWavTmDRB8/jgeW8CJi5BRkOi2cZqt1vFzTf60svaw9Mn+2HR3yMBzEoJQuwOHoEXEXAzAvsgUJWm6mSgipMM=
X-Received: by 2002:a5d:588f:0:b0:385:f220:f798 with SMTP id
 ffacd0b85a97d-38bf5655b12mr18111784f8f.6.1737542871130; Wed, 22 Jan 2025
 02:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72kqu7U6CR30T5q=PvRam919eMTXNOfJHKXKJ0Z60U0=uw@mail.gmail.com>
 <20250122.155702.1385101290715452078.fujita.tomonori@gmail.com>
 <CAH5fLghgcJV6gLvPxJVvn8mq4ZN0jGF16L5w-7nDo9TGNAA86w@mail.gmail.com> <20250122.194405.1742941306708932313.fujita.tomonori@gmail.com>
In-Reply-To: <20250122.194405.1742941306708932313.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 22 Jan 2025 11:47:38 +0100
X-Gm-Features: AbW1kvYPNCJ_OEMhXw5wZW68xizrdf7gH6-wZQQhXhiBoEIM8R03-BQuIRCiqTY
Message-ID: <CAH5fLgiEqd6uAzx5bkSDzst6hB0Ap=FAB7tOs96+WBL-pHN+ZA@mail.gmail.com>
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

On Wed, Jan 22, 2025 at 11:44=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> >> >> A range can be used for a custom type?
> >> >
> >> > I was thinking of doing it through `as_nanos()`, but it may read
> >> > worse, so please ignore it if so.
> >>
> >> Ah, it might work. The following doesn't work. Seems that we need to
> >> add another const like MAX_DELTA_NANOS or something. No strong
> >> preference but I feel the current is simpler.
> >>
> >> let delta =3D match delta.as_nanos() {
> >>     0..=3DMAX_DELTA.as_nanos() as i32 =3D> delta,
> >>     _ =3D> MAX_DELTA,
> >> };
> >
> > Could you do Delta::min(delta, MAX_DELTA).as_nanos() ?
>
> We need Delta type here so you meant:
>
> let delta =3D std::cmp::min(delta, MAX_DELTA);

If `Delta` implements the `Ord` trait, then you can write `Delta::min`
to take the minimum of two deltas. It's equivalent to `std::cmp::min`,
of course.

> We also need to convert a negative delta to MAX_DELTA so we could do:
>
> let delta =3D if delta.is_negative() {
>     MAX_DELTA
> } else {
>     min(delta, MAX_DELTA)
> };
>
> looks a bit readable than the original code?

At that point we might as well write

    if delta.is_negative() || delta > MAX_DELTA

and skip the call to `min`.

Alice

