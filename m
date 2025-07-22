Return-Path: <netdev+bounces-209060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2BEB0E219
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC1F565D5D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA8B27E043;
	Tue, 22 Jul 2025 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPNXL+dh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4284C277814;
	Tue, 22 Jul 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202739; cv=none; b=EdTSaIrQvp1mrzrFLN/9n18MSfUSnv/D+U9fRhBWNv80Cp+RbBmG5dDpeSdzanlxC52xnC5MWSf0GGcvtMF2T5Ds54c+K432FI7ab8jsZ7zHZzfRL3Zv3TpyolJM/VW8+0854NU3GuIrhJaOl8BRuoa8qdtxLfcp7+PrC3grr7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202739; c=relaxed/simple;
	bh=PHTcopnvoUUPICM9yN+/r0sMQFYJuZdnPPfIUrcHjqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ma8aBE/Xp7IohMOKOZI5QLu5VY2e///76tq4OcwCxbev5XQweqoCXaTAndTJZe9s9EoHrWNixI9eli12bG7CALKzUDkHb9klEfEkoZEEbRoF18Q+ZJg9B20hKNvRqFX+o9x/QgQ/7te9kW7xSWN41qW/WY6Tavd8zo75lF8sMcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPNXL+dh; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2ff94cc4068so1171276fac.3;
        Tue, 22 Jul 2025 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753202734; x=1753807534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrrhnQ3SPCtHnglawQ3hAL35cOq58qAmmuM+Az+YVko=;
        b=nPNXL+dh08NofRx5m0Dj5snNvjdBng3FlKZE6xsEdzf2JVu1qRHzhdEr78dCcXgu+1
         rpm359OUG/uDPyP7Vd/ExPhUtIl62Zujm0dZFh3KOFHt4S7SjWXAw9m8K/kBaDdXSO54
         hIBjQkkM42FZCHlN2smMnyZ+wr7AznG1h9ThG0O3or2wszTrlhza6D0OPi5hj+cGomIz
         +ADZhj6HYrRHzXyirL1H1lBzOO6TE533m/WAbc+rixOVIklVdHDOi+lzLqgfqtMTjzpx
         pp8yHI4xdRm9CjC691qOeuCXQbjE4yEObA/2lnSa1uGOS+SJbtSa1M+XM2k5HhtHAsvq
         CxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753202734; x=1753807534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrrhnQ3SPCtHnglawQ3hAL35cOq58qAmmuM+Az+YVko=;
        b=DV1EmTBJISFM9t/E4L1r6OS5QCw/oQw0UiSZ8TK0c9aQcooTcPfUiutzbMVS83kIbx
         NpdbxbtX1fnfnZvf/twb6wQOe4oCFin1stO+QQArwJi3u172ltn1JX2Au20v4ZsGwpFC
         TCOGfZhAg8HmljXRLSQKTsPnKhXOHDK3G0iBtPobc9O4hBGfE9CBH3cQBC3MKaqeDN33
         0Pcil4zrYfZrIIPsK0L2gmJI+FVmDEK2nq0Fkt85lIOjeGbh6JvwXizzvJMEIb0yTPM2
         S6Ie+wiRxxfWWFEysZBrVttBLtf2HoHn21llmmxvibzxZcwcpbjedUyAYkoCeQ+b3a18
         kj6A==
X-Forwarded-Encrypted: i=1; AJvYcCU7Zv2zcdNkrXYYMzFyt8l/Xbjs8cZ9KXdnZbebLkQTuCPR97+qRhRMhA6zuBKR5Om1FvKPm91jUJkj/w8=@vger.kernel.org, AJvYcCWNfwQYUbhhW8cewCHODgdVcOFhgds8ozsgPp0om5wydipeCRnrwUP2vQ0U1fXvTFLs9n9ocPCA@vger.kernel.org
X-Gm-Message-State: AOJu0Yys2SfvURoiV1MKvaCJ/r52T5Al+/u2glGH7Qjpa2wga/RWP+ev
	X1oLfCBKux+hqHE+Ek6d3pKPsgh1R/SrnXQGhmNwMTP5Z/PAfAtsUq3e3RTWHMocqimzZbuowX6
	5RV296JPq3ehOXVWpgmfBvJrIQuHlsd0=
X-Gm-Gg: ASbGnctidhwWPZYYOqVWCCWZGLEmzk5MWqoqD3adGREpqIEZNJW3Jv2G45xHkRzLeCg
	LiKR/ujfT9T/H4E8eLS4e91UuZeywc/4f3m2AHF154iYzM8b7ItjkIWHig4fA1BPLapl9S3z3k7
	J+UHuLHR2EP5HBUOWN+tmHHXXrr+RE0MUlUPnnMi3OFBMI15WdGgKggCpj/x8BIwmmJkoB/5Mt6
	maSeMZ0
X-Google-Smtp-Source: AGHT+IGujhh+TbcurHZKA27S4y43iuhUTCYpSn+qbOkt4C52QbJ8LuGP672Oxj7Kn+OQIp+QBBMom2C1Kfhm6mASIxo=
X-Received: by 2002:a05:6871:3685:b0:2ff:a814:dfdf with SMTP id
 586e51a60fabf-300e9dcc04dmr15297143fac.20.1753202734115; Tue, 22 Jul 2025
 09:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071508.12497-1-suchitkarunakaran@gmail.com>
 <CANn89iJgG3yRQv+a04wzUtgqorSOM3DOFvGV2mgFV8QTVFjYxg@mail.gmail.com>
 <CAO9wTFgzNfPKBOY5XanjnUeE9FfAGovg02ZU6Q1TH-EnA52LAA@mail.gmail.com> <CANn89i+dif2qjKM6oO1o=BKutXoO6w9kWnnPfc50BDBJ7VpAeQ@mail.gmail.com>
In-Reply-To: <CANn89i+dif2qjKM6oO1o=BKutXoO6w9kWnnPfc50BDBJ7VpAeQ@mail.gmail.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Tue, 22 Jul 2025 22:15:22 +0530
X-Gm-Features: Ac12FXxPP_X2GzzSAxaYHWL1BgGFTF8gKQEBJ5k-jWzRXfsqbB-cYKlnKc5mw8o
Message-ID: <CAO9wTFgYMfDzmL_PfpX4jRKaG2mEZmNq+rLRyprGLN6r23udkQ@mail.gmail.com>
Subject: Re: [PATCH] net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, sdf@fomichev.me, 
	kuniyu@google.com, aleksander.lobakin@intel.com, netdev@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jul 2025 at 21:58, Eric Dumazet <edumazet@google.com> wrote:
>
> On Tue, Jul 22, 2025 at 9:22=E2=80=AFAM Suchit K <suchitkarunakaran@gmail=
.com> wrote:
> >
> > >
> > > WRITE_ONCE() is missing.
> >
> > Oops, I'm sorry about that.
> >
> > >
> > > > +               while (i >=3D 0) {
> > > > +                       qdisc_change_tx_queue_len(dev, &dev->_tx[i]=
);
> > >
> > > What happens if one of these calls fails ?
> > >
> > > I think a fix will be more complicated...
> >
> > I did consider that, but since I didn=E2=80=99t have a solution, I assu=
med it
> > wouldn=E2=80=99t fail.
>
> But this definitely could fail. Exactly the same way than the first time.
>

Yeah, it makes sense.

> I also have a question. In the Qdisc_ops structure,
> > there=E2=80=99s a function pointer for change_tx_queue_len, but I was o=
nly
> > able to find a single implementation which is
> > pfifo_fast_change_tx_queue_len. Is that the only one? Apologies if
> > this isn=E2=80=99t the right place to ask such questions. I=E2=80=99d r=
eally
> > appreciate any feedback. Thank you!
>
> I think only pfifo_fast has to re-allocate its data structures.
>
> Other qdiscs eventually dynamically read dev->tx_queue_len (thus the
> WRITE_ONCE() I mentioned to you)

Yup got it. Thank you so much.

