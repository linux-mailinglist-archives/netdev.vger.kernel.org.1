Return-Path: <netdev+bounces-272990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJGXGxqCyWmBygUAu9opvQ
	(envelope-from <netdev+bounces-272990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:48:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E16CB353D4C
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AF9C300C5B0
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C782727F3;
	Sun, 29 Mar 2026 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvylsfQe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CC1292B54
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774813669; cv=none; b=qnFPbx5J4/4RswMPxfXusmcm1o2LyP7AokqlMP3uxoci0zYUFDlvPGQ3sDKzz5qXv8c2mqSChfMrB60Vmtd9Gw/1o17dPBBmM/5PTFqxx9R82ERNXz5cjkhsAkiYHdP44Ow/DuOgNgVAUB5AgkY8Vvfw6/FS7ZB+ef5xYVBt31U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774813669; c=relaxed/simple;
	bh=6MYKNqloEAUlvnH2BRlAnouVR6iLhRhs0jjpPB8vM7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZDSc+Za3OL7iKS466GgkrPBbWyn2RBF6upmAnkQSpFUsm+AS7yrO7Ywxj7OB55T23/Y6QBX4/OmX4KPk669TmJ2BwYsHDtHZMdEshRXgy24Gd826lA0o/mRp1iX51tC4GYYn2MF29Pt8In66VJcfAhk/NK5U3gTM5Tuad8eXgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvylsfQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AC5C116C6;
	Sun, 29 Mar 2026 19:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774813669;
	bh=6MYKNqloEAUlvnH2BRlAnouVR6iLhRhs0jjpPB8vM7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvylsfQeENRmLfYlH0QngMLVTmsM+kwqKZmhhkL/gl05tkETlnYFEBOUSrI0mi5RP
	 4TUiVOwNPUI+86BtjmyTxS0i+0J+muAj36sFAtMYGj1T9TADKYvaPWSGOKHoGmHJYT
	 B07xffma9WiTuper7B/WQkKWpg7qW7+0GQKKcXExDPuoN7tCyKLYzYq72fCXC5bhlm
	 rl1QcilZKEK3+sMVCAAp7i7g/cyPmPROnv+T2xxvfU1dXyX1/uOWOrghI14BW5my1A
	 gTUXiEn4VJRwkARC9Cu7yZWU5yX5a/g//Cx0vF1MC/aEAa61lK+3qGbaTb2nAjmM3c
	 Byn1hIYkTu8WQ==
From: Jakub Kicinski <kuba@kernel.org>
To: pvalerio@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	lorenzo@kernel.org,
	theo.lebrun@bootlin.com,
	nb@tipi-net.de
Subject: Re: [PATCH net-next v6 5/7] net: macb: generalize tx buffer handling
Date: Sun, 29 Mar 2026 12:47:48 -0700
Message-ID: <20260329194748.2781504-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323221047.2749577-6-pvalerio@redhat.com>
References: <20260323221047.2749577-6-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272990-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E16CB353D4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: macb: generalize tx buffer handling

This commit renames the skb member in struct macb_tx_buff to ptr and
introduces an enum macb_tx_buff_type. This prepares the driver for XDP xmit
support by allowing the buffer to handle both sk_buff and xdp frames.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index a71d36b18170..4c5dd70f003b 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1197,7 +1197,8 @@ static int macb_halt_tx(struct macb *bp)
>  					bp, TSR);
>  }
>  
> -static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff, int budget)
> +static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
> +			  int budget)
>  {

[ ... ]

> -	if (tx_buff->skb) {
> -		napi_consume_skb(tx_buff->skb, budget);
> -		tx_buff->skb = NULL;
> +	if (tx_buff->ptr) {
> +		napi_consume_skb(tx_buff->ptr, budget);
> +		tx_buff->ptr = NULL;
>  	}
>  }

Does the teardown path iterate over the uncompleted descriptors to call
macb_tx_unmap()?

When the interface is closed, the hardware is reset and macb_free_consistent()
frees the tx_buff array directly via kfree(queue->tx_buff).

If the teardown path does not iterate from tx_tail to tx_head, will any
packets (and future xdp frames) that are currently in the transmit ring when
the interface is brought down be permanently leaked, along with their
associated DMA mappings?

[ ... ]

> @@ -1298,7 +1299,7 @@ static void macb_tx_error_task(struct work_struct *work)
>  		desc = macb_tx_desc(queue, tail);
>  		ctrl = desc->ctrl;
>  		tx_buff = macb_tx_buff(queue, tail);
> -		skb = tx_buff->skb;
> +		skb = tx_buff->ptr;

Is the tx_error_task workqueue canceled before freeing tx_buff during device
teardown?

The macb_tx_error_task background task accesses the queue->tx_buff array and
the hardware tx_ring. During device teardown, macb_free_consistent() frees
queue->tx_buff using kfree().

If cancel_work_sync(&queue->tx_error_task) is not called in the teardown
path, could a transmit error schedule this workqueue just before the device
is brought down, causing the task to execute after the structures have been
destroyed and resulting in a use-after-free?

[ ... ]

> @@ -2365,7 +2368,8 @@ static unsigned int macb_tx_map(struct macb *bp,
>  			goto dma_error;
>  
>  		/* Save info to properly release resources */
> -		tx_buff->skb = NULL;
> +		tx_buff->ptr = NULL;
> +		tx_buff->type = MACB_TYPE_SKB;

What happens if this function receives an empty skb and fails to find any
fragments?

Looking at the rest of macb_tx_map(), if the packet has no data length, it
appears the function logs an error and returns 0:

	/* Should never happen */
	if (unlikely(!tx_buff)) {
		netdev_err(bp->dev, "BUG! empty skb!\n");
		return 0;
	}

Since the caller treats 0 as success, it would skip the error path that frees
the skb. As no descriptor was actually queued and tx_head wasn't updated, will
the packet never be unmapped or freed by the completion path, causing a
permanent memory leak? Should this return a non-zero error code instead?

[ ... ]

> @@ -5283,8 +5289,9 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
>  		netif_stop_queue(dev);
>  
>  		/* Store packet information (to free when Tx completed) */
> -		lp->rm9200_txq[desc].skb = skb;
> +		lp->rm9200_txq[desc].ptr = skb;
>  		lp->rm9200_txq[desc].size = skb->len;
> +		lp->rm9200_txq[desc].type = MACB_TYPE_SKB;
>  		lp->rm9200_txq[desc].mapping = dma_map_single(&lp->pdev->dev, skb->data,

Can a DMA mapping error here cause a permanent queue hang?

If dma_mapping_error() fails just below this, the driver calls
dev_kfree_skb_any(skb) and returns NETDEV_TX_OK but leaves the queue stopped
via netif_stop_queue(dev).

Because no transmission is started, the hardware will never generate a
completion interrupt, leaving the queue permanently hung.

Additionally, ptr is left pointing to the freed memory, creating a dangling
pointer. Does this need to be cleared when the error occurs?

