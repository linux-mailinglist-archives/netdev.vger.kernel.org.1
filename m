Return-Path: <netdev+bounces-37294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5476D7B48FE
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 19:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 89771281789
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 17:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C6218C09;
	Sun,  1 Oct 2023 17:54:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E95D18B1B
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 17:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238FBC433C7;
	Sun,  1 Oct 2023 17:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696182867;
	bh=Lk94c1Pr/kdJ6GO1+4Jo2iWmzYgaMVSKIR6PfPgI5DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYU3gK0lrlOPDbGgFKYHIZ1a5cj3aSJUVifwAp4V56PstaLW5RB0/24mz2NM0QbSA
	 7i7VeKINiCQRgHFuuugaxJ5Jk73ff3OIyfu2U2Jv9k9XXXlXxYkCT6pkqtWFipNpNy
	 6A3T9LgCnRV5gOfNuKBxlsYOeljTfTCMvXngAIDh6ZOoAHrxXtEdE8KXkJGikpfapH
	 ciixqEYsQwnm/AqHuodprrxzFqt1PO5S76zJHXoBTeXtdur/pA2nxYoQGC8VyvZuGq
	 flPPtlzVXgeIpxzz8n+HImPLBgydJ5qPWpibnQQpdz51zaNXMW+ctkz2oAZOIm5EL8
	 FT58b0nHnXItw==
Date: Sun, 1 Oct 2023 19:54:22 +0200
From: Simon Horman <horms@kernel.org>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>, Po Liu <Po.Liu@nxp.com>
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
Message-ID: <20231001175422.GT92317@kernel.org>
References: <20230926182625.72475-1-dg573847474@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926182625.72475-1-dg573847474@gmail.com>

+  Pedro Tammela <pctammela@mojatatu.com>
   Po Liu <Po.Liu@nxp.com>

On Tue, Sep 26, 2023 at 06:26:25PM +0000, Chengfeng Ye wrote:
> I find tcf_gate_act() acquires &gact->tcf_lock without disable
> bh explicitly, as gact->tcf_lock is acquired inside timer under
> softirq context, if tcf_gate_act() is not called with bh disable
> by default or under softirq context(which I am not sure as I cannot
> find corresponding documentation), then it could be the following 
> deadlocks.
> 
> tcf_gate_act()
> --> spin_loc(&gact->tcf_lock)
> <interrupt>
>    --> gate_timer_func()
>    --> spin_lock(&gact->tcf_lock)
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>


Hi Chengfeng Ye,

thanks for your patch.

As a fix for Networking this should probably be targeted at the
'net' tree. Which should be denoted in the subject.

        Subject: [PATCH net] ...

And as a fix this patch should probably have a Fixes tag.
This ones seem appropriate to me, but I could be wrong.

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")

I don't think it is necessary to repost just to address these issues,
but the Networking maintainers may think otherwise.

The code change itself looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/sched/act_gate.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index c9a811f4c7ee..b82daf7401a5 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -124,25 +124,25 @@ TC_INDIRECT_SCOPE int tcf_gate_act(struct sk_buff *skb,
>  	tcf_lastuse_update(&gact->tcf_tm);
>  	tcf_action_update_bstats(&gact->common, skb);
>  
> -	spin_lock(&gact->tcf_lock);
> +	spin_lock_bh(&gact->tcf_lock);
>  	if (unlikely(gact->current_gate_status & GATE_ACT_PENDING)) {
> -		spin_unlock(&gact->tcf_lock);
> +		spin_unlock_bh(&gact->tcf_lock);
>  		return action;
>  	}
>  
>  	if (!(gact->current_gate_status & GATE_ACT_GATE_OPEN)) {
> -		spin_unlock(&gact->tcf_lock);
> +		spin_unlock_bh(&gact->tcf_lock);
>  		goto drop;
>  	}
>  
>  	if (gact->current_max_octets >= 0) {
>  		gact->current_entry_octets += qdisc_pkt_len(skb);
>  		if (gact->current_entry_octets > gact->current_max_octets) {
> -			spin_unlock(&gact->tcf_lock);
> +			spin_unlock_bh(&gact->tcf_lock);
>  			goto overlimit;
>  		}
>  	}
> -	spin_unlock(&gact->tcf_lock);
> +	spin_unlock_bh(&gact->tcf_lock);
>  
>  	return action;
>  
> -- 
> 2.17.1
> 
> 

