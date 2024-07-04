Return-Path: <netdev+bounces-109229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 394B39277A2
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D379F1F26497
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DE51ABC25;
	Thu,  4 Jul 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RSyWU75G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2A2F37;
	Thu,  4 Jul 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101710; cv=none; b=B6aD0PasNMWgKLItbWc398vH8oILiQPYkBvPVepmFDKRWOLPEgeboeWiv2Ao7zssExLddy88XDx2RpmoGd0wXSKleHtNdIGkMbKUP0xNP9oCYXuHpqgomcVA2aJ0GoGCmjUYCOvgmefJrCD3yXHrcr+SsK2yMhgpMv4K+dUmd3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101710; c=relaxed/simple;
	bh=H5Uew8F2uXvEpeO76s6GsNJFSC8jO/pWdK+eFV2lhsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNhRipHM1YgQSSoc31zN8aZG42R/bxzNovtkBSZpvH/PJYj3MCPVW9vM9fsIPB2R6xKpbsDxAr47w5OHOeOzfZDd6My0v8Yrv5F6CM7SOGGA3qYi36zahD5CoX17pXfZD8j5Eh2W3jiX0sUvovI08LjIY0f7MBT2hHUBaYOCijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RSyWU75G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dk4Niv3otUMwysFaaWf12wUtBDt6vqrPW64ZZuSzVzk=; b=RSyWU75GYpDDW6nYKA0tPDxeiX
	CuosGDsAFhLkOEVroKGteQkj2w747LfTcfn+VtzCZGm5LcOoRVCeA0qpebHLAuzcVyO1Bh0xksZJz
	H+Ux2ifXRph8HZufCRpWn2z5Hq45XfgABPUu8Eh/Grxw9UHb75Yce6v+7J8MJUvZ9v9k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sPN1f-001oUO-8j; Thu, 04 Jul 2024 16:01:31 +0200
Date: Thu, 4 Jul 2024 16:01:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Michal Kubecek <mkubecek@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Woojung.Huh@microchip.com, kernel@pengutronix.de,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] ethtool: netlink: do not return SQI value if
 link is down
Message-ID: <dbfa3bc1-fff0-4dc7-a9f2-6cd304d4eaf8@lunn.ch>
References: <20240704054007.969557-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704054007.969557-1-o.rempel@pengutronix.de>

On Thu, Jul 04, 2024 at 07:40:07AM +0200, Oleksij Rempel wrote:
> Do not attach SQI value if link is down. "SQI values are only valid if link-up
> condition is present" per OpenAlliance specification of 100Base-T1
> Interoperability Test suite [1]. The same rule would apply for other link
> types.
> 
> [1] https://opensig.org/automotive-ethernet-specifications/#
> 
> Fixes: 8066021915924 ("ethtool: provide UAPI for PHY Signal Quality Index (SQI)")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  net/ethtool/linkstate.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
> index b2de2108b356a..370ae628b13a4 100644
> --- a/net/ethtool/linkstate.c
> +++ b/net/ethtool/linkstate.c
> @@ -37,6 +37,8 @@ static int linkstate_get_sqi(struct net_device *dev)
>  	mutex_lock(&phydev->lock);
>  	if (!phydev->drv || !phydev->drv->get_sqi)
>  		ret = -EOPNOTSUPP;
> +	else if (!phydev->link)
> +		ret = -ENETDOWN;
>  	else
>  		ret = phydev->drv->get_sqi(phydev);
>  	mutex_unlock(&phydev->lock);
> @@ -55,6 +57,8 @@ static int linkstate_get_sqi_max(struct net_device *dev)
>  	mutex_lock(&phydev->lock);
>  	if (!phydev->drv || !phydev->drv->get_sqi_max)
>  		ret = -EOPNOTSUPP;
> +	else if (!phydev->link)
> +		ret = -ENETDOWN;
>  	else
>  		ret = phydev->drv->get_sqi_max(phydev);
>  	mutex_unlock(&phydev->lock);

I guess this part is optional. I think i've always seen hard coded
values. But this is O.K.

> @@ -93,12 +97,12 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
>  	data->link = __ethtool_get_link(dev);
>  
>  	ret = linkstate_get_sqi(dev);
> -	if (ret < 0 && ret != -EOPNOTSUPP)
> +	if (ret < 0 && ret != -EOPNOTSUPP && ret != -ENETDOWN)
>  		goto out;
>  	data->sqi = ret;

So data->sqi becomes -ENETDOWN 


> -	if (data->sqi != -EOPNOTSUPP &&
> +	if (data->sqi != -EOPNOTSUPP && data->sqi != -ENETDOWN &&
>  	    nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI, data->sqi))
>  		return -EMSGSIZE;

Thinking about the old code, if the driver returned something other
than -EOPNOTSUPP, it looks like the error code would make it to user
space. Is ethtool/iproute2 setup to correctly handle this? If it is,
maybe pass the -ENETDOWN to user space?

	Andrew

