Return-Path: <netdev+bounces-251323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9D8D3BAFE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 23:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C7E0300462F
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BAF271456;
	Mon, 19 Jan 2026 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+qEu45h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96D21A256B
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768862545; cv=none; b=Op0M9zkCtfqHA2C3cH2oLTqEFqKE6LC3+cAQV0ZJ29fLzrnoffusb0CCGfjAOT72B5UB4h1SOPxeljcgwRm1HJUqD4DtZqbdf7UWRmfT9WZq+uFLYsbV+9lV/1cCF8Fews5ogl2bLHqlQIQFOnuRPLPGZ2O6kSl/HEqEjHBtoDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768862545; c=relaxed/simple;
	bh=tkX+tD9U5oooed5Xc7XrbMPPC9KCKgt3geH6UYnrjJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+59sdKWO4h0Lpw7SAPwwMwVhO/YeMds75xyW1SVoxQWaaWRLqK2e0As/1hMK/DQIkp9Yev03RId1/aqP22NHEOLr6yL8zNf1TZruUHI1Ol0MCPVFlpSsmqiekSi/xg+1sduRcTxakRMaWip9BibluR5gliUsXOyNFC717rpBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+qEu45h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D71C116C6;
	Mon, 19 Jan 2026 22:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768862545;
	bh=tkX+tD9U5oooed5Xc7XrbMPPC9KCKgt3geH6UYnrjJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+qEu45h9sQ6EMejKSZDEQgCRp4iK54HvMgM3f1UjXtGAjadZiJBSHVClWIx0Q6By
	 egZDPMjGigCywb7wpkwMQntD6vVhZ/e2YTkp3aJ6JSVz9GH7x8Kvik1XIXFKTllkNB
	 GqyOMQUGPiuxWikKlL252iVzeILhRgmRc55e5edlVZa1FRhHTb2tu+4xKcClrnDe+m
	 UYZIEUeCLGKBzu2BFV/TXAlvVDBVCI95eJQG2Mp7CTyyUrumwgmrEI18xXP9QS1+X6
	 0bN3NUhTrWf4pmPnBS6o399VOV+kd7mahkli48xUsfs0qKM4EFqahzAFjZm+5BE46y
	 0sNVoWA1CtalA==
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	dust.li@linux.alibaba.com,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	dong100@mucse.com,
	guwen@linux.alibaba.com,
	lorenzo@kernel.org,
	edumazet@google.com,
	lulie@linux.alibaba.com,
	lukas.bulwahn@redhat.com
Subject: Re: [net-next,v20,4/6] eea: create/destroy rx,tx queues for netdevice open and stop
Date: Mon, 19 Jan 2026 14:42:17 -0800
Message-ID: <20260119224217.1362965-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115031042.104164-5-xuanzhuo@linux.alibaba.com>
References: <20260115031042.104164-5-xuanzhuo@linux.alibaba.com>
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
eea: create/destroy rx,tx queues for netdevice open and stop

This commit adds netdevice open and stop operations for the EEA driver,
including TX and RX queue allocation/deallocation and NAPI setup.

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/ethernet/alibaba/eea/eea_tx.c
> new file mode 100644
> index 000000000000..f3e648960918
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_tx.c

[ ... ]

> +static void eea_tx_meta_put_and_unmap(struct eea_net_tx *tx,
> +				      struct eea_tx_meta *meta)
> +{
> +	struct eea_tx_meta *head;
> +
> +	head = meta;
> +
> +	while (true) {
> +		dma_unmap_single(tx->dma_dev, meta->dma_addr,
> +				 meta->dma_len, DMA_TO_DEVICE);
> +
> +		meta->data = NULL;
> +
> +		if (meta->next) {
> +			meta = meta->next;
> +			continue;
> +		}
> +
> +		break;
> +	}
> +
> +	meta->next = tx->free;
> +	tx->free = head;
> +}
> +
> +static void eea_meta_free_xmit(struct eea_net_tx *tx,
> +			       struct eea_tx_meta *meta,
> +			       bool in_napi,
> +			       struct eea_tx_cdesc *desc,
> +			       struct eea_sq_free_stats *stats)
> +{
> +	struct sk_buff *skb = meta->skb;
> +
> +	if (!skb) {
> +		netdev_err(tx->enet->netdev,
> +			   "tx meta->skb is null. id %d num: %d\n",
> +			   meta->id, meta->num);
> +		return;
> +	}
> +
> +	if (unlikely((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && desc)) {
> +		struct skb_shared_hwtstamps ts = {};
> +
> +		ts.hwtstamp = EEA_DESC_TS(desc) + tx->enet->hw_ts_offset;
> +		skb_tstamp_tx(skb, &ts);
> +	}
> +
> +	stats->bytes += meta->skb->len;
> +	napi_consume_skb(meta->skb, in_napi);
> +}

[ ... ]

> +static u32 eea_clean_tx(struct eea_net_tx *tx)
> +{
> +	struct eea_sq_free_stats stats = {0};
> +	struct eea_tx_cdesc *desc;
> +	struct eea_tx_meta *meta;
> +
> +	while ((desc = ering_cq_get_desc(tx->ering))) {
> +		++stats.packets;
> +
> +		meta = &tx->meta[le16_to_cpu(desc->id)];
> +
> +		eea_meta_free_xmit(tx, meta, true, desc, &stats);
> +
> +		ering_cq_ack_desc(tx->ering, meta->num);
> +		eea_tx_meta_put_and_unmap(tx, meta);
> +	}
> +
> +	return stats.packets;
> +}

[ ... ]

> +static int eea_tx_post_skb(struct eea_net_tx *tx, struct sk_buff *skb)
> +{
> +	const struct skb_shared_info *shinfo = skb_shinfo(skb);
> +	u32 hlen = skb_headlen(skb);
> +	struct eea_tx_meta *meta;
> +	dma_addr_t addr;
> +	int i, err;
> +	u16 flags;
> +
> +	addr = dma_map_single(tx->dma_dev, skb->data, hlen, DMA_TO_DEVICE);
> +	if (unlikely(dma_mapping_error(tx->dma_dev, addr)))
> +		return -ENOMEM;

[ ... ]

> +static void eea_free_meta(struct eea_net_tx *tx, struct eea_net_cfg *cfg)
> +{
> +	struct eea_sq_free_stats stats;
> +	struct eea_tx_meta *meta;
> +	int i;
> +
> +	while ((meta = eea_tx_meta_get(tx)))
> +		meta->skb = NULL;
> +
> +	for (i = 0; i < cfg->tx_ring_depth; i++) {
> +		meta = &tx->meta[i];
> +
> +		if (!meta->skb)
> +			continue;
> +
> +		eea_meta_free_xmit(tx, meta, false, NULL, &stats);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In eea_clean_tx(), after calling eea_meta_free_xmit(), there is a call to
eea_tx_meta_put_and_unmap() which performs dma_unmap_single() for the DMA
mappings.

Here in eea_free_meta(), only eea_meta_free_xmit() is called but
eea_tx_meta_put_and_unmap() is not. The DMA mappings created in
eea_tx_post_skb() via dma_map_single() and skb_frag_dma_map() would not
be unmapped when the device is closed with pending TX packets. Does this
leak DMA mappings?

> +
> +		meta->skb = NULL;
> +	}
> +
> +	kvfree(tx->meta);
> +	tx->meta = NULL;
> +}
-- 
pw-bot: cr

