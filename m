Return-Path: <netdev+bounces-143518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CC49C2D6A
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 13:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89431C20D85
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 12:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBC61448F2;
	Sat,  9 Nov 2024 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="2pgOJCXW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C7422083
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731156667; cv=none; b=u5C/+QygudvSZsQ7hFkV1EbF6HbIxl3fIx1rLuZA+GT5nMtKsZa7PXdqvfmWBo9fzgAzrOcE4jivGDIKMmI8BkCpocQlKtZpJPGL8TotHwYHhdpYz7/dUM44kd4qw/xAGXgfefm8JclT9zvyA3zimlJTsg9MDSOOFATpTOUET2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731156667; c=relaxed/simple;
	bh=m64QaKUaZTxnkgelxWu20m5n+dkYOuC3Bv9wYe7Iggk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9PzcihsP0ZY1+pW0qpGAAEISagpBfn3dQeKQun0rCr7W9/+sPueKUskNPQzCXGa5a1Ws5aZZcFRydUbIVfJRDTsu8aSTH+21/DCmMUtxvJy4QXSA5etfI2X29MJEXxivtu6PWSu7dSB/cefDxQ5o9xPen7BxdqKQfXRUwkPUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=2pgOJCXW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7eda47b7343so2142191a12.0
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 04:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1731156664; x=1731761464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hjoy55EqLsAxv2ynvUHo4RLIRWtSzWG06eaGN7V8d1A=;
        b=2pgOJCXW/SqBRQbb97aH+B6+3jleTFIeX0Yiw9Giqspe5FNoPc/hT3ULUFTLN4b+pA
         5hWFG/LCNsUvFfYFdHRShjvPFeA9EcLhGICS1CRa03rFyyCMKnNIuBOZYCClFRNpT5sJ
         8/y9id/edEDXP+aQeIRm9latwRlKquPMqX+EuPhFbjBx00q0tOF23gO88b9gYKfTuKJm
         H1E1+RnxsF5mx53jaO2KwGDsu6vOAssdtB1dyGOCSbjDkP6q7qovzPnuS2OjpPCV57Lc
         t5Xtp4nLOfrrjynxMyKluD+XL44f087f8QCcL4kZc+TTqtW8/1SG0bTvoTe2qyN8Tbj/
         eCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731156664; x=1731761464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hjoy55EqLsAxv2ynvUHo4RLIRWtSzWG06eaGN7V8d1A=;
        b=rvC2n0nJoG4p+JVhitnpnbOq648DD8NYImNAKvtnfr47TtVcC+VXq5WHj/cd4G0t+M
         XNUN9lYby+e+uOq4qk4yxbD6msRUir029j7sNHvf8NwSL4Ee2JssWm/4l1t4vqVt6pu2
         FRgfOJYrKZrhZJtAyt8Fpd6e1ETBhXdByjJoMlugjGowzmERZRd/UMgdFv/kRDGOwxyO
         +UM5Jpg8nWIdZtWKJtZtxnJ1nP5qIIAz1LmBaTt5RWqoMPxNX5POvZU9DDmR/MWrMIbM
         8FJmAXL/IKRR4T3SObEHbiD4teaXbnXEb236kfiPGIi8lJgitWGj29GxRKX0Wkg1Z19q
         GzfA==
X-Forwarded-Encrypted: i=1; AJvYcCWFoD6G52LI7MZDFMDd4+0u+GLTerU0TrnEDLxVyiEPYvm0s71hJSNWzRQA/LQ/7UtKi076fTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/hNVOW0eLXLKTD2GDE/b4Tb8duGf8muUvVPJr1lTRECvuma/
	HREzO5EH5ypUwMhzNYXnDW4ZFxa0CB9mbEZe9EiilB7ManX9OwaZ41GXFYb2DlOrR1vLY87VL7m
	wLLchxj7kruz7x1JhjHbVhuGfVNFf70ix96/W
X-Google-Smtp-Source: AGHT+IE20cuBS5IHS5bvoMYITbK/4r3hNwxvefgmOE3HTluxmbdsqN01uJtK5pb/+dxVJPgPiQ8EktkLb6TyoxAubwc=
X-Received: by 2002:a17:90b:3c8f:b0:2e2:ac13:6f7 with SMTP id
 98e67ed59e1d1-2e9b16f0fffmr8888372a91.4.1731156664413; Sat, 09 Nov 2024
 04:51:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108141159.305966-1-alexandre.ferrieux@orange.com>
In-Reply-To: <20241108141159.305966-1-alexandre.ferrieux@orange.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 9 Nov 2024 07:50:53 -0500
Message-ID: <CAM0EoMn+7tntXK10eT5twh6Bc62Gx2tE+3beVY99h6EMnFs6AQ@mail.gmail.com>
Subject: Re: [PATCH net v6] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, alexandre.ferrieux@orange.com, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 9:12=E2=80=AFAM Alexandre Ferrieux
<alexandre.ferrieux@gmail.com> wrote:
>
> To generate hnode handles (in gen_new_htid()), u32 uses IDR and
> encodes the returned small integer into a structured 32-bit
> word. Unfortunately, at disposal time, the needed decoding
> is not done. As a result, idr_remove() fails, and the IDR
> fills up. Since its size is 2048, the following script ends up
> with "Filter already exists":
>
>   tc filter add dev myve $FILTER1
>   tc filter add dev myve $FILTER2
>   for i in {1..2048}
>   do
>     echo $i
>     tc filter del dev myve $FILTER2
>     tc filter add dev myve $FILTER2
>   done
>
> This patch adds the missing decoding logic for handles that
> deserve it, along with a corresponding tdc test.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>


Ok, looks good.
Please split the test into a separate patch targeting net-next. Also
your "Fixes" should be:
commit e7614370d6f04711c4e4b48f7055e5008fa4ed42
When you send the next version please include my Acked-by:

cheers,
jamal

> ---
> v6: big speedup of the tdc test with batch tc
> v5: fix title - again
> v4: add tdc test
> v3: prepend title with subsystem ident
> v2: use u32 type in handle encoder/decoder
>
>  net/sched/cls_u32.c                           | 18 ++++++++++----
>  .../tc-testing/tc-tests/filters/u32.json      | 24 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 9412d88a99bc..6da94b809926 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -41,6 +41,16 @@
>  #include <linux/idr.h>
>  #include <net/tc_wrapper.h>
>
> +static inline u32 handle2id(u32 h)
> +{
> +       return ((h & 0x80000000) ? ((h >> 20) & 0x7FF) : h);
> +}
> +
> +static inline u32 id2handle(u32 id)
> +{
> +       return (id | 0x800U) << 20;
> +}
> +
>  struct tc_u_knode {
>         struct tc_u_knode __rcu *next;
>         u32                     handle;
> @@ -310,7 +320,7 @@ static u32 gen_new_htid(struct tc_u_common *tp_c, str=
uct tc_u_hnode *ptr)
>         int id =3D idr_alloc_cyclic(&tp_c->handle_idr, ptr, 1, 0x7FF, GFP=
_KERNEL);
>         if (id < 0)
>                 return 0;
> -       return (id | 0x800U) << 20;
> +       return id2handle(id);
>  }
>
>  static struct hlist_head *tc_u_common_hash;
> @@ -360,7 +370,7 @@ static int u32_init(struct tcf_proto *tp)
>                 return -ENOBUFS;
>
>         refcount_set(&root_ht->refcnt, 1);
> -       root_ht->handle =3D tp_c ? gen_new_htid(tp_c, root_ht) : 0x800000=
00;
> +       root_ht->handle =3D tp_c ? gen_new_htid(tp_c, root_ht) : id2handl=
e(0);
>         root_ht->prio =3D tp->prio;
>         root_ht->is_root =3D true;
>         idr_init(&root_ht->handle_idr);
> @@ -612,7 +622,7 @@ static int u32_destroy_hnode(struct tcf_proto *tp, st=
ruct tc_u_hnode *ht,
>                 if (phn =3D=3D ht) {
>                         u32_clear_hw_hnode(tp, ht, extack);
>                         idr_destroy(&ht->handle_idr);
> -                       idr_remove(&tp_c->handle_idr, ht->handle);
> +                       idr_remove(&tp_c->handle_idr, handle2id(ht->handl=
e));
>                         RCU_INIT_POINTER(*hn, ht->next);
>                         kfree_rcu(ht, rcu);
>                         return 0;
> @@ -989,7 +999,7 @@ static int u32_change(struct net *net, struct sk_buff=
 *in_skb,
>
>                 err =3D u32_replace_hw_hnode(tp, ht, userflags, extack);
>                 if (err) {
> -                       idr_remove(&tp_c->handle_idr, handle);
> +                       idr_remove(&tp_c->handle_idr, handle2id(handle));
>                         kfree(ht);
>                         return err;
>                 }
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json=
 b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> index 24bd0c2a3014..b2ca9d4e991b 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> @@ -329,5 +329,29 @@
>          "teardown": [
>              "$TC qdisc del dev $DEV1 parent root drr"
>          ]
> +    },
> +    {
> +        "id": "1234",
> +        "name": "Exercise IDR leaks by creating/deleting a filter many (=
2048) times",
> +        "category": [
> +            "filter",
> +            "u32"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$TC qdisc add dev $DEV1 parent root handle 10: drr",
> +            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 u32=
 match ip src 0.0.0.2/32 action drop",
> +            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 3 u32=
 match ip src 0.0.0.3/32 action drop"
> +        ],
> +        "cmdUnderTest": "bash -c 'for i in {1..2048} ;do echo filter del=
ete dev $DEV1 pref 3;echo filter add dev $DEV1 parent 10:0 protocol ip prio=
 3 u32 match ip src 0.0.0.3/32 action drop;done | $TC -b -'",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC filter show dev $DEV1",
> +        "matchPattern": "protocol ip pref 3 u32",
> +        "matchCount": "3",
> +        "teardown": [
> +            "$TC qdisc del dev $DEV1 parent root drr"
> +        ]
>      }
>  ]
> --
> 2.30.2
>

