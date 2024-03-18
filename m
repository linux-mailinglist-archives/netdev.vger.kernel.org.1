Return-Path: <netdev+bounces-80443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7729B87EC72
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 16:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516E41C21021
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 15:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630C4524C1;
	Mon, 18 Mar 2024 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="csmFPszC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656C5535A9
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776801; cv=none; b=R7D3bfvTBnQq1uuvJslpy8OC9OleGqO3/9pm+WGILLcClvl7h0475eC6XFRAVBYE+1fMmkFz9ePHpAhlUfkink1KEAu1vxUupyxt0pDrOE0p5U5hTyM2I4ctfTnxPic3kezBUzI4oQaMOq+tqsNjkCVFbSTLQGt4yibGXgFf+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776801; c=relaxed/simple;
	bh=jXXI50TiMlOqJQjdXFo9vY7QDh00uCpEoElOkrZox9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs53iEl/9JeBRJ1LnmPwYWOWWiUTKKSXEANEbz+TbzGl/Yzl4ufstMw1jSg2O1d/k2wPugEDgdcPMcWCb9C9n9sPAbuc06piCW7MHNJcydlGXV2ig6csnFx1Q7z5JjZjGWpl+pnXmBT19ZQSTHCO9ONn+52Er636rH4FyLsg58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=csmFPszC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-568d160155aso11193a12.1
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710776798; x=1711381598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QZzjYRU9TXg6zXSHoYWJ3rkIJT1MGLQJOrabGyzS9I=;
        b=csmFPszCLdr5lYc1qLmbDkAuue8pvd4JvkkSden5GEHVKBJpYkIyqtQqV+BOaANkAi
         4EQX4tZ+2vV4y5IkP2DIbRrsAIQ8nw5p2LJmZJlO3eFjl+PePmww0+luA5Vg5pjx193K
         pVrbWUMHuBOdc7+71/M9A0oC0caovG4LkWmnT8ZVcPruqnhzexqV/ZtVNxG2YKnawXr4
         iMcEHwal+yp3xkCslJvZkgflD02yUHnWsOSmkW7nLGCIqWfuH7dxpElqqQg3iOyiUnws
         ci6yjQsyQGqzPXCh9ji3KJOr058um4QM9xHHD/05C0/7UGDQuWFgWEB8nW7hME2GHaZs
         inQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710776798; x=1711381598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QZzjYRU9TXg6zXSHoYWJ3rkIJT1MGLQJOrabGyzS9I=;
        b=L/pHLDGc6nIGedkANKydSaD7rWaG5ASG1bWHwNLWM30CDGzaBEUxipi51T/wxtOXGc
         UE459c0dsjg/anWnPlhgHtVPzOKOEz8GrVvxEjo2mvf36u4ieKxGi/eJ0PPkqialhSqM
         C5zHxpE8E8ecnAfMMYWvp/6hZTg1wqfH5/1EdG0zHmOVtvl+F7mqA02Jl9nLJ4O7AAqa
         yQZT5O1GMjIe/In5xTVY4bBsJvp2g7c3Tx4ZQatxOBJntqCdqTod/FIQIn5ZMbZ1XLcZ
         PFkkxYoYALeBcHQQHM+HRHkS1Vanj0WZuc4Pf1lnYxNPBF5n79w2g01XhpDbY86OHzI0
         c8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWNByahoSh5nXqAs/HvRXoJ+wJl/UeP+Sxbx3sPIG4Lg7qUPoJoOaA6FJSjqWf15Fyni5W4KGMvnrDhnUkhXso0p0Rbkdft
X-Gm-Message-State: AOJu0YxfVWX2LkqZtmyncvzcKXzhvdeoTpgbronT/v0p3SPNVvha9bXT
	qpTboonlBYsevUf+9+z1m7rlWJcls3sHfXJQXxXUL+MEUXgqP5FLwCXLRlyFr7wGpBqnPkUrb3o
	4n/NO8dYMoYTQYVQsea3iDtT97DdrB9y7+lUo
X-Google-Smtp-Source: AGHT+IHisruZG2LLKHbWeenBghR7I5/G0mgFW0rpi2GnmuRAsMCW2wHM6XUBLTkRQ0/xJbBAm6rTv9hGT+5W0uSY8Uo=
X-Received: by 2002:a05:6402:341a:b0:569:806:f643 with SMTP id
 k26-20020a056402341a00b005690806f643mr164611edc.5.1710776797382; Mon, 18 Mar
 2024 08:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314111713.5979-1-renmingshuai@huawei.com>
 <CAM0EoMmqVHGC4_YVHj=rUPj+XBS_N99rCKk1S7wCi1wJ8__Pyw@mail.gmail.com>
 <CAM0EoMkZKvvPVaCGFVTE_P1YCyS-r2b3gq3QRhDuEF=Cm-sY4g@mail.gmail.com> <CAM0EoMm+W3X7TG8qjb8LWsBbAQ8_rntr7kwhSTy7Sxk=Yj=R2g@mail.gmail.com>
In-Reply-To: <CAM0EoMm+W3X7TG8qjb8LWsBbAQ8_rntr7kwhSTy7Sxk=Yj=R2g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Mar 2024 16:46:23 +0100
Message-ID: <CANn89iL_hfoWTqr+KaKZoO8fKoZdd-xcY040NeSb-WL7pHMLGQ@mail.gmail.com>
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

On Mon, Mar 18, 2024 at 3:27=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sun, Mar 17, 2024 at 12:10=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > On Thu, Mar 14, 2024 at 1:14=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Thu, Mar 14, 2024 at 7:18=E2=80=AFAM renmingshuai <renmingshuai@hu=
awei.com> wrote:
> > > >
> > > > As we all know the mirred action is used to mirroring or redirectin=
g the
> > > > packet it receives. Howerver, add mirred action to a filter attache=
d to
> > > > a egress qdisc might cause a deadlock. To reproduce the problem, pe=
rform
> > > > the following steps:
> > > > (1)tc qdisc add dev eth0 root handle 1: htb default 30 \n
> > > > (2)tc filter add dev eth2 protocol ip prio 2 flower verbose \
> > > >      action police rate 100mbit burst 12m conform-exceed jump 1 \
> > > >      / pipe mirred egress redirect dev eth2 action drop
> > > >
> > >
> > > I think you meant both to be the same device eth0 or eth2?
> > >
> > > > The stack is show as below:
> > > > [28848.883915]  _raw_spin_lock+0x1e/0x30
> > > > [28848.884367]  __dev_queue_xmit+0x160/0x850
> > > > [28848.884851]  ? 0xffffffffc031906a
> > > > [28848.885279]  tcf_mirred_act+0x3ab/0x596 [act_mirred]
> > > > [28848.885863]  tcf_action_exec.part.0+0x88/0x130
> > > > [28848.886401]  fl_classify+0x1ca/0x1e0 [cls_flower]
> > > > [28848.886970]  ? dequeue_entity+0x145/0x9e0
> > > > [28848.887464]  ? newidle_balance+0x23f/0x2f0
> > > > [28848.887973]  ? nft_lookup_eval+0x57/0x170 [nf_tables]
> > > > [28848.888566]  ? nft_do_chain+0xef/0x430 [nf_tables]
> > > > [28848.889137]  ? __flush_work.isra.0+0x35/0x80
> > > > [28848.889657]  ? nf_ct_get_tuple+0x1cf/0x210 [nf_conntrack]
> > > > [28848.890293]  ? do_select+0x637/0x870
> > > > [28848.890735]  tcf_classify+0x52/0xf0
> > > > [28848.891177]  htb_classify+0x9d/0x1c0 [sch_htb]
> > > > [28848.891722]  htb_enqueue+0x3a/0x1c0 [sch_htb]
> > > > [28848.892251]  __dev_queue_xmit+0x2d8/0x850
> > > > [28848.892738]  ? nf_hook_slow+0x3c/0xb0
> > > > [28848.893198]  ip_finish_output2+0x272/0x580
> > > > [28848.893692]  __ip_queue_xmit+0x193/0x420
> > > > [28848.894179]  __tcp_transmit_skb+0x8cc/0x970
> > > >
> > > > In this case, the process has hold the qdisc spin lock in __dev_que=
ue_xmit
> > > > before the egress packets are mirred, and it will attempt to obtain=
 the
> > > > spin lock again after packets are mirred, which cause a deadlock.
> > > >
> > > > Fix the issue by forbidding assigning mirred action to a filter att=
ached
> > > > to the egress.
> > > >
> > > > Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>
> > > > ---
> > > >  net/sched/act_mirred.c                        |  4 +++
> > > >  .../tc-testing/tc-tests/actions/mirred.json   | 32 +++++++++++++++=
++++
> > > >  2 files changed, 36 insertions(+)
> > > >
> > > > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > > > index 5b3814365924..fc96705285fb 100644
> > > > --- a/net/sched/act_mirred.c
> > > > +++ b/net/sched/act_mirred.c
> > > > @@ -120,6 +120,10 @@ static int tcf_mirred_init(struct net *net, st=
ruct nlattr *nla,
> > > >                 NL_SET_ERR_MSG_MOD(extack, "Mirred requires attribu=
tes to be passed");
> > > >                 return -EINVAL;
> > > >         }
> > > > +       if (tp->chain->block->q->parent !=3D TC_H_INGRESS) {
> > > > +               NL_SET_ERR_MSG_MOD(extack, "Mirred can only be assi=
gned to the filter attached to ingress");
> > > > +               return -EINVAL;
> > > > +       }
> > >
> > > Sorry, this is too restrictive as Jiri said. We'll try to reproduce. =
I
> > > am almost certain this used to work in the old days.
> >
> > Ok, i looked at old notes - it did work at "some point" pre-tdc.
> > Conclusion is things broke around this time frame:
> > https://lore.kernel.org/netdev/1431679850-31896-1-git-send-email-fw@str=
len.de/
> > https://lore.kernel.org/netdev/1465095748.2968.45.camel@edumazet-glapto=
p3.roam.corp.google.com/
> >
> > Looking further into it.
>
> This is what we came up with. Eric, please take a look...
>
> cheers,
> jamal
>
>
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3789,7 +3789,14 @@ static inline int __dev_xmit_skb(struct sk_buff
> *skb, struct Qdisc *q,
>         if (unlikely(contended))
>                 spin_lock(&q->busylock);
>
> +       if (dev_recursion_level()) {

I am not sure what your intent is, but this seems wrong to me.

Some valid setup use :

A bonding device, with HTB qdisc (or other qdisc)
  (This also could be a tunnel device with a qdisc)

-> one or multiple physical NIC, wth FQ or other qdisc.

Packets would be dropped here when we try to reach the physical device.

> +               rc =3D NET_XMIT_DROP;
> +               __qdisc_drop(skb, &to_free);
> +               goto free;
> +       }
> +
>         spin_lock(root_lock);
> +       dev_xmit_recursion_inc();
>         if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
>                 __qdisc_drop(skb, &to_free);
>                 rc =3D NET_XMIT_DROP;
> @@ -3824,8 +3831,10 @@ static inline int __dev_xmit_skb(struct sk_buff
> *skb, struct Qdisc *q,
>                         qdisc_run_end(q);
>                 }
>         }
> +       dev_xmit_recursion_dec();
>         spin_unlock(root_lock);
>         if (unlikely(to_free))
> +free:
>                 kfree_skb_list_reason(to_free,
>                                       tcf_get_drop_reason(to_free));
>         if (unlikely(contended))

