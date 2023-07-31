Return-Path: <netdev+bounces-22896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBF7769D2C
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37681C208B0
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C31819BC8;
	Mon, 31 Jul 2023 16:52:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE9C8BEE
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 16:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0D0C433C8;
	Mon, 31 Jul 2023 16:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690822321;
	bh=CGzW4Z4n87oXkmDgD3NYNy1uk7m9r4O9fbpQ0K4fcrw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JwP2f6UiI/vu1DP9is9j8UII+ounDJXNS96unDEUTuoypnss/KVF645UcDhKT1oX+
	 MxD72lxig3/MfG2acIqu6QYXzcHTRD5Gu2QeJ6BWlTu+W14gikM9dg20Pvkl4iGC+G
	 Wb3fiR6p4u6l0Lw05mRLbxTf3rRvNlY/kN5F1TO9wnosooHIRdQdF2wn+c9Fk0QW8T
	 sEteJiW0DkcJXo8tJiRf+5rIuQbj1/OEKValoXbf/8RXyTqb50vvXO7t4kezgIE4mw
	 /TrUY9WAxRAxGCdWYmP88TLvkiq7acc2xKsWUdoHC2bewk8jBZdMPE/Ua1P2QOVY4t
	 L2Af9fI3xDQMw==
Date: Mon, 31 Jul 2023 09:51:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Md Danish Anwar <a0501179@ti.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Randy Dunlap
 <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>, Simon Horman
 <simon.horman@corigine.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew
 Lunn <andrew@lunn.ch>, Richard Cochran <richardcochran@gmail.com>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David
 S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v12 06/10] net: ti: icssg-prueth: Add ICSSG ethernet
 driver
Message-ID: <20230731095159.3b7e3b75@kernel.org>
In-Reply-To: <8790da4f-1378-410c-f637-f85ca4d34604@ti.com>
References: <20230727112827.3977534-1-danishanwar@ti.com>
	<20230727112827.3977534-7-danishanwar@ti.com>
	<20230728172419.702b4ac0@kernel.org>
	<8790da4f-1378-410c-f637-f85ca4d34604@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 16:49:59 +0530 Md Danish Anwar wrote:
> There are five error handling cases in xmit().
> 
> 1. DMA Mapping the linear buffer -- If we fail to map dma, we will return
> NETDEV_TX_OK and goto drop_free_skb which will free the skb and drop the packet.
> 
> 2. Allocating descriptor for linear buffer -- If we fail to allocate descriptor
> this means it is a occupancy issue and we will goto drop_stop_q_busy which will
> stop queue and return NETDEV_TX_BUSY.
> 
> 3. Allocating descriptor when skb is fragmented. -- If we fail to allocate
> descriptor when skb is fragmented, we will goto drop_stop_q which will stop the
> queue, free the descriptor, free the skb, drop the packet and return NETDEV_TX_OK.

This one should be BUSY, right? goto free_desc_stop_q_busy

> 4. DMA mapping for fragment. -- If DMA mapping for fragment fails, we will go
> to drop_free_descs which will free the descriptor, free the skb, drop the
> packet and return NETDEV_TX_OK.
> 
> 5. Tx push failed. -- If tx push fails we will goto drop_free_descs which will
> free the descriptor, free the skb, drop the packet and return.
> 
> We will only stop queue in case 2 and 3 where we failed to allocate descriptor.
> In case 1, 4 and 5 we are encountering dma mapping error, so for these cases we
> will not stop the queue.
> 
> Below will be my goto labels.
> 
> drop_stop_q:
> 	netif_tx_stop_queue(netif_txq);
> 
> drop_free_descs:
> 	prueth_xmit_free(tx_chn, first_desc);
> 
> drop_free_skb:
> 	dev_kfree_skb_any(skb);
> 
> 	/* error */
> 	ndev->stats.tx_dropped++;
> 	netdev_err(ndev, "tx: error: %d\n", ret);
> 
> 	return ret;

free_desc_stop_q_busy:
 	prueth_xmit_free(tx_chn, first_desc);
> drop_stop_q_busy:
> 	netif_tx_stop_queue(netif_txq);
> 	return NETDEV_TX_BUSY;

