Return-Path: <netdev+bounces-25614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C103774EAA
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F1D280C21
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D653171B8;
	Tue,  8 Aug 2023 22:48:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B516154B6
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EE7C433C7;
	Tue,  8 Aug 2023 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691534934;
	bh=YiBtVFQUNG8GVyERTFX35x1DFW/bnSp8S24/0nVDADU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lPUBCFyLunCojxi/KiHqmoqVrukLhYgZEz1ef1kae+KVInb+8aoBjEEhfgHX6ZEFD
	 tdlzNNjwR3zI6oxm0BTfzEumakEFdrLOOeJmHmsyR87kbOcRxykEm50NpXkkfqb/dy
	 FlvLUZKPCyS4REUbO8kgVU2AmFioGmODnnaBrGbjrq+HfJGUuPl8q321x4nSINsQll
	 snAmEd/KDGcmvZqR/gUwN7XNf1HOALUO8NAZmIpV7hRZm5ypX4kZnp6WflGVWJFqm2
	 BnNx0u20xW3J8S1QSS3UNJ4pvK40WlZS+5zb0aM3bGcz01AH0k2iTpUR3Nt8cdm5B3
	 aYh2wWKc/Jj9w==
Date: Tue, 8 Aug 2023 15:48:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: <vkoul@kernel.org>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <michal.simek@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <linux@armlinux.org.uk>, <dmaengine@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <git@amd.com>
Subject: Re: [PATCH net-next v5 10/10] net: axienet: Introduce dmaengine
 support
Message-ID: <20230808154853.0fafa7fc@kernel.org>
In-Reply-To: <1691387509-2113129-11-git-send-email-radhey.shyam.pandey@amd.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
	<1691387509-2113129-11-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Aug 2023 11:21:49 +0530 Radhey Shyam Pandey wrote:
> +struct axi_skbuff {
> +	struct scatterlist sgl[MAX_SKB_FRAGS + 1];
> +	struct dma_async_tx_descriptor *desc;
> +	dma_addr_t dma_address;
> +	struct sk_buff *skb;
> +	struct list_head lh;
> +	int sg_len;
> +} __packed;

Why __packed?

> +static netdev_tx_t
> +axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct dma_async_tx_descriptor *dma_tx_desc = NULL;
> +	struct axienet_local *lp = netdev_priv(ndev);
> +	u32 app[DMA_NUM_APP_WORDS] = {0};
> +	struct axi_skbuff *axi_skb;
> +	u32 csum_start_off;
> +	u32 csum_index_off;
> +	int sg_len;
> +	int ret;
> +
> +	sg_len = skb_shinfo(skb)->nr_frags + 1;
> +	axi_skb = kmem_cache_zalloc(lp->skb_cache, GFP_KERNEL);
> +	if (!axi_skb)
> +		return NETDEV_TX_BUSY;

Drop on error, you're not stopping the queue correctly, just drop,
return OK and avoid bugs.

> +static inline int axienet_init_dmaengine(struct net_device *ndev)

Why inline? Please remove the spurious inline annotations.

> +{
> +	struct axienet_local *lp = netdev_priv(ndev);
> +	int i, ret;
> +
> +	lp->tx_chan = dma_request_chan(lp->dev, "tx_chan0");
> +	if (IS_ERR(lp->tx_chan)) {
> +		ret = PTR_ERR(lp->tx_chan);
> +		return dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX) channel found\n");
> +	}
> +
> +	lp->rx_chan = dma_request_chan(lp->dev, "rx_chan0");
> +	if (IS_ERR(lp->rx_chan)) {
> +		ret = PTR_ERR(lp->rx_chan);
> +		dev_err_probe(lp->dev, ret, "No Ethernet DMA (RX) channel found\n");
> +		goto err_dma_request_rx;

name labels after the target, not the source. Makes it a ton easier 
to maintain sanity when changing the code later.

> +	}
> +
> +	lp->skb_cache = kmem_cache_create("ethernet", sizeof(struct axi_skbuff),
> +					  0, 0, NULL);

Why create a cache ?
Isn't it cleaner to create a fake ring buffer of sgl? Most packets will
not have MAX_SKB_FRAGS of memory. On a ring buffer you can use only as
many sg entries as the packet requires. Also no need to alloc/free.

> +	if (!lp->skb_cache) {
> +		ret =  -ENOMEM;

double space, please fix everywhere

> +		goto err_kmem;

> @@ -2140,6 +2432,31 @@ static int axienet_probe(struct platform_device *pdev)
>  		}
>  		netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
>  		netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
> +	} else {
> +		struct xilinx_vdma_config cfg;
> +		struct dma_chan *tx_chan;
> +
> +		lp->eth_irq = platform_get_irq_optional(pdev, 0);

This can't fail?

> +		tx_chan = dma_request_chan(lp->dev, "tx_chan0");
> +
> +		if (IS_ERR(tx_chan)) {

no empty lines between call and its error check, please fix thru out

> +			ret = PTR_ERR(tx_chan);
> +			dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX) channel found\n");
> +			goto cleanup_clk;
> +		}
-- 
pw-bot: cr

