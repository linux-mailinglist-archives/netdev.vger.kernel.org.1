Return-Path: <netdev+bounces-69284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7EB84A923
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0BA1C27D48
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D2548CF2;
	Mon,  5 Feb 2024 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFyQhakc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C371AB81E
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707171532; cv=none; b=XfPIzcRBGvOzDrIbWCo8Eg7VIVQy7xMrCNl4C4SaWLqWruBL46R8xpoQZiTDrffHtT8Bs0R4F0JZZBelBVGd8hzsoQE5A8HicUfY0QQcOBkYSHT9LoG0HXy1OU0IGK15gTdOyiJWOb5A0sN6kwsXC/swQs1SD3X5TK7AS/3nQLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707171532; c=relaxed/simple;
	bh=BAH125mBsYFEBGDQftLFxdMVbZuGsZ6WYMkSz0EYXdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K39NQp0uVvZA44dwcAzkZ8PVXPxNkJ/WhVPajIsBi7nqrQAeq07cZqZRsU52QAAWOeVVXSI8MUnTv7iJymMOAWoSaiavKmrFf4aUCUJQUb4JX8b3YpZBRIuQSzl/M7cBlxRZ20jKqDJtOmoJa4svowr5Ph0bOFYo9QVoDqchs7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFyQhakc; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d09bdddfc9so28343481fa.2
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 14:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707171528; x=1707776328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7cvkZKDXtlhOQr74SkHRJuQ/Sp8e5itgT2ptQh4RUg=;
        b=RFyQhakcJwKa4XCqQ3YQudE4SAPosvZIWUm3PcIMJ0SXr6hEifQrb24hxbWbHDgNI8
         AjqrL/oqjOlQvZ62lOUTyTZUyLr+iD5GsCtweAJ8yvzFh+KKpmDxNGMGC/16sSJJkiIa
         zsC3bx/ct+w5gk4MtUJSOqrODfFsGph/fVfefwKQrofxbUtkGycN+W6nwd6o/z8Z8TKd
         OU/iPHlJFdGJwXgVww3i+GEnuzSF2C+doHi7xkCODRHU0C6VEPElnpwHUyOSqcxaH8v4
         fMvXUT8nvKU5XGSvl88lq7EsagB/oEwW1iK8UPe8Qahl/tA1u/ldz4I0PCGqz+sBbXuD
         CLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707171528; x=1707776328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7cvkZKDXtlhOQr74SkHRJuQ/Sp8e5itgT2ptQh4RUg=;
        b=ACF8+GyI1nKNkMypJcIRGr6lrEElJwHWGZMBEb8YMUVK287MfChlj+3UGZe8/DpTTv
         1p5G47Qjborr/P5BASo4sIpnT6Qmlm17Dvk88pgzpOAC2QzfCRoioXLXFmzomiDXcXyI
         +pd478TQjpNB94ALbDcyALn4Q4PayR7V0TPIQ/ZZW7btkAl42QNwhkBwko78S7a1UoTE
         1cz+O0AcbAbAIAup/Q8DdIhgNVJcnd0tlY3sj1p2EK05ERBKBy0WDCjdqZ1OvwgTKvZ4
         ZnjLawMmS+e6BY1MgPZzrpTNR7Y3CTEIRs611vtgXr6lvs0RLhvcoWQ6J/TCMwef4HMs
         sjig==
X-Gm-Message-State: AOJu0YwhA3X2UR7dRLYHofq9A0J5Go+AZbEKEryVVw6hdX8asQODVrYa
	S/wu006zLxKfRm1xzw64SVrOiXw6Rw0UZIIcseIEa+t7axLCq/pV
X-Google-Smtp-Source: AGHT+IGl7Kixy/rU+hVNAF4rrQuts8hO8N/RMMcF55ax/3AEDcLxNB6B+Kh1gdN8w5Lsn9qLJIX+Ow==
X-Received: by 2002:a05:651c:2003:b0:2d0:b336:e0f1 with SMTP id s3-20020a05651c200300b002d0b336e0f1mr258073ljo.14.1707171528055;
        Mon, 05 Feb 2024 14:18:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWu+bAoPCct25FhtgZJM5J+NPN2qf98N09wd+fJQAgwObtEV/+GbUg5P1pojBr4dd/m+PIOHcmb/a+tLCjhDs8Op5sB/AeKN/9rVpDMxUNDbnOqhiQ0/nFw/xeo0RpEajQYyI5cYFCKETwXWJLnw9DRggV+8bh81oGm5JREvaFyS7Nyu6qoyVmYNfD2VgG0fn+JuFOXnqCAAFnq/kUNtOmmvsr/pM5nmyIfRDGft0IB7t7i4vUje4hY/tBwSLpWg/e6nKS2nVqf88ZvH3jSKkNIKxOJ/vyROlLnkh82O9cvBkuxnnkAnnhughkt6mfB7Zpm59XUJ9KCDuo/4YqMhwXbOachBqiZ8AEG+Xefz7jPJhJBXFZGQha3YwC6gyP+tWUigU9xjA==
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id r37-20020a05651c082500b002d094866a4fsm76714ljb.93.2024.02.05.14.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:18:47 -0800 (PST)
Date: Tue, 6 Feb 2024 01:18:45 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 11/11] net: stmmac: dwmac-loongson: Disable
 coe for some Loongson GNET
Message-ID: <52aodgfoh35zxpube73w53jv7rno5k7vfwdy276zjqpcbewk5t@4f2igj76y5ri>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <151e688e8977376c3c97548540f8e15d272685cb.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151e688e8977376c3c97548540f8e15d272685cb.1706601050.git.siyanteng@loongson.cn>

On Tue, Jan 30, 2024 at 04:49:16PM +0800, Yanteng Si wrote:
> Some chips of Loongson GNET does not support coe, so disable them.

s/coe/Tx COE

> 
> Set dma_cap->tx_coe to 0 and overwrite get_hw_feature.
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index b78a73ea748b..8018d7d5f31b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -196,6 +196,51 @@ static int dwlgmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>  	return ret;
>  }
>  

> +static int dwlgmac_get_hw_feature(void __iomem *ioaddr,

Please use GNET-specific prefix.

> +				  struct dma_features *dma_cap)
> +{
> +	u32 hw_cap = readl(ioaddr + DMA_HW_FEATURE);
> +

> +	if (!hw_cap) {
> +		/* 0x00000000 is the value read on old hardware that does not
> +		 * implement this register
> +		 */
> +		return -EOPNOTSUPP;
> +	}

This doesn't seems like possible. All your devices have the
HW-features register. If so please drop.

> +
> +	dma_cap->mbps_10_100 = (hw_cap & DMA_HW_FEAT_MIISEL);
> +	dma_cap->mbps_1000 = (hw_cap & DMA_HW_FEAT_GMIISEL) >> 1;
> +	dma_cap->half_duplex = (hw_cap & DMA_HW_FEAT_HDSEL) >> 2;
> +	dma_cap->hash_filter = (hw_cap & DMA_HW_FEAT_HASHSEL) >> 4;
> +	dma_cap->multi_addr = (hw_cap & DMA_HW_FEAT_ADDMAC) >> 5;
> +	dma_cap->pcs = (hw_cap & DMA_HW_FEAT_PCSSEL) >> 6;
> +	dma_cap->sma_mdio = (hw_cap & DMA_HW_FEAT_SMASEL) >> 8;
> +	dma_cap->pmt_remote_wake_up = (hw_cap & DMA_HW_FEAT_RWKSEL) >> 9;
> +	dma_cap->pmt_magic_frame = (hw_cap & DMA_HW_FEAT_MGKSEL) >> 10;
> +	/* MMC */
> +	dma_cap->rmon = (hw_cap & DMA_HW_FEAT_MMCSEL) >> 11;
> +	/* IEEE 1588-2002 */
> +	dma_cap->time_stamp =
> +	    (hw_cap & DMA_HW_FEAT_TSVER1SEL) >> 12;
> +	/* IEEE 1588-2008 */
> +	dma_cap->atime_stamp = (hw_cap & DMA_HW_FEAT_TSVER2SEL) >> 13;
> +	/* 802.3az - Energy-Efficient Ethernet (EEE) */
> +	dma_cap->eee = (hw_cap & DMA_HW_FEAT_EEESEL) >> 14;
> +	dma_cap->av = (hw_cap & DMA_HW_FEAT_AVSEL) >> 15;
> +	/* TX and RX csum */
> +	dma_cap->tx_coe = 0;
> +	dma_cap->rx_coe_type1 = (hw_cap & DMA_HW_FEAT_RXTYP1COE) >> 17;
> +	dma_cap->rx_coe_type2 = (hw_cap & DMA_HW_FEAT_RXTYP2COE) >> 18;
> +	dma_cap->rxfifo_over_2048 = (hw_cap & DMA_HW_FEAT_RXFIFOSIZE) >> 19;
> +	/* TX and RX number of channels */
> +	dma_cap->number_rx_channel = (hw_cap & DMA_HW_FEAT_RXCHCNT) >> 20;
> +	dma_cap->number_tx_channel = (hw_cap & DMA_HW_FEAT_TXCHCNT) >> 22;
> +	/* Alternate (enhanced) DESC mode */
> +	dma_cap->enh_desc = (hw_cap & DMA_HW_FEAT_ENHDESSEL) >> 24;

I am not sure whether you need to parse the capability register at all
seeing this is a GNET-specific method. For that device all the
capabilities are already known and can be just initialized in this
method.

-Serge(y)

> +
> +	return 0;
> +}
> +
>  struct stmmac_pci_info {
>  	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
>  	int (*config)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat,
> @@ -542,6 +587,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>  		ld->dwlgmac_dma_ops = dwmac1000_dma_ops;
>  		ld->dwlgmac_dma_ops.init_chan = dwlgmac_dma_init_channel;
>  		ld->dwlgmac_dma_ops.dma_interrupt = dwlgmac_dma_interrupt;
> +		ld->dwlgmac_dma_ops.get_hw_feature = dwlgmac_get_hw_feature;
>  
>  		plat->setup = loongson_setup;
>  		ret = loongson_dwmac_config_multi_msi(pdev, plat, &res, np, 8);
> -- 
> 2.31.4
> 

