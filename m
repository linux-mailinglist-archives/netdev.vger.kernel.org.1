Return-Path: <netdev+bounces-208304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B5EB0AD53
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 03:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2A15656AA
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 01:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33599193079;
	Sat, 19 Jul 2025 01:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfPZkFoA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9892E62C;
	Sat, 19 Jul 2025 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752888524; cv=none; b=W/eX3e8mO60Q62xjMB9b9tkAkIvj59nxrgOPBTDu3MGHg1kOiThHlUoaZKHdgdx4bVtK2EpOVzwOAfhiDqEIp03N3Tm6XonY9q7Be76CP1O69+O2P/qvTXjssapsvjKvbe8ZdcCb8nUMPw0A+ume4lH0M/+GcZTHoIrbnTVRI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752888524; c=relaxed/simple;
	bh=Xgk+Vyd7x+6zQrEAnXg5atZzEmalN4PkM8Ip/CYxqwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAdzsmeULWkR7ofedd56wiSJB6DACf5fsn+2dVqZb+tdBKSTRQ+3IwWrDD4Y1P0DaBbouH+KuhR/X8aGs/Fiz9nqNJK1oZybgP3vWMZ+QNykPPfy1N2ie4FTllhqnb+ATAItvKfSMEEAHWNtJIylKg2IZm3rGjykLlb9oHXl8FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfPZkFoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E19C4CEEB;
	Sat, 19 Jul 2025 01:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752888521;
	bh=Xgk+Vyd7x+6zQrEAnXg5atZzEmalN4PkM8Ip/CYxqwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lfPZkFoA3Z24WBBd9MMRnhKZMdp5gnVosdYE8Q/i9PYWIAZzRroRFMzV8QnwfDvt4
	 kz+/Jv8t7a2RGS2sWVjDCYSqG47HmNk6ye1KTrG5zhMf9Ns8LsdwbvDkHU/lW0WM57
	 ATL1F175Bz0rUtgcrTp65YYpio0cbeoRyAO4bv5i88hiGDLdj6D03jGgsyR4L5+/DS
	 kUz8MkJ2autaMOIDVk1fMopa3pRG1uEEUigHlDcnvJioMxW6vhhLTCWYVXyHV5pcWA
	 HURmrr9AXzwN6pqvM/E+SS11bhWPDrvd+ybRm5wGr4PDF/XZUBnCbKGrS8dQUACnRO
	 Va2gPWTaJ+UxA==
Date: Fri, 18 Jul 2025 18:28:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v15 06/12] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20250718182840.7ab7e202@kernel.org>
In-Reply-To: <20250716214731.3384273-7-lukma@denx.de>
References: <20250716214731.3384273-1-lukma@denx.de>
	<20250716214731.3384273-7-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 23:47:25 +0200 Lukasz Majewski wrote:
> +static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
> +					struct net_device *dev, int port)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	unsigned short status;
> +	struct cbd_t *bdp;
> +	void *bufaddr;
> +
> +	spin_lock(&fep->hw_lock);

I see some inconsistencies in how you take this lock.
Bunch of bare spin_lock() calls from BH context, but there's also
a _irqsave() call in mtip_adjust_link(). Please align to the strictest
context (not sure if the irqsave is actually needed, at a glance, IOW
whether the lock is taken from an IRQ)

> +	if (!fep->link[0] && !fep->link[1]) {
> +		/* Link is down or autonegotiation is in progress. */
> +		netif_stop_queue(dev);
> +		spin_unlock(&fep->hw_lock);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	/* Fill in a Tx ring entry */
> +	bdp = fep->cur_tx;
> +
> +	/* Force read memory barier on the current transmit description */

Barrier are between things. What is this barrier separating, and what
write barrier does it pair with? As far as I can tell cur_tx is just
a value in memory, and accesses are under ->hw_lock, so there should
be no ordering concerns.

> +	rmb();
> +	status = bdp->cbd_sc;
> +
> +	if (status & BD_ENET_TX_READY) {
> +		/* All transmit buffers are full. Bail out.
> +		 * This should not happen, since dev->tbusy should be set.
> +		 */
> +		netif_stop_queue(dev);
> +		dev_err(&fep->pdev->dev, "%s: tx queue full!.\n", dev->name);

This needs to be rate limited, we don't want to flood the logs in case
there's a bug.

Also at a glance it seems like you have one fep for multiple netdevs.
So stopping one netdev's Tx queue when fep fills up will not stop the
other ports from pushing frames, right?

> +		spin_unlock(&fep->hw_lock);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	/* Clear all of the status flags */
> +	status &= ~BD_ENET_TX_STATS;
> +
> +	/* Set buffer length and buffer pointer */
> +	bufaddr = skb->data;
> +	bdp->cbd_datlen = skb->len;
> +
> +	/* On some FEC implementations data must be aligned on
> +	 * 4-byte boundaries. Use bounce buffers to copy data
> +	 * and get it aligned.spin
> +	 */
> +	if ((unsigned long)bufaddr & MTIP_ALIGNMENT) {

I think you should add 

	if ... ||
           fep->quirks & FEC_QUIRK_SWAP_FRAME)

here. You can't modify skb->data without calling skb_cow_data()
but you already have buffers allocated so can as well use them.

> +		unsigned int index;
> +
> +		index = bdp - fep->tx_bd_base;
> +		memcpy(fep->tx_bounce[index],
> +		       (void *)skb->data, skb->len);

this fits on one 80 char line BTW, quite easily:

		memcpy(fep->tx_bounce[index], (void *)skb->data, skb->len);

Also the cast to void * is not necessary in C.

> +		bufaddr = fep->tx_bounce[index];
> +	}
> +
> +	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> +		swap_buffer(bufaddr, skb->len);
> +
> +	/* Save skb pointer. */
> +	fep->tx_skbuff[fep->skb_cur] = skb;
> +
> +	fep->skb_cur = (fep->skb_cur + 1) & TX_RING_MOD_MASK;

Not sure if this is buggy, but maybe delay updating things until the
mapping succeeds? Fewer things to unwind.

> +	/* Push the data cache so the CPM does not get stale memory
> +	 * data.
> +	 */
> +	bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, bufaddr,
> +					  MTIP_SWITCH_TX_FRSIZE,
> +					  DMA_TO_DEVICE);
> +	if (unlikely(dma_mapping_error(&fep->pdev->dev, bdp->cbd_bufaddr))) {
> +		dev_err(&fep->pdev->dev,
> +			"Failed to map descriptor tx buffer\n");
> +		dev->stats.tx_errors++;
> +		dev->stats.tx_dropped++;

dropped and errors are two different counters
I'd stick to dropped

> +		dev_kfree_skb_any(skb);
> +		goto err;
> +	}
> +
> +	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
> +	 * it's the last BD of the frame, and to put the CRC on the end.
> +	 */
> +
> +	status |= (BD_ENET_TX_READY | BD_ENET_TX_INTR
> +			| BD_ENET_TX_LAST | BD_ENET_TX_TC);

The | goes at the end of the previous line, start of new line adjusts 
to the opening brackets..

> +
> +	/* Synchronize all descriptor writes */
> +	wmb();
> +	bdp->cbd_sc = status;
> +
> +	netif_trans_update(dev);

Is this call necessary?

> +	skb_tx_timestamp(skb);
> +
> +	/* Trigger transmission start */
> +	writel(MCF_ESW_TDAR_X_DES_ACTIVE, fep->hwp + ESW_TDAR);
> +
> +	dev->stats.tx_bytes += skb->len;
> +	/* If this was the last BD in the ring,
> +	 * start at the beginning again.
> +	 */
> +	if (status & BD_ENET_TX_WRAP)
> +		bdp = fep->tx_bd_base;
> +	else
> +		bdp++;
> +
> +	if (bdp == fep->dirty_tx) {
> +		fep->tx_full = 1;
> +		netif_stop_queue(dev);
> +	}
> +
> +	fep->cur_tx = bdp;
> + err:
> +	spin_unlock(&fep->hw_lock);
> +
> +	return NETDEV_TX_OK;
> +}

