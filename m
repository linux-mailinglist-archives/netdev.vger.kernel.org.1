Return-Path: <netdev+bounces-278261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AElDGQWR3WkLfwkAu9opvQ
	(envelope-from <netdev+bounces-278261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:57:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F101F3F4ADF
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67580303D892
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54252279DAD;
	Tue, 14 Apr 2026 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTcf+G+r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309DF242925;
	Tue, 14 Apr 2026 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776128217; cv=none; b=Rdh7wFI8YAVTkpMCR+LsPd+PHjZijIMIjjeoIr6x18ZT/PucnGu7dLsCgPspWVswYpNOZgx/IzhFXKG+tN3TVlw/tqy8nEMmXNElk2SobpKrdkh6Qs2E5IJ7S7WyDMszD3sPptf1t9TpWezVLMS+7K7bKPSuGP09FaDwyFWtY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776128217; c=relaxed/simple;
	bh=XP8FQWYIKKkg3CtjlVkf45FV3FMUgqEestMU94C2yrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw37L0E24PAypCVZrqguTobRtJC0TWvtXiFPJa/7A55lr/ivSd8SeSkWIuZ9BBxX66PU7qyr6nd16TLzWbz1UnL8BB/jM2uvaJ588IlnAmMQ6ztXlVr/nNEDMT7X6SXWwJQVW9N5zR97xTYPYq0hWDDl47lsdEbA6kjmy3DEvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTcf+G+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB788C2BCAF;
	Tue, 14 Apr 2026 00:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776128217;
	bh=XP8FQWYIKKkg3CtjlVkf45FV3FMUgqEestMU94C2yrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTcf+G+rBSA4Ial1rFJRY6ViAWtI2u+FmIOiQPokVTlQN0WJfhJI82HdHiIs4Oel+
	 dPkJP7tmVKhwh7rnDdGND6I/+Z0HfPceIzUISwK+e6ExSVYhp4FABvNHsCAAmAatZv
	 JhNLIiY+v9uOo+6CoEEuBdI/d6ZTq9JXWUq+VT5jikh1HeiF9MDHnH9Fv5JnmBZFrw
	 K28OwQut9hNhG4k3+87koWNDmZkA5sZO46XASaEbBAVApj4e2xuNhBGdk/erNwz/DI
	 rC5UYBO2FkxtxsWrDk0lWFJIwksq2uiTCIkmKT3wWZCoI0Yle3eXzbbHmGjocB7p3+
	 OF6Sj8de59lmQ==
From: Jakub Kicinski <kuba@kernel.org>
To: theo.lebrun@bootlin.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	pvalerio@redhat.com,
	conor@kernel.org,
	nb@tipi-net.de,
	vladimir.kondratiev@mobileye.com,
	gregory.clement@bootlin.com,
	benoit.monin@bootlin.com,
	tawfik.bayouk@mobileye.com,
	thomas.petazzoni@bootlin.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 13/14] net: macb: use context swapping in .set_ringparam()
Date: Mon, 13 Apr 2026 17:56:54 -0700
Message-ID: <20260414005654.3766959-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-macb-context-v2-13-af39f71d40b6@bootlin.com>
References: <20260410-macb-context-v2-13-af39f71d40b6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278261-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,tipi-net.de,mobileye.com,bootlin.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F101F3F4ADF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: macb: use context swapping in .set_ringparam()

This patch modifies the ethtool set_ringparam implementation to use a
context swapping mechanism. Instead of closing and reopening the interface,
it allocates new buffers, stops the interface temporarily, swaps the active
context, and then frees the old one.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 3deab87c565b5..d1536cb1e40bb 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3081,6 +3081,89 @@ static void macb_configure_dma(struct macb *bp)
[ ... ]
> +static void macb_context_swap_start(struct macb *bp)
> +{
[ ... ]
> +	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> +		napi_disable(&queue->napi_rx);
> +		napi_disable(&queue->napi_tx);

This isn't a regression from this patch, but does calling napi_disable()
unconditionally crash on EMAC devices?

EMAC devices appear to not initialize NAPI, which leaves the NAPI struct
zero-initialized (n->dev is NULL), potentially causing a NULL pointer
dereference in napi_disable(). Additionally, does this path also blindly
call bp->macbgem_ops.mog_init_rings() which is NULL on EMAC?

> +		netdev_tx_reset_queue(netdev_get_tx_queue(bp->netdev, q));
> +		cancel_work_sync(&queue->tx_error_task);
> +	}
[ ... ]
> +static void macb_context_swap_end(struct macb *bp,
> +				  struct macb_context *new_ctx)
> +{
[ ... ]
> +	/* Swap contexts & give buffer pointers to HW. */
> +
> +	old_ctx = bp->ctx;
> +	bp->ctx = new_ctx;
> +	macb_init_buffers(bp);

Since the new context swap doesn't call phylink_stop(), could a concurrent
macb_mac_link_up() execution set the RE and TE bits in NCR during the window
where bp->lock is dropped?

If so, macb_init_buffers() would write new DMA ring base addresses to RBQP
and TBQP while the MAC is actively enabled, which violates hardware
specifications and could cause DMA corruption.

[ ... ]
> +	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
> +		for (q = 0, queue = bp->queues; q < bp->num_queues;
> +		     ++q, ++queue) {
> +			queue_writel(queue, IER,
> +				     bp->rx_intr_mask |
> +				     MACB_TX_INT_FLAGS |
> +				     MACB_BIT(HRESP));
> +		}
> +	}

Hardware interrupts are disabled unconditionally for all devices in
macb_context_swap_start() by writing -1 to IDR.

Will this explicit check prevent EMAC devices from having their interrupts
re-enabled?

Since EMAC devices do not use NAPI and rely on hardware interrupts, leaving
them masked might silently halt all network traffic after a ring parameter
change.

> +
> +	ctrl = macb_readl(bp, NCR);
> +	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));

Can this unprotected read-modify-write of the NCR register race with phylink
state changes?

If an asynchronous phylink callback like macb_mac_config() modifies NCR
while holding bp->lock, this unlocked write could overwrite and drop those
concurrent updates.

> +
> +	netif_tx_start_all_queues(bp->netdev);
> +
> +	/* Free old context. */
> +
> +	macb_free_consistent(old_ctx);

This isn't a regression from this patch, but does this context swap leak
pending TX packets and their DMA mappings?

When freeing the old context, macb_free_consistent() appears to only free
the pointer array. If it doesn't iterate from txq->tail to txq->head to
unmap the active DMA mappings and free the sk_buff structs, repeatedly
modifying ring parameters could cause a memory and DMA mapping leak.

