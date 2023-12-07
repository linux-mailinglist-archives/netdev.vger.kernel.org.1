Return-Path: <netdev+bounces-55011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5068092E0
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520FF281481
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C150D4F895;
	Thu,  7 Dec 2023 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CW0VHQEb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BC87096E
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 20:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4CBC433C7;
	Thu,  7 Dec 2023 20:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701982784;
	bh=gLo1oofiPzFLm9XMj+lVxiHiPH3r97r9vL+jiB5l6co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CW0VHQEbCOWjoakOuc+cB/1AQyoDIY+dr+3qhwBBhlYi0h5ZFNWjoduSk0XhHRB2Z
	 2BH9Ff3GMZEXCP+kdPeontPTzLzohc1rYd+khtnz/7hUu2O9e2jyjl6xW7peJ1NxHA
	 6pQcx8bPCmTRbsQObYCtlwxRTNiMev0w2OXl9J4MyKJU/Bg6HmeqU8CHuK/emiugwx
	 VDzMS9B1Vp53lMYhBWWdh/87ryA+w57BEoZfCzKPLbG179VJKdipCno4QWYEkrJ+Ah
	 tRTitmTBQIkk24d5wtD5gPWHGgwOz6rxHcNRhXw5Wubo0BaHHG+sJSh+PyRjs3EITl
	 8D7GvQjapU91w==
Date: Thu, 7 Dec 2023 20:59:39 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us,
	marcelo.leitner@gmail.com, vladbu@nvidia.com,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v3 5/5] net/sched: cls_api: conditional
 notification of events
Message-ID: <20231207205939.GI50400@kernel.org>
References: <20231206164416.543503-1-pctammela@mojatatu.com>
 <20231206164416.543503-6-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206164416.543503-6-pctammela@mojatatu.com>

On Wed, Dec 06, 2023 at 01:44:16PM -0300, Pedro Tammela wrote:
> As of today tc-filter/chain events are unconditionally built and sent to
> RTNLGRP_TC. As with the introduction of rtnl_notify_needed we can check
> before-hand if they are really needed. This will help to alleviate
> system pressure when filters are concurrently added without the rtnl
> lock as in tc-flower.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Thanks Pedro,

my comment below notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/sched/cls_api.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 1976bd163986..123185907ebd 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -2053,6 +2053,9 @@ static int tfilter_notify(struct net *net, struct sk_buff *oskb,
>  	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
>  	int err = 0;
>  
> +	if (!unicast && !rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))

I don't feel strongly about this, but
as the above condition appears 3 times in this patch,
perhaps it could be a helper?

> +		return 0;
> +
>  	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
>  	if (!skb)
>  		return -ENOBUFS;
> @@ -2082,6 +2085,9 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
>  	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
>  	int err;
>  
> +	if (!unicast && !rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
> +		return tp->ops->delete(tp, fh, last, rtnl_held, extack);
> +
>  	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
>  	if (!skb)
>  		return -ENOBUFS;
> @@ -2906,6 +2912,9 @@ static int tc_chain_notify(struct tcf_chain *chain, struct sk_buff *oskb,
>  	struct sk_buff *skb;
>  	int err = 0;
>  
> +	if (!unicast && !rtnl_notify_needed(net, flags, RTNLGRP_TC))
> +		return 0;
> +
>  	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
>  	if (!skb)
>  		return -ENOBUFS;
> @@ -2935,6 +2944,9 @@ static int tc_chain_notify_delete(const struct tcf_proto_ops *tmplt_ops,
>  	struct net *net = block->net;
>  	struct sk_buff *skb;
>  
> +	if (!unicast && !rtnl_notify_needed(net, flags, RTNLGRP_TC))
> +		return 0;
> +
>  	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
>  	if (!skb)
>  		return -ENOBUFS;
> -- 
> 2.40.1
> 

