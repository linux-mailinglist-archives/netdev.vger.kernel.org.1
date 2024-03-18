Return-Path: <netdev+bounces-80421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8284287EAEE
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 15:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28AD1C20D6E
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 14:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A544BA94;
	Mon, 18 Mar 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QYt03oPN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B0E25740
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772051; cv=none; b=O4Bo7LTC0eby6FqoXQWJSX0bEvKpWZUxESIV2DJeaoiyB53o/tW6X14E8ynsQ7eolhYUUuZjNfL76homYToDJdnpje8yghwPdySNTu914DQK1YCby5jvMO5jWj9FVRJa4eT9b/hYdHODsu5OprGZb12cb6hsV2KH8ya1ECEvkNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772051; c=relaxed/simple;
	bh=vMjangHmhIsFcqbY2zMb+hekHvoejiMsc8ElxL6lI/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqJkK1XkST8mdaSRLi2qqNhd+WturFa35uBfaYdBfZGUTPyKc/rijF8zpy0/cWPnVSy2zukWEjvNFtG8TOthmAJiIGZZuSjgg3dvLhAcIMxFkNSDXJbYFJ8jIWeVX/5cuKHlcikVsGVhTbL8so4qJ8zMQxbphSeVcbuaXJqsMMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QYt03oPN; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6098a20ab22so39947067b3.2
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1710772048; x=1711376848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i86Y1C8ACu60ezBiV3Hsao6Bo4yhfhnLYWm/UnhLOKw=;
        b=QYt03oPNngX4/DPuEWWX3JZTdIf/QvutQh1stttoDvBW/+E10Y16tjIcqLoNP0CL0A
         Ur24wTPdrkZOkXM13DjRhuU6SLNV6THwA/Zlh5xkf6W9MGjzqo1CAz+W4uz5mo2ED6Xf
         nAzipasaY4gEAhEzMeFwI/G4cuQwPAs2JmRFZdLn52DlIrm2iI15c3bk8TAclTJgLQMl
         YexgXjc8kUkTu1tZYbNWRjf20oo101w1sSFLtWPkMowMGs8thC190+OYoI4FxE//0up3
         Vc7n678potnVxjhRZW5/KkEltIRBtZXL/Mg+sPr1pRx7hL1re2TWsVJCa6QZ0UQTtkRo
         K5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710772048; x=1711376848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i86Y1C8ACu60ezBiV3Hsao6Bo4yhfhnLYWm/UnhLOKw=;
        b=ej76eTDSZ+0YM4l5Z2Wmf/MaepTiMxJClvx5UGijfL2mEkiTx3UNT1Dy9AWrPiDxtn
         iPOPwjZcnFEQGS4MXd9hfvwggKOGoSFlFmu+gHwDovrKl2OE42w7K9u7hTVk3/2VaZdW
         8XEv2KHtrj4aeuALYuzHzGsRmL9OT2Ukfvc/W4iV9KwH4K9BaS2FVzWFgMnYGMj+oYul
         zVTMfZIWNnj9ZsLPTGggrO+KxpIywUWlFrH/S+qQIQm3vdFyrsCDGQpONNx8dWn5bOXz
         d0UXJLM98yHCzJNM3Fj8KRJNTbbh8MyWGkK3GwWiF1FETEe7AhxlzQBty8WzuJCaMhVw
         VREA==
X-Forwarded-Encrypted: i=1; AJvYcCU6WA8CvnIFd7HL7f71hsV5nILpF0oNc5ZVDoAQWMqrQaX2z0szrEkRdzBPE9xpbOqBIn4I9ZhhVeFmc9aTqsLTH76MkRQk
X-Gm-Message-State: AOJu0YxfATplGn/hATDYC0df63tuwPTT7i/V/onMjB4s41SI/qvO8uNN
	9iT7e0WXAGBk1RseVP72tPDScN6vsCkPvsQZcdEbbk4E4NrBb5v7tLfpniLYzWXoJVNqF17/IUL
	fTYHWLRSDwq9mECoMsoCmqFH2vrCBd09rnzh4
X-Google-Smtp-Source: AGHT+IHzsQeZ771cVahOzmno2qV84ihQZouTr8tAzi3W6m8rXATVPHf2e2gpNQRWDd1fG9/LpTjLBrsBgxYY3kJa5+E=
X-Received: by 2002:a0d:c343:0:b0:610:ccbe:159a with SMTP id
 f64-20020a0dc343000000b00610ccbe159amr2967483ywd.18.1710772047859; Mon, 18
 Mar 2024 07:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314111713.5979-1-renmingshuai@huawei.com>
 <CAM0EoMmqVHGC4_YVHj=rUPj+XBS_N99rCKk1S7wCi1wJ8__Pyw@mail.gmail.com> <CAM0EoMkZKvvPVaCGFVTE_P1YCyS-r2b3gq3QRhDuEF=Cm-sY4g@mail.gmail.com>
In-Reply-To: <CAM0EoMkZKvvPVaCGFVTE_P1YCyS-r2b3gq3QRhDuEF=Cm-sY4g@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 18 Mar 2024 10:27:16 -0400
Message-ID: <CAM0EoMm+W3X7TG8qjb8LWsBbAQ8_rntr7kwhSTy7Sxk=Yj=R2g@mail.gmail.com>
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter
 attached to the egress
To: renmingshuai <renmingshuai@huawei.com>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	vladbu@nvidia.com, netdev@vger.kernel.org, yanan@huawei.com, 
	liaichun@huawei.com, caowangbao@huawei.com, 
	Eric Dumazet <edumazet@google.com>, Eric Dumazet <eric.dumazet@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 12:10=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Thu, Mar 14, 2024 at 1:14=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Thu, Mar 14, 2024 at 7:18=E2=80=AFAM renmingshuai <renmingshuai@huaw=
ei.com> wrote:
> > >
> > > As we all know the mirred action is used to mirroring or redirecting =
the
> > > packet it receives. Howerver, add mirred action to a filter attached =
to
> > > a egress qdisc might cause a deadlock. To reproduce the problem, perf=
orm
> > > the following steps:
> > > (1)tc qdisc add dev eth0 root handle 1: htb default 30 \n
> > > (2)tc filter add dev eth2 protocol ip prio 2 flower verbose \
> > >      action police rate 100mbit burst 12m conform-exceed jump 1 \
> > >      / pipe mirred egress redirect dev eth2 action drop
> > >
> >
> > I think you meant both to be the same device eth0 or eth2?
> >
> > > The stack is show as below:
> > > [28848.883915]  _raw_spin_lock+0x1e/0x30
> > > [28848.884367]  __dev_queue_xmit+0x160/0x850
> > > [28848.884851]  ? 0xffffffffc031906a
> > > [28848.885279]  tcf_mirred_act+0x3ab/0x596 [act_mirred]
> > > [28848.885863]  tcf_action_exec.part.0+0x88/0x130
> > > [28848.886401]  fl_classify+0x1ca/0x1e0 [cls_flower]
> > > [28848.886970]  ? dequeue_entity+0x145/0x9e0
> > > [28848.887464]  ? newidle_balance+0x23f/0x2f0
> > > [28848.887973]  ? nft_lookup_eval+0x57/0x170 [nf_tables]
> > > [28848.888566]  ? nft_do_chain+0xef/0x430 [nf_tables]
> > > [28848.889137]  ? __flush_work.isra.0+0x35/0x80
> > > [28848.889657]  ? nf_ct_get_tuple+0x1cf/0x210 [nf_conntrack]
> > > [28848.890293]  ? do_select+0x637/0x870
> > > [28848.890735]  tcf_classify+0x52/0xf0
> > > [28848.891177]  htb_classify+0x9d/0x1c0 [sch_htb]
> > > [28848.891722]  htb_enqueue+0x3a/0x1c0 [sch_htb]
> > > [28848.892251]  __dev_queue_xmit+0x2d8/0x850
> > > [28848.892738]  ? nf_hook_slow+0x3c/0xb0
> > > [28848.893198]  ip_finish_output2+0x272/0x580
> > > [28848.893692]  __ip_queue_xmit+0x193/0x420
> > > [28848.894179]  __tcp_transmit_skb+0x8cc/0x970
> > >
> > > In this case, the process has hold the qdisc spin lock in __dev_queue=
_xmit
> > > before the egress packets are mirred, and it will attempt to obtain t=
he
> > > spin lock again after packets are mirred, which cause a deadlock.
> > >
> > > Fix the issue by forbidding assigning mirred action to a filter attac=
hed
> > > to the egress.
> > >
> > > Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>
> > > ---
> > >  net/sched/act_mirred.c                        |  4 +++
> > >  .../tc-testing/tc-tests/actions/mirred.json   | 32 +++++++++++++++++=
++
> > >  2 files changed, 36 insertions(+)
> > >
> > > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > > index 5b3814365924..fc96705285fb 100644
> > > --- a/net/sched/act_mirred.c
> > > +++ b/net/sched/act_mirred.c
> > > @@ -120,6 +120,10 @@ static int tcf_mirred_init(struct net *net, stru=
ct nlattr *nla,
> > >                 NL_SET_ERR_MSG_MOD(extack, "Mirred requires attribute=
s to be passed");
> > >                 return -EINVAL;
> > >         }
> > > +       if (tp->chain->block->q->parent !=3D TC_H_INGRESS) {
> > > +               NL_SET_ERR_MSG_MOD(extack, "Mirred can only be assign=
ed to the filter attached to ingress");
> > > +               return -EINVAL;
> > > +       }
> >
> > Sorry, this is too restrictive as Jiri said. We'll try to reproduce. I
> > am almost certain this used to work in the old days.
>
> Ok, i looked at old notes - it did work at "some point" pre-tdc.
> Conclusion is things broke around this time frame:
> https://lore.kernel.org/netdev/1431679850-31896-1-git-send-email-fw@strle=
n.de/
> https://lore.kernel.org/netdev/1465095748.2968.45.camel@edumazet-glaptop3=
.roam.corp.google.com/
>
> Looking further into it.

This is what we came up with. Eric, please take a look...

cheers,
jamal


--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3789,7 +3789,14 @@ static inline int __dev_xmit_skb(struct sk_buff
*skb, struct Qdisc *q,
        if (unlikely(contended))
                spin_lock(&q->busylock);

+       if (dev_recursion_level()) {
+               rc =3D NET_XMIT_DROP;
+               __qdisc_drop(skb, &to_free);
+               goto free;
+       }
+
        spin_lock(root_lock);
+       dev_xmit_recursion_inc();
        if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
                __qdisc_drop(skb, &to_free);
                rc =3D NET_XMIT_DROP;
@@ -3824,8 +3831,10 @@ static inline int __dev_xmit_skb(struct sk_buff
*skb, struct Qdisc *q,
                        qdisc_run_end(q);
                }
        }
+       dev_xmit_recursion_dec();
        spin_unlock(root_lock);
        if (unlikely(to_free))
+free:
                kfree_skb_list_reason(to_free,
                                      tcf_get_drop_reason(to_free));
        if (unlikely(contended))

