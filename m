Return-Path: <netdev+bounces-55010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B628092D6
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79907B20ACD
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D02D4F1F6;
	Thu,  7 Dec 2023 20:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="al/hnS08"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724187096E
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 20:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FC0C433C7;
	Thu,  7 Dec 2023 20:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701982615;
	bh=E9QHdhuGqs7O3HvE8DDRQuAUr9zlZal/Gkd8UlR8R/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=al/hnS08tq/jSo1FRdqmDy4OIIsgPWrr/EpCVOXw138IbYAzEwdbDheAyG2Oq8Tt7
	 CJ2Dx92nBwkouoeeIJbS1iTrT7SIq02nUhuO9vSKHX02oqkKIC8F6Z+03q49SM+f7S
	 r4bxuSrPbVS7rYiE7oBHQMHVdo2a8xhhPobP5vv/Tukk3sEA3yRQgtN3WTcwh9kM14
	 9Xy0jBjTL6bnnDDOB7GbnNgkk9yawcZ7At9rSKeaPawn9CW4bxNSFwZMSLUwYmVwSc
	 N9UDnr+AcMzTTUYnmDOe+8gYBbqI7Bbpi/Vi0DXBpt7CCCm8foQwaJHAAqbBFqvG6N
	 bV6KwGeM6XlbA==
Date: Thu, 7 Dec 2023 20:56:50 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us,
	marcelo.leitner@gmail.com, vladbu@nvidia.com
Subject: Re: [PATCH net-next v3 4/5] net/sched: act_api: conditional
 notification of events
Message-ID: <20231207205650.GH50400@kernel.org>
References: <20231206164416.543503-1-pctammela@mojatatu.com>
 <20231206164416.543503-5-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206164416.543503-5-pctammela@mojatatu.com>

On Wed, Dec 06, 2023 at 01:44:15PM -0300, Pedro Tammela wrote:
> As of today tc-action events are unconditionally built and sent to
> RTNLGRP_TC. As with the introduction of rtnl_notify_needed we can check
> before-hand if they are really needed.
> 
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Hi Pedro,

a nice optimisation :)

...

> +static int tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
> +{
> +	const struct tc_action_ops *ops = action->ops;
> +	struct sk_buff *skb = NULL;
> +	int ret;
> +
> +	if (!rtnl_notify_needed(net, 0, RTNLGRP_TC))
> +		goto skip_msg;

Is there a reason (performance?) to use a goto here
rather than putting the tcf_reoffload_del_notify_msg() call inside
an if condition?

Completely untested!

	if (!rtnl_notify_needed(net, 0, RTNLGRP_TC)) {
		skb = NULL;
	} else {
		skb = tcf_reoffload_del_notify_msg(net, action);
		if (IS_ERR(skb))
			return PTR_ERR(skb);
	}

Or perhaps a helper, as this pattern seems to also appear in tcf_add_notify()


> +
> +	skb = tcf_reoffload_del_notify_msg(net, action);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +
> +skip_msg:
>  	ret = tcf_idr_release_unsafe(action);
>  	if (ret == ACT_P_DELETED) {
>  		module_put(ops->owner);
> -		ret = rtnetlink_send(skb, net, 0, RTNLGRP_TC, 0);
> +		ret = rtnetlink_maybe_send(skb, net, 0, RTNLGRP_TC, 0);
>  	} else {
>  		kfree_skb(skb);
>  	}

...

> +static int tcf_add_notify(struct net *net, struct nlmsghdr *n,
> +			  struct tc_action *actions[], u32 portid,
> +			  size_t attr_size, struct netlink_ext_ack *extack)
> +{
> +	struct sk_buff *skb = NULL;
> +
> +	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
> +		goto skip_msg;
> +
> +	skb = tcf_add_notify_msg(net, n, actions, portid, attr_size, extack);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +
> +skip_msg:
> +	return rtnetlink_maybe_send(skb, net, portid, RTNLGRP_TC,
> +				    n->nlmsg_flags & NLM_F_ECHO);
>  }
>  
>  static int tcf_action_add(struct net *net, struct nlattr *nla,
> -- 
> 2.40.1
> 

