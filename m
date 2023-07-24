Return-Path: <netdev+bounces-20469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F69C75FA5B
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E9C1C20BD0
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB089D533;
	Mon, 24 Jul 2023 15:02:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760E6D530
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 15:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D7FC433C7;
	Mon, 24 Jul 2023 15:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690210964;
	bh=UxjBHdkN++vx6fWzk9QG9dF8YApCkBCzdo+fHcascaA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OtvfhghPEw7m5wutraZ/B/dbxrg/zlzQus88SwxG6qto66EGvhltzCojWV9lWxhYh
	 znRjYV/Lx3giKwwWgewOmyHlbwf9BWkCbd9kHpOm+3m4BROEV+XyCUWgHFdfT/xDB/
	 bihRtpG0EM1XgTZabNn1oz02RH5wwxKG/BkphEZmk6syb/Jt+AiJQMtuuFBnDmqaFM
	 MUkB4DZmTb9PDj9mL6RqfDzJ+mubneLeSmqa/KZM9+1JYigXkdFxexsyBtmxoo0LAT
	 583Xpcwr1hVPsk/3miv5mMIf3GlNUXgXpBxgOAHLSseut+88RNJfq5cURlhO6ZcShL
	 LunY6Vd4+XYQg==
Message-ID: <1c9f75cc-b9c0-0f5d-9b92-b37f639ce25b@kernel.org>
Date: Mon, 24 Jul 2023 09:02:42 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCHv3 net-next] IPv6: add extack info for IPv6 address
 add/delete
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Beniamino Galvani <bgalvani@redhat.com>
References: <20230724075051.20081-1-liuhangbin@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230724075051.20081-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/23 1:50 AM, Hangbin Liu wrote:
> Add extack info for IPv6 address add/delete, which would be useful for
> users to understand the problem without having to read kernel code.
> 
> Suggested-by: Beniamino Galvani <bgalvani@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v3: * Update extack message. Pass extack to addrconf_f6i_alloc().
>     * Return "IPv6 is disabled" for addrconf_add_dev(), as the same
>       with ndisc_allow_add() does.
>     * Set dup addr extack message in inet6_rtm_newaddr() instead of
>       ipv6_add_addr_hash().
> v2: Update extack msg for dead dev. Remove msg for NOBUFS error.
>     Add extack for ipv6_add_addr_hash()
> ---
>  include/net/ip6_route.h |  2 +-
>  net/ipv6/addrconf.c     | 63 +++++++++++++++++++++++++++++------------
>  net/ipv6/anycast.c      |  2 +-
>  net/ipv6/route.c        |  5 ++--
>  4 files changed, 50 insertions(+), 22 deletions(-)
> 

This patch is getting long enough, so:
Reviewed-by: David Ahern <dsahern@kernel.org>

Followup requests below. Thanks,

> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 19eb4b3d26ea..53dea18a4a07 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1068,15 +1068,19 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
>  	     !(cfg->ifa_flags & IFA_F_MCAUTOJOIN)) ||
>  	    (!(idev->dev->flags & IFF_LOOPBACK) &&
>  	     !netif_is_l3_master(idev->dev) &&
> -	     addr_type & IPV6_ADDR_LOOPBACK))
> +	     addr_type & IPV6_ADDR_LOOPBACK)) {
> +		NL_SET_ERR_MSG(extack, "Cannot assign requested address");
>  		return ERR_PTR(-EADDRNOTAVAIL);
> +	}

It would be good to split the above checks into separate ones with more
specific messages.

>  
>  	if (idev->dead) {
> -		err = -ENODEV;			/*XXX*/
> +		NL_SET_ERR_MSG(extack, "IPv6 device is going away");
> +		err = -ENODEV;
>  		goto out;
>  	}
>  
>  	if (idev->cnf.disable_ipv6) {
> +		NL_SET_ERR_MSG(extack, "IPv6 is disabled on this device");
>  		err = -EACCES;
>  		goto out;
>  	}

...

>  
>  	if (cfg->ifa_flags & IFA_F_MCAUTOJOIN) {
>  		int ret = ipv6_mc_config(net->ipv6.mc_autojoin_sk,
>  					 true, cfg->pfx, ifindex);

and pass extack to this one for better message as well.

>  
> -		if (ret < 0)
> +		if (ret < 0) {
> +			NL_SET_ERR_MSG(extack, "Multicast auto join failed");
>  			return ret;
> +		}
>  	}
>  
>  	cfg->scope = ipv6_addr_scope(cfg->pfx);



