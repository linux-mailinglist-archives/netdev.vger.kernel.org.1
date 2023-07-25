Return-Path: <netdev+bounces-21107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8862762776
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 01:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7387B281B24
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C0027714;
	Tue, 25 Jul 2023 23:38:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A368462
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 23:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E402C433C8;
	Tue, 25 Jul 2023 23:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690328293;
	bh=984JfVzqe/2uLEFyh6EUp3Mgr+B3z66EwSwgATFg6JM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M8RkHHJlmclbWyqMypVfrYwkaYk5JpmJMn3JlLzsUwJix7Gb1BafcWy3phK63LvK0
	 QuS8BjIXM41f8j9jvh30qznvw8p2zDhyqWD2YfNFPylqbCXMMJyPBdFJbO5UAGXdjP
	 lw7Sf9/m7hAORp/Job3bX5WIntYFDWrhAHc6E//RI+SXgkY4eLpuPxbzZc8UNGajb8
	 70+YDsNFKrC1isRXfEAZXHs3gjKbkqiGckhrb6JfsWLDtEnSWgEjOPRiC8JAfjW3aL
	 3WVgY+RSyFRaC+/wDFxU5ojS/zmUnTwyeiB8lWg6DFpMAkJQS8OqRNjwfsVxLC6L5U
	 8BhgUSAVLCpHw==
Message-ID: <a9854c98-627f-a496-5c0a-1cbf3f050e4f@kernel.org>
Date: Tue, 25 Jul 2023 17:38:12 -0600
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Beniamino Galvani <bgalvani@redhat.com>
References: <20230724075051.20081-1-liuhangbin@gmail.com>
 <1c9f75cc-b9c0-0f5d-9b92-b37f639ce25b@kernel.org>
 <ZL99lOAlwAsvsJU1@Laptop-X1>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZL99lOAlwAsvsJU1@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/23 1:45 AM, Hangbin Liu wrote:
>>> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>>> index 19eb4b3d26ea..53dea18a4a07 100644
>>> --- a/net/ipv6/addrconf.c
>>> +++ b/net/ipv6/addrconf.c
>>> @@ -1068,15 +1068,19 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
>>>  	     !(cfg->ifa_flags & IFA_F_MCAUTOJOIN)) ||
>>>  	    (!(idev->dev->flags & IFF_LOOPBACK) &&
>>>  	     !netif_is_l3_master(idev->dev) &&
>>> -	     addr_type & IPV6_ADDR_LOOPBACK))
>>> +	     addr_type & IPV6_ADDR_LOOPBACK)) {
>>> +		NL_SET_ERR_MSG(extack, "Cannot assign requested address");
>>>  		return ERR_PTR(-EADDRNOTAVAIL);
>>> +	}
>>
>> It would be good to split the above checks into separate ones with more
>> specific messages.
> 
> How about this.
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 53dea18a4a07..e6c3fe413441 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1063,13 +1063,17 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
>         struct fib6_info *f6i = NULL;
>         int err = 0;
> 
> -       if (addr_type == IPV6_ADDR_ANY ||
> -           (addr_type & IPV6_ADDR_MULTICAST &&
> -            !(cfg->ifa_flags & IFA_F_MCAUTOJOIN)) ||
> -           (!(idev->dev->flags & IFF_LOOPBACK) &&
> -            !netif_is_l3_master(idev->dev) &&
> -            addr_type & IPV6_ADDR_LOOPBACK)) {
> -               NL_SET_ERR_MSG(extack, "Cannot assign requested address");
> +       if (addr_type == IPV6_ADDR_ANY) {
> +               NL_SET_ERR_MSG(extack, "IPv6: Cannot assign unspecified address");

Maybe just "IPv6: Invalid address".

Also, that reminds me that IPv6 should be using NL_SET_ERR_MSG_MOD which
will add the IPv6 part.



> +               return ERR_PTR(-EADDRNOTAVAIL);
> +       } else if (addr_type & IPV6_ADDR_MULTICAST &&
> +                  !(cfg->ifa_flags & IFA_F_MCAUTOJOIN)) {
> +               NL_SET_ERR_MSG(extack, "IPv6: Cannot assign multicast address without \"IFA_F_MCAUTOJOIN\" flag");
> +               return ERR_PTR(-EADDRNOTAVAIL);
> +       } else if (!(idev->dev->flags & IFF_LOOPBACK) &&
> +                  !netif_is_l3_master(idev->dev) &&
> +                  addr_type & IPV6_ADDR_LOOPBACK) {
> +               NL_SET_ERR_MSG(extack, "IPv6: Cannot assign loopback address on this device");
>                 return ERR_PTR(-EADDRNOTAVAIL);
>         }
> 
>> ...
>>
>>>  
>>>  	if (cfg->ifa_flags & IFA_F_MCAUTOJOIN) {
>>>  		int ret = ipv6_mc_config(net->ipv6.mc_autojoin_sk,
>>>  					 true, cfg->pfx, ifindex);
>>
>> and pass extack to this one for better message as well.
> 
> This one looks a little deep. We need pass extack to
> - ipv6_mc_config
>   - ipv6_sock_mc_join
>     - __ipv6_sock_mc_join
>       - __ipv6_dev_mc_inc	maybe also this one??
> 
> to get more detailed message. And all these are "Join multicast group failed".
> Do you still want to do this?

ok, staring at the errors for that stack, not much value I guess.



