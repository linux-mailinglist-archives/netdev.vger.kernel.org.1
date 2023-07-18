Return-Path: <netdev+bounces-18616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 411F7757FE5
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 16:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9F92815B4
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 14:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDB7D2F6;
	Tue, 18 Jul 2023 14:43:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4FEFBEE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 14:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B843FC433C7;
	Tue, 18 Jul 2023 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689691402;
	bh=bgDvRF5E5PFtVZZCHvdXqPTAMliRzTgjWef0coaWvTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BC1gk+rQApQDFTV9Wp6kIXpUUoiD8QNlWcKsLB39hT/d3LW9LoR1gJFnUiPPbeYib
	 lb8f57ErwUztOPjM+GXxTy1B7A4UiOc8/aDpq74sOE0uOyMnBNES8AORcysi3Vwic4
	 6D/5UUwc4jiIgPcUMEgIf7enSniGAjnD0gBcNIOgjMpSOolAxtRwI9/SEj7iEkHg1w
	 WnWE8/YlQTJ1zJUY2ijIBYzSDe7X+g7iQJ2LuTeZzzIvhbY8Awr4Iqk33SEQXhn5cG
	 unDAi0/dYNvkrQSYN1vcmrzOkmNRBytVUTwxj28FF0F+22+Sb1ngSLLS+Rs6zRER78
	 VQX7KSAaJRlFw==
Message-ID: <564f1ddc-cd96-4c60-8351-e9757543714e@kernel.org>
Date: Tue, 18 Jul 2023 08:43:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] IPv6: add extack info for inet6_addr_add/del
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Beniamino Galvani <bgalvani@redhat.com>
References: <20230717093316.2428813-1-liuhangbin@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230717093316.2428813-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/23 3:33 AM, Hangbin Liu wrote:
> Add extack info for inet6_addr_add(), ipv6_add_addr() and
> inet6_addr_del(), which would be useful for users to understand the
> problem without having to read kernel code.
> 
> Suggested-by: Beniamino Galvani <bgalvani@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/ipv6/addrconf.c | 66 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 48 insertions(+), 18 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index e5213e598a04..199de4b37f24 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1066,15 +1066,19 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
>  	     !(cfg->ifa_flags & IFA_F_MCAUTOJOIN)) ||
>  	    (!(idev->dev->flags & IFF_LOOPBACK) &&
>  	     !netif_is_l3_master(idev->dev) &&
> -	     addr_type & IPV6_ADDR_LOOPBACK))
> +	     addr_type & IPV6_ADDR_LOOPBACK)) {
> +		NL_SET_ERR_MSG(extack, "Cannot assign requested address");
>  		return ERR_PTR(-EADDRNOTAVAIL);
> +	}
>  
>  	if (idev->dead) {
> -		err = -ENODEV;			/*XXX*/
> +		NL_SET_ERR_MSG(extack, "No such device");

ENODEV error string gives the same information. Here we can be more
informative with something like "Device marked as dead".


> +		err = -ENODEV;
>  		goto out;
>  	}
>  
>  	if (idev->cnf.disable_ipv6) {
> +		NL_SET_ERR_MSG(extack, "IPv6 is disabled on this device");
>  		err = -EACCES;
>  		goto out;
>  	}
> @@ -1097,12 +1101,14 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
>  
>  	ifa = kzalloc(sizeof(*ifa), gfp_flags | __GFP_ACCOUNT);
>  	if (!ifa) {
> +		NL_SET_ERR_MSG(extack, "No buffer space available");

If I recall correctly, extack messages are not returned for memory
allocation failure since it will be the same as strerror(ENOMEM) and
strerror(ENOBUFS).


>  		err = -ENOBUFS;
>  		goto out;
>  	}
>  
>  	f6i = addrconf_f6i_alloc(net, idev, cfg->pfx, false, gfp_flags);
>  	if (IS_ERR(f6i)) {
> +		NL_SET_ERR_MSG(extack, "Dest allocate failed");
>  		err = PTR_ERR(f6i);
>  		f6i = NULL;
>  		goto out;
> @@ -1142,6 +1148,7 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
>  
>  	err = ipv6_add_addr_hash(idev->dev, ifa);
>  	if (err < 0) {
> +		NL_SET_ERR_MSG(extack, "IPv6 address add failed");

Add extack to ipv6_add_addr_hash and convert the debug string in that
function to to return the error.

>  		rcu_read_unlock();
>  		goto out;
>  	}


