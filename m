Return-Path: <netdev+bounces-124344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62167969126
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 03:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8A2281D52
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 01:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3031CCEE0;
	Tue,  3 Sep 2024 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEesa1yz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DF91A4E6B;
	Tue,  3 Sep 2024 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725328545; cv=none; b=pjDbuPEMgPKmtxpjnn6QVLbW+FZlsM9TrbhRuB+3ZFYJXrPBaNzlbNDUlqH63NdhzgWClxPFTLpAS6kR2fqSiKdxT1GixrFY5gw5f9Ini7uZ7lZojzZw5SSezk+zIXlh0jk/lT3Vh6HfC9iDcuBr3sSpjclXO51sVGU20h1kOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725328545; c=relaxed/simple;
	bh=v8xWr6M2051Rwz9iwqMbOx4x+nrK2/zcfwCjvgZQXZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TABsuVyVoexJXjymBdh2kbcaV8D8zVft1f6/9by4+GKxf344ynPQ7lXn4WsCDXLHhXNvgza9WsGSQPrCQXeP4fSP8+UeuyPqFYKLv6JDv9cwNUjI8z6lPqrVJzAupDOutGezJ/UZQgdR7tNQMvhUS6a8X3A6dhIZM5VKSD8SF5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEesa1yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84481C4CEC2;
	Tue,  3 Sep 2024 01:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725328545;
	bh=v8xWr6M2051Rwz9iwqMbOx4x+nrK2/zcfwCjvgZQXZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JEesa1yzSepQanqA9PAXiL0AFqAwvxbRHqcqGpnIt58f47jqrp2kgaMwfuG0WRC1J
	 FnZfk2vgxSmniECctuc+gheU7NsOMjIrm51uppOvyzySjT76RnaL/0ElCSAAALDjwy
	 imh66B3rf2Co1GVqMTgLVFwWoZmzbsMDsuX9t6rFas/iYyT3hQo4SNq2lVr2gMJ426
	 IhwMImH0FRszRVnYYEaBwTYNFxJnEoUBTtaH4bJEYKH/xm5X/8HPGQjEL4ukKTz1ek
	 6knDoCMqfgTTqFtqXMh6Xz/dkmkzqYOBpQv4PaWChR+1BNcN5dEkmLFZIaT2Rk2lCo
	 WwAFqNDbnTaFg==
Date: Mon, 2 Sep 2024 18:55:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 Simon Horman <horms@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 7/7] net: ethernet: fs_enet: phylink
 conversion
Message-ID: <20240902185543.48d91e87@kernel.org>
In-Reply-To: <20240829161531.610874-8-maxime.chevallier@bootlin.com>
References: <20240829161531.610874-1-maxime.chevallier@bootlin.com>
	<20240829161531.610874-8-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 18:15:30 +0200 Maxime Chevallier wrote:
> @@ -582,15 +591,12 @@ static void fs_timeout_work(struct work_struct *work)
>  
>  	dev->stats.tx_errors++;
>  
> -	spin_lock_irqsave(&fep->lock, flags);
> -
> -	if (dev->flags & IFF_UP) {
> -		phy_stop(dev->phydev);
> -		(*fep->ops->stop)(dev);
> -		(*fep->ops->restart)(dev);
> -	}
> +	rtnl_lock();

so we take rtnl_lock here..

> +	phylink_stop(fep->phylink);
> +	phylink_start(fep->phylink);
> +	rtnl_unlock();
>  
> -	phy_start(dev->phydev);
> +	spin_lock_irqsave(&fep->lock, flags);
>  	wake = fep->tx_free >= MAX_SKB_FRAGS &&
>  	       !(CBDR_SC(fep->cur_tx) & BD_ENET_TX_READY);
>  	spin_unlock_irqrestore(&fep->lock, flags);

> @@ -717,19 +686,18 @@ static int fs_enet_close(struct net_device *dev)
>  	unsigned long flags;
>  
>  	netif_stop_queue(dev);
> -	netif_carrier_off(dev);
>  	napi_disable(&fep->napi);
>  	cancel_work_sync(&fep->timeout_work);

..and cancel_work_sync() under rtnl_lock here?

IDK if removing the the "dev->flags & IFF_UP" check counts as
meaningfully making it worse, but we're going in the wrong direction.
The _sync() has to go, and the timeout work needs to check if device
has been closed under rtnl_lock ?


> -	phy_stop(dev->phydev);
> +	phylink_stop(fep->phylink);
>  
>  	spin_lock_irqsave(&fep->lock, flags);
>  	spin_lock(&fep->tx_lock);
>  	(*fep->ops->stop)(dev);
>  	spin_unlock(&fep->tx_lock);
>  	spin_unlock_irqrestore(&fep->lock, flags);
> +	phylink_disconnect_phy(fep->phylink);
>  
>  	/* release any irqs */
> -	phy_disconnect(dev->phydev);
>  	free_irq(fep->interrupt, dev);
>  
>  	return 0;

