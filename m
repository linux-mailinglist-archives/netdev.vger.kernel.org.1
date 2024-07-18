Return-Path: <netdev+bounces-112064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2F6934C99
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF04F1C20B2A
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761B512F375;
	Thu, 18 Jul 2024 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3dyGixH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E9078C92
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302335; cv=none; b=cmCG/m4XRf11/Fm5Fcs9larHgdfylbyPoO8usIHKv4z5RPv1yYZWVqa+kf2PUV+fNLH5uz9H7T8p2ig1Z0ia+H/IPcIREDryAqRymxE0TQrgcJBG7BlJS2LW62eBqU8UYYHxh3JJx8n/WMLyjPUlrQ13RjX/ys6D1vqmYNN+uSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302335; c=relaxed/simple;
	bh=v9hZ52bxIyh7XdjGL+LnQaaY+DcmFhMhupLqz0uFZcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcVCQlB/fJ0shr8Lwqxi+g1+CG6NZOB+H45JHYDjt8r6Fab/FWlrAS6RkaoQ1fS8ecgUYBttM7D5d5SPUblj2KQ9H06nfunrzQrPzuLqiNeRmjJA+TRshAbqXdwOZ+igJgVNiNF8WpNjlx4BVq+Rz7N7HSOeXQqvK2eSxf4sVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3dyGixH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc49c0aaffso6249225ad.3
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 04:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721302333; x=1721907133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Han/sbV7N/EXBhgWvXvA8b/T5eW2hcpF5OsCeTUigg0=;
        b=K3dyGixHWKizqIw/BlmGtAgWdcYO7wN5VluwBZPecEwcDubJy3Ue5tJIGL8vFBEbu7
         p+2oyCZa7baMQvvPEs3G+0C731L5a5/8Xs/HPYPAE6IXN4aXeEKWxlVFp3n+4giItBYa
         gIq1MpNuShVEFx23Fi9ozm5ty7/V+lVaqVib2RtLbILX6zMd27fVdw9Ha3xdP2u/aZVB
         g+u2CJrQyYChPigrFQb4Kd02ENG2+isBGY9u/glzQ0EvcHW0Wh2wnJ0fiNX4JTqyTYum
         HZIxXwJTWYJw4Q2fnCISusF3HOJX1en8VKQXb8G0sf+c19FwVbDX38wvnmw7e84/jVZG
         xLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721302333; x=1721907133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Han/sbV7N/EXBhgWvXvA8b/T5eW2hcpF5OsCeTUigg0=;
        b=oBIuUiWConEa1CVj083RYsOtDyqMXA0ZFHyfpx5awBNRf6OPGwjEaVeWHkJfqqnfcw
         dySHQMMq/Zle6E4H66HMjd0yiq2kittCvs8pU2SaLSt4sKQGYbWq2KMfClWl+myWbnCl
         yVjzNO+KSF4Q7rDvIvwcu7xDbxio+PFFjFhGr2jHMqR6hnYHqWghOZj+QDulx67B/Nsj
         kZEyWf8dRiOifFmeNTPdcKxSVqdlwOGRyeP0p3IngK6VLmF+49irHvuLDyWwAdts8z4Q
         +8luSbtPEslmYFTW53AmN8myqkEZQ6m4dK0LHTaic1Dumly+p6aO+BTG2R7IR6G8++8C
         W1Cw==
X-Forwarded-Encrypted: i=1; AJvYcCU+zE5C5si/Ue1uR4rabSAX+uFyO/JQnwaFXJf22FOhPs2TeIGL2Rre/5542Jk6ufy0mh3iKXVmDHjTWHBPmpZ0m5rIiQZo
X-Gm-Message-State: AOJu0Yx++E5b4GBT+dfKTr1m6DaqcHHXFfQYkMugw20FSobsrotryZ4m
	KsVGtcZU3mf8YagGGSRBOWi/ewtRc3rLcb2i9+BJYXlptHNibeBG
X-Google-Smtp-Source: AGHT+IEmaP3je0187NNUJdhYlCvifaA3gINmREfuVh3hYDXWEgOj1iykarmPcToTP8VuNWHel+vjIw==
X-Received: by 2002:a17:902:dacc:b0:1fb:9b47:b642 with SMTP id d9443c01a7336-1fc4e140360mr40026005ad.31.1721302333074;
        Thu, 18 Jul 2024 04:32:13 -0700 (PDT)
Received: from mobilestation ([176.15.242.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc2751bsm91211625ad.143.2024.07.18.04.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:32:12 -0700 (PDT)
Date: Thu, 18 Jul 2024 14:32:04 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v14 07/14] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
Message-ID: <jjjxl2mlnzfnrvljlwzuffrholdk4lduly3pxemugncwpu3d67@leqb263vpzyf>
References: <cover.1720512634.git.siyanteng@loongson.cn>
 <6f1724aaa4f5e247163405d3f7939ac44e1c859c.1720512634.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f1724aaa4f5e247163405d3f7939ac44e1c859c.1720512634.git.siyanteng@loongson.cn>

On Tue, Jul 09, 2024 at 05:36:26PM +0800, Yanteng Si wrote:
> Loongson delivers two types of the network devices: Loongson GMAC and
> Loongson GNET in the framework of four CPU/Chipsets revisions:
> 
>    Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
> LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
> LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
> LS2K2000 CPU         GMAC      0x7a03          v3.73a            8
> LS2K2000 CPU         GNET      0x7a13          v3.73a            8
> LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
> 
> The driver currently supports the chips with the Loongson GMAC network
> device synthesized with a single DMA-channel available. As a
> preparation before adding the Loongson GNET support detach the
> Loongson GMAC-specific platform data initializations to the
> loongson_gmac_data() method and preserve the common settings in the
> loongson_default_data().
> 
> While at it drop the return value statement from the
> loongson_default_data() method as redundant.

Please add a word about the plat->mac_interface field value changed to
NA. Something like this:

"Note there is no intermediate vendor-specific PCS in between the MAC
and PHY on Loongson GMAC and GNET. So the plat->mac_interface field
can be freely initialized with the PHY_INTERFACE_MODE_NA value."

Other than that the change looks good. Thanks.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index f39c13a74bb5..9b2e4bdf7cc7 100644
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
> @@ -42,6 +40,14 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
>  
>  	plat->dma_cfg->pbl = 32;
>  	plat->dma_cfg->pblx8 = true;
> +}
> +
> +static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
> +{
> +	loongson_default_data(plat);
> +
> +	plat->tx_queues_to_use = 1;
> +	plat->rx_queues_to_use = 1;
>  
>  	return 0;
>  }
> @@ -111,11 +117,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	}
>  
>  	plat->phy_interface = phy_mode;
> -	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
>  
>  	pci_set_master(pdev);
>  
> -	loongson_default_data(plat);
> +	loongson_gmac_data(plat);
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
>  
> -- 
> 2.31.4
> 

