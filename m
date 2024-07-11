Return-Path: <netdev+bounces-110839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7A892E87F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 14:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448061F22B93
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F71F14C5A4;
	Thu, 11 Jul 2024 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIZMW2h3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8D12F5B7
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702009; cv=none; b=S4KuAm2cPdH9xeNLhjvj15xBn8kXIsGja+UCCgjKcWkw77mkgNCp7SrQlfe0pLHx2Sk/DZNeOIjoZ1IhuklleM8lYtuq1VOOR8AiukgkxvHhzddYxkhE+kFodrhN7p58Rnj4KU4EDvhjb5J72abyGG7FxMeaCU/uhhcg0N7Hbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702009; c=relaxed/simple;
	bh=2Pc9KghlUrKj/NPhMPl4h2MeN+YxELeMcPsbUfNC1JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrsTFCwBzt/WdjhonUTCF2DWFuWTZTjB8Tw78QILLp3s4J+5bb1z93NwqRSk2FZM6NCjZGMCo9nI2XWF3CIVKmvLdEZCdsmddXTcdzlwclTQOXWaGPaU5HUcvlWB1ohYS1qDk54g5mXJexZV2KNL9ejnAWTnEzQCe1BgrZ4b4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIZMW2h3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95451C116B1;
	Thu, 11 Jul 2024 12:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720702008;
	bh=2Pc9KghlUrKj/NPhMPl4h2MeN+YxELeMcPsbUfNC1JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIZMW2h3iLKw1g0un9IN9dQK69n3aLk8tKScfuXJLCVcJMr1g+80JsOX7W00Q7GTS
	 qKva9+J4jrnVGbP7xrE8ZDD+C4LoMQsOzw3kKlAupcSPorrdixTYolkUVbdTsEI3lk
	 j5OIZ+PzSWQL0pv95fJWsBo8uUbm991J68qPleKfnZB9NPM00RDK0MEsszA/xNUmc0
	 IU0DfXaBeGPYpG/pi4lsHGu278G6o6cWkGxlJCyR+v4h1awTxfl4UaxIDV1L/lchLY
	 vCOmzEi4wzhfD5rDd4tj+DCHAA2ayTZ02W7/0BEsSR5Q0BFLeen9hhQIyfkKBtk7GF
	 fdNBCjI8KdYgg==
Date: Thu, 11 Jul 2024 13:46:45 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next] net: reduce rtnetlink_rcv_msg() stack usage
Message-ID: <20240711124645.GC8788@kernel.org>
References: <20240710151653.3786604-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710151653.3786604-1-edumazet@google.com>

On Wed, Jul 10, 2024 at 03:16:53PM +0000, Eric Dumazet wrote:
> IFLA_MAX is increasing slowly but surely.
> 
> Some compilers use more than 512 bytes of stack in rtnetlink_rcv_msg()
> because it calls rtnl_calcit() for RTM_GETLINK message.
> 
> Use noinline_for_stack attribute to not inline rtnl_calcit(),
> and directly use nla_for_each_attr_type() (Jakub suggestion)
> because we only care about IFLA_EXT_MASK at this stage.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/core/rtnetlink.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index eabfc8290f5e29f2ef3e5c1481715ae9056ea689..87e67194f24046a8420bbb51c19fb0a686b9b06b 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3969,22 +3969,28 @@ static int rtnl_dellinkprop(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	return rtnl_linkprop(RTM_DELLINKPROP, skb, nlh, extack);
>  }
>  
> -static u32 rtnl_calcit(struct sk_buff *skb, struct nlmsghdr *nlh)
> +static noinline_for_stack u32 rtnl_calcit(struct sk_buff *skb,
> +					  struct nlmsghdr *nlh)
>  {
>  	struct net *net = sock_net(skb->sk);
>  	size_t min_ifinfo_dump_size = 0;
> -	struct nlattr *tb[IFLA_MAX+1];
>  	u32 ext_filter_mask = 0;
>  	struct net_device *dev;
> -	int hdrlen;
> +	struct nlattr *nla;
> +	int hdrlen, rem;
>  
>  	/* Same kernel<->userspace interface hack as in rtnl_dump_ifinfo. */
>  	hdrlen = nlmsg_len(nlh) < sizeof(struct ifinfomsg) ?
>  		 sizeof(struct rtgenmsg) : sizeof(struct ifinfomsg);
>  
> -	if (nlmsg_parse_deprecated(nlh, hdrlen, tb, IFLA_MAX, ifla_policy, NULL) >= 0) {
> -		if (tb[IFLA_EXT_MASK])
> -			ext_filter_mask = nla_get_u32(tb[IFLA_EXT_MASK]);
> +	if (nlh->nlmsg_len < nlmsg_msg_size(hdrlen))
> +		return NLMSG_GOODSIZE;
> +
> +	nla_for_each_attr_type(nla, IFLA_EXT_MASK,
> +			       nlmsg_attrdata(nlh, hdrlen),
> +			       nlmsg_attrlen(nlh, hdrlen), rem) {
> +		if (nla_len(nla) == sizeof(u32))
> +			ext_filter_mask = nla_get_u32(nla);

I guess that in practice we can break here.
But perhaps there is some case where there is more than one
IFLA_EXT_MASK attribute and it changes behaviour.

>  	}
>  
>  	if (!ext_filter_mask)
> -- 
> 2.45.2.993.g49e7a77208-goog
> 
> 

