Return-Path: <netdev+bounces-261670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK+fMsX5oGlXogQAu9opvQ
	(envelope-from <netdev+bounces-261670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:56:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F26461B1AE3
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8845930372E5
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01492C11C2;
	Fri, 27 Feb 2026 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oQKQ+N6v"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985B62C0260
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 01:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157360; cv=none; b=oBnK2jLRPbdiSRDKNgu1oxqCwgTrkjq0nFBcRyy+X3G8+Z1795UEWybItHyUsMStAmvVw5BPee/dATcOs6UWQuP0QMLITx54ULfMfWZkhKE2v1EoSTrXq5iY0MgI4kqVfgt73BzsakQTnIA0Itpvfu0cq5KSUUps/sVr9I7/jg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157360; c=relaxed/simple;
	bh=Cy7QD+jarlKL2UTKUJgIsk/sA7hdD2N1gfco56paJvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=caGZJGY/WJ8SUttzQ8TliORCRTr4bfyy6HF8cK9v+V6pwC+/Dn81J9t+XA7XC4wZbNEydiQ+BJhuaycGagbJdRcYcDzqpB2Pokb2Q2b6GFg4tU5a+Ai4EEyLQL8FcF84G4xkpvG3jKwXrOnn2tWbX1lMnXbRcsKnZfg9tCJFkDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oQKQ+N6v; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772157351; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=anv9pRvECt+47JpwsXiEKO3zF57GTmHIq6DI9R404S4=;
	b=oQKQ+N6vFOcPSTKmvsaH0YZlGO63FujgYFGplznZZE4zKQOsn3fiLlYeqGvN0h8MyjNkR7g3a20lW9hdYqCXtN5mT2G6CT0tiLygzHY9xBRaEHsUYrjkyjM1b+IpJgvpuba3ezHNU3834WRJdFIeAgWRKluYMZ0pAZG4I0h2bEk=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WzsXoPy_1772157349 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Feb 2026 09:55:50 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Dong Yibo <dong100@mucse.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v27 5/8] eea: implement packet receive logic
Date: Fri, 27 Feb 2026 09:55:43 +0800
Message-Id: <20260227015546.47336-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260227015546.47336-1-xuanzhuo@linux.alibaba.com>
References: <20260227015546.47336-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: f713bd6bad2c
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261670-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: F26461B1AE3
X-Rspamd-Action: no action

Implement the core logic for receiving packets in the EEA RX path,
including packet buffering and basic validation.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/eea_net.h |   2 +
 drivers/net/ethernet/alibaba/eea/eea_rx.c  | 475 ++++++++++++++++++++-
 2 files changed, 475 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
index 0398e781dfdb..5a607947a76e 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -62,6 +62,7 @@ struct eea_net_rx_pkt_ctx {
 	bool data_valid;
 	bool do_drop;
 
+	u32 recv_len;
 	struct sk_buff *head_skb;
 	struct sk_buff *curr_skb;
 };
@@ -166,6 +167,7 @@ void eea_init_ctx(struct eea_net *enet, struct eea_net_init_ctx *ctx);
 int eea_queues_check_and_reset(struct eea_device *edev);
 
 /* rx apis */
+
 void enet_rx_stop(struct eea_net_rx *rx);
 void enet_rx_start(struct eea_net_rx *rx);
 
diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/ethernet/alibaba/eea/eea_rx.c
index a8695704d67d..db74580f296c 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_rx.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_rx.c
@@ -16,6 +16,41 @@
 
 #define EEA_PAGE_FRAGS_NUM 1024
 
+#define EEA_RX_BUF_ALIGN 128
+
+struct eea_rx_ctx {
+	void *buf;
+
+	u32 len;
+	u32 hdr_len;
+
+	u16 flags;
+	bool more;
+
+	u32 frame_sz;
+
+	struct eea_rx_meta *meta;
+};
+
+static struct eea_rx_meta *eea_rx_meta_get(struct eea_net_rx *rx)
+{
+	struct eea_rx_meta *meta;
+
+	if (!rx->free)
+		return NULL;
+
+	meta = rx->free;
+	rx->free = meta->next;
+
+	return meta;
+}
+
+static void eea_rx_meta_put(struct eea_net_rx *rx, struct eea_rx_meta *meta)
+{
+	meta->next = rx->free;
+	rx->free = meta;
+}
+
 static void eea_free_rx_buffer(struct eea_net_rx *rx, struct eea_rx_meta *meta)
 {
 	u32 drain_count;
@@ -28,6 +63,63 @@ static void eea_free_rx_buffer(struct eea_net_rx *rx, struct eea_rx_meta *meta)
 	meta->page = NULL;
 }
 
+static void meta_align_offset(struct eea_net_rx *rx, struct eea_rx_meta *meta)
+{
+	int h, b;
+
+	h = rx->headroom;
+	b = meta->offset + h;
+
+	/* For better performance, we align the buffer address to
+	 * EEA_RX_BUF_ALIGN, as required by the device design.
+	 */
+	b = ALIGN(b, EEA_RX_BUF_ALIGN);
+
+	meta->offset = b - h;
+}
+
+static int eea_alloc_rx_buffer(struct eea_net_rx *rx, struct eea_rx_meta *meta)
+{
+	struct page *page;
+
+	if (meta->page)
+		return 0;
+
+	page = page_pool_dev_alloc_pages(rx->pp);
+	if (!page)
+		return -ENOMEM;
+
+	page_pool_fragment_page(page, EEA_PAGE_FRAGS_NUM);
+
+	meta->page = page;
+	meta->dma = page_pool_get_dma_addr(page);
+	meta->offset = 0;
+	meta->frags = 0;
+
+	meta_align_offset(rx, meta);
+
+	return 0;
+}
+
+static void eea_consume_rx_buffer(struct eea_net_rx *rx,
+				  struct eea_rx_meta *meta,
+				  u32 consumed)
+{
+	int min;
+
+	meta->offset += consumed;
+	++meta->frags;
+
+	min = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	min += rx->headroom;
+	min += ETH_DATA_LEN;
+
+	meta_align_offset(rx, meta);
+
+	if (min + meta->offset > PAGE_SIZE)
+		eea_free_rx_buffer(rx, meta);
+}
+
 static void eea_free_rx_hdr(struct eea_net_rx *rx, struct eea_net_cfg *cfg)
 {
 	struct eea_rx_meta *meta;
@@ -88,12 +180,391 @@ static int eea_alloc_rx_hdr(struct eea_net_init_ctx *ctx, struct eea_net_rx *rx)
 	return 0;
 }
 
-static int eea_poll(struct napi_struct *napi, int budget)
+static void eea_rx_meta_dma_sync_for_cpu(struct eea_net_rx *rx,
+					 struct eea_rx_meta *meta, u32 len)
+{
+	dma_sync_single_for_cpu(rx->enet->edev->dma_dev,
+				meta->dma + meta->offset + meta->headroom,
+				len, DMA_FROM_DEVICE);
+}
+
+static int eea_harden_check_overflow(struct eea_rx_ctx *ctx,
+				     struct eea_net *enet)
+{
+	u32 max_len;
+
+	max_len = ctx->meta->truesize - ctx->meta->headroom -
+		ctx->meta->tailroom;
+
+	if (unlikely(ctx->len > max_len)) {
+		pr_debug("%s: rx error: len %u exceeds truesize %u\n",
+			 enet->netdev->name, ctx->len, max_len);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int eea_harden_check_size(struct eea_rx_ctx *ctx, struct eea_net *enet)
 {
-	/* Empty function; will be implemented in a subsequent commit. */
+	int err;
+
+	err = eea_harden_check_overflow(ctx, enet);
+	if (err)
+		return err;
+
+	if (ctx->hdr_len) {
+		if (unlikely(ctx->hdr_len < ETH_HLEN)) {
+			pr_debug("%s: short packet %u\n", enet->netdev->name,
+				 ctx->len);
+			return -EINVAL;
+		}
+
+		if (unlikely(ctx->hdr_len > enet->cfg.split_hdr)) {
+			pr_debug("%s: rx error: hdr len %u exceeds hdr buffer size %u\n",
+				 enet->netdev->name, ctx->len,
+				 enet->cfg.split_hdr);
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	if (unlikely(ctx->len < ETH_HLEN)) {
+		pr_debug("%s: short packet %u\n", enet->netdev->name, ctx->len);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
+static struct sk_buff *eea_build_skb(void *buf, u32 buflen, u32 headroom,
+				     u32 len)
+{
+	struct sk_buff *skb;
+
+	skb = build_skb(buf, buflen);
+	if (unlikely(!skb))
+		return NULL;
+
+	skb_reserve(skb, headroom);
+	skb_put(skb, len);
+
+	return skb;
+}
+
+static struct sk_buff *eea_rx_build_split_hdr_skb(struct eea_net_rx *rx,
+						  struct eea_rx_ctx *ctx)
+{
+	struct eea_rx_meta *meta = ctx->meta;
+	struct sk_buff *skb;
+	u32 truesize;
+
+	dma_sync_single_for_cpu(rx->enet->edev->dma_dev, meta->hdr_dma,
+				ctx->hdr_len, DMA_FROM_DEVICE);
+
+	skb = napi_alloc_skb(rx->napi, ctx->hdr_len);
+	if (unlikely(!skb))
+		return NULL;
+
+	truesize = meta->headroom + ctx->len;
+
+	skb_put_data(skb, ctx->meta->hdr_addr, ctx->hdr_len);
+
+	if (ctx->len) {
+		skb_add_rx_frag(skb, 0, meta->page,
+				meta->offset + meta->headroom,
+				ctx->len, truesize);
+
+		eea_consume_rx_buffer(rx, meta, truesize);
+	}
+
+	skb_mark_for_recycle(skb);
+
+	return skb;
+}
+
+static struct sk_buff *eea_rx_build_skb(struct eea_net_rx *rx,
+					struct eea_rx_ctx *ctx)
+{
+	struct eea_rx_meta *meta = ctx->meta;
+	u32 len, shinfo_size, truesize;
+	struct sk_buff *skb;
+	struct page *page;
+	void *buf, *pkt;
+
+	page = meta->page;
+	if (!page)
+		return NULL;
+
+	shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	buf = page_address(page) + meta->offset;
+	pkt = buf + meta->headroom;
+	len = ctx->len;
+	truesize = meta->headroom + ctx->len + shinfo_size;
+
+	skb = eea_build_skb(buf, truesize, pkt - buf, len);
+	if (unlikely(!skb))
+		return NULL;
+
+	eea_consume_rx_buffer(rx, meta, truesize);
+	skb_mark_for_recycle(skb);
+
+	return skb;
+}
+
+static int eea_skb_append_buf(struct eea_net_rx *rx, struct eea_rx_ctx *ctx)
+{
+	struct sk_buff *curr_skb = rx->pkt.curr_skb;
+	struct sk_buff *head_skb = rx->pkt.head_skb;
+	int num_skb_frags;
+	int offset;
+
+	if (!curr_skb)
+		curr_skb = head_skb;
+
+	num_skb_frags = skb_shinfo(curr_skb)->nr_frags;
+	if (unlikely(num_skb_frags == MAX_SKB_FRAGS)) {
+		struct sk_buff *nskb = alloc_skb(0, GFP_ATOMIC);
+
+		if (unlikely(!nskb))
+			return -ENOMEM;
+
+		if (curr_skb == head_skb)
+			skb_shinfo(curr_skb)->frag_list = nskb;
+		else
+			curr_skb->next = nskb;
+
+		curr_skb = nskb;
+		head_skb->truesize += nskb->truesize;
+		num_skb_frags = 0;
+
+		rx->pkt.curr_skb = curr_skb;
+	}
+
+	if (curr_skb != head_skb) {
+		head_skb->data_len += ctx->len;
+		head_skb->len += ctx->len;
+		head_skb->truesize += ctx->meta->truesize;
+	}
+
+	offset = ctx->meta->offset + ctx->meta->headroom;
+
+	skb_add_rx_frag(curr_skb, num_skb_frags, ctx->meta->page,
+			offset, ctx->len, ctx->meta->truesize);
+
+	eea_consume_rx_buffer(rx, ctx->meta, ctx->meta->headroom + ctx->len);
+
+	return 0;
+}
+
+static int process_remain_buf(struct eea_net_rx *rx, struct eea_rx_ctx *ctx)
+{
+	struct eea_net *enet = rx->enet;
+
+	if (eea_harden_check_overflow(ctx, enet))
+		goto err;
+
+	if (eea_skb_append_buf(rx, ctx))
+		goto err;
+
+	return 0;
+
+err:
+	dev_kfree_skb(rx->pkt.head_skb);
+	rx->pkt.do_drop = true;
+	rx->pkt.head_skb = NULL;
+	return 0;
+}
+
+static int process_first_buf(struct eea_net_rx *rx, struct eea_rx_ctx *ctx)
+{
+	struct eea_net *enet = rx->enet;
+	struct sk_buff *skb = NULL;
+
+	if (eea_harden_check_size(ctx, enet))
+		goto err;
+
+	rx->pkt.data_valid = ctx->flags & EEA_DESC_F_DATA_VALID;
+
+	if (ctx->hdr_len)
+		skb = eea_rx_build_split_hdr_skb(rx, ctx);
+	else
+		skb = eea_rx_build_skb(rx, ctx);
+
+	if (unlikely(!skb))
+		goto err;
+
+	rx->pkt.head_skb = skb;
+
+	return 0;
+
+err:
+	rx->pkt.do_drop = true;
+	return 0;
+}
+
+static void eea_submit_skb(struct eea_net_rx *rx, struct sk_buff *skb,
+			   struct eea_rx_cdesc *desc)
+{
+	struct eea_net *enet = rx->enet;
+
+	if (rx->pkt.data_valid)
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	if (enet->cfg.ts_cfg.rx_filter == HWTSTAMP_FILTER_ALL)
+		skb_hwtstamps(skb)->hwtstamp = EEA_DESC_TS(desc) +
+			enet->hw_ts_offset;
+
+	skb_record_rx_queue(skb, rx->index);
+	skb->protocol = eth_type_trans(skb, enet->netdev);
+
+	napi_gro_receive(rx->napi, skb);
+}
+
+static void eea_rx_desc_to_ctx(struct eea_net_rx *rx,
+			       struct eea_rx_ctx *ctx,
+			       struct eea_rx_cdesc *desc)
+{
+	ctx->meta = &rx->meta[le16_to_cpu(desc->id)];
+	ctx->len = le16_to_cpu(desc->len);
+	ctx->flags = le16_to_cpu(desc->flags);
+
+	ctx->hdr_len = 0;
+	if (ctx->flags & EEA_DESC_F_SPLIT_HDR) {
+		ctx->hdr_len = le16_to_cpu(desc->len_ex) &
+			EEA_RX_CDESC_HDR_LEN_MASK;
+	}
+
+	ctx->more = ctx->flags & EEA_RING_DESC_F_MORE;
+}
+
+static int eea_cleanrx(struct eea_net_rx *rx, int budget,
+		       struct eea_rx_ctx *ctx)
+{
+	struct eea_rx_cdesc *desc;
+	struct eea_rx_meta *meta;
+	int packets;
+
+	for (packets = 0; packets < budget; ) {
+		desc = ering_cq_get_desc(rx->ering);
+		if (!desc)
+			break;
+
+		eea_rx_desc_to_ctx(rx, ctx, desc);
+
+		meta = ctx->meta;
+		ctx->buf = page_address(meta->page) + meta->offset +
+			meta->headroom;
+
+		if (unlikely(rx->pkt.do_drop))
+			goto skip;
+
+		eea_rx_meta_dma_sync_for_cpu(rx, meta, ctx->len);
+
+		rx->pkt.recv_len += ctx->len;
+
+		if (!rx->pkt.idx)
+			process_first_buf(rx, ctx);
+		else
+			process_remain_buf(rx, ctx);
+
+		++rx->pkt.idx;
+
+		if (!ctx->more && rx->pkt.head_skb) {
+			eea_submit_skb(rx, rx->pkt.head_skb, desc);
+			++packets;
+		}
+
+skip:
+		eea_rx_meta_put(rx, meta);
+		ering_cq_ack_desc(rx->ering, 1);
+
+		if (!ctx->more)
+			memset(&rx->pkt, 0, sizeof(rx->pkt));
+	}
+
+	return packets;
+}
+
+static bool eea_rx_post(struct eea_net *enet, struct eea_net_rx *rx)
+{
+	u32 tailroom, headroom, room, len;
+	struct eea_rx_meta *meta;
+	struct eea_rx_desc *desc;
+	int err = 0, num = 0;
+	dma_addr_t addr;
+
+	tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	headroom = rx->headroom;
+	room = headroom + tailroom;
+
+	while (true) {
+		meta = eea_rx_meta_get(rx);
+		if (!meta)
+			break;
+
+		err = eea_alloc_rx_buffer(rx, meta);
+		if (err) {
+			eea_rx_meta_put(rx, meta);
+			break;
+		}
+
+		len = PAGE_SIZE - meta->offset - room;
+		addr = meta->dma + meta->offset + headroom;
+
+		desc = ering_sq_alloc_desc(rx->ering, meta->id, true, 0);
+		desc->addr = cpu_to_le64(addr);
+		desc->len = cpu_to_le16(len);
+
+		if (meta->hdr_addr)
+			desc->hdr_addr = cpu_to_le64(meta->hdr_dma);
+
+		ering_sq_commit_desc(rx->ering);
+
+		meta->truesize = len + room;
+		meta->headroom = headroom;
+		meta->tailroom = tailroom;
+		meta->len = len;
+		++num;
+	}
+
+	if (num)
+		ering_kick(rx->ering);
+
+	/* true means busy, napi should be called again. */
+	return !!err;
+}
+
+static int eea_poll(struct napi_struct *napi, int budget)
+{
+	struct eea_irq_blk *blk = container_of(napi, struct eea_irq_blk, napi);
+	struct eea_net_rx *rx = blk->rx;
+	struct eea_net_tx *tx = &rx->enet->tx[rx->index];
+	struct eea_net *enet = rx->enet;
+	struct eea_rx_ctx ctx = {};
+	bool busy = false;
+	u32 received;
+
+	eea_poll_tx(tx, budget);
+
+	received = eea_cleanrx(rx, budget, &ctx);
+
+	if (rx->ering->num_free > budget)
+		busy |= eea_rx_post(enet, rx);
+
+	busy |= received >= budget;
+
+	if (busy)
+		return budget;
+
+	if (napi_complete_done(napi, received))
+		ering_irq_active(rx->ering, tx->ering);
+
+	return received;
+}
+
 static void eea_free_rx_buffers(struct eea_net_rx *rx, struct eea_net_cfg *cfg)
 {
 	struct eea_rx_meta *meta;
-- 
2.32.0.3.g01195cf9f


