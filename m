Return-Path: <netdev+bounces-79932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF99887C1F0
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 18:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834AF282C7D
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 17:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3295D6FE10;
	Thu, 14 Mar 2024 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="254VjyGl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B874434
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436509; cv=none; b=VrBBuX8zQUdtRtVxmdqz72Urjg7b1XHgctUmSQKS1DCaQKd68njgjxhT8R15NHrwMWFH98JEJImnf5FdzOAKzEmFcqpf3k7lSL7iZ5WDQoTDvk1jdBOaDbIjth+30qubmLWmo5WqDOTHMsi+N8ppaSq9X7MsOUJu3BcbNZuadQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436509; c=relaxed/simple;
	bh=uLtV39/rPAialp/Aebz9EnHq7/GIHQxyduW9QvotHW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRY7XIjJP9nkQA2OpvkB0ZI6MIYbxLaEPhRlNH01QDH/NcO2iLyp8860WoA528FFBY8b5cB+X9MHow1qlqpcfXj0j+V6RhaY7rp2LdA68Uc7NvF035BhAoefKY1NfA6XQO0sUv1Cf6a7A/QJNPg/v6wRELtW3DZzIy4HNAxqJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=254VjyGl; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60cc4124a39so12081797b3.3
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1710436505; x=1711041305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxMrKw7HjXsBS7vMedoL9HdNARYspR60YCEBH2wMvow=;
        b=254VjyGl5LGmwW0FSUI+AoEUg+l44pYX2vGJNelyCu/DYynUOMAhAfKwpMOUclHBfm
         QMVzQtY/4Yb/UOdDYcOsYMaiz/bL7Nlz8VUq5ssvGI+qUKsZ8VQf9QLJDpxTyvqfT81G
         xswntooB02B1yMwwfW0oJE/im72ujV3ieMIS0zzIoi2VnHIvXrfj1NhXReOPhMrm3aZH
         fmdbfxWxcGs66t9KwlBHapZTgvjKgbIesdXBrEzGACDy833TfC3YfIfRcK8yGXQsWiim
         hWP2zPfW4LSJ2cpOx00D8RsWB1vxilAgEKAd0Ol8P393CrtUXviKOEQentQWB0HmKbyo
         TtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710436505; x=1711041305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxMrKw7HjXsBS7vMedoL9HdNARYspR60YCEBH2wMvow=;
        b=X9+xFCHcnFZ5lvnhFvgflIIpb1G818pLl75gZHVfsX679JhLNKrnb4AJds3aqhGBHf
         pfLquH8TypMfOzkzpEA0yTbQWvpiCecVyN6DdWvNbXYD+HEL/BVsI2uSbOoiqWAYPKKG
         I0fRB9wPzc6lBpeo9CTknt4xhaY21J/1sqPTtcagnw93erq2oOa96WQixpsy9+Ax5Rj2
         lNdiTTNac1V4w3gYKjnncVp7MwCnhKzggg9orSBBxT4jsVhJ/fhIn9EoxsPxgSdqq+2v
         gD5Wp/aEL9ed572Rbvr7hQICdi5ES1GnhxJJP3Y+CbboFdNxPSPokwI5CZx+UU7s94Cg
         eP+w==
X-Forwarded-Encrypted: i=1; AJvYcCU1vRmb9ZujjUVAkrl9qo0863dXVn1n3E/X7PchdxnNNBQGFnnUmVkONcvXPc9eLhDdjYDCvjSQ8m8N54YkqFgTHfjz0TfX
X-Gm-Message-State: AOJu0Yyeq4v/hIUSzo0hVi2D78Goc/EvK0fLVx0fHaQ4iUS0kc1DvCKE
	4zXu8GMkISe5oMjTYfgwNR89HXowCJAy6nTCbXrNYlykketZzBtbCA754OgNBkd8JsPnw12u59Q
	+WugGlfLRfOELotloxkzRtg5X/TcIBXXtOGje
X-Google-Smtp-Source: AGHT+IHfntwb1Rep3hKpuHeorwfeDuvandCXfIwA3yaASZP42Rf4i1rg90Q+iJUlETSiXuNXIqGxMqUvx7ClOCQh+h4=
X-Received: by 2002:a0d:e286:0:b0:609:33dd:c63f with SMTP id
 l128-20020a0de286000000b0060933ddc63fmr2287933ywe.34.1710436505663; Thu, 14
 Mar 2024 10:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314111713.5979-1-renmingshuai@huawei.com>
In-Reply-To: <20240314111713.5979-1-renmingshuai@huawei.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 14 Mar 2024 13:14:54 -0400
Message-ID: <CAM0EoMmqVHGC4_YVHj=rUPj+XBS_N99rCKk1S7wCi1wJ8__Pyw@mail.gmail.com>
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter
 attached to the egress
To: renmingshuai <renmingshuai@huawei.com>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	vladbu@nvidia.com, netdev@vger.kernel.org, yanan@huawei.com, 
	liaichun@huawei.com, caowangbao@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 7:18=E2=80=AFAM renmingshuai <renmingshuai@huawei.c=
om> wrote:
>
> As we all know the mirred action is used to mirroring or redirecting the
> packet it receives. Howerver, add mirred action to a filter attached to
> a egress qdisc might cause a deadlock. To reproduce the problem, perform
> the following steps:
> (1)tc qdisc add dev eth0 root handle 1: htb default 30 \n
> (2)tc filter add dev eth2 protocol ip prio 2 flower verbose \
>      action police rate 100mbit burst 12m conform-exceed jump 1 \
>      / pipe mirred egress redirect dev eth2 action drop
>

I think you meant both to be the same device eth0 or eth2?

> The stack is show as below:
> [28848.883915]  _raw_spin_lock+0x1e/0x30
> [28848.884367]  __dev_queue_xmit+0x160/0x850
> [28848.884851]  ? 0xffffffffc031906a
> [28848.885279]  tcf_mirred_act+0x3ab/0x596 [act_mirred]
> [28848.885863]  tcf_action_exec.part.0+0x88/0x130
> [28848.886401]  fl_classify+0x1ca/0x1e0 [cls_flower]
> [28848.886970]  ? dequeue_entity+0x145/0x9e0
> [28848.887464]  ? newidle_balance+0x23f/0x2f0
> [28848.887973]  ? nft_lookup_eval+0x57/0x170 [nf_tables]
> [28848.888566]  ? nft_do_chain+0xef/0x430 [nf_tables]
> [28848.889137]  ? __flush_work.isra.0+0x35/0x80
> [28848.889657]  ? nf_ct_get_tuple+0x1cf/0x210 [nf_conntrack]
> [28848.890293]  ? do_select+0x637/0x870
> [28848.890735]  tcf_classify+0x52/0xf0
> [28848.891177]  htb_classify+0x9d/0x1c0 [sch_htb]
> [28848.891722]  htb_enqueue+0x3a/0x1c0 [sch_htb]
> [28848.892251]  __dev_queue_xmit+0x2d8/0x850
> [28848.892738]  ? nf_hook_slow+0x3c/0xb0
> [28848.893198]  ip_finish_output2+0x272/0x580
> [28848.893692]  __ip_queue_xmit+0x193/0x420
> [28848.894179]  __tcp_transmit_skb+0x8cc/0x970
>
> In this case, the process has hold the qdisc spin lock in __dev_queue_xmi=
t
> before the egress packets are mirred, and it will attempt to obtain the
> spin lock again after packets are mirred, which cause a deadlock.
>
> Fix the issue by forbidding assigning mirred action to a filter attached
> to the egress.
>
> Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>
> ---
>  net/sched/act_mirred.c                        |  4 +++
>  .../tc-testing/tc-tests/actions/mirred.json   | 32 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 5b3814365924..fc96705285fb 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -120,6 +120,10 @@ static int tcf_mirred_init(struct net *net, struct n=
lattr *nla,
>                 NL_SET_ERR_MSG_MOD(extack, "Mirred requires attributes to=
 be passed");
>                 return -EINVAL;
>         }
> +       if (tp->chain->block->q->parent !=3D TC_H_INGRESS) {
> +               NL_SET_ERR_MSG_MOD(extack, "Mirred can only be assigned t=
o the filter attached to ingress");
> +               return -EINVAL;
> +       }

Sorry, this is too restrictive as Jiri said. We'll try to reproduce. I
am almost certain this used to work in the old days.

cheers,
jamal

PS:- thanks for the tdc test, you are a hero just for submitting that!



>         ret =3D nla_parse_nested_deprecated(tb, TCA_MIRRED_MAX, nla,
>                                           mirred_policy, extack);
>         if (ret < 0)
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.j=
son b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
> index b73bd255ea36..50c6153bf34c 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
> @@ -1052,5 +1052,37 @@
>              "$TC qdisc del dev $DEV1 ingress_block 21 clsact",
>              "$TC actions flush action mirred"
>          ]
> +    },
> +    {
> +        "id": "fdda",
> +        "name": "Add mirred mirror to the filter which attached to engre=
ss",
> +        "category": [
> +            "actions",
> +            "mirred"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            [
> +                "$TC actions flush action mirred",
> +                0,
> +                1,
> +                255
> +            ],
> +            [
> +                "$TC qdisc add dev $DEV1 root handle 1: htb default 1",
> +                0
> +            ]
> +        ],
> +        "cmdUnderTest": "$TC filter add dev $DEV1 protocol ip u32 match =
ip protocol 1 0xff action mirred egress mirror dev $DEV1",
> +        "expExitCode": "2",
> +        "verifyCmd": "$TC action list action mirred",
> +        "matchPattern": "^[ \t]+index [0-9]+ ref",
> +        "matchCount": "0",
> +        "teardown": [
> +            "$TC qdisc del dev $DEV1 root handle 1: htb default 1",
> +            "$TC actions flush action mirred"
> +        ]
>      }
>  ]
> --
> 2.33.0
>

