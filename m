Return-Path: <netdev+bounces-74527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F6861C22
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 19:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CEF1F22518
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822D881AA8;
	Fri, 23 Feb 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sgurqc+N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF65DDBD
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708714227; cv=none; b=HubpPhjW6b9qYkAJ5qMA+sDt/qCw7o33ityvNbflc3kD4CT3OtlhR01jrweoK9Pw11VgljCe4hqyJdnlYyL4SOOkeMlJCw1pTpgfyvE8u2vJW9+UnsbpyloihFZ7+ZjucSUU50hOcRbOxRL3cSXb0txq0JAGRT6GYMFbnl/naSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708714227; c=relaxed/simple;
	bh=XiP14gzG/2I02VeE1VvhAWLb9K73Q/QKtpMzMEt2seg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/L87symf5jWknCXMXSNFtahtGSKfPGqNYCpuuSuEmP0enf7k1k84GO4EAkz5IkXTIjwd+QVVYQHVTu60cAD6t6h+16BOHM9lJwUkb8zyt1Wzls1VX/lN1oqGAlwy/I+H9eBNQgHRcdYFn2ZB2ZBfJThKHkGB/apfV7k1vyu894=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sgurqc+N; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d23114b19dso15612971fa.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 10:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708714223; x=1709319023; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UVRSd3MJ8eguFQjGtMRyfs0E3EJTZP9qTMQxuTEqBbw=;
        b=Sgurqc+NskQG8Bu0NssZUd1hclq0QJBggBWhkmv6tkRFWMnqaqO9/vlLPoVdI0t3y7
         tUV54D7TmKebgCEsKZIRneTCnVsWVMPk2isvch1DT6LZgoQYAZbMPtLdxnk2uWqayinl
         xBygmKd9J5IowlFy70UNKAE5bl0olifRFv3cEdYCHUmZT/RtAkhjm/h2RjUKc7YT0yER
         /+xoQwuObBR0nEwdf5Fd3bAlT6UM1Un0mGhUzWxqVdn3fuuolCli/yey3PIGH6Lsou85
         nlDZI2LS3DXmhD900X9t/pQLUhskEyecqVIbqsd2e5gh5pQ9Hm/G3IDjkLQ7Tt1lNx/z
         ZSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708714223; x=1709319023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVRSd3MJ8eguFQjGtMRyfs0E3EJTZP9qTMQxuTEqBbw=;
        b=IczwJR4p+3Ptw/92xYdGFrctutXLZqkC60tnGLpfnnK1fK4wsRryvRgHVsbo74tL46
         k4mSx8sa+tYAqsyzCW4Jai9SnacsaXO6mUrcaNlKch6vd0CX99qVZu6gtCgrFUGcQF2X
         SEOKisR1nSkuVYUDxgipNvo4F8D/sdnkR7y3VjD5Ni8NMiRuxEZoa2jKxwUL+SL91M5v
         JKd/raZYNzqKAoVnDTOJhhrOmhkTtJPzBxhsjWmZOtcxIYg4Tr+WJBPW3/2pHE5qiVWp
         449PcbzCSkvvv5cuB6r3Oif1euiPd1zqlOnonkawsG30VQZNyPRuSb+PwJ74n9Wc1xg/
         MgBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7aJn1A8gCfuuP861iVEgGEo1KSIn9uDmLAw+G9ZjuqCY9YPvaPmxupFmcolrLM8BYzj0LGRm6UiQgWLpHjnvMDFmFOsG/
X-Gm-Message-State: AOJu0YzVELlJCJV3aw9Gvr7zBsyQh2AHrHK+fpr/fRpnKph/pCKKGIep
	Bk3xCHmso8W0PqC+KBKm3gMt2r7UWAuJaonPisWy99j8Km4StBTT
X-Google-Smtp-Source: AGHT+IEkPriEKa0kD9duj7nnCo/5lpkS0p/uFBLi+GsFa47h04BDgw3DEoWxsJcd22XemvKfPDv8XQ==
X-Received: by 2002:a05:6512:2242:b0:511:82b5:b484 with SMTP id i2-20020a056512224200b0051182b5b484mr443883lfu.64.1708714222894;
        Fri, 23 Feb 2024 10:50:22 -0800 (PST)
Received: from mobilestation ([95.79.226.168])
        by smtp.gmail.com with ESMTPSA id g15-20020a0565123b8f00b00512d16a68e0sm1138040lfv.120.2024.02.23.10.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 10:50:22 -0800 (PST)
Date: Fri, 23 Feb 2024 21:50:20 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 05/11] net: stmmac: dwmac-loongson: Add
 Loongson-specific register definitions
Message-ID: <elp4xrucwj6yexhbh2huoq4n4n4zrdtdditpdmt5ikfz5hffau@wdpaoabvnfpr>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <e7e265e2d9d2f9d18d4633d037305cef3c5a18ca.1706601050.git.siyanteng@loongson.cn>
 <2gemgo5ghmtp3pmbi2mkdh4ll7lfncnkqe7xrr3ke3dhjkjsas@m2mfy5zlsmca>
 <544951f8-e910-40cd-8cb7-6fafc00f0bf6@loongson.cn>
 <sa5yimnaij2ucthjeouvgjsqmt2o54ye6pd6se5362lycqppvw@vf7rmdhlq6xd>
 <8986e189-2099-4d27-bd7c-d9c098530f1b@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8986e189-2099-4d27-bd7c-d9c098530f1b@loongson.cn>

On Fri, Feb 23, 2024 at 04:16:07PM +0800, Yanteng Si wrote:
> Hi Serge,
> 
> 在 2024/2/22 21:59, Serge Semin 写道:
> > On Thu, Feb 22, 2024 at 09:39:49PM +0800, Yanteng Si wrote:
> > > 在 2024/2/6 02:17, Serge Semin 写道:
> > > > On Tue, Jan 30, 2024 at 04:48:17PM +0800, Yanteng Si wrote:
> > > > > There are two types of Loongson DWGMAC. The first type shares the same
> > > > > register definitions and has similar logic as dwmac1000. The second type
> > > > > uses several different register definitions, we think it is necessary to
> > > > > distinguish rx and tx, so we split these bits into two.
> > > > > 
> > > > > Simply put, we split some single bit fields into double bits fileds:
> > > > > 
> > > > >        Name              Tx          Rx
> > > > > 
> > > > > DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
> > > > > DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
> > > > > DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
> > > > > DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
> > > > > DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
> > > > > 
> > > > > Therefore, when using, TX and RX must be set at the same time.
> > > > > 
> > > > > How to use them:
> > > > > 1. Create the Loongson GNET-specific
> > > > > stmmac_dma_ops.dma_interrupt()
> > > > > stmmac_dma_ops.init_chan()
> > > > > methods in the dwmac-loongson.c driver. Adding all the
> > > > > Loongson-specific macros
> > > > > 
> > > > > 2. Create a Loongson GNET-specific platform setup method with the next
> > > > > semantics:
> > > > >      + allocate stmmac_dma_ops instance and initialize it with
> > > > >        dwmac1000_dma_ops.
> > > > >      + override the stmmac_dma_ops.{dma_interrupt, init_chan} with
> > > > >        the pointers to the methods defined in 2.
> > > > >      + allocate mac_device_info instance and initialize the
> > > > >        mac_device_info.dma field with a pointer to the new
> > > > >        stmmac_dma_ops instance.
> > > > >      + initialize mac_device_info in a way it's done in
> > > > >        dwmac1000_setup().
> > > > > 
> > > > > 3. Initialize plat_stmmacenet_data.setup() with the pointer to the
> > > > > method created in 2.
> > > > > 
> > > > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > > > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > > > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > > > ---
> > > > >    .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 248 ++++++++++++++++++
> > > > >    1 file changed, 248 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > > index e7ce027cc14e..3b3578318cc1 100644
> > > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > > @@ -8,6 +8,193 @@
> > > > >    #include <linux/device.h>
> > > > >    #include <linux/of_irq.h>
> > > > >    #include "stmmac.h"
> > > > > +#include "dwmac_dma.h"
> > > > > +#include "dwmac1000.h"
> > > > > +
> > > > > +#define DMA_INTR_ENA_NIE_TX_LOONGSON 0x00040000	/* Normal Loongson Tx Summary */
> > > > > +#define DMA_INTR_ENA_NIE_RX_LOONGSON 0x00020000	/* Normal Loongson Rx Summary */
> > > > > +#define DMA_INTR_NORMAL_LOONGSON	(DMA_INTR_ENA_NIE_TX_LOONGSON | \
> > > > > +			 DMA_INTR_ENA_NIE_RX_LOONGSON | DMA_INTR_ENA_RIE | \
> > > > > +			 DMA_INTR_ENA_TIE)
> > > > > +
> > > > > +#define DMA_INTR_ENA_AIE_TX_LOONGSON 0x00010000	/* Abnormal Loongson Tx Summary */
> > > > > +#define DMA_INTR_ENA_AIE_RX_LOONGSON 0x00008000	/* Abnormal Loongson Rx Summary */
> > > > > +
> > > > > +#define DMA_INTR_ABNORMAL_LOONGSON	(DMA_INTR_ENA_AIE_TX_LOONGSON | \
> > > > > +				DMA_INTR_ENA_AIE_RX_LOONGSON | DMA_INTR_ENA_FBE | \
> > > > > +				DMA_INTR_ENA_UNE)
> > > > > +
> > > > > +#define DMA_INTR_DEFAULT_MASK_LOONGSON	(DMA_INTR_NORMAL_LOONGSON | DMA_INTR_ABNORMAL_LOONGSON)
> > > > > +
> > > > > +#define DMA_STATUS_NIS_TX_LOONGSON	0x00040000	/* Normal Loongson Tx Interrupt Summary */
> > > > > +#define DMA_STATUS_NIS_RX_LOONGSON	0x00020000	/* Normal Loongson Rx Interrupt Summary */
> > > > > +
> > > > > +#define DMA_STATUS_AIS_TX_LOONGSON	0x00010000	/* Abnormal Loongson Tx Interrupt Summary */
> > > > > +#define DMA_STATUS_AIS_RX_LOONGSON	0x00008000	/* Abnormal Loongson Rx Interrupt Summary */
> > > > > +
> > > > > +#define DMA_STATUS_FBI_TX_LOONGSON	0x00002000	/* Fatal Loongson Tx Bus Error Interrupt */
> > > > > +#define DMA_STATUS_FBI_RX_LOONGSON	0x00001000	/* Fatal Loongson Rx Bus Error Interrupt */
> > > > > +
> > > > > +#define DMA_STATUS_MSK_COMMON_LOONGSON		(DMA_STATUS_NIS_TX_LOONGSON | \
> > > > > +					 DMA_STATUS_NIS_RX_LOONGSON | DMA_STATUS_AIS_TX_LOONGSON | \
> > > > > +					 DMA_STATUS_AIS_RX_LOONGSON | DMA_STATUS_FBI_TX_LOONGSON | \
> > > > > +					 DMA_STATUS_FBI_RX_LOONGSON)
> > > > Max 80 chars per line please.
> > > OK,
> > > > > +
> > > > > +#define DMA_STATUS_MSK_RX_LOONGSON		(DMA_STATUS_ERI | \
> > > > > +					 DMA_STATUS_RWT | \
> > > > > +					 DMA_STATUS_RPS | \
> > > > > +					 DMA_STATUS_RU | \
> > > > > +					 DMA_STATUS_RI | \
> > > > > +					 DMA_STATUS_OVF | \
> > > > > +					 DMA_STATUS_MSK_COMMON_LOONGSON)
> > > > > +
> > > > > +#define DMA_STATUS_MSK_TX_LOONGSON		(DMA_STATUS_ETI | \
> > > > > +					 DMA_STATUS_UNF | \
> > > > > +					 DMA_STATUS_TJT | \
> > > > > +					 DMA_STATUS_TU | \
> > > > > +					 DMA_STATUS_TPS | \
> > > > > +					 DMA_STATUS_TI | \
> > > > > +					 DMA_STATUS_MSK_COMMON_LOONGSON)
> > > > > +
> > > > > +struct loongson_data {
> > > > > +	struct device *dev;
> > > > > +	u32 lgmac_version;
> > > > > +	struct stmmac_dma_ops dwlgmac_dma_ops;
> > > > Just figured out we can do without this field being added to the
> > > > private data. See my note in the loongson_setup() method.
> > > > 
> > > > > +};
> > > > > +
> > > > > +static void dwlgmac_dma_init_channel(struct stmmac_priv *priv,
> > > > The "dwlgmac_" prefix is confusing. There is the DW XLGMAC IP-core for
> > > > which the "dwxlgmac_" is more appropriate and "x" is easy to miss
> > > > should your version of the prefix is met. Consider changing it to
> > > > something like "loongson_gnet_".
> > > OK,
> > > > > +				     void __iomem *ioaddr,
> > > > > +				     struct stmmac_dma_cfg *dma_cfg, u32 chan)
> > > > > +{
> > > > > +	u32 value;
> > > > > +	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
> > > > > +	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
> > > > > +
> > > > > +	/* common channel control register config */
> > > > > +	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
> > > > > +
> > > > > +	/* Set the DMA PBL (Programmable Burst Length) mode.
> > > > > +	 *
> > > > > +	 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
> > > > > +	 * post 3.5 mode bit acts as 8*PBL.
> > > > > +	 */
> > > > > +	if (dma_cfg->pblx8)
> > > > > +		value |= DMA_BUS_MODE_MAXPBL;
> > > > > +	value |= DMA_BUS_MODE_USP;
> > > > > +	value &= ~(DMA_BUS_MODE_PBL_MASK | DMA_BUS_MODE_RPBL_MASK);
> > > > > +	value |= (txpbl << DMA_BUS_MODE_PBL_SHIFT);
> > > > > +	value |= (rxpbl << DMA_BUS_MODE_RPBL_SHIFT);
> > > > > +
> > > > > +	/* Set the Fixed burst mode */
> > > > > +	if (dma_cfg->fixed_burst)
> > > > > +		value |= DMA_BUS_MODE_FB;
> > > > > +
> > > > > +	/* Mixed Burst has no effect when fb is set */
> > > > > +	if (dma_cfg->mixed_burst)
> > > > > +		value |= DMA_BUS_MODE_MB;
> > > > > +
> > > > > +	value |= DMA_BUS_MODE_ATDS;
> > > > > +
> > > > > +	if (dma_cfg->aal)
> > > > > +		value |= DMA_BUS_MODE_AAL;
> > > > > +
> > > > > +	writel(value, ioaddr + DMA_BUS_MODE);
> > > > > +
> > > > > +	/* Mask interrupts by writing to CSR7 */
> > > > > +	writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr + DMA_INTR_ENA);
> > > > > +}
> > > > > +
> > > > > +static int dwlgmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
> > > > The same note as above.
> > > > 
> > > > > +				 struct stmmac_extra_stats *x, u32 chan, u32 dir)
> > > > > +{
> > > > > +	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[chan];
> > > > > +	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
> > > > > +	int ret = 0;
> > > > > +	/* read the status register (CSR5) */
> > > > > +	u32 nor_intr_status;
> > > > > +	u32 abnor_intr_status;
> > > > > +	u32 fb_intr_status;
> > > > Reverse xmas tree please.
> > > > 
> > > > > +	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
> > > > Please move the initialization into a separate statement.
> > > OK,
> > > > > +
> > > > > +#ifdef DWMAC_DMA_DEBUG
> > > > > +	/* Enable it to monitor DMA rx/tx status in case of critical problems */
> > > > > +	pr_debug("%s: [CSR5: 0x%08x]\n", __func__, intr_status);
> > > > > +	show_tx_process_state(intr_status);
> > > > > +	show_rx_process_state(intr_status);
> > > > > +#endif
> > > > This will cause a build-error if DWMAC_DMA_DEBUG is defined. Just drop
> > > > it.
> > > > OK,
> > > > > +
> > > > > +	if (dir == DMA_DIR_RX)
> > > > > +		intr_status &= DMA_STATUS_MSK_RX_LOONGSON;
> > > > > +	else if (dir == DMA_DIR_TX)
> > > > > +		intr_status &= DMA_STATUS_MSK_TX_LOONGSON;
> > > > > +
> > > > > +	nor_intr_status = intr_status & (DMA_STATUS_NIS_TX_LOONGSON |
> > > > > +		DMA_STATUS_NIS_RX_LOONGSON);
> > > > > +	abnor_intr_status = intr_status & (DMA_STATUS_AIS_TX_LOONGSON |
> > > > > +		DMA_STATUS_AIS_RX_LOONGSON);
> > > > > +	fb_intr_status = intr_status & (DMA_STATUS_FBI_TX_LOONGSON |
> > > > > +		DMA_STATUS_FBI_RX_LOONGSON);
> > > > > +
> > > > > +	/* ABNORMAL interrupts */
> > > > > +	if (unlikely(abnor_intr_status)) {
> > > > > +		if (unlikely(intr_status & DMA_STATUS_UNF)) {
> > > > > +			ret = tx_hard_error_bump_tc;
> > > > > +			x->tx_undeflow_irq++;
> > > > > +		}
> > > > > +		if (unlikely(intr_status & DMA_STATUS_TJT))
> > > > > +			x->tx_jabber_irq++;
> > > > > +
> > > > > +		if (unlikely(intr_status & DMA_STATUS_OVF))
> > > > > +			x->rx_overflow_irq++;
> > > > > +
> > > > > +		if (unlikely(intr_status & DMA_STATUS_RU))
> > > > > +			x->rx_buf_unav_irq++;
> > > > > +		if (unlikely(intr_status & DMA_STATUS_RPS))
> > > > > +			x->rx_process_stopped_irq++;
> > > > > +		if (unlikely(intr_status & DMA_STATUS_RWT))
> > > > > +			x->rx_watchdog_irq++;
> > > > > +		if (unlikely(intr_status & DMA_STATUS_ETI))
> > > > > +			x->tx_early_irq++;
> > > > > +		if (unlikely(intr_status & DMA_STATUS_TPS)) {
> > > > > +			x->tx_process_stopped_irq++;
> > > > > +			ret = tx_hard_error;
> > > > > +		}
> > > > > +		if (unlikely(intr_status & fb_intr_status)) {
> > > > > +			x->fatal_bus_error_irq++;
> > > > > +			ret = tx_hard_error;
> > > > > +		}
> > > > > +	}
> > > > > +	/* TX/RX NORMAL interrupts */
> > > > > +	if (likely(nor_intr_status)) {
> > > > > +		if (likely(intr_status & DMA_STATUS_RI)) {
> > > > > +			u32 value = readl(ioaddr + DMA_INTR_ENA);
> > > > > +			/* to schedule NAPI on real RIE event. */
> > > > > +			if (likely(value & DMA_INTR_ENA_RIE)) {
> > > > > +				u64_stats_update_begin(&rxq_stats->syncp);
> > > > > +				rxq_stats->rx_normal_irq_n++;
> > > > > +				u64_stats_update_end(&rxq_stats->syncp);
> > > > > +				ret |= handle_rx;
> > > > > +			}
> > > > > +		}
> > > > > +		if (likely(intr_status & DMA_STATUS_TI)) {
> > > > > +			u64_stats_update_begin(&txq_stats->syncp);
> > > > > +			txq_stats->tx_normal_irq_n++;
> > > > > +			u64_stats_update_end(&txq_stats->syncp);
> > > > > +			ret |= handle_tx;
> > > > > +		}
> > > > > +		if (unlikely(intr_status & DMA_STATUS_ERI))
> > > > > +			x->rx_early_irq++;
> > > > > +	}
> > > > > +	/* Optional hardware blocks, interrupts should be disabled */
> > > > > +	if (unlikely(intr_status &
> > > > > +		     (DMA_STATUS_GPI | DMA_STATUS_GMI | DMA_STATUS_GLI)))
> > > > > +		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
> > > > > +
> > > > > +	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
> > > > > +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > >    struct stmmac_pci_info {
> > > > >    	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
> > > > > @@ -121,6 +308,48 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
> > > > >    	.config = loongson_gmac_config,
> > > > >    };
> > > > > +static struct mac_device_info *loongson_setup(void *apriv)
> > > > Consider using the GNET-specific prefix, like "loongson_gnet_".
> > > > 
> > > > > +{
> > > > > +	struct stmmac_priv *priv = apriv;
> > > > > +	struct mac_device_info *mac;
> > > > > +	struct loongson_data *ld;
> > > > > +
> > > > > +	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
> > > > > +	if (!mac)
> > > > > +		return NULL;
> > > > What about devm_kzalloc()-ing the stmmac_dma_ops instance here and
> > > > initializing it as it's done in the probe method? Thus ...
> > > > 
> > > > > +
> > > > > +	ld = priv->plat->bsp_priv;
> > > > > +	mac->dma = &ld->dwlgmac_dma_ops;
> > > > ... this can be replaced with:
> > > > 
> > > > 	mac->dma = devm_kzalloc(priv->device, sizeof(*mac->dma), GFP_KERNEL);
> > > > 	if (!mac->dma)
> > > > 		return -ENOMEM;
> > > Great, but It seems that we cannot return an int value here.
> > Just
> > 		return NULL;
> OK,
> > then.
> > 
> > > > 	*mac->dma = dwmac1000_dma_ops;
> > > > 	mac->dma->init_chan = loongson_gnet_dma_init_channel;
> > > > 	mac->dma->dma_interrupt = loongson_gnet_dma_interrupt;
> It seems that we still cannot do this because：
> structmac_device_info{
> ...
> conststructstmmac_mmc_ops*mmc;
> ...
> }
> some errors output:
> error: assignment of read-only location '*mac->dma'
> error: assignment of member 'init_chan' in read-only object
> ...

No, we can. Just use a temporary non-const pointer to stmmac_dma_ops:

+static struct mac_device_info *loongson_gnet_setup(void *apriv)
+{
+	struct stmmac_priv *priv = apriv;
+	struct mac_device_info *mac;
+	struct stmmac_dma_ops *dma;
+	struct loongson_data *ld;
+
+	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
+	if (!mac)
+		return NULL;
+
+	dma = devm_kzalloc(priv->device, sizeof(*dma), GFP_KERNEL);
+	if (!mac->dma)
+		return NULL;
+
+	*dma = dwmac1000_dma_ops;
+	dma->init_chan = loongson_gnet_dma_init_channel;
+	dma->dma_interrupt = loongson_gnet_dma_interrupt;
+	mac->dma = dma;
+
+	...

-Serge(y)

> Thanks,
> Yanteng
> > > > 
> > > > > +
> > > > > +	/* Pre-initialize the respective "mac" fields as it's done in
> > > > > +	 * dwmac1000_setup()
> > > > > +	 */
> > > > > +	priv->dev->priv_flags |= IFF_UNICAST_FLT;
> > > > > +	mac->pcsr = priv->ioaddr;
> > > > > +	mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
> > > > > +	mac->unicast_filter_entries = priv->plat->unicast_filter_entries;
> > > > > +	mac->mcast_bits_log2 = 0;
> > > > > +
> > > > > +	if (mac->multicast_filter_bins)
> > > > > +		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
> > > > > +
> > > > > +	mac->link.duplex = GMAC_CONTROL_DM;
> > > > > +	mac->link.speed10 = GMAC_CONTROL_PS;
> > > > > +	mac->link.speed100 = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
> > > > > +	mac->link.speed1000 = 0;
> > > > > +	mac->link.speed_mask = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
> > > > > +	mac->mii.addr = GMAC_MII_ADDR;
> > > > > +	mac->mii.data = GMAC_MII_DATA;
> > > > > +	mac->mii.addr_shift = 11;
> > > > > +	mac->mii.addr_mask = 0x0000F800;
> > > > > +	mac->mii.reg_shift = 6;
> > > > > +	mac->mii.reg_mask = 0x000007C0;
> > > > > +	mac->mii.clk_csr_shift = 2;
> > > > > +	mac->mii.clk_csr_mask = GENMASK(5, 2);
> > > > > +
> > > > > +	return mac;
> > > > > +}
> > > > > +
> > > > >    static int loongson_dwmac_probe(struct pci_dev *pdev,
> > > > >    				const struct pci_device_id *id)
> > > > >    {
> > > > > @@ -129,6 +358,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
> > > > >    	struct stmmac_pci_info *info;
> > > > >    	struct stmmac_resources res;
> > > > >    	struct device_node *np;
> > > > > +	struct loongson_data *ld;
> > > > reverse xmas tree order please.
> > > > 
> > > > >    	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> > > > >    	if (!plat)
> > > > > @@ -145,6 +375,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
> > > > >    	if (!plat->dma_cfg)
> > > > >    		return -ENOMEM;
> > > > > +	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> > > > > +	if (!ld)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > >    	np = dev_of_node(&pdev->dev);
> > > > >    	plat->mdio_node = of_get_child_by_name(np, "mdio");
> > > > >    	if (plat->mdio_node) {
> > > > > @@ -197,6 +431,20 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
> > > > >    	if (ret)
> > > > >    		goto err_disable_device;
> > > > > +	ld->dev = &pdev->dev;
> > > > > +	ld->lgmac_version = readl(res.addr + GMAC_VERSION) & 0xff;
> > > > AFAICS the lgmac_version is unused in out of the probe() method
> > > > context. What about locally defining it?
> > > OK,
> > > > > +
> > > > > +	/* Activate loongson custom ip */
> > > > > +	if (ld->lgmac_version < DWMAC_CORE_3_50) {
> > > > Please define a new macro for the GNET MAC.
> > > OK.
> > > > > +		ld->dwlgmac_dma_ops = dwmac1000_dma_ops;
> > > > > +		ld->dwlgmac_dma_ops.init_chan = dwlgmac_dma_init_channel;
> > > > > +		ld->dwlgmac_dma_ops.dma_interrupt = dwlgmac_dma_interrupt;
> > > > See my comment in the loongson_setup() method.
> > > This will introduce a compilation warning:
> > > 
> > > warning: returning 'int' from a function with return type 'struct
> > > mac_device_info *' makes pointer from integer without a cast
> > > [-Wint-conversion]
> > >    418 |                 return -ENOMEM;
> > stmmac_hwif_init() expects priv->plat->setup(priv) returning NULL
> > if something wrong. As I suggested above just return NULL then if
> > mac_device_info couldn't be allocated.
> > 
> > -Serge(y)
> > 
> > > 
> > > Thanks,
> > > 
> > > Yanteng
> > > 
> > > > -Serge(y)
> > > > 
> > > > > +
> > > > > +		plat->setup = loongson_setup;
> > > > > +	}
> > > > > +
> > > > > +	plat->bsp_priv = ld;
> > > > > +
> > > > >    	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
> > > > >    	if (ret)
> > > > >    		goto err_disable_device;
> > > > > -- 
> > > > > 2.31.4
> > > > > 
> 

