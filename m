Return-Path: <netdev+bounces-181398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FC5A84C93
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 21:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99B53B47E5
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A302328D823;
	Thu, 10 Apr 2025 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLopckpM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FBC2853EE;
	Thu, 10 Apr 2025 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312060; cv=none; b=GnzfeHpVqs3ArCpkY1IvfOoiRe99jqgF2hdCXj65UTceCpwbg7XDM/nngW/xiqn3RueMAgS8hLf2/Hka+w1a4FIyTY0PMo6KACC2+7fqtZ3yBm5G2hZ/VqZ7pck8tf22E1Kvt57+AU574hzW/QiLxiBiULUQjq3OFGq/tKjdRCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312060; c=relaxed/simple;
	bh=9LzDhagF1B/m2ytbn3Sp4CBEK7Ris0Pmu1ba2tDdU0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JK4EUm9xyTBQEPYUdeg/8v9aCiJemQCF7GNQxKRldMKJIppMgmDwUrED/gCbWGg8DNtU9PQfLGIxI30RWbQEeX4mxSF6RsSEmB3F+VRF6hH8EHP7havU+NsPL7Hyoc57q1BgN3/cVeTsY9WByd62SWdhQvqy+eOSIoaurbn2QHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLopckpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB136C4CEDD;
	Thu, 10 Apr 2025 19:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744312059;
	bh=9LzDhagF1B/m2ytbn3Sp4CBEK7Ris0Pmu1ba2tDdU0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLopckpMOaw2ss8AP4md5j7yUBTlWXUYEVbolOQZATbdY3kBcAvYGq7IuSF/3ACav
	 MC7Wn4ho2da//78A7fzeoumwGxh/FvbRF254J8mM24rIfoteD7S9mKnKZM5ZeUOoP2
	 cdzBHrsbi+0CCfTDiaUZLJIl0uXZOVPOv5snv2REC4WbhH0Z0wcf3p8DLrk1lASXCB
	 WVPwmmz7wTp3oXZzFl4q9MQJ2MTnQ7uYiaOK3hFcueSZkXSjqJItJEjBZW1GeacudA
	 Sn/ocE8Islx6tS6l9qyuM10986xbqWFPYY/2cIO60HE3CeSG5oXNq+LjvN8DxIt4bO
	 3OVSRNuXoCNLQ==
Date: Thu, 10 Apr 2025 20:07:33 +0100
From: Simon Horman <horms@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH v2 2/2] net: phy: mediatek: add Airoha PHY ID to
 SoC driver
Message-ID: <20250410190733.GV395307@horms.kernel.org>
References: <20250410100410.348-1-ansuelsmth@gmail.com>
 <20250410100410.348-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410100410.348-2-ansuelsmth@gmail.com>

On Thu, Apr 10, 2025 at 12:04:04PM +0200, Christian Marangi wrote:
> Airoha AN7581 SoC ship with a Switch based on the MT753x Switch embedded
> in other SoC like the MT7581 and the MT7988. Similar to these they
> require configuring some pin to enable LED PHYs.
> 
> Add support for the PHY ID for the Airoha embedded Switch and define a
> simple probe function to toggle these pins. Also fill the LED functions
> and add dedicated function to define LED polarity.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

...

> diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c

...

> +static int an7581_phy_led_polarity_set(struct phy_device *phydev, int index,
> +				       unsigned long modes)
> +{
> +	u32 mode;
> +	u16 val;
> +
> +	if (index >= MTK_PHY_MAX_LEDS)
> +		return -EINVAL;
> +
> +	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
> +		switch (mode) {
> +		case PHY_LED_ACTIVE_LOW:
> +			val = MTK_PHY_LED_ON_POLARITY;
> +			break;
> +		case PHY_LED_ACTIVE_HIGH:
> +			val = 0;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
> +			      MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
> +			      MTK_PHY_LED_ON_POLARITY, val);

Hi Christian,

Perhaps this cannot occur in practice, but if the for_each_set_bit
loop iterates zero times then val will be used uninitialised here.

Flagged by Smatch.

> +}

...

