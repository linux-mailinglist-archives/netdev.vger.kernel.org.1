Return-Path: <netdev+bounces-88811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EFD8A8964
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33056284B3C
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FEA17109D;
	Wed, 17 Apr 2024 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEQaV8tA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A216FF38
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372870; cv=none; b=VFUMbJg/z8EYC7odYDz24StGjvTYQ4uLbDF83cl1Fsvy/3LMKdQVH3pZNOnlyqFkQp1yKqZWLx/B1xGatyS3VOXcFI+xa1bCtn/LUHYgJ8Gn2bb6onbL+447w89oFmFfVvDqKxxAeSRFVNwe4mcSd4SFc82F+X3XFQuRcfrkguE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372870; c=relaxed/simple;
	bh=xoSzvBjIFVGpMmrp6L6fzvNnlEXqho916igCTC3nN98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lItRW6hiacIx1O9mSHB714LIVKRs76FNeVoqxgLRMmebcGKIv5V1AN6nda1pRRhgf0gOzfseHBKjyQgbYIksMSaKVg5Na0TjcD50lIOuTvMbdXeP06MIz+VxeIwOixETo7OVwsayujWBVgpHvfA2tzC7u6ff1Oxp0OFL1l8yb7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEQaV8tA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FFEC32786;
	Wed, 17 Apr 2024 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713372870;
	bh=xoSzvBjIFVGpMmrp6L6fzvNnlEXqho916igCTC3nN98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tEQaV8tA5J28wONHbDmsuQgCdKI5cUZNMmcWaf+sHhA7Is3pXwe4k5qE+iJYWTDdp
	 JUUxMXaLGzOUd+9pv8ChaT8/F3Ugm+HUugw3lxrZJDIM5iqGZ25Ha36BllbsdifInQ
	 Ms0z1y05Ioidf/SFJ2w/LQI/hAFA2WHoWVUOOAsRom7M5DrDohZ1Qjx2OYpgAhxZ6i
	 R0rd1zPgyrBXS4b780izg/3cevSZEHZWeciqw/0pK7GRPuGQW1dZq9RZNB8NT126sS
	 rtsmcZ8MvyWyvQAAoM3BoWfvUVzwLrZBVv/n1qY18/N6TFPwxORN5K4oKDHg+8Fedt
	 VbXbxu0szYHMA==
Date: Wed, 17 Apr 2024 17:54:25 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 07/14] net_sched: sch_ets: implement lockless
 ets_dump()
Message-ID: <20240417165425.GD2320920@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-8-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415132054.3822230-8-edumazet@google.com>

On Mon, Apr 15, 2024 at 01:20:47PM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, ets_dump() can use READ_ONCE()
> annotations, paired with WRITE_ONCE() ones in ets_change().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/sch_ets.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index 835b4460b44854a803d3054e744702022b7551f4..f80bc05d4c5a5050226e6cfd30fa951c0b61029f 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c

...

> @@ -658,11 +658,11 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
>  			list_del(&q->classes[i].alist);
>  		qdisc_tree_flush_backlog(q->classes[i].qdisc);
>  	}
> -	q->nstrict = nstrict;
> +	WRITE_ONCE(q->nstrict, nstrict);
>  	memcpy(q->prio2band, priomap, sizeof(priomap));

Hi Eric,

I think that writing elements of q->prio2band needs WRITE_ONCE() treatment too.

>  	for (i = 0; i < q->nbands; i++)
> -		q->classes[i].quantum = quanta[i];
> +		WRITE_ONCE(q->classes[i].quantum, quanta[i]);
>  
>  	for (i = oldbands; i < q->nbands; i++) {
>  		q->classes[i].qdisc = queues[i];

...

> @@ -733,6 +733,7 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
>  	struct ets_sched *q = qdisc_priv(sch);
>  	struct nlattr *opts;
>  	struct nlattr *nest;
> +	u8 nbands, nstrict;
>  	int band;
>  	int prio;
>  	int err;

The next few lines of this function are:

	err = ets_offload_dump(sch);
	if (err)
		return err;

Where ets_offload_dump may indirectly call ndo_setup_tc().
And I am concerned that ndo_setup_tc() expects RTNL to be held,
although perhaps that assumption is out of date.

...

> @@ -771,7 +773,8 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
>  		goto nla_err;
>  
>  	for (prio = 0; prio <= TC_PRIO_MAX; prio++) {
> -		if (nla_put_u8(skb, TCA_ETS_PRIOMAP_BAND, q->prio2band[prio]))
> +		if (nla_put_u8(skb, TCA_ETS_PRIOMAP_BAND,
> +			       READ_ONCE(q->prio2band[prio])))
>  			goto nla_err;
>  	}

...

