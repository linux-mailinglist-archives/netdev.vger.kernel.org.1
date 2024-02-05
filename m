Return-Path: <netdev+bounces-69161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6890849D40
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 15:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0F1280E70
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 14:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A1924B4A;
	Mon,  5 Feb 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItSMWlAc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089822C68F
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144229; cv=none; b=hAhEcIMbgzaCFxwcTFhaKt/r5tJm1LIcoZ2RPB/tDU7c4/3mrRlN1Aw8c0Aa+0STVbgCKTKcV+uSJIS7+v3GyWb/KDGo66tT0Bc6XHsXRnGgFn4i+1lV3LACHj50uCjzB/SjGMGI1h7SD+ffBe7mvIh2XKbxQT+hPLDe/HxUWPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144229; c=relaxed/simple;
	bh=WuSKyk52/3P5l4ayH8LjFOfXyFY69uktccRFTch3zLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6qiooqkBw2UG0xtFBDPf9bdq3fDQX+aemdybg/xz+u1ETYprfLE8n69ervDzMZ74lQ8rl60NNqYLDua5wFTfdRA9ZD9Th345QOQzlet/Ia9mTbIP3MlyO3yBJ4mh47JFxRPH3PHKaAwhffovT3WZg2+2XDvR3/TgKWKEtteMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItSMWlAc; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d09fefabc1so18949301fa.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 06:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707144226; x=1707749026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/PGhQqNjDp0wlx4FyE5Eq61K2PDMeRi6CWww7e0UxGg=;
        b=ItSMWlAc3Z9MDcYGgEsZllPoTdk+FhA3PwbwyuwydXLY5LDv8fqoNJcq10umU+NHX9
         sHcUGwFHGUH1zZpOdg0nVe8BU5RCIYqTMFClCQ/xooRAUqBHrqI8rKX9R1EXaD4IO+yl
         /JSGDQNnd9Vcv2mMM3s4GXRX5o1+IY7sGToC39BjKBJSUnOgfBLnu+ovyjpm4Ps4ssfI
         hWZMq8ybIbv7vXgYP49YhsX7/SRJ/PMmTuMwVpO3y8QHacwoGY4pMhArzd/FkngIYsps
         oCcrQ5MMYv0pezQZjISO3jPMoImdQ3UYv2pVHA6/IIgKNbJXX220OtOntzSGLL+8vP86
         frFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707144226; x=1707749026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PGhQqNjDp0wlx4FyE5Eq61K2PDMeRi6CWww7e0UxGg=;
        b=S1TZ4ZFqtkSH42vlL0bVYpy+qTW3Jic3H6gXvJ/cZX0njW+F0qYYgw7m1kdY8UwtM2
         TygQ7eYCTMeDfU1uXzlZfwDVf9jJ+DvG08mdTmCGFE5h2Juwnhjo/9QXsUgUnHOpprTG
         mLQFLAMankFyD2rhDqjH0ll9SWuIRr8XlDQMmWPXJ5rXFbnyg+1vmWjnyMFFoDof5Tpg
         KRmrVOgFBq4uSo4T6+miC6e/a3qcOG2SN+xG7aNXFf0/tadRU5cON5IHom4uBXdf6Rql
         GQCoQw2N2gba2fX0YqoYPnAI/RD6AjGFdi5jJmrLjgzXdZEDnoXTnYWYyhyso1y/puuI
         BFJw==
X-Gm-Message-State: AOJu0YzkngOmTu4Q5xP5IWGjDd0P02omjNt3YLjvxR1AGv60W/iImEWs
	hiSXzvJ/+BVQpu145USdBOWrq5rITBJ7uj9zBXF314ei+qGkChLu
X-Google-Smtp-Source: AGHT+IGCb9KV+9ueuXOxRr0+w6nQKYUkPqaMeC8Vly6lbcTOqPUgblYBN17d6hSUNU/+ZLFyhN4WbQ==
X-Received: by 2002:a2e:988a:0:b0:2d0:ab84:71ab with SMTP id b10-20020a2e988a000000b002d0ab8471abmr2169ljj.4.1707144225673;
        Mon, 05 Feb 2024 06:43:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW4VxBE9j7KtTZq+QJt4j+x7iavUgo8aFB6ooAUbLWtNzRk8YE8u6i7niCBmuBa1AyIZbp51S3n3lH2Ta6OA+ZvAvwVCkvZhVzxmwvGzoO4c461x6x90cMJRftBFLpGKr9O7tqafkA9DI35cKF2dUxEqzuM/bHm6XA39rfxAxk40ENUMVkiffa0iFSn0xtpzWMU4ymmVMGEq8ZKfgsVLlPWqWHH9e8T6o2deQvHHA/XwRLgk/5R4YGszUD13qLvOh3CoNgASWr4JBHFlIFk50lP6gOGKcl/4GvLBwchTlK6Zxcohlm2uhExPBnKSwTbI0YiUU5YhJxAXZ39+Nd+MPt7z2J3nyDlb9mVz2EcoZnsbkAE768c+t8ht5fRatuLp0AYNijnaw==
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id g3-20020a2eb0c3000000b002d0aa17d2e3sm488585ljl.48.2024.02.05.06.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 06:43:45 -0800 (PST)
Date: Mon, 5 Feb 2024 17:43:42 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 02/11] net: stmmac: dwmac-loongson: Refactor
 code for loongson_dwmac_probe()
Message-ID: <uvar72vvibm44tgn3trr52mpvrjgnn4ttbmyt2mouwws7pkywq@qcyrmj25c4su>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <6a66fdf816665c9d91c4611f47ffe3108b9bd39a.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a66fdf816665c9d91c4611f47ffe3108b9bd39a.1706601050.git.siyanteng@loongson.cn>

On Tue, Jan 30, 2024 at 04:43:22PM +0800, Yanteng Si wrote:
> The driver function is not changed, but the code location is
> adjusted to prepare for adding more loongson drivers.

Having the word "refactoring" in the subject is always suspicious
because submitters very often try to hind behind it many small
changes they didn't want to/didn't know how to unpin from a more bulky
change. Moreover if there is no detailed explanation what is done and
why, it raises too many review questions and makes the reviewers life
much harder. So it would have been much better for us if you split up
this change into the smaller patches (see my last comment for a
presumable subset of the patches) to simplify the review process and
improve the driver bisectability especially seeing there actually are
functional changes introduced here despite of what is said in the
commit log.

> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 61 +++++++++++++------
>  1 file changed, 42 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 9e40c28d453a..e2dcb339b8b0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -9,7 +9,12 @@
>  #include <linux/of_irq.h>
>  #include "stmmac.h"
>  
> -static int loongson_default_data(struct plat_stmmacenet_data *plat)
> +struct stmmac_pci_info {
> +	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
> +};
> +
> +static void loongson_default_data(struct pci_dev *pdev,
> +				  struct plat_stmmacenet_data *plat)
>  {
>  	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>  	plat->has_gmac = 1;
> @@ -34,23 +39,37 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
>  
>  	/* Disable RX queues routing by default */
>  	plat->rx_queues_cfg[0].pkt_route = 0x0;
> +}
> +
> +static int loongson_gmac_data(struct pci_dev *pdev,
> +			      struct plat_stmmacenet_data *plat)
> +{
> +	loongson_default_data(pdev, plat);
> +

> +	plat->multicast_filter_bins = 256;

Why do you need to move this here from the function tail?

> +

> +	plat->mdio_bus_data->phy_mask = 0;

This is already zero. Why do you need this?

>  

> -	/* Default to phy auto-detection */

What is wrong with this comment?

>  	plat->phy_addr = -1;
>  
>  	plat->dma_cfg->pbl = 32;
>  	plat->dma_cfg->pblx8 = true;
>  
> -	plat->multicast_filter_bins = 256;
>  	return 0;
>  }
>  
> -static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +static struct stmmac_pci_info loongson_gmac_pci_info = {
> +	.setup = loongson_gmac_data,
> +};
> +
> +static int loongson_dwmac_probe(struct pci_dev *pdev,
> +				const struct pci_device_id *id)
>  {

> +	int ret, i, bus_id, phy_mode;
>  	struct plat_stmmacenet_data *plat;
> +	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
>  	struct device_node *np;
> -	int ret, i, phy_mode;

Reverse xmas tree order please.

>  
>  	np = dev_of_node(&pdev->dev);
>  
> @@ -69,18 +88,17 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	if (!plat->mdio_bus_data)
>  		return -ENOMEM;
>  

> +	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg),
> +				     GFP_KERNEL);
> +	if (!plat->dma_cfg)
> +		return -ENOMEM;
> +

Why do you need this moved above the mdio_node getting procedure? They
seem independent.

>  	plat->mdio_node = of_get_child_by_name(np, "mdio");
>  	if (plat->mdio_node) {
>  		dev_info(&pdev->dev, "Found MDIO subnode\n");
>  		plat->mdio_bus_data->needs_reset = true;
>  	}
>  
> -	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
> -	if (!plat->dma_cfg) {
> -		ret = -ENOMEM;
> -		goto err_put_node;
> -	}
> -
>  	/* Enable pci device */
>  	ret = pci_enable_device(pdev);
>  	if (ret) {
> @@ -98,9 +116,16 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		break;
>  	}
>  

> -	plat->bus_id = of_alias_get_id(np, "ethernet");
> -	if (plat->bus_id < 0)
> -		plat->bus_id = pci_dev_id(pdev);

This is a functional change because further bus_id is no longer
initialized by the pci_dev_id() method as a fallback case. If you are
sure this is required please unpin to a separate patch and explain.

> +	pci_set_master(pdev);
> +
> +	info = (struct stmmac_pci_info *)id->driver_data;
> +	ret = info->setup(pdev, plat);
> +	if (ret)
> +		goto err_disable_device;
> +
> +	bus_id = of_alias_get_id(np, "ethernet");
> +	if (bus_id >= 0)
> +		plat->bus_id = bus_id;
>  
>  	phy_mode = device_get_phy_mode(&pdev->dev);
>  	if (phy_mode < 0) {
> @@ -110,11 +135,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	}
>  
>  	plat->phy_interface = phy_mode;

> -	plat->mac_interface = PHY_INTERFACE_MODE_GMII;

This is just dropped. Are you sure that the driver will work correctly
after this change is applied? Russell already asked you about this change
here:
https://lore.kernel.org/netdev/ZZPnaziDZEcv5GGw@shell.armlinux.org.uk/

Anyway please unpin it to a separate patch and explain.

>  
> -	pci_set_master(pdev);
> -
> -	loongson_default_data(plat);
>  	pci_enable_msi(pdev);
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
> @@ -212,8 +233,10 @@ static int __maybe_unused loongson_dwmac_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>  			 loongson_dwmac_resume);
>  
> +#define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
> +
>  static const struct pci_device_id loongson_dwmac_id_table[] = {
> -	{ PCI_VDEVICE(LOONGSON, 0x7a03) },
> +	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },

If I were you and needed to preserve all the changes I would have
split the patch up into the next patches:
1. Use PCI_DEVICE_DATA() macro for device identification
2. Drop mac-interface initialization
3. Don't initialize MDIO bus ID with PCIe device ID
4. Introduce device-specific setup callback

-Serge(y)

>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> -- 
> 2.31.4
> 

