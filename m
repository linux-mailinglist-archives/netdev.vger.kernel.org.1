Return-Path: <netdev+bounces-251266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF137D3B75F
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4C1C3016AC1
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CB92D640D;
	Mon, 19 Jan 2026 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTUC/Hw2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930FC2741B5
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768851384; cv=none; b=fsNx+TVoAPpilCFrftvgXkQmOr4Hw5lh0oiqyBqtMzwsXPGx2NNrnH3eDW+gTm5QGZguU8DWeTqSNeliFmOQqt+9keq/tu1TRn+CwGzPf2obT8EJtf7FL0ECBJqqiYIDG4FO181XpC1OPNInzkFBqxOVC/i1g7/sN+609rYVzN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768851384; c=relaxed/simple;
	bh=zU5xfvssetDk/D/bLpJOfvxWgy2ZUGmMy3WSvXb4G3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Je7e5+r4zD1fGnzJRVk+cOzjqsVEpKJZdmEhw5WzW3fEeDn0GHudyeE2yyE0OBA8kCwrGkT05elJJ2ToSx0xUIbqM2M7CNNzsBgf3utNd3OtjFknOdeo1gxwRFz2orv/zZ8zqDVAP9J5Wh2iv/XSIL0LdvdJL8S1GyrRn/B2814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTUC/Hw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7820C116C6;
	Mon, 19 Jan 2026 19:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768851384;
	bh=zU5xfvssetDk/D/bLpJOfvxWgy2ZUGmMy3WSvXb4G3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kTUC/Hw2FqkV6IqqmSgy3kkZ4SaACBzNPSTjiaUS/fPBAeMgJoOMer0nmGC0+XRpf
	 OSrIRSkcQ1btgz6oJfNj9nIUUHoOQyFvvoCa7x6/LN74A4pm5urxuJnG4IGnpHojZg
	 1RwopJP5L/LstV+dre0r86u4vyA3YzunnArHlrViLyDyEGjZloVHdy8auoIPvRdJ9D
	 T5c3zPy/YVASFjPcE3oPy+KuBQiC1JvjMSHgDtbk51OBcD7JvWIahj0JPuweITAvEG
	 So7VzzWflspv1tTl6iW1lNGj+Zrs47FR4603bNiJapy/CJsSTNswxNEQAyKBshPLgb
	 xg1okOlTKN34w==
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
Subject: Re: [net-next,3/8] cadence: macb: Add page pool support handle multi-descriptor frame rx
Date: Mon, 19 Jan 2026 11:36:22 -0800
Message-ID: <20260119193622.1255610-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115222531.313002-4-pvalerio@redhat.com>
References: <20260115222531.313002-4-pvalerio@redhat.com>
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
cadence: macb: Add page pool support handle multi-descriptor frame rx

This patch converts the MACB/GEM driver from netdev_alloc_skb() to
page pool allocation and adds support for receiving frames that span
multiple DMA descriptors.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 19782f3f46f2..464bb7b2c04d 100644

[ ... ]

> @@ -1350,17 +1339,21 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
>  static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
>  		  int budget)
>  {
> +	struct skb_shared_info *shinfo;
>  	struct macb *bp = queue->bp;
> -	unsigned int		len;
> -	unsigned int		entry;
> -	struct sk_buff		*skb;
> -	struct macb_dma_desc	*desc;
> -	int			count = 0;
> +	struct macb_dma_desc *desc;
> +	unsigned int entry;
> +	struct page *page;
> +	void *buff_head;
> +	int count = 0;
> +	int data_len;
> +	int nr_frags;
> +
>
>  	while (count < budget) {
> -		u32 ctrl;
> +		bool rxused, first_frame, last_frame;
>  		dma_addr_t addr;
> -		bool rxused;
> +		u32 ctrl;

[ ... ]

> -		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
> -			netdev_err(bp->dev,
> -				   "not whole frame pointed by descriptor\n");
> -			bp->dev->stats.rx_dropped++;
> -			queue->stats.rx_dropped++;
> -			break;
> -		}
> -		skb = queue->rx_buff[entry];
> -		if (unlikely(!skb)) {
> +		buff_head = queue->rx_buff[entry];
> +		if (unlikely(!buff_head)) {
>  			netdev_err(bp->dev,
>  				   "inconsistent Rx descriptor chain\n");
>  			bp->dev->stats.rx_dropped++;
>  			queue->stats.rx_dropped++;
>  			break;
>  		}
> -		/* now everything is ready for receiving packet */
> -		queue->rx_buff[entry] = NULL;
> -		len = ctrl & bp->rx_frm_len_mask;
>
> -		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
> +		first_frame = ctrl & MACB_BIT(RX_SOF);
> +		last_frame = ctrl & MACB_BIT(RX_EOF);
> +
> +		if (last_frame) {
> +			data_len = ctrl & bp->rx_frm_len_mask;
> +			if (!first_frame)
> +				data_len -= queue->skb->len;
                                     ^^^^^^^^^^^^^^

If a descriptor arrives with RX_EOF set but RX_SOF clear (e.g., hardware
error or link reset mid-frame), and queue->skb is NULL from a previously
completed frame, this will dereference NULL. The check for queue->skb
being NULL at the "else" branch below happens after this calculation.
Should the data_len calculation be moved after the first_frame handling,
or should there be a NULL check on queue->skb before accessing its len?

> +		} else {
> +			data_len = bp->rx_buffer_size;
> +		}
> +
> +		if (first_frame) {

[ ... ]

> +		} else {
> +			if (!queue->skb) {
> +				netdev_err(bp->dev,
> +					   "Received non-starting frame while expecting it\n");
> +				goto free_frags;
> +			}
> +
> +			shinfo = skb_shinfo(queue->skb);
> +			page = virt_to_head_page(buff_head);
> +			nr_frags = shinfo->nr_frags;
> +
> +			if (nr_frags >= ARRAY_SIZE(shinfo->frags))
> +				goto free_frags;
> +
> +			skb_add_rx_frag(queue->skb, nr_frags, page,
> +					buff_head - page_address(page) + bp->rx_headroom,
> +					data_len, gem_total_rx_buffer_size(bp));
> +		}

[ ... ]

> +	free_frags:
> +		if (queue->skb) {
> +			dev_kfree_skb(queue->skb);
> +			queue->skb = NULL;
> +		} else {
> +			page_pool_put_full_page(queue->page_pool,
> +						virt_to_head_page(buff_head),
> +						false);
> +		}

When the fragment overflow check (nr_frags >= ARRAY_SIZE) triggers,
queue->skb is non-NULL so dev_kfree_skb() runs. However, the current
buff_head (the fragment that could not be added) is not returned to
the page pool since the else branch is not taken. Does this leak the
page for that buffer?

> +
> +		bp->dev->stats.rx_dropped++;
> +		queue->stats.rx_dropped++;
> +		queue->rx_buff[entry] = NULL;
>  	}

[ ... ]

> +static int gem_create_page_pool(struct macb_queue *queue)
> +{
> +	struct page_pool_params pp_params = {
> +		.order = 0,
> +		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +		.pool_size = queue->bp->rx_ring_size,
> +		.nid = NUMA_NO_NODE,
> +		.dma_dir = DMA_FROM_DEVICE,
> +		.dev = &queue->bp->pdev->dev,
> +		.napi = &queue->napi_rx,
> +		.max_len = PAGE_SIZE,
> +	};
> +	struct page_pool *pool;
> +	int err = 0;
> +
> +	pool = page_pool_create(&pp_params);
> +	if (IS_ERR(pool)) {
> +		netdev_err(queue->bp->dev, "cannot create rx page pool\n");
> +		err = PTR_ERR(pool);
> +		pool = NULL;
> +	}
> +
> +	queue->page_pool = pool;
> +
> +	return err;
> +}

[ ... ]

> @@ -2607,12 +2698,24 @@ static int gem_init_rings(struct macb *bp, bool fail_early)
>  		queue->rx_tail = 0;
>  		queue->rx_prepared_head = 0;
>
> +		/* This is a hard failure, so the best we can do is try the
> +		 * next queue in case of HRESP error.
> +		 */
> +		err = gem_create_page_pool(queue);
                      ^^^^^^^^^^^^^^^^^^^^^^^^

When macb_hresp_error_task() calls gem_init_rings(bp, false), this
creates a new page pool without destroying the existing one. The old
queue->page_pool pointer is overwritten, leaking the previous page pool.
Additionally, the rx_buff[] entries still reference pages from the old
pool. When those buffers are later processed in gem_rx() and returned
via page_pool_put_full_page(), they would be returned to the new pool
instead of their original pool. Should the old page pool be destroyed
and rx buffers cleaned up before creating the new pool in the HRESP
recovery path?

> +		if (err) {
> +			last_err = err;
> +			if (fail_early)
> +				break;
> +
> +			continue;
> +		}

[ ... ]

