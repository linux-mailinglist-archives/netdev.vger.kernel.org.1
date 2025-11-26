Return-Path: <netdev+bounces-242051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6350C8BDC8
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 398E3353B3A
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F9F340A4A;
	Wed, 26 Nov 2025 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/N5RJ1D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB734105A
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764189014; cv=none; b=rgmlYHgWTjFPN+gWgSA1THqd+mnzfgoNsB3CiS+L7hZcQVHQ7TD5QFcSgD0huaQA4zRwAr8yv9eeHjzvLmtWHA6wDm2DfgqBTxEpfppZgRYAAp7m3S3EvQQlmC4qQlcIB7OHeT7r0EcWD4zUm8rb1lYcq6ArguhCT8sJ6ereK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764189014; c=relaxed/simple;
	bh=57VGx/K4c6Rtkg3J/M2zVPoVjOAxpyq5einPpgWZ20E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+b+eQFa8Wjs6LX71/d15wI/I27Yl8kxpou6aJ549UMTeA53fikAX5r1IBS8MlDcZGREw1NsBgz+TdvB9IeeWb7ZLLTXwWumJvALYEsiSHtOARkAfvpCh8Jy8wDUJK+S8nLLLSIdajbaHUSx7mTOmXiF7NWJPfBqWwIkZ6e6ILg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/N5RJ1D; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8a479c772cfso9441085a.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 12:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764189011; x=1764793811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGHzOZgL8hND3TNz9prrhXNNPy1wXoeq77dDQ0F/ZEQ=;
        b=j/N5RJ1DEmgbhGUDfpTYOqpVWA4uGjG2BFWQvJhpByF4UfD/vor6ZPq7CuBrmHsoke
         CbPuSjdUiobrR9YvLx2ZwXe7/BsdeW11nPN5zCWFawvYfk7k3tGOIqN+rpIP254muOMS
         M+tOeh5V2zCq3MEhHlVsPA+ZnO8z/ukl5o0yp2LWPW0UOtzUyLnsYM+0o0cJ/d2m+A0/
         O7yXdnEPHwvnvU6VKGFE+Rg98uZmyXfdbgQz3DIQu180MKtbcM2lJm9507Slz9Px74wE
         jyQMmAVt1NJVyEolFTi7A5r957qnvVD7WSyzt7auRjlmxMGrhOrg7GPRlxq08XHregti
         jDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764189011; x=1764793811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KGHzOZgL8hND3TNz9prrhXNNPy1wXoeq77dDQ0F/ZEQ=;
        b=bTxaqOAclISoddR/4E6/MQ7E72Rcae/SOTlhsC5zXtyIaF8bMoGOnwC/uqZ3zCTWSM
         FVcWrJNqeYfod9Wpc5tlho+bXksRvExlSIfzoNyBJfyjTyqsW1z0QAwZBHIDUTalNyY8
         OkDcXUme7Xv/22P63H2+D4+xZkzs/a3Fa+bODXwKuf45Ga0kZQ4Cjl9/ZkL4a1r5CrU1
         AzgkOb6qMMgM/sB8EioN1upQpiYcUL0xfRhHiKbLdu1JNex4QtH/filgh7vS902sdoBX
         rAA92dbm6AXVBPmSrYeL2GWTml+fyAvJAPIGUhxbvlyC3y3ldbNZL/aX74C8mR+bXyBk
         9OlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBfg2tBtSOy/B5UW7aveO1yzWY014emI7hRg4LadtAbOuQHeDLE/IqCJH1EIDR6Dhr/KGXP6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBqLvKKTVBBjXhFa0fbh7ag5XuHyB0IJ9ayzIVknM/5LANmIty
	Sc3qL9HPW+MVDIYWhRYc+pZEnw1CrrFNUOZiIbMc2wmDBsBh0ZUCkBOWN1yk4/3M1n07xM+p2dt
	GC9/6DtDI0f2jTeELYcj5tTopggUKcNqn9zJPR1ao
X-Gm-Gg: ASbGnct6c8Q3PI9n/3A/IHery9riYffoOheID6R9hvvfynJETAdgogtLioRWkINA1nu
	Ox14j6vv0sR+0gcqfTkZcWvZGCvZvwpyA9DqPdBLLfe7iS89Y2vu7VXHg4GVeUViyqkfrfySsPy
	1SLTDoodqi1KPziIEKsj5nio5Rhiz7OhWsA0H59+ucewSBg+j+w9vKW6snfQ0XFHc/2XbNkKeJf
	0/q2sAbP5+bytUZFJtvB9R6cDF7foBQdaF/o2/5/tazQY0kEAg+73AI59Xpmdxje9aRA4s=
X-Google-Smtp-Source: AGHT+IE2j9T9V/TLwIjb9jFsB2sJGgnTglcZUQAT0nUztyTPd0En4R2LwsO37goHkRwwoKZRjzTihAJdxJAaWKWTWEM=
X-Received: by 2002:a05:622a:180b:b0:4ed:6a9c:7234 with SMTP id
 d75a77b69052e-4efbdaf616emr101185191cf.82.1764189010251; Wed, 26 Nov 2025
 12:30:10 -0800 (PST)
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
 <CANn89i+_4Hj2WApgy_UBFhsDy+FEM8M1HhutrUcUHKmqbMR1-A@mail.gmail.com> <CAM0EoMmoMUtrBHyYUWNeBnFFj8kDFYPyQB+O1fdGB4xk_bMWZA@mail.gmail.com>
In-Reply-To: <CAM0EoMmoMUtrBHyYUWNeBnFFj8kDFYPyQB+O1fdGB4xk_bMWZA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Nov 2025 12:29:58 -0800
X-Gm-Features: AWmQ_blTmckWLh20_AHzdy8VNVwoWNAI9kMCjaJf9-pULThFYVG4Iy5pmOZaqCA
Message-ID: <CANn89i+zDW5ttPZ7fw2gDbVQqXj2uFoeEeTRSU6gzFLM3zGCeA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	dcaratti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 12:20=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Wed, Nov 26, 2025 at 1:20=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Nov 26, 2025 at 10:14=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> >
> > > It's the multiport redirection, particularly to ingress. When it get
> > > redirected to ingress it will get queued and then transitioned back.
> > > xmit struct wont catch this as a recursion, so MIRRED_NEST_LIMIT will
> > > not help you.
> > > Example (see the first accompanying tdc test):
> > > packet showing up on port0:ingress mirred redirect --> port1:egress
> > > packet showing up on port1:egress mirred redirect --> port0:ingress
> >
> > Have you tried recording both devices ?
> >
> > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > index f27b583def78e4afecc7112854b93d59c2520201..711fc2e31cb0451c07a39f9=
c94226357d5faec09
> > 100644
> > --- a/net/sched/act_mirred.c
> > +++ b/net/sched/act_mirred.c
> > @@ -445,15 +445,17 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_bu=
ff *skb,
> >                 return retval;
> >         }
> >         for (i =3D 0; i < xmit->sched_mirred_nest; i++) {
> > -               if (xmit->sched_mirred_dev[i] !=3D dev)
> > +               if (xmit->sched_mirred_dev[i] !=3D dev &&
> > +                   xmit->sched_mirred_dev[i] !=3D skb->dev)
> >                         continue;
> > -               pr_notice_once("tc mirred: loop on device %s\n",
> > -                              netdev_name(dev));
> > +               pr_notice_once("tc mirred: loop on device %s/%s\n",
> > +                              netdev_name(dev), netdev_name(skb->dev))=
;
> >                 tcf_action_inc_overlimit_qstats(&m->common);
> >                 return retval;
> >         }
> >
> >         xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D dev;
> > +       xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D skb->dev;
> >
> >         m_mac_header_xmit =3D READ_ONCE(m->tcfm_mac_header_xmit);
> >         m_eaction =3D READ_ONCE(m->tcfm_eaction);
>
> Did you mean not to decrement sched_mirred_nest twice?

No, sorry, we should decrement twice of course.

> I dont have time today but will continue early AM.
>
> cheers,
> jamal

