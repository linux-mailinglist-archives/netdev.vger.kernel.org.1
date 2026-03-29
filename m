Return-Path: <netdev+bounces-272991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFQDCCuCyWmBygUAu9opvQ
	(envelope-from <netdev+bounces-272991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:48:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C70353D53
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFAFB302BEAD
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D145274FEB;
	Sun, 29 Mar 2026 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk30xVZc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6081C8634
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774813671; cv=none; b=NixQ9A1wJFFGH7xzGY1i/2Cdc0bjnsgJBlTurcO5U8J2DajqUP8k2UGuGHl0LiImLpHI0fnLhs5NB90Tcw7yWRcanklkLIpoqs1D2/aKY9MjgJVQGWjgOrs8abCsp2Z9IWBbFrHgd7ujE/lgD/jKi9XKS2sTMUkBZN9ZZQGGtlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774813671; c=relaxed/simple;
	bh=+1PBXvBhna3YctzmS8U7N4WTuV6LO6zkkBGkQEuHwic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXfF7ua6i6TADXVPEcub3kQcIaXvNZLwpP5KN5M4vByAGA9hY7xXmbBddkh6XJEv+6fsV3kJ2nw0YserWkn2wZljAJxVEj3N/qIJQ0hRvCztpdooP+ZhlDvRv5nSM7nq1kFWdInunYc4MnElg50pxlAbh/rxm21DilfdcvJIKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk30xVZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4F8C116C6;
	Sun, 29 Mar 2026 19:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774813671;
	bh=+1PBXvBhna3YctzmS8U7N4WTuV6LO6zkkBGkQEuHwic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uk30xVZczpo5SGexAKe6DEnQyaQukwUR91QtvqmZBALKx3JVpGAq+cy5kEiTZ5B83
	 beWrUMHYvD+ixD9Ou1UqzX7RLCQvDAKzTZwr+PPkqUv9VrfrE+eWJXgLRqhj8EsM35
	 B/BuCx5RtRVIotQu7M14jN0vNskQJGCSHcHAkSjn6b0JY2hDAjxniOggdVc88zIvWa
	 Y4IIP2u6GN/wpY707K18lJwZPyn9FM7h0HdEl9sVW4GQwoYxjievx23GqmK9PwfUg0
	 d+USNcnGABaXg0HFKcvyrfcAu+6MIaSHJd6dd+gLOlxIuadnw7pyhwHk7SmWMOLJrt
	 l++qc3uxshI1Q==
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
Subject: Re: [PATCH net-next v6 6/7] net: macb: add XDP support for gem
Date: Sun, 29 Mar 2026 12:47:49 -0700
Message-ID: <20260329194749.2781535-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323221047.2749577-7-pvalerio@redhat.com>
References: <20260323221047.2749577-7-pvalerio@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272991-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96C70353D53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: macb: add XDP support for gem

This commit introduces basic XDP support for macb/gem with the XDP_TX,
XDP_PASS, XDP_DROP, and XDP_REDIRECT verdict support.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 4c5dd70f003b..537d02264851 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
[ ... ]
> @@ -1197,6 +1198,18 @@ static int macb_halt_tx(struct macb *bp)
>  					bp, TSR);
>  }
>  
> +static void macb_tx_release_buff(void *buff, enum macb_tx_buff_type type, int budget)
> +{
> +	if (type == MACB_TYPE_SKB) {
> +		napi_consume_skb(buff, budget);
> +	} else {
> +		if (!budget)
> +			xdp_return_frame(buff);
> +		else
> +			xdp_return_frame_rx_napi(buff);
> +	}
> +}

Does this code cause memory corruption in the page pool lockless cache?
This function is called from macb_tx_complete(), which executes in the
context of the TX NAPI poll routine (queue->napi_tx).

However, the page pool was created and bound to the RX NAPI context
(queue->napi_rx). Since xdp_return_frame_rx_napi() bypasses safety checks
and places the page directly into the pool's lockless cache, and these are
independent NAPI instances that can be scheduled concurrently on different
CPUs, shouldn't this use xdp_return_frame() to safely handle cross-CPU
synchronization?

[ ... ]
> +static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
> +				 struct net_device *dev, dma_addr_t addr)
> +{
[ ... ]
> +	tx_buff->ptr = xdpf;
> +	tx_buff->type = MACB_TYPE_XDP_TX;
> +	tx_buff->mapping = 0;
> +	tx_buff->size = xdpf->len;
> +	tx_buff->mapped_as_page = false;
> +
> +	ctrl = (u32)tx_buff->size;
> +	ctrl |= MACB_BIT(TX_LAST);

Could this write overwrite control bits in the descriptor if the XDP frame
length exceeds the hardware's maximum limit?

The hardware uses a 14-bit field for the frame length, with higher bits
reserved for control flags like TX_LAST and TX_WRAP. On architectures with
a PAGE_SIZE larger than 16KB (e.g., ARM64 ZynqMP with 64KB pages), an XDP
program can use bpf_xdp_adjust_tail() to legitimately increase the frame
length beyond this boundary.

Does this need a bounds check against the hardware's maximum supported
transmit size to prevent corrupted DMA operations?

[ ... ]
> @@ -1683,6 +1878,18 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
>  				queue->stats.rx_dropped++;
>  			}
>  
> +			headroom = bp->rx_headroom;
> +
> +			if (last_frame) {
> +				ret = gem_xdp_run(queue, buff_head, &data_len,
> +						  &headroom, addr - gem_rx_pad(bp));
> +				if (ret == XDP_REDIRECT)
> +					xdp_flush = true;
> +
> +				if (ret != XDP_PASS)
> +					goto next_frame;
> +			}
> +
>  			queue->skb = napi_build_skb(buff_head, gem_total_rx_buffer_size(bp));

Will this sequence allow multi-descriptor RX packets to silently bypass the
XDP program?

If a received packet spans multiple hardware descriptors (first_frame is true
but last_frame is false), the code skips gem_xdp_run() completely. It then
proceeds to allocate an sk_buff using napi_build_skb(), append subsequent
fragments on following loop iterations, and pass the assembled packet to the
network stack.

Shouldn't the driver explicitly drop packets that span multiple descriptors
when an XDP program is attached?

