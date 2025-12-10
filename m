Return-Path: <netdev+bounces-244260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C0CB33BB
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 15:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3120D300748F
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F506259CBF;
	Wed, 10 Dec 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="F7jcJS8v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF1248F69
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765378784; cv=none; b=ZjAmSApLFF1z0KVYwL+jUq4J23ZUAbh+ovj18FbrmJtViWCaXpaknfUELAyv9vwgzbif/BlpNtWI5BDEncWAfC3Bwo9cNJoQ1MWPyjBeyDt7aD9gPofiyjVK7NDnbSRmXLzgbDh6lY6GASHHtzOGG+IOUlLCyTmm+PxE6Un411w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765378784; c=relaxed/simple;
	bh=BX9GCeksrm871dWwF5T+K6bNl/z1hw13Z+q1a2aBIug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhGAP6cGs5SnFOzULNn7dMCif1lowYmVpcbTbJx1laoptnJxsUhb0OEVhVrDwV8auxLFhRwNJtEaJhjAXts7XAjO/gHmm4f5Q8AQcSG1O5BdqxNpN7wMF8qrIfxsgaAEiSJvRWxmXaajAI4aE5fR6Bnsr36erKdyX0Qy4bR2F+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=F7jcJS8v; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7e2762ad850so7244286b3a.3
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 06:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1765378781; x=1765983581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tthgIGp9nW3QqcCewKRsGoMrm0jaWkDqz+wuPCkHL9I=;
        b=F7jcJS8v7C60NbHsfSIgod0aoMUq2grgSx/NtciYaXRvc3XYZEt4WIWaErYSfDWKoP
         AUOpSsKg6MuHVfwmYDfJ4SYd7vSoz6YuNI9KUUJl75zjQo1CDqocFJiQ+7EW8GgkwQC0
         stBSzgjgvcbw0Ff6qZnlSAR6fzf1DThPXSndaUYDt+3aVnuUuceS19gFu4qnQFhrzhMC
         amExXdc9iUfIp25YuDKC29+WB7cF5Aq9Z9y75GNqExzk1QJJwOhMJkujs9rPvh+DtxoZ
         LCswl55Oba4haYhYMRMJP16tGH5Oj0Q81QT82WREoU0Hqie4WyiEjwZOJy5JoOyFGw2d
         /KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765378781; x=1765983581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tthgIGp9nW3QqcCewKRsGoMrm0jaWkDqz+wuPCkHL9I=;
        b=mz2kwETuQGO9J2OEGGI2LeJ/867vFGLW3T7cJ8YvpMD6+skIo/tVbN8TKc2zHSmtKy
         Ac3u30q0XS8IGeqrlpC1noVO7G5fVmd9nMxTbuJa6XtGwXHlD2Ff8rWeM5kggSoSqn5b
         Cj5uuWbpKWgZFtLUet+vbJlmKomkNAhi+GBh5AMebv5e39oU059Q5YIUwZGNMlqZxeqd
         5ZOKXtsScpnDH+TZawy7Uen67NYU8E9mh99Pm2upnjH5QIx25Zpp1PaFmauOKZfmS2j3
         RazDNC4t8O+bQJFDq3mmU5xTO6LemVLzrfNc8WiH/LLbtWUZUTO3/jXgYONvP67j6t6t
         ky6A==
X-Forwarded-Encrypted: i=1; AJvYcCVKztVN0SPQmcnMSRzMtD3Mzxl6PNwCg8lKX59MFwlSnIN9pzLCQhQJMErvFBT4WXVgn5QlMLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPST2rXk3KpgC48m7Cat+Mf8kqbuGhgJB7MDLEpK6xJwsFrT/f
	SjpDbziriNwLk8GMxnnCLIRNm5iWu9bw1RaipEJJrt4x2SM0jK0uc+38XZb2ZYHpmey5124huQt
	3IDye4gYDrmRDBTqCknpozO0KIERwDxbJMR2p65VIExiyJup74tQ=
X-Gm-Gg: ASbGncvRWoDbIbXyoX3IKP08lolIq9UlB9H+4XS++meWe+CowX62YWZTQvcDnlP/FXV
	jT4N4HMrKfhfvJ3G3XvjxPcDjyui0TBySJoUw0g/6COrPaCWzJP6BXMJUBeNESKKdkTMlAEYdlH
	pqMWcz6pt0fa0o2ApoeRhscf/2zKfAqSfRdD6JKw+TQo34QT5zxmdw0pPdnqDwDt6hzzI0C5GNE
	/di6npcYQUfCmLXVPe0rJVM5FzppZIYkTPQr5L2+T5BfSGpbEHFp4X8BxR6bs3NjE+QLheXoRCv
	BE8=
X-Google-Smtp-Source: AGHT+IETpuuZlhHeHQtcbCcEcbIQ9g0JazU3ez7ddZz674YeaD1RnC8G/WhgSsEX3PiYTVt8h5UnbsTzDvVI1J5gM4s=
X-Received: by 2002:a05:6a00:b86:b0:7e8:4433:8fb8 with SMTP id
 d2e1a72fcca58-7f2302ba42fmr3009529b3a.64.1765378781399; Wed, 10 Dec 2025
 06:59:41 -0800 (PST)
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
 <CAM0EoMngngPdwCqFrbEQAFgu+cMe0eVfBs1XKD4zTUCTpYYHOw@mail.gmail.com>
 <CAM0EoMn4rW3VOmEaxz2VBxGeywoQ_TBDSz7qKsS6AHjo0HNJWA@mail.gmail.com> <CAM0EoMmiTRqKaXK7Y7LQpm6yfkz6Q-pGn9e_bMo-t8++pqHZSQ@mail.gmail.com>
In-Reply-To: <CAM0EoMmiTRqKaXK7Y7LQpm6yfkz6Q-pGn9e_bMo-t8++pqHZSQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 10 Dec 2025 09:59:28 -0500
X-Gm-Features: AQt7F2rCtXPo2WBfqBkgafyBVV4worEbhZd604dU-UyypGnypMxUxt_c_ypzUZU
Message-ID: <CAM0EoMnPVnPvffYFLygRQw7Oi-WpaxuKWqxx+GYE0O=kFK=4wQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	dcaratti@redhat.com, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 9:27=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Thu, Nov 27, 2025 at 11:21=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > On Thu, Nov 27, 2025 at 10:23=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > On Thu, Nov 27, 2025 at 10:11=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > On Thu, Nov 27, 2025 at 6:45=E2=80=AFAM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> > > > >
> > > > > On Wed, Nov 26, 2025 at 3:30=E2=80=AFPM Eric Dumazet <edumazet@go=
ogle.com> wrote:
> > > > > >
> > > > > > On Wed, Nov 26, 2025 at 12:20=E2=80=AFPM Jamal Hadi Salim <jhs@=
mojatatu.com> wrote:
> > > > > > >
> > > > > > > On Wed, Nov 26, 2025 at 1:20=E2=80=AFPM Eric Dumazet <edumaze=
t@google.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Nov 26, 2025 at 10:14=E2=80=AFAM Jamal Hadi Salim <=
jhs@mojatatu.com> wrote:
> > > > > > > >
> > > > > > > > > It's the multiport redirection, particularly to ingress. =
When it get
> > > > > > > > > redirected to ingress it will get queued and then transit=
ioned back.
> > > > > > > > > xmit struct wont catch this as a recursion, so MIRRED_NES=
T_LIMIT will
> > > > > > > > > not help you.
> > > > > > > > > Example (see the first accompanying tdc test):
> > > > > > > > > packet showing up on port0:ingress mirred redirect --> po=
rt1:egress
> > > > > > > > > packet showing up on port1:egress mirred redirect --> por=
t0:ingress
> > > > > > > >
> > > > > > > > Have you tried recording both devices ?
> > > > > > > >
> > > > > > > > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.=
c
> > > > > > > > index f27b583def78e4afecc7112854b93d59c2520201..711fc2e31cb=
0451c07a39f9c94226357d5faec09
> > > > > > > > 100644
> > > > > > > > --- a/net/sched/act_mirred.c
> > > > > > > > +++ b/net/sched/act_mirred.c
> > > > > > > > @@ -445,15 +445,17 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(=
struct sk_buff *skb,
> > > > > > > >                 return retval;
> > > > > > > >         }
> > > > > > > >         for (i =3D 0; i < xmit->sched_mirred_nest; i++) {
> > > > > > > > -               if (xmit->sched_mirred_dev[i] !=3D dev)
> > > > > > > > +               if (xmit->sched_mirred_dev[i] !=3D dev &&
> > > > > > > > +                   xmit->sched_mirred_dev[i] !=3D skb->dev=
)
> > > > > > > >                         continue;
> > > > > > > > -               pr_notice_once("tc mirred: loop on device %=
s\n",
> > > > > > > > -                              netdev_name(dev));
> > > > > > > > +               pr_notice_once("tc mirred: loop on device %=
s/%s\n",
> > > > > > > > +                              netdev_name(dev), netdev_nam=
e(skb->dev));
> > > > > > > >                 tcf_action_inc_overlimit_qstats(&m->common)=
;
> > > > > > > >                 return retval;
> > > > > > > >         }
> > > > > > > >
> > > > > > > >         xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =
=3D dev;
> > > > > > > > +       xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =
=3D skb->dev;
> > > > > > > >
> > > > > > > >         m_mac_header_xmit =3D READ_ONCE(m->tcfm_mac_header_=
xmit);
> > > > > > > >         m_eaction =3D READ_ONCE(m->tcfm_eaction);
> > > > > > >
> > > > > > > Did you mean not to decrement sched_mirred_nest twice?
> > > > > >
> > > > > > No, sorry, we should decrement twice of course.
> > > > > >
> > > > >
> > > > > Ok, I tested.
> > > > > While it "fixes" it - it's not really a fix. It works by ignoring=
 direction.
> > > > > Example, this is not a loop but currently would be claimed to be =
a
> > > > > loop because port0 appears twice:
> > > > > port0 ingress --> port1 ingress --> port1 egress
> > > > > Note: port0 ingress and port0 egress cannot create a loop.
> > > >
> > > > I am not familiar with this stuff, can the direction be known and
> > > > taken into account ?
> > > >
> > >
> > > Yes, it can.
> > > To figure the target direction see tcf_mirred_act_wants_ingress() and
> > > to get what the current direction see code like:
> > > at_ingress =3D skb_at_tc_ingress(skb);
> > >
> > > > Really, anything but adding new bits in sk_buff.
> > >
> > > If we can fix it without restoring those two bits i will be happy.
> > > To repeat something i said earlier:
> > > The bigger challenge is somewhere along the way (after removing those
> > > two bits) we ended sending the egress->ingress to netif_rx() (see
> > > tcf_mirred_forward()), so any flow with that kind of setup will
> > > nullify your xmit count i.e when we come back for the next leg the
> > > xmit counter will be 0.
> > >
> >
> > BTW, I have the attached patch but was waiting to see how this
> > discussion is heading.
> > It's when you have something like port0 egress --> port0 egress and
> > you use something like drr as root qdisc.
> >
> > -- a/net/sched/act_mirred.c
> > +++ b/net/sched/act_mirred.c
> > @@ -281,6 +281,14 @@ static int tcf_mirred_to_dev(struct sk_buff *skb,
> > struct tcf_mirred *m,
> >
> >         want_ingress =3D tcf_mirred_act_wants_ingress(m_eaction);
> >
> > +       if (dev =3D=3D skb->dev && want_ingress =3D=3D at_ingress) {
> > +               pr_notice_once("tc mirred: Loop (%s:%s --> %s:%s)\n",
> > +                              netdev_name(skb->dev),
> > +                              at_ingress?"ingress":"egress",
> > +                              netdev_name(dev),
> > +                              want_ingress?"ingress":"egress");
> > +               goto err_cant_do;
> > +       }
> >         /* All mirred/redirected skbs should clear previous ct info */
> >         nf_reset_ct(skb_to_send);
> >         if (want_ingress && !at_ingress) /* drop dst for egress -> ingr=
ess */
> >
>
> Eric,
> Are you still looking at this?
>

i will send a bunch of RFC patches. Maybe one is a clear "easy fix",
so i will send that one out against net. Just a bit of testing needed.

cheers,
jamal
> cheers,
> jamal

