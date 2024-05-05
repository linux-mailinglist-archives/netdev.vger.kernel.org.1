Return-Path: <netdev+bounces-93543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB928BC40F
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 23:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FA31F21F19
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 21:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E6A135A73;
	Sun,  5 May 2024 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlC6DsUu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D4A6EB7E
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714945823; cv=none; b=uR/A2aCn+q5Hu43tzKKeDd9IKarJpV1S8U9vhmUKZtJlHpREKr+7NdSANy6idG7X77Gz/TMLk/+seQxO1NhnEKwXLcZGFx86XGlUdKYM07iZQepkS0XazpU3DzBn6idwZZTr/zmgKZ8J/4L8ul2T7du7v8vV/UMFKaG2YhFNeRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714945823; c=relaxed/simple;
	bh=IV4jRdS0GBBYyL9EUqquEKo0h5w37Or6SAe/xNqXx3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcpYyWAwERyv2c4tYX0WCHF6WADuF4wZSvw4S3zPwhEKBzPPBaUWj9nuKcCoYnLVgj6qj4ruTbDfqbWhr40qzf4rY49NPEvx9DSyVAh1vXqWQMX58aWPk9G/130tF4oOUmbP6sojD1QdCfE10IJ4o1CVyTFaWjYE1okxoLR+At0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlC6DsUu; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e1fa2ff499so28919201fa.0
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 14:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714945819; x=1715550619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCWLAJbnUaxV/Z6Hiji+C4R39e1aKsYSWGQ4dlGGzPQ=;
        b=RlC6DsUumoKjY/Ax22AfXK6g4wZedjD32rWlhFBrkM6mmy5Aj9M/SRlrslSLxVSpA6
         DOUh4DOZzUOAshjCNMeF+spvAMv19wZ7hJ2L4GYAtmdzH+rMbScg+Vpr6fpGgc7xwjUV
         kWRZhIgvdfWpo7Z8zmTY8/OiynpV0DCXCBjCFHY51ueNfbOMzy3kME33Q4/QUdgxLcCW
         D4Em55Mezr/8u9uaFCkmuEr2MfZcAAOv5SL0Lae2FfXvAANkMwwvIvsIF/jl4C60ILN/
         eMRvdnsEDGE4bLNRuL1oZsGUwlPXGSHNk4P0stfmgr2VW3sMUV3bxYTFsD6iYhtTM/SZ
         MZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714945819; x=1715550619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCWLAJbnUaxV/Z6Hiji+C4R39e1aKsYSWGQ4dlGGzPQ=;
        b=Cxs4DfM2zCOQC4ZZ5pXT4XuZcysxptowgP/Ys/PfK5LxUGJOeMw/OfpJlutlVMhUIv
         NRZVeD3aesdZqUbDx2er8QEGIyL/70EcOe8/27Ai7L+SwAGw1qulvDFkaWJ8d+JxpUoQ
         RK/TrPBG4smWZwFkK0UyzpUjxclJ1+xAaOGS44pInjcr8V2Umg2LHlfiWaOvtoz4YWQF
         a3g81JTnrmlFLNWTmiYQgpUEm6QQfHU/o5Qgivcb89w+dF27FOEwjCKBcJHZEcYtAwHZ
         X2+aC+p2Hj05OavNdwga9OUgPjzoDy2tEmCgRIyvyOEUP7h94U5dZwOqyF/0QhKRqhDp
         JoMw==
X-Forwarded-Encrypted: i=1; AJvYcCVpGhPCMn1s8cGADZljYL/TlxK3pj1mAhuFaeIOvm+Raw7NDkzB/fRmmKt6zd0WWqU701FaIIgPtFe/aR7+BHUafCdJD7es
X-Gm-Message-State: AOJu0Yy5hnvc6wsr1wEzlAVdLVaFLen1dQjg7bO22fFsSu2vlFki6TBM
	9pFewWYglVE2cVjxqy7MtqeSGXcCRlwHDq180ukdB9D8cnEDbUy/SM8i+A==
X-Google-Smtp-Source: AGHT+IEW19ck+gO3PmtWR5YC9NzzNad/TQ1LOYq+/DT6MPQArfs8+hRsKyiVbauts8CnzaGM+J/mDA==
X-Received: by 2002:a05:651c:10a2:b0:2e1:a40b:af28 with SMTP id k2-20020a05651c10a200b002e1a40baf28mr2496909ljn.18.1714945818271;
        Sun, 05 May 2024 14:50:18 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id z17-20020a2e3511000000b002ddd2680c8dsm1315792ljz.132.2024.05.05.14.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 14:50:17 -0700 (PDT)
Date: Mon, 6 May 2024 00:50:14 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <dcsn7kixduijizlmkhm4jmzevc6dt46gl33orh3z2ohu6otbz2@zlkx3vyvlsur>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>

On Thu, Apr 25, 2024 at 09:11:36PM +0800, Yanteng Si wrote:
> There are two types of Loongson DWGMAC. The first type shares the same

s/Loongson DWGMAC/Loongson GNET controllers

> register definitions and has similar logic as dwmac1000. The second type
> uses several different register definitions, we think it is necessary to
> distinguish rx and tx, so we split these bits into two.

s/rx/Rx
s/tx/Tx

> 
> Simply put, we split some single bit fields into double bits fileds:
> 
>      Name              Tx          Rx
> 
> DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
> DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
> DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
> DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
> DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
> 
> Therefore, when using, TX and RX must be set at the same time.
> 
> How to use them:
>  1. Create the Loongson GNET-specific
>  stmmac_dma_ops.dma_interrupt()
>  stmmac_dma_ops.init_chan()
>  methods in the dwmac-loongson.c driver. Adding all the
>  Loongson-specific macros
> 
>  2. Create a Loongson GNET-specific platform setup method with the next
>  semantics:
>     + allocate stmmac_dma_ops instance and initialize it with
>       dwmac1000_dma_ops.
>     + override the stmmac_dma_ops.{dma_interrupt, init_chan} with
>       the pointers to the methods defined in 2.
>     + allocate mac_device_info instance and initialize the
>       mac_device_info.dma field with a pointer to the new
>       stmmac_dma_ops instance.
>     + initialize mac_device_info in a way it's done in
>       dwmac1000_setup().
> 
>  3. Initialize plat_stmmacenet_data.setup() with the pointer to the
>  method created in 2.
> 
> GNET features:
> 
>  Speeds: 10/100/1000Mbps
>  DMA-descriptors type: enhanced
>  L3/L4 filters availability: support
>  VLAN hash table filter: support
>  PHY-interface: GMII
>  Remote Wake-up support: support
>  Mac Management Counters (MMC): support
>  Number of additional MAC addresses: 5
>  MAC Hash-based filter: support
>  Number of ash table size: 256
>  DMA chennel number: 0x10 device is 8 and 0x37 device is 1
> 
> Others:
> 
>  GNET integrates both MAC and PHY chips inside.
>  GNET device: LS2K2000, LS7A2000, the chip connection between the mac and
>              phy of these devices is not normal and requires two rounds of
>              negotiation; LS7A2000 does not support half-duplex and
>              multi-channel;
> 
>              To enable multi-channel on LS2K2000, you need to turn off
>              hardware checksum.
> 
> **Note**: Currently, only the LS2K2000's synopsys_id is 0x10, while the
> synopsys_id of other devices are 0x37.

The entire commit log looks as a set of information and doesn't
explicitly explain what is going on in the patch body. Let's make it a
bit more coherent:

"Aside with the Loongson GMAC controllers which can be normally found
on the LS2K1000 SoC and LS7A1000 chipset, Loongson released a new
version of the network controllers called Loongson GNET. It has
been synthesized into the new generation LS2K2000 SoC and LS7A2000
chipset with the next DW GMAC features enabled:

  DW GMAC IP-core: v3.73a
  Speeds: 10/100/1000Mbps
  Duplex: Full (both versions), Half (LS2K2000 SoC only)
  DMA-descriptors type: enhanced
  L3/L4 filters availability: Y
  VLAN hash table filter: Y
  PHY-interface: GMII (PHY is integrated into the chips)
  Remote Wake-up support: Y
  Mac Management Counters (MMC): Y
  Number of additional MAC addresses: 5
  MAC Hash-based filter: Y
  Hash Table Size: 256
  AV feature: Y (LS2K2000 SoC only)
  DMA channels: 8 (LS2K2000 SoC), 1 (LS7A2000 chipset)

The integrated PHY has a weird problem with switching from the low
speeds to 1000Mbps mode. The speedup procedure requires the PHY-link
re-negotiation. Besides the LS2K2000 GNET controller the next
peculiarities:
1. Split up Tx and Rx DMA IRQ status/mask bits:
       Name              Tx          Rx
  DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
  DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
  DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
  DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
  DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
2. Custom Synopsys ID hardwired into the GMAC_VERSION.SNPSVER field.
It's 0x10 while it should have been 0x37 in accordance with the actual
DW GMAC IP-core version.

Thus in order to have the Loongson GNET controllers supported let's
modify the Loongson DWMAC driver in accordance with all the
peculiarities described above:

1. Create the Loongson GNET-specific
   stmmac_dma_ops::dma_interrupt()
   stmmac_dma_ops::init_chan()
   callbacks due to the non-standard DMA IRQ CSR flags layout.
2. Create the Loongson GNET-specific platform setup() method which
gets to initialize the DMA-ops with the dwmac1000_dma_ops instance
and overrides the callbacks described in 1, and overrides the custom
Synopsys ID with the real one in order to have the rest of the
HW-specific callbacks correctly detected by the driver core.
3. Make sure the Loongson GNET-specific platform setup() method
enables the duplex modes supported by the controller.
4. Provide the plat_stmmacenet_data::fix_mac_speed() callback which
will restart the link Auto-negotiation in case of the speed change."


See, you don't need to mention the 0x10 ID all the time. Just once and
in the place where it's actually relevant.

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 381 +++++++++++++++++-
>  2 files changed, 371 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index 9cd62b2110a1..aed6ae80cc7c 100644
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
> index a16bba389417..68de90c44feb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -8,9 +8,71 @@
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
>  #define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13

> +#define LOONGSON_DWMAC_CORE_1_00	0x10	/* Loongson custom IP */

What about using the name like calling as:
+#define DWMAC_CORE_LS2K2000		0x10
Thus you'll have the name similar to the rest of the DWMAC_CORE_*
macros and which would emphasize what the device for which the custom
ID is specific.

> +#define CHANNEL_NUM			8
> +
> +struct loongson_data {

> +	u32 gmac_verion;

Let's call it loongson_id thus referring to the
stmmac_priv::synopsys_id field.

> +	struct device *dev;
> +};
>  
>  struct stmmac_pci_info {
>  	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
> @@ -69,6 +131,168 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>  	.setup = loongson_gmac_data,
>  };
>  
> +static void loongson_gnet_dma_init_channel(struct stmmac_priv *priv,
> +					   void __iomem *ioaddr,
> +					   struct stmmac_dma_cfg *dma_cfg,
> +					   u32 chan)
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
> +static int loongson_gnet_dma_interrupt(struct stmmac_priv *priv,
> +				       void __iomem *ioaddr,
> +				       struct stmmac_extra_stats *x,
> +				       u32 chan, u32 dir)
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

> +	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */

0x7ffff != CSR5[15-0]

> +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
> +
> +	return ret;
> +}
> +
> +static void loongson_gnet_fix_speed(void *priv, unsigned int speed,
> +				    unsigned int mode)
> +{
> +	struct loongson_data *ld = (struct loongson_data *)priv;
> +	struct net_device *ndev = dev_get_drvdata(ld->dev);
> +	struct stmmac_priv *ptr = netdev_priv(ndev);
> +

> +	/* The controller and PHY don't work well together.
> +	 * We need to use the PS bit to check if the controller's status
> +	 * is correct and reset PHY if necessary.

This doesn't correspond to what you're actually doing. Please align
the comment with what is done below (if what I provided in the commit
log regarding this problem is correct, use the description here).

> +	 * MAC_CTRL_REG.15 is defined by the GMAC_CONTROL_PS macro.

useless. please drop

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
> +	loongson_default_data(pdev, plat);
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
>  static int loongson_dwmac_config_legacy(struct pci_dev *pdev,
>  					struct plat_stmmacenet_data *plat,
>  					struct stmmac_resources *res,
> @@ -101,12 +325,126 @@ static int loongson_dwmac_config_legacy(struct pci_dev *pdev,
>  	return 0;
>  }
>  
> +static int loongson_dwmac_config_msi(struct pci_dev *pdev,
> +				     struct plat_stmmacenet_data *plat,
> +				     struct stmmac_resources *res,
> +				     struct device_node *np)
> +{
> +	int i, ret, vecs;
> +
> +	vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> +	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> +	if (ret < 0) {
> +		dev_info(&pdev->dev,
> +			 "MSI enable failed, Fallback to legacy interrupt\n");
> +		return loongson_dwmac_config_legacy(pdev, plat, res, np);
> +	}
> +
> +	res->irq = pci_irq_vector(pdev, 0);
> +	res->wol_irq = 0;
> +
> +	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> +	 * --------- ----- -------- --------  ...  -------- --------
> +	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> +	 */
> +	for (i = 0; i < CHANNEL_NUM; i++) {
> +		res->rx_irq[CHANNEL_NUM - 1 - i] =
> +			pci_irq_vector(pdev, 1 + i * 2);
> +		res->tx_irq[CHANNEL_NUM - 1 - i] =
> +			pci_irq_vector(pdev, 2 + i * 2);
> +	}
> +
> +	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> +
> +	return 0;
> +}
> +
> +static struct mac_device_info *loongson_dwmac_setup(void *apriv)
> +{
> +	struct stmmac_priv *priv = apriv;

> +	struct mac_device_info *mac;

seems unused. See my next comment.

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

I see you no longer override the ops in dwmac1000_ops. If so this can
be dropped.

> +
> +	dma = devm_kzalloc(priv->device, sizeof(*dma), GFP_KERNEL);
> +	if (!dma)
> +		return NULL;
> +
> +	/* The original IP-core version is 0x37 in all Loongson GNET

s/0x37/v3.73a

> +	 * (ls2k2000 and ls7a2000), but the GNET HW designers have changed the
> +	 * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the Loongson
> +	 * ls2k2000 MAC to emphasize the differences: multiple DMA-channels,

s/ls2k2000/LS2K2000
s/ls7a2000/LS7A2000

> +	 * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
> +	 * original value so the correct HW-interface would be selected.
> +	 */
> +	if (ld->gmac_verion == LOONGSON_DWMAC_CORE_1_00) {
> +		priv->synopsys_id = DWMAC_CORE_3_70;
> +		*dma = dwmac1000_dma_ops;
> +		dma->init_chan = loongson_gnet_dma_init_channel;
> +		dma->dma_interrupt = loongson_gnet_dma_interrupt;
> +		mac->dma = dma;
> +	}
> +

> +	mac->mac = &dwmac1000_ops;

Unused?

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

> +	/* The GMAC devices with PCI ID 0x7a03 does not support any pause mode.
> +	 * The GNET devices without CORE ID 0x10 does not support half-duplex.
> +	 */

No need to mention the IDs but just the actual devices:
	/* Loongson GMAC doesn't support the flow control. LS2K2000
	 * GNET doesn't support the half-duplex link mode.
	 */

> +	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC) {
> +		mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
> +	} else {
> +		if (ld->gmac_verion == LOONGSON_DWMAC_CORE_1_00)
> +			mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +					 MAC_10 | MAC_100 | MAC_1000;
> +		else
> +			mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +					 MAC_10FD | MAC_100FD | MAC_1000FD;
> +	}
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
>  static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct plat_stmmacenet_data *plat;
>  	int ret, i, bus_id, phy_mode;
>  	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
> +	struct loongson_data *ld;
>  	struct device_node *np;
>  
>  	np = dev_of_node(&pdev->dev);
> @@ -122,10 +460,12 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		return -ENOMEM;
>  

>  	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
> -	if (!plat->dma_cfg) {
> -		ret = -ENOMEM;
> -		goto err_put_node;
> -	}
> +	if (!plat->dma_cfg)
> +		return -ENOMEM;

This change must have been introduced in the patch
[PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
which moves the mdio_node pointer initialization to under the if-clause.

> +
> +	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> +	if (!ld)
> +		return -ENOMEM;
>  
>  	/* Enable pci device */
>  	ret = pci_enable_device(pdev);
> @@ -171,14 +511,34 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		plat->phy_interface = phy_mode;
>  	}
>  

> -	pci_enable_msi(pdev);

Hm, this must be justified and better being done in a separate patch.

> +	plat->bsp_priv = ld;
> +	plat->setup = loongson_dwmac_setup;
> +	ld->dev = &pdev->dev;
> +
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
> +	ld->gmac_verion = readl(res.addr + GMAC_VERSION) & 0xff;
> +
> +	switch (ld->gmac_verion) {
> +	case LOONGSON_DWMAC_CORE_1_00:

> +		plat->rx_queues_to_use = CHANNEL_NUM;
> +		plat->tx_queues_to_use = CHANNEL_NUM;
> +
> +		/* Only channel 0 supports checksum,
> +		 * so turn off checksum to enable multiple channels.
> +		 */
> +		for (i = 1; i < CHANNEL_NUM; i++)
> +			plat->tx_queues_cfg[i].coe_unsupported = 1;
>  
> -	plat->tx_queues_to_use = 1;
> -	plat->rx_queues_to_use = 1;
> +		ret = loongson_dwmac_config_msi(pdev, plat, &res, np);
> +		break;
> +	default:	/* 0x35 device and 0x37 device. */
> +		plat->tx_queues_to_use = 1;
> +		plat->rx_queues_to_use = 1;
>  

Move the NoF queues (and coe flag) initializations to the respective
loongson_*_data() methods.

Besides I don't see you freeing the IRQ vectors allocated in the
loongson_dwmac_config_msi() method neither in probe(), nor in remove()
functions. That's definitely wrong. What you need is to have a
method antagonistic to loongson_dwmac_config_msi() (like
loongson_dwmac_clear_msi()) which would execute the cleanup procedure.

> -	ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> +		ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
> +		break;
> +	}
>  
>  	/* GNET devices with dev revision 0x00 do not support manually
>  	 * setting the speed to 1000.
> @@ -189,12 +549,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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

Once again. Justify the change. Moreover I don't see you dropping the
pci_disable_msi() from the remove() method.

-Serge(y)

>  err_disable_device:
>  	pci_disable_device(pdev);
>  err_put_node:
> @@ -262,6 +620,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
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

