Return-Path: <netdev+bounces-207539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920DDB07B52
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C45508143
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF7923FC42;
	Wed, 16 Jul 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y5FJ2XgP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51061D528;
	Wed, 16 Jul 2025 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752683960; cv=none; b=cN7LDKld0ZFYAF4+gMzcvOxSLzyy9cJjsb7caqiRJJV6r7+N1s3ENH8Fr+FJbf6lt9JjpS/IBkXUC5wV3KKnFGheoHDwasN6cMiDza/XIpTSE0Gs968CwIwr8w+sYD1BhjUJ+IYFq/r4uV/uTOg0Fx7avz98adq667TGIIJ6T3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752683960; c=relaxed/simple;
	bh=W8xgVhhwZWuTdjr7lS0rwtLzvbY4CBMrrpJ7DWC87Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzCfmP7gEYvwLenacOaSau6KD9dFbTRPkZfcFQfktMNnwlgq/QIzK3CfqTC8g0qabhMkwBJszM4btTGSwvyorIBcGnoNRi/ibMrIF4PWbxwpg+awq6il+DIH6ftIJgtIp9dHIYcPXZYh0Mlph+3RT0TmGS3KIWHxRAp5zY/sKXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y5FJ2XgP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7EI7/tzVVxb3gkfkxEXZPPT7eC9VGWHM194adz+fKxk=; b=y5FJ2XgPCb7mWK2aDISMIxvNXP
	RtKFjkvDvvPGTMXJoi1z5hrniOzTgQcMskEXX7a5F2UdynJqyX+noLw/DiFUJSxaEMy1yDBwy32xa
	GayO+h6h9n2g6gcqCeOqrFBw7fYR8POnhEBeFvdELMInTRXtnsnDp6OfywDtmNUgOl/Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uc59o-001hvE-V6; Wed, 16 Jul 2025 18:39:00 +0200
Date: Wed, 16 Jul 2025 18:39:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: motorcomm: Add support for PHY
 LEDs on YT8521
Message-ID: <4a622284-66db-49c4-943f-5da1f1a6ba65@lunn.ch>
References: <20250716100041.2833168-1-shaojijie@huawei.com>
 <20250716100041.2833168-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716100041.2833168-2-shaojijie@huawei.com>

On Wed, Jul 16, 2025 at 06:00:40PM +0800, Jijie Shao wrote:
> Add minimal LED controller driver supporting
> the most common uses with the 'netdev' trigger.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/phy/motorcomm.c | 120 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 0e91f5d1a4fd..e1a1c3a1c9d0 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -213,6 +213,23 @@
>  #define YT8521_RC1R_RGMII_2_100_NS		14
>  #define YT8521_RC1R_RGMII_2_250_NS		15
>  
> +/* LED CONFIG */
> +#define YT8521_MAX_LEDS				3
> +#define YT8521_LED0_CFG_REG			0xA00C
> +#define YT8521_LED1_CFG_REG			0xA00D
> +#define YT8521_LED2_CFG_REG			0xA00E
> +#define YT8521_LED_ACT_BLK_IND			BIT(13)
> +#define YT8521_LED_FDX_ON_EN			BIT(12)
> +#define YT8521_LED_HDX_ON_EN			BIT(11)
> +#define YT8521_LED_TXACT_BLK_EN			BIT(10)
> +#define YT8521_LED_RXACT_BLK_EN			BIT(9)
> +/* 1000Mbps */
> +#define YT8521_LED_GT_ON_EN			BIT(6)
> +/* 100Mbps */
> +#define YT8521_LED_HT_ON_EN			BIT(5)
> +/* 10Mbps */
> +#define YT8521_LED_BT_ON_EN			BIT(4)

Rather than comments, why not call these YT8521_LED_1000_ON_EN,
YT8521_LED_100_ON_EN, YT8521_LED_100_ON_EN ? That makes the rest of
the driver easier to read.

> +static int yt8521_led_hw_control_get(struct phy_device *phydev, u8 index,
> +				     unsigned long *rules)
> +{
> +	int val;
> +
> +	if (index >= YT8521_MAX_LEDS)
> +		return -EINVAL;
> +
> +	val = ytphy_read_ext(phydev, YT8521_LED0_CFG_REG + index);
> +	if (val < 0)
> +		return val;
> +
> +	if (val & YT8521_LED_TXACT_BLK_EN)
> +		set_bit(TRIGGER_NETDEV_TX, rules);
> +
> +	if (val & YT8521_LED_RXACT_BLK_EN)
> +		set_bit(TRIGGER_NETDEV_RX, rules);

This looks to be missing YT8521_LED_ACT_BLK_IND.

    Andrew

---
pw-bot: cr

