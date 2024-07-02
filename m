Return-Path: <netdev+bounces-108356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (unknown [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4712992383B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D19B1C20DDF
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 08:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4B814D2B2;
	Tue,  2 Jul 2024 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WidGs0PR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1710D14B97A
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908933; cv=none; b=HFJYBzGzO4Rb66WYB5DXbS833NKyeTNyQu0t1jXJYCB7WVkXd9rRKwBkhCDwaVSi1vHmfQZolm0L5RRCdiMt76/pEXUhiI52JREcBcunUbaw+s3MOAkMu7t5Liezyk9XhuojuTFcHreOjq/PUSMTgh59LelxsmnosTTgNq5aLjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908933; c=relaxed/simple;
	bh=RAoPoHIB2qf5gYoHU95XCzRGXjIX7d7V9Mud9piVFo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SavC7WQFR2+4/X+xN+wG7b2VSFF77CVZXPmEqgKUVEad2v4pQM/6myWoCNuw9Ej65jIyy+LXsEXjnHPgGLmsAAXHuazaW85/4+alwCwcyvoI/QHCeL/Y9A7hRbNAVmk8DWpv7UdJxHiIF+WowbFAdbn4khNJ2wmTx0bzhn950ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WidGs0PR; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so40569441fa.3
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719908929; x=1720513729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ph36HoA7PNXZQfJulYWH5z//ZnziOmiT83ch/lyuk/0=;
        b=WidGs0PRIvpzxD3fayiXygVm+Xddnwup6QMA4rW0REwye3zIiize3RXkxIfOZsuPDw
         nFNhzBJpsDzXKAR0BPWo2LIjDH6vaT0HdkWRFc9irAsFz//unTFZvFH+LPwLDcmzRpSp
         E97zmv+Q/Dr8WOLtHWPnFE+TbhnOg3FUPYh4QQ6irQDgd4vY87wocO/3ukaLvweap2vc
         SYHeiRBkV8Sh3B2/cc0SIGeeCtpRzdkz7OVVl9uEuRjIZEs4Nwnwr9W1fY0KvDifvDLS
         bP5LGmNcb9YWX0SxqfcLlf/CNILaY6QK93rWJ+KazBpj1HVbi9ptnU4LDwWz5yvmhr2J
         9AJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719908929; x=1720513729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph36HoA7PNXZQfJulYWH5z//ZnziOmiT83ch/lyuk/0=;
        b=eVXQjuBVIfelhM9IREst/92ibkPzjPrrZpCVyLURnuFqCF7QuzwxhTYJgDeBlmfwGY
         GqCjycLRR45RsB5ywXLVhpG+H0bg0W4XE5rSgL7KACf7nXFH92b1g2v+/O4E1wAQm5eM
         ovvnjvp/LP57KV9fo635Jj17KH6O4ldIpliabD2Qb2sPZAytHGkslOc65vriIDFz9YnN
         v51jhC9FyazW1cymuqtD40hjuZdsMvljocA3p1hv/Hv4yfE0SMRYOvUVSc6Om3F+YEej
         ZAmoTE/wlaJK+cx9FqAtL3C7wf6oIvMHDRSLXZKuepbHPVPRC2wyxnUOLfQSllK5EhwY
         hrFA==
X-Forwarded-Encrypted: i=1; AJvYcCXBmIujOrMHefdFzlaeKrQ3d0uUcy2otIi/91bIRLqGJ+JKFPyJk0pB4MqGtWsqVzrdjLACGDM4SFboj50T0et2t1h7nsel
X-Gm-Message-State: AOJu0YwQkMXWgDRxj0eIFuNu6iTetTOXeLhSu/uKGWos19VAizSKNskk
	wJD5FMGRDjOQ9LqW1kazbdfjj8QmlN7s1RbYxCdMJ1nV/krafKJf
X-Google-Smtp-Source: AGHT+IHUdniUnQoUnO0IUlLnDlRAT/kI+FuRQh1gc6oI6IpIEKepaItY9/WH9gYXtzJSETUztVceUA==
X-Received: by 2002:a2e:88d1:0:b0:2ec:5f6e:65ea with SMTP id 38308e7fff4ca-2ee5e6e7210mr45652851fa.38.1719908928734;
        Tue, 02 Jul 2024 01:28:48 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee516803c4sm16297351fa.93.2024.07.02.01.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 01:28:48 -0700 (PDT)
Date: Tue, 2 Jul 2024 11:28:45 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
Message-ID: <io5eoyp7eq656fzrrd5htq3d7rc22tm7b5zpi6ynaoawhdb7sp@b5ydxzhtqg6x>
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
> 
> The driver currently supports the chips with the Loongson GMAC network
> device. As a preparation before adding the Loongson GNET support
> detach the Loongson GMAC-specific platform data initializations to the
> loongson_gmac_data() method and preserve the common settings in the
> loongson_default_data().
> 
> While at it drop the return value statement from the
> loongson_default_data() method as redundant.

Based on the last hardware setup insight Loongson GMAC with AV-feature
can be found on the LS2K2000 CPU. Thus the commit log should be:

"Loongson delivers two types of the network devices: Loongson GMAC and
Loongson GNET in the framework of four CPU/Chipsets revisions:

   Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
LS2K2000 CPU         GMAC      0x7a03          v3.73a            8
LS2K2000 CPU         GNET      0x7a13          v3.73a            8
LS7A2000 Chipset     GNET      0x7a13          v3.73a            1

The driver currently supports the chips with the Loongson GMAC network
device synthesized with a single DMA-channel available. As a
preparation before adding the Loongson GNET support detach the
Loongson GMAC-specific platform data initializations to the
loongson_gmac_data() method and preserve the common settings in the
loongson_default_data().

While at it drop the return value statement from the
loongson_default_data() method as redundant."

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

Please move this to the loongson_gmac_data(). Thus all the
platform-data initializations would be collected in two coherent
methods: loongson_default_data() and loongson_gmac_data(). It will be
positive from the readability and maintainability points of view.

In the patch adding the Loongson multi-channel GMAC support make sure
the loongson_data::loongson_id field is initialized before the
stmmac_pci_info::setup() method is called.

-Serge(y)

>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
>  		goto err_disable_msi;
> -- 
> 2.31.4
> 

