Return-Path: <netdev+bounces-111351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A6A930AA0
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 17:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F18F28141F
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 15:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABABB13A249;
	Sun, 14 Jul 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n0rTq7PJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B563C8;
	Sun, 14 Jul 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720972614; cv=none; b=nWKwnn6hYHBlh2SyBHZ2lfcY/ciZsN8wpGFTj71nYMhykOLkU1b52oSEAYjnO27rZQqY8dajRHEeXUzUAbkGk82nIVFimnsrpJCzFOAoqf0SK7UpxJUgaWKigR+xhG1Esa65u1YAyRbeeuhthbcmKvCnIhcWYlngfs4p7pg+agg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720972614; c=relaxed/simple;
	bh=F9cTaoH+KxaO6WuCPvtMU54p5GI4prFTCv3WeSwC5P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3HPnGwqT/HjWUKPn4dN+vEQw+PmTOqT/oTg5vXdMtJXossO57BIEQ1FHWJ1dSZ11teIrvRjSkOW+FMzmJxoOyNHs7lgxJtwoAZ7s/pk6a6Xmf1LtmXdv+xVPKuHWIF4nf5KYdQXcuy1V6LXamzpsxqYzTI7cCPudL18UUf3QKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n0rTq7PJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ladN6LLUy8M/kRB3T3QoGod7Oj8SG+/0YO1GOtFc7UE=; b=n0rTq7PJ8a8mBaG/5Dw1EJOJmf
	o/A75NFJSd5VsmYp2EpWm8mnKoAb0s6y/98tuEGYbcs3yHeyeMXrIIKY7gRfmFimHyf/lHjBADnZb
	bPIfP8GXGiAzjbBD9fCbMnSpwXCg/zXeZWDviShqK1255Deu9LtM+vuX+YALDGRr1eMs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sT1aN-002VjU-3z; Sun, 14 Jul 2024 17:56:27 +0200
Date: Sun, 14 Jul 2024 17:56:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Drew Fustini <drew@pdp7.com>
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
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC net-next 3/4] net: stmmac: add glue layer for T-HEAD
 TH1520 SoC
Message-ID: <7146ac63-f5fa-4335-9607-2cd38baca3ab@lunn.ch>
References: <20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com>
 <20240713-thead-dwmac-v1-3-81f04480cd31@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713-thead-dwmac-v1-3-81f04480cd31@tenstorrent.com>

> +static int thead_dwmac_set_txclk_dir(struct plat_stmmacenet_data *plat)
> +{
> +	struct thead_dwmac *dwmac = plat->bsp_priv;
> +	u32 txclk_dir;
> +
> +	switch (plat->mac_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		txclk_dir = TXCLK_DIR_INPUT;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		txclk_dir = TXCLK_DIR_OUTPUT;
> +		break;
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->mac_interface);
> +		return -EINVAL;
> +	};
> +
> +	regmap_write(dwmac->apb_regmap, GMAC_TXCLK_OEN, txclk_dir);
> +
> +	return 0;

regmap_write() can fail. So it would be better to have

	return regmap_write(dwmac->apb_regmap, GMAC_TXCLK_OEN, txclk_dir);

Please consider this for all functions which a similar.

> +static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> +{
> +	struct thead_dwmac *dwmac = priv;
> +	struct plat_stmmacenet_data *plat = dwmac->plat;
> +	unsigned long rate;
> +	u32 div;

Reverse christmas tree please. You will need to move the plat
assignment into the body of the code.

> +static int thead_dwmac_probe(struct platform_device *pdev)
> +{
> +	struct plat_stmmacenet_data *plat;
> +	struct stmmac_resources stmmac_res;
> +	struct thead_dwmac *dwmac;
> +	struct device_node *np = pdev->dev.of_node;
> +	u32 delay_ps;
> +	int ret;
> +	void __iomem *apb;

np and apb should be earlier to keep with reverse christmas
tree. Please check and fix all functions.

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
> +	if (!of_property_read_u32(np, "rx-internal-delay-ps", &delay_ps))
> +		dwmac->rx_delay = delay_ps;

> +#define  GMAC_RXCLK_DELAY_MASK		GENMASK(4, 0)

So this is a 5 bit value. You should perform a range check. So, do you
need to do some sort of conversion from picoseconds to register value?

> +MODULE_AUTHOR("T-HEAD");

Authors are people.

> +MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
> +MODULE_DESCRIPTION("T-HEAD dwmac platform driver");
> +MODULE_LICENSE("GPL");


    Andrew

---
pw-bot: cr

