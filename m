Return-Path: <netdev+bounces-132030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952E79902B0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C436F1C215CD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BAF15B11D;
	Fri,  4 Oct 2024 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qqOsVPUC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987EE1494D4;
	Fri,  4 Oct 2024 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043693; cv=none; b=QsUyI/vlJEYIorWEmdiviGJfYUwOOvQsayMVIuZiBQ8aXeLNk8X1FcLTPstYWey5AQVII78ULasnTJbqy3zCzIjLh2EcbV4gGMvCN3LT6uNr/cBQZmy4H8TC2dX1/cbvmPD2MebjXojQtz8+2OmQU6cSMCCVstQIjYHJXjMhJyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043693; c=relaxed/simple;
	bh=FiSZSy/7mmJmtWGTNZA0nZxQ9VRZYcf5NldOZufVz8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQgxD8GMZX7t33iL806DjiAEselVRCK8UpIm1Qs2pQYgT2TbRXOsro5S8JgSpk7BNQcNTsXykq24xUkWDzrt4FgP+716EWpdisAj+TV/iVt/SRRtM8bumEwk05QHSY+pooSKb9aP1b1dzZF2Dt6L2W6MVWJVImntZsrqRR22x98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qqOsVPUC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gjkpj7klBDx4CtJ5kaQxWvklTYn7Jg83Vuq32kjyQEA=; b=qqOsVPUC7pi+5Idm9LgCg/j6Ts
	0CfnRuuIZesmuPfkSBRC8LGDUQw55gLfwTnw022eB4RdQPSXHCydnY+s0QBAsB7PkmviwNEOzQO6y
	+NWPYhl+ravyBhbNfpAdK8NwumIR1ozgD9qjibiDHZpMSPs7kUtYatX9c+4hMHzoogWQsw+WMRPLy
	dwjs/5YBseAuAzC+5+H8bdKvYp0VrEJNIwk1g9qRLXFDEZAqksf2bj96gHk5213tiWATwp/qqwnRb
	jpvRu0WgaDaN1ae1OqwrzQp6zoI9ctt+M+G2X1r49vWlUG77JnlXc50t4KUQsKa3rbRIMJR0PN/gy
	AnfadSbw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56390)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1swh6A-0001ui-1q;
	Fri, 04 Oct 2024 13:07:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1swh64-0001AB-2a;
	Fri, 04 Oct 2024 13:07:48 +0100
Date: Fri, 4 Oct 2024 13:07:48 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next 8/9] net: phy: mediatek: Change mtk-ge-soc.c
 line wrapping
Message-ID: <Zv_alBqCPvrSzRPL@shell.armlinux.org.uk>
References: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
 <20241004102413.5838-9-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004102413.5838-9-SkyLake.Huang@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

On Fri, Oct 04, 2024 at 06:24:12PM +0800, Sky Huang wrote:
> diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
> index 26c2183..cb6838b 100644
> --- a/drivers/net/phy/mediatek/mtk-ge-soc.c
> +++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
> @@ -295,7 +295,8 @@ static int cal_cycle(struct phy_device *phydev, int devad,
>  	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
>  					MTK_PHY_RG_AD_CAL_CLK, reg_val,
>  					reg_val & MTK_PHY_DA_CAL_CLK, 500,
> -					ANALOG_INTERNAL_OPERATION_MAX_US, false);
> +					ANALOG_INTERNAL_OPERATION_MAX_US,
> +					false);

This is fine.

>  	if (ret) {
>  		phydev_err(phydev, "Calibration cycle timeout\n");
>  		return ret;
> @@ -304,7 +305,7 @@ static int cal_cycle(struct phy_device *phydev, int devad,
>  	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CALIN,
>  			   MTK_PHY_DA_CALIN_FLAG);
>  	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CAL_COMP) >>
> -			   MTK_PHY_AD_CAL_COMP_OUT_SHIFT;
> +	      MTK_PHY_AD_CAL_COMP_OUT_SHIFT;

Before cleaning this up, please first make it propagate any error code
correctly (a bug fix):

	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CAL_COMP);
	if (ret < 0)
		return ret;

	ret >>= MTK_PHY_AD_CAL_COMP_OUT_SHIFT;

and then you won't need to change it in this patch. A better solution to
the shift would be to look at FIELD_GET().

>  	phydev_dbg(phydev, "cal_val: 0x%x, ret: %d\n", cal_val, ret);
>  
>  	return ret;
> @@ -394,38 +395,46 @@ static int tx_amp_fill_result(struct phy_device *phydev, u16 *buf)
>  	}
>  
>  	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TXVLD_DA_RG,
> -		       MTK_PHY_DA_TX_I2MPB_A_GBE_MASK, (buf[0] + bias[0]) << 10);
> +		       MTK_PHY_DA_TX_I2MPB_A_GBE_MASK,
> +		       (buf[0] + bias[0]) << 10);

Another cleanup would be to use FIELD_PREP() for these.

> -static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
> -						 BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
> -						 BIT(TRIGGER_NETDEV_LINK)        |
> -						 BIT(TRIGGER_NETDEV_LINK_10)     |
> -						 BIT(TRIGGER_NETDEV_LINK_100)    |
> -						 BIT(TRIGGER_NETDEV_LINK_1000)   |
> -						 BIT(TRIGGER_NETDEV_RX)          |
> -						 BIT(TRIGGER_NETDEV_TX));
> +static const unsigned long supported_triggers =
> +	(BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
> +	 BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
> +	 BIT(TRIGGER_NETDEV_LINK)        |
> +	 BIT(TRIGGER_NETDEV_LINK_10)     |
> +	 BIT(TRIGGER_NETDEV_LINK_100)    |
> +	 BIT(TRIGGER_NETDEV_LINK_1000)   |
> +	 BIT(TRIGGER_NETDEV_RX)          |
> +	 BIT(TRIGGER_NETDEV_TX));

The outer parens are unnecessary, and thus could be removed.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

