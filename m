Return-Path: <netdev+bounces-193970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C80AC6ADC
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145773AFBA6
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 13:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8281E2882A6;
	Wed, 28 May 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O8iQQ/V8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E623D561;
	Wed, 28 May 2025 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748439881; cv=none; b=WHgA/ER/+0jHzVbI8IeeCKnV3PmFqYdeTxmKZj2b7TuatlApPHR5S1052xS01ieqrcRLEJQuTfEQkTbnTSZ39K4tDCxC3DeIu0smtu1DxBPNRbiQPNCgrub3JZUS0Y5LL2iX5pLTi9kNE4fdjCo7mT0Z4HQOAOE8Qvne/Ow7uiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748439881; c=relaxed/simple;
	bh=E15IkgiQNik1xTR6jnoo1aTBBTDqNYSMkDv5a0E6euk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwQFB83XEbvUEZPY4sRrjF99KrArG6PV0LNkAfO579VkxggBmytLag8GX17zL50as65LmNZ1JfHCJ1qrwsOyI1Oi5R6Q5niyXicmZrXmuO4jxJ5LU47nESU3VsAVMKsmOzmQ9RBUf70/7OEEdY9jubaAFj8ZqwO5AUe92RSIaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O8iQQ/V8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MBbrn7eQDWJVCAKImqv3Knw41beS2cHZDNUxETDEwfM=; b=O8iQQ/V8bHl6lOCEVTlkgRjo44
	gcgAFR2K9InA3NJSn5okPeS35of+VlF+V2w7viINNPtJbrMNDgEsU6GQ4isK4scegHzenw8YdCiSd
	nVUaAEytpdXsvMKdXFQTmALESkOqOSgRjHyrC+sjcGoTmnR9KapDaflyr9RjgT+u0MrU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uKH55-00EBEE-SV; Wed, 28 May 2025 15:44:31 +0200
Date: Wed, 28 May 2025 15:44:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: weishangjuan@eswincomputing.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	vladimir.oltean@nxp.com, rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	jan.petrous@oss.nxp.com, jszhang@kernel.org, p.zabel@pengutronix.de,
	0x1207@gmail.com, boon.khai.ng@altera.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com
Subject: Re: [PATCH v2 2/2] =?iso-8859-1?Q?ethernet?=
 =?iso-8859-1?B?OqBlc3dpbjqgQWRkoGVpYzc3MDCgZXRoZXJuZXSgZHJpdmVy?=
Message-ID: <2c2dc4cb-57aa-476a-8668-c0b358f0ee0c@lunn.ch>
References: <20250528041455.878-1-weishangjuan@eswincomputing.com>
 <20250528041634.912-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528041634.912-1-weishangjuan@eswincomputing.com>

> +/* PHY default addr in mdio*/
> +#define PHY_ADDR				-1

PHY addresses are 0 to 31. How can -1 be a default?

> +static struct clk *dwc_eth_find_clk(struct plat_stmmacenet_data *plat_dat,
> +				    const char *name)
> +{
> +	for (int i = 0; i < plat_dat->num_clks; i++)
> +		if (strcmp(plat_dat->clks[i].id, name) == 0)
> +			return plat_dat->clks[i].clk;
> +
> +	return NULL;
> +}

Please look at the cleanup work Russell King has been doing the last
couple of months. Is this still needed?

> +static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
> +				   struct plat_stmmacenet_data *plat_dat)
> +{
> +	struct device *dev = &pdev->dev;
> +	u32 burst_map = 0;
> +	u32 bit_index = 0;
> +	u32 a_index = 0;
> +
> +	if (!plat_dat->axi) {
> +		plat_dat->axi = devm_kzalloc(&pdev->dev, sizeof(struct stmmac_axi), GFP_KERNEL);
> +
> +		if (!plat_dat->axi)
> +			return -ENOMEM;
> +	}
> +
> +	plat_dat->axi->axi_lpi_en = device_property_read_bool(dev,
> +							      "snps,en-lpi");
> +	if (device_property_read_u32(dev, "snps,write-requests",
> +				     &plat_dat->axi->axi_wr_osr_lmt)) {
> +		/**
> +		 * Since the register has a reset value of 1, if property
> +		 * is missing, default to 1.
> +		 */

Is that described in the binding? Please fully describe all the DT
properties, including what happens when they are not present.

> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,phyaddr", 0,
> +					 &dwc_priv->phyaddr);
> +	if (ret)
> +		dev_warn(&pdev->dev, "can't get phyaddr (%d)\n", ret);

Are we talking about the Ethernet PHY here or a generic PHY? You
should not need any vendor properties for an Ethernet phy, phy-handle
points to the PHY on an MDIO bus.

> +	ret = of_property_read_variable_u32_array(pdev->dev.of_node, "dly-param-1000m",
> +						  &dwc_priv->dly_param_1000m[0], 3, 0);
> +	if (ret != 3) {
> +		dev_err(&pdev->dev, "can't get delay param for 1Gbps mode (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = of_property_read_variable_u32_array(pdev->dev.of_node, "dly-param-100m",
> +						  &dwc_priv->dly_param_100m[0], 3, 0);
> +	if (ret != 3) {
> +		dev_err(&pdev->dev, "can't get delay param for 100Mbps mode (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = of_property_read_variable_u32_array(pdev->dev.of_node, "dly-param-10m",
> +						  &dwc_priv->dly_param_10m[0], 3, 0);
> +	if (ret != 3) {
> +		dev_err(&pdev->dev, "can't get delay param for 10Mbps mode (%d)\n", ret);
> +		return ret;
> +	}

        rx-internal-delay-ps:
          description:
            RGMII Receive Clock Delay defined in pico seconds. This is used for
            controllers that have configurable RX internal delays. If this
            property is present then the MAC applies the RX delay.
        tx-internal-delay-ps:
          description:
            RGMII Transmit Clock Delay defined in pico seconds. This is used for
            controllers that have configurable TX internal delays. If this
            property is present then the MAC applies the TX delay.

The RGMII standard only talks about 2ns delay. There is no delay per
link speed. This is something specific to your hardware. Please figure
out how you can map these standard properties to what you need for
100Mbps and 10Mbps.

    Andrew

---
pw-bot: cr

