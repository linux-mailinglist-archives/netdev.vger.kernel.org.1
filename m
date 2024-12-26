Return-Path: <netdev+bounces-154298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020979FCB2A
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 14:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB25161F62
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 13:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF171D5CD3;
	Thu, 26 Dec 2024 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2GacGl7w"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D2C38DF9;
	Thu, 26 Dec 2024 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735219575; cv=none; b=I1hcqo+P4QhPzkIcEhAXtd9mvUzg1wLQmNTcHB3hq5GvqxkGCCuPwOumhRzC/D9xLwTEnjE77CtWo6gqygorbTqN/2mApbO8bDR3Nl8nHA6rJF0bMK6wZZ1DjzVRdv0aL0tdBw0yMAt6irq1Kaug9HZuxM1qXkCB8M3Rrz57CMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735219575; c=relaxed/simple;
	bh=KP4fUOEUtc0PXacnjYyr9G3RvMNfRDjkA3oHWmw2ARQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTz2BKOhpoHXAESfouDLsN4z3y8VNsAQhWXESakIOKT1TAGlxbKS6ehYYsbnPhpUEhHDCksYyee2Nk0eTatAZQNWD17qiAm/8Ale+hhHR86zsJmJKLfPHAAsUrx0noCtIQsoIBVt7qlLtPyEbkRJDJDBwEgUEy6USB3523UCaaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2GacGl7w; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cwjSRK3r/Hud4AZdAdsLSZywHfwIlBbaz7OhAgb8JlI=; b=2GacGl7w+C2PvwqEHEQPUaOGB3
	A9PpZTXZbXoMrlzMOmM8dNpfNKODj6sPG5FbHISdLfgU1rqrBhjtLhS/RUK6LDEozo7aOKfrEmUFH
	wzbOBr58fb3kCAVH4kvHi6c8nULzdgRWc6kqtpKEXlNki5RmN/fXjUTwR78Gtz1DLdwKst6bS77n+
	znSTzAx6yMIMQ+36htyQUPc4jPx5DB/dFbKjmtjqigqj0bkRwujxdIvCzANET7XdB67GlTUWJAlhq
	ZYMktfTfGnuulU3WXEirY8q32C33ntS5exFeM0z+Wkiumokor7SZ/TeqOtxJgMD+tIO+vJcG0DoIX
	M3ckBmfg==;
Received: from i5e860d12.versanet.de ([94.134.13.18] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tQnsL-00048C-RU; Thu, 26 Dec 2024 14:26:05 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, David Wu <david.wu@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jose Abreu <joabreu@synopsys.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org
Subject:
 Re: [PATCH 2/3] ethernet: stmmac: dwmac-rk: Add gmac support for rk3562
Date: Thu, 26 Dec 2024 14:26:04 +0100
Message-ID: <8703908.NyiUUSuA9g@phil>
In-Reply-To: <20241224094124.3816698-2-kever.yang@rock-chips.com>
References:
 <20241224094124.3816698-1-kever.yang@rock-chips.com>
 <20241224094124.3816698-2-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 24. Dezember 2024, 10:41:23 CET schrieb Kever Yang:
> From: David Wu <david.wu@rock-chips.com>
> 
> Add constants and callback functions for the dwmac on RK3562 soc.
> As can be seen, the base structure is the same.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> 
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 207 +++++++++++++++++-
>  1 file changed, 205 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 8cb374668b74..2ce38bf205d4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -2,8 +2,7 @@
>  /**
>   * DOC: dwmac-rk.c - Rockchip RK3288 DWMAC specific glue layer
>   *
> - * Copyright (C) 2014 Chen-Zhi (Roger Chen)
> - *
> + * Copyright (c) 2014 Rockchip Electronics Co., Ltd.
>   * Chen-Zhi (Roger Chen)  <roger.chen@rock-chips.com>
>   */
>  
> @@ -91,6 +90,16 @@ struct rk_priv_data {
>  	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
>  	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
>  
> +#define DELAY_VALUE(soc, tx, rx) \
> +	((((tx) >= 0) ? soc##_GMAC_CLK_TX_DL_CFG(tx) : 0) | \
> +	 (((rx) >= 0) ? soc##_GMAC_CLK_RX_DL_CFG(rx) : 0))
> +
> +#define GMAC_RGMII_CLK_DIV_BY_ID(soc, id, div) \
> +		(soc##_GMAC##id##_CLK_RGMII_DIV##div)
> +
> +#define GMAC_RMII_CLK_DIV_BY_ID(soc, id, div) \
> +		(soc##_GMAC##id##_CLK_RMII_DIV##div)
> +
>  #define PX30_GRF_GMAC_CON1		0x0904
>  
>  /* PX30_GRF_GMAC_CON1 */
> @@ -1013,6 +1022,199 @@ static const struct rk_gmac_ops rk3399_ops = {
>  	.set_rmii_speed = rk3399_set_rmii_speed,
>  };
>  
> +/* sys_grf */
> +#define RK3562_GRF_SYS_SOC_CON0			0X0400
> +#define RK3562_GRF_SYS_SOC_CON1			0X0404
> +
> +#define RK3562_GMAC0_CLK_RMII_MODE		GRF_BIT(5)
> +#define RK3562_GMAC0_CLK_RGMII_MODE		GRF_CLR_BIT(5)
> +
> +#define RK3562_GMAC0_CLK_RMII_GATE		GRF_BIT(6)
> +#define RK3562_GMAC0_CLK_RMII_NOGATE		GRF_CLR_BIT(6)
> +
> +#define RK3562_GMAC0_CLK_RMII_DIV2		GRF_BIT(7)
> +#define RK3562_GMAC0_CLK_RMII_DIV20		GRF_CLR_BIT(7)
> +
> +#define RK3562_GMAC0_CLK_RGMII_DIV1		\
> +				(GRF_CLR_BIT(7) | GRF_CLR_BIT(8))
> +#define RK3562_GMAC0_CLK_RGMII_DIV5		\
> +				(GRF_BIT(7) | GRF_BIT(8))
> +#define RK3562_GMAC0_CLK_RGMII_DIV50		\
> +				(GRF_CLR_BIT(7) | GRF_BIT(8))
> +
> +#define RK3562_GMAC0_CLK_RMII_DIV2		GRF_BIT(7)
> +#define RK3562_GMAC0_CLK_RMII_DIV20		GRF_CLR_BIT(7)
> +
> +#define RK3562_GMAC0_CLK_SELET_CRU		GRF_CLR_BIT(9)
> +#define RK3562_GMAC0_CLK_SELET_IO		GRF_BIT(9)
> +
> +#define RK3562_GMAC1_CLK_RMII_GATE		GRF_BIT(12)
> +#define RK3562_GMAC1_CLK_RMII_NOGATE		GRF_CLR_BIT(12)
> +
> +#define RK3562_GMAC1_CLK_RMII_DIV2		GRF_BIT(13)
> +#define RK3562_GMAC1_CLK_RMII_DIV20		GRF_CLR_BIT(13)
> +
> +#define RK3562_GMAC1_RMII_SPEED100		GRF_BIT(11)
> +#define RK3562_GMAC1_RMII_SPEED10		GRF_CLR_BIT(11)
> +
> +#define RK3562_GMAC1_CLK_SELET_CRU		GRF_CLR_BIT(15)
> +#define RK3562_GMAC1_CLK_SELET_IO		GRF_BIT(15)
> +
> +/* ioc_grf */
> +#define RK3562_GRF_IOC_GMAC_IOFUNC0_CON0	0X10400
> +#define RK3562_GRF_IOC_GMAC_IOFUNC0_CON1	0X10404
> +#define RK3562_GRF_IOC_GMAC_IOFUNC1_CON0	0X00400
> +#define RK3562_GRF_IOC_GMAC_IOFUNC1_CON1	0X00404
> +
> +#define RK3562_GMAC_RXCLK_DLY_ENABLE		GRF_BIT(1)
> +#define RK3562_GMAC_RXCLK_DLY_DISABLE		GRF_CLR_BIT(1)
> +#define RK3562_GMAC_TXCLK_DLY_ENABLE		GRF_BIT(0)
> +#define RK3562_GMAC_TXCLK_DLY_DISABLE		GRF_CLR_BIT(0)
> +
> +#define RK3562_GMAC_CLK_RX_DL_CFG(val)		HIWORD_UPDATE(val, 0xFF, 8)
> +#define RK3562_GMAC_CLK_TX_DL_CFG(val)		HIWORD_UPDATE(val, 0xFF, 0)
> +
> +#define RK3562_GMAC0_IO_EXTCLK_SELET_CRU	GRF_CLR_BIT(2)
> +#define RK3562_GMAC0_IO_EXTCLK_SELET_IO		GRF_BIT(2)
> +
> +#define RK3562_GMAC1_IO_EXTCLK_SELET_CRU	GRF_CLR_BIT(3)
> +#define RK3562_GMAC1_IO_EXTCLK_SELET_IO		GRF_BIT(3)
> +
> +static void rk3562_set_to_rgmii(struct rk_priv_data *bsp_priv,
> +				int tx_delay, int rx_delay)
> +{
> +	struct device *dev = &bsp_priv->pdev->dev;
> +
> +	if (IS_ERR(bsp_priv->grf) || IS_ERR(bsp_priv->php_grf)) {
> +		dev_err(dev, "Missing rockchip,grf or rockchip,php_grf property\n");
> +		return;
> +	}
> +
> +	if (bsp_priv->id > 0)
> +		return;
> +
> +	regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0,
> +		     RK3562_GMAC0_CLK_RGMII_MODE);
> +
> +	regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC0_CON1,
> +		     DELAY_ENABLE(RK3562, tx_delay, rx_delay));
> +	regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC0_CON0,
> +		     DELAY_VALUE(RK3562, tx_delay, rx_delay));
> +
> +	regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC1_CON1,
> +		     DELAY_ENABLE(RK3562, tx_delay, rx_delay));
> +	regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC1_CON0,
> +		     DELAY_VALUE(RK3562, tx_delay, rx_delay));
> +}
> +
> +static void rk3562_set_to_rmii(struct rk_priv_data *bsp_priv)
> +{
> +	struct device *dev = &bsp_priv->pdev->dev;
> +
> +	if (IS_ERR(bsp_priv->grf)) {
> +		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
> +		return;
> +	}
> +
> +	if (!bsp_priv->id)
> +		regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0,
> +			     RK3562_GMAC0_CLK_RMII_MODE);
> +}
> +
> +static void rk3562_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
> +{
> +	struct device *dev = &bsp_priv->pdev->dev;
> +	unsigned int val = 0, offset, id = bsp_priv->id;
> +
> +	switch (speed) {
> +	case 10:
> +		if (bsp_priv->phy_iface == PHY_INTERFACE_MODE_RMII) {
> +			if (id > 0) {
> +				val = GMAC_RMII_CLK_DIV_BY_ID(RK3562, 1, 20);
> +				regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0,
> +					     RK3562_GMAC1_RMII_SPEED10);
> +			} else {
> +				val = GMAC_RMII_CLK_DIV_BY_ID(RK3562, 0, 20);
> +			}
> +		} else {
> +			val = GMAC_RGMII_CLK_DIV_BY_ID(RK3562, 0, 50);
> +		}
> +		break;
> +	case 100:
> +		if (bsp_priv->phy_iface == PHY_INTERFACE_MODE_RMII) {
> +			if (id > 0) {
> +				val = GMAC_RMII_CLK_DIV_BY_ID(RK3562, 1, 2);
> +				regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0,
> +					     RK3562_GMAC1_RMII_SPEED100);
> +			} else {
> +				val = GMAC_RMII_CLK_DIV_BY_ID(RK3562, 0, 2);
> +			}
> +		} else {
> +			val = GMAC_RGMII_CLK_DIV_BY_ID(RK3562, 0, 5);
> +		}
> +		break;
> +	case 1000:
> +		if (bsp_priv->phy_iface != PHY_INTERFACE_MODE_RMII)
> +			val = GMAC_RGMII_CLK_DIV_BY_ID(RK3562, 0, 1);
> +		else
> +			goto err;
> +		break;
> +	default:
> +		goto err;
> +	}
> +
> +	offset = (bsp_priv->id > 0) ? RK3562_GRF_SYS_SOC_CON1 :
> +					  RK3562_GRF_SYS_SOC_CON0;
> +	regmap_write(bsp_priv->grf, offset, val);
> +
> +	return;
> +err:
> +	dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
> +}
> +
> +static void rk3562_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
> +				       bool enable)
> +{
> +	struct device *dev = &bsp_priv->pdev->dev;
> +	unsigned int value;
> +
> +	if (IS_ERR(bsp_priv->grf) || IS_ERR(bsp_priv->php_grf)) {
> +		dev_err(dev, "Missing rockchip,grf or rockchip,php_grf property\n");
> +		return;
> +	}
> +
> +	if (!bsp_priv->id) {
> +		value = input ? RK3562_GMAC0_CLK_SELET_IO :
> +				RK3562_GMAC0_CLK_SELET_CRU;
> +		value |= enable ? RK3562_GMAC0_CLK_RMII_NOGATE :
> +				  RK3562_GMAC0_CLK_RMII_GATE;
> +		regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0, value);
> +
> +		value = input ? RK3562_GMAC0_IO_EXTCLK_SELET_IO :
> +				RK3562_GMAC0_IO_EXTCLK_SELET_CRU;
> +		regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC0_CON1, value);
> +		regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC1_CON1, value);
> +	} else {
> +		value = input ? RK3562_GMAC1_CLK_SELET_IO :
> +				RK3562_GMAC1_CLK_SELET_CRU;
> +		value |= enable ? RK3562_GMAC1_CLK_RMII_NOGATE :
> +				 RK3562_GMAC1_CLK_RMII_GATE;
> +		regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON1, value);
> +
> +		value = input ? RK3562_GMAC1_IO_EXTCLK_SELET_IO :
> +				RK3562_GMAC1_IO_EXTCLK_SELET_CRU;
> +		regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC1_CON1, value);
> +	}
> +}
> +
> +static const struct rk_gmac_ops rk3562_ops = {
> +	.set_to_rgmii = rk3562_set_to_rgmii,
> +	.set_to_rmii = rk3562_set_to_rmii,
> +	.set_rgmii_speed = rk3562_set_gmac_speed,
> +	.set_rmii_speed = rk3562_set_gmac_speed,
> +	.set_clock_selection = rk3562_set_clock_selection,
> +};
> +
>  #define RK3568_GRF_GMAC0_CON0		0x0380
>  #define RK3568_GRF_GMAC0_CON1		0x0384
>  #define RK3568_GRF_GMAC1_CON0		0x0388
> @@ -2062,6 +2264,7 @@ static const struct of_device_id rk_gmac_dwmac_match[] = {
>  	{ .compatible = "rockchip,rk3366-gmac", .data = &rk3366_ops },
>  	{ .compatible = "rockchip,rk3368-gmac", .data = &rk3368_ops },
>  	{ .compatible = "rockchip,rk3399-gmac", .data = &rk3399_ops },
> +	{ .compatible = "rockchip,rk3562-gmac", .data = &rk3562_ops },
>  	{ .compatible = "rockchip,rk3568-gmac", .data = &rk3568_ops },
>  	{ .compatible = "rockchip,rk3576-gmac", .data = &rk3576_ops },
>  	{ .compatible = "rockchip,rk3588-gmac", .data = &rk3588_ops },
> 





