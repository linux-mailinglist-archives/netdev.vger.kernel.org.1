Return-Path: <netdev+bounces-80268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC7687DE41
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 17:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B909B282077
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B55B1CAAD;
	Sun, 17 Mar 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="I8xKz/Ai"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188E1C695
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710691849; cv=none; b=FXdTQNZIsj4XlNBqbsKXGkzE+NZULy+WIy/8t6ldEKQNi8aUouUVDc4TKPQLIOY6kYkdoVDaK1YM7UiJggol3BJuTx08us+fudIPQWzkgOPMmEE2OJIK3NAe50c5QYvBTYvfke1TGTwkRx62VQRTpIQ21OeDr+pr4HhXdLalaZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710691849; c=relaxed/simple;
	bh=KMotG60XxuVCEkoVtAm6Ppg7TjP0DwSNy1S7bW+NgaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHTMn9ZNdcvz9r+XbmXggbKtp1eko5FLaMK2Gyiv4I+vUjs2ASOMRo8EMOEE4xO3EW6KjT2YBIETrAEpsLgMyFR7nxU1hp1/I5bbu22J44k8zGpJ+t+9wJZkWfWNaigL76AXfY5WqxJC1H2qSq8pyXZG99UZGszfP6Z/1P/dRss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=I8xKz/Ai; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60a0599f631so31776887b3.2
        for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 09:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1710691846; x=1711296646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVO82x7UzWV3o52/IWJuJPkMrBfqe0LN04bPOBK+oRA=;
        b=I8xKz/Ai4qIMyHU0ji5natEczNmZX2+Atkfz8e58TLYbjHOyzJjMZAa9SnvLogq+8+
         7TJc7IPCpKuwryh6PLDc2lfZp4EbHEyILwp1jf1mb43HkaQQ9gWK8wd7a6gyrSnhY/qw
         eLE3cFkWnjLv8ydVElGH+Yqdsm3XeUbqkhVyjqSGZArrIhneXLe1J0y63ILtBO4+JccW
         ACswiuVAgFkVLKqorfefhPRCLYzPkIOW6oicfBpuXYa0P4JfnnP/+anYupqnqaVRurEc
         a+mYpbgO73ZM7dt1ESVd55nirvtV8D52ZsF9IPaaUaKd+QYRhKnKU5HsvPVScOzg/MHm
         tbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710691846; x=1711296646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVO82x7UzWV3o52/IWJuJPkMrBfqe0LN04bPOBK+oRA=;
        b=mzrgW4K0P4+bN8kPJxi/+4f0x44N8hvRrX9b0QaQkUHnUlG9hb2lj5kFvoS3a9qpuG
         cdwXM4xCQkfvzPGWw+gw2IwOsTZKyJknwOZbEjkHT9bLRCT3bB/fH2DT/+AVSGwAWBNr
         hNjhrniHZogwJ+QESsJZ088NX1193bQ6R6vCB5VCqY0eZbo71cWreuXNuaLuBnKY+vxz
         kpzjhDzY/tkn+Khw6UIH6LaKKe1gPkGfWCy6W3lpNXwOzuoAoAhtDp1/nFH18N46f/qN
         Llv6BfQJXKBcuOqdTA9C4JnMrRu7u2Lt0dvnnNscIvwpl1uWcZ7EG63LfGkvg0PjiQVA
         LdpA==
X-Forwarded-Encrypted: i=1; AJvYcCWMD1rBrCO7OK0MmEkxQNDck3kS4fBrQ7rp1ZcFYxQCiMFCFychv8nYmuEZwLROIL3IQmUrSS29kfqLOfjCXql3j70ZZioD
X-Gm-Message-State: AOJu0YyEPSTpVj1BkIpUg2wM4vgtWmjWXiIY2m9YYFIB+03oUij8pCdX
	t6djJWN8UKLrHri/h8v/arWhTW/FesSWsRZZfOWKOxo3qGSqFGnEKidBhxu+XO43YHfYjwZ1deN
	wZPPOf9ORiawwwJpmg7Ktnt80m19brHqFxncb
X-Google-Smtp-Source: AGHT+IHIHKTxr+rKerrEq+M3xn/PJnKiHuIsKWv7KmHEn1XnyhpuKogDwwIrbKEqi1c/0iO0/dVujbvplI3aamhbesU=
X-Received: by 2002:a0d:e5c1:0:b0:610:b386:759c with SMTP id
 o184-20020a0de5c1000000b00610b386759cmr2714873ywe.12.1710691845778; Sun, 17
 Mar 2024 09:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314111713.5979-1-renmingshuai@huawei.com> <CAM0EoMmqVHGC4_YVHj=rUPj+XBS_N99rCKk1S7wCi1wJ8__Pyw@mail.gmail.com>
In-Reply-To: <CAM0EoMmqVHGC4_YVHj=rUPj+XBS_N99rCKk1S7wCi1wJ8__Pyw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 17 Mar 2024 12:10:34 -0400
Message-ID: <CAM0EoMkZKvvPVaCGFVTE_P1YCyS-r2b3gq3QRhDuEF=Cm-sY4g@mail.gmail.com>
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter
 attached to the egress
To: renmingshuai <renmingshuai@huawei.com>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	vladbu@nvidia.com, netdev@vger.kernel.org, yanan@huawei.com, 
	liaichun@huawei.com, caowangbao@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 1:14=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, Mar 14, 2024 at 7:18=E2=80=AFAM renmingshuai <renmingshuai@huawei=
.com> wrote:
> >
> > As we all know the mirred action is used to mirroring or redirecting th=
e
> > packet it receives. Howerver, add mirred action to a filter attached to
> > a egress qdisc might cause a deadlock. To reproduce the problem, perfor=
m
> > the following steps:
> > (1)tc qdisc add dev eth0 root handle 1: htb default 30 \n
> > (2)tc filter add dev eth2 protocol ip prio 2 flower verbose \
> >      action police rate 100mbit burst 12m conform-exceed jump 1 \
> >      / pipe mirred egress redirect dev eth2 action drop
> >
>
> I think you meant both to be the same device eth0 or eth2?
>
> > The stack is show as below:
> > [28848.883915]  _raw_spin_lock+0x1e/0x30
> > [28848.884367]  __dev_queue_xmit+0x160/0x850
> > [28848.884851]  ? 0xffffffffc031906a
> > [28848.885279]  tcf_mirred_act+0x3ab/0x596 [act_mirred]
> > [28848.885863]  tcf_action_exec.part.0+0x88/0x130
> > [28848.886401]  fl_classify+0x1ca/0x1e0 [cls_flower]
> > [28848.886970]  ? dequeue_entity+0x145/0x9e0
> > [28848.887464]  ? newidle_balance+0x23f/0x2f0
> > [28848.887973]  ? nft_lookup_eval+0x57/0x170 [nf_tables]
> > [28848.888566]  ? nft_do_chain+0xef/0x430 [nf_tables]
> > [28848.889137]  ? __flush_work.isra.0+0x35/0x80
> > [28848.889657]  ? nf_ct_get_tuple+0x1cf/0x210 [nf_conntrack]
> > [28848.890293]  ? do_select+0x637/0x870
> > [28848.890735]  tcf_classify+0x52/0xf0
> > [28848.891177]  htb_classify+0x9d/0x1c0 [sch_htb]
> > [28848.891722]  htb_enqueue+0x3a/0x1c0 [sch_htb]
> > [28848.892251]  __dev_queue_xmit+0x2d8/0x850
> > [28848.892738]  ? nf_hook_slow+0x3c/0xb0
> > [28848.893198]  ip_finish_output2+0x272/0x580
> > [28848.893692]  __ip_queue_xmit+0x193/0x420
> > [28848.894179]  __tcp_transmit_skb+0x8cc/0x970
> >
> > In this case, the process has hold the qdisc spin lock in __dev_queue_x=
mit
> > before the egress packets are mirred, and it will attempt to obtain the
> > spin lock again after packets are mirred, which cause a deadlock.
> >
> > Fix the issue by forbidding assigning mirred action to a filter attache=
d
> > to the egress.
> >
> > Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>
> > ---
> >  net/sched/act_mirred.c                        |  4 +++
> >  .../tc-testing/tc-tests/actions/mirred.json   | 32 +++++++++++++++++++
> >  2 files changed, 36 insertions(+)
> >
> > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > index 5b3814365924..fc96705285fb 100644
> > --- a/net/sched/act_mirred.c
> > +++ b/net/sched/act_mirred.c
> > @@ -120,6 +120,10 @@ static int tcf_mirred_init(struct net *net, struct=
 nlattr *nla,
> >                 NL_SET_ERR_MSG_MOD(extack, "Mirred requires attributes =
to be passed");
> >                 return -EINVAL;
> >         }
> > +       if (tp->chain->block->q->parent !=3D TC_H_INGRESS) {
> > +               NL_SET_ERR_MSG_MOD(extack, "Mirred can only be assigned=
 to the filter attached to ingress");
> > +               return -EINVAL;
> > +       }
>
> Sorry, this is too restrictive as Jiri said. We'll try to reproduce. I
> am almost certain this used to work in the old days.

Ok, i looked at old notes - it did work at "some point" pre-tdc.
Conclusion is things broke around this time frame:
https://lore.kernel.org/netdev/1431679850-31896-1-git-send-email-fw@strlen.=
de/
https://lore.kernel.org/netdev/1465095748.2968.45.camel@edumazet-glaptop3.r=
oam.corp.google.com/

Looking further into it.

cheers,
jamal

