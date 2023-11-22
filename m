Return-Path: <netdev+bounces-50166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92F7F4C15
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD051C2085D
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B18A4C3A4;
	Wed, 22 Nov 2023 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DtriJOKi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41262BD
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 08:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FY+f2qj0/72vLCisd/VN8yV9yOyc4z6I8SX1zuVOtOo=; b=DtriJOKi3vI0eepNlR+YqJ7KRJ
	rLH1hD2gw5VyWUc+LMSslCc/B37vrHEelRKrgp1+AoZvc/M38ckn4OeO7yJlcT3xk9aLCi10fpMQN
	fpEchRZglQVwCDuV9GACnfAzzs/WlT+f+gLNz9esPZP8hXl9WVIaL2qnFel8FT6eOSaw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5psX-000t8H-Rs; Wed, 22 Nov 2023 17:15:05 +0100
Date: Wed, 22 Nov 2023 17:15:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 1/5] net: wangxun: add flow control support
Message-ID: <6218df6e-db11-4640-a296-946088d32916@lunn.ch>
References: <20231122102226.986265-1-jiawenwu@trustnetic.com>
 <20231122102226.986265-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122102226.986265-2-jiawenwu@trustnetic.com>

> +	/* Calculate max LAN frame size */
> +	link = dev->mtu + ETH_HLEN + ETH_FCS_LEN + WX_ETH_FRAMING;
> +	tc = link;
> +
> +	/* Calculate delay value for device */
> +	dv_id = WX_DV(link, tc);

That looks odd. tc == link. So why pass both? Or is it a typo?

> +/* BitTimes (BT) conversion */
> +#define WX_BT2KB(BT)         (((BT) + (8 * 1024 - 1)) / (8 * 1024))
> +#define WX_B2BT(BT)          ((BT) * 8)
> +/* Calculate Interface Delay */
> +#define WX_PHY_D     12800
> +#define WX_MAC_D     4096
> +#define WX_XAUI_D    (2 * 1024)
> +#define WX_ID        (WX_MAC_D + WX_XAUI_D + WX_PHY_D)
> +/* Calculate PCI Bus delay for low thresholds */
> +#define WX_PCI_DELAY 10000
> +
> +/* Calculate delay value in bit times */
> +#define WX_DV(_max_frame_link, _max_frame_tc) \
> +	((36 * (WX_B2BT(_max_frame_link) + 672 + (2 * 5556) + (2 * WX_ID) + 6144) / \
> +	  25 + 1) +  2 * WX_B2BT(_max_frame_tc))
> +
> +/* Calculate low threshold delay values */
> +#define WX_LOW_DV(_max_frame_tc) \
> +	(2 * (2 * WX_B2BT(_max_frame_tc) + (36 * WX_PCI_DELAY / 25) + 1))

There is too much magic here. Please make these functions, and add
comments explaining what is going on here.

> +static void ngbe_get_pauseparam(struct net_device *netdev,
> +				struct ethtool_pauseparam *pause)
> +{
> +	struct wx *wx = netdev_priv(netdev);
> +
> +	pause->autoneg = !wx->fc.disable_fc_autoneg;

Maybe call it enable_fs_autoneg, since that is what the kAPI uses?

> +static int ngbe_set_pauseparam(struct net_device *netdev,
> +			       struct ethtool_pauseparam *pause)
> +{
> +	struct wx *wx = netdev_priv(netdev);
> +
> +	if (!wx->phydev)
> +		return -ENODEV;
> +
> +	if (!phy_validate_pause(wx->phydev, pause))
> +		return -EINVAL;
> +
> +	wx->fc.disable_fc_autoneg = !pause->autoneg;
> +	wx->fc.tx_pause = pause->tx_pause;
> +	wx->fc.rx_pause = pause->rx_pause;
> +
> +	phy_set_asym_pause(wx->phydev, pause->rx_pause, pause->tx_pause);

You should only be doing this if pause->autoneg is true. If it is
false, you ignore the results from autoneg, and just configure the
hardware as indicated by pause->{tr}x_pause.

phylink makes this a lot easier, because it hides away all these
details. You might want to convert to phylink. Everybody gets is wrong
with phylib, but correct with phylink.

	 Andrew

