Return-Path: <netdev+bounces-69206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D0384A1EF
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 19:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A533B2857BA
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FE5481AC;
	Mon,  5 Feb 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRaY28Bk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8679A481CC
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157031; cv=none; b=WfYsYX/kt/p3Jf3uuYZfWDievcVoL3enk/Yf+aeROe5ZocBzyex6YEE2fUnFjIU21RfZ9p58JH6n3Gm35tyFTiji39ASR94Ea4K0crrfDbx5DnPr5OU1BaOAGUkMwPTMe2ILUDVL8oT8baKBsGROIraJsw35z7ofXQovjkvTO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157031; c=relaxed/simple;
	bh=31fXBEzih1haEBrlPJ0+Hb6SlrAUzaBXdC00zCIvrTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2iNTOjscITexhk9qCUJ72grtWZqALhnGZXkiWV3kjCkuq0Wc+SHX8hEc61YzszK9450gfD6dhlSnz/pCewGP8Yo9ygiBoK19z88mub5XwF8EmlSVGWzuPiI6i5YFGhiYavTtxz7U6ohDs/9GIOj1PhQfWS+bcHKo2+nNIc7o6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRaY28Bk; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d08d34ce3dso31037201fa.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 10:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707157027; x=1707761827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KhJScFVR4FQNq408Z6GTxgkNo/xSodNdEGRHDyTXl4Y=;
        b=QRaY28BkZg+gNcybgibh3QkjfgsR4ub0oLkvGzrJG+naw66/GILdulXaHX9+NYdeoT
         yhkQJyXoZygy7KKlm04NoaS9bKsJPMqaHr8QCLPwrA4jEsUtw0+ibBBKa044ck2lobzn
         AZt3LZ+4vlJbJywtzp4MgfR6KlHRCMci/eVVgRa+s2c9R0FX9YVP6IYIA9E7uxhcr+94
         VtOzP0xkFBxHRaTx7jZAMxxMhCdWvgvG85Qq98Z+CyW7wBO6HuqtbOPxGOuPSlSrkoP0
         xOd/SVnw20MM9GebSLNFMhLasSoJw7yUtFV56qcC2Lrm5sNLczcjKgfnMu4cSUqk85Fx
         EI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157027; x=1707761827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhJScFVR4FQNq408Z6GTxgkNo/xSodNdEGRHDyTXl4Y=;
        b=IEYk7Gg2DNdWCZCUg37SN0NE0o9hF0GBL4Zva7BquKxVGboXUB7jD+B2FwT/w24A+J
         htdmLSkVSgOhvGG4srxU1vzhDIUQKcZN0D0B0OO1QDC7bUnXp7DngL2JsBX58xj3ksmy
         fHIepSFLngzwcyp8bzfvvl+r0nW773MQGGH015+5ftXlBPdbl9dFTE+dx0l5DEMYNxfV
         OGgZLnItOjTR2S3zBRglHN/lhyoRhnLO6DHVaQAPepOIV9aMfvRm7eNZCCvfNdvNseze
         wAMrIQ2zebEAbiDEteel5X8CAFOKjJK/n7TYKdzrsPakKLXLx0VC16BAfDTzIZC+8Lpp
         MYbg==
X-Gm-Message-State: AOJu0YwLFo6mHhEIfGRWdmFogCHlefsPSPzxUI6hLuQmzpgbSkUeceE+
	YBT70yYlcyWz6x8mmEyZwH4W8/j2uOuHbHj2qc2m1jZOcSiEvcwM
X-Google-Smtp-Source: AGHT+IGld6JsSVG460A66/okCYVlfBmFW4NdJ/WLgzczr1K2EvNPFXeBnrOWtvOyUVfEI1Mu9fGOXw==
X-Received: by 2002:a05:6512:3682:b0:511:54a6:1cc4 with SMTP id d2-20020a056512368200b0051154a61cc4mr241204lfs.49.1707157027072;
        Mon, 05 Feb 2024 10:17:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXenKatpREsKXLrPS2NKA7o3VhrsF96EJ7WeqX++4eGCrfyfEfHpNoS71VYEAar7l5+kVPkLknh5jPHNI7p5jr8KZwa/6x0FyBc/5kOqQ2iVnxERY8pisfInbbUWQOeCzE/VloK4eJTZRB84+zqsMaV0shxokM0ww/FnJ8uVmGjHr3oD+jvPOOOzczth9IiocMcLykiEMYpN7HLJyG9tSMGjCwWCYnRTD6N0wvD+T4W+Ose3WhHtocJvhOTr/6wGRGv2Bg+R2rorX1SqrsIJ6tNBlSrZ2Kzpm88v8mUxpg8mplmqprHIp2OiVtDLuCN218PHI35MPpCQq23cV2cda0TCT0jkgPkbEpqjpVsGFqP6qp51izFw6LvETZ3ajqjjHRqc4+3aA==
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id o11-20020a056512230b00b0051154ac7267sm24504lfu.25.2024.02.05.10.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:17:06 -0800 (PST)
Date: Mon, 5 Feb 2024 21:17:03 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 05/11] net: stmmac: dwmac-loongson: Add
 Loongson-specific register definitions
Message-ID: <2gemgo5ghmtp3pmbi2mkdh4ll7lfncnkqe7xrr3ke3dhjkjsas@m2mfy5zlsmca>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <e7e265e2d9d2f9d18d4633d037305cef3c5a18ca.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7e265e2d9d2f9d18d4633d037305cef3c5a18ca.1706601050.git.siyanteng@loongson.cn>

On Tue, Jan 30, 2024 at 04:48:17PM +0800, Yanteng Si wrote:
> There are two types of Loongson DWGMAC. The first type shares the same
> register definitions and has similar logic as dwmac1000. The second type
> uses several different register definitions, we think it is necessary to
> distinguish rx and tx, so we split these bits into two.
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
> 1. Create the Loongson GNET-specific
> stmmac_dma_ops.dma_interrupt()
> stmmac_dma_ops.init_chan()
> methods in the dwmac-loongson.c driver. Adding all the
> Loongson-specific macros
> 
> 2. Create a Loongson GNET-specific platform setup method with the next
> semantics:
>    + allocate stmmac_dma_ops instance and initialize it with
>      dwmac1000_dma_ops.
>    + override the stmmac_dma_ops.{dma_interrupt, init_chan} with
>      the pointers to the methods defined in 2.
>    + allocate mac_device_info instance and initialize the
>      mac_device_info.dma field with a pointer to the new
>      stmmac_dma_ops instance.
>    + initialize mac_device_info in a way it's done in
>      dwmac1000_setup().
> 
> 3. Initialize plat_stmmacenet_data.setup() with the pointer to the
> method created in 2.
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 248 ++++++++++++++++++
>  1 file changed, 248 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index e7ce027cc14e..3b3578318cc1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -8,6 +8,193 @@
>  #include <linux/device.h>
>  #include <linux/of_irq.h>
>  #include "stmmac.h"
> +#include "dwmac_dma.h"
> +#include "dwmac1000.h"
> +

> +#define DMA_INTR_ENA_NIE_TX_LOONGSON 0x00040000	/* Normal Loongson Tx Summary */
> +#define DMA_INTR_ENA_NIE_RX_LOONGSON 0x00020000	/* Normal Loongson Rx Summary */
> +#define DMA_INTR_NORMAL_LOONGSON	(DMA_INTR_ENA_NIE_TX_LOONGSON | \
> +			 DMA_INTR_ENA_NIE_RX_LOONGSON | DMA_INTR_ENA_RIE | \
> +			 DMA_INTR_ENA_TIE)
> +
> +#define DMA_INTR_ENA_AIE_TX_LOONGSON 0x00010000	/* Abnormal Loongson Tx Summary */
> +#define DMA_INTR_ENA_AIE_RX_LOONGSON 0x00008000	/* Abnormal Loongson Rx Summary */
> +
> +#define DMA_INTR_ABNORMAL_LOONGSON	(DMA_INTR_ENA_AIE_TX_LOONGSON | \
> +				DMA_INTR_ENA_AIE_RX_LOONGSON | DMA_INTR_ENA_FBE | \
> +				DMA_INTR_ENA_UNE)
> +
> +#define DMA_INTR_DEFAULT_MASK_LOONGSON	(DMA_INTR_NORMAL_LOONGSON | DMA_INTR_ABNORMAL_LOONGSON)
> +
> +#define DMA_STATUS_NIS_TX_LOONGSON	0x00040000	/* Normal Loongson Tx Interrupt Summary */
> +#define DMA_STATUS_NIS_RX_LOONGSON	0x00020000	/* Normal Loongson Rx Interrupt Summary */
> +
> +#define DMA_STATUS_AIS_TX_LOONGSON	0x00010000	/* Abnormal Loongson Tx Interrupt Summary */
> +#define DMA_STATUS_AIS_RX_LOONGSON	0x00008000	/* Abnormal Loongson Rx Interrupt Summary */
> +
> +#define DMA_STATUS_FBI_TX_LOONGSON	0x00002000	/* Fatal Loongson Tx Bus Error Interrupt */
> +#define DMA_STATUS_FBI_RX_LOONGSON	0x00001000	/* Fatal Loongson Rx Bus Error Interrupt */
> +
> +#define DMA_STATUS_MSK_COMMON_LOONGSON		(DMA_STATUS_NIS_TX_LOONGSON | \
> +					 DMA_STATUS_NIS_RX_LOONGSON | DMA_STATUS_AIS_TX_LOONGSON | \
> +					 DMA_STATUS_AIS_RX_LOONGSON | DMA_STATUS_FBI_TX_LOONGSON | \
> +					 DMA_STATUS_FBI_RX_LOONGSON)

Max 80 chars per line please.

> +
> +#define DMA_STATUS_MSK_RX_LOONGSON		(DMA_STATUS_ERI | \
> +					 DMA_STATUS_RWT | \
> +					 DMA_STATUS_RPS | \
> +					 DMA_STATUS_RU | \
> +					 DMA_STATUS_RI | \
> +					 DMA_STATUS_OVF | \
> +					 DMA_STATUS_MSK_COMMON_LOONGSON)
> +
> +#define DMA_STATUS_MSK_TX_LOONGSON		(DMA_STATUS_ETI | \
> +					 DMA_STATUS_UNF | \
> +					 DMA_STATUS_TJT | \
> +					 DMA_STATUS_TU | \
> +					 DMA_STATUS_TPS | \
> +					 DMA_STATUS_TI | \
> +					 DMA_STATUS_MSK_COMMON_LOONGSON)
> +

> +struct loongson_data {
> +	struct device *dev;
> +	u32 lgmac_version;

> +	struct stmmac_dma_ops dwlgmac_dma_ops;

Just figured out we can do without this field being added to the
private data. See my note in the loongson_setup() method.

> +};
> +

> +static void dwlgmac_dma_init_channel(struct stmmac_priv *priv,

The "dwlgmac_" prefix is confusing. There is the DW XLGMAC IP-core for
which the "dwxlgmac_" is more appropriate and "x" is easy to miss
should your version of the prefix is met. Consider changing it to
something like "loongson_gnet_".

> +				     void __iomem *ioaddr,
> +				     struct stmmac_dma_cfg *dma_cfg, u32 chan)
> +{
> +	u32 value;
> +	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
> +	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
> +
> +	/* common channel control register config */
> +	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
> +
> +	/* Set the DMA PBL (Programmable Burst Length) mode.
> +	 *
> +	 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
> +	 * post 3.5 mode bit acts as 8*PBL.
> +	 */
> +	if (dma_cfg->pblx8)
> +		value |= DMA_BUS_MODE_MAXPBL;
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
> +	value |= DMA_BUS_MODE_ATDS;
> +
> +	if (dma_cfg->aal)
> +		value |= DMA_BUS_MODE_AAL;
> +
> +	writel(value, ioaddr + DMA_BUS_MODE);
> +
> +	/* Mask interrupts by writing to CSR7 */
> +	writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr + DMA_INTR_ENA);
> +}
> +

> +static int dwlgmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,

The same note as above.

> +				 struct stmmac_extra_stats *x, u32 chan, u32 dir)
> +{
> +	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[chan];
> +	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
> +	int ret = 0;
> +	/* read the status register (CSR5) */
> +	u32 nor_intr_status;
> +	u32 abnor_intr_status;
> +	u32 fb_intr_status;

Reverse xmas tree please.

> +	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));

Please move the initialization into a separate statement.

> +
> +#ifdef DWMAC_DMA_DEBUG
> +	/* Enable it to monitor DMA rx/tx status in case of critical problems */
> +	pr_debug("%s: [CSR5: 0x%08x]\n", __func__, intr_status);
> +	show_tx_process_state(intr_status);
> +	show_rx_process_state(intr_status);
> +#endif

This will cause a build-error if DWMAC_DMA_DEBUG is defined. Just drop
it.

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
> +
> +		if (unlikely(intr_status & DMA_STATUS_OVF))
> +			x->rx_overflow_irq++;
> +
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
> +		if (unlikely(intr_status & fb_intr_status)) {
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
> +				u64_stats_update_begin(&rxq_stats->syncp);
> +				rxq_stats->rx_normal_irq_n++;
> +				u64_stats_update_end(&rxq_stats->syncp);
> +				ret |= handle_rx;
> +			}
> +		}
> +		if (likely(intr_status & DMA_STATUS_TI)) {
> +			u64_stats_update_begin(&txq_stats->syncp);
> +			txq_stats->tx_normal_irq_n++;
> +			u64_stats_update_end(&txq_stats->syncp);
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
> +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
> +
> +	return ret;
> +}
>  
>  struct stmmac_pci_info {
>  	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
> @@ -121,6 +308,48 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>  	.config = loongson_gmac_config,
>  };
>  

> +static struct mac_device_info *loongson_setup(void *apriv)

Consider using the GNET-specific prefix, like "loongson_gnet_".

> +{
> +	struct stmmac_priv *priv = apriv;
> +	struct mac_device_info *mac;
> +	struct loongson_data *ld;
> +
> +	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
> +	if (!mac)
> +		return NULL;

What about devm_kzalloc()-ing the stmmac_dma_ops instance here and
initializing it as it's done in the probe method? Thus ...

> +
> +	ld = priv->plat->bsp_priv;
> +	mac->dma = &ld->dwlgmac_dma_ops;

... this can be replaced with:

	mac->dma = devm_kzalloc(priv->device, sizeof(*mac->dma), GFP_KERNEL);
	if (!mac->dma)
		return -ENOMEM;

	*mac->dma = dwmac1000_dma_ops;
	mac->dma->init_chan = loongson_gnet_dma_init_channel;
	mac->dma->dma_interrupt = loongson_gnet_dma_interrupt;

> +
> +	/* Pre-initialize the respective "mac" fields as it's done in
> +	 * dwmac1000_setup()
> +	 */
> +	priv->dev->priv_flags |= IFF_UNICAST_FLT;
> +	mac->pcsr = priv->ioaddr;
> +	mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
> +	mac->unicast_filter_entries = priv->plat->unicast_filter_entries;
> +	mac->mcast_bits_log2 = 0;
> +
> +	if (mac->multicast_filter_bins)
> +		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
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
>  static int loongson_dwmac_probe(struct pci_dev *pdev,
>  				const struct pci_device_id *id)
>  {
> @@ -129,6 +358,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>  	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
>  	struct device_node *np;
> +	struct loongson_data *ld;

reverse xmas tree order please.

>  
>  	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>  	if (!plat)
> @@ -145,6 +375,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>  	if (!plat->dma_cfg)
>  		return -ENOMEM;
>  
> +	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> +	if (!ld)
> +		return -ENOMEM;
> +
>  	np = dev_of_node(&pdev->dev);
>  	plat->mdio_node = of_get_child_by_name(np, "mdio");
>  	if (plat->mdio_node) {
> @@ -197,6 +431,20 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>  	if (ret)
>  		goto err_disable_device;
>  
> +	ld->dev = &pdev->dev;

> +	ld->lgmac_version = readl(res.addr + GMAC_VERSION) & 0xff;

AFAICS the lgmac_version is unused in out of the probe() method
context. What about locally defining it?

> +
> +	/* Activate loongson custom ip */

> +	if (ld->lgmac_version < DWMAC_CORE_3_50) {

Please define a new macro for the GNET MAC.

> +		ld->dwlgmac_dma_ops = dwmac1000_dma_ops;
> +		ld->dwlgmac_dma_ops.init_chan = dwlgmac_dma_init_channel;
> +		ld->dwlgmac_dma_ops.dma_interrupt = dwlgmac_dma_interrupt;

See my comment in the loongson_setup() method.

-Serge(y)

> +
> +		plat->setup = loongson_setup;
> +	}
> +
> +	plat->bsp_priv = ld;
> +
>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
>  		goto err_disable_device;
> -- 
> 2.31.4
> 

