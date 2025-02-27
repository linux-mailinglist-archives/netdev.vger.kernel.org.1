Return-Path: <netdev+bounces-170252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4548BA48012
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998271671F9
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0812022B584;
	Thu, 27 Feb 2025 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VjM/TY+M"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE4225408;
	Thu, 27 Feb 2025 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664083; cv=none; b=dQsJ+fKNU4hOlGVRuzzeHFvsYbHN+OzYgY91zWtg603EGiWlG4teOZZ4kV2JHQVVm5nluW1NqH+VvdYGbcFZTlU84mskNNAwqRABBqwNZAsyr7OUJK7C+w8aq77Um83v4WzEIatod3lNspPEgv7zrku4mjD4319pK2BEZXxldbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664083; c=relaxed/simple;
	bh=wD85VJQ8lARU3IOIS7ujrn+8LZk9cO7XYm4TGlkQQKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Efjtob3zmhNURZfdTgXtfqZTCt/poyzT1fNdoZhrndGtSuoyMlJoGnfRS+9mJ5kTDUf4VuENNMsMiqxMXjUzrVW5e0WwAYVOE/16PwgaLbBAcDqF4ywJDV6SjJZ03NBSLANBURrEKnXSHHOjgKkSacMVe0lsP+RGEsiXIuWPRYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VjM/TY+M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z2VNcrufiCKj7eFAmSfO6YQZUc/4GuUjSOvR4L9XN8o=; b=VjM/TY+MXccsyzI6ksj8zDo9In
	yFoyfRsMmdidwKCGMPw1blkR3xTStw1bxHGpgycjtHDOsEnqExtNS3RQIudklQ8ucmhjj/B4S1SWP
	XZsbM1ax1tchMRmjs0fXdGMprPgX+3Ab2pssCBqoQkjazkJQI0GjsRlxtyc69Y/C4pOw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tneEx-000bcT-JT; Thu, 27 Feb 2025 14:47:51 +0100
Date: Thu, 27 Feb 2025 14:47:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
	David Wu <david.wu@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	netdev@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2 2/3] ethernet: stmmac: dwmac-rk: Add gmac support for
 rk3562
Message-ID: <f7146c95-85dd-4e5f-99b4-83a5d1b6fbd1@lunn.ch>
References: <20250227110652.2342729-1-kever.yang@rock-chips.com>
 <20250227110652.2342729-2-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227110652.2342729-2-kever.yang@rock-chips.com>

On Thu, Feb 27, 2025 at 07:06:51PM +0800, Kever Yang wrote:
> From: David Wu <david.wu@rock-chips.com>
> 
> Add constants and callback functions for the dwmac on RK3562 soc.
> As can be seen, the base structure is the same.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
> 
> Changes in v2:
> - Collect review tag
> 
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 207 +++++++++++++++++-
>  1 file changed, 205 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index a4dc89e23a68..ccf4ecdffad3 100644
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

IANAL, but generally, you add additional copyright notices, not
replace them.

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

This macro magic is pretty unreadable. Please consider another way to
do this. Some wise developer once said, code is written once, read 100
times. So please make code readable by default, unless it is hot path.

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

It seems like this function would be a lot more readable if it was
split into two, one dealing with RMII and another with RGMII.

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

That should of been checked much earlier, at probe.

	Andrew

