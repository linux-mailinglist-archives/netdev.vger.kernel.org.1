Return-Path: <netdev+bounces-242316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CACBC8ED11
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC2F234D58E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E35C221554;
	Thu, 27 Nov 2025 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="WJNVDJBy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E11260585
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254721; cv=none; b=MQs42o+zC3+8xiTzELjy+44PtYRPR1JKXjNQyIH/WqMgQQFcVEB0FgPb4UAmlYV1t6qXr2q9KetX1lygc5wy9PM9I8qkbOEfryloPFUYhY4Jn1okRvsqmJgeG90/XVyE3tToQZ0Emlbcdxcv3WUpxp/pWM69Sx1U/E4b3LjXgmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254721; c=relaxed/simple;
	bh=nDb6+t7lPP5+FIkHzYNMTBTTfUliovvIhiEFyFW2eKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohXm5fTa4qKx2p8+Pth6CqJ9Dv5wKELTG1raXyDh0xOEGCJQ+c1YhukC/RfpcYxJ9WF7yIcqrWD36WXl63KFBG0toKtp/1aLHpOOikFBB78nJ2WEFUFbyTovwaAfIDRTySTpgpZNS1kxDULI+THEIDKLip8QuaYb9Tgj8DQ3Uv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=WJNVDJBy; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-343806688c5so709027a91.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 06:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764254718; x=1764859518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM0/33JYJs/eW0kO95rmop8gvc93VyjEg4y63JI+Ybo=;
        b=WJNVDJByxysGoZiLWPwMGC220uj9uxPCd3CO32sGfJ0eSozKD4eeRpN5EZONRKpjiK
         H6F56etM1KBvZ4uNseQ9rpyW9CMdnE1oEU/3WTQbaPQNyZfsz6oc3dbmzOpO/iGRJq7R
         3/k35kZEqrFZ8iGDp5ehc/m+Qv1h5mQRi8WyTLF99DlbPmimdF07xxjNJpJoVhcLiA9G
         o/uLKcMRueQ0yD04CopzBPiDp96OMTGUazDw+9kZ6KOEA27upfZX0NuY8MM84RVPc7uq
         sWBJpB6/EEvpCUNjtf7CO531m0Qxlgy9naeZScdtARuc+kZ+gGFcdfvd52sqKROQsdvQ
         ZodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764254718; x=1764859518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vM0/33JYJs/eW0kO95rmop8gvc93VyjEg4y63JI+Ybo=;
        b=mLmn9bVjLHrg1Uf88lqwqFUmhxN+5liycOdJ+pHwY7jh7HyvcKbWjAPu5SxTeemMgi
         OdPUtOT9AzliRNPfatrSXs4nca4Xr1J+jN2JpxFI0fdCK8iTNXjU3+1G75i6bX6JPSr1
         BrCWQdGVcG9kN4gd8qdEN6NTyl6mVtOtgMc4tnjLqFfu0Zh/QyH1k29wmAddymqd6bsv
         ZNGGs7Uve0GZnWQe0ZiC+MrpK5DnLo9gary2rLanzZEmOcK1qQnIMbhzBZiaP25s488C
         tglqS+w6OEfCOqlcr/yTwbPzUG2/i/RpLZ5m5LCrP4d53HUoL8cTTVvPSXXCCUINGqsw
         1a2A==
X-Forwarded-Encrypted: i=1; AJvYcCW9pDNdwAuhLs1M8UWMZ2oOhbtw3AToVb4PixHz0p6mR2lMvdi/0np5M1d7BXnME2T/uDidmVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKEZIXzvGE9zH/BLV773sR33FxSJddLnEGDlCAcdR47aiNldS
	ZgxKAbJl+OESueY8lKB85yuxbDJbRoTsWfEAnep8gimqWDE9MPD8YkZp0/zf2IEXSEwemXyBJ9s
	T2VORxdT7TdMIPmAnPxFeTuMqnixFXs1ItrJKkfhd
X-Gm-Gg: ASbGncvFkjJg1h76az3wFj0IVg/UWj2BFBLizhk9RSsQbJMdcW7TGVXHFwtNX+9+sWw
	IAnefNJoA95x/0ZhKGhXP/dkBRs04+HnRwxnVVDFxWH1vvEMdf8AKEDfDLbgS/AQ0IbEMb7PgGS
	J3AT/txRTCIP7dk1eDDFCW+3SW114ZY1cegzLjFeNGRUy9q5YO6NYlI1nMAyKOrWhQh0gbdaTLn
	YDA+OKV/B3Rtu77teCKbw6roRDTun9RAKLnM9Z+WC4gGQ2L9Iu6VCN2NFvhd/5iOOlvGu9HL3A2
	hBE=
X-Google-Smtp-Source: AGHT+IGYyfI/Nll7F4wlvy7892Ip3dZMpyPj23+ooycmV3QUMQXFH9ubBCsCToAA6fYp/XAgaJoZODZOkohSU9ESqL8=
X-Received: by 2002:a17:90b:4e83:b0:343:684c:f8ad with SMTP id
 98e67ed59e1d1-3475ebe73camr9947669a91.4.1764254718448; Thu, 27 Nov 2025
 06:45:18 -0800 (PST)
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
 <CAM0EoMmoMUtrBHyYUWNeBnFFj8kDFYPyQB+O1fdGB4xk_bMWZA@mail.gmail.com> <CANn89i+zDW5ttPZ7fw2gDbVQqXj2uFoeEeTRSU6gzFLM3zGCeA@mail.gmail.com>
In-Reply-To: <CANn89i+zDW5ttPZ7fw2gDbVQqXj2uFoeEeTRSU6gzFLM3zGCeA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 27 Nov 2025 09:45:06 -0500
X-Gm-Features: AWmQ_bmI004BADyPj7HzU8kk5p-V8onFRfgbx-kAGiVuJyWCDpwqB6OVkxLQA6s
Message-ID: <CAM0EoMmzt1tDpoqK=mMZoj1=6UU2Ytim2aqJWOBAZmPfNyZSfQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	dcaratti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 3:30=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Nov 26, 2025 at 12:20=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > On Wed, Nov 26, 2025 at 1:20=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Nov 26, 2025 at 10:14=E2=80=AFAM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> > >
> > > > It's the multiport redirection, particularly to ingress. When it ge=
t
> > > > redirected to ingress it will get queued and then transitioned back=
.
> > > > xmit struct wont catch this as a recursion, so MIRRED_NEST_LIMIT wi=
ll
> > > > not help you.
> > > > Example (see the first accompanying tdc test):
> > > > packet showing up on port0:ingress mirred redirect --> port1:egress
> > > > packet showing up on port1:egress mirred redirect --> port0:ingress
> > >
> > > Have you tried recording both devices ?
> > >
> > > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > > index f27b583def78e4afecc7112854b93d59c2520201..711fc2e31cb0451c07a39=
f9c94226357d5faec09
> > > 100644
> > > --- a/net/sched/act_mirred.c
> > > +++ b/net/sched/act_mirred.c
> > > @@ -445,15 +445,17 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_=
buff *skb,
> > >                 return retval;
> > >         }
> > >         for (i =3D 0; i < xmit->sched_mirred_nest; i++) {
> > > -               if (xmit->sched_mirred_dev[i] !=3D dev)
> > > +               if (xmit->sched_mirred_dev[i] !=3D dev &&
> > > +                   xmit->sched_mirred_dev[i] !=3D skb->dev)
> > >                         continue;
> > > -               pr_notice_once("tc mirred: loop on device %s\n",
> > > -                              netdev_name(dev));
> > > +               pr_notice_once("tc mirred: loop on device %s/%s\n",
> > > +                              netdev_name(dev), netdev_name(skb->dev=
));
> > >                 tcf_action_inc_overlimit_qstats(&m->common);
> > >                 return retval;
> > >         }
> > >
> > >         xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D dev;
> > > +       xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D skb->de=
v;
> > >
> > >         m_mac_header_xmit =3D READ_ONCE(m->tcfm_mac_header_xmit);
> > >         m_eaction =3D READ_ONCE(m->tcfm_eaction);
> >
> > Did you mean not to decrement sched_mirred_nest twice?
>
> No, sorry, we should decrement twice of course.
>

Ok, I tested.
While it "fixes" it - it's not really a fix. It works by ignoring direction=
.
Example, this is not a loop but currently would be claimed to be a
loop because port0 appears twice:
port0 ingress --> port1 ingress --> port1 egress
Note: port0 ingress and port0 egress cannot create a loop.

cheers,
jamal

