Return-Path: <netdev+bounces-243412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F685C9F49E
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 15:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 011104E2140
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5DE2FC874;
	Wed,  3 Dec 2025 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="JCP4E7Dr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592902FC862
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764772063; cv=none; b=HVmaD6zLULnAWNuJeOiAbZ4sEBA51IkLpSJWXT/5Ht8/Xaw2mILKsN0/Am0rwZtzi7fsJUPVjvqPe0wjud0Rpf+xxLPcniimOSP54uAEnodqZ69o+M77BrvlXO8S7smyDRj98KKPtywWvFscg3bwQKoO7KjE2oGtGW6kDVhyciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764772063; c=relaxed/simple;
	bh=wWTzrUpzTX4SJk//X3ZRdnOiElAdok9TiYFwDIDS0ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GU9KIgkVIWe8IqvhowcjlPrQ/qByhJfR+j0eecPiSLR7/s8QnXIFIEd3wlwUvi1zjel2QfA/2thwEGHdYDPMu1cUE1XDY3kabKVcTi7twhhrRU+iZfLefKd9L+lia4BUi601O0OcLDYqmPS64B9Vx1HHh4a4x6t6N3mDv/d5vZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=JCP4E7Dr; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7ba55660769so5804911b3a.1
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 06:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764772062; x=1765376862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Igppe6+ES5Wn2eFg/jj8SRWMr9cSJfS1jo6G4ZsA7iU=;
        b=JCP4E7DrPCYAmBYVksrq9P+kwFfYAslRWnwyuAAkedIwp8R+qQXVi3AMnzS76dpYEN
         KwZr1qW1BPf5Gkc/PWPmGK2YqkGnkWrxsrzdFFIJsXYILtbZUxe3uDyq4FegNL+gY53m
         qSuPdykAuxgupUqlHqkMUATVcwexUTo8FYhwG3scB/ZynMzlfJmhDOY76cZZZANRnpX+
         suChqMC8YWGdtDwn0GOXRHdvGkyUWtb0T0GmQkNiXeGR2UMTv1dUW+9u3Zg+EJpjdLut
         Ul9xZx1X3V6HTWbmsKud/iUEVoyLOZ9LoAQBkAj6MChytXNtEhV2LpiYsDJxRN+Vee0T
         BQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764772062; x=1765376862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Igppe6+ES5Wn2eFg/jj8SRWMr9cSJfS1jo6G4ZsA7iU=;
        b=URQAYskRw/DIgQfkq7AyOzs0oNZ7NUepwrZOnOjJtnrjrc1LWrQH0V3CUk5JR+c1Ra
         xSGn4QzQc0ytYESifO6VIa3lNkBT9XNPP6O5XKLkT7lEgb+YF+6n4XJY4ep6hnD+xSMy
         lNGf96B/WLqAWHNReh620xHDn8g2pD1dGdVrdiQJcytB+J9jxC2N+ITG4arrefmgPHs1
         BI9vaBgPZmLT2xqKtc+qGS/b8v0VsFn9rV1ph3hw4PFacvotTn/n0KQBpYUeGS9zgrvk
         PciIm0vT8YFsDwQ1FyzgTUhrMq8zJZjzkz6xQpnefr58WlNwOKzjoQG6+L4nJMk2IXSO
         ETMg==
X-Forwarded-Encrypted: i=1; AJvYcCXLiSt3NTSGNOfhOY0JSStM9IBWMg5a5sTljIr1CpslwAL0p2vM27KkyQyKxxNFsEnEkWy/DhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWrTlndQ6lxy/1l8eOz+6BpuoPJ4H17XsjGukKySj89yoU9/ZX
	caXrgCJs9sK+LSxHpKIkNulpq9rnov3n3K3FcIkVAgT/Mjn9B5cdZ6pxbyP04yNudxbue3NOEO3
	7qDmcKvEw9qrFnh5HB5iRmY3k8zSBHof+g+oUiqvP
X-Gm-Gg: ASbGnctAixOpDuI9dCwbmkkiS2fYUoHjDNCh25l9OTe5UhQHnWEfuJu21jRBmRZ+3Ia
	E2pOdnqe3QzkhK88Vnl5o7czLHRRWnALwrYOWUmzbYlFw+tZxwv19ol4lajMFPBSKtMZbVvVxLY
	XffAogRSzgnAHJCexwLBH0yEH+zUeQl2z+fNqZ4xCENosv90Ey2pT7tcfPlV31iAKI9R+kIQO7F
	cUkes3oo/WsF84nm+ArfVp5gCp6cAXGmvXzHS4qLXeqsKLgw5IT6jRL8jYrJOmMk+8vuhWOxyLD
	S8eT2Ly8goUbvg==
X-Google-Smtp-Source: AGHT+IGDCuUpNjdUshvN4Tp/jEk+5A9P4cK43AazL9l7Zg5oXNqVDQkPyC+GxmEEtLaHN2cWZiQO9OsJhEiV09Ry/l4=
X-Received: by 2002:a05:6a00:13a5:b0:7b9:a27:3516 with SMTP id
 d2e1a72fcca58-7e00dbe640dmr2898888b3a.21.1764772061469; Wed, 03 Dec 2025
 06:27:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124200825.241037-1-jhs@mojatatu.com> <20251124145115.30c01882@kernel.org>
 <CAM0EoM=jDt_CeCop82aH=Fch+4M9QawX4aQdKdiUCsdFzuC2rQ@mail.gmail.com>
 <CAM0EoM=Rci1sfLFzenP9KyGhWNuLsprRZu0jS5pg2Wh35--4wg@mail.gmail.com>
 <CANn89iJiapfb3OULLv8FxQET4e-c7Kei_wyx2EYb7Wt_0qaAtw@mail.gmail.com>
 <CAM0EoMm4UZ9cM6zOTH+uT1kwyMdgEsP2BPR3C+d_-nmbXfrYyQ@mail.gmail.com>
 <CANn89i+_4Hj2WApgy_UBFhsDy+FEM8M1HhutrUcUHKmqbMR1-A@mail.gmail.com>
 <CAM0EoMmoMUtrBHyYUWNeBnFFj8kDFYPyQB+O1fdGB4xk_bMWZA@mail.gmail.com>
 <CANn89i+zDW5ttPZ7fw2gDbVQqXj2uFoeEeTRSU6gzFLM3zGCeA@mail.gmail.com>
 <CAM0EoMmzt1tDpoqK=mMZoj1=6UU2Ytim2aqJWOBAZmPfNyZSfQ@mail.gmail.com>
 <CANn89iKKKwj33WgSbGKDa7JB=qRBXSH6VbiAV=umwOgwYsbmTQ@mail.gmail.com>
 <CAM0EoMngngPdwCqFrbEQAFgu+cMe0eVfBs1XKD4zTUCTpYYHOw@mail.gmail.com> <CAM0EoMn4rW3VOmEaxz2VBxGeywoQ_TBDSz7qKsS6AHjo0HNJWA@mail.gmail.com>
In-Reply-To: <CAM0EoMn4rW3VOmEaxz2VBxGeywoQ_TBDSz7qKsS6AHjo0HNJWA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 3 Dec 2025 09:27:30 -0500
X-Gm-Features: AWmQ_bnTd-6jsGdPjljxejJyqBLqaaRv4yz1lhlE4dA27F3s_V7x3Pvrx9aDs2E
Message-ID: <CAM0EoMmiTRqKaXK7Y7LQpm6yfkz6Q-pGn9e_bMo-t8++pqHZSQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	dcaratti@redhat.com, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 11:21=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Thu, Nov 27, 2025 at 10:23=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > On Thu, Nov 27, 2025 at 10:11=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Thu, Nov 27, 2025 at 6:45=E2=80=AFAM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Wed, Nov 26, 2025 at 3:30=E2=80=AFPM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > On Wed, Nov 26, 2025 at 12:20=E2=80=AFPM Jamal Hadi Salim <jhs@mo=
jatatu.com> wrote:
> > > > > >
> > > > > > On Wed, Nov 26, 2025 at 1:20=E2=80=AFPM Eric Dumazet <edumazet@=
google.com> wrote:
> > > > > > >
> > > > > > > On Wed, Nov 26, 2025 at 10:14=E2=80=AFAM Jamal Hadi Salim <jh=
s@mojatatu.com> wrote:
> > > > > > >
> > > > > > > > It's the multiport redirection, particularly to ingress. Wh=
en it get
> > > > > > > > redirected to ingress it will get queued and then transitio=
ned back.
> > > > > > > > xmit struct wont catch this as a recursion, so MIRRED_NEST_=
LIMIT will
> > > > > > > > not help you.
> > > > > > > > Example (see the first accompanying tdc test):
> > > > > > > > packet showing up on port0:ingress mirred redirect --> port=
1:egress
> > > > > > > > packet showing up on port1:egress mirred redirect --> port0=
:ingress
> > > > > > >
> > > > > > > Have you tried recording both devices ?
> > > > > > >
> > > > > > > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > > > > > > index f27b583def78e4afecc7112854b93d59c2520201..711fc2e31cb04=
51c07a39f9c94226357d5faec09
> > > > > > > 100644
> > > > > > > --- a/net/sched/act_mirred.c
> > > > > > > +++ b/net/sched/act_mirred.c
> > > > > > > @@ -445,15 +445,17 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(st=
ruct sk_buff *skb,
> > > > > > >                 return retval;
> > > > > > >         }
> > > > > > >         for (i =3D 0; i < xmit->sched_mirred_nest; i++) {
> > > > > > > -               if (xmit->sched_mirred_dev[i] !=3D dev)
> > > > > > > +               if (xmit->sched_mirred_dev[i] !=3D dev &&
> > > > > > > +                   xmit->sched_mirred_dev[i] !=3D skb->dev)
> > > > > > >                         continue;
> > > > > > > -               pr_notice_once("tc mirred: loop on device %s\=
n",
> > > > > > > -                              netdev_name(dev));
> > > > > > > +               pr_notice_once("tc mirred: loop on device %s/=
%s\n",
> > > > > > > +                              netdev_name(dev), netdev_name(=
skb->dev));
> > > > > > >                 tcf_action_inc_overlimit_qstats(&m->common);
> > > > > > >                 return retval;
> > > > > > >         }
> > > > > > >
> > > > > > >         xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D=
 dev;
> > > > > > > +       xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D=
 skb->dev;
> > > > > > >
> > > > > > >         m_mac_header_xmit =3D READ_ONCE(m->tcfm_mac_header_xm=
it);
> > > > > > >         m_eaction =3D READ_ONCE(m->tcfm_eaction);
> > > > > >
> > > > > > Did you mean not to decrement sched_mirred_nest twice?
> > > > >
> > > > > No, sorry, we should decrement twice of course.
> > > > >
> > > >
> > > > Ok, I tested.
> > > > While it "fixes" it - it's not really a fix. It works by ignoring d=
irection.
> > > > Example, this is not a loop but currently would be claimed to be a
> > > > loop because port0 appears twice:
> > > > port0 ingress --> port1 ingress --> port1 egress
> > > > Note: port0 ingress and port0 egress cannot create a loop.
> > >
> > > I am not familiar with this stuff, can the direction be known and
> > > taken into account ?
> > >
> >
> > Yes, it can.
> > To figure the target direction see tcf_mirred_act_wants_ingress() and
> > to get what the current direction see code like:
> > at_ingress =3D skb_at_tc_ingress(skb);
> >
> > > Really, anything but adding new bits in sk_buff.
> >
> > If we can fix it without restoring those two bits i will be happy.
> > To repeat something i said earlier:
> > The bigger challenge is somewhere along the way (after removing those
> > two bits) we ended sending the egress->ingress to netif_rx() (see
> > tcf_mirred_forward()), so any flow with that kind of setup will
> > nullify your xmit count i.e when we come back for the next leg the
> > xmit counter will be 0.
> >
>
> BTW, I have the attached patch but was waiting to see how this
> discussion is heading.
> It's when you have something like port0 egress --> port0 egress and
> you use something like drr as root qdisc.
>
> -- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -281,6 +281,14 @@ static int tcf_mirred_to_dev(struct sk_buff *skb,
> struct tcf_mirred *m,
>
>         want_ingress =3D tcf_mirred_act_wants_ingress(m_eaction);
>
> +       if (dev =3D=3D skb->dev && want_ingress =3D=3D at_ingress) {
> +               pr_notice_once("tc mirred: Loop (%s:%s --> %s:%s)\n",
> +                              netdev_name(skb->dev),
> +                              at_ingress?"ingress":"egress",
> +                              netdev_name(dev),
> +                              want_ingress?"ingress":"egress");
> +               goto err_cant_do;
> +       }
>         /* All mirred/redirected skbs should clear previous ct info */
>         nf_reset_ct(skb_to_send);
>         if (want_ingress && !at_ingress) /* drop dst for egress -> ingres=
s */
>

Eric,
Are you still looking at this?

cheers,
jamal

