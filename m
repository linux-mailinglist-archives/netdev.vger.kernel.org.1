Return-Path: <netdev+bounces-242325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FC5C8F398
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68E7C4EE635
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D7F3346A1;
	Thu, 27 Nov 2025 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTeRQBnA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47094257830
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256307; cv=none; b=tS4hVb5J+yDj9FXd+jSAhLEie1Efa3XvDJHnyFpL5l5tddFj51HuZlkwPqIGZroyZwOXj4aOlko5LwO/X/Pfb3JKnWIXx32RZnDSZuIUGsN6zb7OepPtkat8NXJ5mIzkP72upFUNGLyOBBk2T8VWPdCLpj/dwQTdwceNefnpy1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256307; c=relaxed/simple;
	bh=lL2txegud9ux4YyJuiMB3jslVmUHJ0T8vXbTtZewYus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Brbya0oVeyzZeMHx2bcQqo9vyOBNKLfYPbaMa2LbYCuRUSYMSLQv8nSD4/AvDZpHmjPS9HGOyYSSdPie6Uu0uGb0ZJDuDU9OqmW7TKTSPIA9u+GBVZf4CO3u7yA3DgMhc9dGUoik9r18fteRSBbLJPIMQFbFHkxjE0ZOdrTHa9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cTeRQBnA; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee158187aaso10406841cf.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 07:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764256305; x=1764861105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGMldPR2co4OK62sx7a7yX7veINWWn7QvUHPjJEI6uQ=;
        b=cTeRQBnA7GzmEWIVm6mw0wrSPg/VPxR7K4pEuUva5serJHB4fhjDfUX7sRRfBzNN2y
         iNvaWnysy0zjbYaPPZHLkIN5d5SzP3NH7B5SM6w6eaXq/yV3HOz3sMi07xFrTk//oIuA
         VMo15lsZ0OOMR/KluHj1hJQ78yyJUG8y88XUMBYPO1OETIfuxTlUH6sYyVfuFn3k+lKU
         Y33DdTo15jEEV7Hrn/XNE4OZigmzwk4rV/YzEih1MUSZ+uaBM/oBmzUrcM5lIDZe24ha
         /z5d5TkFQnPcBS5hyTIWGS4FpAFuOu0dpMfYzGS5jRTI1Bwtlud9jflx5jo0mmHfoLsa
         5tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764256305; x=1764861105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TGMldPR2co4OK62sx7a7yX7veINWWn7QvUHPjJEI6uQ=;
        b=mpiUgS8gvDCo9DoVdBojCZLi6agaW1iURqb4HI/NxKQQwcJkRAhTEv2YSSFmcn/44W
         V3V3JMWGik9qcdiHPAVdnqRWHYuNn1s/dNd6OHocqgwDy/woG+aU2KFQGxAz7gGfFPVl
         mwshEYdApL9F6ExWWzLqdaBt1o2IO2wIzPqPO81wzbM0NSnxOs39JgUomtStJeEFYZXK
         x+TFahG/XT/iH+VQHsO3n5IVf9NmeqaQqxiA6cbGKKvj47JJHax23TcvjQ7Jq99+hT/p
         taXG78F1NU+hN0u6/xZzpggFHoPuMzhxTRPlrmbAvlfbUW4fHnoZY0bT7ioR81z0RBua
         AybA==
X-Forwarded-Encrypted: i=1; AJvYcCUVDwOa0dX6icvqrhUIrvAh9s0xJIpV+6jdWI5xTuFahtUaqMJnZtO/X58ncWAo24E6q128vEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEXK+AbamlCyIvCTecgUTE0hqF63D0+uZwA7ZB1C6rYR8zYvcG
	LeDdjTYE2uJPWLJaJWyAf436FtzZjTCtQB/A05/95fQI45iSoM4sRg18OXPqJ/fJ6M4g+5BBRzT
	e/dMb/AT1pGkJWxe6sjyLsulksItuCHgPDageWETe
X-Gm-Gg: ASbGncvQ/dG30ZAwD6J+5MMHcg/3rK11NvEyo8LAvingIGGYRenUY4ra6H5eVJcqNLh
	Jr3d3qwnEmz8x1aYqgZCtHlksVbreQgVfS5kd1Vf5cvFFHJFtqbNwOGbY4IsAnB8wfe1kzdagxz
	CPkyWm60ALdhZHH/dhpzx3pQLeI7OYw3G4xuOmz8JJRdoWgBX9G/dT20WoYaet+fSFbvnaZN5RV
	1o1uNdEUEizAO4aFd2Tyh972JeTfR5Ng4BakOLqEZZ9wcFxkuErv48rbR2S6g//Cj5inNs=
X-Google-Smtp-Source: AGHT+IHX28DZubR5YC2LgjvbqnH6C6/8G22z+8hn9EJfTYpkAY5zNQ3nvT0+Q05E1oDuCXNVNv7uHKv0/ZRKpRlbt+c=
X-Received: by 2002:ac8:5f82:0:b0:4ed:b4e3:cfb0 with SMTP id
 d75a77b69052e-4ee58858da8mr336066921cf.29.1764256304705; Thu, 27 Nov 2025
 07:11:44 -0800 (PST)
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
 <CANn89i+zDW5ttPZ7fw2gDbVQqXj2uFoeEeTRSU6gzFLM3zGCeA@mail.gmail.com> <CAM0EoMmzt1tDpoqK=mMZoj1=6UU2Ytim2aqJWOBAZmPfNyZSfQ@mail.gmail.com>
In-Reply-To: <CAM0EoMmzt1tDpoqK=mMZoj1=6UU2Ytim2aqJWOBAZmPfNyZSfQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Nov 2025 07:11:33 -0800
X-Gm-Features: AWmQ_bn3iBruLy8dyS89veJy9eNtEQM0dfNGZOO3D9P_awgUaRlerorDBuFM8Hg
Message-ID: <CANn89iKKKwj33WgSbGKDa7JB=qRBXSH6VbiAV=umwOgwYsbmTQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	dcaratti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 6:45=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Nov 26, 2025 at 3:30=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Nov 26, 2025 at 12:20=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > On Wed, Nov 26, 2025 at 1:20=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Wed, Nov 26, 2025 at 10:14=E2=80=AFAM Jamal Hadi Salim <jhs@moja=
tatu.com> wrote:
> > > >
> > > > > It's the multiport redirection, particularly to ingress. When it =
get
> > > > > redirected to ingress it will get queued and then transitioned ba=
ck.
> > > > > xmit struct wont catch this as a recursion, so MIRRED_NEST_LIMIT =
will
> > > > > not help you.
> > > > > Example (see the first accompanying tdc test):
> > > > > packet showing up on port0:ingress mirred redirect --> port1:egre=
ss
> > > > > packet showing up on port1:egress mirred redirect --> port0:ingre=
ss
> > > >
> > > > Have you tried recording both devices ?
> > > >
> > > > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > > > index f27b583def78e4afecc7112854b93d59c2520201..711fc2e31cb0451c07a=
39f9c94226357d5faec09
> > > > 100644
> > > > --- a/net/sched/act_mirred.c
> > > > +++ b/net/sched/act_mirred.c
> > > > @@ -445,15 +445,17 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct s=
k_buff *skb,
> > > >                 return retval;
> > > >         }
> > > >         for (i =3D 0; i < xmit->sched_mirred_nest; i++) {
> > > > -               if (xmit->sched_mirred_dev[i] !=3D dev)
> > > > +               if (xmit->sched_mirred_dev[i] !=3D dev &&
> > > > +                   xmit->sched_mirred_dev[i] !=3D skb->dev)
> > > >                         continue;
> > > > -               pr_notice_once("tc mirred: loop on device %s\n",
> > > > -                              netdev_name(dev));
> > > > +               pr_notice_once("tc mirred: loop on device %s/%s\n",
> > > > +                              netdev_name(dev), netdev_name(skb->d=
ev));
> > > >                 tcf_action_inc_overlimit_qstats(&m->common);
> > > >                 return retval;
> > > >         }
> > > >
> > > >         xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D dev;
> > > > +       xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D skb->=
dev;
> > > >
> > > >         m_mac_header_xmit =3D READ_ONCE(m->tcfm_mac_header_xmit);
> > > >         m_eaction =3D READ_ONCE(m->tcfm_eaction);
> > >
> > > Did you mean not to decrement sched_mirred_nest twice?
> >
> > No, sorry, we should decrement twice of course.
> >
>
> Ok, I tested.
> While it "fixes" it - it's not really a fix. It works by ignoring directi=
on.
> Example, this is not a loop but currently would be claimed to be a
> loop because port0 appears twice:
> port0 ingress --> port1 ingress --> port1 egress
> Note: port0 ingress and port0 egress cannot create a loop.

I am not familiar with this stuff, can the direction be known and
taken into account ?

Really, anything but adding new bits in sk_buff.

