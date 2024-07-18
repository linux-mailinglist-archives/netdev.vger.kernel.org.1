Return-Path: <netdev+bounces-112060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910E4934C38
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999AB1C20D6B
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491FD7F498;
	Thu, 18 Jul 2024 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/s+AD81"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE6639
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300990; cv=none; b=tnJsjY6YXvDne3jKRdfNMbARrEfIq0RthmW0iTiWdsn9mWWoNXpQ0qdCBPamAxc/mpL2RKCSph2g9BmZAA8q2Mz6o48CC8XJFxtXrnvf9aLLzEgT9PP1SBU3Ffm5pLC2Dena5Dapdr/M0oRv8NszDTFPEaP3ZO7tfefJEoLGnkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300990; c=relaxed/simple;
	bh=2gcM5AfGN2a1RUB74XI90i+f6mDj+CErmOfm9LJc80o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOCZvwseUGL+VyfWDcUK9Rs47jyGqm5mJF00n6NXs+ZvlgKkyLFBnhM8CQdC5t65sbGnjBmqOv9Vw02Vi87LfMAaK5VAWweWgZLCOuAuB3ILmk+RKC3QtettU9hGJlrCbSo2XftKzuIzlsgiJUpoGPaHHu+0Pe7e+NU/pnwmFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/s+AD81; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb4c584029so105728a91.3
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721300988; x=1721905788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2Vj0hEYRURUzAM7DtW92tHfyI5rXmKzOzCnNxS1q/A=;
        b=V/s+AD814LLIGfnB4SCxwcVBxsqcIses/IgaUPUiE9O7r8MHCFUh2IL8TxeW5fMdnC
         5FGEKQ7wAzwdbonesFebAy8aidBLrrT4W5dDGlCklM25L8TqhEjPNQCXJ+UZPNr3smSy
         kll/z8sfrr4gxFe5BkKkHNuk3Iz62Zo4l7MzfLyJPG6sPyPnTfrzmOM49u3y9HAs9WII
         Dxk9s265N8XTGP4mrdimWHJiz0jsCuD12ocrXY38cGVXVFKZfBJ0LElgRIjumi3a0yqJ
         jLYMQmG1/xtqwzo/lipneTnG2pQ0NEisXrhpxZi80fv9vipnh1VTfbpb+hfnVvFepqFQ
         kRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721300988; x=1721905788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2Vj0hEYRURUzAM7DtW92tHfyI5rXmKzOzCnNxS1q/A=;
        b=nmWLzLBkEMmCCO9QmPk5XS0Pzrw59mGR5pUIFGM8+tP6Ppxp8E2KUIaIRBb9e8tjO8
         P5Ptx7RQ3rs9zGzosTR/q9w6k0TXlTn70TqGZPcbHURc1XIhX8eOw+0h40U9u+6uzz5C
         MqRGtTVfPq240nNrZnepSiS6Odd65NR9L6qZJ7kqJrTpqlXoQJN86IdLDvAVBjVt6qIs
         civuNw+DJ9TLu69NVgtv5xlFnM+uKsdoA2vhC0AfeD1jK6OD5AOne3eh050oGXzHvx8R
         xcDveLxBIbl+ABrw40tRwyy4A9/Yf96y018k61XpVcPidHbz12TGMNe/LMWNC+MyzSCR
         Ry6A==
X-Forwarded-Encrypted: i=1; AJvYcCUaGGkAvyuPU2THCefh7o/xuYmEhN+FYSk30jDYgzyhUSJtfyS2tQiy2jTtRMh2KymFgPeW0qCCjNtPvleWO5omqvZ0URez
X-Gm-Message-State: AOJu0YwxQSTf6TLnv5sdXo3+S2wT4QhX5UtZw7IsAfRaOv/kl0DzTWQG
	bXYpyB4ujj8UViMiXyulrhSCyyVBvIhHBWDp4lDyJgn/ZfMDG5IT
X-Google-Smtp-Source: AGHT+IHZaqKMevS0sM74Ai9K9fUHcnhVhNrgGIypsRRJyH+rtQ5xEJksSVnOp6DwEOl3SoK6j3q6yw==
X-Received: by 2002:a17:90a:f315:b0:2c9:77d8:bb60 with SMTP id 98e67ed59e1d1-2cb5292110dmr3416438a91.35.1721300988060;
        Thu, 18 Jul 2024 04:09:48 -0700 (PDT)
Received: from mobilestation ([176.15.242.109])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77307630sm417622a91.21.2024.07.18.04.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:09:47 -0700 (PDT)
Date: Thu, 18 Jul 2024 14:09:37 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v14 05/14] net: stmmac: dwmac-loongson: Drop
 pci_enable/disable_msi calls
Message-ID: <lmkzza7ojixmdveu6u3qc46nxkexhbrpb6nvcdizvt4743uokh@ggpgdntfn2rl>
References: <cover.1720512634.git.siyanteng@loongson.cn>
 <951f9f94e0c0009417d9fd6822b9414196dcb2ae.1720512634.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <951f9f94e0c0009417d9fd6822b9414196dcb2ae.1720512634.git.siyanteng@loongson.cn>

On Tue, Jul 09, 2024 at 05:36:24PM +0800, Yanteng Si wrote:
> The Loongson GMAC driver currently doesn't utilize the MSI IRQs, but
> retrieves the IRQs specified in the device DT-node. Let's drop the
> direct pci_enable_msi()/pci_disable_msi() calls then as redundant
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 9dbd11766364..32814afdf321 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -114,7 +114,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	pci_set_master(pdev);
>  
>  	loongson_default_data(plat);
> -	pci_enable_msi(pdev);
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
>  
> @@ -122,7 +121,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	if (res.irq < 0) {
>  		dev_err(&pdev->dev, "IRQ macirq not found\n");
>  		ret = -ENODEV;
> -		goto err_disable_msi;
> +		goto err_disable_device;
>  	}
>  
>  	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
> @@ -135,17 +134,15 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	if (res.lpi_irq < 0) {
>  		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
>  		ret = -ENODEV;
> -		goto err_disable_msi;
> +		goto err_disable_device;
>  	}
>  
>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
> -		goto err_disable_msi;
> +		goto err_disable_device;
>  
>  	return ret;
>  
> -err_disable_msi:
> -	pci_disable_msi(pdev);
>  err_disable_device:
>  	pci_disable_device(pdev);
>  err_put_node:
> @@ -169,7 +166,6 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>  		break;
>  	}
>  
> -	pci_disable_msi(pdev);
>  	pci_disable_device(pdev);
>  }
>  
> -- 
> 2.31.4
> 

