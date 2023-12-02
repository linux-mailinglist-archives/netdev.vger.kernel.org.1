Return-Path: <netdev+bounces-53279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75990801E37
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 20:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D421C2084B
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 19:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646031C69C;
	Sat,  2 Dec 2023 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjNT42ok"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E619448
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 19:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7A8C433C9;
	Sat,  2 Dec 2023 19:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701544865;
	bh=7bnMIPdcyyE3JV3poJ2NEga2ixCjC16/Hl+yEa/j6iE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tjNT42oke+8SlfgZfFzf/WOefE2+ArDC5E+gHOUeIhai5JkrIFt0l5hvpAg7F3aUt
	 zC/qv3XHaTOGPNtd7SpazsnAaDEB1alkdPWPTpcLFJoMkCc76gvMgUc1DFjtdf81up
	 nEmi1RZJY9DG6pwoGQiSt+jKFoafogfK1gMx3gElOdm+y4tS4oOXi+HUVhDzIrGEil
	 vGyKSvlinNDz3eynXYAMT3WCxQ51SpuLLWNEi+Sh3pMl6ZNnxs7f05MAEf++4pgl8U
	 74LSFh9o8NClrFNndjo7U/vdbGPvWgtO4XCFeISaPrm775YYFag0qOjWb9kFyk4rOZ
	 7rWEPiQtLdNaA==
Date: Sat, 2 Dec 2023 11:21:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, marcelo.leitner@gmail.com, vladbu@nvidia.com
Subject: Re: [PATCH net-next 3/4] net/sched: act_api: conditional
 notification of events
Message-ID: <20231202112104.0ca43022@kernel.org>
In-Reply-To: <20231201204314.220543-4-pctammela@mojatatu.com>
References: <20231201204314.220543-1-pctammela@mojatatu.com>
	<20231201204314.220543-4-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Dec 2023 17:43:13 -0300 Pedro Tammela wrote:
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -1791,6 +1791,13 @@ tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
>  	struct sk_buff *skb;
>  	int ret;
>  
> +	if (!tc_should_notify(net, 0)) {
> +		ret = tcf_idr_release_unsafe(action);
> +		if (ret == ACT_P_DELETED)
> +			module_put(ops->owner);
> +		return ret;
> +	}

I fell like we can do better than this.. let's refactor this code a bit
harder. Maybe factor out the alloc_skb() and fill()? Then add a wrapper
around rtnetlink_send() which does nothing if skb is NULL?

>  	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
>  			GFP_KERNEL);
>  	if (!skb)

