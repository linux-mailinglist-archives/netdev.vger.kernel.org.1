Return-Path: <netdev+bounces-191296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70002ABAA9C
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 16:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF69189D55B
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8157202F7B;
	Sat, 17 May 2025 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7Uh3zpS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9766935946;
	Sat, 17 May 2025 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747491126; cv=none; b=aA1CCPtegf5Yo2Audr8P+jzbFokHY92uLf40Vd3fHb14eDY0seWqm1PpN61dXnQeMksZHUnZgLlS6S3bfyYLQvUf+fiEpCugizX/0wg4Y7yYRjKKdwTtV6KvcXzbMZfQsUke5ZxdYw5XsIFNFHfUIWPz8Gwo/POPT/thD1yHjiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747491126; c=relaxed/simple;
	bh=qYndr5U3m8H68PIKip0s+OciLB7QEEHXQa1hgFbB3f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9xGh0usgeB+TPG0MeXzLUhFunjMI9ftliiDG27v6xDNaj7b0aK32sb9UGvzxo7jZFiC8j0ybyNkfLQ7gSQdnCm1Gx/EZjaDibaSujqDnOF9BCoR/de2mQGhezo+wwMBMzMPRjycP4H4ARDnKiRHVSu7rlxMOnFbhoRjFabAX/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7Uh3zpS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279B6C4CEE3;
	Sat, 17 May 2025 14:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747491125;
	bh=qYndr5U3m8H68PIKip0s+OciLB7QEEHXQa1hgFbB3f8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7Uh3zpSCHsenVsHNiSV5Jucv4/7unZy8SKwhaKVrZKoffbk8Y3yTF1SJ8A6mPvyh
	 uEuUmEjdiJSCLhGcCDSpZfsD600CLfa4CU7oneSZAzr9xTCmeThjAPBcd5ESTVOHMo
	 zi1O/w/CaYNH5CQ7L/P24taEW4ijVM4hebdxwyOi+Y+4a9T4zrbHh2k2rHsBv3x+qs
	 BEip2sxJo/nW96JOp74w2Wf3Cf3uxIfrlW/swAUqChxpNW+0/W8Zbf0uID0dhKVp9f
	 Fka3UCzXNiugNTRsfXFVSa+8gAevU6BbxuZvr+ebgC9raPhugCsYraSfYbkgq0O34l
	 q6wdp/RHezr3A==
Date: Sat, 17 May 2025 15:11:57 +0100
From: Simon Horman <horms@kernel.org>
To: weishangjuan@eswincomputing.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	yong.liang.choong@linux.intel.com, rmk+kernel@armlinux.org.uk,
	jszhang@kernel.org, inochiama@gmail.com, jan.petrous@oss.nxp.com,
	dfustini@tenstorrent.com, 0x1207@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com
Subject: Re: [PATCH v1 2/2] ethernet: eswin: Add eic7700 ethernet driver
Message-ID: <20250517141157.GM3339421@horms.kernel.org>
References: <20250516010849.784-1-weishangjuan@eswincomputing.com>
 <20250516011130.818-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516011130.818-1-weishangjuan@eswincomputing.com>

On Fri, May 16, 2025 at 09:11:28AM +0800, weishangjuan@eswincomputing.com wrote:
> From: Shangjuan Wei <weishangjuan@eswincomputing.com>
> 
> Add Ethernet controller support for Eswin's eic7700 SoC. The driver
> provides management and control of Ethernet signals for the eiC7700
> series chips.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c

...
d
> +static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
> +				   struct plat_stmmacenet_data *plat_dat)
> +{
> +	struct device *dev = &pdev->dev;
> +	u32 burst_map = 0;
> +	u32 bit_index = 0;
> +	u32 a_index = 0;
> +
> +	if (!plat_dat->axi) {
> +		plat_dat->axi = kzalloc(sizeof(*plat_dat->axi), GFP_KERNEL);

It is unclear to me where this memory is freed, both on error and removal.
For consistency perhaps it is appropriate to use devm_kzalloc().

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
> +		plat_dat->axi->axi_wr_osr_lmt = 1;
> +	} else {
> +		/**
> +		 * If property exists, to keep the behavior from dwc_eth_qos,
> +		 * subtract one after parsing.
> +		 */
> +		plat_dat->axi->axi_wr_osr_lmt--;
> +	}
> +
> +	if (device_property_read_u32(dev, "snps,read-requests",
> +				     &plat_dat->axi->axi_rd_osr_lmt)) {
> +		/**
> +		 * Since the register has a reset value of 1, if property
> +		 * is missing, default to 1.
> +		 */
> +		plat_dat->axi->axi_rd_osr_lmt = 1;
> +	} else {
> +		/**
> +		 * If property exists, to keep the behavior from dwc_eth_qos,
> +		 * subtract one after parsing.
> +		 */
> +		plat_dat->axi->axi_rd_osr_lmt--;
> +	}
> +	device_property_read_u32(dev, "snps,burst-map", &burst_map);
> +
> +	/* converts burst-map bitmask to burst array */
> +	for (bit_index = 0; bit_index < 7; bit_index++) {
> +		if (burst_map & (1 << bit_index)) {
> +			switch (bit_index) {
> +			case 0:
> +			plat_dat->axi->axi_blen[a_index] = 4; break;
> +			case 1:
> +			plat_dat->axi->axi_blen[a_index] = 8; break;
> +			case 2:
> +			plat_dat->axi->axi_blen[a_index] = 16; break;
> +			case 3:
> +			plat_dat->axi->axi_blen[a_index] = 32; break;
> +			case 4:
> +			plat_dat->axi->axi_blen[a_index] = 64; break;
> +			case 5:
> +			plat_dat->axi->axi_blen[a_index] = 128; break;
> +			case 6:
> +			plat_dat->axi->axi_blen[a_index] = 256; break;
> +			default:
> +			break;

I think the preferred coding style for the above would be:

			switch(...) {
			case 0:
				...
				break;
			...
			default:
				...
			}
> +			}
> +			a_index++;
> +		}

But I also think the code above can be more succinctly expressed something
like this:

	for (bit_index = 0; bit_index < 7; bit_index++)
		if (burst_map & (1 << bit_index)
			plat_dat->axi->axi_blen[a_index++] = 1 << i + 2;


> +	}
> +
> +	/* dwc-qos needs GMAC4, AAL, TSO and PMT */
> +	plat_dat->has_gmac4 = 1;
> +	plat_dat->dma_cfg->aal = 1;
> +	plat_dat->flags |= STMMAC_FLAG_TSO_EN;
> +	plat_dat->pmt = 1;
> +
> +	return 0;
> +}
> +
> +static void dwc_qos_fix_speed(void *priv, int speed, unsigned int mode)
> +{
> +	unsigned long rate = 125000000;
> +	int i, err, data = 0;
> +	struct dwc_qos_priv *dwc_priv = (struct dwc_qos_priv *)priv;

Please arrange local variables in networking code in reverse xmas tree
order - longest line to shortest.

To this end, this tool can be useful.
https://github.com/ecree-solarflare/xmastree

Also priv is void *. And there is usually no need to explicitly cast
to or from a void *.

So, something like this (completely intested!)

	struct dwc_qos_priv *dwc_priv = priv;
	unsigned long rate = 125000000;
	int i, err, data = 0;


> +
> +	switch (speed) {
> +	case SPEED_1000:
> +		rate = 125000000;
> +
> +		for (i = 0; i < 3; i++)
> +			regmap_write(dwc_priv->hsp_regmap,
> +				     dwc_priv->dly_hsp_reg[i],
> +				     dwc_priv->dly_param_1000m[i]);
> +
> +		if (dwc_priv->stmpriv) {
> +			data = mdiobus_read(dwc_priv->stmpriv->mii, PHY_ADDR,
> +					    PHY_PAGE_SWITCH_REG);
> +			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
> +				      PHY_PAGE_SWITCH_REG, PHY_LED_PAGE_CFG);
> +			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
> +				      PHY_LED_CFG_REG, dwc_priv->phyled_cfgs[0]);
> +			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
> +				      PHY_PAGE_SWITCH_REG, data);
> +		}
> +
> +		break;
> +	case SPEED_100:
> +		rate = 25000000;
> +
> +		for (i = 0; i < 3; i++) {
> +			regmap_write(dwc_priv->hsp_regmap,
> +				     dwc_priv->dly_hsp_reg[i],
> +				     dwc_priv->dly_param_100m[i]);
> +		}
> +
> +		if (dwc_priv->stmpriv) {
> +			data = mdiobus_read(dwc_priv->stmpriv->mii, PHY_ADDR,
> +					    PHY_PAGE_SWITCH_REG);
> +			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
> +				      PHY_PAGE_SWITCH_REG, PHY_LED_PAGE_CFG);
> +			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
> +				      PHY_LED_CFG_REG, dwc_priv->phyled_cfgs[1]);

For Networking code please limit lines to 80 columns wide or less in
Networking code where it can be done without reducing readability (which is
the case here).

checkpatch.pl --max-line-length=80 is your friend.


> +			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
> +				      PHY_PAGE_SWITCH_REG, data);
> +		}
> +
> +		break;
> +	case SPEED_10:
> +		rate = 2500000;
> +
> +		for (i = 0; i < 3; i++) {
> +			regmap_write(dwc_priv->hsp_regmap,
> +				     dwc_priv->dly_hsp_reg[i],
> +				     dwc_priv->dly_param_10m[i]);
> +		}
> +
> +		if (dwc_priv->stmpriv) {
> +			data = mdiobus_read(dwc_priv->stmpriv->mii, PHY_ADDR,
> +					    PHY_PAGE_SWITCH_REG);
> +			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
> +				      PHY_PAGE_SWITCH_REG, PHY_LED_PAGE_CFG);
> +			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
> +				      PHY_LED_CFG_REG, dwc_priv->phyled_cfgs[2]);
> +			mdiobus_write(dwc_priv->stmpriv->mii, PHY_ADDR,
> +				      PHY_PAGE_SWITCH_REG, data);
> +		}
> +
> +		break;
> +	default:

Maybe set rate here rather than along with it's declaration, and provide
a comment regarding a default value being used in the case of an
invalid speed.

> +		dev_err(dwc_priv->dev, "invalid speed %u\n", speed);
> +		break;
> +	}
> +
> +	err = clk_set_rate(dwc_priv->clk_tx, rate);
> +	if (err < 0)
> +		dev_err(dwc_priv->dev, "failed to set TX rate: %d\n", err);
> +}
> +
> +static int dwc_qos_probe(struct platform_device *pdev,
> +			 struct plat_stmmacenet_data *plat_dat,
> +			 struct stmmac_resources *stmmac_res)
> +{
> +	struct dwc_qos_priv *dwc_priv;
> +	int ret;
> +	int err;
> +	u32 hsp_aclk_ctrl_offset;
> +	u32 hsp_aclk_ctrl_regset;
> +	u32 hsp_cfg_ctrl_offset;
> +	u32 eth_axi_lp_ctrl_offset;
> +	u32 eth_phy_ctrl_offset;
> +	u32 eth_phy_ctrl_regset;
> +
> +	dwc_priv = devm_kzalloc(&pdev->dev, sizeof(*dwc_priv), GFP_KERNEL);
> +	if (!dwc_priv)
> +		return -ENOMEM;
> +
> +	if (device_property_read_u32(&pdev->dev, "id", &dwc_priv->dev_id)) {
> +		dev_err(&pdev->dev, "Can not read device id!\n");
> +		return -EINVAL;

This and other error paths below look like candidates for:

		return dev_err_probe(...)

> +	}
> +
> +	dwc_priv->dev = &pdev->dev;
> +	dwc_priv->phy_reset = devm_gpiod_get(&pdev->dev, "rst", GPIOD_OUT_LOW);
> +	if (IS_ERR(dwc_priv->phy_reset)) {
> +		dev_err(&pdev->dev, "Reset gpio not specified\n");
> +		return -EINVAL;
> +	}

...

> +	err = clk_prepare_enable(dwc_priv->clk_app);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "failed to enable app clock: %d\n",
> +			err);
> +		return err;
> +	}

Can devm_clk_get_enabled() be used in place of devm_clk_get() +
clk_prepare_enable(). It seems odd to me to let devm handle part of
the setup but not all of it.

If not, I think you need to make sure clk_disable_unprepare() is
called in the error paths below.

Flagged by Smatch.

> +
> +	dwc_priv->clk_tx = devm_clk_get(&pdev->dev, "tx");
> +	if (IS_ERR(plat_dat->pclk)) {
> +		dev_err(&pdev->dev, "tx clock not found.\n");
> +		return PTR_ERR(dwc_priv->clk_tx);
> +	}
> +
> +	err = clk_prepare_enable(dwc_priv->clk_tx);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "failed to enable tx clock: %d\n", err);
> +		return err;
> +	}

Likewise here.

> +	dwc_priv->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, "ethrst");
> +	if (IS_ERR(dwc_priv->rst))
> +		return PTR_ERR(dwc_priv->rst);
> +
> +	ret = reset_control_assert(dwc_priv->rst);
> +	WARN_ON(ret != 0);
> +	ret = reset_control_deassert(dwc_priv->rst);
> +	WARN_ON(ret != 0);
> +
> +	plat_dat->fix_mac_speed = dwc_qos_fix_speed;
> +	plat_dat->bsp_priv = dwc_priv;
> +	plat_dat->phy_addr = PHY_ADDR;
> +
> +	return 0;
> +}

...

> +static int dwc_eth_dwmac_probe(struct platform_device *pdev)
> +{
> +	const struct dwc_eth_dwmac_data *data;
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct stmmac_resources stmmac_res;
> +	struct net_device *ndev = NULL;
> +	struct stmmac_priv *stmpriv = NULL;
> +	struct dwc_qos_priv *dwc_priv = NULL;
> +	int ret;
> +
> +	data = device_get_match_data(&pdev->dev);
> +
> +	memset(&stmmac_res, 0, sizeof(struct stmmac_resources));
> +
> +	/**
> +	 * Since stmmac_platform supports name IRQ only, basic platform
> +	 * resource initialization is done in the glue logic.
> +	 */
> +	stmmac_res.irq = platform_get_irq(pdev, 0);
> +	if (stmmac_res.irq < 0)
> +		return stmmac_res.irq;
> +	stmmac_res.wol_irq = stmmac_res.irq;
> +	stmmac_res.addr = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(stmmac_res.addr))
> +		return PTR_ERR(stmmac_res.addr);
> +
> +	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	if (IS_ERR(plat_dat))
> +		return PTR_ERR(plat_dat);
> +
> +	ret = data->probe(pdev, plat_dat, &stmmac_res);
> +	if (ret < 0) {

This also looks like a candidate for dev_err_probe().

> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to probe subdriver: %d\n",
> +				ret);
> +
> +		return ret;
> +	}
> +
> +	ret = dwc_eth_dwmac_config_dt(pdev, plat_dat);
> +	if (ret)
> +		goto remove;
> +
> +	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
> +	if (ret)
> +		goto remove;
> +
> +	ndev = dev_get_drvdata(&pdev->dev);
> +	stmpriv = netdev_priv(ndev);
> +	dwc_priv = (struct dwc_qos_priv *)plat_dat->bsp_priv;
> +	dwc_priv->stmpriv = stmpriv;
> +
> +	return ret;
> +
> +remove:
> +	data->remove(pdev);
> +
> +	return ret;
> +}
> +
> +static void dwc_eth_dwmac_remove(struct platform_device *pdev)
> +{
> +	const struct dwc_eth_dwmac_data *data;
> +	int err;
> +
> +	data = device_get_match_data(&pdev->dev);
> +
> +	stmmac_dvr_remove(&pdev->dev);
> +
> +	err = data->remove(pdev);
> +	if (err < 0)
> +		dev_err(&pdev->dev, "failed to remove subdriver: %d\n", err);
> +}
> +
> +static const struct of_device_id dwc_eth_dwmac_match[] = {
> +	{ .compatible = "eswin,eic7700-qos-eth", .data = &dwc_qos_data },

Checkpatch warns that:

.../dwmac-eic7700.c:501: WARNING: DT compatible string vendor "eswin" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, dwc_eth_dwmac_match);
> +
> +static struct platform_driver eic7700_eth_dwmac_driver = {
> +	.probe  = dwc_eth_dwmac_probe,
> +	.remove = dwc_eth_dwmac_remove,
> +	.driver = {
> +		.name           = "eic7700-eth-dwmac",
> +		.pm             = &stmmac_pltfr_pm_ops,
> +		.of_match_table = dwc_eth_dwmac_match,
> +	},
> +};
> +module_platform_driver(eic7700_eth_dwmac_driver);
> +
> +MODULE_AUTHOR("Eswin");
> +MODULE_AUTHOR("Shuang Liang <liangshuang@eswincomputing.com>");
> +MODULE_AUTHOR("Shangjuan Wei <weishangjuan@eswincomputing.com>");
> +MODULE_DESCRIPTION("Eswin eic7700 qos ethernet driver");
> +MODULE_LICENSE("GPL");

