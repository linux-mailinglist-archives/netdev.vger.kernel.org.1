Return-Path: <netdev+bounces-28146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC5E77E5F4
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074A71C2112F
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D377A1641A;
	Wed, 16 Aug 2023 16:04:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A86AC8FF
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90265C433C8;
	Wed, 16 Aug 2023 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692201879;
	bh=4Zp3gWJ/UNXl5LmVpCbTdj3eqr5kWiHHc7k0ReSn3hQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OdpNHr+CytMtoJpZeiAl2Xzi7+pDId7Xfjb/3bZi8Pk+XWouoXSg9a0POUmnKK8gK
	 OcEephfmv973Ybjmgpmuw41k/dYlLPEoZBlRChm34EsmWn2GrifjY+cu6oGNAcj2iL
	 yvl1HfXQFX1oVYxsFaFsda2FVI4l+03j9ERhPGMus+ri/E5ah7C1JLAadr/LTYE6NK
	 r09mWMjaoFOrWOKTgJGMpmiRDwOzOIdg4JCkytUL61ndvuQYLeRJrJZXIYOIuBZw7T
	 ew5tURaBN7HSkAWt7eFw8H8tSWC+0A3uKowil81GNaAOWA5a0ytyeF5GaWTP/fZZyA
	 bVnJ+wQ04434g==
Date: Wed, 16 Aug 2023 23:52:53 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 06/10] net: stmmac: xgmac: support
 per-channel irq
Message-ID: <ZNzw1cqmGQaKpfGi@xhacker>
References: <20230809165007.1439-1-jszhang@kernel.org>
 <20230809165007.1439-7-jszhang@kernel.org>
 <a12b6d39-0e26-7bdc-4207-c767342ebcf6@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a12b6d39-0e26-7bdc-4207-c767342ebcf6@foss.st.com>

On Thu, Aug 10, 2023 at 04:52:01PM +0200, Alexandre TORGUE wrote:
> On 8/9/23 18:50, Jisheng Zhang wrote:
> > The IP supports per channel interrupt, add support for this usage case.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >   .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++
> >   .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 33 +++++++++++--------
> >   2 files changed, 22 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > index 81cbb13a101d..12e1228ccf2a 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > @@ -327,6 +327,8 @@
> >   /* DMA Registers */
> >   #define XGMAC_DMA_MODE			0x00003000
> > +#define XGMAC_INTM			GENMASK(13, 12)
> > +#define XGMAC_INTM_MODE1		0x1
> >   #define XGMAC_SWR			BIT(0)
> >   #define XGMAC_DMA_SYSBUS_MODE		0x00003004
> >   #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > index b5ba4e0cca55..ef25af92d6cc 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > @@ -31,6 +31,13 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
> >   		value |= XGMAC_EAME;
> >   	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > +
> > +	if (dma_cfg->perch_irq_en) {
> > +		value = readl(ioaddr + XGMAC_DMA_MODE);
> > +		value &= ~XGMAC_INTM;
> > +		value |= FIELD_PREP(XGMAC_INTM, XGMAC_INTM_MODE1);
> > +		writel(value, ioaddr + XGMAC_DMA_MODE);
> > +	}
> >   }
> >   static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
> > @@ -365,20 +372,20 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
> >   	}
> >   	/* TX/RX NORMAL interrupts */
> > -	if (likely(intr_status & XGMAC_NIS)) {
> 
> No longer need to check NIS bit ?

Hi Alexandre,

NIS is RI | TI | TBU, since we have checked these three
bits we can ignore NIS. And dwmac4 behaves similarly.

Thanks

> 
> > -		if (likely(intr_status & XGMAC_RI)) {
> > -			u64_stats_update_begin(&rx_q->rxq_stats.syncp);
> > -			rx_q->rxq_stats.rx_normal_irq_n++;
> > -			u64_stats_update_end(&rx_q->rxq_stats.syncp);
> > -			ret |= handle_rx;
> > -		}
> > -		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
> > -			u64_stats_update_begin(&tx_q->txq_stats.syncp);
> > -			tx_q->txq_stats.tx_normal_irq_n++;
> > -			u64_stats_update_end(&tx_q->txq_stats.syncp);
> > -			ret |= handle_tx;
> > -		}
> > +	if (likely(intr_status & XGMAC_RI)) {
> > +		u64_stats_update_begin(&rx_q->rxq_stats.syncp);
> > +		rx_q->rxq_stats.rx_normal_irq_n++;
> > +		u64_stats_update_end(&rx_q->rxq_stats.syncp);
> > +		ret |= handle_rx;
> > +	}
> > +	if (likely(intr_status & XGMAC_TI)) {
> > +		u64_stats_update_begin(&tx_q->txq_stats.syncp);
> > +		tx_q->txq_stats.tx_normal_irq_n++;
> > +		u64_stats_update_end(&tx_q->txq_stats.syncp);
> > +		ret |= handle_tx;
> >   	}
> > +	if (unlikely(intr_status & XGMAC_TBU))
> > +		ret |= handle_tx;
> >   	/* Clear interrupts */
> >   	writel(intr_en & intr_status, ioaddr + XGMAC_DMA_CH_STATUS(chan));
> 

