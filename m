Return-Path: <netdev+bounces-272992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD8xOj+CyWmBygUAu9opvQ
	(envelope-from <netdev+bounces-272992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:49:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA1E353D5A
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3A7D300DF63
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9B3292B54;
	Sun, 29 Mar 2026 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIpP+rfU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F5F1C8634
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774813673; cv=none; b=B3YGURu+fPk/MxJX/jkiXjzTiR2fLy06t/DwmY6o4Q0GDjinHjsvIcjhv2CG/KKLBchRkJX0oJKIZBfKWXkprdV1dXHfDHn/EJGSmg/mdSHX2d8ty54wfVArx0ldhAB48cmQwnhtHdNvK4F4ix/E18gEk7Lr2d2oiTWUjFA1NQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774813673; c=relaxed/simple;
	bh=Pb4w/eaCQxIBwkeAzx0AsYwcBf04mixK9df36YJfOWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+62JKakNEyOuBwrGxyuBy5YwHtVluq18oyvB0r1fjZqY4YzR33rcxC2t2PpdIt6iGDdQXMuYkdjRELMs+e/B7PoOZQwXkaOgMy2BGykyZ14zRmRwIjvfsjtypxlSS1lxSwD55pUebZemSU9zVRZz6oJPnsLdjw3A6mLiXoWmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIpP+rfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68465C116C6;
	Sun, 29 Mar 2026 19:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774813672;
	bh=Pb4w/eaCQxIBwkeAzx0AsYwcBf04mixK9df36YJfOWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XIpP+rfUew0QDsCi/REfJDwxNiKcxTNNDV7i7B2zVVLwGaVrqIY53Umo4kOXfK8vh
	 7KO90kWS9JG6i4j2nYsvbqI0PCiT8dlbsWFB7tMoG153wRIqXsslVXCE2VZa6zjE4a
	 2boXwB2xHwzg7JMdQjqRZpmoOBGCM5GtGzRjk3e8w5xDrUJzLlckLCK8r4CnV5ob/Q
	 Bc7cN0QOurxONvWYVAcFk1pC9UQqLH/m7w+T2VLFWpdYDBivjR8v7CExkz+j7PiKpo
	 A94/CR78SA89a2vRdJ8sPjii3enkeQtyAbyJ1ZuOQBQ5SaFst/5hJMl1iHpf6Fbp+r
	 iisKup/aVRZKQ==
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
Subject: Re: [PATCH net-next v6 7/7] net: macb: introduce ndo_xdp_xmit support
Date: Sun, 29 Mar 2026 12:47:51 -0700
Message-ID: <20260329194751.2781563-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323221047.2749577-8-pvalerio@redhat.com>
References: <20260323221047.2749577-8-pvalerio@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-272992-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 6DA1E353D5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: macb: introduce ndo_xdp_xmit support

This commit introduces ndo_xdp_xmit support for the macb driver to
enable XDP redirection. It adds the gem_xdp_xmit function and updates
macb_xdp_submit_frame to handle DMA mapping for redirected frames.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 537d02264851..38b15d1e7127 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -1708,8 +1723,8 @@ static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
>  	desc = macb_tx_desc(queue, queue->tx_head);
>  	tx_buff = macb_tx_buff(queue, queue->tx_head);
>  	tx_buff->ptr = xdpf;
> -	tx_buff->type = MACB_TYPE_XDP_TX;
> -	tx_buff->mapping = 0;
> +	tx_buff->type = buff_type;
> +	tx_buff->mapping = dma_map ? mapping : 0;
>  	tx_buff->size = xdpf->len;

Is a bounds check needed on the frame length here?

Since ndo_xdp_xmit can receive frames redirected from other devices,
the frame length could potentially be up to ~64KB on architectures with
64KB pages.

macb_xdp_submit_frame() casts this length to a 32-bit integer and
bitwise-ORs it into the descriptor's control word, which has a 14-bit
length field (maximum 16383 bytes). Frame lengths exceeding this limit
could silently overflow into adjacent control bits like TX_LAST,
corrupting the descriptor ring.

[ ... ]

> +static int gem_xdp_xmit(struct net_device *dev, int num_frame,
> +			struct xdp_frame **frames, u32 flags)
> +{
> +	struct macb *bp = netdev_priv(dev);
> +	u32 xmitted = 0;
> +	int i;
> +
> +	if (!macb_is_gem(bp))
> +		return -EOPNOTSUPP;
> +
> +	if (unlikely(!netif_carrier_ok(dev)))
> +		return -ENETDOWN;
> +
> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> +		return -EINVAL;
> +
> +	for (i = 0; i < num_frame; i++) {
> +		if (macb_xdp_submit_frame(bp, frames[i], dev, true, 0))
> +			break;

Should this loop batch the doorbell rings based on the XDP_XMIT_FLUSH flag?

Currently, the code calls macb_xdp_submit_frame() for each frame, which
independently acquires the global bp->lock and performs an MMIO write to the
NCR register to ring the hardware doorbell per packet.

Doing this per packet ignores the batching semantics of the bulk transmission
API and could cause severe lock contention and MMIO overhead.

> +
> +		xmitted++;
> +	}
> +
> +	return xmitted;
> +}

