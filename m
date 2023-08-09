Return-Path: <netdev+bounces-25919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B93C7762AC
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25431280A7A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8CD18B03;
	Wed,  9 Aug 2023 14:40:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CA02CA4
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEFDC433C8;
	Wed,  9 Aug 2023 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691592001;
	bh=t6FjFc3AES2KACSvBk65Vzki7TTeide32e508stIQPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iH/uNjKqst+lY51K1kZDshSOoR+reeILLpdtz8Ao14jstCiZMIKIepAR1KjxSIByQ
	 ThlyHk8zjv/VdlVDLzyVj/Mf0RCbuGjc74ES7OxcffFuCl8I+9syQYqTiqzP//7wm7
	 MTd9Urzs7nOpKPM+sJiInjD/0DW8xmVSL9WmIo+m/n0Kx6AvklgRwe9zaxKSUutARI
	 2YmSzN9UCyK4Yc/tU9gdaCOYk7EvaXf5dh2grULVHSCxSCU8wU6ZRa3QDo1eWrdOAt
	 ugZD+2wHve4uJSQCiRbgglp69eq/DxdvctVWuZWEeH4AqVQ1x+e33sUMz2vWZJwJbW
	 nyxrmenqljSAA==
Date: Wed, 9 Aug 2023 16:39:57 +0200
From: Simon Horman <horms@kernel.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: geoff@infradead.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -next] net/ps3_gelic_net: Use ether_addr_to_u64() to
 convert ethernet address
Message-ID: <ZNOlPdxAPzIcB0Ij@vergenet.net>
References: <20230808114050.4034547-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808114050.4034547-1-lizetao1@huawei.com>

On Tue, Aug 08, 2023 at 07:40:50PM +0800, Li Zetao wrote:
> Use ether_addr_to_u64() to convert an Ethernet address into a u64 value,
> instead of directly calculating, as this is exactly what
> this function does.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/net/ethernet/toshiba/ps3_gelic_net.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> index 9d535ae59626..77a02819e412 100644
> --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> @@ -596,7 +596,6 @@ void gelic_net_set_multi(struct net_device *netdev)
>  	struct gelic_card *card = netdev_card(netdev);
>  	struct netdev_hw_addr *ha;
>  	unsigned int i;

Hi Li Zetao,

It looks like i is now unused in this function and should be removed.

> -	uint8_t *p;
>  	u64 addr;
>  	int status;
>  
> @@ -629,12 +628,7 @@ void gelic_net_set_multi(struct net_device *netdev)
>  
>  	/* set multicast addresses */
>  	netdev_for_each_mc_addr(ha, netdev) {
> -		addr = 0;
> -		p = ha->addr;
> -		for (i = 0; i < ETH_ALEN; i++) {
> -			addr <<= 8;
> -			addr |= *p++;
> -		}
> +		addr = ether_addr_to_u64(ha->addr);
>  		status = lv1_net_add_multicast_address(bus_id(card),
>  						       dev_id(card),
>  						       addr, 0);
> -- 
> 2.34.1

-- 
pw-bot: changes-requested

