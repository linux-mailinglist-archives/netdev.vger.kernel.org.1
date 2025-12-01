Return-Path: <netdev+bounces-243038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495CC98A15
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 18:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBCB3A4391
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 17:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84353385B9;
	Mon,  1 Dec 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4IUtPHX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F0B335BAA
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611844; cv=none; b=VgffhxW93ZRdyAFmBRC5P7Y6I9FN9hNioo+KnjdEzH7Rxj+kUSAQTc0WV32iuYuHLLCCqifMV8ouPKtY3wCr8zb+7jQReo+BPGqmShYk7px8/LvxEmWc32yk69aykBEtFxt1lY1OnmH5VEy3VH0DfBrdVv+XsJmyY9IXMrhGUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611844; c=relaxed/simple;
	bh=c4usMbBj3/G86A0FdsSpAon/EhuYcqKwiGhrgdLC5zs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=q+u+BHcw4KZoyQdnMPtZ0yCJ5euNsHWO60R8JT0UbD1uWed2wYzm3UgmZXBiySQ6MFgA/by5h+pa8hIiaBSqF0/qaAQspegQ3+k5zg/kEuNX23gtR4KJNuXYi4o8GoPtj3X/n2ifnyjQG9thzE0kiUSVSiPBAxCq2rkYN0K/ohQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4IUtPHX; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-787e7aa1631so56028197b3.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 09:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764611842; x=1765216642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkqmpx35EBVYyHz+sYsqNnuEOUKwB0sqoFFtTjdVi3U=;
        b=D4IUtPHX3vd97uc16dyLGDG9nmtNR/KA0daJIPl3EMNH8tN+1HUAUtSOI9XqEnGCBm
         ulU5y9il/1Hc1MaXclJcU180ym34lezPO+pNK2kPGHnwdkFNp3yVLdNh7CfWR6pVYMwx
         oYxqYxcG4kHGuGDi91c4jeV7SE/t/O3HElgDS8Ae3e/LZhYydI0JM0UaFxE9SWXmS7am
         kwjnasUY4r9sAi7QXj9bd/hR8jlwwwsl5v9+BteR1IdIk7K7r1CB5/f25ieQ7tkJa2Zz
         2cyo5/KMVVOkURp70rGAP9tM/ih/ykFu9zjF8A3zscuNXJ5XrAJomK5oeITv46cRN311
         qcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764611842; x=1765216642;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkqmpx35EBVYyHz+sYsqNnuEOUKwB0sqoFFtTjdVi3U=;
        b=oDCADOIflWbkoVgf1flmmy/DpqAvGAuKcgUDrjDI7R65cDsjUBrOAGNlyvx8wFlSvJ
         mCp0SOGxAk31Oni6i0NVVm8JXGfDcAG2ne+3g5dqt+fcbiSj56HTUcbB4rzyJAjVmaNy
         CCnAXxe5XJeUQZZSHDW4wvsdfEl4tpqY3p91dakqXMvHjOwfQHu0hchWVaHP/a4bZLAf
         2onZh2OnngzYiKhVGkN4lSie/k/SW8s1PWPr6lxP59O3WTayb73EyeYf++sz3f2NBbBA
         KP8KEXSvWCnU90m+ykALHrrbeGRxUlZrehxlXNZA4KVItYqgBUivN4l3BohSWnj57Oq1
         heNw==
X-Forwarded-Encrypted: i=1; AJvYcCVzBBhKAAqiDvo566qCjJSa42owvZ1eNNKpbIzZTwF48gL0xJmidCv/fvTY+RWrma4KmJb4bKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkgRLIh5bXoqExzJpWCckIhSjjvs4FAAHg8Aa891/QYFEapSJU
	/clOphGUoFZI6xi0ZTVKJvfRPFqmNbF8SKhq81cmMKDfSEa0XSMZyvxd
X-Gm-Gg: ASbGncujAGksoOfB4LFM/bz3j3r4FwSyWE4roY0watfjAm1/evFTLtSPmypPoSjHLpT
	eeMtrb/veT8GSIrXVMGk7xfDCLBBLbvKt3e0Nm4h+OUpy9lXy7FqxxOJY3ttBHPAUJ9e/T4T3VG
	w/uQV04M30/cavzwvUxn32D73qjWeHQ/0rQL14HNU86ZlEeyc97tFMAArS9X+Osz+H/GDBwyehw
	P1Y1za3iCZHv4Hb6cqJjgFPIvOYpIIarwGke6AT0B3xgK+xSAMVdQl9UI9dnN5EAm1kj/wP39UE
	ARFwSis4L/rmlvTwrTHnIBtP6f9nibLIhD458q1LJCT9vGxI5hx+uvdhlowN+L16EzXkH+qr1Tp
	gF9mCSJtYpSKTt9JCYX8yq0Hd97ckqrxueuxGwtJImlXqw/d20RwRUHUpvffYPEutX6bos8cD3S
	r8UgdKy9sNyehlXWxToEDE9kogYyrPpyfnCgcAK9HAdsz9BGK11Hc2DWFI2z29vk88/j0=
X-Google-Smtp-Source: AGHT+IHtwRV3z+eEprkjPN1JlQVtx9G4JjRCbnGZDpI5VxqHcgiCtPJziT1NzvZ10SNonlVHTRvkuA==
X-Received: by 2002:a05:690e:429c:10b0:63f:96d7:a369 with SMTP id 956f58d0204a3-643026257f4mr28216730d50.28.1764611841786;
        Mon, 01 Dec 2025 09:57:21 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6433bf5f366sm5191475d50.0.2025.12.01.09.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 09:57:20 -0800 (PST)
Date: Mon, 01 Dec 2025 12:57:20 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: =?UTF-8?B?Sm9uYXMgS8O2cHBlbGVy?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, 
 netdev@vger.kernel.org, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Message-ID: <willemdebruijn.kernel.1b99d2d13dcba@gmail.com>
In-Reply-To: <20251130-mq-cake-sub-qdisc-v3-1-5f66c548ecdc@redhat.com>
References: <20251130-mq-cake-sub-qdisc-v3-0-5f66c548ecdc@redhat.com>
 <20251130-mq-cake-sub-qdisc-v3-1-5f66c548ecdc@redhat.com>
Subject: Re: [PATCH net-next v3 1/5] net/sched: Export mq functions for reuse
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> To enable the cake_mq qdisc to reuse code from the mq qdisc, export a
> bunch of functions from sch_mq. Split common functionality out from som=
e
> functions so it can be composed with other code, and export other
> functions wholesale.
> =

> No functional change intended.
> =

> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  include/net/sch_generic.h | 19 +++++++++++++
>  net/sched/sch_mq.c        | 69 ++++++++++++++++++++++++++++++++-------=
--------
>  2 files changed, 67 insertions(+), 21 deletions(-)
> =

> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index c3a7268b567e..f2281914d962 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h

We probably want to avoid random users. This may be better suited to a
local header, similar to net/core/devmem.h.

I don't mean to derail this feature if these are the only concerns.
This can be revised later in -rcX too.

> @@ -1419,7 +1419,26 @@ void mini_qdisc_pair_init(struct mini_Qdisc_pair=
 *miniqp, struct Qdisc *qdisc,
>  void mini_qdisc_pair_block_init(struct mini_Qdisc_pair *miniqp,
>  				struct tcf_block *block);
>  =

> +struct mq_sched {
> +	struct Qdisc		**qdiscs;
> +};
> +
> +int mq_init_common(struct Qdisc *sch, struct nlattr *opt,
> +		   struct netlink_ext_ack *extack,
> +		   const struct Qdisc_ops *qdisc_ops);
> +void mq_destroy_common(struct Qdisc *sch);
> +void mq_attach(struct Qdisc *sch);
>  void mq_change_real_num_tx(struct Qdisc *sch, unsigned int new_real_tx=
);
> +void mq_dump_common(struct Qdisc *sch, struct sk_buff *skb);
> +struct netdev_queue *mq_select_queue(struct Qdisc *sch,
> +				     struct tcmsg *tcm);
> +struct Qdisc *mq_leaf(struct Qdisc *sch, unsigned long cl);
> +unsigned long mq_find(struct Qdisc *sch, u32 classid);
> +int mq_dump_class(struct Qdisc *sch, unsigned long cl,
> +		  struct sk_buff *skb, struct tcmsg *tcm);
> +int mq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
> +			struct gnet_dump *d);
> +void mq_walk(struct Qdisc *sch, struct qdisc_walker *arg);
>  =

>  int sch_frag_xmit_hook(struct sk_buff *skb, int (*xmit)(struct sk_buff=
 *skb));
>  =

> diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
> index c860119a8f09..0bcabdcd1f44 100644
> --- a/net/sched/sch_mq.c
> +++ b/net/sched/sch_mq.c
> @@ -17,10 +17,6 @@
>  #include <net/pkt_sched.h>
>  #include <net/sch_generic.h>
>  =

> -struct mq_sched {
> -	struct Qdisc		**qdiscs;
> -};
> -
>  static int mq_offload(struct Qdisc *sch, enum tc_mq_command cmd)
>  {
>  	struct net_device *dev =3D qdisc_dev(sch);
> @@ -49,23 +45,29 @@ static int mq_offload_stats(struct Qdisc *sch)
>  	return qdisc_offload_dump_helper(sch, TC_SETUP_QDISC_MQ, &opt);
>  }
>  =

> -static void mq_destroy(struct Qdisc *sch)
> +void mq_destroy_common(struct Qdisc *sch)
>  {
>  	struct net_device *dev =3D qdisc_dev(sch);
>  	struct mq_sched *priv =3D qdisc_priv(sch);
>  	unsigned int ntx;
>  =

> -	mq_offload(sch, TC_MQ_DESTROY);
> -
>  	if (!priv->qdiscs)
>  		return;
>  	for (ntx =3D 0; ntx < dev->num_tx_queues && priv->qdiscs[ntx]; ntx++)=

>  		qdisc_put(priv->qdiscs[ntx]);
>  	kfree(priv->qdiscs);
>  }
> +EXPORT_SYMBOL(mq_destroy_common);

On a similar note, this would be a good use of EXPORT_SYMBOL_NS_GPL.

Maybe not even NETDEV_INTERNAL but a dedicated NET_SCHED_MQ.

> -static int mq_init(struct Qdisc *sch, struct nlattr *opt,
> -		   struct netlink_ext_ack *extack)
> +static void mq_destroy(struct Qdisc *sch)
> +{
> +	mq_offload(sch, TC_MQ_DESTROY);
> +	mq_destroy_common(sch);
> +}
> +
> +int mq_init_common(struct Qdisc *sch, struct nlattr *opt,
> +		   struct netlink_ext_ack *extack,
> +		   const struct Qdisc_ops *qdisc_ops)
>  {
>  	struct net_device *dev =3D qdisc_dev(sch);
>  	struct mq_sched *priv =3D qdisc_priv(sch);
> @@ -87,7 +89,8 @@ static int mq_init(struct Qdisc *sch, struct nlattr *=
opt,
>  =

>  	for (ntx =3D 0; ntx < dev->num_tx_queues; ntx++) {
>  		dev_queue =3D netdev_get_tx_queue(dev, ntx);
> -		qdisc =3D qdisc_create_dflt(dev_queue, get_default_qdisc_ops(dev, nt=
x),
> +		qdisc =3D qdisc_create_dflt(dev_queue,
> +					  qdisc_ops ?: get_default_qdisc_ops(dev, ntx),
>  					  TC_H_MAKE(TC_H_MAJ(sch->handle),
>  						    TC_H_MIN(ntx + 1)),
>  					  extack);
> @@ -98,12 +101,24 @@ static int mq_init(struct Qdisc *sch, struct nlatt=
r *opt,
>  	}
>  =

>  	sch->flags |=3D TCQ_F_MQROOT;
> +	return 0;
> +}
> +EXPORT_SYMBOL(mq_init_common);
> +
> +static int mq_init(struct Qdisc *sch, struct nlattr *opt,
> +		   struct netlink_ext_ack *extack)
> +{
> +	int ret;
> +
> +	ret =3D mq_init_common(sch, opt, extack, NULL);
> +	if (ret)
> +		return ret;
>  =

>  	mq_offload(sch, TC_MQ_CREATE);
>  	return 0;
>  }
>  =

> -static void mq_attach(struct Qdisc *sch)
> +void mq_attach(struct Qdisc *sch)
>  {
>  	struct net_device *dev =3D qdisc_dev(sch);
>  	struct mq_sched *priv =3D qdisc_priv(sch);
> @@ -124,8 +139,9 @@ static void mq_attach(struct Qdisc *sch)
>  	kfree(priv->qdiscs);
>  	priv->qdiscs =3D NULL;
>  }
> +EXPORT_SYMBOL(mq_attach);
>  =

> -static int mq_dump(struct Qdisc *sch, struct sk_buff *skb)
> +void mq_dump_common(struct Qdisc *sch, struct sk_buff *skb)
>  {
>  	struct net_device *dev =3D qdisc_dev(sch);
>  	struct Qdisc *qdisc;
> @@ -152,7 +168,12 @@ static int mq_dump(struct Qdisc *sch, struct sk_bu=
ff *skb)
>  =

>  		spin_unlock_bh(qdisc_lock(qdisc));
>  	}
> +}
> +EXPORT_SYMBOL(mq_dump_common);
>  =

> +static int mq_dump(struct Qdisc *sch, struct sk_buff *skb)
> +{
> +	mq_dump_common(sch, skb);
>  	return mq_offload_stats(sch);
>  }
>  =

> @@ -166,11 +187,12 @@ static struct netdev_queue *mq_queue_get(struct Q=
disc *sch, unsigned long cl)
>  	return netdev_get_tx_queue(dev, ntx);
>  }
>  =

> -static struct netdev_queue *mq_select_queue(struct Qdisc *sch,
> -					    struct tcmsg *tcm)
> +struct netdev_queue *mq_select_queue(struct Qdisc *sch,
> +				     struct tcmsg *tcm)
>  {
>  	return mq_queue_get(sch, TC_H_MIN(tcm->tcm_parent));
>  }
> +EXPORT_SYMBOL(mq_select_queue);
>  =

>  static int mq_graft(struct Qdisc *sch, unsigned long cl, struct Qdisc =
*new,
>  		    struct Qdisc **old, struct netlink_ext_ack *extack)
> @@ -198,14 +220,15 @@ static int mq_graft(struct Qdisc *sch, unsigned l=
ong cl, struct Qdisc *new,
>  	return 0;
>  }
>  =

> -static struct Qdisc *mq_leaf(struct Qdisc *sch, unsigned long cl)
> +struct Qdisc *mq_leaf(struct Qdisc *sch, unsigned long cl)
>  {
>  	struct netdev_queue *dev_queue =3D mq_queue_get(sch, cl);
>  =

>  	return rtnl_dereference(dev_queue->qdisc_sleeping);
>  }
> +EXPORT_SYMBOL(mq_leaf);
>  =

> -static unsigned long mq_find(struct Qdisc *sch, u32 classid)
> +unsigned long mq_find(struct Qdisc *sch, u32 classid)
>  {
>  	unsigned int ntx =3D TC_H_MIN(classid);
>  =

> @@ -213,9 +236,10 @@ static unsigned long mq_find(struct Qdisc *sch, u3=
2 classid)
>  		return 0;
>  	return ntx;
>  }
> +EXPORT_SYMBOL(mq_find);
>  =

> -static int mq_dump_class(struct Qdisc *sch, unsigned long cl,
> -			 struct sk_buff *skb, struct tcmsg *tcm)
> +int mq_dump_class(struct Qdisc *sch, unsigned long cl,
> +		  struct sk_buff *skb, struct tcmsg *tcm)
>  {
>  	struct netdev_queue *dev_queue =3D mq_queue_get(sch, cl);
>  =

> @@ -224,9 +248,10 @@ static int mq_dump_class(struct Qdisc *sch, unsign=
ed long cl,
>  	tcm->tcm_info =3D rtnl_dereference(dev_queue->qdisc_sleeping)->handle=
;
>  	return 0;
>  }
> +EXPORT_SYMBOL(mq_dump_class);
>  =

> -static int mq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
> -			       struct gnet_dump *d)
> +int mq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
> +			struct gnet_dump *d)
>  {
>  	struct netdev_queue *dev_queue =3D mq_queue_get(sch, cl);
>  =

> @@ -236,8 +261,9 @@ static int mq_dump_class_stats(struct Qdisc *sch, u=
nsigned long cl,
>  		return -1;
>  	return 0;
>  }
> +EXPORT_SYMBOL(mq_dump_class_stats);
>  =

> -static void mq_walk(struct Qdisc *sch, struct qdisc_walker *arg)
> +void mq_walk(struct Qdisc *sch, struct qdisc_walker *arg)
>  {
>  	struct net_device *dev =3D qdisc_dev(sch);
>  	unsigned int ntx;
> @@ -251,6 +277,7 @@ static void mq_walk(struct Qdisc *sch, struct qdisc=
_walker *arg)
>  			break;
>  	}
>  }
> +EXPORT_SYMBOL(mq_walk);
>  =

>  static const struct Qdisc_class_ops mq_class_ops =3D {
>  	.select_queue	=3D mq_select_queue,
> =

> -- =

> 2.52.0
> =




