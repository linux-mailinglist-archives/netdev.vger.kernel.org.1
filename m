Return-Path: <netdev+bounces-132741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33197992F08
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E951C23616
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EDA1D61A7;
	Mon,  7 Oct 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d80rBEkU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473F71D61A3
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311084; cv=none; b=Ua+uWBetYCq6Ur8DNQm/dLmPX1C/poludCG/jtmgsvPJDuhV4TP6eLvu4QnVUVHhcOEvq+KufJZqEKdmJMrYOjEiuIjaa6crvPUaQiP0peGx55bXTLhI+kg63vVUUHTILJnvMR0nnceJAIUg8spheHiDxwihShjDa4DNjH3nudQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311084; c=relaxed/simple;
	bh=M/ln/IfRG23UW65hQDx2sPi2M1oZ1ULBSaWU8tBPOQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smLJqIRSB/SKI2opExIGrSOK7esOjEUCrmk8PfRUmfdK+z5exCIx20XNMK/HrTZsB2h8ZFHHyOh7I6pop1aO8t5VoNHTOKoqSG4mpcvNR5u+CflBXj58WWtfnUt97A0C3C+zMnQauJ3r7ZrWXHJhaPu2+bbVbG/Is8TbQmINL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d80rBEkU; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea1b850d5cso195689a12.1
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728311082; x=1728915882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMzHKJcLgL4mw0mj0q3+1HsZsdarzSx1Vg2HXSvY4Sk=;
        b=d80rBEkUzhDsi5lz1SwK7HDvpLitxX7Ntn8CG5K7XwOl2Nrz23NXVs+7EVOAO2tgIG
         aZReRkULwcbABT4p8T8HUphRUE3rKmgmG16V7do2uJ2eJcRGpsY+ph/teyPrNz6p9ADh
         B6C378f4XkUGRY2mo/opqE6kOlGddUPQOy2O63+3jx8RZUr3lr1AtYpnIZHsf8Aj0Jz9
         SlAfQqOH6tx8yxJBnyt+UjnauLQYhAC+vi6KrZ+PoZgsSvlWiXwmWC687IcBAmg/aNoK
         rCIaEZ0zX1gndXDenp9PIHMUwnw9DMD20xoCR6OFOdqZT31i552UOcn0raqiabDTal09
         Yqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728311082; x=1728915882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMzHKJcLgL4mw0mj0q3+1HsZsdarzSx1Vg2HXSvY4Sk=;
        b=F/yj3eKTh+WKlLElJBRjWW8MMEK/LcSEpqUtzPn7jj77hpJeVahzOExnDxc53UhbUQ
         ywZ9+vKoNxOluoBcjV9EF8GCxoTwc7sP/iq1PgUU4VssFYntGuve2TaeGRGbNnJGAcPv
         2FRpPwNsQqDz4eNrwL7YISCEE82z0yuTvGPBN3WnfFwoq+BWzGY6MVCe7QTYAej0A6Fr
         3yBzWbrOV2SDgQCRTsEd+OTNtkLgBMvmB3jKqdUEVzmFHmMCNN8W56V7IwmqFERswd3N
         9pwxhLeETnDIpdOUvITcw/cHJcdE+Nq52rXXqLeZE3uPzeokXMhsFGNYKsaRU6II3gCp
         zZoA==
X-Forwarded-Encrypted: i=1; AJvYcCXNmSW6VtOy4I15/6RAywd1CkSd03MzV2mA6D4q5T2yr8RpQ6YB7rsH58+L38Oz8dMOy1isPhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvMx8HN5L4Xbq4itrkB4u+wF22QY1Bz3SrHrBdrBEF3FmXsNpk
	JdjRR24ZRBuV9wWdZeBtqXkeJd8e2WOGuITvu1mn47TbcnXLI+pW4bqW7ocuivmiaWcMon/ScLC
	PBo/8BrQ4KqtM+PL6uZbQ/xZfQw5FZ+g4WuBh
X-Google-Smtp-Source: AGHT+IFw6uM5+6C7SMH67mk+Hc1sAMfXhD2yPqK2binLtdR+dEflXw9OzVkLv56wMCTjpeR0STCBxEH2wN1oY363ons=
X-Received: by 2002:a05:6a20:d81a:b0:1d3:5202:f9a8 with SMTP id
 adf61e73a8af0-1d6dfa3b32bmr18029273637.15.1728311082348; Mon, 07 Oct 2024
 07:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-4-fujita.tomonori@gmail.com> <CANiq72=YAumHrwE4fCSy2TqaSYBHgxFTJmvnp336iQBKmGGTMw@mail.gmail.com>
 <20241007.151707.748215468112346610.fujita.tomonori@gmail.com>
In-Reply-To: <20241007.151707.748215468112346610.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Oct 2024 16:24:28 +0200
Message-ID: <CAH5fLghps=Aa69Aye5PCGu6LuoHomMcQYEN1USTd5JiBkLdJLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] rust: time: Implement addition of Ktime
 and Delta
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 8:17=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Sat, 5 Oct 2024 20:36:44 +0200
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>
> > On Sat, Oct 5, 2024 at 2:26=E2=80=AFPM FUJITA Tomonori
> > <fujita.tomonori@gmail.com> wrote:
> >>
> >> +    fn add(self, delta: Delta) -> Ktime {
> >> +        // SAFETY: FFI call.
> >> +        let t =3D unsafe { bindings::ktime_add_ns(self.inner, delta.a=
s_nanos() as u64) };
> >> +        Ktime::from_raw(t)
> >> +    }
> >
> > I wonder if we want to use the `ktime` macros/operations for this type
> > or not (even if we still promise it is the same type underneath). It
> > means having to define helpers, adding `unsafe` code and `SAFETY`
> > comments, a call penalty in non-LTO, losing overflow checking (if we
> > want it for these types), and so on.
>
> Yeah, if we are allowed to touch ktime_t directly instead of using the
> accessors, it's great for the rust side.
>
> The timers maintainers, what do you think?

We already do that in the existing code. The Ktime::sub method touches
the ktime_t directly and performs a subtraction using the - operator
rather than call a ktime_ method for it.

Alice

