Return-Path: <netdev+bounces-251268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B01D3B762
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FAFF306A405
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F423B2DC77F;
	Mon, 19 Jan 2026 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iv4X1MZa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB132D7DF3
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768851387; cv=none; b=O64qsrEaBbZhmeJai39//Ibp+MjqW4mP3o+4tLdDPUx9/dUKuBgVuDytLfpIR4w+v1Z9K5VIXEWNXPhGr7LfRoLm4I3Mk/HuqAgUZQue57LlPXk0nBaZhi9OWUXltFp54iTY1OvETeq+xe5ptTicuODvoTC7xvPq6CmDm5xo/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768851387; c=relaxed/simple;
	bh=n+79UUo0vjH04ePNO2YSSxR1uFmtREdFYXUzVVfaFV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpwrV0rV8aYLVpC7TG78INOegh7BRlPeAzE49E0lrk0UqxFsQmsQlHJOAoPeJ6lCWS3fLD28s/CZJx0x/ESoL3QmbHFo50hHf5bVfaegocErCP4j/BAeFbuO3oe1KOYgdI/yzN3f+EcAh7bBKHSX01RXp1cpd1IFzinyAwClsk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iv4X1MZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3675CC116C6;
	Mon, 19 Jan 2026 19:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768851387;
	bh=n+79UUo0vjH04ePNO2YSSxR1uFmtREdFYXUzVVfaFV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iv4X1MZaEsJadtHF8Es3byO+ENgRO+6DJ5JZfajmUCg73Ga6M679uJxLsLeJl9Boa
	 3T+H+Cjjd0lftl9sxNL3wURlWZ7TmzZupYfNncTweWT+/6hLBl3cZ0qwybRacB7VK8
	 i0y4ETlm097LrjboCB9nAq5KjYOO5fbn7J9WNflYDGK2yH95vcilpaT1NXdDyyJjB0
	 hA+SgrJ+ZCn0Of01DsOUy8TarbTbIXTTCi8Hl7UJEqcy/OWvQ37InIYIrpk2/KZ3/2
	 TxhMGMJOqCVRHLfH6geKNBdbVFQ48Qs56WC/twptHHO72+75srFuhtpUCAMQ0xHs4p
	 dw8wopS0NTpPg==
From: Jakub Kicinski <kuba@kernel.org>
To: pvalerio@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	lorenzo@kernel.org,
	claudiu.beznea@tuxon.dev,
	nicolas.ferre@microchip.com,
	theo.lebrun@bootlin.com,
	netdev@vger.kernel.org,
	edumazet@google.com
Subject: Re: [net-next,8/8] cadence: macb: introduce xmit support
Date: Mon, 19 Jan 2026 11:36:26 -0800
Message-ID: <20260119193626.1255791-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115222531.313002-9-pvalerio@redhat.com>
References: <20260115222531.313002-9-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
cadence: macb: introduce xmit support

This patch adds XDP_TX verdict support and introduces the ndo_xdp_xmit
function for XDP redirection.  It updates macb_tx_unmap() to handle both
skbs and xdp frames.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index afd8c0f2d895..32f8629bcb25 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -983,7 +994,7 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
>  	}
>
>  	if (tx_buff->ptr) {
> -		napi_consume_skb(tx_buff->ptr, budget);
> +		release_buff(tx_buff->ptr, tx_buff->type, budget);
>  		tx_buff->ptr = NULL;
>  	}
>  }

[ ... ]

> +static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
> +				 struct net_device *dev, bool dma_map,
> +				 dma_addr_t addr)
> +{

[ ... ]

> +	if (dma_map) {
> +		mapping = dma_map_single(&bp->pdev->dev,
> +					 xdpf->data,
> +					 xdpf->len, DMA_TO_DEVICE);
> +		if (unlikely(dma_mapping_error(&bp->pdev->dev, mapping))) {
> +			err = -ENOMEM;
> +			goto unlock;
> +		}
> +	} else {
> +		mapping = addr;
> +		dma_sync_single_for_device(&bp->pdev->dev, mapping,
> +					   xdpf->len, DMA_BIDIRECTIONAL);
> +	}

[ ... ]

> +	tx_buff->ptr = xdpf;
> +	tx_buff->type = buff_type;
> +	tx_buff->mapping = mapping;
                          ^^^^^^^

For XDP_TX (dma_map=false), the mapping here is the page pool's DMA address
passed via the addr parameter.  Later, macb_tx_unmap() unconditionally calls
dma_unmap_single() when tx_buff->mapping is non-zero.

Should macb_tx_unmap() skip the DMA unmap for MACB_TYPE_XDP_TX buffers?
Page pool manages its own DMA mappings, and calling dma_unmap_single() on
them appears incorrect.  For comparison, stmmac_tx_clean() explicitly
checks "buf_type != STMMAC_TXBUF_T_XDP_TX" before unmapping.

[ ... ]

> +	case XDP_TX:
> +		xdpf = xdp_convert_buff_to_frame(&xdp);
> +
> +		if (!xdpf || macb_xdp_submit_frame(queue->bp, xdpf, dev, false,
> +						   addr))
> +			act = XDP_DROP;
> +		goto out;

When xdp_convert_buff_to_frame() returns NULL, this sets act = XDP_DROP but
then unconditionally executes "goto out", which skips the page_pool_put_full_page()
call that handles XDP_DROP.  Could this leak the page when
xdp_convert_buff_to_frame() fails due to insufficient headroom?

When macb_xdp_submit_frame() fails, it internally calls release_buff() which
returns the page, so that path seems fine.  But the xdpf == NULL case appears
to need a "break" instead of falling through to "goto out".

