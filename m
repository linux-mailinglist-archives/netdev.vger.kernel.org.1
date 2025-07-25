Return-Path: <netdev+bounces-210216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15636B126B9
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37DD71886DB7
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 22:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA221230BEE;
	Fri, 25 Jul 2025 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZKOhAYk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19A19D06B;
	Fri, 25 Jul 2025 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481781; cv=none; b=domqD+Eas15LRNsDdpKUeTSkl8F0nYR3RaQRcpgus2+nIXgOUfFvQGlwY/oEAaqSNwXKSaJuxB9Dfh9sPWzEjNslxOokS/Jh4BkkdJey9U+myTZc9kP6Ze0kbp0szT3fTtn3EV7QffBcgIEwDl5HHJeTs/x+wL6+R9IdIIoyGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481781; c=relaxed/simple;
	bh=zcCljp+/O3021EXF1kCLQYobxVhkF/h2q9zxHMYLlrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LV+IVS9t8mA5SBcAwIoxJHCraoFE93DIMcnbxRq3oroX+a4DhiNK23OlSrADLe6oJE2qwBgJMYuaPSv/MZz3Uh77Fyjab3HKz7O4ihXnMOiDnJAHCxAARXHnoWInMLSNat+7GOEjiVOb3EMqCvmXRYwq2GRw+hRsW9IFlNNpHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZKOhAYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C206C4CEEF;
	Fri, 25 Jul 2025 22:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753481780;
	bh=zcCljp+/O3021EXF1kCLQYobxVhkF/h2q9zxHMYLlrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YZKOhAYkjdfG8UL5HyJCFIY5sTjEDtSgODpdhnxJHWSijrZUGlWcW8bnm9QR/3Bo8
	 MOu7XWmbuz2fW/3mr6s58b1HlBXH/j3Dr5hwwJe7jRQAKLeIpVdfloTiX1kPjPj6LX
	 RXfHwUTSK6J1UNfxEMAd7zMN50FiHYgDcMkEZmHuCQbFPIvUcS+hmvAxhDVis2PI6F
	 IMFQ4cGUHzYx3+9Zwm2s7jH6YxyUqcaj+M9S7iriu1EofrRPo3E4488GIgFXE8D07a
	 WuoDsvFFqj3rxBASIDmQ3E79npvARYh4fHJ9XG+9hMQzqx2MIGGsHOXsBeIZ88Qw00
	 meD+hksXofvbw==
Date: Fri, 25 Jul 2025 15:16:18 -0700
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
Subject: Re: [net-next v16 06/12] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20250725151618.0bc84bdb@kernel.org>
In-Reply-To: <20250724223318.3068984-7-lukma@denx.de>
References: <20250724223318.3068984-1-lukma@denx.de>
	<20250724223318.3068984-7-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 00:33:12 +0200 Lukasz Majewski wrote:
> +static void swap_buffer(void *bufaddr, int len)
> +{
> +	int i;
> +	unsigned int *buf = bufaddr;
> +

nit: reverse xmas tree

> +	if (status & BD_ENET_TX_READY) {
> +		/* All transmit buffers are full. Bail out.
> +		 * This should not happen, since dev->tbusy should be set.
> +		 */
> +		netif_stop_queue(dev);
> +		dev_err_ratelimited(&fep->pdev->dev, "%s: tx queue full!.\n",
> +				    dev->name);
> +		spin_unlock(&fep->hw_lock);

As we discussed on previous revision you have many to one mapping
of netdevs to queues. I think the warning should only be printed
if the drivers is in "single netdev" mode. Otherwise it _will_
trigger.

BTW you should put the print after the unlock, console writes are slow.

> +static void mtip_timeout(struct net_device *dev, unsigned int txqueue)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct cbd_t *bdp;
> +	int i;
> +
> +	dev->stats.tx_errors++;
> +
> +	if (IS_ENABLED(CONFIG_SWITCH_DEBUG)) {

why are you hiding the debug info under a CONFIG_ ? 
(which BTW appears not to be defined at all)
Seems useful to know the state of the HW when the queue hung.
You can use a DO_ONCE() if you want to avoid spamming logs

> +	/* Set buffer length and buffer pointer */
> +	bufaddr = skb->data;

You should call skb_cow_data() if you want to write to the skb data.

> +static void mtip_timeout(struct net_device *dev, unsigned int txqueue)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct cbd_t *bdp;
> +	int i;
> +
> +	dev->stats.tx_errors++;

timeouts are already counted by the stack, I think the statistic
is exposed per-queue in sysfs

> +		spin_lock_bh(&fep->hw_lock);
> +		dev_info(&dev->dev, "%s: transmit timed out.\n", dev->name);
> +		dev_info(&dev->dev,
> +			 "Ring data: cur_tx %lx%s, dirty_tx %lx cur_rx: %lx\n",
> +			 (unsigned long)fep->cur_tx,
> +			 fep->tx_full ? " (full)" : "",
> +			 (unsigned long)fep->dirty_tx,
> +			 (unsigned long)fep->cur_rx);
> +
> +		bdp = fep->tx_bd_base;
> +		dev_info(&dev->dev, " tx: %u buffers\n", TX_RING_SIZE);
> +		for (i = 0; i < TX_RING_SIZE; i++) {
> +			dev_info(&dev->dev, "  %08lx: %04x %04x %08x\n",
> +				 (kernel_ulong_t)bdp, bdp->cbd_sc,
> +				 bdp->cbd_datlen, (int)bdp->cbd_bufaddr);
> +			bdp++;
> +		}
> +
> +		bdp = fep->rx_bd_base;
> +		dev_info(&dev->dev, " rx: %lu buffers\n",
> +			 (unsigned long)RX_RING_SIZE);
> +		for (i = 0 ; i < RX_RING_SIZE; i++) {
> +			dev_info(&dev->dev, "  %08lx: %04x %04x %08x\n",
> +				 (kernel_ulong_t)bdp,
> +				 bdp->cbd_sc, bdp->cbd_datlen,
> +				 (int)bdp->cbd_bufaddr);
> +			bdp++;
> +		}
> +		spin_unlock_bh(&fep->hw_lock);

