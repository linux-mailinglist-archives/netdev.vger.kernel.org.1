Return-Path: <netdev+bounces-169670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E504A45310
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE033A7E30
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 02:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D498321A928;
	Wed, 26 Feb 2025 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrTtu2aQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B069410A1F
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536808; cv=none; b=kszLclUSF5ZFv2CdoXWy0zxTzNTQmMjZyTHud6NuFocM8ThHME791JrlfwuzP815boV1furLDazC8ONdw97i3Cp5V9v3wdlvvyDi+JQ1Xxit8FL1GoDdIaQHEEt94qhk+e8aXuAgV99xt8PP0ZgUups6XAuFwH8KXLhUKj947DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536808; c=relaxed/simple;
	bh=9SAXM4tOMeJ84hfpureMEED9fBbAHfFN3mkAaRU9pNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVQ9tuLobv40r5iisqoljxB7MU4wtUoGkvE+1CVTjKkfXKsOgiIyc/fN+A42fJA0284DNNKF3Zhhnn9EfxzSiYId4DtEaDh6PayydPvJRl/9OGAOJg8QPT2ya6iXRLXcM3TeYnOs6tCAmyHwq1wsdN/qC/LkjFFLfO44HM+JvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrTtu2aQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196B6C4CEDD;
	Wed, 26 Feb 2025 02:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740536808;
	bh=9SAXM4tOMeJ84hfpureMEED9fBbAHfFN3mkAaRU9pNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DrTtu2aQKZe2h5J73ajPj628+Xq3Z12MkMhzCUNztwfAVAWAwo847X1yhI722HvI3
	 Jwo1vMPcdcM5v/mHThklZFklFUb8mhuML4yGIIAFDJ7tvhByRe43LiD1yn0uIY4zqf
	 zUpGf7+Y+VNoftosVBJZEboG2a9hHgRCKa9Pq/mxnbnFQxAyz2obDMtt61EnRV79Kv
	 PNABGCIp7OkQuBKfj3tAvrMk6lyDK3wE73w4CW2eNu/Ejl68m0BuTWxrjxZo2bFFBO
	 7YArT2bnQckP25gsBXUmpTek5oyJIqgJe5KarSccbP6DRQMr6pv9BbhoNysl4W4X+X
	 RmZMDkoD0CprA==
Date: Tue, 25 Feb 2025 18:26:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] geneve: Allow users to specify source port
 range
Message-ID: <20250225182647.486772df@kernel.org>
In-Reply-To: <20250224153927.50684-1-daniel@iogearbox.net>
References: <20250224153927.50684-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 16:39:26 +0100 Daniel Borkmann wrote:
> @@ -1083,8 +1087,8 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
>  
>  		use_cache = ip_tunnel_dst_cache_usable(skb, info);
>  		tos = geneve_get_dsfield(skb, dev, info, &use_cache);
> -		sport = udp_flow_src_port(geneve->net, skb,
> -					  1, USHRT_MAX, true);
> +		sport = udp_flow_src_port(geneve->net, skb, geneve->cfg.port_min,

nit: we do still prefer breaking at 80 columns if it doesn't make code
less readable.

> +					  geneve->cfg.port_max, true);
>  
>  		rt = udp_tunnel_dst_lookup(skb, dev, geneve->net, 0, &saddr,
>  					   &info->key,

> @@ -1279,6 +1284,17 @@ static int geneve_validate(struct nlattr *tb[], struct nlattr *data[],
>  		}
>  	}
>  
> +	if (data[IFLA_GENEVE_PORT_RANGE]) {
> +		const struct ifla_geneve_port_range *p =
> +			nla_data(data[IFLA_GENEVE_PORT_RANGE]);

nit: would be more readable as fully separate assignment

> +		if (p->high < p->low) {
> +			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_PORT_RANGE],
> +					    "Invalid source port range");
> +			return -EINVAL;
> +		}
> +	}
> +
>  	return 0;
>  }

> @@ -1450,6 +1451,11 @@ enum ifla_geneve_df {
>  	GENEVE_DF_MAX = __GENEVE_DF_END - 1,
>  };
>  
> +struct ifla_geneve_port_range {
> +	__u16 low;
> +	__u16 high;

I agree with the choice in abstract, but since VXLAN uses byte swapped
fields I think we may be setting an annoying trap for user space
implementations. I'd err on the side of consistency. No?

> +};
> +
>  /* Bareudp section  */
>  enum {
>  	IFLA_BAREUDP_UNSPEC,
-- 
pw-bot: cr

