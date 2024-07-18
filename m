Return-Path: <netdev+bounces-112083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92540934DFF
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B516C1C20F74
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C26284E11;
	Thu, 18 Jul 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG7AfZii"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D47470
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308961; cv=none; b=FlD8wDMqXP2EmSbnYaqvlOLWQU82+RcOFgGRji4NqtJ5EenBiR5bc5UcAQf2XO04BwKU99+/zSdnESeWYH7hWDrUpb///8I/rKphs+SeENPyHYooSmD96ho2ZE/Gn1u8tBinwWJx06Szey7Ep/4+iuDr0y8qcHtb08Da+1ZTSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308961; c=relaxed/simple;
	bh=nY+GEUQEIQEdcjTni7JFgWVVXPbV4foHHoYre0NUcBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+ioRopVBqXDLsYUySXbiYCtXoV3sRObWGMTL/ROfhp6Ubmi/kxl5a9Z/289TBUzzgGYPM3pmWeSoPHg3kuPEu4I8zyk1wrqGuru2MZzuYkWwD+1HlfU8f4KDBV3V3Y7FOCQul5hRgJ1zAvWd+oq+gogVOGAK6hTiGW7f78KOsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KG7AfZii; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70af2b1a35aso567945b3a.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721308958; x=1721913758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7R1IScFIpMqnxkmjusAWRJZPVBpzBw2UEbkQQFeMUnY=;
        b=KG7AfZiiAKPsb1OracpCN+Ok6fcdDVDbfjKXBUNSBmdUhiJUjrJh2VKc3i5xzmxvXd
         yT/6zq3E4vEZH2YSe5JDUsxjPRUpvj8RHvxs1kwHBxodxg/eGOAN2ZWrS+cdRH0+9Z0t
         IX32KxDHRNa3635hrtf9JcF71q+w5xWfyc6/FpUDRbp52R9x1GNRIv+2WUw3YtanNNls
         hi5Tn47WsZT1rhabjtP6EcTVgmrgpDXzXrd/LXsdUBgY4z7wCT5JuQd30OW2KYc58Wm2
         JNG5WIQSoDG9i5BBm7y/KYuZECkw31Jw6tmtfyc99AKHJlPUN3nvv4+RPHG3HMicpUgq
         Emyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721308958; x=1721913758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R1IScFIpMqnxkmjusAWRJZPVBpzBw2UEbkQQFeMUnY=;
        b=DGi4vTUUByDismtH3QS7WcYLec18FblmqDai5tBcC5D7mt9gAjUwWCNySbaLm3dJ1D
         rDr4JP1XIEjQ27h/rk8XaMrdD3s8HPzzfeyAV1eYH9BXwZE/gZoQVxSLfvMni2n1nNwj
         h+GPWTIH1F5CXOAsUbnU8x23EtkO6uPnMOCFvjN8cDpU3xgZxM5VF02ZgOT7D1q/AS/3
         K5OWkeHEAihWT7nuBU/p4Zzds8vA4Lq375+cm6r3AKIIzkePtt1P/zverSasZc0S0jHz
         HW8ukfj33WL+KB6tKZxIpJbJrekW664jtUjkdPQ7GOuSi+JPHUmvFSDXw56wtt1AG8it
         wfxg==
X-Forwarded-Encrypted: i=1; AJvYcCX3p8OiHXFtRiY4d9YKdK/KnhO63KGjZ5VJ1nK26TdZtHIjLdHp+2l7pANeJ43B1sespeD0dKzrX6UhpD7uda1muA7/dKxi
X-Gm-Message-State: AOJu0YztgYxqr4aUNExm8LW+yM8rdfP/1rh+w+OwEcc5Bj5taGa4NCzl
	htjJdd9CG+uMRKmzGNMABrMCbRBZkQY1Eraez+i6C4qVzpNstkor
X-Google-Smtp-Source: AGHT+IE0gYq9nksPEjj43vLzIrCe67A6YqKPb1EJLJjSHHsMRQqD48/z0U4UoNieFLx1tP/AS7BPyw==
X-Received: by 2002:a05:6a00:3d44:b0:706:6937:cb9d with SMTP id d2e1a72fcca58-70ce4c1c149mr5607834b3a.0.1721308958061;
        Thu, 18 Jul 2024 06:22:38 -0700 (PDT)
Received: from mobilestation ([176.15.243.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca7794sm10331919b3a.149.2024.07.18.06.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 06:22:37 -0700 (PDT)
Date: Thu, 18 Jul 2024 16:22:27 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v14 12/14] net: stmmac: dwmac-loongson: Add
 Loongson Multi-channels GMAC support
Message-ID: <kdk2ulmdvtnlujmg2don2nb2v3oqe6km6gfvylsnrrel7uf2vc@4hmxkgifnxgf>
References: <cover.1720512634.git.siyanteng@loongson.cn>
 <a80bc1276dcdd277e684e02531c45eb9718e6589.1720512634.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80bc1276dcdd277e684e02531c45eb9718e6589.1720512634.git.siyanteng@loongson.cn>

On Tue, Jul 09, 2024 at 05:37:35PM +0800, Yanteng Si wrote:
> The Loongson DWMAC driver currently supports the Loongson GMAC
> devices (based on the DW GMAC v3.50a/v3.73a IP-core) installed to the
> LS2K1000 SoC and LS7A1000 chipset. But recently a new generation
> LS2K2000 SoC was released with the new version of the Loongson GMAC
> synthesized in. The new controller is based on the DW GMAC v3.73a
> IP-core with the AV-feature enabled, which implies the multi
> DMA-channels support. The multi DMA-channels feature has the next
> vendor-specific peculiarities:
> 
> 1. Split up Tx and Rx DMA IRQ status/mask bits:
>        Name              Tx          Rx
>   DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
>   DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
>   DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
>   DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
>   DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
> 2. Custom Synopsys ID hardwired into the GMAC_VERSION.SNPSVER register
> field. It's 0x10 while it should have been 0x37 in accordance with
> the actual DW GMAC IP-core version.
> 3. There are eight DMA-channels available meanwhile the Synopsys DW
> GMAC IP-core supports up to three DMA-channels.
> 4. It's possible to have each DMA-channel IRQ independently delivered.
> The MSI IRQs must be utilized for that.
> 
> Thus in order to have the multi-channels Loongson GMAC controllers
> supported let's modify the Loongson DWMAC driver in accordance with
> all the peculiarities described above:
> 
> 1. Create the multi-channels Loongson GMAC-specific
>    stmmac_dma_ops::dma_interrupt()
>    stmmac_dma_ops::init_chan()
>    callbacks due to the non-standard DMA IRQ CSR flags layout.
> 2. Create the Loongson DWMAC-specific platform setup() method
> which gets to initialize the DMA-ops with the dwmac1000_dma_ops
> instance and overrides the callbacks described in 1. The method also
> overrides the custom Synopsys ID with the real one in order to have
> the rest of the HW-specific callbacks correctly detected by the driver
> core.
> 3. Make sure the platform setup() method enables the flow control and
> duplex modes supported by the controller.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 341 +++++++++++++++++-
>  2 files changed, 339 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index cd36ff4da68c..684489156dce 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -29,6 +29,7 @@
>  /* Synopsys Core versions */
>  #define	DWMAC_CORE_3_40		0x34
>  #define	DWMAC_CORE_3_50		0x35
> +#define	DWMAC_CORE_3_70		0x37
>  #define	DWMAC_CORE_4_00		0x40
>  #define DWMAC_CORE_4_10		0x41
>  #define DWMAC_CORE_5_00		0x50
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index b4704068321f..ed45d6e56de2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -8,8 +8,70 @@
>  #include <linux/device.h>
>  #include <linux/of_irq.h>
>  #include "stmmac.h"
> +#include "dwmac_dma.h"
> +#include "dwmac1000.h"
> +
> +/* Normal Loongson Tx Summary */
> +#define DMA_INTR_ENA_NIE_TX_LOONGSON	0x00040000
> +/* Normal Loongson Rx Summary */
> +#define DMA_INTR_ENA_NIE_RX_LOONGSON	0x00020000
> +
> +#define DMA_INTR_NORMAL_LOONGSON	(DMA_INTR_ENA_NIE_TX_LOONGSON | \
> +					 DMA_INTR_ENA_NIE_RX_LOONGSON | \
> +					 DMA_INTR_ENA_RIE | DMA_INTR_ENA_TIE)
> +
> +/* Abnormal Loongson Tx Summary */
> +#define DMA_INTR_ENA_AIE_TX_LOONGSON	0x00010000
> +/* Abnormal Loongson Rx Summary */
> +#define DMA_INTR_ENA_AIE_RX_LOONGSON	0x00008000
> +
> +#define DMA_INTR_ABNORMAL_LOONGSON	(DMA_INTR_ENA_AIE_TX_LOONGSON | \
> +					 DMA_INTR_ENA_AIE_RX_LOONGSON | \
> +					 DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE)
> +
> +#define DMA_INTR_DEFAULT_MASK_LOONGSON	(DMA_INTR_NORMAL_LOONGSON | \
> +					 DMA_INTR_ABNORMAL_LOONGSON)
> +
> +/* Normal Loongson Tx Interrupt Summary */
> +#define DMA_STATUS_NIS_TX_LOONGSON	0x00040000
> +/* Normal Loongson Rx Interrupt Summary */
> +#define DMA_STATUS_NIS_RX_LOONGSON	0x00020000
> +
> +/* Abnormal Loongson Tx Interrupt Summary */
> +#define DMA_STATUS_AIS_TX_LOONGSON	0x00010000
> +/* Abnormal Loongson Rx Interrupt Summary */
> +#define DMA_STATUS_AIS_RX_LOONGSON	0x00008000
> +
> +/* Fatal Loongson Tx Bus Error Interrupt */
> +#define DMA_STATUS_FBI_TX_LOONGSON	0x00002000
> +/* Fatal Loongson Rx Bus Error Interrupt */
> +#define DMA_STATUS_FBI_RX_LOONGSON	0x00001000
> +
> +#define DMA_STATUS_MSK_COMMON_LOONGSON	(DMA_STATUS_NIS_TX_LOONGSON | \
> +					 DMA_STATUS_NIS_RX_LOONGSON | \
> +					 DMA_STATUS_AIS_TX_LOONGSON | \
> +					 DMA_STATUS_AIS_RX_LOONGSON | \
> +					 DMA_STATUS_FBI_TX_LOONGSON | \
> +					 DMA_STATUS_FBI_RX_LOONGSON)
> +
> +#define DMA_STATUS_MSK_RX_LOONGSON	(DMA_STATUS_ERI | DMA_STATUS_RWT | \
> +					 DMA_STATUS_RPS | DMA_STATUS_RU  | \
> +					 DMA_STATUS_RI  | DMA_STATUS_OVF | \
> +					 DMA_STATUS_MSK_COMMON_LOONGSON)
> +
> +#define DMA_STATUS_MSK_TX_LOONGSON	(DMA_STATUS_ETI | DMA_STATUS_UNF | \
> +					 DMA_STATUS_TJT | DMA_STATUS_TU  | \
> +					 DMA_STATUS_TPS | DMA_STATUS_TI  | \
> +					 DMA_STATUS_MSK_COMMON_LOONGSON)
>  
>  #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03

> +#define DWMAC_CORE_LS_MULTICHAN	0x10	/* Loongson custom IP */

s/Loongson custom IP/Loongson custom ID

> +#define CHANNEL_NUM			8
> +
> +struct loongson_data {
> +	u32 loongson_id;

> +	struct device *dev;

Move this field adding to the next patch.

> +};
>  
>  struct stmmac_pci_info {
>  	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
> @@ -56,10 +118,26 @@ static void loongson_default_data(struct pci_dev *pdev,
>  static int loongson_gmac_data(struct pci_dev *pdev,
>  			      struct plat_stmmacenet_data *plat)
>  {
> +	struct loongson_data *ld;
> +	int i;
> +
> +	ld = plat->bsp_priv;
> +
>  	loongson_default_data(pdev, plat);
>  
> -	plat->tx_queues_to_use = 1;
> -	plat->rx_queues_to_use = 1;
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
>  
>  	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
>  
> @@ -70,6 +148,239 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>  	.setup = loongson_gmac_data,
>  };
>  
> +static void loongson_dwmac_dma_init_channel(struct stmmac_priv *priv,
> +					    void __iomem *ioaddr,
> +					    struct stmmac_dma_cfg *dma_cfg,
> +					    u32 chan)
> +{
> +	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
> +	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
> +	u32 value;
> +
> +	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
> +
> +	if (dma_cfg->pblx8)
> +		value |= DMA_BUS_MODE_MAXPBL;
> +
> +	value |= DMA_BUS_MODE_USP;
> +	value &= ~(DMA_BUS_MODE_PBL_MASK | DMA_BUS_MODE_RPBL_MASK);
> +	value |= (txpbl << DMA_BUS_MODE_PBL_SHIFT);
> +	value |= (rxpbl << DMA_BUS_MODE_RPBL_SHIFT);
> +
> +	/* Set the Fixed burst mode */
> +	if (dma_cfg->fixed_burst)
> +		value |= DMA_BUS_MODE_FB;
> +
> +	/* Mixed Burst has no effect when fb is set */
> +	if (dma_cfg->mixed_burst)
> +		value |= DMA_BUS_MODE_MB;
> +
> +	if (dma_cfg->atds)
> +		value |= DMA_BUS_MODE_ATDS;
> +
> +	if (dma_cfg->aal)
> +		value |= DMA_BUS_MODE_AAL;
> +
> +	writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
> +
> +	/* Mask interrupts by writing to CSR7 */
> +	writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr +
> +	       DMA_CHAN_INTR_ENA(chan));
> +}
> +
> +static int loongson_dwmac_dma_interrupt(struct stmmac_priv *priv,
> +					void __iomem *ioaddr,
> +					struct stmmac_extra_stats *x,
> +					u32 chan, u32 dir)
> +{
> +	struct stmmac_pcpu_stats *stats = this_cpu_ptr(priv->xstats.pcpu_stats);
> +	u32 abnor_intr_status;
> +	u32 nor_intr_status;
> +	u32 fb_intr_status;
> +	u32 intr_status;
> +	int ret = 0;
> +
> +	/* read the status register (CSR5) */
> +	intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
> +
> +	if (dir == DMA_DIR_RX)
> +		intr_status &= DMA_STATUS_MSK_RX_LOONGSON;
> +	else if (dir == DMA_DIR_TX)
> +		intr_status &= DMA_STATUS_MSK_TX_LOONGSON;
> +
> +	nor_intr_status = intr_status & (DMA_STATUS_NIS_TX_LOONGSON |
> +		DMA_STATUS_NIS_RX_LOONGSON);
> +	abnor_intr_status = intr_status & (DMA_STATUS_AIS_TX_LOONGSON |
> +		DMA_STATUS_AIS_RX_LOONGSON);
> +	fb_intr_status = intr_status & (DMA_STATUS_FBI_TX_LOONGSON |
> +		DMA_STATUS_FBI_RX_LOONGSON);
> +
> +	/* ABNORMAL interrupts */
> +	if (unlikely(abnor_intr_status)) {
> +		if (unlikely(intr_status & DMA_STATUS_UNF)) {
> +			ret = tx_hard_error_bump_tc;
> +			x->tx_undeflow_irq++;
> +		}
> +		if (unlikely(intr_status & DMA_STATUS_TJT))
> +			x->tx_jabber_irq++;
> +		if (unlikely(intr_status & DMA_STATUS_OVF))
> +			x->rx_overflow_irq++;
> +		if (unlikely(intr_status & DMA_STATUS_RU))
> +			x->rx_buf_unav_irq++;
> +		if (unlikely(intr_status & DMA_STATUS_RPS))
> +			x->rx_process_stopped_irq++;
> +		if (unlikely(intr_status & DMA_STATUS_RWT))
> +			x->rx_watchdog_irq++;
> +		if (unlikely(intr_status & DMA_STATUS_ETI))
> +			x->tx_early_irq++;
> +		if (unlikely(intr_status & DMA_STATUS_TPS)) {
> +			x->tx_process_stopped_irq++;
> +			ret = tx_hard_error;
> +		}
> +		if (unlikely(fb_intr_status)) {
> +			x->fatal_bus_error_irq++;
> +			ret = tx_hard_error;
> +		}
> +	}
> +	/* TX/RX NORMAL interrupts */
> +	if (likely(nor_intr_status)) {
> +		if (likely(intr_status & DMA_STATUS_RI)) {
> +			u32 value = readl(ioaddr + DMA_INTR_ENA);
> +			/* to schedule NAPI on real RIE event. */
> +			if (likely(value & DMA_INTR_ENA_RIE)) {
> +				u64_stats_update_begin(&stats->syncp);
> +				u64_stats_inc(&stats->rx_normal_irq_n[chan]);
> +				u64_stats_update_end(&stats->syncp);
> +				ret |= handle_rx;
> +			}
> +		}
> +		if (likely(intr_status & DMA_STATUS_TI)) {
> +			u64_stats_update_begin(&stats->syncp);
> +			u64_stats_inc(&stats->tx_normal_irq_n[chan]);
> +			u64_stats_update_end(&stats->syncp);
> +			ret |= handle_tx;
> +		}
> +		if (unlikely(intr_status & DMA_STATUS_ERI))
> +			x->rx_early_irq++;
> +	}
> +	/* Optional hardware blocks, interrupts should be disabled */
> +	if (unlikely(intr_status &
> +		     (DMA_STATUS_GPI | DMA_STATUS_GMI | DMA_STATUS_GLI)))
> +		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
> +
> +	/* Clear the interrupt by writing a logic 1 to the CSR5[19-0] */
> +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
> +
> +	return ret;
> +}
> +
> +static struct mac_device_info *loongson_dwmac_setup(void *apriv)
> +{
> +	struct stmmac_priv *priv = apriv;
> +	struct mac_device_info *mac;
> +	struct stmmac_dma_ops *dma;
> +	struct loongson_data *ld;
> +	struct pci_dev *pdev;
> +
> +	ld = priv->plat->bsp_priv;
> +	pdev = to_pci_dev(priv->device);
> +
> +	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
> +	if (!mac)
> +		return NULL;
> +
> +	dma = devm_kzalloc(priv->device, sizeof(*dma), GFP_KERNEL);
> +	if (!dma)
> +		return NULL;
> +
> +	/* The Loongson GMAC devices are based on the DW GMAC
> +	 * v3.50a and v3.73a IP-cores. But the HW designers have changed the
> +	 * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the
> +	 * network controllers with the multi-channels feature
> +	 * available to emphasize the differences: multiple DMA-channels,
> +	 * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
> +	 * original value so the correct HW-interface would be selected.
> +	 */
> +	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
> +		priv->synopsys_id = DWMAC_CORE_3_70;
> +		*dma = dwmac1000_dma_ops;
> +		dma->init_chan = loongson_dwmac_dma_init_channel;
> +		dma->dma_interrupt = loongson_dwmac_dma_interrupt;
> +		mac->dma = dma;
> +	}
> +
> +	priv->dev->priv_flags |= IFF_UNICAST_FLT;
> +
> +	/* Pre-initialize the respective "mac" fields as it's done in
> +	 * dwmac1000_setup()
> +	 */
> +	mac->pcsr = priv->ioaddr;
> +	mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
> +	mac->unicast_filter_entries = priv->plat->unicast_filter_entries;
> +	mac->mcast_bits_log2 = 0;
> +
> +	if (mac->multicast_filter_bins)
> +		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
> +
> +	/* Loongson GMAC doesn't support the flow control. */

> +	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC)

This if-statement should be added in the next patch since at this
patch stage the only supported device is Loongson GMAC so ...

> +		mac->link.caps = MAC_10 | MAC_100 | MAC_1000;

... the caps initialisation is supposed to be performed unconditionally.

> +
> +	mac->link.duplex = GMAC_CONTROL_DM;
> +	mac->link.speed10 = GMAC_CONTROL_PS;
> +	mac->link.speed100 = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
> +	mac->link.speed1000 = 0;
> +	mac->link.speed_mask = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
> +	mac->mii.addr = GMAC_MII_ADDR;
> +	mac->mii.data = GMAC_MII_DATA;
> +	mac->mii.addr_shift = 11;
> +	mac->mii.addr_mask = 0x0000F800;
> +	mac->mii.reg_shift = 6;
> +	mac->mii.reg_mask = 0x000007C0;
> +	mac->mii.clk_csr_shift = 2;
> +	mac->mii.clk_csr_mask = GENMASK(5, 2);
> +
> +	return mac;
> +}
> +
> +static int loongson_dwmac_msi_config(struct pci_dev *pdev,
> +				     struct plat_stmmacenet_data *plat,
> +				     struct stmmac_resources *res)
> +{
> +	int i, ret, vecs;
> +
> +	vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> +	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
> +		return ret;
> +	}
> +
> +	res->irq = pci_irq_vector(pdev, 0);
> +
> +	if (ret >= vecs) {
> +		for (i = 0; i < plat->rx_queues_to_use; i++) {
> +			res->rx_irq[CHANNEL_NUM - 1 - i] =
> +				pci_irq_vector(pdev, 1 + i * 2);
> +		}
> +		for (i = 0; i < plat->tx_queues_to_use; i++) {
> +			res->tx_irq[CHANNEL_NUM - 1 - i] =
> +				pci_irq_vector(pdev, 2 + i * 2);
> +		}
> +
> +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> +	}
> +
> +	return 0;
> +}

I deliberately emphasized to note the pci_alloc_irq_vectors()
arguments. Passing the same min and max means to request the exact
amount of MSI vectors. So there is no need in checking the returned
value for being greater than vecs.

Moreover as we figured out on v13, the multi-channel-ness still works
even if no MSI allocated. The only difference is that all the events
will be delivered via the MAC IRQ:
https://lore.kernel.org/netdev/16ce72fa-585a-4522-9f8c-a987f1788e67@loongson.cn/

So AFAICS the method can be simplified like this:

+static int loongson_dwmac_msi_config(struct pci_dev *pdev,
+				     struct plat_stmmacenet_data *plat,
+				     struct stmmac_resources *res)
+{
+	int i, ret, vecs;
+
+	vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
+	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
+	if (ret < 0) {
+		dev_warn(&pdev->dev, "Failed to allocate MSI IRQs\n");
+		return ret;
+	}
+
+	res->irq = pci_irq_vector(pdev, 0);
+
+	for (i = 0; i < plat->rx_queues_to_use; i++) {
+		res->rx_irq[CHANNEL_NUM - 1 - i] =
+			pci_irq_vector(pdev, 1 + i * 2);
+	}
+
+	for (i = 0; i < plat->tx_queues_to_use; i++) {
+		res->tx_irq[CHANNEL_NUM - 1 - i] =
+			pci_irq_vector(pdev, 2 + i * 2);
+	}
+
+	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+
+	return 0;
+}

Please once again note the omitted (ret > vecs) conditional statement
and using the dev_warn("... MSI IRQS ...") instead of dev_err(), since
having MSI isn't required for the device to work.

> +

> +static int loongson_dwmac_msi_clear(struct pci_dev *pdev)
> +{
> +	pci_free_irq_vectors(pdev);
> +
> +	return 0;
> +}

Please convert it to returning void.

> +
>  static int loongson_dwmac_dt_config(struct pci_dev *pdev,
>  				    struct plat_stmmacenet_data *plat,
>  				    struct stmmac_resources *res)
> @@ -134,6 +445,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	struct plat_stmmacenet_data *plat;
>  	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
> +	struct loongson_data *ld;
>  	int ret, i;
>  
>  	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> @@ -150,6 +462,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	if (!plat->dma_cfg)
>  		return -ENOMEM;
>  
> +	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> +	if (!ld)
> +		return -ENOMEM;
> +
>  	/* Enable pci device */
>  	ret = pci_enable_device(pdev);
>  	if (ret) {
> @@ -172,6 +488,11 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
>  
> +	plat->bsp_priv = ld;
> +	plat->setup = loongson_dwmac_setup;

> +	ld->dev = &pdev->dev;

Move this line to the next patch.

> +	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
> +
>  	info = (struct stmmac_pci_info *)id->driver_data;
>  	ret = info->setup(pdev, plat);
>  	if (ret)
> @@ -184,12 +505,21 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	if (ret)
>  		goto err_disable_device;
>  

> +	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
> +		ret = loongson_dwmac_msi_config(pdev, plat, &res);
> +		if (ret)
> +			goto err_disable_device;
> +	}

Since MSIs isn't required for the Multi-channels device to work this
can be converted to:

	/* Use the common MAC IRQ if per-channel MSIs allocation failed */
	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
		loongson_dwmac_msi_config(pdev, plat, &res);

-Serge(y)

> +
>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
> -		goto err_disable_device;
> +		goto err_clear_msi;
>  
>  	return ret;
>  
> +err_clear_msi:
> +	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
> +		loongson_dwmac_msi_clear(pdev);
>  err_disable_device:
>  	pci_disable_device(pdev);
>  err_put_node:
> @@ -201,8 +531,10 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>  {
>  	struct net_device *ndev = dev_get_drvdata(&pdev->dev);
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> +	struct loongson_data *ld;
>  	int i;
>  
> +	ld = priv->plat->bsp_priv;
>  	of_node_put(priv->plat->mdio_node);
>  	stmmac_dvr_remove(&pdev->dev);
>  
> @@ -213,6 +545,9 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>  		break;
>  	}
>  
> +	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
> +		loongson_dwmac_msi_clear(pdev);
> +
>  	pci_disable_device(pdev);
>  }
>  
> -- 
> 2.31.4
> 

