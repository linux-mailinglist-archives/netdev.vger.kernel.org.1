Return-Path: <netdev+bounces-272989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IvlEAuCyWmBygUAu9opvQ
	(envelope-from <netdev+bounces-272989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:48:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EBC353D43
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B4613021733
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D162727F3;
	Sun, 29 Mar 2026 19:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqxoLZBv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3799640DFDF
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774813668; cv=none; b=gTGduhwqWKq+wPMtF2wDZ6n6mm4P7Y+sWEMq+THopgSgXrgj1FCSD9DNNF57/04nvMTpu6isASshYD+bz+Qq6ipPA5IBMmVofqQYWWhHKWPFg+8PEx8LCahXLGdWSw8BxhqFhqDVxubB0CQHET8jc+VBqfKpir53mmmUjx43IIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774813668; c=relaxed/simple;
	bh=pTrR5GSrcCUbf0vlF2gd1oxffNotG6Awksl1hm7YiIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQQ6BI8gGuONal4Zg3Elg8OP4WROgBkKS6Myt2e4F3/ZkFwPmdN2zo73Pv+IzZ7k+NSTGHuqEvmXHuSbgrJ0Kl8J2VGTGjMEIDewYxuIddmtfS7SkxLNZrfG/jlVg0bA6pz/RRr77RgVwlxQmCggW8N4B//aHPed7eKS9nWpnAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqxoLZBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B44BC116C6;
	Sun, 29 Mar 2026 19:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774813667;
	bh=pTrR5GSrcCUbf0vlF2gd1oxffNotG6Awksl1hm7YiIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqxoLZBvWkwv+d43xKLiO0RsJ6Uan3eMH1Ji3bICdmgwj7BYJZ6w7yQWdqhKHJKw9
	 VFcRpbD9YPFuLGzVBC66TfuYsAy73m0dJNgmten3QUKnXS12v+NfhzOmeQDOXGSq2d
	 HPDxQWIE7EfJgzf0P267rTPVDPiztyG7iZTWFdtJFon+3FeF1zrBKYxpAoW98ZyeSy
	 H1taC1SBkblbOPEnBCeXt3sybJmWWHnnzmaJKDgIUF+LYamcS9+/v+cBQY88n3c2HU
	 dPFG56tIPEbppUCJFkqUVSTMFalDN8RnkRHgzm7pUiG8NPRM/xY9V58oXBW6ZNY+y0
	 7R4bGllLOkyHg==
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
Subject: Re: [PATCH net-next v6 4/7] net: macb: make macb_tx_skb generic
Date: Sun, 29 Mar 2026 12:47:46 -0700
Message-ID: <20260329194746.2781445-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323221047.2749577-5-pvalerio@redhat.com>
References: <20260323221047.2749577-5-pvalerio@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272989-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A4EBC353D43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: macb: make macb_tx_skb generic

This commit renames the macb_tx_skb structure to macb_tx_buff with no
functional changes. This is done as a preparatory step for adding XDP
xmit support.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -2404,12 +2404,12 @@ static unsigned int macb_tx_map(struct macb *bp,
>  	}
>  
>  	/* Should never happen */
> -	if (unlikely(!tx_skb)) {
> +	if (unlikely(!tx_buff)) {
>  		netdev_err(bp->dev, "BUG! empty skb!\n");
>  		return 0;
>  	}

Does returning 0 here cause a memory leak? 

If macb_tx_map() returns 0 for an empty skb, the caller macb_start_xmit()
will assume the packet was successfully enqueued and will not free it. Should
this return an error code like -EINVAL instead to trigger the 
dev_kfree_skb_any() error path?

[ ... ]

> @@ -2808,8 +2808,8 @@ static void macb_free_consistent(struct macb *bp)
>  	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
>  
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> -		kfree(queue->tx_skb);
> -		queue->tx_skb = NULL;
> +		kfree(queue->tx_buff);
> +		queue->tx_buff = NULL;

Is queue->tx_error_task guaranteed to be canceled before we free
queue->tx_buff here?

Since macb_close() calls macb_free_consistent() without explicitly calling
cancel_work_sync(&queue->tx_error_task), could a pending background error
task execute and access the freed array, resulting in a use-after-free?

[ ... ]

> @@ -2887,9 +2887,9 @@ static int macb_alloc_consistent(struct macb *bp)
>  		queue->rx_ring = rx + macb_rx_ring_size_per_queue(bp) * q;
>  		queue->rx_ring_dma = rx_dma + macb_rx_ring_size_per_queue(bp) * q;
>  
> -		size = bp->tx_ring_size * sizeof(struct macb_tx_skb);
> -		queue->tx_skb = kmalloc(size, GFP_KERNEL);
> -		if (!queue->tx_skb)
> +		size = bp->tx_ring_size * sizeof(struct macb_tx_buff);
> +		queue->tx_buff = kmalloc(size, GFP_KERNEL);
> +		if (!queue->tx_buff)
>  			goto out_err;
>  	}

This isn't a bug, but would it be better to use kcalloc() or kmalloc_array()
here instead of manual size multiplication?

