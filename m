Return-Path: <netdev+bounces-80192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337E987D6AB
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 23:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D64A1C20F36
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 22:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94855179AB;
	Fri, 15 Mar 2024 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="CISRMvFt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0045E101E6
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710542086; cv=none; b=HXtIR4j+iEYSGfxtymJT1R1cB/GWLutEUh3FJ1Ufe2lAdQmLSSmIBZ/wfFEShFkotHv9Oht8iuH4vPirYQsvYXDQMZfPtfDGr5RVcEIGmO7sRRyOKcbHyR8Pgg5VNFukdW15l3dUwdl9wAgbWOQBYC+ppsPtYhRrLc1dIptJgJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710542086; c=relaxed/simple;
	bh=FcrjpD6vrHKlbUPdoi6hB0T/+kl3ir3DShVVAqXWIN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L47bQ3YOOt2uU6QwV3bZznuB2gPwhtT53NXdkMadagseFYjU1a+KDP4qwZXnFuYDew8VLi7KHfhN8N0PgjCbhBA/BlDFUxTzjXSJtcn4qlX4XKwHZYsYTvAKg0UxLKGyueKKR55XYbLUUuEfelAvza9PyH/fAAPHRm0q17APzeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=CISRMvFt; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60a0599f6e5so24633157b3.3
        for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1710542082; x=1711146882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPSUThE/VPaHSlHDvAIizne93hl3enhN5ts/grlrcOI=;
        b=CISRMvFtxtVX9OfINVeXJVt4Sb/n+74HtWB4TzU8OAit9okkLHOChMKGmdVAszGrAf
         Kyl0PQCWFxZDZnpwtOLSrX/nUmc+3TLRcHc3Asy6lTSDqT5u0fAqHi7PbuzGaO5uruEa
         pTZxSvHCqfHCbcu8dDRYApSLRJebzvDreC/rF3GvwIhx7D1R1eF6CQNJxiRnVKjcMItO
         elVUx0AoF1PY/brS+qu0UZtSvRAE1i4sy2aWcl+zwZwwcLrxyFojrtNfUh8kf5y2beps
         SMGe+sGpyh44tFviPLQo8qrxmFdkYmElNW15jHdNJwRNw9ObOuuwyknMuXRN8Zpk6FeS
         YL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710542082; x=1711146882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPSUThE/VPaHSlHDvAIizne93hl3enhN5ts/grlrcOI=;
        b=nnecM7/0sT4fs9KQooHw6THImyiRvbPBQUsHCsiWVcDuc08JiddaARCjkVnexT5NtL
         kwYmMlq+bQAP0iSTIFoajbbkBVzjF0PyaSmJt9uVn2HvpIck/CDm8sDSQNTfFJd9ctlF
         4aS7yGgpCR3D1ng80nMcom5c2/5D1Nr3c/SOgat3kMFZxhy8jwONTcWoLHLVzTMF0fwq
         HcvqDTYeea8XaeauRohvhjeW6Xv0MFatyvX5ZtxZyPWBTG+z9rcgGR3ZCM0vQON3l3xx
         jAhgtFA8T5hR8NmgE5eI5S7oyWM8AUdOKDieHCjtTQb95DHvKvdAaKm2NAbZ9MB5HDVp
         IXRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfAPuWgrBU1pf3f8bRTBmcA7d8OfNmCMakf7VOiX5hMdgElgcd/voq/pL1jn0LxjOcxfzGHnI8XPIrA5He9ZDfo4CmPp3q
X-Gm-Message-State: AOJu0YzBEx4Bngc0KYAdZCsH2kZHErCdcHfudVQF5tJdJq6O2I5ZlGob
	pdFgTzF0bT0iQwynZTXj/CF3aO8Ihmx3JMEweYoUGQ0OYm5fDDvYrMEu8JuPWzA+G4s5vhmzreg
	LmGGls1ign2Elq03Nyuj9M/ooOomml7S+8uuB
X-Google-Smtp-Source: AGHT+IEiWKhRrtUX+Q514oMaLSccoeP+STAZhmb1/jGdF7ub4CTINcJjHT0RV0wRWltmwK6/p9ki7tRxkbdO56uqWK0=
X-Received: by 2002:a0d:d0c1:0:b0:60a:379d:2bb8 with SMTP id
 s184-20020a0dd0c1000000b0060a379d2bb8mr4759361ywd.35.1710542081939; Fri, 15
 Mar 2024 15:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMmqVHGC4_YVHj=rUPj+XBS_N99rCKk1S7wCi1wJ8__Pyw@mail.gmail.com>
 <20240315015645.4851-1-renmingshuai@huawei.com>
In-Reply-To: <20240315015645.4851-1-renmingshuai@huawei.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 15 Mar 2024 18:34:30 -0400
Message-ID: <CAM0EoMm5vCmtQ8CS4zRZX3QDfB9zoEYZC_CDHO_tHug-okXHhQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter
 attached to the egress
To: renmingshuai <renmingshuai@huawei.com>
Cc: caowangbao@huawei.com, davem@davemloft.net, jiri@resnulli.us, 
	liaichun@huawei.com, netdev@vger.kernel.org, vladbu@nvidia.com, 
	xiyou.wangcong@gmail.com, yanan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:10=E2=80=AFPM renmingshuai <renmingshuai@huawei.=
com> wrote:
>
> >> As we all know the mirred action is used to mirroring or redirecting t=
he
> >> packet it receives. Howerver, add mirred action to a filter attached t=
o
> >> a egress qdisc might cause a deadlock. To reproduce the problem, perfo=
rm
> >> the following steps:
> >> (1)tc qdisc add dev eth0 root handle 1: htb default 30 \n
> >> (2)tc filter add dev eth2 protocol ip prio 2 flower verbose \
> >>      action police rate 100mbit burst 12m conform-exceed jump 1 \
> >>      / pipe mirred egress redirect dev eth2 action drop
> >>
> >
> >I think you meant both to be the same device eth0 or eth2?
>
> Sorry, a careless mistake. eth2 in step 2 should be eth0.
> (2)tc filter add dev eth0 protocol ip prio 2 flower verbose \
>      action police rate 100mbit burst 12m conform-exceed jump 1 \
>      / pipe mirred egress redirect dev eth0 action drop
>
> >> The stack is show as below:
> >> [28848.883915]  _raw_spin_lock+0x1e/0x30
> >> [28848.884367]  __dev_queue_xmit+0x160/0x850
> >> [28848.884851]  ? 0xffffffffc031906a
> >> [28848.885279]  tcf_mirred_act+0x3ab/0x596 [act_mirred]
> >> [28848.885863]  tcf_action_exec.part.0+0x88/0x130
> >> [28848.886401]  fl_classify+0x1ca/0x1e0 [cls_flower]
> >> [28848.886970]  ? dequeue_entity+0x145/0x9e0
> >> [28848.887464]  ? newidle_balance+0x23f/0x2f0
> >> [28848.887973]  ? nft_lookup_eval+0x57/0x170 [nf_tables]
> >> [28848.888566]  ? nft_do_chain+0xef/0x430 [nf_tables]
> >> [28848.889137]  ? __flush_work.isra.0+0x35/0x80
> >> [28848.889657]  ? nf_ct_get_tuple+0x1cf/0x210 [nf_conntrack]
> >> [28848.890293]  ? do_select+0x637/0x870
> >> [28848.890735]  tcf_classify+0x52/0xf0
> >> [28848.891177]  htb_classify+0x9d/0x1c0 [sch_htb]
> >> [28848.891722]  htb_enqueue+0x3a/0x1c0 [sch_htb]
> >> [28848.892251]  __dev_queue_xmit+0x2d8/0x850
> >> [28848.892738]  ? nf_hook_slow+0x3c/0xb0
> >> [28848.893198]  ip_finish_output2+0x272/0x580
> >> [28848.893692]  __ip_queue_xmit+0x193/0x420
> >> [28848.894179]  __tcp_transmit_skb+0x8cc/0x970
> >>
> >> In this case, the process has hold the qdisc spin lock in __dev_queue_=
xmit
> >> before the egress packets are mirred, and it will attempt to obtain th=
e
> >> spin lock again after packets are mirred, which cause a deadlock.
> >>
> >> Fix the issue by forbidding assigning mirred action to a filter attach=
ed
> >> to the egress.
> >>
> >> Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>
> >> ---
> >>  net/sched/act_mirred.c                        |  4 +++
> >>  .../tc-testing/tc-tests/actions/mirred.json   | 32 ++++++++++++++++++=
+
> >>  2 files changed, 36 insertions(+)
> >>
> >> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> >> index 5b3814365924..fc96705285fb 100644
> >> --- a/net/sched/act_mirred.c
> >> +++ b/net/sched/act_mirred.c
> >> @@ -120,6 +120,10 @@ static int tcf_mirred_init(struct net *net, struc=
t nlattr *nla,
> >>                 NL_SET_ERR_MSG_MOD(extack, "Mirred requires attributes=
 to be passed");
> >>                 return -EINVAL;
> >>         }
> >> +       if (tp->chain->block->q->parent !=3D TC_H_INGRESS) {
> >> +               NL_SET_ERR_MSG_MOD(extack, "Mirred can only be assigne=
d to the filter attached to ingress");
> >> +               return -EINVAL;
> >> +       }
> >
> >Sorry, this is too restrictive as Jiri said. We'll try to reproduce. I
> >am almost certain this used to work in the old days.
> >

> >cheers,
> >jamal
> >
> >PS:- thanks for the tdc test, you are a hero just for submitting that!
>
> As Jiri said, that is really quite restrictive. It might be better to for=
bid mirred attached to egress filter
> to mirror or redirect packets to the egress. Just like:
>

Please, no. You are continuing to restrict many valid use cases. We'll
look at it this weekend.

cheers,
jamal

> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -152,6 +152,12 @@ static int tcf_mirred_init(struct net *net, struct n=
lattr *nla,
>                 return -EINVAL;
>         }
>
> +       if ((tp->chain->block->q->parent !=3D TC_H_INGRESS) &&
> +           (parm->eaction =3D=3D TCA_EGRESS_MIRROR || parm->eaction =3D=
=3D TCA_EGRESS_REDIR)) {
> +               NL_SET_ERR_MSG_MOD(extack, "Mirred assigned to egress fil=
ter can only mirror or redirect to ingress");
> +               return -EINVAL;
> +       }
> +
>         switch (parm->eaction) {
>         case TCA_EGRESS_MIRROR:
>         case TCA_EGRESS_REDIR:
>

