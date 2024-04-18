Return-Path: <netdev+bounces-89175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B59C8A99BC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADC7281039
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3864F15D5D6;
	Thu, 18 Apr 2024 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zmc0ndJ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934971B20
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443219; cv=none; b=eDnFnYIubBK55lMF7KsncGWpZ7i73pxp0zy1Rz++Yg6HqiO0V9ULWHaxf7AzBarmtPsf9qNTbIpIdPwBcSUD9FN58g3Luh/o03vCAnjsqVtbsYgCncUPw50qjCxXzDVTl2544pJpjfAcr7D6jVSmJfLXkqwoDcdGAJD6U/Lb3Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443219; c=relaxed/simple;
	bh=RtKaj9xG2ma4x1CgaEzeDBSzuUk+V72sGOs27rvG0x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbkHnOu/XTWOhTAmfQTdid3KuWKtn2tJn2davnWBUhfOXVrIU8AH3jRvI6HpSTWH0fhjudNiH86SJ/MgQnh16sjAlSW/4A5cu2wfRe7fME/CpH0KkYGfYn4jToPl0qZXBxFbmb9eVsPv6FDzgVuiLtDKpxzgPa4zCpUCaQjwTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zmc0ndJ4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2da0b3f7ad2so11712731fa.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 05:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713443215; x=1714048015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=efm5I5k1qIDxQjQ5kbCS/EzVBhYJeEnSM8KlPS7rQvk=;
        b=Zmc0ndJ4YAbDiSg8gminzm8nvOLu99J7QlnlnFGHN+cFZWVDODYKztJk/glC/hALSV
         0y2NdDVlYTtuU5vM7V2SMfTvGDq/kBbiiabsOm0mbT9pDsccUBc98vindiilyg6B18ut
         Faio9TkUG9l1PD5CFVCzmRwK7a/LHmLsbY06GlzXPGnM50Cz1BC75n54FZX9YrG6IaKa
         1BS7tuEhgQ9WlpHfUEEVCGUZ9us618f+0aBC9sujbjmxaBid8ZqHo2oImZsbZo9BxXFS
         hF95T6qfWU586Sd8YeCNmjmxAu8wz7Snw2ktWZM6kLEA+r60sUMtM/u38oeAymY3Pc2r
         A/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713443215; x=1714048015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efm5I5k1qIDxQjQ5kbCS/EzVBhYJeEnSM8KlPS7rQvk=;
        b=cck9u9lssjrNEJZ4Ux8d6lYGnPEY3P3peNF73mtbhgVeWz8srne1t9DVJOVfHr6W5X
         T9mOb/X4vEWvMsLmRzHaRNeHR0ScF8SY7eFtaO90tIPl/WJcwB6lIo55n2m8jH7p2CIZ
         UWFIwF5VLUeoLVb4MdSSSMO4kTdKkdXVlAixv4fBzz7zJUm5MqYFmC24zHw9rWWhMBiy
         At3EFwJhf5PuiWiTtz+S8WPrZhxzbY4V6yM1O07h1yuaNPBFYxUeByB96t6IfxB/sA3c
         YCeo01BIyoQt9HcRPdm1FYM4NTMe7zYvv6BUPdvhYEe88dEtVjMaVfFku5ZJ47lRPPJW
         mYgA==
X-Forwarded-Encrypted: i=1; AJvYcCVznqxSydJJ+BcSk5LknBK6hgvTeELBFeweUklWkTEYSglsTMQDr4E/RTcTyVuVr4lb9DYz8zNdUtQYa/dN64KF7XTGhQzV
X-Gm-Message-State: AOJu0Yw/Nh48fsqRqXzt76XrG+AgC03BC6fLJvau5RfqEiSoF6u72QNx
	c1HpLK1X4GDk371wgioL6RvJ/nxVMlFPhaVT2hb5CBAsgVMz/Nlb
X-Google-Smtp-Source: AGHT+IEZjNnIGc9Ykr9Fv/DsIv7MYqTD504J4kGvBBvwotkY/Wo09PrKu0ivTML9t9ntr6yslxVekw==
X-Received: by 2002:a2e:9650:0:b0:2d6:f69d:c74c with SMTP id z16-20020a2e9650000000b002d6f69dc74cmr1375944ljh.38.1713443215266;
        Thu, 18 Apr 2024 05:26:55 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id w15-20020a2e300f000000b002d871012b12sm179794ljw.84.2024.04.18.05.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:26:54 -0700 (PDT)
Date: Thu, 18 Apr 2024 15:26:53 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v11 4/6] net: stmmac: dwmac-loongson: Introduce
 GMAC setup
Message-ID: <pyqjoofuvrscra6bluwginu5bowzb3dr424sf3riyrtpzsaheg@k3rr25ivcj7s>
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <6f0ac42c1b60db318b7d746254a9b310dd03aa32.1712917541.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f0ac42c1b60db318b7d746254a9b310dd03aa32.1712917541.git.siyanteng@loongson.cn>

On Fri, Apr 12, 2024 at 07:28:49PM +0800, Yanteng Si wrote:
> Based on IP core classification, loongson has two types of network
> devices: GMAC and GNET. GMAC's ip_core id is 0x35/0x37, while GNET's
> ip_core id is 0x37/0x10.
> 
> Device tables:
> 
> device    type    pci_id    ip_core
> ls2k1000  gmac    7a03      0x35/0x37
> ls7a1000  gmac    7a03      0x35/0x37
> ls2k2000  gnet    7a13      0x10
> ls7a2000  gnet    7a13      0x37
> 
> The ref/ptp clock of gmac is 125000000. gmac device only
> has a MAC chip inside and needs an external PHY chip;
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 21 +++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 995c9bd144e0..ad19b4087974 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -9,7 +9,8 @@
>  #include <linux/of_irq.h>
>  #include "stmmac.h"
>  
> -static int loongson_default_data(struct plat_stmmacenet_data *plat)
> +static void loongson_default_data(struct pci_dev *pdev,
> +				  struct plat_stmmacenet_data *plat)
>  {
>  	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>  	plat->has_gmac = 1;
> @@ -24,16 +25,18 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
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
>  
>  	/* Disable RX queues routing by default */
>  	plat->rx_queues_cfg[0].pkt_route = 0x0;
> +}
> +
> +static int loongson_gmac_data(struct pci_dev *pdev,
> +			      struct plat_stmmacenet_data *plat)
> +{
> +	loongson_default_data(pdev, plat);
>  
>  	/* Default to phy auto-detection */
>  	plat->phy_addr = -1;
> @@ -42,6 +45,12 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
>  	plat->dma_cfg->pblx8 = true;
>  

>  	plat->multicast_filter_bins = 256;
> +	plat->clk_ref_rate = 125000000;
> +	plat->clk_ptp_rate = 125000000;

This change is unrelated to the rest of the changes in this patch.
Please split the patch up into two:
1. Add ref and ptp clocks for Loongson GMAC
2. Split up the platform data initialization
First one is a new feature adding the actual ref clock rates to the
driver. The second patch is a preparation before adding the full PCI
support.

-Serge(y)

> +
> +	plat->tx_queues_to_use = 1;
> +	plat->rx_queues_to_use = 1;
> +
>  	return 0;
>  }
>  
> @@ -114,7 +123,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  
>  	pci_set_master(pdev);
>  
> -	loongson_default_data(plat);
> +	loongson_gmac_data(pdev, plat);
>  	pci_enable_msi(pdev);
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
> -- 
> 2.31.4
> 

