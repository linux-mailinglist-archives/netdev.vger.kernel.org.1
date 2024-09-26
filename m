Return-Path: <netdev+bounces-130013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8A698791D
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 20:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F092E1C21490
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57DD15B552;
	Thu, 26 Sep 2024 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0GffIClt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB91D5AD0;
	Thu, 26 Sep 2024 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727375540; cv=none; b=YcoorvJ3+hFhypXHWmrybNkKauu/vArDa3ABSOeEaG07TTFDVIYC1K9llCowVJD4lsxtcSXRe3Mv94UJPsQKY4prRztyecvsC2aF9jPDpxQhdO59y2VWTZb9ikPkj43Q/+cCB/DNvh1pFMC4vr4YsAnespDbzA948eKFz1w0Da0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727375540; c=relaxed/simple;
	bh=D+2u2aVIXi6x+bhRCjpRClGravjiy4BJH2k4iLCbMVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+OTA9X6frGXgk1lgVLwwp3WjdNg86OXDMucHagXZSOljmtM4EJ3F/cQzI8W//bmBHi3PRt44RCUOUnVjMGLhmA/rCGMtYC6TQIWdsB6b2fqL13n50/83FsmmLLntikeEU66b7O9wrstkaBgYIyzfhGVCs1JRTesXq/QRW7rguc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0GffIClt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Rlnyig4rL5kmmCvrq8BcNJP6HH7YItNnR5m32oxXtkA=; b=0GffICltFZ/zEwUglhP4DXBSuj
	0vVCN2Ik8/1NhLytYwwZ673FN+KI0GCM1LMzZVAxUDAqo9eyL1uZDvfcK3s+AJQ0VJC/C0prNY18j
	jf8976MR7yA2oRt7/AzCvyQqU7boNqAYYztiOyrLRgDIPsw06JkTvOo3GCNRU1cTpLQg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sttHU-008P5w-EH; Thu, 26 Sep 2024 20:32:00 +0200
Date: Thu, 26 Sep 2024 20:32:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/3] net: stmmac: Add glue layer for T-HEAD TH1520 SoC
Message-ID: <a64eb154-30b9-4321-b3ef-2bcb1e861800@lunn.ch>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
 <20240926-th1520-dwmac-v2-2-f34f28ad1dc9@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926-th1520-dwmac-v2-2-f34f28ad1dc9@tenstorrent.com>

> +static int thead_dwmac_init(struct platform_device *pdev, void *priv)
> +{
> +	struct thead_dwmac *dwmac = priv;
> +	int ret;
> +
> +	ret = thead_dwmac_set_phy_if(dwmac->plat);
> +	if (ret)
> +		return ret;
> +
> +	ret = thead_dwmac_set_txclk_dir(dwmac->plat);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(dwmac->apb_regmap, GMAC_RXCLK_DELAY_CTRL,
> +			   GMAC_RXCLK_DELAY_VAL(dwmac->rx_delay));
> +	if (ret)
> +		return dev_err_probe(dwmac->dev, ret,
> +				     "failed to set GMAC RX clock delay\n");
> +
> +	ret = regmap_write(dwmac->apb_regmap, GMAC_TXCLK_DELAY_CTRL,
> +			   GMAC_TXCLK_DELAY_VAL(dwmac->tx_delay));
> +	if (ret)
> +		return dev_err_probe(dwmac->dev, ret,
> +				     "failed to set GMAC TX clock delay\n");
> +
> +	thead_dwmac_fix_speed(dwmac, SPEED_1000, 0);

Is this needed? I would expect this to be called when the PHY has link
and you know the link speed. So why set it here?

> +
> +	return thead_dwmac_enable_clk(dwmac->plat);
> +}
> +
> +static int thead_dwmac_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct stmmac_resources stmmac_res;
> +	struct plat_stmmacenet_data *plat;
> +	struct thead_dwmac *dwmac;
> +	void __iomem *apb;
> +	u32 delay;
> +	int ret;
> +
> +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to get resources\n");
> +
> +	plat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	if (IS_ERR(plat))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
> +				     "dt configuration failed\n");
> +
> +	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> +	if (!dwmac)
> +		return -ENOMEM;
> +
> +	/* hardware default is 0 for the rx and tx internal clock delay */
> +	dwmac->rx_delay = 0;
> +	dwmac->tx_delay = 0;
> +
> +	/* rx and tx internal delay properties are optional */
> +	if (!of_property_read_u32(np, "thead,rx-internal-delay", &delay)) {
> +		if (delay > GMAC_RXCLK_DELAY_MASK)
> +			dev_warn(&pdev->dev,
> +				 "thead,rx-internal-delay (%u) exceeds max (%lu)\n",
> +				 delay, GMAC_RXCLK_DELAY_MASK);
> +		else
> +			dwmac->rx_delay = delay;
> +	}
> +

So you keep going, with an invalid value? It is better to use
dev_err() and return -EINVAL. The DT write will then correct their
error when the device fails to probe.

If you decide to keep this... I'm not sure these properties are
needed.

> +MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");

Please add a second author, if you have taken over this driver.

       Andrew

