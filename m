Return-Path: <netdev+bounces-88821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418DD8A89DE
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37AF3B2594C
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1572116D334;
	Wed, 17 Apr 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="belNWJ8b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9E1487E4
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373664; cv=none; b=kXzhPIPvPen9uvHdbzcCmsc+MgvWVN4Jzbm/24IJPhPNcYh7sYy6bi4+bU2+pz9kDYPNPPVmzPeh1m7p0nk25oPSBTFlecj+2GhNG8RoMf1RGHCBKOL0UjKF5qVBKyW7CkLRfal+l86I/ElSk/kehA0xxv36n91hIZUOxXVP+kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373664; c=relaxed/simple;
	bh=vL7dNHHMoYA9aVz5zI+6e61+WjGY7AhETSRX0cYKQ8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9nMyER6sUIEvZzn8IHUlshOZnZpuqr2fx1f/vygVrr0i3nDknh+UEdqmr2HqXllrmfAMdoVqfJjFVbrVbx6Uzq3J5fU3KKL/DMcIQ1O2e7oZ0GKKTzXxUjIY8nYJbU5KP6fjFd947HIrolxSL/sx9DBj/bGvWQCB3CXTHiW22o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=belNWJ8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CB4C072AA;
	Wed, 17 Apr 2024 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713373663;
	bh=vL7dNHHMoYA9aVz5zI+6e61+WjGY7AhETSRX0cYKQ8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=belNWJ8bxbuKiydIdvtqopuK6u6DgHEnaAgakNNyncai2qRWOLg//r+DBhFkAcgHS
	 RZrYTSSME5Oz4/djGu0oSPpuqpTXZPgnbHZ1YcVRZz71CCX7vFveiAgRSBFM5TYmpu
	 dPZ6UEg+GnYTVfCggWQD5/sk8+c1ibC80YBQMyglPXPMUwQ8N1VW6twmHqAe0Rq4aO
	 jrYT+nMmKujuc4eknWE5rYPhnsRMLXuRsid9W+6rcy31Li0lsSZi1NmYVvrczlgvLq
	 NLWd9CiLDQKKdkZCDeygDb8fC0a9U6zhc5whIpnRWd1Y6oNd24RzoMP9bZ4ev3E4TQ
	 nSlDMjt4rB/AA==
Date: Wed, 17 Apr 2024 18:07:39 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 09/14] net_sched: sch_fq_codel: implement
 lockless fq_codel_dump()
Message-ID: <20240417170739.GE2320920@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-10-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415132054.3822230-10-edumazet@google.com>

On Mon, Apr 15, 2024 at 01:20:49PM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, fq_codel_dump() can use READ_ONCE()
> annotations, paired with WRITE_ONCE() ones in fq_codel_change().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/sch_fq_codel.c | 57 ++++++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 22 deletions(-)
> 
> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c

...

> @@ -529,30 +539,33 @@ static int fq_codel_dump(struct Qdisc *sch, struct sk_buff *skb)
>  		goto nla_put_failure;
>  
>  	if (nla_put_u32(skb, TCA_FQ_CODEL_TARGET,
> -			codel_time_to_us(q->cparams.target)) ||
> +			codel_time_to_us(READ_ONCE(q->cparams.target))) ||
>  	    nla_put_u32(skb, TCA_FQ_CODEL_LIMIT,
> -			sch->limit) ||
> +			READ_ONCE(sch->limit)) ||
>  	    nla_put_u32(skb, TCA_FQ_CODEL_INTERVAL,
> -			codel_time_to_us(q->cparams.interval)) ||
> +			codel_time_to_us(READ_ONCE(q->cparams.interval))) ||
>  	    nla_put_u32(skb, TCA_FQ_CODEL_ECN,
> -			q->cparams.ecn) ||
> +			READ_ONCE(q->cparams.ecn)) ||
>  	    nla_put_u32(skb, TCA_FQ_CODEL_QUANTUM,
> -			q->quantum) ||
> +			READ_ONCE(q->quantum)) ||
>  	    nla_put_u32(skb, TCA_FQ_CODEL_DROP_BATCH_SIZE,
> -			q->drop_batch_size) ||
> +			READ_ONCE(q->drop_batch_size)) ||
>  	    nla_put_u32(skb, TCA_FQ_CODEL_MEMORY_LIMIT,
> -			q->memory_limit) ||
> +			READ_ONCE(q->memory_limit)) ||
>  	    nla_put_u32(skb, TCA_FQ_CODEL_FLOWS,
> -			q->flows_cnt))
> +			READ_ONCE(q->flows_cnt)))

Hi Eric,

I think you missed the corresponding update for q->flows_cnt
in fq_codel_change().

>  		goto nla_put_failure;
>  
> -	if (q->cparams.ce_threshold != CODEL_DISABLED_THRESHOLD) {
> +	ce_threshold = READ_ONCE(q->cparams.ce_threshold);
> +	if (ce_threshold != CODEL_DISABLED_THRESHOLD) {
>  		if (nla_put_u32(skb, TCA_FQ_CODEL_CE_THRESHOLD,
> -				codel_time_to_us(q->cparams.ce_threshold)))
> +				codel_time_to_us(ce_threshold)))
>  			goto nla_put_failure;
> -		if (nla_put_u8(skb, TCA_FQ_CODEL_CE_THRESHOLD_SELECTOR, q->cparams.ce_threshold_selector))
> +		if (nla_put_u8(skb, TCA_FQ_CODEL_CE_THRESHOLD_SELECTOR,
> +			       READ_ONCE(q->cparams.ce_threshold_selector)))
>  			goto nla_put_failure;
> -		if (nla_put_u8(skb, TCA_FQ_CODEL_CE_THRESHOLD_MASK, q->cparams.ce_threshold_mask))
> +		if (nla_put_u8(skb, TCA_FQ_CODEL_CE_THRESHOLD_MASK,
> +			       READ_ONCE(q->cparams.ce_threshold_mask)))
>  			goto nla_put_failure;
>  	}
>  
> -- 
> 2.44.0.683.g7961c838ac-goog
> 
> 

