Return-Path: <netdev+bounces-80475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC8687F02C
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 20:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7AC281C16
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 19:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DD856462;
	Mon, 18 Mar 2024 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zOx9tm2B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266C5645C
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789093; cv=none; b=StFxQpZgkvayMijXxYhz3RDvMrWYIBa7VyMAwKlEKs9YdyjWuYNuG7QL+/LHE8kHwozXPkcycM3DnKJFafE599Eb6eYk1md7P4fyOD10l9U36L2vGFPmAlgJSIYzFDxBfKBFF7a8ZIWIqkS3V4CnU5Fza7VnuCzvTuv2No/p7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789093; c=relaxed/simple;
	bh=vbRWz5K9NTSszNsw6ZcueaMlkKLE3H6SGWEN0Wo9R58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4l8AozQAgmQ5n3Ur82OfslBWZabQg7dk+Nn0dosv8ys8utsI+5BAiorMysOxzREBl0bvr8YgSBjM7ojxsvfBX8DkPInhzbXWlG+Az99NCMC2flvff5z1uM16ksqwi6or/vfIv92g8zlgKl9Iu5KgtHE2oCmj6LDHczIg7OxrVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zOx9tm2B; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-568c3888ad7so3503a12.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 12:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710789089; x=1711393889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gawhhL/GGdTlH8efilkm133hNQKiTawcI4U8zZY3TiQ=;
        b=zOx9tm2BJhUqysqFBk3PUQE+B3sFSaPA4+p4ukJZB6I4xoGEDi0Y5bABANcQ2awMRx
         ybIBxXs3p58NGuym/WhuUrossdz7kWsM/M9I8lsbsF3+TvPL9c3MD2zsLcNUfwC51xe7
         AeSttppOAmBIEXjvwqEdiXU3CUMX7BOeN39I1uJGHK17edrWVnFdwPytdP7FIOHQ+biM
         VbsBMbg9RLPFUOt0EhdMYLpNpzgCieK+hyBO1013WfZSzT9rP2sda9y9K8hu0kfsMB9H
         AXrztN4fNFfkOsGCGFrtvUJ/cYvzKKg3YdUQbPtTZBaHKlLnwo2plI4FREW04V+fj3nf
         JvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710789089; x=1711393889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gawhhL/GGdTlH8efilkm133hNQKiTawcI4U8zZY3TiQ=;
        b=vFsx7z+AajoZ4LI9E6S+FMFQRkXGhJuFyfUwXwUVfwLM/YbTvc9dA+FHLPV7vY4Fpi
         4BlszZtlqfhSpLbGLIoEC7bUTs/dWqnuf07/6QjKzTsOrxqLJRYU0ZrEVVkY87b6lIBO
         6jl0QOHrHbtyp9zcIwiUPL4HTJu4l6louIYObCaApfWLZ22Hb7UFnYRQOoYMoj75tLaN
         L01EdyjVIonc4Od4NeHJ+XcYYocw5xTDweuN0vhz0sagnv9qUY9Hgts2kg6vwnMnKCXi
         rYszEYJkuVBxsM5VGWU/Z3ZOLAhx8BV2hC8lc7c3yvjOl9HnA1IqRt/+nzqE2EOeRHjG
         R9vw==
X-Forwarded-Encrypted: i=1; AJvYcCXoBHZu4z/Tp/geaHEQGA3FpAftBBRkaZB1AJSLQFKf1AJllb/3by4yHICR7hZ1wU78FOjcoJ6G/4sufNL6C3sJn3dRWeYd
X-Gm-Message-State: AOJu0YxhyEndsmZt0t+Gx4vda53p697blSMA24Rqf6Cc+3/MfQC3QP7Q
	Qj26RuBK8LTfB2HMMXjjhAtwFwSi5mcutM6tlpUjd+uh3Bw9qR6L/zCyxnaxJf9bTCIjxkzcQLm
	en4wsPsdravKHid/i1zCUMdNV0Xz3+lSM5fkR
X-Google-Smtp-Source: AGHT+IHaBjBsoVTQ149TwFD3jQQf8tcnHoSpdYI9kgDDq13OCvlX+Biob/obmo3bes3DFaDwuuK8b/+vBvFWES8q2TI=
X-Received: by 2002:aa7:ca47:0:b0:56b:826e:d77d with SMTP id
 j7-20020aa7ca47000000b0056b826ed77dmr37235edt.3.1710789089321; Mon, 18 Mar
 2024 12:11:29 -0700 (PDT)
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
 <CANn89iL_hfoWTqr+KaKZoO8fKoZdd-xcY040NeSb-WL7pHMLGQ@mail.gmail.com> <CAM0EoMkqhmDtpg09ktnkxjAtddvXzwQo4Qh2-LX2r8iqrECogw@mail.gmail.com>
In-Reply-To: <CAM0EoMkqhmDtpg09ktnkxjAtddvXzwQo4Qh2-LX2r8iqrECogw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Mar 2024 20:11:18 +0100
Message-ID: <CANn89iK2e4csrApZjY+kpR9TwaFpN9rcbRSPtyQnw5P_qkyYfA@mail.gmail.com>
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter
 attached to the egress
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: renmingshuai <renmingshuai@huawei.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, vladbu@nvidia.com, netdev@vger.kernel.org, 
	yanan@huawei.com, liaichun@huawei.com, caowangbao@huawei.com, 
	Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 6:36=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, Mar 18, 2024 at 11:46=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Mon, Mar 18, 2024 at 3:27=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Sun, Mar 17, 2024 at 12:10=E2=80=AFPM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> > > >
> > > > On Thu, Mar 14, 2024 at 1:14=E2=80=AFPM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> > > > >
> > > > > On Thu, Mar 14, 2024 at 7:18=E2=80=AFAM renmingshuai <renmingshua=
i@huawei.com> wrote:
> > > > > >
> > > > > > As we all know the mirred action is used to mirroring or redire=
cting the
> > > > > > packet it receives. Howerver, add mirred action to a filter att=
ached to
> > > > > > a egress qdisc might cause a deadlock. To reproduce the problem=
, perform
> > > > > > the following steps:
> > > > > > (1)tc qdisc add dev eth0 root handle 1: htb default 30 \n
> > > > > > (2)tc filter add dev eth2 protocol ip prio 2 flower verbose \
> > > > > >      action police rate 100mbit burst 12m conform-exceed jump 1=
 \
> > > > > >      / pipe mirred egress redirect dev eth2 action drop
> > > > > >
> > > > >
> > > > > I think you meant both to be the same device eth0 or eth2?
> > > > >
> > > > > > The stack is show as below:
> > > > > > [28848.883915]  _raw_spin_lock+0x1e/0x30
> > > > > > [28848.884367]  __dev_queue_xmit+0x160/0x850
> > > > > > [28848.884851]  ? 0xffffffffc031906a
> > > > > > [28848.885279]  tcf_mirred_act+0x3ab/0x596 [act_mirred]
> > > > > > [28848.885863]  tcf_action_exec.part.0+0x88/0x130
> > > > > > [28848.886401]  fl_classify+0x1ca/0x1e0 [cls_flower]
> > > > > > [28848.886970]  ? dequeue_entity+0x145/0x9e0
> > > > > > [28848.887464]  ? newidle_balance+0x23f/0x2f0
> > > > > > [28848.887973]  ? nft_lookup_eval+0x57/0x170 [nf_tables]
> > > > > > [28848.888566]  ? nft_do_chain+0xef/0x430 [nf_tables]
> > > > > > [28848.889137]  ? __flush_work.isra.0+0x35/0x80
> > > > > > [28848.889657]  ? nf_ct_get_tuple+0x1cf/0x210 [nf_conntrack]
> > > > > > [28848.890293]  ? do_select+0x637/0x870
> > > > > > [28848.890735]  tcf_classify+0x52/0xf0
> > > > > > [28848.891177]  htb_classify+0x9d/0x1c0 [sch_htb]
> > > > > > [28848.891722]  htb_enqueue+0x3a/0x1c0 [sch_htb]
> > > > > > [28848.892251]  __dev_queue_xmit+0x2d8/0x850
> > > > > > [28848.892738]  ? nf_hook_slow+0x3c/0xb0
> > > > > > [28848.893198]  ip_finish_output2+0x272/0x580
> > > > > > [28848.893692]  __ip_queue_xmit+0x193/0x420
> > > > > > [28848.894179]  __tcp_transmit_skb+0x8cc/0x970
> > > > > >
> > > > > > In this case, the process has hold the qdisc spin lock in __dev=
_queue_xmit
> > > > > > before the egress packets are mirred, and it will attempt to ob=
tain the
> > > > > > spin lock again after packets are mirred, which cause a deadloc=
k.
> > > > > >
> > > > > > Fix the issue by forbidding assigning mirred action to a filter=
 attached
> > > > > > to the egress.
> > > > > >
> > > > > > Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>
> > > > > > ---
> > > > > >  net/sched/act_mirred.c                        |  4 +++
> > > > > >  .../tc-testing/tc-tests/actions/mirred.json   | 32 +++++++++++=
++++++++
> > > > > >  2 files changed, 36 insertions(+)
> > > > > >
> > > > > > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > > > > > index 5b3814365924..fc96705285fb 100644
> > > > > > --- a/net/sched/act_mirred.c
> > > > > > +++ b/net/sched/act_mirred.c
> > > > > > @@ -120,6 +120,10 @@ static int tcf_mirred_init(struct net *net=
, struct nlattr *nla,
> > > > > >                 NL_SET_ERR_MSG_MOD(extack, "Mirred requires att=
ributes to be passed");
> > > > > >                 return -EINVAL;
> > > > > >         }
> > > > > > +       if (tp->chain->block->q->parent !=3D TC_H_INGRESS) {
> > > > > > +               NL_SET_ERR_MSG_MOD(extack, "Mirred can only be =
assigned to the filter attached to ingress");
> > > > > > +               return -EINVAL;
> > > > > > +       }
> > > > >
> > > > > Sorry, this is too restrictive as Jiri said. We'll try to reprodu=
ce. I
> > > > > am almost certain this used to work in the old days.
> > > >
> > > > Ok, i looked at old notes - it did work at "some point" pre-tdc.
> > > > Conclusion is things broke around this time frame:
> > > > https://lore.kernel.org/netdev/1431679850-31896-1-git-send-email-fw=
@strlen.de/
> > > > https://lore.kernel.org/netdev/1465095748.2968.45.camel@edumazet-gl=
aptop3.roam.corp.google.com/
> > > >
> > > > Looking further into it.
> > >
> > > This is what we came up with. Eric, please take a look...
> > >
> > > cheers,
> > > jamal
> > >
> > >
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -3789,7 +3789,14 @@ static inline int __dev_xmit_skb(struct sk_buf=
f
> > > *skb, struct Qdisc *q,
> > >         if (unlikely(contended))
> > >                 spin_lock(&q->busylock);
> > >
> > > +       if (dev_recursion_level()) {
> >
> > I am not sure what your intent is, but this seems wrong to me.
> >
>
> There is a deadlock if you reenter the same device which has a qdisc
> attached to it more than once.
> Essentially entering __dev_xmit_skb() we grab the root qdisc lock then
> run some action which requires it to grab the root qdisc lock (again).
> This is easy to show with mirred (although i am wondering if syzkaller
> may have produced this at some point)..
> $TC qdisc add dev $DEV root handle 1: htb default 1
> $TC filter add dev $DEV protocol ip u32 match ip protocol 1 0xff
> action mirred egress mirror dev $DEV
>
> Above example is essentially egress $DEV-> egress $DEV in both cases
> "egress $DEV" grabs the root qdisc lock. You could also create another
> example with egress($DEV1->$DEV2->back to $DEV1).
>
> > Some valid setup use :
> >
> > A bonding device, with HTB qdisc (or other qdisc)
> >   (This also could be a tunnel device with a qdisc)
> >
> > -> one or multiple physical NIC, wth FQ or other qdisc.
> >
> > Packets would be dropped here when we try to reach the physical device.
> >
>
> If you have an example handy please send it. I am trying to imagine
> how those would have worked if they have to reenter the root qdisc of
> the same dev multiple times..

Any virtual device like a GRE/SIT/IPIP/... tunnel, add a qdisc on it ?

dev_xmit_recursion_inc() is global (per-cpu), it is not per-device.

A stack of devices A -> B -> C  would elevate the recursion level to
three just fine.

After your patch, a stack of devices would no longer work.

It seems mirred correctly injects packets to the top of the stack for
ingress (via netif_rx() / netif_receive_skb()),
but thinks it is okay to call dev_queue_xmit(), regardless of the context ?

Perhaps safe-guard mirred, instead of adding more code to fast path.

