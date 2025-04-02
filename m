Return-Path: <netdev+bounces-178866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AF3A793D4
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC7F189430F
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047161A5B84;
	Wed,  2 Apr 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RMl6pwh7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159919F419;
	Wed,  2 Apr 2025 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743614734; cv=none; b=rioZif87PY8xKJhKbfngjnJlFkcOsJ0agXucAI3QVZImgeq2lTbi+CMMtAOlAiTdT1Zix4GI3jGyYCfPzDRyHdr9YDSSsH7kER+C0TSD/i5b3c4ayMDDUjS1TTZ6NzYxi6tpKLUfiPjsXViY7q+LisHaJSwj6ZVkTqbAf9NpX9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743614734; c=relaxed/simple;
	bh=LfkI45sM3YwHB2enwUiXol6GeCWXUbXnj6SA8oIs1Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCUF45iHzfHUsvcXaktJe/36FD5GS5KKNFm0HGO5TRcaVV4SGFZt0zVfNuFlvYvJMm5l1RaUDI8rdMhPul2hrrzGUQ38ZGlRxHfdofybhmIGBRSqSHmd5ETtP5ax7SyZ7J5MiS1xBjX5xJN9trSnC9MmKXWapRckzDi2o14atiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RMl6pwh7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xjco1YDCuCbUrUVk9eoDRqqrWkwQL1ZF+I2sBO+WXM0=; b=RMl6pwh75Bzrg4n8XUqQumdAhq
	r7bf/esLZkLWq5tdGo7DCRJjs6s+20yHYnFhS8xLJFGqxl8IN/xYZPnl44qzWgc2FKbixRjYxUb5a
	S8EUYlG1ovYbe545rofh7kSeu3eZzgH6MFGZOOiTvvYgX4xkuMJSAvk1K4S30TmQSM7o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u01q7-007pcw-SY; Wed, 02 Apr 2025 19:25:23 +0200
Date: Wed, 2 Apr 2025 19:25:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] net: mtip: The L2 switch driver for imx287
Message-ID: <33394d5b-9a67-4acc-bdd1-bf43dc3bd8ab@lunn.ch>
References: <20250331103116.2223899-1-lukma@denx.de>
 <20250331103116.2223899-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331103116.2223899-5-lukma@denx.de>

> +struct switch_enet_private *mtip_netdev_get_priv(const struct net_device *ndev)
> +{
> +	if (ndev->netdev_ops == &mtip_netdev_ops)
> +		return netdev_priv(ndev);
> +
> +	return NULL;
> +}

> +static bool mtip_port_dev_check(const struct net_device *ndev)
> +{
> +	if (!mtip_netdev_get_priv(ndev))
> +		return false;
> +
> +	return true;
> +}
> +

Rearranging the code a bit to make my point....

mtip_port_dev_check() tells us if this ndev is one of the ports of
this switch.

> +/* netdev notifier */
> +static int mtip_netdevice_event(struct notifier_block *unused,
> +				unsigned long event, void *ptr)
> +{
> +	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
> +	struct netdev_notifier_changeupper_info *info;
> +	int ret = NOTIFY_DONE;
> +
> +	if (!mtip_port_dev_check(ndev))
> +		return NOTIFY_DONE;

We have received a notification about some interface. This filters out
all but the switches interfaces.

> +
> +	switch (event) {
> +	case NETDEV_CHANGEUPPER:
> +		info = ptr;

CHANGERUPPER is that a netdev has been added or removed from a bridge,
or some other sort of master device, e.g. a bond.

> +
> +		if (netif_is_bridge_master(info->upper_dev)) {
> +			if (info->linking)
> +				ret = mtip_ndev_port_link(ndev,
> +							  info->upper_dev);

Call mtip_ndev_port_link() has been added to some bridge.

> +static int mtip_ndev_port_link(struct net_device *ndev,
> +			       struct net_device *br_ndev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(ndev);
> +	struct switch_enet_private *fep = priv->fep;
> +
> +	dev_dbg(&ndev->dev, "%s: ndev: %s br: %s fep: 0x%x\n",
> +		__func__, ndev->name,  br_ndev->name, (unsigned int)fep);
> +
> +	/* Check if MTIP switch is already enabled */
> +	if (!fep->br_offload) {
> +		if (!priv->master_dev)
> +			priv->master_dev = br_ndev;
> +
> +		fep->br_offload = 1;
> +		mtip_switch_dis_port_separation(fep);
> +		mtip_clear_atable(fep);
> +	}

So lets consider

ip link add br0 type bridge
ip link add br1 type bridge
ip link set dev lan1 master br0

We create two bridges, and add the first port to one of the bridges.

fep->br_offload should be False
priv->master_dev should be NULL.

So fep->br_offload is set to 1, priv->master_dev is set to br0 and the
separation between the ports is removed.

It seems like the hardware will now be bridging packets between the
two interfaces, despite lan2 not being a member of any bridge....

Now

ip link set dev lan2 master br1

I make the second port a member of some other bridge. fep->br_offload
is True, so nothing happens.

This is why i said this code needs expanding.

If you look at other switch drivers, you will see each port keeps
track of what bridge it has been joined to. There is then logic which
iterates over the ports, finds which ports are members of the same
bridge, and enables packets to flow between those ports.

With only two ports, you can make some simplifications, but you should
only disable the separation once both ports are the member of the same
bridge.

	Andrew

