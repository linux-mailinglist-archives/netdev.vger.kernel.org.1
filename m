Return-Path: <netdev+bounces-93690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595AB8BCC20
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 12:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EC11F237D8
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 10:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC38C4204B;
	Mon,  6 May 2024 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaY81R1k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106753FB01
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714991971; cv=none; b=KzqJOGYLEW9BQdte9SrgNmEwBb3PzgNoFEIUu6Io5MCzPcCX6db+omkljswmNUQ01TUqyBX3aAI2/YeXDIg79CVE4loMdqib2zZ1hF0uD89yTal1BLQ6PTGiYw99h5Sbnz1GIDBfAQbm0RBIRKivNob+iPVjmHBiVqCfUhP8TV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714991971; c=relaxed/simple;
	bh=9i2/+ErYcB9oz2880zKRUydc6iDuCpjZ6d4276pkhoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlFiBl7gPMHoavHJP1hOk+cF5QQf9+txp7p28CVoejcmlVP0VK6lgsbQgDqCodp7FLuIs2QePtPjJDJw3YP+5kyOW6lNIhWp3ZE5K/ApjKaGSTzJYT7hgea7S76rUZz+w49gnn+5DJ5SGUuOjzEMxCWiXXt+JnNB65clZyfLOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaY81R1k; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so2133029e87.1
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 03:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714991968; x=1715596768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6nsA7vG8OvNMmMvn9MeDr3P9BPT2uDIXSUCPJvJfIY=;
        b=AaY81R1ktKy89dbg/xZ+5+Wsp0xAnQtvyqeuSzKVnp+a+l/1/xHVvBQZ/CwLUijKNF
         wZ5mLrZ8I4Mvg3Q6UMr6j75dxqXWKrfGAOAscn+ub3HtuN1Xsd5x8o0fte4ASldraNjx
         atWK3pSfBUf0+g0Ya/DhH0iM10aFddLmN1PuacM/5tnOgbCYerPcpBnvmMn/PF82RDt3
         RQvoluzvWeMPh8r08SHQfamHQQZHDS3MaoiMQY/ETTuCCuYNCHLkhDXTlNQX4NZIzFjR
         xfdZ5AQsawFRQi4T5JnmMhefo5hATUkVLD/t60xYJmBnsrJFzmt+47VbfRbY2byiQZBN
         +C7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714991968; x=1715596768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6nsA7vG8OvNMmMvn9MeDr3P9BPT2uDIXSUCPJvJfIY=;
        b=dhkMueP3LGmEUXVJ/zb900jDRf2cPO0QeXYMWrg3O7SywA458jM1o3Zwei4cV57VIB
         EXcbSQ13zNlvpTpDjukGgeiaLK9lk7IgplYhF7iDjZoBJlf1z1nrOIAudgFmner+/j6s
         a6BiDPju8EjkqnXhN+sDsDWUHe3w1WzN7ocZVg2/tt2j5189Aav7DXhzmkbezCInU+tO
         KYMsaVDJdcF06kobtTV0Bix7t16o8cIAd/dVGfusRNKidRmT2YHtP+oR0akBn27II+pD
         PeYX+855WFOx9z1hNR6qtWuyCTsCGYqPMh0zm1FGh+AhpJEhu8y+mBml6G/fB8TNt4km
         34vA==
X-Forwarded-Encrypted: i=1; AJvYcCUyhj8NwDxTZLsChA8c7XawWiNaxDuiilr9RsHtYItSFWYC5QV6tP4OgRdQJyAEpptdfx8CtxdyaBqmeibU0lQHXFUYL8c/
X-Gm-Message-State: AOJu0YxsefME09ivYHINVfEj01La+fe7aPnO1IGHkjc6R4QSVNaGpjWC
	95r/hYNGbha7GuE6M+A0H52lavmilJwg7sioeXvN/K+LJm9MeUFH
X-Google-Smtp-Source: AGHT+IER9z9ChzD/DpmIGdDY5jwDtt3ZmD2FE4YmuB8kOwlE6HDW9cZnWLfhJpaoZREkcyBp4TC34g==
X-Received: by 2002:ac2:5b01:0:b0:520:107f:8375 with SMTP id v1-20020ac25b01000000b00520107f8375mr4078974lfn.50.1714991967928;
        Mon, 06 May 2024 03:39:27 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 7-20020ac25f07000000b0051f1b4709d9sm1585080lfq.163.2024.05.06.03.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 03:39:27 -0700 (PDT)
Date: Mon, 6 May 2024 13:39:24 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <jkjgjraqvih4zu7wvqykerq5wisgkhqf2n2pouha7qhfoeif7v@tkwyx53dfrdw>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>

On Thu, Apr 25, 2024 at 09:11:36PM +0800, Yanteng Si wrote:
> ...
>  
> +static int loongson_dwmac_config_msi(struct pci_dev *pdev,
> +				     struct plat_stmmacenet_data *plat,
> +				     struct stmmac_resources *res,
> +				     struct device_node *np)
> +{
> +	int i, ret, vecs;
> +
> +	vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> +	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> +	if (ret < 0) {
> +		dev_info(&pdev->dev,
> +			 "MSI enable failed, Fallback to legacy interrupt\n");
> +		return loongson_dwmac_config_legacy(pdev, plat, res, np);
> +	}
> +
> +	res->irq = pci_irq_vector(pdev, 0);
> +	res->wol_irq = 0;
> +
> +	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> +	 * --------- ----- -------- --------  ...  -------- --------
> +	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> +	 */
> +	for (i = 0; i < CHANNEL_NUM; i++) {
> +		res->rx_irq[CHANNEL_NUM - 1 - i] =
> +			pci_irq_vector(pdev, 1 + i * 2);
> +		res->tx_irq[CHANNEL_NUM - 1 - i] =
> +			pci_irq_vector(pdev, 2 + i * 2);
> +	}
> +
> +	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> +
> +	return 0;
> +}
> +
> ...
>  static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct plat_stmmacenet_data *plat;
>  	int ret, i, bus_id, phy_mode;
>  	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
> +	struct loongson_data *ld;
>  	struct device_node *np;
>  
>  	np = dev_of_node(&pdev->dev);
> @@ -122,10 +460,12 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		return -ENOMEM;
>  
>  	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
> -	if (!plat->dma_cfg) {
> -		ret = -ENOMEM;
> -		goto err_put_node;
> -	}
> +	if (!plat->dma_cfg)
> +		return -ENOMEM;
> +
> +	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> +	if (!ld)
> +		return -ENOMEM;
>  
>  	/* Enable pci device */
>  	ret = pci_enable_device(pdev);
> @@ -171,14 +511,34 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		plat->phy_interface = phy_mode;
>  	}
>  
> -	pci_enable_msi(pdev);
> +	plat->bsp_priv = ld;
> +	plat->setup = loongson_dwmac_setup;
> +	ld->dev = &pdev->dev;
> +
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
> +	ld->gmac_verion = readl(res.addr + GMAC_VERSION) & 0xff;
> +
> +	switch (ld->gmac_verion) {
> +	case LOONGSON_DWMAC_CORE_1_00:
> +		plat->rx_queues_to_use = CHANNEL_NUM;
> +		plat->tx_queues_to_use = CHANNEL_NUM;
> +
> +		/* Only channel 0 supports checksum,
> +		 * so turn off checksum to enable multiple channels.
> +		 */
> +		for (i = 1; i < CHANNEL_NUM; i++)
> +			plat->tx_queues_cfg[i].coe_unsupported = 1;
>  
> -	plat->tx_queues_to_use = 1;
> -	plat->rx_queues_to_use = 1;
> +		ret = loongson_dwmac_config_msi(pdev, plat, &res, np);
> +		break;
> +	default:	/* 0x35 device and 0x37 device. */
> +		plat->tx_queues_to_use = 1;
> +		plat->rx_queues_to_use = 1;
>  
> -	ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> +		ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> +		break;
> +	}
>  

Let's now talk about this change.

First of all, one more time. You can't miss the return value check
because if any of the IRQ config method fails then the driver won't
work! The first change that introduces the problem is in the patch
[PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy

Second, as I already mentioned in another message sent to this patch
you are missing the PCI MSI IRQs freeing in the cleanup-on-error path
and in the device/driver remove() function. It's definitely wrong.

Thirdly, you said that the node-pointer is now optional and introduced
the patch 
[PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
If so and the DT-based setting up isn't mandatory then I would
suggest to proceed with the entire so called legacy setups only if the
node-pointer has been found, otherwise the pure PCI-based setup would
be performed. So the patches 10-13 (in your v12 order) would look
like this:

1. Patch 10 introduces the two types of the configs - DT and PCI plus
the bus_id initialized based on the PCI domain and device ID.
[PATCH net-next v13 10/15] net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
The DT and PCI config functions can look like this:

static int loongson_dwmac_config_dt(struct pci_dev *pdev,
				    struct plat_stmmacenet_data *plat,
				    struct stmmac_resources *res)
{
	struct device_node *np = dev_of_node(&pdev->dev);
	int ret;

	plat->mdio_node = of_get_child_by_name(np, "mdio");
	if (plat->mdio_node) {
		dev_info(&pdev->dev, "Found MDIO subnode\n");
		plat->mdio_bus_data->needs_reset = true;
	}

	ret = of_alias_get_id(np, "ethernet");
	if (ret >= 0)
		plat->bus_id = ret;

	res->irq = of_irq_get_byname(np, "macirq");
	if (res->irq < 0) {
		dev_err(&pdev->dev, "IRQ macirq not found\n");
		return -ENODEV;
	}

	res->wol_irq = of_irq_get_byname(np, "eth_wake_irq");
	if (res->wol_irq < 0) {
		dev_info(&pdev->dev,
			 "IRQ eth_wake_irq not found, using macirq\n");
		res->wol_irq = res->irq;
	}

	res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
	if (res->lpi_irq < 0) {
		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
		return -ENODEV;
	}

	return 0;
}

static int loongson_dwmac_config_pci(struct pci_dev *pdev,
				     struct plat_stmmacenet_data *plat,
				     struct stmmac_resources *res)
{
	res.irq = pdev->irq;

	return 0;
}

...

static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
{
	...
	if (dev_of_node(&pdev->dev))
		ret = loongson_dwmac_dt_config(pdev, plat, res);
	else
		ret = loongson_dwmac_pci_config(pdev, plat, res);
	if (ret)
		goto err_disable_msi;

	...
}

2. Patch 11 introduces the stmmac_pci_info structure, makes the
stmmac_pci_info::setup() callback called in the probe() function and
assigns the loongson_gmac_data() method pointer to the GMAC info data. 
[PATCH net-next v13 11/15] net: stmmac: dwmac-loongson: Introduce PCI device info data

3. Patch 12 can be preserved as is (but see my notes regarding moving
a part of it to the patch 13).
[PATCH net-next v13 12/15] net: stmmac: dwmac-loongson: Add flag disabling AN-less 1Gbps setup

4. Patch 13 introduces the GNET support as it's mainly done in your
patch (see my notes in there though)
[PATCH net-next v13 13/15] net: stmmac: dwmac-loongson: Add Loongson GNET support
but the loongson_dwmac_config_pci() method would now look as follows:

static int loongson_dwmac_config_pci(struct pci_dev *pdev,
				     struct plat_stmmacenet_data *plat,
				     struct stmmac_resources *res)
{
	int i, ret, vecs;

	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
	 * --------- ----- -------- --------  ...  -------- --------
	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
	 */
	vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
	ret = pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IRQ_LEGACY);
	if (ret < 0) {
		dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
		return ret;
	} else if (ret >= vecs) {
		for (i = 0; i < CHANNEL_NUM; i++) {
			res->rx_irq[CHANNEL_NUM - 1 - i] =
				pci_irq_vector(pdev, 1 + i * 2);
			res->tx_irq[CHANNEL_NUM - 1 - i] =
				pci_irq_vector(pdev, 2 + i * 2);
		}

		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
	} else {
		dev_warn(&pdev->dev, "Fall back to PCIe INTx IRQs\n");
	}

	res->irq = pci_irq_vector(pdev, 0);

	return 0;
}

What do you think?

-Serge(y)


