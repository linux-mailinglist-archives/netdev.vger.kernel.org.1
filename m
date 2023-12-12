Return-Path: <netdev+bounces-56572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C8980F6BB
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E982F1C20B9C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 19:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB32D81E51;
	Tue, 12 Dec 2023 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNxbmsS/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB95DF06
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 19:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9E4C433C8;
	Tue, 12 Dec 2023 19:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702409534;
	bh=TY0fTx0ctTq290WnoWAWUZDkJDQeQKPE92XPLQbudrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZNxbmsS/+h1vg1YDha+zs73ry/J6JwD9wUqhXowYooyJXnc44pEUjmKhLQx1Mccdg
	 kp/fOLDBP/VN2SkWVyFbkoQIfdPhk1LY6Ssd1gF99lkSc/nNyP/BS859V6zdU3/dDM
	 cPvs3qwtLTYvWOAp/csw9reTXvq578vQePaIA5WReWVOmdqAYUA8eRNSqT7Yxb/6nN
	 g9zWOYXZByVNKBeAtw+LzrjWitaL/efLkvAa3XQ6amXDrpFyuoe8wFwd8RieVCN1Ye
	 1fL40FWifvmwR0psB1eBxwUflDm/kuU629zzOnmDVMJ6Nf9ETF2YdCAZ5PgYZBNMPK
	 NB08Xl1EqSiRw==
Date: Tue, 12 Dec 2023 11:32:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v14 06/13] rtase: Implement .ndo_start_xmit
 function
Message-ID: <20231212113212.1cfb9e19@kernel.org>
In-Reply-To: <20231208094733.1671296-7-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
	<20231208094733.1671296-7-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Dec 2023 17:47:26 +0800 Justin Lai wrote:
> +static int tx_handler(struct rtase_ring *ring, int budget)

I don't see how this is called, the way you split the submission makes
it a bit hard to review, oh well. Anyway - if you pass the NAPI budget
here - that's not right, it may be 0, and you'd loop forever.
For Tx - you should try to reap some fixed number of packets, say 128,
the budget is for Rx, not for Tx.

> +	const struct rtase_private *tp = ring->ivec->tp;
> +	struct net_device *dev = tp->dev;
> +	int workdone = 0;
> +	u32 dirty_tx;
> +	u32 tx_left;
> +
> +	dirty_tx = ring->dirty_idx;
> +	tx_left = READ_ONCE(ring->cur_idx) - dirty_tx;
> +
> +	while (tx_left > 0) {
> +		u32 entry = dirty_tx % NUM_DESC;
> +		struct tx_desc *desc = ring->desc +
> +				       sizeof(struct tx_desc) * entry;
> +		u32 len = ring->mis.len[entry];
> +		u32 status;
> +
> +		status = le32_to_cpu(desc->opts1);
> +
> +		if (status & DESC_OWN)
> +			break;
> +
> +		rtase_unmap_tx_skb(tp->pdev, len, desc);
> +		ring->mis.len[entry] = 0;
> +		if (ring->skbuff[entry]) {
> +			dev_consume_skb_any(ring->skbuff[entry]);

napi_consume_skb, assuming you call this from NAPI

> +			ring->skbuff[entry] = NULL;
> +		}
> +
> +		dev->stats.tx_bytes += len;
> +		dev->stats.tx_packets++;
> +		dirty_tx++;
> +		tx_left--;
> +		workdone++;
> +
> +		if (workdone == budget)
> +			break;
> +	}
> +
> +	if (ring->dirty_idx != dirty_tx) {
> +		WRITE_ONCE(ring->dirty_idx, dirty_tx);
> +
> +		if (__netif_subqueue_stopped(dev, ring->index) &&
> +		    rtase_tx_avail(ring))
> +			netif_start_subqueue(dev, ring->index);

Please use the start / stop macros from include/net/netdev_queues.h
I'm pretty sure the current code is racy.

> +		if (ring->cur_idx != dirty_tx)
> +			rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
> +	}
> +
> +	return workdone;
> +}

> +	/* multiqueues */
> +	q_idx = skb_get_queue_mapping(skb);
> +	ring = &tp->tx_ring[q_idx];

As Paolo pointed out elsewhere you seem to only support one queue.
Remove this indirection, please, and always use queue 0, otherwise
it's a bit confusing.

