Return-Path: <netdev+bounces-301905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +HwiL/TrPGrHuQgAu9opvQ
	(envelope-from <netdev+bounces-301905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:51:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B80306C3F74
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:50:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ld6Rr9qV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301905-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301905-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1059930135C9
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8259387345;
	Thu, 25 Jun 2026 08:50:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D6386571;
	Thu, 25 Jun 2026 08:50:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377439; cv=none; b=E/gCYW7HsWqerJEx6dK117jLUSnGF/L+gCRaYoclEDcdMGnpg1MoQRQj43zklDYwS7E5CaU8bySb2YRnXJMqEr0zrT4GBMIrMc7gD51uzzjHwMfP2XG/rdqiViN0uw6AidQ89roNwgbLYqmnmp66YJkLEFL736aAM9aK0XZV094=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377439; c=relaxed/simple;
	bh=3CavB3xFcg6aPEmH4BBYZKfZU71D5ex0qIHZqodBe44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktn8OZZC46UepmzoceTuTX84X2Pnxy/iACMAohs+OzWHs7FhE7QmGWFIZwiAxroCkn6X/LbJjNHZX8ZzUnR+c7CUv6IeWWeINJbbOY4rmQLTkCiOiOEAGmYEl0XAPIi+UB8aEAaObfuJR7qCrRPbAqZxfY9c/v9d2GArd1F45no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld6Rr9qV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0528E1F000E9;
	Thu, 25 Jun 2026 08:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782377438;
	bh=wgnueYGHh9WXeRoyt7ilJit1Zlim1DNaRtritPKy+1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ld6Rr9qVNm2zPem8/TfMnMxeMUGclZUZhL4DAV3+f1WkOaxRFmovyLx2PMt8FmnGO
	 C13qTJdPOUEuZaGms6WVmbrF2kF8hwse+i7HtxiFEHm7dgvwBatXwmFDYyWWXrF1a/
	 K+VmxHwgCDJqDBXxVm9w3Tck81o5ZSpbDu4fR3Sab18NDpPYj2vnBB0cXmuAsbW/sw
	 pAl6oiPda69flVy7lCFZG0Uc1eP2pn/woXgTGoANfHHr7xGKd4O3Nb7D5ZIurV6v3u
	 6o86mzsxMcgUs9YESdTt/tiwnNs2XlHXI+DfQ7h/0GAQjwW87d9zizmdbTa/dl5H6z
	 /on2msPQ73zQg==
From: Simon Horman <horms@kernel.org>
To: haoxiang_li2024@163.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: meth: Fix skb allocation failure handling in RX init
Date: Thu, 25 Jun 2026 09:47:46 +0100
Message-ID: <20260625084744.1163212-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624031940.2690439-1-haoxiang_li2024@163.com>
References: <20260624031940.2690439-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301905-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:pavan.chebbi@broadcom.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B80306C3F74

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says:

Hi Haoxiang,

I think that the pre-existing issues flagged below do not need
to be considered in the context of this patch. But I am wondering
if you could take a look over the others.

---
net: meth: Fix skb allocation failure handling in RX init

meth_init_rx_ring() does not check the return value of alloc_skb().
If the allocation fails, the NULL skb is passed to skb_reserve() and
then dereferenced through skb->head.

> --- a/drivers/net/ethernet/sgi/meth.c
> +++ b/drivers/net/ethernet/sgi/meth.c
> @@ -228,6 +228,9 @@ static int meth_init_rx_ring(struct meth_private *priv)
>  
>  	for (i = 0; i < RX_RING_ENTRIES; i++) {
>  		priv->rx_skbs[i] = alloc_skb(METH_RX_BUFF_SIZE, 0);
> +		if (!priv->rx_skbs[i])
> +			goto err_free_skbs;
> +
>  		/* 8byte status vector + 3quad padding + 2byte padding,
>  		 * to put data on 64bit aligned boundary */
>  		skb_reserve(priv->rx_skbs[i],METH_RX_HEAD);

[ ... ]

> @@ -240,6 +243,17 @@ static int meth_init_rx_ring(struct meth_private *priv)
>  	}
>          priv->rx_write = 0;
>  	return 0;
> +
> +err_free_skbs:
> +	while (i--) {
> +		dma_unmap_single(&priv->pdev->dev, priv->rx_ring_dmas[i],
> +				 METH_RX_BUFF_SIZE, DMA_FROM_DEVICE);

[Severity: Critical]
During the allocation loop, each successfully mapped DMA address is pushed
immediately to the hardware via the mace->eth.rx_fifo register. Unmapping
them here frees the memory, but the hardware FIFO still retains the physical
addresses.

When meth_init_rx_ring() returns -ENOMEM to meth_tx_timeout(), the error is
ignored and the RX DMA engine is enabled anyway:

meth_tx_timeout()
    ...
    meth_init_rx_ring(priv);
    priv->dma_ctrl |= METH_DMA_TX_EN | METH_DMA_RX_EN | METH_DMA_RX_INT_EN;

Will this cause the hardware to DMA incoming packet data into the unmapped
and potentially reallocated memory?

> +		priv->rx_ring[i] = 0;

[Severity: High]
If the hardware remains active as described above, will the RX interrupt
handler dereference this NULL pointer?

When the hardware receives a packet, it raises an RX interrupt and meth_rx()
attempts to process it:

meth_rx()
    ...
    status = priv->rx_ring[priv->rx_write]->status.raw;

Since the pointer at this index was cleared in the error path, this looks
like it will cause a kernel panic.

> +		priv->rx_ring_dmas[i] = 0;
> +		kfree_skb(priv->rx_skbs[i]);
> +		priv->rx_skbs[i] = NULL;

[Severity: Critical]
Does this partial cleanup lead to a double free of socket buffers?

When meth_init_rx_ring() fails at index N, this loop zeroes out elements 0
through N-1. The elements from N through 63 retain their dangling pointers
from the previous execution of meth_free_rx_ring(), which fails to clear SKB
pointers after freeing them.

Since meth_tx_timeout() ignores the error and leaves the device running, the
next time meth_free_rx_ring() is called, it iterates over all 64 elements
again. Will this call kfree_skb() on the dangling pointers in indices N
through 63?

> +	}
> +	return -ENOMEM;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but dma_map_single() is called in
meth_init_rx_ring() without checking for mapping errors:

meth_init_rx_ring()
    ...
    priv->rx_ring_dmas[i] = dma_map_single(&priv->pdev->dev,
                                           priv->rx_ring[i],
                                           METH_RX_BUFF_SIZE,
                                           DMA_FROM_DEVICE);
    mace->eth.rx_fifo = priv->rx_ring_dmas[i];

If the mapping fails, an error cookie is passed directly to the hardware.
Could this lead to IOMMU faults or memory corruption when DMA bounce buffers
are exhausted?

[Severity: High]
This is a pre-existing issue, but there appears to be a race condition due
to lockless processing in meth_rx().

The interrupt handler drops the spinlock before processing the ring:

meth_rx()
    ...
    spin_unlock_irqrestore(&priv->meth_lock, flags);
    ...
    while (priv->rx_write != fifo_rptr) {

Concurrently, meth_tx_timeout() can acquire the lock and destroy the RX rings,
falsely assuming it is protected:

meth_tx_timeout()
    ...
    spin_lock_irqsave(&priv->meth_lock,flags);
    meth_reset(dev);
    ...
    meth_free_rx_ring(priv);

If meth_free_rx_ring() frees the SKBs while meth_rx() is still executing the
lockless while loop, could this result in a use-after-free or NULL pointer
dereference?

