Return-Path: <netdev+bounces-114768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E235A943FE0
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 03:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6601C22D26
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 01:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5AD146A6E;
	Thu,  1 Aug 2024 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0HxnOME3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B60B13DDC6;
	Thu,  1 Aug 2024 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474654; cv=none; b=hUZKN4bNQf9/epYzdrT5OZlBbL0WF8VkbnW6jjDUCr1hDFi+9aZ0ArZ/9LtlVJm/fykf2bvghzOpWodB8de8KEl1+D7oa9p3dIzWtv+i9wxcEOZhOZtRokdSw/Fz5KAQQuqWqFDV6FMdJyfvj5MYpJoIKNEy0VYTq9Xq5pq35+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474654; c=relaxed/simple;
	bh=CAJJgmIakQYNVPki7gaEEI+Ck1Xo4hCVjFbvhPu982g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnXxVG7G+aJFA8btq1Lt1GeZX1bxhqnlwmSLBjz3X8e7u45XfLSahH1U/qCtv9PsOtTzf7tBLj/2K6VIFoHM8E8OYTO6E2oKesA6L9mrFyVd7ZfLsNu8kZsTiBelb42zdtl6X/5GToDmQetOMc0zUrIImk0LNUzUhnqRUX7cg2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0HxnOME3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=x0erb+7biLuDSDsPYnc54prG9SaFPCLd+R+sOW39uF4=; b=0HxnOME3H0a8NEJQDPxWX69CwY
	LX8ddzg2HW46JS2Txy4WCPoDOdTtJeRKa3X3HLd2gh/ZGgM6BxiE4p5iXheU1gt7jIkFJ1EKbKjyr
	cZBMLr/h3r5KQykz0eHFxm0CLkHrhOROeh3W03gy/Idga6GM/QuF2kqJWwmz8M+TnFb4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZKL3-003j3k-KF; Thu, 01 Aug 2024 03:10:41 +0200
Date: Thu, 1 Aug 2024 03:10:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 08/10] net: hibmcge: Implement workqueue and
 some ethtool_ops functions
Message-ID: <b20b5d68-2dab-403c-b37b-084218e001bc@lunn.ch>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-9-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731094245.1967834-9-shaojijie@huawei.com>

> +static void hbg_ethtool_get_drvinfo(struct net_device *netdev,
> +				    struct ethtool_drvinfo *drvinfo)
> +{
> +	strscpy(drvinfo->version, HBG_MOD_VERSION, sizeof(drvinfo->version));
> +	drvinfo->version[sizeof(drvinfo->version) - 1] = '\0';

A version is pointless, it tells you nothing useful. If you don't
touch version, the core will fill it with the uname, so you know
exactly what kernel this is, which is useful.

> +static u32 hbg_ethtool_get_link(struct net_device *netdev)
> +{
> +	struct hbg_priv *priv = netdev_priv(netdev);
> +
> +	return priv->mac.link_status;
> +}
> +
> +static int hbg_ethtool_get_ksettings(struct net_device *netdev,
> +				     struct ethtool_link_ksettings *ksettings)
> +{
> +	struct hbg_priv *priv = netdev_priv(netdev);
> +
> +	phy_ethtool_ksettings_get(priv->mac.phydev, ksettings);

You can avoid this wrapper since phy_attach_direct sets netdev->phydev
to phydev. You can then call phy_ethtool_get_link_ksettings() etc.

> +static int hbg_ethtool_set_ksettings(struct net_device *netdev,
> +				     const struct ethtool_link_ksettings *cmd)
> +{
> +	struct hbg_priv *priv = netdev_priv(netdev);
> +
> +	if (cmd->base.speed == SPEED_1000 && cmd->base.duplex == DUPLEX_HALF)
> +		return -EINVAL;

So long as you have told phylib about not supporting 1000Base/Half,
phy_ethtool_set_link_ksettings() will return an error for you.

> +static const struct ethtool_ops hbg_ethtool_ops = {
> +	.get_drvinfo		= hbg_ethtool_get_drvinfo,
> +	.get_link		= hbg_ethtool_get_link,

Why not ethtool_op_get_link() ?

> +	.get_link_ksettings	= hbg_ethtool_get_ksettings,
> +	.set_link_ksettings	= hbg_ethtool_set_ksettings,
> +};
> +static void hbg_update_link_status(struct hbg_priv *priv)
> +{
> +	u32 link;
> +
> +	link = hbg_get_link_status(priv);
> +	if (link == priv->mac.link_status)
> +		return;
> +
> +	priv->mac.link_status = link;
> +	if (link == HBG_LINK_DOWN) {
> +		netif_carrier_off(priv->netdev);
> +		netif_tx_stop_all_queues(priv->netdev);
> +		dev_info(&priv->pdev->dev, "link down!");
> +	} else {
> +		netif_tx_wake_all_queues(priv->netdev);
> +		netif_carrier_on(priv->netdev);
> +		dev_info(&priv->pdev->dev, "link up!");
> +	}
> +}

Why do you need this? phylib will poll the PHY once per second and
call the adjust_link callback whenever the link changes state.

> @@ -177,12 +226,17 @@ static int hbg_init(struct net_device *netdev)
>  	ret = hbg_irq_init(priv);
>  	if (ret)
>  		return ret;
> -
>  	ret = devm_add_action_or_reset(&priv->pdev->dev, hbg_irq_uninit, priv);

This white space change does not belong here.

     Andrew

