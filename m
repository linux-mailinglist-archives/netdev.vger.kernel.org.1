Return-Path: <netdev+bounces-255700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vH3BCbgagGls2wIAu9opvQ
	(envelope-from <netdev+bounces-255700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 04:32:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A60C80D5
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 04:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3647530062F7
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 03:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16AD21D5BC;
	Mon,  2 Feb 2026 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r4TBnQbh"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE248CFC
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770003123; cv=none; b=bl7RaJ9qbR9L6x3l9ufcGmrk4jd282W1AeZgBCfkP6PYL8YK1bdwhwgTTRCGvIA9NZpSxJ7AFm73s+Nz7/Yx6KTIBFwQISTxo3dFEbZM/0P8u+U3GIEePW6cBZRC4nkmfyfpSqhEUv+0WlIMyh/ufwjbE+KBodZyB0i9GDZwO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770003123; c=relaxed/simple;
	bh=IX6Jo8Ihn1Vpv4+UaYg3ZLYFp4RM085sv1RB2EaPfMo=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Nwp6/CVqZx29/cVNNSDOidBWy+/cG+qT5BZZxvcgfjWWiNzJ3KzB0CX+2FiXBOaEnYJ31UYSFj+k70e8DEKdPsRUdw4om/dNTpSGO25A8QZdo2Oc+w6ZfItzej/bQkOLK+Xt9u5X84Ida/nmLL9DE0LU0kOI/6dPRvXAJixc5+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r4TBnQbh; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770003116; h=Message-ID:Subject:Date:From:To;
	bh=49zk2btPVFNY7x4l1bBCULgTNxOWwveuN6O0Jo5im+k=;
	b=r4TBnQbhFYsr/IBCOcj7FCrClpgfjykNtXqE9DeKVJNGPnz8hlAZcraDVAzkmhaV4Gw4PZl0WsF4QTn1nVSe2r/SwAZgqT1mZM2E20Nsg2/yxFBdVUo7e7d13m20DuQ7D2FrVfoPqTFuiaafpDgmI2CT72mkTQfcWLBGmBG80q0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WyIoPfz_1770003115 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Feb 2026 11:31:55 +0800
Message-ID: <1770002612.3297296-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [net-next,v24,4/6] eea: create/destroy rx,tx queues for netdevice open and stop
Date: Mon, 2 Feb 2026 11:23:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
 lorenzo@kernel.org,
 andrew+netdev@lunn.ch,
 hkallweit1@gmail.com,
 dust.li@linux.alibaba.com,
 edumazet@google.com,
 davem@davemloft.net,
 pabeni@redhat.com,
 lulie@linux.alibaba.com,
 andrew@lunn.ch,
 netdev@vger.kernel.org,
 guwen@linux.alibaba.com,
 dong100@mucse.com,
 lukas.bulwahn@redhat.com,
 vadim.fedorenko@linux.dev,
 enelsonmoore@gmail.com
References: <20260130093412.98407-1-xuanzhuo@linux.alibaba.com>
 <20260130093412.98407-5-xuanzhuo@linux.alibaba.com>
 <20260130233243.923376-1-kuba@kernel.org>
In-Reply-To: <20260130233243.923376-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,linux.alibaba.com,google.com,davemloft.net,redhat.com,vger.kernel.org,mucse.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255700-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 69A60C80D5
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 15:32:43 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> eea: create/destroy rx,tx queues for netdevice open and stop
>
> This commit introduces the implementation for netdevice open and stop in
> the Alibaba Elastic Ethernet Adapter (EEA) driver, including RX/TX queue
> allocation, NAPI setup, and resource management.

[...]

>
>
> > +	}
> > +
> > +	err = eea_active_ring_and_irq(enet);
> > +	if (err) {
> > +		netdev_err(enet->netdev,
> > +			   "eea reset: active new ring and irq failed. err %d\n",
> > +			   err);
> > +		return err;
>
> Does this code leak the newly allocated queues when eea_active_ring_and_irq
> fails?
>
> In this scenario:
> 1. New queues allocated in ctx at line 277
> 2. Old queues freed by eea_netdev_stop at line 285
> 3. enet_bind_new_q_and_cfg succeeds at line 294, transferring ctx->rx and
>    ctx->tx to enet->rx and enet->tx
> 4. eea_active_ring_and_irq fails at line 303
> 5. Function returns at line 308 without freeing enet->rx and enet->tx
>
> The newly allocated and transferred resources remain in enet->rx and
> enet->tx but are never freed. The comment at lines 287-292 claims resources
> are deferred for cleanup, but there is no mechanism to track these orphaned
> resources for later cleanup.



The mechanism of the netdev close does this.


>
> [ ... ]
>
> > +static void eea_meta_free_xmit(struct eea_net_tx *tx, struct eea_tx_meta *meta,
> > +			       int budget)
> > +{
> > +	struct eea_net_stats *stats = &tx->stats;
> > +
> > +	++stats->packets;
> > +	stats->bytes += meta->skb->len;
> > +	napi_consume_skb(meta->skb, budget);
>
> The second parameter to napi_consume_skb() should be a boolean indicating
> NAPI context (0 or non-zero), not the actual budget value.
>
> Jakub Kicinski raised this concern in v21 review, referencing commit
> cd18e8ac030e646 which added kdoc clarifying this. The current code passes
> 'budget' (which could be any positive integer like 64) instead of just 1 to
> indicate NAPI context. While the function still works correctly (any
> non-zero value indicates NAPI context), using the budget value is
> semantically incorrect.
>
> Reference: https://lore.kernel.org/netdev/20260121170658.371e0e63@kernel.org/


I think the parameter budget should be an int value from NAPI context.


>
> > +	meta->skb = NULL;
> > +
> > +	eea_tx_meta_put_and_unmap(tx, meta);
> > +}
>
> [ ... ]
>
> [ ... ]
>
> > +static struct eea_tx_meta *eea_tx_desc_fill(struct eea_net_tx *tx,
> > +					    dma_addr_t addr, u32 size,
> > +					    bool is_last, struct sk_buff *skb,
> > +					    u32 flags)
> > +{
> > +	struct eea_tx_desc *desc;
> > +	struct eea_tx_meta *meta;
> > +
> > +	meta = eea_tx_meta_get(tx);
> > +
> > +	desc = ering_sq_alloc_desc(tx->ering, meta->id, is_last, flags);
>
> Can this code dereference a NULL pointer?


The validation performed after packet posting is sufficient, as large fragmented
packets do not affect this check. The below follows the same principle.

Thanks.

>
> eea_tx_meta_get() can return NULL when the free list is exhausted (tx->free
> is NULL, as seen in lines 40-41 of eea_tx_meta_get). When NULL is returned,
> line 182 unconditionally dereferences meta->id without checking if meta is
> NULL, causing a kernel crash.
>
> The TX queue flow control check (netif_txq_maybe_stop) happens AFTER packet
> posting in eea_tx_xmit (line 280), not before. When the ring is under heavy
> load with fragmented packets, the meta free list can be exhausted before the
> queue is stopped.
>
> The meta array has cfg.tx_ring_depth entries (allocated at line 360 in
> eea_alloc_tx). Each packet can consume 1 + nr_frags meta entries (up to
> MAX_SKB_FRAGS + 1). With small ring depths and many large fragmented packets
> in flight, the free list can be completely exhausted.
>
> Call path:
> Network stack -> eea_tx_xmit -> eea_tx_post_skb (line 274) ->
> eea_tx_desc_fill (line 231) -> eea_tx_meta_get (line 180) returns NULL ->
> line 182 crashes.
>
> > +
> > +	meta->data = (void *)skb;
> > +	meta->dma = addr;
> > +	meta->desc = desc;
> > +
> > +	return meta;
> > +}
>
> [ ... ]
>
> > +static int eea_tx_post_skb(struct sk_buff *skb, struct eea_net_tx *tx,
> > +			   int flags)
> > +{
> > +	dma_addr_t addr;
> > +	u32 hlen;
> > +	struct skb_shared_info *shinfo = skb_shinfo(skb);
> > +	struct eea_tx_meta *meta;
> > +	int err, last = 0;
> > +	struct device *dmadev;
> > +
> > +	dmadev = ering_get_dma_device(tx->ering);
> > +
> > +	hlen = skb_headlen(skb);
> > +
> > +	addr = dma_map_single(dmadev, skb->data, hlen, DMA_TO_DEVICE);
> > +	if (dma_mapping_error(dmadev, addr))
> > +		return -ENOMEM;
> > +
> > +	meta = eea_tx_desc_fill(tx, addr, hlen, !shinfo->nr_frags, skb, flags);
> > +
> > +	if (eea_fill_desc_from_skb(skb, tx->ering, meta->desc))
>
> Can this code dereference a NULL pointer?
>
> eea_tx_desc_fill() at line 231 can return NULL when the meta free list is
> exhausted (root cause explained earlier). Line 233 unconditionally
> dereferences meta->desc without checking if meta is NULL.
>
> This is a consequence of the same underlying issue: the TX queue flow
> control happens after packet posting rather than before.
>
> Call path:
> eea_tx_xmit (line 274) -> eea_tx_post_skb -> eea_tx_desc_fill (line 231)
> returns NULL -> line 233 crashes accessing meta->desc.
>
> > +		goto err_cancel;
>
> [ ... ]

