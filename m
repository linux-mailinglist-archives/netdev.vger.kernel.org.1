Return-Path: <netdev+bounces-80489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFFD87F2EB
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 23:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD35280EA7
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 22:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5070C59B68;
	Mon, 18 Mar 2024 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="aT9Xj+u4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E0659B60
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799541; cv=none; b=MEQl8+VMK3zpLOKNuJqm//iuOI6uXResgYQWBl3/tUQBl04GtJy7b8E2Rob4Ik5cfYQbFfhLZQ59eBLSMOgr6po8WtQv0k801lj3QOnQXy9fweCOXp60IGeS8p1RduxXzyFi6rHfKAFfUB0KNBpnvg6sn0G8xaUGCSit14gjwLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799541; c=relaxed/simple;
	bh=ImxnwmPVH4hKEKAyrKCxvMl+7+5fJEuF8Z51+rw4I04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHZHIz8TdLTcDeJh0elJ0YcDtJm0ZuKHjsjMmC45PmlA3RdlBRGr/EwshzYIah9Qa4hL4XVG5UCkaPVDuwvmA+oOrg4M5gQIdrO5jfpC0V5l3gCuzf5wjrMSLyhrQvh5vRuukIGTSjjVkEleLHYn/k1IlcZg8WXG5IOGHrUCiDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=aT9Xj+u4; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso4601932276.3
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 15:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1710799538; x=1711404338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JgsfA8A/SfQBB0wg/L10qRsSBa4VkEUGFliTXRJJ0M=;
        b=aT9Xj+u4OHObd+A/cz7MfBmSCeBlfhuGtjoRUIU4+i+JkNkQf24qpa+KopCI3QysnY
         6tgtg35pF9yv+hVHir8DfATQVSNgVxJvgSRZc9rLTOPKPKmcOqtYcmgIPbUK0lOqn3y8
         bBpgEo4fYBVecRD1wupu7prOIMoiyhZ5EMzWU/xEQ7OyHIvZXlJoB95sOT2JjuqWx177
         BvR6xhQj6n52zNPEIykALSBPQ4YQjrM68IL3CVTtsQFBGRhF8PsK9wgKpdU0Er1w5dUA
         Rdb5Dkt2z7SIltb80Y+Z2cA9rgePiduoDQOKRBLIrQ/xgf+5qRZbcKLRVdVZMlMuFhH7
         CODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710799538; x=1711404338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JgsfA8A/SfQBB0wg/L10qRsSBa4VkEUGFliTXRJJ0M=;
        b=u6k2PT/x4PCFws3bTjJtWiDnpeCq4P1jpbCBpzGqj7LiGx7CsBON5WBrz0BLDyHsLp
         VludHQLTQl0kNxaQO/vTje23AJwb+40H23uvH4hPaknBaTGfBGnnffaJxP5oUpejhSVE
         k89GEZFt45PnGoktMzK43tyjAMvGlsWTB4PU9KmfDLYXumL52c1JHcqoA8GiEwwfN16B
         79/6niyqZGKRdM3PimZnuBs/fByxffkTkf9cw/lextDjmMJ6dmS+9svgWWyZgfRbU/lX
         YEqQsq+eJjx2gM/0dALXNwyuMgzCw6eP2y5oXAOK1t2AOKm5lX3JkRegCIbmVCtc/8iG
         G1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWtzpersMXcEp8YHmvLzmS1fNOTYQLkVsqC16V3c+uS09y3iUqzS74q30NO5n8ABQchlBVZW09jUzYZWtrT6jsjkt+9vQZa
X-Gm-Message-State: AOJu0YznSdcEM1BODScvtQocQ8E/5bNeWAlDBEwmkMMlTiat6rVYC+lM
	vq/l75U++6HkxBVuEj04iHjbPeaS08FYnIYoEXwCoK1m+PuTLMie8tz1FviWK0shT8OQmLEFrNT
	73ZaShFPURX2qSmzW5XXUtG9sv+RW5H0bMDkU
X-Google-Smtp-Source: AGHT+IGhRx0PyAP7lfxuEZj7NDj8u3iE4675Ym7tx+6drValTpleq+0Db08rtMQ2HwdjtAlmOeMzmmpLZjTVVaOWdxc=
X-Received: by 2002:a05:6902:2202:b0:dcd:990a:c02a with SMTP id
 dm2-20020a056902220200b00dcd990ac02amr333070ybb.63.1710799537930; Mon, 18 Mar
 2024 15:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314111713.5979-1-renmingshuai@huawei.com>
 <CAM0EoMmqVHGC4_YVHj=rUPj+XBS_N99rCKk1S7wCi1wJ8__Pyw@mail.gmail.com>
 <CAM0EoMkZKvvPVaCGFVTE_P1YCyS-r2b3gq3QRhDuEF=Cm-sY4g@mail.gmail.com>
 <CAM0EoMm+W3X7TG8qjb8LWsBbAQ8_rntr7kwhSTy7Sxk=Yj=R2g@mail.gmail.com>
 <CANn89iL_hfoWTqr+KaKZoO8fKoZdd-xcY040NeSb-WL7pHMLGQ@mail.gmail.com>
 <CAM0EoMkqhmDtpg09ktnkxjAtddvXzwQo4Qh2-LX2r8iqrECogw@mail.gmail.com> <CANn89iK2e4csrApZjY+kpR9TwaFpN9rcbRSPtyQnw5P_qkyYfA@mail.gmail.com>
In-Reply-To: <CANn89iK2e4csrApZjY+kpR9TwaFpN9rcbRSPtyQnw5P_qkyYfA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 18 Mar 2024 18:05:26 -0400
Message-ID: <CAM0EoMkDexWQ_Rj_=gKMhWzSgQqtbAdyDv8DXgY+nk_2Rp3drg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter
 attached to the egress
To: Eric Dumazet <edumazet@google.com>
Cc: renmingshuai <renmingshuai@huawei.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, vladbu@nvidia.com, netdev@vger.kernel.org, 
	yanan@huawei.com, liaichun@huawei.com, caowangbao@huawei.com, 
	Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 3:11=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Mar 18, 2024 at 6:36=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Mon, Mar 18, 2024 at 11:46=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Mon, Mar 18, 2024 at 3:27=E2=80=AFPM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Sun, Mar 17, 2024 at 12:10=E2=80=AFPM Jamal Hadi Salim <jhs@moja=
tatu.com> wrote:
> > > > >
> > > > > On Thu, Mar 14, 2024 at 1:14=E2=80=AFPM Jamal Hadi Salim <jhs@moj=
atatu.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 14, 2024 at 7:18=E2=80=AFAM renmingshuai <renmingsh=
uai@huawei.com> wrote:
> > > > > > >
> > > > > > > As we all know the mirred action is used to mirroring or redi=
recting the
> > > > > > > packet it receives. Howerver, add mirred action to a filter a=
ttached to
> > > > > > > a egress qdisc might cause a deadlock. To reproduce the probl=
em, perform
> > > > > > > the following steps:
> > > > > > > (1)tc qdisc add dev eth0 root handle 1: htb default 30 \n
> > > > > > > (2)tc filter add dev eth2 protocol ip prio 2 flower verbose \
> > > > > > >      action police rate 100mbit burst 12m conform-exceed jump=
 1 \
> > > > > > >      / pipe mirred egress redirect dev eth2 action drop
> > > > > > >
> > > > > >
> > > > > > I think you meant both to be the same device eth0 or eth2?
> > > > > >
> > > > > > > The stack is show as below:
> > > > > > > [28848.883915]  _raw_spin_lock+0x1e/0x30
> > > > > > > [28848.884367]  __dev_queue_xmit+0x160/0x850
> > > > > > > [28848.884851]  ? 0xffffffffc031906a
> > > > > > > [28848.885279]  tcf_mirred_act+0x3ab/0x596 [act_mirred]
> > > > > > > [28848.885863]  tcf_action_exec.part.0+0x88/0x130
> > > > > > > [28848.886401]  fl_classify+0x1ca/0x1e0 [cls_flower]
> > > > > > > [28848.886970]  ? dequeue_entity+0x145/0x9e0
> > > > > > > [28848.887464]  ? newidle_balance+0x23f/0x2f0
> > > > > > > [28848.887973]  ? nft_lookup_eval+0x57/0x170 [nf_tables]
> > > > > > > [28848.888566]  ? nft_do_chain+0xef/0x430 [nf_tables]
> > > > > > > [28848.889137]  ? __flush_work.isra.0+0x35/0x80
> > > > > > > [28848.889657]  ? nf_ct_get_tuple+0x1cf/0x210 [nf_conntrack]
> > > > > > > [28848.890293]  ? do_select+0x637/0x870
> > > > > > > [28848.890735]  tcf_classify+0x52/0xf0
> > > > > > > [28848.891177]  htb_classify+0x9d/0x1c0 [sch_htb]
> > > > > > > [28848.891722]  htb_enqueue+0x3a/0x1c0 [sch_htb]
> > > > > > > [28848.892251]  __dev_queue_xmit+0x2d8/0x850
> > > > > > > [28848.892738]  ? nf_hook_slow+0x3c/0xb0
> > > > > > > [28848.893198]  ip_finish_output2+0x272/0x580
> > > > > > > [28848.893692]  __ip_queue_xmit+0x193/0x420
> > > > > > > [28848.894179]  __tcp_transmit_skb+0x8cc/0x970
> > > > > > >
> > > > > > > In this case, the process has hold the qdisc spin lock in __d=
ev_queue_xmit
> > > > > > > before the egress packets are mirred, and it will attempt to =
obtain the
> > > > > > > spin lock again after packets are mirred, which cause a deadl=
ock.
> > > > > > >
> > > > > > > Fix the issue by forbidding assigning mirred action to a filt=
er attached
> > > > > > > to the egress.
> > > > > > >
> > > > > > > Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>
> > > > > > > ---
> > > > > > >  net/sched/act_mirred.c                        |  4 +++
> > > > > > >  .../tc-testing/tc-tests/actions/mirred.json   | 32 +++++++++=
++++++++++
> > > > > > >  2 files changed, 36 insertions(+)
> > > > > > >
> > > > > > > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > > > > > > index 5b3814365924..fc96705285fb 100644
> > > > > > > --- a/net/sched/act_mirred.c
> > > > > > > +++ b/net/sched/act_mirred.c
> > > > > > > @@ -120,6 +120,10 @@ static int tcf_mirred_init(struct net *n=
et, struct nlattr *nla,
> > > > > > >                 NL_SET_ERR_MSG_MOD(extack, "Mirred requires a=
ttributes to be passed");
> > > > > > >                 return -EINVAL;
> > > > > > >         }
> > > > > > > +       if (tp->chain->block->q->parent !=3D TC_H_INGRESS) {
> > > > > > > +               NL_SET_ERR_MSG_MOD(extack, "Mirred can only b=
e assigned to the filter attached to ingress");
> > > > > > > +               return -EINVAL;
> > > > > > > +       }
> > > > > >
> > > > > > Sorry, this is too restrictive as Jiri said. We'll try to repro=
duce. I
> > > > > > am almost certain this used to work in the old days.
> > > > >
> > > > > Ok, i looked at old notes - it did work at "some point" pre-tdc.
> > > > > Conclusion is things broke around this time frame:
> > > > > https://lore.kernel.org/netdev/1431679850-31896-1-git-send-email-=
fw@strlen.de/
> > > > > https://lore.kernel.org/netdev/1465095748.2968.45.camel@edumazet-=
glaptop3.roam.corp.google.com/
> > > > >
> > > > > Looking further into it.
> > > >
> > > > This is what we came up with. Eric, please take a look...
> > > >
> > > > cheers,
> > > > jamal
> > > >
> > > >
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -3789,7 +3789,14 @@ static inline int __dev_xmit_skb(struct sk_b=
uff
> > > > *skb, struct Qdisc *q,
> > > >         if (unlikely(contended))
> > > >                 spin_lock(&q->busylock);
> > > >
> > > > +       if (dev_recursion_level()) {
> > >
> > > I am not sure what your intent is, but this seems wrong to me.
> > >
> >
> > There is a deadlock if you reenter the same device which has a qdisc
> > attached to it more than once.
> > Essentially entering __dev_xmit_skb() we grab the root qdisc lock then
> > run some action which requires it to grab the root qdisc lock (again).
> > This is easy to show with mirred (although i am wondering if syzkaller
> > may have produced this at some point)..
> > $TC qdisc add dev $DEV root handle 1: htb default 1
> > $TC filter add dev $DEV protocol ip u32 match ip protocol 1 0xff
> > action mirred egress mirror dev $DEV
> >
> > Above example is essentially egress $DEV-> egress $DEV in both cases
> > "egress $DEV" grabs the root qdisc lock. You could also create another
> > example with egress($DEV1->$DEV2->back to $DEV1).
> >
> > > Some valid setup use :
> > >
> > > A bonding device, with HTB qdisc (or other qdisc)
> > >   (This also could be a tunnel device with a qdisc)
> > >
> > > -> one or multiple physical NIC, wth FQ or other qdisc.
> > >
> > > Packets would be dropped here when we try to reach the physical devic=
e.
> > >
> >
> > If you have an example handy please send it. I am trying to imagine
> > how those would have worked if they have to reenter the root qdisc of
> > the same dev multiple times..
>
> Any virtual device like a GRE/SIT/IPIP/... tunnel, add a qdisc on it ?
>
> dev_xmit_recursion_inc() is global (per-cpu), it is not per-device.
>
> A stack of devices A -> B -> C  would elevate the recursion level to
> three just fine.
>
> After your patch, a stack of devices would no longer work.
>
> It seems mirred correctly injects packets to the top of the stack for
> ingress (via netif_rx() / netif_receive_skb()),
> but thinks it is okay to call dev_queue_xmit(), regardless of the context=
 ?
>
> Perhaps safe-guard mirred, instead of adding more code to fast path.

I agree not to penalize everybody for a "bad config" like this
(surprising syzkaller hasnt caught this). But i dont see how doing the
checking within mirred will catch this (we cant detect the A->B->A
case).
I think you are suggesting a backlog-like queue for mirred? Not far
off from that is how it used to work before
(https://lore.kernel.org/netdev/1465095748.2968.45.camel@edumazet-glaptop3.=
roam.corp.google.com/)
- i.e we had a trylock for the qdisc lock and if it failed we tagged
the rx softirq for a reschedule. That in itself is insufficient, we
would need a loop check which is per-skb (which we had before
https://lore.kernel.org/netdev/1431679850-31896-1-git-send-email-fw@strlen.=
de/).
There are other gotchas there, potentially packet reordering.

cheers,
jamal

