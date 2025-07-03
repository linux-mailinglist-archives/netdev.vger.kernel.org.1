Return-Path: <netdev+bounces-203790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB53AF732B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138431887898
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DF9298CBC;
	Thu,  3 Jul 2025 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ayEG+PtL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DA8EEA9;
	Thu,  3 Jul 2025 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751544206; cv=none; b=bjteR2WjY6oSR7NcqeR209RPpOOUJwPLzu0n6x2roJFLiqtJmOJhWYmRK0AZvonvpgafHjWcfhg8usr0FbSdtTmN4SgwT1PPB3Eo8JddCKlFKxldDYXNZTNRGpr9l8HIG0T68i98mZOPd8JdW9pt3GcjLDDmM+TqdQIJFV9qhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751544206; c=relaxed/simple;
	bh=13Mtr8tfOpo/bjU47Z0Ixv/RqoqZx+pkZNbvLw+MH6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+K554ORNE55rd86EsHyHfgxEPY5qvlt8lOVgh3swoi8byA345KlyMVSOpkAOTEItzWyOLaFk0xrIuAwKsi9M0eqKyANYl91ST3ePa0nppS4MYSM+oQEJQszyNCJFaN+QnM3NZQrDJqV2ADj0UqR7ny6Nyk82k9ia+8zngI/0ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ayEG+PtL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0bLFCgSGsGWYqU1VUzp/98s4ncOYCMUP6PUrfSKkQ9I=; b=ayEG+PtL2NdfYFXcLmfnMMc+/o
	REzK/c2hbPC5peR8ZFgtSTCGIwfArWZLcKgJZYlfV4CQSgckIAtgEpCBuc0U9ApE8zxEcdu84+/Vp
	/8m8ibuEVYYA0mOJUFD3FeLs4FzBiiugflhOFF//Qlplz/DBrvsIu8Li98qAgzaldWJ08LShkNJMw
	k678K+PC1fbvUgCwdIlPjRJGFyYe7M8RBdMckjrhpz9jEDTLsc53yiMyEQNgrFIdUmsxPZON/xTch
	KRAGlD50wX7grhb9R40HOToRDopp9oo4HXTCggU+zZHztGDRVUjubbE2dbpddRVH+1FXWgZvCetN0
	M2/p8Rbw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43908)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uXIeh-0000gv-0k;
	Thu, 03 Jul 2025 13:03:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uXIeZ-00054e-1E;
	Thu, 03 Jul 2025 13:02:59 +0100
Date: Thu, 3 Jul 2025 13:02:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: weishangjuan@eswincomputing.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	yong.liang.choong@linux.intel.com, vladimir.oltean@nxp.com,
	jszhang@kernel.org, jan.petrous@oss.nxp.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	boon.khai.ng@altera.com, dfustini@tenstorrent.com, 0x1207@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com
Subject: Re: [PATCH v3 2/2] ethernet: eswin: Add eic7700 ethernet driver
Message-ID: <aGZxc-9C0rPVMsGH@shell.armlinux.org.uk>
References: <20250703091808.1092-1-weishangjuan@eswincomputing.com>
 <20250703092015.1200-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703092015.1200-1-weishangjuan@eswincomputing.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 03, 2025 at 05:20:15PM +0800, weishangjuan@eswincomputing.com wrote:
> +static void eic7700_qos_fix_speed(void *priv, int speed, u32 mode)
> +{
> +	struct eic7700_qos_priv *dwc_priv = priv;
> +	int i;
> +
> +	switch (speed) {
> +	case SPEED_1000:
> +		for (i = 0; i < 3; i++)
> +			regmap_write(dwc_priv->hsp_regmap,
> +				     dwc_priv->dly_hsp_reg[i],
> +				     dwc_priv->dly_param_1000m[i]);
> +		break;
> +	case SPEED_100:
> +		for (i = 0; i < 3; i++) {
> +			regmap_write(dwc_priv->hsp_regmap,
> +				     dwc_priv->dly_hsp_reg[i],
> +				     dwc_priv->dly_param_100m[i]);
> +		}

The other two instances don't have the curley braces, why does this need
it?

> +		break;
> +	case SPEED_10:
> +		for (i = 0; i < 3; i++) {
> +			regmap_write(dwc_priv->hsp_regmap,
> +				     dwc_priv->dly_hsp_reg[i],
> +				     dwc_priv->dly_param_10m[i]);
> +		}
> +		break;
> +	default:
> +		dev_err(dwc_priv->dev, "invalid speed %u\n", speed);
> +		break;
> +	}

Overall, wouldn't:

	const u32 *dly_param;

	switch (speed) {
	case SPEED_1000:
		dly_param = dwc_priv->dly_param_1000m;
		break;
	... etc ...
	default:
		dly_param = NULL;
		dev_err(dwc_priv->dev, "invalid speed %u\n", speed);
		break;
	}

	if (dly_param)
		for (i = 0; i < 3; i++)
			regmap_write(dwc_priv->hsp_regmap,
				     dwc_priv->dly_hsp_reg[i],
				     dly_param[i]);

be more concise and easier to read?

> +}
> +
> +static int eic7700_dwmac_probe(struct platform_device *pdev)
> +{
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct stmmac_resources stmmac_res;
> +	struct eic7700_qos_priv *dwc_priv;
> +	u32 hsp_aclk_ctrl_offset;
> +	u32 hsp_aclk_ctrl_regset;
> +	u32 hsp_cfg_ctrl_offset;
> +	u32 eth_axi_lp_ctrl_offset;
> +	u32 eth_phy_ctrl_offset;
> +	u32 eth_phy_ctrl_regset;
> +	bool has_rx_dly = false;
> +	bool has_tx_dly = false;
> +	int ret;
> +
> +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				"failed to get resources\n");
> +
> +	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	if (IS_ERR(plat_dat))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
> +				"dt configuration failed\n");
> +
> +	dwc_priv = devm_kzalloc(&pdev->dev, sizeof(*dwc_priv), GFP_KERNEL);
> +	if (!dwc_priv)
> +		return -ENOMEM;
> +
> +	dwc_priv->dev = &pdev->dev;
> +	dwc_priv->dly_param_1000m[0] = EIC7700_DELAY_VALUE0;
> +	dwc_priv->dly_param_1000m[1] = EIC7700_DELAY_VALUE1;
> +	dwc_priv->dly_param_1000m[2] = EIC7700_DELAY_VALUE0;
> +	dwc_priv->dly_param_100m[0] = EIC7700_DELAY_VALUE0;
> +	dwc_priv->dly_param_100m[1] = EIC7700_DELAY_VALUE1;
> +	dwc_priv->dly_param_100m[2] = EIC7700_DELAY_VALUE0;
> +	dwc_priv->dly_param_10m[0] = 0x0;
> +	dwc_priv->dly_param_10m[1] = 0x0;
> +	dwc_priv->dly_param_10m[2] = 0x0;
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "rx-internal-delay-ps",
> +				   &dwc_priv->rx_delay_ps);
> +	if (ret)
> +		dev_dbg(&pdev->dev, "can't get rx-internal-delay-ps, ret(%d).", ret);

Consider using %pe and ERR_PTR(ret) so that error codes can be
translated to human readable strings. Ditto elsewhere.

> +	else
> +		has_rx_dly = true;
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "tx-internal-delay-ps",
> +				   &dwc_priv->tx_delay_ps);
> +	if (ret)
> +		dev_dbg(&pdev->dev, "can't get tx-internal-delay-ps, ret(%d).", ret);
> +	else
> +		has_tx_dly = true;
> +	if (has_rx_dly && has_tx_dly) {
> +		eic7700_set_delay(dwc_priv->rx_delay_ps, dwc_priv->tx_delay_ps,
> +				  &dwc_priv->dly_param_1000m[1]);
> +		eic7700_set_delay(dwc_priv->rx_delay_ps, dwc_priv->tx_delay_ps,
> +				  &dwc_priv->dly_param_100m[1]);
> +		eic7700_set_delay(dwc_priv->rx_delay_ps, dwc_priv->tx_delay_ps,
> +				  &dwc_priv->dly_param_10m[1]);
> +	} else {
> +		dev_dbg(&pdev->dev, " use default dly\n");
> +	}
> +
> +	ret = of_property_read_variable_u32_array(pdev->dev.of_node, "eswin,dly_hsp_reg",
> +						  &dwc_priv->dly_hsp_reg[0], 3, 0);
> +	if (ret != 3) {
> +		dev_err(&pdev->dev, "can't get delay hsp reg.ret(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	dwc_priv->crg_regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +							       "eswin,syscrg_csr");
> +	if (IS_ERR(dwc_priv->crg_regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(dwc_priv->crg_regmap),
> +				"Failed to get syscrg_csr regmap\n");
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr", 1,
> +					 &hsp_aclk_ctrl_offset);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "can't get hsp_aclk_ctrl_offset\n");
> +
> +	regmap_read(dwc_priv->crg_regmap, hsp_aclk_ctrl_offset, &hsp_aclk_ctrl_regset);
> +	hsp_aclk_ctrl_regset |= (EIC7700_HSP_ACLK_CLKEN | EIC7700_HSP_ACLK_DIVSOR);
> +	regmap_write(dwc_priv->crg_regmap, hsp_aclk_ctrl_offset, hsp_aclk_ctrl_regset);
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr", 2,
> +					 &hsp_cfg_ctrl_offset);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "can't get hsp_cfg_ctrl_offset\n");
> +
> +	regmap_write(dwc_priv->crg_regmap, hsp_cfg_ctrl_offset, EIC7700_HSP_CFG_CTRL_REGSET);
> +
> +	dwc_priv->hsp_regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +							       "eswin,hsp_sp_csr");
> +	if (IS_ERR(dwc_priv->hsp_regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(dwc_priv->hsp_regmap),
> +				"Failed to get hsp_sp_csr regmap\n");
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr", 2,
> +					 &eth_phy_ctrl_offset);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "can't get eth_phy_ctrl_offset\n");
> +
> +	regmap_read(dwc_priv->hsp_regmap, eth_phy_ctrl_offset, &eth_phy_ctrl_regset);
> +	eth_phy_ctrl_regset |= (EIC7700_ETH_TX_CLK_SEL | EIC7700_ETH_PHY_INTF_SELI);
> +	regmap_write(dwc_priv->hsp_regmap, eth_phy_ctrl_offset, eth_phy_ctrl_regset);
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr", 3,
> +					 &eth_axi_lp_ctrl_offset);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "can't get eth_axi_lp_ctrl_offset\n");
> +
> +	regmap_write(dwc_priv->hsp_regmap, eth_axi_lp_ctrl_offset, EIC7700_ETH_CSYSREQ_VAL);
> +

Consider more sensible wrapping of this (netdev frowns at >80
characters per line, except for message strings that should remain
greppable.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

