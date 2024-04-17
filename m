Return-Path: <netdev+bounces-88644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 383CB8A7F9B
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 11:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E959B281BD7
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D95312EBDB;
	Wed, 17 Apr 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4+0ycOi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7897412DD87
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346049; cv=none; b=APB4wZWuMgT7pLwgKAgpA99ya6s9VNxMXiKGDfAJdATMzu64U/4YZd+WlJpqClPKxFqMN5ZAT32/xVfbeCfZ9Hrs1MMMmY2WLisM+0gNMH54D6dDROUTyLH2m2j4xM+krl4goJobjpfIgFmuRDDhOqRNVxHqk1cVpLPEqUJguY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346049; c=relaxed/simple;
	bh=yrBqkzrLpFn0awnopzQBMslffvaKiAAvgt7sv4IoHh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP15XK70jWy3yJHDjy2B8nVFmlpnHtXND7jH88SAJZLYo0YWF7McwTsR9l4GT88OX5dgt9ye4f4HmzD9mExBVpdzJkixreBcHgigtkK7sMvbmb7DflxqPkXQP0gnzEQayRWFFz8LOvGVcnA9l7nlwP46DCnJRupz8+57sVuO9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4+0ycOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D1FC072AA;
	Wed, 17 Apr 2024 09:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713346049;
	bh=yrBqkzrLpFn0awnopzQBMslffvaKiAAvgt7sv4IoHh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g4+0ycOiHtRa9WDlbdHFwO9PBTv5+2haD/9vgtIFUifEO7ELJK9j8xNoi1T90EiNp
	 x8qK8ATHE79x5MSmGg9oVlhhJZZTgLH1Hg25S2ZBrdHgNSlfKkJV6/FJ9PErOgSXTi
	 kfdbncZjeYhD9W00EeRAKTlPXClH4pcYpyvVsy5giv1BYrYS0zFwbwDQs1v2rPAO31
	 ZPS15Ye9KgYX5D82hJB+DHNMOBRmPeksiu0l16fc45Bk/VbtK2xDH6LUF9Q7iPzmo1
	 p+Vr32z7c4pdAXF9qXsvlK37hbh6HfnIFhU9iFejVHM8mPtFI7wuXTXHYWuNCnSymy
	 F53LzpBBT6YCQ==
Date: Wed, 17 Apr 2024 10:27:24 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net-next 03/14] net_sched: sch_cbs: implement lockless
 cbs_dump()
Message-ID: <20240417092724.GW2320920@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415132054.3822230-4-edumazet@google.com>

+ Vinicius Costa Gomes

On Mon, Apr 15, 2024 at 01:20:43PM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, cbs_dump() can use READ_ONCE()
> annotations, paired with WRITE_ONCE() ones in cbs_change().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

(Eric, I need to step away from my desk for a while.
 So there will be a bit of a delay in reviewing the rest
 of the series.)

> ---
>  net/sched/sch_cbs.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
> index 69001eff0315584df23a24f81ae3b4cf7bf5fd79..939425da18955bc8a3f3d2d5b852b2585e9bcaee 100644
> --- a/net/sched/sch_cbs.c
> +++ b/net/sched/sch_cbs.c
> @@ -389,11 +389,11 @@ static int cbs_change(struct Qdisc *sch, struct nlattr *opt,
>  	}
>  
>  	/* Everything went OK, save the parameters used. */
> -	q->hicredit = qopt->hicredit;
> -	q->locredit = qopt->locredit;
> -	q->idleslope = qopt->idleslope * BYTES_PER_KBIT;
> -	q->sendslope = qopt->sendslope * BYTES_PER_KBIT;
> -	q->offload = qopt->offload;
> +	WRITE_ONCE(q->hicredit, qopt->hicredit);
> +	WRITE_ONCE(q->locredit, qopt->locredit);
> +	WRITE_ONCE(q->idleslope, qopt->idleslope * BYTES_PER_KBIT);
> +	WRITE_ONCE(q->sendslope, qopt->sendslope * BYTES_PER_KBIT);
> +	WRITE_ONCE(q->offload, qopt->offload);
>  
>  	return 0;
>  }
> @@ -459,11 +459,11 @@ static int cbs_dump(struct Qdisc *sch, struct sk_buff *skb)
>  	if (!nest)
>  		goto nla_put_failure;
>  
> -	opt.hicredit = q->hicredit;
> -	opt.locredit = q->locredit;
> -	opt.sendslope = div64_s64(q->sendslope, BYTES_PER_KBIT);
> -	opt.idleslope = div64_s64(q->idleslope, BYTES_PER_KBIT);
> -	opt.offload = q->offload;
> +	opt.hicredit = READ_ONCE(q->hicredit);
> +	opt.locredit = READ_ONCE(q->locredit);
> +	opt.sendslope = div64_s64(READ_ONCE(q->sendslope), BYTES_PER_KBIT);
> +	opt.idleslope = div64_s64(READ_ONCE(q->idleslope), BYTES_PER_KBIT);
> +	opt.offload = READ_ONCE(q->offload);
>  
>  	if (nla_put(skb, TCA_CBS_PARMS, sizeof(opt), &opt))
>  		goto nla_put_failure;
> -- 
> 2.44.0.683.g7961c838ac-goog
> 
> 

