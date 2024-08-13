Return-Path: <netdev+bounces-118198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD44950F45
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6A228493A
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 21:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B741A76BB;
	Tue, 13 Aug 2024 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qDCHQfgg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8163F19DF49
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585819; cv=none; b=Sap4OOFaIzk0ui0bE/iy+aKIdR3vyfX/YUedLHXfpY3iDzi2s8+BOwQw3gAaurRFdoXROdMoN6ks8Awe+M/5MY2Tyatx6ynUDK5y/jeFcAsHkbgk7mR0PE/yEV+5ISuIvC7QgwD0Kzjxy9LXj+v9B+kx+W4ZanqSqFBrktVg3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585819; c=relaxed/simple;
	bh=Eo9cLrGrsiOf2rVTelEn1LJUk+568Belby8uwLONfTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ruT9gD4DLq09bRLBXF9xNU1MzmgNRkUuKKquKGw68MzcgidqsjczNJOIhhpxiCnE4LWKnPTGnLrpsc7A8IcK2+1h51QqFUxO6bwZuwRFbh1BiNBr64ajk7AkkVYn9P0Ew4l1Ft/3lCY+N/bHHy9BEfI6Lyj5Xcp8RnS4U7WYInE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qDCHQfgg; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d024f775so397247885a.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723585816; x=1724190616; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSiV3SuCMfW9JOqoJiKPvJCeDk2FrtYrANArULa+fHk=;
        b=qDCHQfggQN0m+1jTpWldncrsrqtQSbm6J6Zmr89F0qP0X8Y1LmLjI9R8Na9+dObc1T
         ViRYlqzN/4LBbhn/65HlRXE6e5EIL0FuxSggJiz7I83HpDajcpQHWY7LNBCreQtcJ4I2
         8Qt5X+HOBqnrwONXnKLp0vKb/mLIAFJvs9XwlaLwHuXDRZIa4UyyzIOQ8m3UeaCmxZn4
         Af0NBGW8815K5NQlqovRYc++yj07ncKanp6QBo6DP1D/38O0Q0+JIA/+Bg7xjHyCub/x
         C+jV+qM4wQUFZNVzS9u0muqRdj0l5Pmft5k/qOyCAwOv+Mq3VYc2C7nCZlp8c66Qxy0y
         F/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723585816; x=1724190616;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSiV3SuCMfW9JOqoJiKPvJCeDk2FrtYrANArULa+fHk=;
        b=oZWxiEJD56rsh8X1uRM7wkyWX8V3o9d7O/gYSSUa1qbyw8q8PbOBbghTVVc++3AMWu
         9GOq0yENl7d4aPSBShhpJ7tmNA2caKKPvIZRtOTbBZffDrBDcsQYtkeitRaVmUH5uTCb
         Bl3Mh396dS0jMrbzp+CupABIcUlOySEaIBlPAsKHDFhudzk4euZvZR8MTEI+VygTNPcP
         1idZTpGik8QrsujtHLGP6UHDwUsc6C7oANZ826eBkcFcL/z4AwntGF6elO2AaDTMsVn6
         pMQGLxVwN0VEWylq9tI3fQLGfbSaCrVCMmzGiyhinW+4hUhTLD9pwyudJ/pu1TXD/nOk
         kS6A==
X-Forwarded-Encrypted: i=1; AJvYcCXI1WB/9wHaO3g1vELVDfHvTgcuB8/ypI05SOWwHjHC3I+8WZjQPqfefaTxitKKvVsLSvTgCq0g0hNQt93gbdzNLGmW85k1
X-Gm-Message-State: AOJu0YxnZxow3GP1PSkalblGhgihUcoixiHqe+tN2flHD3486Bubz7ib
	ZxxNxBa7lPQQwBec5Q1Yt2c4AR0ICfwhYkXghzicg5DQx1tDGyggSjZqAHEPGQjmKyFLx8Yaych
	cuIlFKHnCD70/HcFpFOBFMUXkZknc1lIA43B456f6ikTjgxrvXmD3zlU=
X-Google-Smtp-Source: AGHT+IFnca/v+gpcDnq29UQq1DNCBSiG4yc+o/Pu/quDkhEYG0KrLjRvhqxXKXq8PgOJtiIYZagJkPd7d1zBGI0sgpk=
X-Received: by 2002:a05:620a:45a2:b0:7a3:5e6e:e8e3 with SMTP id
 af79cd13be357-7a4ee3ac4b8mr85925285a.53.1723585816231; Tue, 13 Aug 2024
 14:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812145633.52911-1-jdamato@fastly.com> <20240812145633.52911-4-jdamato@fastly.com>
 <CANLc=av2PUaXQ5KVPQGppOdD5neHUtUgioqOO4fA=+Qb594Z4w@mail.gmail.com> <ZrvTzX8CfyM40c8I@LQ3V64L9R2.home>
In-Reply-To: <ZrvTzX8CfyM40c8I@LQ3V64L9R2.home>
From: Shailend Chand <shailend@google.com>
Date: Tue, 13 Aug 2024 14:50:05 -0700
Message-ID: <CANLc=auVkEWwhEHVwK9UkdjJJ5z9FTRS6wK=zb9pCgoAm4CWdw@mail.gmail.com>
Subject: Re: [RFC net-next 3/6] gve: Use napi_affinity_no_change
To: Joe Damato <jdamato@fastly.com>, Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 2:44=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Tue, Aug 13, 2024 at 11:55:31AM -0700, Shailend Chand wrote:
> > On Mon, Aug 12, 2024 at 7:57=E2=80=AFAM Joe Damato <jdamato@fastly.com>=
 wrote:
> > >
> > > Use napi_affinity_no_change instead of gve's internal implementation,
> > > simplifying and centralizing the logic.
> > >
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > ---
> > >  drivers/net/ethernet/google/gve/gve_main.c | 14 +-------------
> > >  1 file changed, 1 insertion(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net=
/ethernet/google/gve/gve_main.c
> > > index 661566db68c8..ad5e85b8c6a5 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > > @@ -298,18 +298,6 @@ static irqreturn_t gve_intr_dqo(int irq, void *a=
rg)
> > >         return IRQ_HANDLED;
> > >  }
> > >
> > > -static int gve_is_napi_on_home_cpu(struct gve_priv *priv, u32 irq)
> > > -{
> > > -       int cpu_curr =3D smp_processor_id();
> > > -       const struct cpumask *aff_mask;
> > > -
> > > -       aff_mask =3D irq_get_effective_affinity_mask(irq);
> > > -       if (unlikely(!aff_mask))
> > > -               return 1;
> > > -
> > > -       return cpumask_test_cpu(cpu_curr, aff_mask);
> > > -}
> > > -
> > >  int gve_napi_poll(struct napi_struct *napi, int budget)
> > >  {
> > >         struct gve_notify_block *block;
> > > @@ -383,7 +371,7 @@ int gve_napi_poll_dqo(struct napi_struct *napi, i=
nt budget)
> > >                 /* Reschedule by returning budget only if already on =
the correct
> > >                  * cpu.
> > >                  */
> > > -               if (likely(gve_is_napi_on_home_cpu(priv, block->irq))=
)
> > > +               if (likely(napi_affinity_no_change(block->irq)))
> >
> > Nice to centralize this code! Evolving this to cache the affinity mask
> > like the other drivers would probably also require a means to update
> > the cache when the affinity changes.
>
> Thanks for taking a look.
>
> The gve driver already calls irq_get_effective_affinity_mask in the
> hot path, so I'm planning on submitting a rfcv2 which will do this:
>
> -               if (likely(gve_is_napi_on_home_cpu(priv, block->irq)))
> +               const struct cpumask *aff_mask =3D
> +                       irq_get_effective_affinity_mask(block->irq);
> +
> +               if (likely(napi_affinity_no_change(aff_mask)))
>                         return budget;
>
> with a change like that there'd be no behavioral change to gve since
> it didn't cache before and still won't be caching after this change.
>
> I think a change can be made to gve in a separate patch set to
> support caching the affinity mask and does not need to be included
> with this change.
>
> What do you think?

Sounds good!

