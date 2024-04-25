Return-Path: <netdev+bounces-91464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BF38B2A8F
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 23:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AA01F21D94
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 21:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4D01553A0;
	Thu, 25 Apr 2024 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZojpZkhq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034514F9ED
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079756; cv=none; b=msBdzSDn6+4qkrq6cgeTBPqp8dshSgI1IosPu6z/pGjOeCcn8rdeNLipARY/3Dzd15YTU+Ar0eX7gDTbXWun3AFUj0+V1GMzKesyOYEg8SzLlzuaELq2QhpOaNTlslS4Y8waszKUK30llyL86g3EJbXfOgxZ5TR/59CKMv6rVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079756; c=relaxed/simple;
	bh=/FFmdsR9O9Fym31s3IonpaadQSALFxi+gkgXELQJDnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KImwcmiFgsLgxulZkXPOdP0wSseEvHU7P4IK79NvKa1M091yqIstlrqX+113wq7SOJL/zOZGPC11MOxtIHfMWyJSFhFYZo7WGa2WG28qlbImFZN8/aB5GQa5Fz65FUHsxJckRPiReTIWWxtj18WLTWbMHgpaRCsJuuk7wjoSIpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZojpZkhq; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61af74a010aso15058177b3.0
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 14:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714079752; x=1714684552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blHg8bPgQUhKFHhF3jugQx9VV2zZlze7Lx295xv8KO8=;
        b=ZojpZkhq/yy3e12S1EdvW7NZ1HQqwDsjipNIlBAwkZHQBp3wL6s4Ak7nUpEXQiX8Ah
         ypZ4D/HjUCmVnLg6/oCHHFLbibbB8os3U2eQUCtn+mrnSNaahEvJxfx2rMMW2/TTMSF+
         I8TzsJEaz3bJNQAVZQoWnFBYA7kz4tGsyHVyWk73o98IxKhctpcdIPR7lnWruDCcO7Jw
         ackP23FAux8skycWtVUt+fd8u8u89H6eUFhALRLfXWEmoT+B+XybtWgjNJtm0uP0QGwR
         8K5U3KhTPOTyAvfrcb2eF8ljc67XdxM18J96xaevr9amVnqwVaoelPwS74TjZtw8/Mga
         Dw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714079752; x=1714684552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blHg8bPgQUhKFHhF3jugQx9VV2zZlze7Lx295xv8KO8=;
        b=ty6Nc2ZXknQqdxz2LdfQCZiNiZjsumLq6FsdHbHwpRdowcE1cJsJwH+MZch5qqbskx
         zwjoV7Lz7LMDBWtiXqzscxOqu+eH3Hw/6qq/3gjdoc+pt0Zpau5N4YVE5OQbUSqnsmzP
         Pm/bfTzKYpODBIOJVHPWdvgtFX8IA91KjfWeSOKPzNGisTDTVPR4KCBrBefwUebDSCeA
         J6LRl38xKdaEOb1gQNyuLaLKoj1OXYrxuZbC5tY/x6AxvQGX/f/eZ0/NgOULmEIKbYUV
         4MoGx1zTHUqbw4LV/0DWhbUMUHiZ64pkpB8Bi67wM09wywZZBDyrSE5L1fnYPvTGb9CF
         TG5A==
X-Gm-Message-State: AOJu0YxL8HVCObJCL53RAFf51SO4dCviqZqX9bBubxgLnjr5mWf8rJzC
	U5227uxR/S4/LrYDS0URZXP+2W2aN4uFDbpX+xXMh3Ub1/U0vhUxzh74c2SuAd4bKuKWS+GwmO9
	fKQt003s0UXmTdnKTaaenX/tYK+5x/mkYYB6RUWLMSNqQeuw=
X-Google-Smtp-Source: AGHT+IFMG9abgUnUOH42JDmyak5//G7o2zxfCzKspMlLs8dzKSAWFr7GjM1qAAC+DwceIip9znmuHzM0W7zyN3KgmQg=
X-Received: by 2002:a05:690c:6803:b0:61b:df5:7876 with SMTP id
 id3-20020a05690c680300b0061b0df57876mr803329ywb.6.1714079752424; Thu, 25 Apr
 2024 14:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416152913.1527166-2-omosnace@redhat.com> <0a814ce3acdea2c07cef6f7c31008e19@paul-moore.com>
 <CAFqZXNvsumcLSKKRGzvUDmz=6WYfw3a0tG43juBjnUTdbfsDsw@mail.gmail.com>
In-Reply-To: <CAFqZXNvsumcLSKKRGzvUDmz=6WYfw3a0tG43juBjnUTdbfsDsw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Apr 2024 17:15:41 -0400
Message-ID: <CAHC9VhRdcMS6WQ1QJD1h+YbNGh0x=Ex-+MvKLSaVqaPdfuZueQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cipso: fix total option length computation
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 8:49=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Tue, Apr 16, 2024 at 8:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Apr 16, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > As evident from the definition of ip_options_get(), the IP option
> > > IPOPT_END is used to pad the IP option data array, not IPOPT_NOP. Yet
> > > the loop that walks the IP options to determine the total IP options
> > > length in cipso_v4_delopt() doesn't take it into account.
> > >
> > > Fix it by recognizing the IPOPT_END value as the end of actual option=
s.
> > > Also add safety checks in case the options are invalid/corrupted.
> > >
> > > Fixes: 014ab19a69c3 ("selinux: Set socket NetLabel based on connectio=
n endpoint")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  net/ipv4/cipso_ipv4.c | 19 ++++++++++++++-----
> > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> > > index 8b17d83e5fde4..75b5e3c35f9bf 100644
> > > --- a/net/ipv4/cipso_ipv4.c
> > > +++ b/net/ipv4/cipso_ipv4.c
> > > @@ -2012,12 +2012,21 @@ static int cipso_v4_delopt(struct ip_options_=
rcu __rcu **opt_ptr)
> > >                * from there we can determine the new total option len=
gth */
> > >               iter =3D 0;
> > >               optlen_new =3D 0;
> > > -             while (iter < opt->opt.optlen)
> > > -                     if (opt->opt.__data[iter] !=3D IPOPT_NOP) {
> > > -                             iter +=3D opt->opt.__data[iter + 1];
> > > -                             optlen_new =3D iter;
> > > -                     } else
> > > +             while (iter < opt->opt.optlen) {
> > > +                     if (opt->opt.__data[iter] =3D=3D IPOPT_END) {
> > > +                             break;
> > > +                     } else if (opt->opt.__data[iter] =3D=3D IPOPT_N=
OP) {
> > >                               iter++;
> > > +                     } else {
> > > +                             if (WARN_ON(opt->opt.__data[iter + 1] <=
 2))
> > > +                                     iter +=3D 2;
> > > +                             else
> > > +                                     iter +=3D opt->opt.__data[iter =
+ 1];
> > > +                             optlen_new =3D iter;
> >
> > I worry that WARN_ON(), especially in conjunction with the one below,
> > could generate a lot of noise on the console and system logs, let's
> > be a bit more selective about what we check and report on.  Presumably
> > the options have already gone through a basic sanity check so there
> > shouldn't be anything too scary in there.
> >
> >   if (opt =3D=3D IPOPT_END) {
> >     /* ... */
> >   } else if (opt =3D=3D IPOPT_NOP) {
> >     /* ... */
> >   } else {
> >     iter +=3D opt[iter + 1];
> >     optlen_new =3D iter;
> >   }
>
> How about turning it to WARN_ON_ONCE() instead? It's actually the
> better choice in this case (alerts to a possible kernel bug, not to an
> event that would need to be logged every time), I just used WARN_ON()
> instinctively and didn't think of the _ONCE variant.

I'd really prefer to not have the WARN_ON(), even the _ONCE() variant.
We're seeing more and more discussion about avoiding the use of
WARN_ON() similar to the current BUG_ON() guidelines.

> > > +                     }
> > > +             }
> > > +             if (WARN_ON(optlen_new > opt->opt.optlen))
> > > +                     optlen_new =3D opt->opt.optlen;
> >
> > This is also probably not really necessary, but it bothers me less.
>
> I would convert this one to WARN_ON_ONCE() as well, or drop both if
> you still don't like either of them to be there.

My preference would be to drop both, although as I said earlier this
last one bothers me less.

--=20
paul-moore.com

