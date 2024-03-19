Return-Path: <netdev+bounces-80611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4DF87FF02
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 14:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8103A283273
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 13:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DED380BE1;
	Tue, 19 Mar 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEQvHPvM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E48004F
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855815; cv=none; b=XCVcCDtOKu4nO+McQGPQY/j5u9M4vZYxdrxop0qFKTuho5tUMxcMl0uuGTHokH/i+QCaYNLIqh/lHvqsiaV0FjzXSRuAXVJPhO5ZV1/yMWi6JIywlwVnjm/Si3SmfQIHXxX+rdES4wuC9bgNpluNxiPlUdBvXnQmVBJU6BC8Evw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855815; c=relaxed/simple;
	bh=2PfxOJPzBJoBVYuYJxIGCBuZ9DLtA3uUJQ7S0DnG/kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABhBXMG//0NAGtcGlIIn9M2Jup4wKDfJbMBhkAqtuqYHEWTpgf5cKAtMACV8TKefZO+YOF0QH9gTMXDr6oyyoCheO3HG5ybX8ZC83fVQdjyIaH84THGbeto3CoQRwvnxBliIMrkoqTG+LuRJWzyBWyHgd/biFgUCqRb58l0ewCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEQvHPvM; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513d3e57518so6001259e87.3
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710855811; x=1711460611; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mv68+UnH8CH2r80ZN2HzyhfceCayNcJkw+9sGUzZqdY=;
        b=aEQvHPvMLCsvO8rKwlzQv2ydd67c+9tmCrYVFFUuieBZTNT3yuDSAoA57ttBdm8dqZ
         +iVpVNTw2RVGJpI/AKrwqv8+HRSuZNPla9kQd67ce4y8U3OodF8CTokUsm/8kQn0isiy
         BDfMVgHcdC8TfWItWubgKh6uRTTh2mNEvVMKonSvPZi1YMoePgWXkPcq76FENYHbiWBF
         Y/sbMmlVvF/YaOYuKLNpRVlGPqdPXrea7/DEqKbMLy+wj0g98BchmnWu486kdPqp8/pq
         5T+FOrSYclYo+nqmL8tAuUuHgOlmBee2kkFSeXrKYPQ0m6yNsgxnfp+p7WXCnXeJjdB3
         +k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710855811; x=1711460611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mv68+UnH8CH2r80ZN2HzyhfceCayNcJkw+9sGUzZqdY=;
        b=EpC4xSL2nmpCGNVbzLt8c9uc4NfhYCipJ7KlRB8OqmQ1CRrL1W4qNZjzFwMphPDkkm
         Zpw+oA/R2eHD9b9eKSzDmTn5XGart6jGAV3VISvdHZahdFIr0Cta513Dxf1ftjZhSKx1
         EeU+S627uwZIESg4gbVr2ZzDPu73IOoX0c3PVx523+43Up/TEy0vY+f7vbECqq+nInDE
         o08fOmDC2DVDTJaBrQOKUOFWKUHFEoRhcEDpdeOSMtEn/H8L9TZ8yeEIO0DGIqrPdkav
         7342bRANmD6ew6Gqf8NO9YmJe9xyZoMOzrFxOS2qsMkKyTLascEiih8w/ccQdxi9TuWR
         OBzg==
X-Forwarded-Encrypted: i=1; AJvYcCX4oKlMRG4J20XaHtAU38nCYqcMhqJyqMb6HkL8+qYL2MkA7Vrfyo39r1JcMwkYGHLJjzk6NFOGnMdLj5u8f0j720wzRXpL
X-Gm-Message-State: AOJu0YyN4DvZnZtomxXpRRLFy+J2KQLk/rjNiT0viTFEwuFybij+9DqM
	NuSwV5V2J8h1d0BaWYYR3foUWBBJf368eU3lOJ9jRYS0hUpf7ApZ
X-Google-Smtp-Source: AGHT+IEGPjTaeH1Pj8jbaC7Kx+2btnxOT5Xbi9AfG25pe+jqYC+T+qk60t/zgxCdgYb2eh+ATyCpNw==
X-Received: by 2002:a05:6512:3294:b0:513:5951:61a4 with SMTP id p20-20020a056512329400b00513595161a4mr10541445lfe.6.1710855811083;
        Tue, 19 Mar 2024 06:43:31 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b5-20020a196445000000b00513d13ede82sm1946950lfj.147.2024.03.19.06.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 06:43:30 -0700 (PDT)
Date: Tue, 19 Mar 2024 16:43:27 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 04/11] net: stmmac: dwmac-loongson: Move irq
 config to loongson_gmac_config
Message-ID: <6x5fg66cr2vwwcgr6yi45ipov5ejkst5fggcxd4y2mxkq7m6po@nkghfpdeduyj>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <776bfe84003b203ebe320dc7bf6b98707a667fa9.1706601050.git.siyanteng@loongson.cn>
 <xjfd4effff6572fohxsgannqjr2w44qm4tru4aan2agojs77dl@tneltus7zqo6>
 <6e7e2765-5074-4252-820f-e9b34960e8b3@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e7e2765-5074-4252-820f-e9b34960e8b3@loongson.cn>

On Wed, Mar 13, 2024 at 04:14:28PM +0800, Yanteng Si wrote:
> 
> 在 2024/2/6 01:01, Serge Semin 写道:
> > On Tue, Jan 30, 2024 at 04:43:24PM +0800, Yanteng Si wrote:
> > > Add loongson_dwmac_config and moving irq config related
> > > code to loongson_dwmac_config.
> > > 
> > > Removing MSI to prepare for adding loongson multi-channel
> > > support later.
> > Please detach this change into a separate patch and thoroughly explain
> > why it was necessary.
> OK.
> > 
> > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > ---
> > >   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 85 ++++++++++++-------
> > >   1 file changed, 55 insertions(+), 30 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > index 979c9b6dab3f..e7ce027cc14e 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > @@ -11,8 +11,46 @@
> > >   struct stmmac_pci_info {
> > >   	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
> > > +	int (*config)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat,
> > > +		      struct stmmac_resources *res, struct device_node *np);
> > >   };
> > > +static int loongson_dwmac_config_legacy(struct pci_dev *pdev,
> > > +					struct plat_stmmacenet_data *plat,
> > > +					struct stmmac_resources *res,
> > > +					struct device_node *np)
> > > +{
> > > +	if (np) {
> > > +		res->irq = of_irq_get_byname(np, "macirq");
> > > +		if (res->irq < 0) {
> > > +			dev_err(&pdev->dev, "IRQ macirq not found\n");
> > > +			return -ENODEV;
> > > +		}
> > > +
> > > +		res->wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> > > +		if (res->wol_irq < 0) {
> > > +			dev_info(&pdev->dev,
> > > +				 "IRQ eth_wake_irq not found, using macirq\n");
> > > +			res->wol_irq = res->irq;
> > > +		}
> > > +
> > > +		res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
> > > +		if (res->lpi_irq < 0) {
> > > +			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> > > +			return -ENODEV;
> > > +		}
> > > +	} else {
> > > +		res->irq = pdev->irq;
> > > +		res->wol_irq = res->irq;
> > > +	}
> > > +
> > > +	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
> > > +	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
> > > +		 __func__);
> > Why is this here all of the sudden? I don't see this in the original
> > code. Please move it to the patch which requires the flag
> > setup/cleanup or drop if it isn't necessary.
> 

> +	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
> This cannot be removed because it appeared in a rebase(v4 -> v5). See
> <https://lore.kernel.org/all/20230710090001.303225-9-brgl@bgdev.pl/>

AFAICS it _can_ be removed. The patch you referred to is a formal
conversion of
-	plat->multi_msi_en = 0;
to
+	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
First of all the "multi_msi_en" field clearance had been
redundant there since the code setting the flag was executed after the
code which may cause the field clearance performed. Second AFAICS the
"multi_msi_en" field clearance was originally added to emphasize the
functions semantics:
intel_eth_config_multi_msi() - config multi IRQ device,
intel_eth_config_single_msi() - config single IRQ device.

So in your case there is no any reason of clearing the
STMMAC_FLAG_MULTI_MSI_EN flag. Please, either drop it or move the
change into a separate patch.

-Serge(y)

> +	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
> +		 __func__);
> 
> OK, drop it.
> 
> > 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   static void loongson_default_data(struct pci_dev *pdev,
> > >   				  struct plat_stmmacenet_data *plat)
> > >   {
> > > @@ -66,8 +104,21 @@ static int loongson_gmac_data(struct pci_dev *pdev,
> > >   	return 0;
> > >   }
> > > +static int loongson_gmac_config(struct pci_dev *pdev,
> > > +				struct plat_stmmacenet_data *plat,
> > > +				struct stmmac_resources *res,
> > > +				struct device_node *np)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > You introduce the config callback here and convert to a dummy method
> > in
> > [PATCH 07/11] net: stmmac: dwmac-loongson: Add multi-channel supports for loongson
> > It's just pointless. What about introducing the
> > loongson_dwmac_config_legacy() method and call it directly?
> OK, I will try.
> > 
> > >   static struct stmmac_pci_info loongson_gmac_pci_info = {
> > >   	.setup = loongson_gmac_data,
> > > +	.config = loongson_gmac_config,
> > >   };
> > >   static int loongson_dwmac_probe(struct pci_dev *pdev,
> > > @@ -139,44 +190,19 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
> > >   		plat->phy_interface = phy_mode;
> > >   	}
> > > -	pci_enable_msi(pdev);
> > See my first note in this message.
> 
> OK.
> 
> 
> Thanks,
> 
> Yanteng
> 
> > 
> > -Serge(y)
> > 
> > >   	memset(&res, 0, sizeof(res));
> > >   	res.addr = pcim_iomap_table(pdev)[0];
> > > -	if (np) {
> > > -		res.irq = of_irq_get_byname(np, "macirq");
> > > -		if (res.irq < 0) {
> > > -			dev_err(&pdev->dev, "IRQ macirq not found\n");
> > > -			ret = -ENODEV;
> > > -			goto err_disable_msi;
> > > -		}
> > > -
> > > -		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> > > -		if (res.wol_irq < 0) {
> > > -			dev_info(&pdev->dev,
> > > -				 "IRQ eth_wake_irq not found, using macirq\n");
> > > -			res.wol_irq = res.irq;
> > > -		}
> > > -
> > > -		res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
> > > -		if (res.lpi_irq < 0) {
> > > -			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> > > -			ret = -ENODEV;
> > > -			goto err_disable_msi;
> > > -		}
> > > -	} else {
> > > -		res.irq = pdev->irq;
> > > -		res.wol_irq = pdev->irq;
> > > -	}
> > > +	ret = info->config(pdev, plat, &res, np);
> > > +	if (ret)
> > > +		goto err_disable_device;
> > >   	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
> > >   	if (ret)
> > > -		goto err_disable_msi;
> > > +		goto err_disable_device;
> > >   	return ret;
> > > -err_disable_msi:
> > > -	pci_disable_msi(pdev);
> > >   err_disable_device:
> > >   	pci_disable_device(pdev);
> > >   err_put_node:
> > > @@ -200,7 +226,6 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
> > >   		break;
> > >   	}
> > > -	pci_disable_msi(pdev);
> > >   	pci_disable_device(pdev);
> > >   }
> > > -- 
> > > 2.31.4
> > > 
> 

