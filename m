Return-Path: <netdev+bounces-205098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9AAFD598
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3061646F2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC952E540C;
	Tue,  8 Jul 2025 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vgUKd8v+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3952E5B0F;
	Tue,  8 Jul 2025 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996432; cv=none; b=DeCjzJ9yOanEcaz9dSvudLRkVyyq+6umveO/QwbVsmkl0IGYw9UyCYop5PJ31RzMXgdlRbHXSUnMDjCaX3nw+vr1VAzopUcAEMHySGGeD7iOj+qR626wsrx8gY+cOXJVNFIHwINjzSqiXl2igQ7R/IAeLlaEq089HscmDcrATYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996432; c=relaxed/simple;
	bh=q8ErWWZB3bgtRnMHAOkyZzK9sHEQJyJpk0dmHap0jg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gg1Wh9nNELbVZ2hSC4lfRTFvqs7ql31IPTc1/zVE2VfFXNwOgI5eBPkAJSjTl3qQjEPD89EutMbIbk846Q1IL3X+z7tPdfwn1xLz6VeeEZt9WAHCFZw6KMRmOtO7igdQLPaO0VyYNKHlQ6kcob/sy3X3Z+mUPi/GDsHFkyddL1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vgUKd8v+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rzBPjq7zJ/E4WWNdaVu+VzaEbNExyKV4C2BkFHWH5JM=; b=vgUKd8v++Eqkxpg6mZRw6MBhUs
	L6B0/4PxzDGgU3aatVWOahA8IabF7XTcbn54qC5w0KfxKVHMEx6UT45rPfIXoM68b5HIzawTXC3Wn
	IY+4vJFuwmsqlGuSP8twmV2XkJH8rnJg1vrr0W4AfqULD9obkLggL0RfSexdLwHHLyJg8vro3/A34
	rSDwrKVBx4FMZ9Es4iFaZtg9q6qEU4jk7yPGm4tLCEDcZnNWTS4TWEI5tUDmJW2wTYc+xXXg29AKY
	8t9zgN2X4OVHXC5W4zeYXzKxwdp9BNVktd58g0dHu0E4YA5/SgPAgoBvH6HCRIlyzN5DuQeZYcJ+x
	YvrFdBRw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35708)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uZCIf-0006vc-11;
	Tue, 08 Jul 2025 18:40:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uZCIY-0001nm-3D;
	Tue, 08 Jul 2025 18:40:07 +0100
Date: Tue, 8 Jul 2025 18:40:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Lizhe <sensor1010@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, vladimir.oltean@nxp.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Support gpio high-level reset for devices
 requiring it
Message-ID: <aG1X9pPYDGO8kfM9@shell.armlinux.org.uk>
References: <20250708165044.3923-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708165044.3923-1-sensor1010@163.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 08, 2025 at 09:50:44AM -0700, Lizhe wrote:
> some devices only reset when the GPIO is at a high level, but the
> current function lacks support for such devices. add high-level
> reset functionality to the function to support devices that require
> high-level triggering for reset
> 
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index 836f2848dfeb..cb989e6d7eac 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -458,6 +458,7 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>  
>  #ifdef CONFIG_OF
>  	if (priv->device->of_node) {
> +		int active_low = 0;
>  		struct gpio_desc *reset_gpio;
>  		u32 delays[3] = { 0, 0, 0 };
>  
> @@ -467,6 +468,9 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>  		if (IS_ERR(reset_gpio))
>  			return PTR_ERR(reset_gpio);
>  
> +		if (reset_gpio)
> +			active_low = gpiod_is_active_low(reset_gpio);
> +
>  		device_property_read_u32_array(priv->device,
>  					       "snps,reset-delays-us",
>  					       delays, ARRAY_SIZE(delays));
> @@ -474,11 +478,11 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>  		if (delays[0])
>  			msleep(DIV_ROUND_UP(delays[0], 1000));
>  
> -		gpiod_set_value_cansleep(reset_gpio, 1);
> +		gpiod_set_value_cansleep(reset_gpio, active_low ? 1 : 0);
>  		if (delays[1])
>  			msleep(DIV_ROUND_UP(delays[1], 1000));
>  
> -		gpiod_set_value_cansleep(reset_gpio, 0);
> +		gpiod_set_value_cansleep(reset_gpio, active_low ? 0 : 1);
>  		if (delays[2])
>  			msleep(DIV_ROUND_UP(delays[2], 1000));
>  	}

NAK. Not required. The GPIO layer can cope with active-high and
active-low signals declared in firmware without needing driver
modification. Use the right data in the firmware and you don't
need to patch.

/* Bit 0 express polarity */
#define GPIO_ACTIVE_HIGH 0
#define GPIO_ACTIVE_LOW 1

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

