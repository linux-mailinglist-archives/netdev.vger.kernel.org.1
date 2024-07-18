Return-Path: <netdev+bounces-112074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E27934D7A
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 14:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2E328119E
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2714813C697;
	Thu, 18 Jul 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T04yDx62"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD9313BC30
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721307120; cv=none; b=qpADSeL+D6KUkzI4hzmtbG+bNfSSOtbYfqeOuQ6E7jCwJJpfnZ1PUdodFmvMyU5jbkF6UHSWzgX75DKFeW/4YRzHB5GMsFaHWUY0IaeEUsluHi5OBEXdITeRiReRFzwlhgMB60fymwOdqWS2YMabG6pySwdAhfrpTfZ32aRC7+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721307120; c=relaxed/simple;
	bh=EuOyxngGrY7nsVHp5Ez2dF5N9HdzLFg2Ou9Q3HFYto8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4+ZQvST5rFDPxlX7yc5SR99/PzsdozLCn8K+U28dAxwCAfqn7kOf+Hu0YhWlwilurWam6FXWpFx6HTzckQgBwaJB+ZqEx2k+tt7umn23sWjNxYKtHMFE0T81YTMsS856Tf07d3gI5mTmoMV0N+fbq/8mcqL9/zRybBbKECaBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T04yDx62; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-78964fd9f2dso499025a12.3
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721307118; x=1721911918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGLtgrWUhu6mOevXq8fD4VuteLw6ANaOq0hILe6MREs=;
        b=T04yDx622tZVbLd6/afLKe5+bxvHj3yx+cjr347EMg+ITsM6rfwNjNH+AUNl0rTr5n
         3v0qa+d83dX92Q0OhPUIqGNHqfDIr3ITL6Qr9McStQTxhCr5E01/mO8Rw3i4GrmNSs6m
         FOup4lM5/G4z5SYCZRsyMaAPTOD/tApc42NwZAgQUVUNdBQ+1ovvAwf9b7eYQC88yAAf
         dW42qx4Fupa3cMaysJ/LtY7qbUY2jnAOeThWYZeaOi/qbT9/OPs6uEU8MoYiV+qJPyBu
         rxYRtr7sBaRSxnKmXqEtxwTUNDbbAFCbHD7ROpZ8ZcwYLfPFGsMteEoJi4QOKuEdu0cM
         zXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721307118; x=1721911918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGLtgrWUhu6mOevXq8fD4VuteLw6ANaOq0hILe6MREs=;
        b=dJjtaFeVIsYfYA9b+Hv67dHxOcl5haqivrjSnwSNo3W3HkCEP+FZ268LBNecj96ess
         fGheWst7YrcqsdNwQUQWvMHQBohKvebJvDV6UjVIBl6ntjeepo1FF6fIjtou6kwu+UIn
         S/mAaszL/GOFHZxtt6vem/dmwyoOhQT3bSvyf1MXRPisG3ncDWPOH99ZdIsUXdmtWSCo
         wzxUO0jJxokBIIOaXdYBt/See9cGaMSXVRCn/LeF20ZhQoSo23b49dkf7z2aXY/yhMKq
         S6KEpjsha85BvK999C26peQCxSu35awOciVG21q1UqJYYaPNKs0OXRHhyPCrkwNuhBUz
         MuRg==
X-Forwarded-Encrypted: i=1; AJvYcCXVtKnPSJ98rCPGZGWFL/sD4ltOooiHPsFkh6MVIwhp0nHQOVRqG6kOQYrasZ7CMd1K+6+3jTDtryrIuHs2V/Y8AuafWeMe
X-Gm-Message-State: AOJu0Yx+JT0YpeZXF+RqUf7mMP80euLS3DMe8vgDMmN0nOLp8TfHO4Sh
	F5TDGeE6wUF6VgxAuUgMndgAYZuRgE7uu69exFmwrdoUIe0B24EA
X-Google-Smtp-Source: AGHT+IE1/U9a1nmlTROM5Fg4OavoDYAw0fEGEip1ApzMlHe9I5jSMcFRQNk3tXu4tucBZZ377efRag==
X-Received: by 2002:a05:6a20:8423:b0:1c0:f6d5:be9a with SMTP id adf61e73a8af0-1c3fddc4176mr6635247637.36.1721307117482;
        Thu, 18 Jul 2024 05:51:57 -0700 (PDT)
Received: from mobilestation ([176.15.243.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc692109aasm8993935ad.104.2024.07.18.05.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 05:51:56 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:51:50 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v14 11/14] net: stmmac: dwmac-loongson: Add
 DT-less GMAC PCI-device support
Message-ID: <4nblf3m3quobk2tmycrdp4v3zltdmhmvrmoqh6mtroj45i5yjc@dmpmh7ohgsde>
References: <cover.1720512634.git.siyanteng@loongson.cn>
 <c558c9ff8e5a8a3657c1e60d6dfc4fa3a121ae93.1720512634.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c558c9ff8e5a8a3657c1e60d6dfc4fa3a121ae93.1720512634.git.siyanteng@loongson.cn>

On Tue, Jul 09, 2024 at 05:37:04PM +0800, Yanteng Si wrote:
> The Loongson GMAC driver currently supports the network controllers
> installed on the LS2K1000 SoC and LS7A1000 chipset, for which the GMAC
> devices are required to be defined in the platform device tree source.
> But Loongson machines may have UEFI (implies ACPI) or PMON/UBOOT
> (implies FDT) as the system bootloaders. In order to have both system
> configurations support let's extend the driver functionality with the
> case of having the Loongson GMAC probed on the PCI bus with no device
> tree node defined for it. That requires to make the device DT-node
> optional, to rely on the IRQ line detected by the PCI core and to
> have the MDIO bus ID calculated using the PCIe Domain+BDF numbers.

Let's extend the log with an additional note:

"In order to have the device probe() and remove() methods less
complicated let's move the DT- and ACPI-specific code to the
respective sub-functions."

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 136 ++++++++++--------
>  1 file changed, 79 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 10b49bea8e3c..b4704068321f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -12,11 +12,15 @@
>  #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>  
>  struct stmmac_pci_info {
> -	int (*setup)(struct plat_stmmacenet_data *plat);
> +	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
>  };
>  
> -static void loongson_default_data(struct plat_stmmacenet_data *plat)
> +static void loongson_default_data(struct pci_dev *pdev,
> +				  struct plat_stmmacenet_data *plat)
>  {
> +	/* Get bus_id, this can be overwritten later */
> +	plat->bus_id = pci_dev_id(pdev);
> +
>  	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>  	plat->has_gmac = 1;
>  	plat->force_sf_dma_mode = 1;
> @@ -49,9 +53,10 @@ static void loongson_default_data(struct plat_stmmacenet_data *plat)
>  	plat->dma_cfg->pblx8 = true;
>  }
>  
> -static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
> +static int loongson_gmac_data(struct pci_dev *pdev,
> +			      struct plat_stmmacenet_data *plat)
>  {
> -	loongson_default_data(plat);
> +	loongson_default_data(pdev, plat);
>  
>  	plat->tx_queues_to_use = 1;
>  	plat->rx_queues_to_use = 1;
> @@ -65,21 +70,72 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>  	.setup = loongson_gmac_data,
>  };
>  
> -static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +static int loongson_dwmac_dt_config(struct pci_dev *pdev,
> +				    struct plat_stmmacenet_data *plat,
> +				    struct stmmac_resources *res)
>  {
> -	struct plat_stmmacenet_data *plat;
> -	struct stmmac_pci_info *info;
> -	struct stmmac_resources res;
> -	struct device_node *np;
> -	int ret, i, phy_mode;
> +	struct device_node *np = dev_of_node(&pdev->dev);
> +	int ret;
> +

> +	plat->mdio_node = of_get_child_by_name(np, "mdio");
> +	if (plat->mdio_node) {
> +		dev_info(&pdev->dev, "Found MDIO subnode\n");
> +		plat->mdio_bus_data->needs_reset = true;
> +	}

This needs to be reverted in case if the following up code fails.
So ...

> +
> +	ret = of_alias_get_id(np, "ethernet");
> +	if (ret >= 0)
> +		plat->bus_id = ret;
> +
> +	res->irq = of_irq_get_byname(np, "macirq");
> +	if (res->irq < 0) {
> +		dev_err(&pdev->dev, "IRQ macirq not found\n");

> +		return -ENODEV;

		ret = -ENODEV;
		goto err_put_node;

> +	}
>  
> -	np = dev_of_node(&pdev->dev);
> +	res->wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> +	if (res->wol_irq < 0) {
> +		dev_info(&pdev->dev,
> +			 "IRQ eth_wake_irq not found, using macirq\n");
> +		res->wol_irq = res->irq;
> +	}
>  
> -	if (!np) {
> -		pr_info("dwmac_loongson_pci: No OF node\n");
> +	res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
> +	if (res->lpi_irq < 0) {
> +		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");

>  		return -ENODEV;

		err = -ENODEV;
		goto err_put_node;

>  	}
>  
> +	ret = device_get_phy_mode(&pdev->dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "phy_mode not found\n");

> +		return -ENODEV;

		goto err_put_node;

> +	}
> +
> +	plat->phy_interface = ret;
> +
> +	return 0;

err_put_node:
	of_node_put(plat->mdio_node);

	return ret;

> +}

static void loongson_dwmac_dt_clear(struct pci_dev *pdev,
				    struct plat_stmmacenet_data *plat)
{
	of_node_put(plat->mdio_node);
}

and ...

> +
> +static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
> +				      struct plat_stmmacenet_data *plat,
> +				      struct stmmac_resources *res)
> +{
> +	if (!pdev->irq)
> +		return -EINVAL;
> +
> +	res->irq = pdev->irq;
> +
> +	return 0;
> +}
> +
> +static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct plat_stmmacenet_data *plat;
> +	struct stmmac_pci_info *info;
> +	struct stmmac_resources res;
> +	int ret, i;
> +
>  	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>  	if (!plat)
>  		return -ENOMEM;
> @@ -90,17 +146,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	if (!plat->mdio_bus_data)
>  		return -ENOMEM;
>  
> -	plat->mdio_node = of_get_child_by_name(np, "mdio");
> -	if (plat->mdio_node) {
> -		dev_info(&pdev->dev, "Found MDIO subnode\n");
> -		plat->mdio_bus_data->needs_reset = true;
> -	}
> -
>  	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
> -	if (!plat->dma_cfg) {
> -		ret = -ENOMEM;
> -		goto err_put_node;
> -	}
> +	if (!plat->dma_cfg)
> +		return -ENOMEM;
>  
>  	/* Enable pci device */
>  	ret = pci_enable_device(pdev);
> @@ -109,6 +157,8 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id

>  		goto err_put_node;

		return ret;

>  	}
>  
> +	pci_set_master(pdev);
> +
>  	/* Get the base address of device */
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		if (pci_resource_len(pdev, i) == 0)
> @@ -119,48 +169,20 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		break;
>  	}
>  
> -	plat->bus_id = of_alias_get_id(np, "ethernet");
> -	if (plat->bus_id < 0)
> -		plat->bus_id = pci_dev_id(pdev);
> -
> -	phy_mode = device_get_phy_mode(&pdev->dev);
> -	if (phy_mode < 0) {
> -		dev_err(&pdev->dev, "phy_mode not found\n");
> -		ret = phy_mode;
> -		goto err_disable_device;
> -	}
> -
> -	plat->phy_interface = phy_mode;
> -
> -	pci_set_master(pdev);
> -
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
>  
>  	info = (struct stmmac_pci_info *)id->driver_data;
> -	ret = info->setup(plat);
> +	ret = info->setup(pdev, plat);
>  	if (ret)
>  		goto err_disable_device;
>  
> -	res.irq = of_irq_get_byname(np, "macirq");
> -	if (res.irq < 0) {
> -		dev_err(&pdev->dev, "IRQ macirq not found\n");
> -		ret = -ENODEV;
> -		goto err_disable_device;
> -	}
> -
> -	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> -	if (res.wol_irq < 0) {
> -		dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
> -		res.wol_irq = res.irq;
> -	}
> -
> -	res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
> -	if (res.lpi_irq < 0) {
> -		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> -		ret = -ENODEV;
> +	if (dev_of_node(&pdev->dev))
> +		ret = loongson_dwmac_dt_config(pdev, plat, &res);
> +	else
> +		ret = loongson_dwmac_acpi_config(pdev, plat, &res);
> +	if (ret)
>  		goto err_disable_device;
> -	}
>  
>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)

... make sure loongson_dwmac_dt_clear() is called in the
cleanup-on-error path:

        ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
        if (ret)
                goto err_plat_clear;

        return 0;

err_plat_clear:
	if (dev_of_node(&pdev->dev))
		loongson_dwmac_dt_clear(pdev, plat);

err_disable_device:
        pci_disable_device(pdev);

        return ret;

... and in the loongson_dwmac_remove() method:

static void loongson_dwmac_remove(struct pci_dev *pdev)
{
	...

        stmmac_dvr_remove(&pdev->dev);

	if (dev_of_node(&pdev->dev))
		loongson_dwmac_dt_clear(pdev, priv->plat);

	...
}

-Serge(y)

> -- 
> 2.31.4
> 

