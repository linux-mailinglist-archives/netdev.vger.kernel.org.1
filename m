Return-Path: <netdev+bounces-115090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 424ED945163
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 19:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CFC1C21A69
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4BE183CA2;
	Thu,  1 Aug 2024 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhhiBije"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C613D617
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722532821; cv=none; b=nQzDub4+SW9rBUPF4dqzEe73jY37marRIU3mO9rsGgLmzcsObotZ6m0nOfdJJu0X2LLwYVgeTVIdoQeuaNl+4ui2sqK/rlBXhn5CWKO0DgiZL/QS/VEmphGWoypl+59iteRWcm89+udTe684QdOK6GjNbMM8G61yZ+XXUcWGY2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722532821; c=relaxed/simple;
	bh=LVt4+cigHarCMVfza1hciObOQ30Y8ghQFsrPeAK6f58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAjdZMPw4yKoYPJo7+wqtYb5AJqZifce9rgv3MmFBsou7UJtD9UZ2lni6CRNetpSZeaE50YyMAsPpsEReEPqReiPj6XlEzKIR980OYTrqYVZrr4T3IrH1jZczDV/6j2MlOMWXWIB+WjlUqFRp24BTZyzG9i6xr5ur5Vhv1R1fog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhhiBije; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efba36802so11894219e87.2
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722532818; x=1723137618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMFrInl+thm4hOeoT3rnFfGGFgE7Pb7KF+Y2jvVGeqk=;
        b=fhhiBijeQvjzrsnv1+7fOyFowm7c0BjCS1UV4fd4bvEifvYvqKAIWyU8uH4Xl+4M8F
         bVmkmUXhzomhdS6hksPh17HaXKzSYRIk9yeq2sRQEONzRUHS48jX0zpKoakNFLCzpG/t
         UYAKNZnrDEmdz7wSvdGbl2xRVi9AV3RzV9DvbPFuVkY3KwyHi38UQENhIZLFve1EeVIQ
         cnyTxvYLLOLu/13+PwmsDjsyykUhxS2NVpRD8zJjEDSnul+s6paNE/Qtd7kYOiNejpxn
         rpYbEK34TZ7YnusmfaPCuI7UXBc/SH45rrZW4lUvwwsC4oKyMIQjPpBqU5r6dyZmRhuo
         uIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722532818; x=1723137618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMFrInl+thm4hOeoT3rnFfGGFgE7Pb7KF+Y2jvVGeqk=;
        b=sgY3yzr81w/aK8WjQpRQoZcVzAtMG66Dj2YKyN736ZsPscBSZYDsPWcN7jJQL1iQMY
         I78oCklb54IDPQpDFNzS+vcfDhD4v8tytoD+HcwShXMNGrO+fUCd0Se018MhDBwXWFne
         YyIQBKCOsVlsPqDWwzNADjmj9XqFatFfWFN/v6s/eb3SxDtpowxVSOo99EJM9cA7USP/
         qDZSt1+kyMkY1BFfBoUHGdAV5RTT4dLoXaG/GkxmFgVlaFc1e36jDgJvCMPAOzxvM+Y8
         7yv6oY0j418+oODNADgGvt8p4+qjGRLaQEzzgIPZsjPxRbwGOQw4XkhsIOVzeumhFq8A
         1a1w==
X-Forwarded-Encrypted: i=1; AJvYcCWQYB1tQ/Q4xaqeLGuha88JRdCAMSznKRutQRtBityYP06FItuL2Ws3hhZ5osva5HFbY9uBgRKiyKyA96UJoxYfSroEqWoM
X-Gm-Message-State: AOJu0YxX4C9E9lxM8B0tk0yhJ8u0HkUSPJY5W+9fjCsjbaatf9A2gyVd
	Sin8CPQjMQGoKHt2aPBm8Veu79HzmiokEaSdEGTABg2svLxVoL8bsuyz+A==
X-Google-Smtp-Source: AGHT+IEsjIBQkXIquNac9STLuJzI7SSHLJmaOLheREhwDxTL7nL891UdGbJqz9nasvhXIIVglZ8qfw==
X-Received: by 2002:a05:6512:1253:b0:52c:dd3d:85af with SMTP id 2adb3069b0e04-530bb379522mr459373e87.25.1722532817561;
        Thu, 01 Aug 2024 10:20:17 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba355d4sm10389e87.215.2024.08.01.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:20:17 -0700 (PDT)
Date: Thu, 1 Aug 2024 20:20:14 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Paolo Abeni <pabeni@redhat.com>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	diasyzhang@tencent.com, Jose.Abreu@synopsys.com, chenhuacai@kernel.org, 
	linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org, 
	chris.chenfeiyang@gmail.com, si.yanteng@linux.dev, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH net-next v15 13/14] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <liank4xev7xx3jms2kobjb5tvcsd43rypicynfqqldhd3pvrnn@e4v6ptohzwej>
References: <cover.1722253726.git.siyanteng@loongson.cn>
 <5bcdb73d995bedc805053a7683abfce4ba02c5bb.1722253726.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bcdb73d995bedc805053a7683abfce4ba02c5bb.1722253726.git.siyanteng@loongson.cn>

On Mon, Jul 29, 2024 at 08:24:32PM +0800, Yanteng Si wrote:
> The new generation Loongson LS2K2000 SoC and LS7A2000 chipset are
> equipped with the network controllers called Loongson GNET. It's the
> single and multi DMA-channels Loongson GMAC but with a PHY attached.
> Here is the summary of the DW GMAC features the controller has:
> 
>    DW GMAC IP-core: v3.73a
>    Speeds: 10/100/1000Mbps
>    Duplex: Full (both versions), Half (LS2K2000 GNET only)
>    DMA-descriptors type: enhanced
>    L3/L4 filters availability: Y
>    VLAN hash table filter: Y
>    PHY-interface: GMII (PHY is integrated into the chips)
>    Remote Wake-up support: Y
>    Mac Management Counters (MMC): Y
>    Number of additional MAC addresses: 5
>    MAC Hash-based filter: Y
>    Hash Table Size: 256
>    AV feature: Y (LS2K2000 GNET only)
>    DMA channels: 8 (LS2K2000 GNET), 1 (LS7A2000 GNET)
> 
> Let's update the Loongson DWMAC driver to supporting the new Loongson
> GNET controller. The change is mainly trivial: the driver shall be
> bound to the PCIe device with DID 0x7a13, and the device-specific
> setup() method shall be called for it. The only peculiarity concerns
> the integrated PHY speed change procedure. The PHY has a weird problem
> with switching from the low speeds to 1000Mbps mode. The speedup
> procedure requires the PHY-link re-negotiation. So the suggested
> change provide the device-specific fix_mac_speed() method to overcome
> the problem.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

Looking good to me. Thanks.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 77 ++++++++++++++++++-
>  1 file changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index eea6a22b10ca..18fc3dd983cb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -65,11 +65,13 @@
>  					 DMA_STATUS_MSK_COMMON_LOONGSON)
>  
>  #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
> +#define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
>  #define DWMAC_CORE_LS_MULTICHAN	0x10	/* Loongson custom ID */
>  #define CHANNEL_NUM			8
>  
>  struct loongson_data {
>  	u32 loongson_id;
> +	struct device *dev;
>  };
>  
>  struct stmmac_pci_info {
> @@ -147,6 +149,60 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>  	.setup = loongson_gmac_data,
>  };
>  
> +static void loongson_gnet_fix_speed(void *priv, unsigned int speed,
> +				    unsigned int mode)
> +{
> +	struct loongson_data *ld = (struct loongson_data *)priv;
> +	struct net_device *ndev = dev_get_drvdata(ld->dev);
> +	struct stmmac_priv *ptr = netdev_priv(ndev);
> +
> +	/* The integrated PHY has a weird problem with switching from the low
> +	 * speeds to 1000Mbps mode. The speedup procedure requires the PHY-link
> +	 * re-negotiation.
> +	 */
> +	if (speed == SPEED_1000) {
> +		if (readl(ptr->ioaddr + MAC_CTRL_REG) &
> +		    GMAC_CONTROL_PS)
> +			/* Word around hardware bug, restart autoneg */
> +			phy_restart_aneg(ndev->phydev);
> +	}
> +}
> +
> +static int loongson_gnet_data(struct pci_dev *pdev,
> +			      struct plat_stmmacenet_data *plat)
> +{
> +	struct loongson_data *ld;
> +	int i;
> +
> +	ld = plat->bsp_priv;
> +
> +	loongson_default_data(pdev, plat);
> +
> +	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
> +		plat->rx_queues_to_use = CHANNEL_NUM;
> +		plat->tx_queues_to_use = CHANNEL_NUM;
> +
> +		/* Only channel 0 supports checksum,
> +		 * so turn off checksum to enable multiple channels.
> +		 */
> +		for (i = 1; i < CHANNEL_NUM; i++)
> +			plat->tx_queues_cfg[i].coe_unsupported = 1;
> +	} else {
> +		plat->tx_queues_to_use = 1;
> +		plat->rx_queues_to_use = 1;
> +	}
> +
> +	plat->phy_interface = PHY_INTERFACE_MODE_GMII;
> +	plat->mdio_bus_data->phy_mask = ~(u32)BIT(2);
> +	plat->fix_mac_speed = loongson_gnet_fix_speed;
> +
> +	return 0;
> +}
> +
> +static struct stmmac_pci_info loongson_gnet_pci_info = {
> +	.setup = loongson_gnet_data,
> +};
> +
>  static void loongson_dwmac_dma_init_channel(struct stmmac_priv *priv,
>  					    void __iomem *ioaddr,
>  					    struct stmmac_dma_cfg *dma_cfg,
> @@ -279,8 +335,10 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
>  	struct mac_device_info *mac;
>  	struct stmmac_dma_ops *dma;
>  	struct loongson_data *ld;
> +	struct pci_dev *pdev;
>  
>  	ld = priv->plat->bsp_priv;
> +	pdev = to_pci_dev(priv->device);
>  
>  	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
>  	if (!mac)
> @@ -290,7 +348,7 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
>  	if (!dma)
>  		return NULL;
>  
> -	/* The Loongson GMAC devices are based on the DW GMAC
> +	/* The Loongson GMAC and GNET devices are based on the DW GMAC
>  	 * v3.50a and v3.73a IP-cores. But the HW designers have changed the
>  	 * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the
>  	 * network controllers with the multi-channels feature
> @@ -319,8 +377,19 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
>  	if (mac->multicast_filter_bins)
>  		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
>  
> -	/* Loongson GMAC doesn't support the flow control. */
> -	mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
> +	/* Loongson GMAC doesn't support the flow control. LS2K2000
> +	 * GNET doesn't support the half-duplex link mode.
> +	 */
> +	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC) {
> +		mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
> +	} else {
> +		if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
> +			mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +					 MAC_10 | MAC_100 | MAC_1000;
> +		else
> +			mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +					 MAC_10FD | MAC_100FD | MAC_1000FD;
> +	}
>  
>  	mac->link.duplex = GMAC_CONTROL_DM;
>  	mac->link.speed10 = GMAC_CONTROL_PS;
> @@ -495,6 +564,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  
>  	plat->bsp_priv = ld;
>  	plat->setup = loongson_dwmac_setup;
> +	ld->dev = &pdev->dev;
>  	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
>  
>  	info = (struct stmmac_pci_info *)id->driver_data;
> @@ -599,6 +669,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>  
>  static const struct pci_device_id loongson_dwmac_id_table[] = {
>  	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> +	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> -- 
> 2.31.4
> 

