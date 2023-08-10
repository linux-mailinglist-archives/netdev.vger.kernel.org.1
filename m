Return-Path: <netdev+bounces-26458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF3B777E04
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD151C21658
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC7F20F94;
	Thu, 10 Aug 2023 16:21:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B4E1E1D2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88910C43395;
	Thu, 10 Aug 2023 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691684475;
	bh=wg+muEbAujbbh2zXEVrmvAEGXX2IY9xlbeZCgjf7UGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSGYTStsitdriIpN4kdKLnkJcGo4quBuINyYRroCoy6YF+BVm5FbF9U/kci+GVKmC
	 V8zxoYzJ/0fj0/0JR7+gP4wZFD4iSGmBUs0U3sl3HIc+7Yz3s7vORWSkpq32OeoAd0
	 Ro4IfgNTLwCKZh1MvZ9fpti7RLw3jntgo8i5DSH8mWOqG/G0u+lfpoX9OGu+QPP6xA
	 zE0K+dPsbWvS/gAWN76XebdzQD2dvJwy6fjEcJ3KFytEh0ypL1WkDBia9ZYfHM49Tl
	 QiCyz0l2LgqHbXH56K91KPhblXV0zEDH9uK1DjMEt1pJvzsFw81eeCEkPlFfzHav0x
	 LcxHnaVgL7LHA==
Date: Fri, 11 Aug 2023 00:09:32 +0800
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
Subject: Re: [PATCH net-next v3 10/10] net: stmmac: platform: support parsing
 per channel irq from DT
Message-ID: <ZNULvNhWbRyOUDci@xhacker>
References: <20230809165007.1439-1-jszhang@kernel.org>
 <20230809165007.1439-11-jszhang@kernel.org>
 <43ea0060-ed69-4efe-4a39-224aa67ae9b8@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43ea0060-ed69-4efe-4a39-224aa67ae9b8@foss.st.com>

On Thu, Aug 10, 2023 at 04:57:00PM +0200, Alexandre TORGUE wrote:
> On 8/9/23 18:50, Jisheng Zhang wrote:
> > The snps dwmac IP may support per channel interrupt. Add support to
> > parse the per channel irq from DT.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++----
> >   .../ethernet/stmicro/stmmac/stmmac_platform.c | 23 +++++++++++++++++++
> >   2 files changed, 29 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 4ed5c976c7a3..245eeb7d3e83 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -3612,7 +3612,7 @@ static int stmmac_request_irq_multi(struct net_device *dev)
> >   	for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
> >   		if (i >= MTL_MAX_RX_QUEUES)
> >   			break;
> > -		if (priv->rx_irq[i] == 0)
> > +		if (priv->rx_irq[i] <= 0)
> 
> What do you fix here ?

No bug to fix, but adjust for parsing optional channel irqs from DT:
rx_irq[i] and tx_irq[i] may come from platform_get_irq_byname_optional()
so for !STMMAC_FLAG_PERCH_IRQ_EN platforms, they can be < 0. Before

Thanks
> 
> >   			continue;
> >   		int_name = priv->int_name_rx_irq[i];
> > @@ -3637,7 +3637,7 @@ static int stmmac_request_irq_multi(struct net_device *dev)
> >   	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
> >   		if (i >= MTL_MAX_TX_QUEUES)
> >   			break;
> > -		if (priv->tx_irq[i] == 0)
> > +		if (priv->tx_irq[i] <= 0)
> 
> same here
> >   			continue;
> >   		int_name = priv->int_name_tx_irq[i];
> > @@ -7278,8 +7278,10 @@ int stmmac_dvr_probe(struct device *device,
> >   	priv->plat = plat_dat;
> >   	priv->ioaddr = res->addr;
> >   	priv->dev->base_addr = (unsigned long)res->addr;
> > -	priv->plat->dma_cfg->perch_irq_en =
> > -		(priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN);
> > +	if (res->rx_irq[0] > 0 && res->tx_irq[0] > 0) {
> > +		priv->plat->flags |= STMMAC_FLAG_PERCH_IRQ_EN;
> > +		priv->plat->dma_cfg->perch_irq_en = true;
> > +	}
> >   	priv->dev->irq = res->irq;
> >   	priv->wol_irq = res->wol_irq;
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index 29145682b57b..9b46775b41ab 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -705,6 +705,9 @@ EXPORT_SYMBOL_GPL(stmmac_remove_config_dt);
> >   int stmmac_get_platform_resources(struct platform_device *pdev,
> >   				  struct stmmac_resources *stmmac_res)
> >   {
> > +	char irq_name[8];
> > +	int i;
> > +
> >   	memset(stmmac_res, 0, sizeof(*stmmac_res));
> >   	/* Get IRQ information early to have an ability to ask for deferred
> > @@ -738,6 +741,26 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
> >   		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
> >   	}
> > +	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
> > +		snprintf(irq_name, sizeof(irq_name), "rx%i", i);
> > +		stmmac_res->rx_irq[i] = platform_get_irq_byname_optional(pdev, irq_name);
> > +		if (stmmac_res->rx_irq[i] < 0) {
> > +			if (stmmac_res->rx_irq[i] == -EPROBE_DEFER)
> > +				return -EPROBE_DEFER;
> > +			break;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
> > +		snprintf(irq_name, sizeof(irq_name), "tx%i", i);
> > +		stmmac_res->tx_irq[i] = platform_get_irq_byname_optional(pdev, irq_name);
> > +		if (stmmac_res->tx_irq[i] < 0) {
> > +			if (stmmac_res->tx_irq[i] == -EPROBE_DEFER)
> > +				return -EPROBE_DEFER;
> > +			break;
> > +		}
> > +	}
> > +
> >   	stmmac_res->sfty_ce_irq = platform_get_irq_byname_optional(pdev, "sfty_ce");
> >   	if (stmmac_res->sfty_ce_irq < 0) {
> >   		if (stmmac_res->sfty_ce_irq == -EPROBE_DEFER)
> 

