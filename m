Return-Path: <netdev+bounces-22475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA81767972
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3E21C217CC
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7696E380;
	Sat, 29 Jul 2023 00:24:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C17537E
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221CAC433C7;
	Sat, 29 Jul 2023 00:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690590260;
	bh=LcvjFZ5wQlT1R6n8uisvWwenXjdvtew/LYTUALvrObc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k8ANMUwVHZyTxyGa3n7sz2LHzbUGdyjNE/J3IJLU9ml/Zqn6ToTj3nqSMmnWv86HE
	 ljVs22Qb90Bw9NXXmPFj9pNMI0mq0ESXP12HP1NQUg4oNm0oy2FQE11CB0NBNUd0G+
	 OewanG+lTJsH17XqdIOPY6NDhrNj+/bVoLB85cpAdgD1AUB923nedsJMnJtEMBykQS
	 vBKZA7MRLDZpu0nFrKX+91j2/g7V7BH+5Zc5MjXXDr7PLLHcemQwj9NdSemoFJUeOf
	 bNGaOXZewZpKb7A4Mupld1931Itsmi/3gwfgRyJlZkoHY1y7tmMWkfVBXjBJ/f5kgi
	 Bg9wqklNDEBrQ==
Date: Fri, 28 Jul 2023 17:24:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
 Simon Horman <simon.horman@corigine.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>, Richard Cochran
 <richardcochran@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v12 06/10] net: ti: icssg-prueth: Add ICSSG ethernet
 driver
Message-ID: <20230728172419.702b4ac0@kernel.org>
In-Reply-To: <20230727112827.3977534-7-danishanwar@ti.com>
References: <20230727112827.3977534-1-danishanwar@ti.com>
	<20230727112827.3977534-7-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jul 2023 16:58:23 +0530 MD Danish Anwar wrote:
> +static int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
> +				    int budget)
> +{
> +	struct net_device *ndev = emac->ndev;
> +	struct cppi5_host_desc_t *desc_tx;
> +	struct netdev_queue *netif_txq;
> +	struct prueth_tx_chn *tx_chn;
> +	unsigned int total_bytes = 0;
> +	struct sk_buff *skb;
> +	dma_addr_t desc_dma;
> +	int res, num_tx = 0;
> +	void **swdata;
> +
> +	tx_chn = &emac->tx_chns[chn];
> +
> +	while (budget) {
> +		res = k3_udma_glue_pop_tx_chn(tx_chn->tx_chn, &desc_dma);
> +		if (res == -ENODATA)
> +			break;

You shouldn't limit the number of serviced packets to budget for Tx
NAPI.

https://docs.kernel.org/next/networking/napi.html#driver-api

> +	skb->dev = ndev;
> +	if (!netif_running(skb->dev)) {
> +		dev_kfree_skb_any(skb);
> +		return 0;
> +	}

why do you check if the interface is running?
If a packet arrives, it means the interface is running..

> +drop_free_descs:
> +	prueth_xmit_free(tx_chn, first_desc);
> +drop_stop_q:
> +	netif_tx_stop_queue(netif_txq);

Do not stop the queue on DMA errors. If the queue is empty nothing
will wake it up. Queue should only be stopped based on occupancy.

> +	dev_kfree_skb_any(skb);
> +
> +	/* error */
> +	ndev->stats.tx_dropped++;
> +	netdev_err(ndev, "tx: error: %d\n", ret);
> +
> +	return ret;
-- 
pw-bot: cr

