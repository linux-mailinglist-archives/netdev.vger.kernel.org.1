Return-Path: <netdev+bounces-242329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA4DC8F407
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FE8D34427E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809E826F471;
	Thu, 27 Nov 2025 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="IFqY2jcD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B720332BF40
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257013; cv=none; b=brhS9902Yw4vRXXGRE3r6LUZkkolObaLUqxrqH/a+K8igXcnaZI4k87EZE1V4+DGryR2TdFup9w04b1WFDDBoe4PGVov9wuX9lYy3BCh0azP444tdVHhZjP8zMxuj4V5osjy40scHf1rMuv9Y/4DSwueqAczQMTSn8zspYDblGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257013; c=relaxed/simple;
	bh=snVZQrqTVEWex2m9bNxSVbf5nmhz6O7pQs+yrCT0LGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kot4U6NWGabcdZ5jFiUsHKahFUYrLdSxBnhnCaV0pgx+qrhq6GSxIebsY0iCuw/Wj1ZWY024b7S8o053JmF9njPgi5fACBu/tqrElZ9RlUIUpcrwIfpuei1nkC4MCiCODWx4Ql1b/Zn5EqW0PCDcno+bYO+k+ekEMjsxeYQuGK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=IFqY2jcD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-343806688c5so733212a91.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 07:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764257011; x=1764861811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF5SVznq17En29aIlJHSRTajaPhzGUPfWZ5+s0SFU9Y=;
        b=IFqY2jcDeMLWA/uZtpA71pegI77/AQMccCFkrJdnUXkZLaKCF+O1szG6CnznmZq+j7
         DI7pPduKjTtPaim1czqDwGIKCoKoCLGBfRHSXciPApMPGPbBKjv/ZY1Ov+baGIERWlW0
         KupHlUZOBSkXnPXIkuBecBVU5q4YMrQBpELKsIK72INkKz2W5joewrNKoR2RiGLId686
         sZ4G7tlH+a9UbUzJBjLFAUKBpNzFuTOe1CcrXVJit0LOW50gMMVsu/WOx2PwMX+VNVkC
         UWi0senLXwI6lP/RqB8vuowU8QGUu2zkoQHgeVd59T+RfB4lLR+G7oScPo0rlzua0Rfr
         HF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764257011; x=1764861811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yF5SVznq17En29aIlJHSRTajaPhzGUPfWZ5+s0SFU9Y=;
        b=OpMKOTlyTPDaM9Qxvs/Ue7CQfIq1729FWU+Xrr27tfwLw7Y7uKb24laoAB/XCJAebI
         GPkp8i0mRlIoTYTr1ykkVlCW9aNQ0b0q2+T6nCDxuETMPcsv0PGkdGCwDCVO4IdDcyN2
         V7L/v9jwNITCnidZR4p3dPq6c8DxXw0FOFdpnZJzfXnmaM/8ALik0S3w97l3674MlyYu
         FT5340HFPZhP/GUKUuZI1EOUdW+TLal/MoOFT579QxBRcAoJkbFLwV5liuG+7qykOSez
         MvyUjLzSe1+j5D7M8jNUkbuplgDrzfQI778ea8y+4lULz6kVdVJRh9g9AWBig9OcUEa0
         QqbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGjXLS/R9E4c2e5KKdas6oCUiCW3xAq7YffrZ11OmQbe2dUyYqn0civiwIRV7VEWUm/povW4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCcUKOVF5KnkSjHiuyFow+c6EzSl4pi37I+e2ZhlQVwdtv5HUE
	LOA1aMZkAYDGLalojuQi4ZZMVkQhO2IXfY9mwxKpvWb94+uxiO4h2UPR9i/dMMg0QF1pt+5+FAn
	1zKulswIAFNpJzqLBjAeh5pASokKg1cxUlG4r4oUI
X-Gm-Gg: ASbGncvP0k37Hw6MdqDwoCCV2/knvvnf2/aIJr8YAH5icee6No/TIv+X7b1k05Oy5lq
	hu6J5dqAlq5gC84jvcanCpOfYBI2iDkY0h+DqD45gSncH/K0U0UvHbL7ttqo3DhztHHrlVFJDdB
	7TOR088tMvr+kyj2JDCrWIAUYZh/p948E5HY9uRSiOpVUw3HkNl4WKcvi2eDWsU7VAmvebyn+6T
	CXTDLoVu+U9ZH/0ETAV3POT+4yPVTBLW+mWrVNFFKZAOQfqI1xaxPT1fEzJ71QSeNIPxTuWwl8s
	Lu4=
X-Google-Smtp-Source: AGHT+IEvwYQ59s4V8ZKMwK+fUJseLYJ2ZtT0dvG7JcsGOEEdlwV0+sLEi6XI7Y/ZVcsl+C+Ccm1sURPrKSCjcSaV+zI=
X-Received: by 2002:a17:90b:57cc:b0:340:5b6a:5bb0 with SMTP id
 98e67ed59e1d1-3475ed68e2amr10534410a91.26.1764257010955; Thu, 27 Nov 2025
 07:23:30 -0800 (PST)
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
 <CAM0EoMmzt1tDpoqK=mMZoj1=6UU2Ytim2aqJWOBAZmPfNyZSfQ@mail.gmail.com> <CANn89iKKKwj33WgSbGKDa7JB=qRBXSH6VbiAV=umwOgwYsbmTQ@mail.gmail.com>
In-Reply-To: <CANn89iKKKwj33WgSbGKDa7JB=qRBXSH6VbiAV=umwOgwYsbmTQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 27 Nov 2025 10:23:20 -0500
X-Gm-Features: AWmQ_bkhAmtiB5ahdfZcgYIiBrWCu43ByF1a9wOtseuiN-pDKiymddGvyRRB67E
Message-ID: <CAM0EoMngngPdwCqFrbEQAFgu+cMe0eVfBs1XKD4zTUCTpYYHOw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	dcaratti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 10:11=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Nov 27, 2025 at 6:45=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Wed, Nov 26, 2025 at 3:30=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Nov 26, 2025 at 12:20=E2=80=AFPM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> > > >
> > > > On Wed, Nov 26, 2025 at 1:20=E2=80=AFPM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > On Wed, Nov 26, 2025 at 10:14=E2=80=AFAM Jamal Hadi Salim <jhs@mo=
jatatu.com> wrote:
> > > > >
> > > > > > It's the multiport redirection, particularly to ingress. When i=
t get
> > > > > > redirected to ingress it will get queued and then transitioned =
back.
> > > > > > xmit struct wont catch this as a recursion, so MIRRED_NEST_LIMI=
T will
> > > > > > not help you.
> > > > > > Example (see the first accompanying tdc test):
> > > > > > packet showing up on port0:ingress mirred redirect --> port1:eg=
ress
> > > > > > packet showing up on port1:egress mirred redirect --> port0:ing=
ress
> > > > >
> > > > > Have you tried recording both devices ?
> > > > >
> > > > > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > > > > index f27b583def78e4afecc7112854b93d59c2520201..711fc2e31cb0451c0=
7a39f9c94226357d5faec09
> > > > > 100644
> > > > > --- a/net/sched/act_mirred.c
> > > > > +++ b/net/sched/act_mirred.c
> > > > > @@ -445,15 +445,17 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct=
 sk_buff *skb,
> > > > >                 return retval;
> > > > >         }
> > > > >         for (i =3D 0; i < xmit->sched_mirred_nest; i++) {
> > > > > -               if (xmit->sched_mirred_dev[i] !=3D dev)
> > > > > +               if (xmit->sched_mirred_dev[i] !=3D dev &&
> > > > > +                   xmit->sched_mirred_dev[i] !=3D skb->dev)
> > > > >                         continue;
> > > > > -               pr_notice_once("tc mirred: loop on device %s\n",
> > > > > -                              netdev_name(dev));
> > > > > +               pr_notice_once("tc mirred: loop on device %s/%s\n=
",
> > > > > +                              netdev_name(dev), netdev_name(skb-=
>dev));
> > > > >                 tcf_action_inc_overlimit_qstats(&m->common);
> > > > >                 return retval;
> > > > >         }
> > > > >
> > > > >         xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D dev=
;
> > > > > +       xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D skb=
->dev;
> > > > >
> > > > >         m_mac_header_xmit =3D READ_ONCE(m->tcfm_mac_header_xmit);
> > > > >         m_eaction =3D READ_ONCE(m->tcfm_eaction);
> > > >
> > > > Did you mean not to decrement sched_mirred_nest twice?
> > >
> > > No, sorry, we should decrement twice of course.
> > >
> >
> > Ok, I tested.
> > While it "fixes" it - it's not really a fix. It works by ignoring direc=
tion.
> > Example, this is not a loop but currently would be claimed to be a
> > loop because port0 appears twice:
> > port0 ingress --> port1 ingress --> port1 egress
> > Note: port0 ingress and port0 egress cannot create a loop.
>
> I am not familiar with this stuff, can the direction be known and
> taken into account ?
>

Yes, it can.
To figure the target direction see tcf_mirred_act_wants_ingress() and
to get what the current direction see code like:
at_ingress =3D skb_at_tc_ingress(skb);

> Really, anything but adding new bits in sk_buff.

If we can fix it without restoring those two bits i will be happy.
To repeat something i said earlier:
The bigger challenge is somewhere along the way (after removing those
two bits) we ended sending the egress->ingress to netif_rx() (see
tcf_mirred_forward()), so any flow with that kind of setup will
nullify your xmit count i.e when we come back for the next leg the
xmit counter will be 0.

cheers,
jamal

