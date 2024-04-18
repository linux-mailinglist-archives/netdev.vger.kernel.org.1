Return-Path: <netdev+bounces-89206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8798A9ADD
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7501C20DA7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922E13D89B;
	Thu, 18 Apr 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNcu7kN9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494E823A2
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445704; cv=none; b=F+zZo2sH9CMRAYIkI1hqU2zMIJfv0JX8+IFE32+Y0vIVsrQ4/sUOp0cuUeeGVzUgCwGbYPPyJaRJMeRYK6xgY1ppbpOV9RBHdaMIrwFeb0FoavEnAX853cnRZagdPx4hD9Cg5vv++HB5UNSMQdyqGz/xCK/Q0cBZXR7s3anm19Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445704; c=relaxed/simple;
	bh=aP+7HADtYJo3igKhSBrXNzs4r4e9f9NPTjqO03x94SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGUhsmXm2G/EDEq1E2t8PBjD39Jn33BMWau/mmt8ATpLuFVrjfko9ssez9d+tNjyOvZDkIduhJ6vMHI6e6M2XVgxmub8ILXEopFvgD8uBAuJPSl5QE4Po+wOgiccHkR3cxx977iriRH48vzEnPTvj5OXBj4QeN1QnbHFpU5Tuws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNcu7kN9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-518a3e0d2e4so800183e87.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713445699; x=1714050499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tY0ewv6WISiK8kt2R7sB1OG56vBsDo7I8v+1iu01wuY=;
        b=iNcu7kN9Kf+t8WPvfGmLBt/TRtJXIIDCQ5LnZ1Ahvhge8PDc9DCFCwVGpFtARLni0D
         qDb0HBwr0Aod8cS/vLhA0Fk4uS2sNhGWOYyvkfB/qkgf1nKXwtUVcWjcNazZLPdjCVev
         mpylCgwMYO6Wxdv472X4UmkyAE2nQU9+RtRg2uYMHoQf8Sepv1rLJDkdfHOIwprhQo3X
         T0bLglJNqYDPmAnjKZOvqk+NLpdDLnLq+Z8AVHiBhGQALLkf9MQA/2BVHM8ogWBylg3t
         8UDmeR9z1K/XHMT+hf6SGJn5o5N2H3BJDau5ww+filJ6IDmpWJOJ4PqEVXsfX9W+Ih1Q
         5hsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713445699; x=1714050499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tY0ewv6WISiK8kt2R7sB1OG56vBsDo7I8v+1iu01wuY=;
        b=GN2wiXbWkMmJwjtWdmBni3JJC9joXDXJNpwoDRisoNao2bYIIB+WmIvqafNVFHLibx
         K4NqZEw8ri/NIMf8z4rV/FTqRF/Aq3+m9cK57CrrQ8VNOVlRuyaDeSX3EFey1VOGAu7X
         dZBQEvtII0B+dBuWo4yfqT76+1Q0CBY6isigeulAmSjXcyURmjTAAAp/IFSizQXgpkeH
         eea0q+GptGsH+z34X/YOw2L6B9eVhSrOU8IqkTjfKCMGdzV4agoVIqRCkSOrPhIzezHt
         ezEfGeWTnbLt3Y+I2ycSEhIXK4rozT5Omzot0vBzHh/JmAZqtZwGOjnWp/YTDEfJ3MkE
         aOIw==
X-Forwarded-Encrypted: i=1; AJvYcCU+Ao1totNaGLiiZoDzO2YGS9jiywHPNjfFhVB+c0FobRol4fN3J/XKMAXixFCkQ8TDaQQbnpPcpl41GHyUrOJ6sVOm4rmg
X-Gm-Message-State: AOJu0Ywi0+075KdJVjmrJXR5LPuRHgYX0/vlaXKijdGYmE8UU52k9X2r
	H7BcaPDigeCerSQAP6bsHr0jlcKc8DnnIqTj9JzTmDUTf6m24w4y
X-Google-Smtp-Source: AGHT+IGHDtl20ewDVkCnB0KGiyOJaCb0X1zPXB6knBjbnWwKvoP2/6+/lrWcocTMVsteGPJtL5Vpyg==
X-Received: by 2002:a19:9150:0:b0:519:99c:9018 with SMTP id y16-20020a199150000000b00519099c9018mr706515lfj.11.1713445698537;
        Thu, 18 Apr 2024 06:08:18 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id v27-20020a05651203bb00b0051969a5b408sm235987lfp.39.2024.04.18.06.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:08:18 -0700 (PDT)
Date: Thu, 18 Apr 2024 16:08:16 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v11 5/6] net: stmmac: dwmac-loongson: Add full
 PCI support
Message-ID: <adnsyedexlqbncmadqzsr7f2vnqcvilzow4n3ibajxek4qes4m@pmwhb636j2qp>
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <ae660c8872297b562ee4e62cd852ba96f307e079.1712917541.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae660c8872297b562ee4e62cd852ba96f307e079.1712917541.git.siyanteng@loongson.cn>

On Fri, Apr 12, 2024 at 07:28:50PM +0800, Yanteng Si wrote:
> Current dwmac-loongson only support LS2K in the "probed with PCI and
> configured with DT" manner. Add LS7A support on which the devices are
> fully PCI (non-DT).
> 
> Others:
> LS2K is a SoC and LS7A is a bridge chip. In the current driving state,
> they are both gmac and phy_interface is RGMII.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 103 +++++++++++-------
>  1 file changed, 64 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index ad19b4087974..69078eb1f923 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -9,9 +9,19 @@
>  #include <linux/of_irq.h>
>  #include "stmmac.h"
>  
> +#define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
> +
> +struct stmmac_pci_info {
> +	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
> +};
> +
>  static void loongson_default_data(struct pci_dev *pdev,
>  				  struct plat_stmmacenet_data *plat)
>  {
> +	/* Get bus_id, this can be overloaded later */
> +	plat->bus_id = (pci_domain_nr(pdev->bus) << 16) |
> +		       PCI_DEVID(pdev->bus->number, pdev->devfn);
> +
>  	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>  	plat->has_gmac = 1;
>  	plat->force_sf_dma_mode = 1;
> @@ -40,6 +50,7 @@ static int loongson_gmac_data(struct pci_dev *pdev,
>  
>  	/* Default to phy auto-detection */
>  	plat->phy_addr = -1;
> +	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
>  
>  	plat->dma_cfg->pbl = 32;
>  	plat->dma_cfg->pblx8 = true;
> @@ -54,19 +65,17 @@ static int loongson_gmac_data(struct pci_dev *pdev,
>  	return 0;
>  }
>  
> +static struct stmmac_pci_info loongson_gmac_pci_info = {
> +	.setup = loongson_gmac_data,
> +};
> +
>  static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct plat_stmmacenet_data *plat;
> +	int ret, i, bus_id, phy_mode;
> +	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
>  	struct device_node *np;
> -	int ret, i, phy_mode;
> -

> -	np = dev_of_node(&pdev->dev);
> -
> -	if (!np) {
> -		pr_info("dwmac_loongson_pci: No OF node\n");
> -		return -ENODEV;
> -	}

Hm, I see you dropping this snippet and never getting it back in this
patch. Thus after the patch is applied np will be left uninitialized,
which will completely break the driver. Please make sure it's fixed.

This problem has been introduced at the v9 stage, which I didn't have
time to review. There were no problem like that in v8.

-Serge(y)

>  
>  	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>  	if (!plat)
> @@ -78,12 +87,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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
>  	if (!plat->dma_cfg) {
>  		ret = -ENOMEM;
> @@ -107,10 +110,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		break;
>  	}
>  
> -	plat->bus_id = of_alias_get_id(np, "ethernet");
> -	if (plat->bus_id < 0)
> -		plat->bus_id = pci_dev_id(pdev);
> -
>  	phy_mode = device_get_phy_mode(&pdev->dev);
>  	if (phy_mode < 0) {
>  		dev_err(&pdev->dev, "phy_mode not found\n");
> @@ -123,30 +122,56 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  
>  	pci_set_master(pdev);
>  
> -	loongson_gmac_data(pdev, plat);
> -	pci_enable_msi(pdev);
> -	memset(&res, 0, sizeof(res));
> -	res.addr = pcim_iomap_table(pdev)[0];
> -
> -	res.irq = of_irq_get_byname(np, "macirq");
> -	if (res.irq < 0) {
> -		dev_err(&pdev->dev, "IRQ macirq not found\n");
> -		ret = -ENODEV;
> -		goto err_disable_msi;
> -	}
> +	info = (struct stmmac_pci_info *)id->driver_data;
> +	ret = info->setup(pdev, plat);
> +	if (ret)
> +		goto err_disable_device;
>  
> -	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> -	if (res.wol_irq < 0) {
> -		dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
> -		res.wol_irq = res.irq;
> +	if (np) {
> +		plat->mdio_node = of_get_child_by_name(np, "mdio");
> +		if (plat->mdio_node) {
> +			dev_info(&pdev->dev, "Found MDIO subnode\n");
> +			plat->mdio_bus_data->needs_reset = true;
> +		}
> +
> +		bus_id = of_alias_get_id(np, "ethernet");
> +		if (bus_id >= 0)
> +			plat->bus_id = bus_id;
> +
> +		phy_mode = device_get_phy_mode(&pdev->dev);
> +		if (phy_mode < 0) {
> +			dev_err(&pdev->dev, "phy_mode not found\n");
> +			ret = phy_mode;
> +			goto err_disable_device;
> +		}
> +		plat->phy_interface = phy_mode;
> +
> +		res.irq = of_irq_get_byname(np, "macirq");
> +		if (res.irq < 0) {
> +			dev_err(&pdev->dev, "IRQ macirq not found\n");
> +			ret = -ENODEV;
> +			goto err_disable_msi;
> +		}
> +
> +		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> +		if (res.wol_irq < 0) {
> +			dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
> +			res.wol_irq = res.irq;
> +		}
> +
> +		res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
> +		if (res.lpi_irq < 0) {
> +			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> +			ret = -ENODEV;
> +			goto err_disable_msi;
> +		}
> +	} else {
> +		res.irq = pdev->irq;
>  	}
>  
> -	res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
> -	if (res.lpi_irq < 0) {
> -		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> -		ret = -ENODEV;
> -		goto err_disable_msi;
> -	}
> +	pci_enable_msi(pdev);
> +	memset(&res, 0, sizeof(res));
> +	res.addr = pcim_iomap_table(pdev)[0];
>  
>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
> -- 
> 2.31.4
> 

