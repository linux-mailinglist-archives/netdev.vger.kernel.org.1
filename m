Return-Path: <netdev+bounces-112072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC68934D32
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 14:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E272F1F211B1
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E988B13B295;
	Thu, 18 Jul 2024 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqkK4ddz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082413AD3F
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721305566; cv=none; b=X1hbLhMFTr/PfF/Z+1j/qjMvN/ghNJfTblmwhd6U2hOsSB7FEVhcPMP5sM6yzz45gsGjDNy8j+U+RFv4tWI7DCzKmSFtzd42H0+57hWC+A0IxRUpUeMGxyO/SWlaZiwqjfKEbyqshEUuWysxLfk0PfVbKMq2rWRg13K4PlrEkck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721305566; c=relaxed/simple;
	bh=xECLJ0zWCwFZuqoncGuPCU0QaBV5SZoR0iUq8QMXjY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enVZxgsFFtVKJH/YgjewT+8HNOhptoJgsRWuh0wjn0t3akYtLmFdeDKtAGHIh5iwkUsWj2aKcgYnXBet887mveIRLFIRWEFbm+biSWeksSpCnXiEf3Q/6foYvd4So82XWZGL96UNte2/Sb9BgEPJYHy3w3qcNHWFzgpzS3hFMeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqkK4ddz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70b0e9ee7bcso502501b3a.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 05:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721305565; x=1721910365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KILFo7bX8NyurInTY0JKt5UJIe20ChrRKLf6quiEKxQ=;
        b=FqkK4ddzuIDRRDibnWoDuDSAAjKpf/OVzn0GOKal2ezBLfOdj4VzScfWWH36uOVfCD
         gFPRQJ1XRSkfc6SXgFhekYsedPySlt+PMf2hrubPYFz/WhAJwG03nCgOWyJgZhKQYyKm
         0eU29+XagGdc2a03eLBItF/64aTbuZe7XgwWjHPm5zPMHI4N1VBLwo3SJr8CPUDHj+O9
         gnrqRP8cj3FBUbvqav7TrStP2P+bKDHtUzkUIYA7Y+Q0F3hTUWKxAsac1HtmXlNzFvsT
         i6oV+6K+53jWtKneY5v/3LweHvc7HsoGDwkKW66iEksHSLuIwYBOMzg+SxKIa8BgTF2o
         +QUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721305565; x=1721910365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KILFo7bX8NyurInTY0JKt5UJIe20ChrRKLf6quiEKxQ=;
        b=M4rQSCcyJwyUqczv7aB+3oPC5c1ENWzCpSPX4vYTgfftfDb7sCb0Ezd1fpYfDVLmFQ
         qzpaLUYUyL2sTztsv6OXSfffb8CQdWq1gqfB/YaxWUEq+q2/VCRj57Yin5BbbMXSQ9iN
         IJcQ/hab3FVJW4AEIuOP86lbnXlFix9o18Az468Cg/vZ+opZXMRMbWWz3cIh5Ujb0Eo8
         e+XOc1lxOy1cLmJs/4znov8Ey8G9sFP/hjFLBAFBlS6Ckvnmy6X9J8wo2dJmYKrXGs95
         C2zPNdqncTNDV8o4U66SBPXzTeHZBDki9eDZ3GswG2c9o/ZNw+1kUFm11acWf233Db1D
         hlag==
X-Forwarded-Encrypted: i=1; AJvYcCXpNRrdFhEbkNqNmttpo9GmTiLWetgiRfanVOVDuVP0VMbd66L0WVlZfqB4L1TqXp/+tqWYTid/0IjrfvbnFyvkaaravy6D
X-Gm-Message-State: AOJu0Yx+Mw6bjXXtYqJutnAhLyNosIA3genus2PD0hDuSfAaWjAEdCRt
	o2XIha07p9nbt2bnbYU/qzPl/9ZFix2C6B56DV7RmBl+u3tZxywy
X-Google-Smtp-Source: AGHT+IH6Eaf+k4C+ccW8z2PewxTfp3gYHIdwVZabQQvrcI7Yq2lm+BQq7qf5+fKhv8G+HcXddpIFVA==
X-Received: by 2002:a05:6a00:1808:b0:706:7276:6287 with SMTP id d2e1a72fcca58-70ce4e8d631mr6123964b3a.1.1721305564599;
        Thu, 18 Jul 2024 05:26:04 -0700 (PDT)
Received: from mobilestation ([176.15.243.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e338dcb64sm7721213a12.20.2024.07.18.05.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 05:26:04 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:25:57 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v14 10/14] net: stmmac: dwmac-loongson:
 Introduce PCI device info data
Message-ID: <fyqkuw5sv746eitjccsrx2zwhfggxjfc6vhxek2th66cv2y3zp@b7s5rcrc4lmy>
References: <cover.1720512634.git.siyanteng@loongson.cn>
 <fb59e57bfc3560c742fe13a2f258281860f0abaa.1720512634.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb59e57bfc3560c742fe13a2f258281860f0abaa.1720512634.git.siyanteng@loongson.cn>

On Tue, Jul 09, 2024 at 05:37:03PM +0800, Yanteng Si wrote:
> The Loongson GNET device support is about to be added in one of the
> next commits. As another preparation for that introduce the PCI device
> info data with a setup() callback performing the device-specific
> platform data initializations. Currently it is utilized for the
> already supported Loongson GMAC device only.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c    | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 7d3f284b9176..10b49bea8e3c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -11,6 +11,10 @@
>  
>  #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>  
> +struct stmmac_pci_info {
> +	int (*setup)(struct plat_stmmacenet_data *plat);
> +};
> +
>  static void loongson_default_data(struct plat_stmmacenet_data *plat)
>  {
>  	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
> @@ -57,9 +61,14 @@ static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
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
> +	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
>  	struct device_node *np;
>  	int ret, i, phy_mode;
> @@ -125,10 +134,14 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  
>  	pci_set_master(pdev);
>  
> -	loongson_gmac_data(plat);
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
>  
> +	info = (struct stmmac_pci_info *)id->driver_data;
> +	ret = info->setup(plat);
> +	if (ret)
> +		goto err_disable_device;
> +
>  	res.irq = of_irq_get_byname(np, "macirq");
>  	if (res.irq < 0) {
>  		dev_err(&pdev->dev, "IRQ macirq not found\n");
> @@ -220,7 +233,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>  			 loongson_dwmac_resume);
>  
>  static const struct pci_device_id loongson_dwmac_id_table[] = {
> -	{ PCI_DEVICE_DATA(LOONGSON, GMAC, NULL) },
> +	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> -- 
> 2.31.4
> 

