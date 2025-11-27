Return-Path: <netdev+bounces-242345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D02C8F7CB
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 17:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A13A4E1451
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6803D2D0625;
	Thu, 27 Nov 2025 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="JTqEc3VQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B332D0C61
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764260493; cv=none; b=XgVPL7ZHvIPxcGYRFhBjvFp/VRuIoLhqPhWy8VDukhtyT1irY5/CV9oAqHd+qKi30xvDlPlVHJXd7HtM3IdUAicaf2FQMAeQyhB//pA09LXipu5rTC0fczVoUn20dRxIqOBLr7LmZjJOHx5j3SQZlZAEppVa0/aHztERrIxbmg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764260493; c=relaxed/simple;
	bh=B8pcjIJ8NN3/saCvuK9B35M/C0wkEJ8biLVzize7KlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exNz1YQyf9DRjnw6gCA+nvH7jgrP3A6yTf2sJVsmluUCk/a+eYug+iPfprkadZrZow7FlkLery/7KTqP4/wyNK+kd+Mcm9jRt+cyh/3UBlUlYJztXYvuwIoKnsLgIN9kW7jALqnxMiK4RZTrGaZGSmKmwrEInHyBVO5FQCxjxwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=JTqEc3VQ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so658361a91.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 08:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764260491; x=1764865291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPoZO1+9MPTIuwcN9knVnczEjAH0ejc7Nq7IJrlykqU=;
        b=JTqEc3VQW9iDD5ujEarjSM2nAXmOgW/NoAGmkQyinE6lcqvnrYxOcCsGy8S/oOhLqo
         DYI57UrjMwwkmN/Rvl96EPPNBuQjdt4vPIyUydMQxd2e2WSrJYs7UkQoJ5017S0q0G3p
         n67kicqiVuQhpXxhgZLibDRkPmhelABGgLSuaytROao0g8xg+p2IFYKkDuswJ6x8u5CX
         soq88hh959SbW/5VgLvwRtpWJ+rGZOADBdZyzD7imjZuCaACPnJ8f3Lzq5oZnNf6Udn9
         CiLpKmopo+YHKjf6l4cXo0fxGRAFjZsndexe3gCOwv19b9yvAYsIAmevhAudw16J9jQ3
         03dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764260491; x=1764865291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BPoZO1+9MPTIuwcN9knVnczEjAH0ejc7Nq7IJrlykqU=;
        b=NlyGuHtf8u9Qex90t2avyABaeWq/IOWBruXKum2yoL7kpGp5h0ypMcsF6eALm+8Gtw
         ahAEQmM7DnTksWlYWhbkBBsVOe0w6S49sNhqNjB5o4UMGTg/MocCsN6V7UdkPwsGcqS8
         +7XoeQxFkGUPF9/KfIRvJWKhHaQ3skgnbR84nfTQACKG0l6UFrlq9Xn/on1Dh6qSy36P
         2WAQPl6NjdSxeIj+K7uDToTAW+BX9up/fcAzx0dbJfjBizEDhk6kzhlY7RdlM+jbUP8K
         fe1OYCoSRRhFzdbV0TvKsuysrOUzN9iLYTDNRCE/pjHuPn2Tn12+kGTRQfOvzW0m/a34
         8b8A==
X-Forwarded-Encrypted: i=1; AJvYcCUNni0mHOOuUHzKZCLC6CsmXObU8rBYH9ubBIiIc2V7WhcUJxxBoZnrWYDMCoeWkbGgh09k0JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVzSzaHY6drZVvELtnrop7Qrtbf1iALMXPLn6vabU78lf4+0Zz
	D70+pzRaBEj3plDQi8FxIqf8Rlan950vy9q1TIkcGopb1E6PovfBoB21PLBanRRXeFLYMC6WBdJ
	TYWXxPV79FAE4eWHMcaRTxwcoVbwzszq9LJnmKlqw
X-Gm-Gg: ASbGnct+ShYA+SWkPPGDeUbrxxZ7OuT6AK2EBv7gFdGoFd7pusNLvIG6fM8taIjQM25
	dccEEJ3HUOIIJeZNk1q/rgeDFgxefpBtd3jHZrrHpXBsqYpqW7fSWFUPq32veSup4LKTKx4BLDe
	J3d/HXk8XedHS8GVmi82oIquTnjNiH90bDpAEpTW7ujwrKzgRK5HKKzX9HpkPW8SzDIN3k8rI4x
	frB2QM5aGZZ4cYgIT3KN21pv/l9vCoxqrSDN2AWtgO6+yCtLmEGvMNpw/A1J528H6Lmvhzi6DFI
	nX0=
X-Google-Smtp-Source: AGHT+IHcLoEiorKJel+2Mttrko7xjxnpFIESVLUrsU4eIVn4brtaamQ5qRm5PoDOXDfeb2hKxYWIf60pI0w2ygBbQ7c=
X-Received: by 2002:a17:90b:3b41:b0:33f:f22c:8602 with SMTP id
 98e67ed59e1d1-3475ed6ac44mr11321859a91.26.1764260490726; Thu, 27 Nov 2025
 08:21:30 -0800 (PST)
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
 <CANn89iKKKwj33WgSbGKDa7JB=qRBXSH6VbiAV=umwOgwYsbmTQ@mail.gmail.com> <CAM0EoMngngPdwCqFrbEQAFgu+cMe0eVfBs1XKD4zTUCTpYYHOw@mail.gmail.com>
In-Reply-To: <CAM0EoMngngPdwCqFrbEQAFgu+cMe0eVfBs1XKD4zTUCTpYYHOw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 27 Nov 2025 11:21:19 -0500
X-Gm-Features: AWmQ_bnVEydWwRRi2hBf_xB6AWAD7WNTCmBvD2ryWVHL4jLKnjyVuVngpPXmoLk
Message-ID: <CAM0EoMn4rW3VOmEaxz2VBxGeywoQ_TBDSz7qKsS6AHjo0HNJWA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	dcaratti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 10:23=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Thu, Nov 27, 2025 at 10:11=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Thu, Nov 27, 2025 at 6:45=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Wed, Nov 26, 2025 at 3:30=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Wed, Nov 26, 2025 at 12:20=E2=80=AFPM Jamal Hadi Salim <jhs@moja=
tatu.com> wrote:
> > > > >
> > > > > On Wed, Nov 26, 2025 at 1:20=E2=80=AFPM Eric Dumazet <edumazet@go=
ogle.com> wrote:
> > > > > >
> > > > > > On Wed, Nov 26, 2025 at 10:14=E2=80=AFAM Jamal Hadi Salim <jhs@=
mojatatu.com> wrote:
> > > > > >
> > > > > > > It's the multiport redirection, particularly to ingress. When=
 it get
> > > > > > > redirected to ingress it will get queued and then transitione=
d back.
> > > > > > > xmit struct wont catch this as a recursion, so MIRRED_NEST_LI=
MIT will
> > > > > > > not help you.
> > > > > > > Example (see the first accompanying tdc test):
> > > > > > > packet showing up on port0:ingress mirred redirect --> port1:=
egress
> > > > > > > packet showing up on port1:egress mirred redirect --> port0:i=
ngress
> > > > > >
> > > > > > Have you tried recording both devices ?
> > > > > >
> > > > > > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > > > > > index f27b583def78e4afecc7112854b93d59c2520201..711fc2e31cb0451=
c07a39f9c94226357d5faec09
> > > > > > 100644
> > > > > > --- a/net/sched/act_mirred.c
> > > > > > +++ b/net/sched/act_mirred.c
> > > > > > @@ -445,15 +445,17 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(stru=
ct sk_buff *skb,
> > > > > >                 return retval;
> > > > > >         }
> > > > > >         for (i =3D 0; i < xmit->sched_mirred_nest; i++) {
> > > > > > -               if (xmit->sched_mirred_dev[i] !=3D dev)
> > > > > > +               if (xmit->sched_mirred_dev[i] !=3D dev &&
> > > > > > +                   xmit->sched_mirred_dev[i] !=3D skb->dev)
> > > > > >                         continue;
> > > > > > -               pr_notice_once("tc mirred: loop on device %s\n"=
,
> > > > > > -                              netdev_name(dev));
> > > > > > +               pr_notice_once("tc mirred: loop on device %s/%s=
\n",
> > > > > > +                              netdev_name(dev), netdev_name(sk=
b->dev));
> > > > > >                 tcf_action_inc_overlimit_qstats(&m->common);
> > > > > >                 return retval;
> > > > > >         }
> > > > > >
> > > > > >         xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D d=
ev;
> > > > > > +       xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D s=
kb->dev;
> > > > > >
> > > > > >         m_mac_header_xmit =3D READ_ONCE(m->tcfm_mac_header_xmit=
);
> > > > > >         m_eaction =3D READ_ONCE(m->tcfm_eaction);
> > > > >
> > > > > Did you mean not to decrement sched_mirred_nest twice?
> > > >
> > > > No, sorry, we should decrement twice of course.
> > > >
> > >
> > > Ok, I tested.
> > > While it "fixes" it - it's not really a fix. It works by ignoring dir=
ection.
> > > Example, this is not a loop but currently would be claimed to be a
> > > loop because port0 appears twice:
> > > port0 ingress --> port1 ingress --> port1 egress
> > > Note: port0 ingress and port0 egress cannot create a loop.
> >
> > I am not familiar with this stuff, can the direction be known and
> > taken into account ?
> >
>
> Yes, it can.
> To figure the target direction see tcf_mirred_act_wants_ingress() and
> to get what the current direction see code like:
> at_ingress =3D skb_at_tc_ingress(skb);
>
> > Really, anything but adding new bits in sk_buff.
>
> If we can fix it without restoring those two bits i will be happy.
> To repeat something i said earlier:
> The bigger challenge is somewhere along the way (after removing those
> two bits) we ended sending the egress->ingress to netif_rx() (see
> tcf_mirred_forward()), so any flow with that kind of setup will
> nullify your xmit count i.e when we come back for the next leg the
> xmit counter will be 0.
>

BTW, I have the attached patch but was waiting to see how this
discussion is heading.
It's when you have something like port0 egress --> port0 egress and
you use something like drr as root qdisc.

-- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -281,6 +281,14 @@ static int tcf_mirred_to_dev(struct sk_buff *skb,
struct tcf_mirred *m,

        want_ingress =3D tcf_mirred_act_wants_ingress(m_eaction);

+       if (dev =3D=3D skb->dev && want_ingress =3D=3D at_ingress) {
+               pr_notice_once("tc mirred: Loop (%s:%s --> %s:%s)\n",
+                              netdev_name(skb->dev),
+                              at_ingress?"ingress":"egress",
+                              netdev_name(dev),
+                              want_ingress?"ingress":"egress");
+               goto err_cant_do;
+       }
        /* All mirred/redirected skbs should clear previous ct info */
        nf_reset_ct(skb_to_send);
        if (want_ingress && !at_ingress) /* drop dst for egress -> ingress =
*/

cheers,
jamal

