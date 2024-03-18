Return-Path: <netdev+bounces-80466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624687EF0B
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 18:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B673D1F210EE
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DA455C0B;
	Mon, 18 Mar 2024 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="vzLJNH4+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F45535C2
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783413; cv=none; b=mBnHwfnVZcLH9fq+FBXbhDteLmaFOoj9n/pqkea9EFZVBcpA2CRVmecEUFIaJO8kPPkGdDxW8beWfxNha1nLu3Xmf/dwrtu9PmkbpfxkyPu/UDXijxYxEf+rXgcJp3OU3ragHkSzcDhPd/vwNnFJ0hSWnVGiIL3/O7TJP6wILcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783413; c=relaxed/simple;
	bh=jDdPlWW3Zx4B+agqeCDUzdkqvGWIXX8CmHVbUlYQnVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJLBNfzOoKB+dZQUmSzq3MKRxazVoABpoaA5m1yG7pucwiSIoUoN+v1awJjg6Ep/pQu/wCNBdFi+u5Q6WBy21ATByw0w9/4OAxPOQPmDsFPTIuIw4nFqO2vjkSXPj0/JUf5WUNpMjnlus2vAmVmPddUtcYX8oQ3Un+it/TpG/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=vzLJNH4+; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-609fd5fbe50so49899487b3.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1710783410; x=1711388210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/0F08IaSQG9zYcah/sEX7QxeV98OzTuAOC6PmayBUA=;
        b=vzLJNH4+9UvGXEmBoZOham9bQMKiVd55EP61bajroNiTWDZ3vA6zCwcWE8OZqI1rXF
         1JAXqx9Yfc1xJfGoIq9g6iSCsTNC2GnIn/710cnKh7aPnv/96GZTFlU/754d79UkXI9r
         O/yLDBhQIQLNMzomPgGnaS58yRMWHkF6tNdUCfxp5IorQJg7+VKytrJbhzeS1aGl0y/c
         enGj5phy4nCNjFCt/zscqwIkUmB//o0iDXbbxz++EcX7K5DBtT/F6XmPuG2aUfkn+XGx
         YtJtMuVrc95EeR1uQRbrbEzcz3yi+ERGQ7vIT3GUZepGE7BA8/S0PX/rdMqsRHSkNnqi
         CvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710783410; x=1711388210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/0F08IaSQG9zYcah/sEX7QxeV98OzTuAOC6PmayBUA=;
        b=rVeAuv8UEfEmRnvwa1P0Q0tAH3yaO2GHoKjzWp6vgGYgX+CPINTz4k8jYGNWhOLocc
         xULGk4SREzRMnMQ0MEyl7TedTcH8qvP87COeD88YlsR9rd24t+efusSNf5c2VfkcBIdZ
         2V1U/MsYFAa1+c0aoY3I2PpdwSf62LFJ+KO8EfZS38XgFiPONExcNDGC/+v6Ue9tGpuE
         QBpwnMutIH1S57H0X0mCwenhspP0s3P3lT6x89KUdyF6OpfY8ZkHkdqKzQywP1vyDCGq
         TpPg0a5MI6SylD2LPuI94SLewZ8KoMoWCBFFwq56WD9n73NCVIBUcSevBp5Gpbl9fT2r
         7KHg==
X-Forwarded-Encrypted: i=1; AJvYcCWoyZKO0L2iVZ3UWO24elNihlVKTuIXVHhiQ83Pb4RNstCDxXdduDqhX3GwBNePlWbLZu3ksjUd4p3qy7Jl2Xl/sI1FTeIc
X-Gm-Message-State: AOJu0YxG99QmdYtM71a1Cv890ISBH8L02uW2pUmu84ykRaITisQGeQbA
	bZERP0xb6ZW7ycYwbS0JDcrkIRDDi6Rz1F1tk2uRLAh7xd8bR17QSowIqD9AS6smpyCUBBsb5Pj
	h4KeAgLS4mWfP73X+jDCXmuW6aGuf3ReC+JhQ
X-Google-Smtp-Source: AGHT+IFEjiceN+yrYTYt1HpD4GLH2iz7RZ3fL9QB3wvfoxYiEhKMRXkCkHMrxMA/l4m98VU99iOPOBZLl5AlOnFkw7A=
X-Received: by 2002:a81:ad24:0:b0:60c:c997:308e with SMTP id
 l36-20020a81ad24000000b0060cc997308emr12845667ywh.0.1710783409926; Mon, 18
 Mar 2024 10:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314111713.5979-1-renmingshuai@huawei.com>
 <CAM0EoMmqVHGC4_YVHj=rUPj+XBS_N99rCKk1S7wCi1wJ8__Pyw@mail.gmail.com>
 <CAM0EoMkZKvvPVaCGFVTE_P1YCyS-r2b3gq3QRhDuEF=Cm-sY4g@mail.gmail.com>
 <CAM0EoMm+W3X7TG8qjb8LWsBbAQ8_rntr7kwhSTy7Sxk=Yj=R2g@mail.gmail.com> <CANn89iL_hfoWTqr+KaKZoO8fKoZdd-xcY040NeSb-WL7pHMLGQ@mail.gmail.com>
In-Reply-To: <CANn89iL_hfoWTqr+KaKZoO8fKoZdd-xcY040NeSb-WL7pHMLGQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 18 Mar 2024 13:36:38 -0400
Message-ID: <CAM0EoMkqhmDtpg09ktnkxjAtddvXzwQo4Qh2-LX2r8iqrECogw@mail.gmail.com>
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter
 attached to the egress
To: Eric Dumazet <edumazet@google.com>
Cc: renmingshuai <renmingshuai@huawei.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, vladbu@nvidia.com, netdev@vger.kernel.org, 
	yanan@huawei.com, liaichun@huawei.com, caowangbao@huawei.com, 
	Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:46=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Mar 18, 2024 at 3:27=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Sun, Mar 17, 2024 at 12:10=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > On Thu, Mar 14, 2024 at 1:14=E2=80=AFPM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Thu, Mar 14, 2024 at 7:18=E2=80=AFAM renmingshuai <renmingshuai@=
huawei.com> wrote:
> > > > >
> > > > > As we all know the mirred action is used to mirroring or redirect=
ing the
> > > > > packet it receives. Howerver, add mirred action to a filter attac=
hed to
> > > > > a egress qdisc might cause a deadlock. To reproduce the problem, =
perform
> > > > > the following steps:
> > > > > (1)tc qdisc add dev eth0 root handle 1: htb default 30 \n
> > > > > (2)tc filter add dev eth2 protocol ip prio 2 flower verbose \
> > > > >      action police rate 100mbit burst 12m conform-exceed jump 1 \
> > > > >      / pipe mirred egress redirect dev eth2 action drop
> > > > >
> > > >
> > > > I think you meant both to be the same device eth0 or eth2?
> > > >
> > > > > The stack is show as below:
> > > > > [28848.883915]  _raw_spin_lock+0x1e/0x30
> > > > > [28848.884367]  __dev_queue_xmit+0x160/0x850
> > > > > [28848.884851]  ? 0xffffffffc031906a
> > > > > [28848.885279]  tcf_mirred_act+0x3ab/0x596 [act_mirred]
> > > > > [28848.885863]  tcf_action_exec.part.0+0x88/0x130
> > > > > [28848.886401]  fl_classify+0x1ca/0x1e0 [cls_flower]
> > > > > [28848.886970]  ? dequeue_entity+0x145/0x9e0
> > > > > [28848.887464]  ? newidle_balance+0x23f/0x2f0
> > > > > [28848.887973]  ? nft_lookup_eval+0x57/0x170 [nf_tables]
> > > > > [28848.888566]  ? nft_do_chain+0xef/0x430 [nf_tables]
> > > > > [28848.889137]  ? __flush_work.isra.0+0x35/0x80
> > > > > [28848.889657]  ? nf_ct_get_tuple+0x1cf/0x210 [nf_conntrack]
> > > > > [28848.890293]  ? do_select+0x637/0x870
> > > > > [28848.890735]  tcf_classify+0x52/0xf0
> > > > > [28848.891177]  htb_classify+0x9d/0x1c0 [sch_htb]
> > > > > [28848.891722]  htb_enqueue+0x3a/0x1c0 [sch_htb]
> > > > > [28848.892251]  __dev_queue_xmit+0x2d8/0x850
> > > > > [28848.892738]  ? nf_hook_slow+0x3c/0xb0
> > > > > [28848.893198]  ip_finish_output2+0x272/0x580
> > > > > [28848.893692]  __ip_queue_xmit+0x193/0x420
> > > > > [28848.894179]  __tcp_transmit_skb+0x8cc/0x970
> > > > >
> > > > > In this case, the process has hold the qdisc spin lock in __dev_q=
ueue_xmit
> > > > > before the egress packets are mirred, and it will attempt to obta=
in the
> > > > > spin lock again after packets are mirred, which cause a deadlock.
> > > > >
> > > > > Fix the issue by forbidding assigning mirred action to a filter a=
ttached
> > > > > to the egress.
> > > > >
> > > > > Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>
> > > > > ---
> > > > >  net/sched/act_mirred.c                        |  4 +++
> > > > >  .../tc-testing/tc-tests/actions/mirred.json   | 32 +++++++++++++=
++++++
> > > > >  2 files changed, 36 insertions(+)
> > > > >
> > > > > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > > > > index 5b3814365924..fc96705285fb 100644
> > > > > --- a/net/sched/act_mirred.c
> > > > > +++ b/net/sched/act_mirred.c
> > > > > @@ -120,6 +120,10 @@ static int tcf_mirred_init(struct net *net, =
struct nlattr *nla,
> > > > >                 NL_SET_ERR_MSG_MOD(extack, "Mirred requires attri=
butes to be passed");
> > > > >                 return -EINVAL;
> > > > >         }
> > > > > +       if (tp->chain->block->q->parent !=3D TC_H_INGRESS) {
> > > > > +               NL_SET_ERR_MSG_MOD(extack, "Mirred can only be as=
signed to the filter attached to ingress");
> > > > > +               return -EINVAL;
> > > > > +       }
> > > >
> > > > Sorry, this is too restrictive as Jiri said. We'll try to reproduce=
. I
> > > > am almost certain this used to work in the old days.
> > >
> > > Ok, i looked at old notes - it did work at "some point" pre-tdc.
> > > Conclusion is things broke around this time frame:
> > > https://lore.kernel.org/netdev/1431679850-31896-1-git-send-email-fw@s=
trlen.de/
> > > https://lore.kernel.org/netdev/1465095748.2968.45.camel@edumazet-glap=
top3.roam.corp.google.com/
> > >
> > > Looking further into it.
> >
> > This is what we came up with. Eric, please take a look...
> >
> > cheers,
> > jamal
> >
> >
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3789,7 +3789,14 @@ static inline int __dev_xmit_skb(struct sk_buff
> > *skb, struct Qdisc *q,
> >         if (unlikely(contended))
> >                 spin_lock(&q->busylock);
> >
> > +       if (dev_recursion_level()) {
>
> I am not sure what your intent is, but this seems wrong to me.
>

There is a deadlock if you reenter the same device which has a qdisc
attached to it more than once.
Essentially entering __dev_xmit_skb() we grab the root qdisc lock then
run some action which requires it to grab the root qdisc lock (again).
This is easy to show with mirred (although i am wondering if syzkaller
may have produced this at some point)..
$TC qdisc add dev $DEV root handle 1: htb default 1
$TC filter add dev $DEV protocol ip u32 match ip protocol 1 0xff
action mirred egress mirror dev $DEV

Above example is essentially egress $DEV-> egress $DEV in both cases
"egress $DEV" grabs the root qdisc lock. You could also create another
example with egress($DEV1->$DEV2->back to $DEV1).

> Some valid setup use :
>
> A bonding device, with HTB qdisc (or other qdisc)
>   (This also could be a tunnel device with a qdisc)
>
> -> one or multiple physical NIC, wth FQ or other qdisc.
>
> Packets would be dropped here when we try to reach the physical device.
>

If you have an example handy please send it. I am trying to imagine
how those would have worked if they have to reenter the root qdisc of
the same dev multiple times..

cheers,
jamal


> > +               rc =3D NET_XMIT_DROP;
> > +               __qdisc_drop(skb, &to_free);
> > +               goto free;
> > +       }
> > +
> >         spin_lock(root_lock);
> > +       dev_xmit_recursion_inc();
> >         if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
> >                 __qdisc_drop(skb, &to_free);
> >                 rc =3D NET_XMIT_DROP;
> > @@ -3824,8 +3831,10 @@ static inline int __dev_xmit_skb(struct sk_buff
> > *skb, struct Qdisc *q,
> >                         qdisc_run_end(q);
> >                 }
> >         }
> > +       dev_xmit_recursion_dec();
> >         spin_unlock(root_lock);
> >         if (unlikely(to_free))
> > +free:
> >                 kfree_skb_list_reason(to_free,
> >                                       tcf_get_drop_reason(to_free));
> >         if (unlikely(contended))

