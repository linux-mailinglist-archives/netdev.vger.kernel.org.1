Return-Path: <netdev+bounces-217344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EBCB38685
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322B3685291
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999E127FD59;
	Wed, 27 Aug 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtMkxQuQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B8A27E7FC;
	Wed, 27 Aug 2025 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308315; cv=none; b=LICVoPwy2ZTewmvXff0qFe302LKhPYCiC3fAwEsBEkFqI6vTazs8IlqRbE+Kk4fngSjLMLZHC0lY5X1w9k0Dm1XU0Q53rp+5QzA5WQOg1wgCpHmhrviyBAc3IGctZXBVau81ozV1L7J2vDYzDk2smFfZpkkkmRc0uSSu/d4S2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308315; c=relaxed/simple;
	bh=kfwViz7xFBzpp18djq1NxXlwY0FdLit/f4wL7ogsZY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLQPHmHUBIyTNIgmC30mARvrgybUQg7T7ZsW5ehq8xmD8x+VtPaS+6bHiRuYrP8rdoF9ryqyCvsVshHTUQbOR8O5JNo1Yxc5SwO9h9ypUUV8TE6se7/1LJvb1OvhWXJNpE8D+L6rVndcYaLc8yLlCX2F3VD5i08ls+3pBm6wMsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtMkxQuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC01C4CEEB;
	Wed, 27 Aug 2025 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756308314;
	bh=kfwViz7xFBzpp18djq1NxXlwY0FdLit/f4wL7ogsZY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RtMkxQuQXfDVIND2OpDItTfeBrBVaErNTzfPbgeIc6qMJjRlaFluCRBKsGF8z7LSi
	 MotoQwLj4l5RJV2zdYk50WTDMlSmUvnZC2qu5oxAJAUkouHRpxJd42kHFtJpMHNxp7
	 5zu/Q96pPUJYvUvT3FhjrogvmGsGEVVt3zYFlxsCPHM+q2ip+ePuv9C23M08bQBqpm
	 9BRue8DRHRqir8Sie/TVZex4vS46w2DV3lYfQtOtYF5mzvPXlbpE7Jr6NDrK/p1/pQ
	 owiq44x+kz8ivAEdHOdEZjlSBs6spCFpmuv5v2A2gWLY5cIWTGk7yqFJzSGDo3fCzY
	 D8tqZ7JO/vLEw==
Date: Wed, 27 Aug 2025 08:25:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukasz.majewski@mailbox.org>
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
Subject: Re: [net-next v19 4/7] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20250827082512.438fd68a@kernel.org>
In-Reply-To: <20250824220736.1760482-5-lukasz.majewski@mailbox.org>
References: <20250824220736.1760482-1-lukasz.majewski@mailbox.org>
	<20250824220736.1760482-5-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 00:07:33 +0200 Lukasz Majewski wrote:
> +	/* Set buffer length and buffer pointer */
> +	bufaddr = skb->data;

You can't write (swap) skb->data if the skb is a clone..

> +	bdp->cbd_datlen = skb->len;
> +
> +	/* On some FEC implementations data must be aligned on
> +	 * 4-byte boundaries. Use bounce buffers to copy data
> +	 * and get it aligned.spin
> +	 */
> +	if ((unsigned long)bufaddr & MTIP_ALIGNMENT) {

add 
	.. ||
	(fep->quirks & FEC_QUIRK_SWAP_FRAME && skb_cloned(skb))

here to switch to the local buffer for clones ?

> +		unsigned int index;
> +
> +		index = bdp - fep->tx_bd_base;
> +		memcpy(fep->tx_bounce[index], skb->data, skb->len);
> +		bufaddr = fep->tx_bounce[index];
> +	}
> +
> +	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> +		swap_buffer(bufaddr, skb->len);

> +	if (unlikely(dma_mapping_error(&fep->pdev->dev, bdp->cbd_bufaddr))) {
> +		dev_err(&fep->pdev->dev,
> +			"Failed to map descriptor tx buffer\n");

All per-packet prints must be rate limited

> +		/* Since we have freed up a buffer, the ring is no longer
> +		 * full.
> +		 */
> +		if (fep->tx_full) {
> +			fep->tx_full = 0;
> +			if (netif_queue_stopped(dev))
> +				netif_wake_queue(dev);
> +		}

I must say I'm still quite confused by the netdev management in this
driver. You seem to have 2 netdevs, one per port. There's one
set of queues and one NAPI. Whichever netdev gets up first gets the
NAPI. What makes my head spin is that you seem to record which
netdev/port was doing Rx _last_ and then pass that netdev to
mtip_switch_tx(). Why? Isn't the dev that we're completing Tx for is
best read from skb->dev packet by packet? Also this wake up logic looks
like it will wake up _one_ netdev's queue and then set tx_full = 0, so
presumably it will not wake the other port if both ports queues were
stopped. Why keep tx_full state in the first place? Just check if the
queues is stopped..?

