Return-Path: <netdev+bounces-103673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31085909003
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88673B28F09
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1E43F8E2;
	Fri, 14 Jun 2024 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdNV7hGj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4C16C692
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382004; cv=none; b=tTc37HePVqVR1WYDE++MEeP7vwhn2lVwOtkqu6wBo15iBf9UlUL39eO5TeURB/zoQj+Pj87wTuH3zlTN5PGGiZwss2eFpAKGCAnQ3LXYJ9mns58GDJWihpwQyxTUJ1gQtyPyZKGc7gyHtFrFMNZtfJ4NC2LJFvlAu9eAT0iBlCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382004; c=relaxed/simple;
	bh=8KAsssM+sUz6tS3/9yMxiUptsBT20xuuydPY0c2DKGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NM8LieAOMG9NGZozjSdc7qCI9EV/vIyrBBRkEI0+eeTPH+7wvXr4TA+cwe2VaGsVyOdj+eQISuHF81o7K7vgtg/0ik1UjZhGXE665nox3+W4hUoHr4BejIk3XqV7YJTJbK8oSmopogM93zUnH0AZ7YcBpDDb5v5Koor1yK0LgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdNV7hGj; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so24999341fa.3
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718382001; x=1718986801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y24OMm6vhyfq3PE2xTuPQUwlkMy0sa07WLmDLr8x62U=;
        b=HdNV7hGjQ+1ngxKCcxJooL1baSiLim2br6PGSefhMLXtj0Hens29i5TiC5CS8ZgDv/
         Y8R7AzpMv7pqTXICLxsECr8CoG6GBJ8jXAXud4vUKaGjD4RaR7VLr9848anIPL5rMHZb
         yL1zS9MW5TsFoivaFKMzv4hdXLCSiBoQ9zN7OWUcoRnH6HOFF60Tpthoig+b0IQ7luIe
         /wvohLhqCGqv7g62j9p/3t1KJbuzyKjugbN1XgS5xzRnXCB+Vkac1218SujhP9sxKRTp
         JMnDo6Y0uF6Ee5LT6ai5/6TDVcK66Ze9QS7flGKHOKZjCO/ogrNuQwV6wqGSnYqWXpFU
         P2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382001; x=1718986801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y24OMm6vhyfq3PE2xTuPQUwlkMy0sa07WLmDLr8x62U=;
        b=IJ7UJ4uHOm8XlpVa3Qj9XoAJjtSAO4Z3Ykl7B+b7rTFLOUrXqzsyHWRzyLvAahis/P
         MpScq6fS7fYeasvas5957S22a7XO17zdsFW55sVigoQ1PpJg47m2u1aCmOyI7N2QOxWw
         N9Ohr/d8pIBYrlxOZW4X2MPDZW9dRwgRygVi30HoYYmX75eLzqD5ZiN5N2I12fd8q9FK
         G8t39gocVPurnl4yhYoRz0YH2sENvj0j23ATb4H5rOtsY9pHgEGHxXbGsR7KclgCuSiV
         IZpMBak0FlxN/Iv0NOzTxGHasYOHWHrjJgkhdjU9Q6LRaCEY5AtXDkAqGyPa7SK9t+fg
         bmug==
X-Forwarded-Encrypted: i=1; AJvYcCUe0WNVVPuf2tVGZt16CEcx9xEqUHcdlVFDIQpy7WDoTewZp4l3GHQZF1rGhpxqkcdNpdjnDgJpRAQ2AQyhwctjfsroKFUG
X-Gm-Message-State: AOJu0YxAt/2YUvAwI5SZm7uLp4m4sXq11FkXy/Xv0iNeYQCP/PPM2pWw
	OID78mgJJT3mIkH1u6tvuOvuXxdE8qvkXNkja5PcR1kM9v5lNM6e
X-Google-Smtp-Source: AGHT+IF+d0I2M0ViD58e8MjddsoWD55LA8e9uYZKkbcqA8vCaAhQHJhJMJq8yk1l5kE0qe5rkI6qmg==
X-Received: by 2002:a2e:988c:0:b0:2eb:fe60:152c with SMTP id 38308e7fff4ca-2ec0e6004e5mr20876671fa.39.1718382000403;
        Fri, 14 Jun 2024 09:20:00 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c9ac5bsm5682331fa.134.2024.06.14.09.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 09:19:59 -0700 (PDT)
Date: Fri, 14 Jun 2024 19:19:57 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
Message-ID: <wosihpytgfb6icdw7326xtez45cm6mbfykt4b7nlmg76xpwu4m@6xwvqj7ls7is>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b987281834a734777ad02acf96e968f05024c031.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b987281834a734777ad02acf96e968f05024c031.1716973237.git.siyanteng@loongson.cn>

On Wed, May 29, 2024 at 06:19:03PM +0800, Yanteng Si wrote:
> Loongson delivers two types of the network devices: Loongson GMAC and
> Loongson GNET in the framework of four CPU/Chipsets revisions:
> 
>    Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
> LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
> LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
> LS2K2000 CPU         GNET      0x7a13          v3.73a            8
> LS7A2000 Chipset     GNET      0x7a13          v3.73a            1

You mentioned in the cover-letter
https://lore.kernel.org/netdev/cover.1716973237.git.siyanteng@loongson.cn/
that LS2K now have GMAC NICs too:
" 1. The current LS2K2000 also have a GMAC(and two GNET) that supports 8
    channels, so we have to reconsider the initialization of
    tx/rx_queues_to_use into probe();"

But I don't see much changes in the series which would indicate that
new data. Please clarify what does it mean:

Does it mean LS2K2000 has two types of the DW GMACs, right?

Are both of them based on the DW GMAC v3.73a IP-core with AV-feature
enabled and 8 DMA-channels? 

Seeing you called the new device as GMAC it doesn't have an
integrated PHY as GNETs do, does it? If so, then neither
STMMAC_FLAG_DISABLE_FORCE_1000 nor loongson_gnet_fix_speed() relevant
for the new device, right?

Why haven't you changed the sheet in the commit log? Shall the sheet
be updated like this:

    Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
 LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
 LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
+LS2K2000 CPU         GMAC      0x7a13          v3.73a            8
 LS2K2000 CPU         GNET      0x7a13          v3.73a            8
 LS7A2000 Chipset     GNET      0x7a13          v3.73a            1

?

I'll continue reviewing the series after the questions above are
clarified.

-Serge(y)

> 
> The driver currently supports the chips with the Loongson GMAC network
> device. As a preparation before adding the Loongson GNET support
> detach the Loongson GMAC-specific platform data initializations to the
> loongson_gmac_data() method and preserve the common settings in the
> loongson_default_data().
> 
> While at it drop the return value statement from the
> loongson_default_data() method as redundant.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 739b73f4fc35..ad3f44440963 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -11,7 +11,7 @@
>  
>  #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>  
> -static int loongson_default_data(struct plat_stmmacenet_data *plat)
> +static void loongson_default_data(struct plat_stmmacenet_data *plat)
>  {
>  	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>  	plat->has_gmac = 1;
> @@ -20,16 +20,14 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
>  	/* Set default value for multicast hash bins */
>  	plat->multicast_filter_bins = 256;
>  
> +	plat->mac_interface = PHY_INTERFACE_MODE_NA;
> +
>  	/* Set default value for unicast filter entries */
>  	plat->unicast_filter_entries = 1;
>  
>  	/* Set the maxmtu to a default of JUMBO_LEN */
>  	plat->maxmtu = JUMBO_LEN;
>  
> -	/* Set default number of RX and TX queues to use */
> -	plat->tx_queues_to_use = 1;
> -	plat->rx_queues_to_use = 1;
> -
>  	/* Disable Priority config by default */
>  	plat->tx_queues_cfg[0].use_prio = false;
>  	plat->rx_queues_cfg[0].use_prio = false;
> @@ -42,6 +40,11 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
>  
>  	plat->dma_cfg->pbl = 32;
>  	plat->dma_cfg->pblx8 = true;
> +}
> +
> +static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
> +{
> +	loongson_default_data(plat);
>  
>  	return 0;
>  }
> @@ -111,11 +114,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	}
>  
>  	plat->phy_interface = phy_mode;
> -	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
>  
>  	pci_set_master(pdev);
>  
> -	loongson_default_data(plat);
> +	loongson_gmac_data(plat);
>  	pci_enable_msi(pdev);
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
> @@ -140,6 +142,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		goto err_disable_msi;
>  	}
>  
> +	plat->tx_queues_to_use = 1;
> +	plat->rx_queues_to_use = 1;
> +
>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
>  		goto err_disable_msi;
> -- 
> 2.31.4
> 

