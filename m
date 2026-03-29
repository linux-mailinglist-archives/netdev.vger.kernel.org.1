Return-Path: <netdev+bounces-272909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Dg+AeMnyWm/vAUAu9opvQ
	(envelope-from <netdev+bounces-272909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:23:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAB135238E
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA366302D09E
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1603F375AC4;
	Sun, 29 Mar 2026 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sbGX3xaR"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870773750CB
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790559; cv=none; b=KlSKT0CiqBorBAkdM4G6KfYoN9RlfHWkOxy5nyVKKCFoll9jQvMYTwYtt6QA7MHDBEYiOkpdYYBsxajJHjICD1otstVoBqoz/H5hf2awzdnWwjocINm04FDs+NxII9jZFC7+DG7kWrnjsKuqEqSnK4DPinOgrkGVwzxvpBF1844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790559; c=relaxed/simple;
	bh=MdRNJVLlMk5Eqmc5f/Thv5Pqd94JaNv2/AF4+JHgPyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FciUau+WCcUwbVymK9KyhfwTeEYXmlIC7IQxe4w9k63gb96lSsRJZVshwrRwHW5Isllzh4XRgm3y57+St7OcElI2HmXoLFndDrX7DXSUCm+KQYcFNX/a1OYNW76zd4eyJTO2xUPFZWtGhxcdRBz8azV2M3buYVNuYN5YdJtscTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sbGX3xaR; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774790547; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=HwTc4WfX1VkqosR/9/RCxW0wpR76drWDSWcE+/ylp+A=;
	b=sbGX3xaRy446vw4lf+1U+nuMrvZ+7oaw26L81x564rFN1J5PU6WLaB4W67Cee6EB6rYWgmvvKostD0Fpa4tYEvG68vyl1kvPH7YxHLUVNH/zgKf5qK40QzTKGhcQswnhIykEPr2lZRYGYC/oXCWFpCBzmHLSx6iPsezOA/V0TN0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.stMSY_1774790545;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X.stMSY_1774790545 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 29 Mar 2026 21:22:26 +0800
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
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Dong Yibo <dong100@mucse.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v36 5/8] eea: implement packet receive logic
Date: Sun, 29 Mar 2026 21:22:19 +0800
Message-Id: <20260329132222.130912-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260329132222.130912-1-xuanzhuo@linux.alibaba.com>
References: <20260329132222.130912-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 404307a8ed35
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272909-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 5DAB135238E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the core logic for receiving packets in the EEA RX path,
including packet buffering and basic validation.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/eea_net.h |   4 +
 drivers/net/ethernet/alibaba/eea/eea_rx.c  | 488 ++++++++++++++++++++-
 2 files changed, 490 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
index dc9076b704a7..a1dcc13ecdd5 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -62,6 +62,7 @@ struct eea_net_rx_pkt_ctx {
 	bool data_valid;
 	bool do_drop;
 
+	u32 recv_len;
 	struct sk_buff *head_skb;
 };
 
@@ -88,6 +89,8 @@ struct eea_net_rx {
 	struct eea_net_rx_pkt_ctx pkt;
 
 	struct page_pool *pp;
+
+	bool dma_need_sync;
 };
 
 struct eea_net_cfg {
@@ -166,6 +169,7 @@ void eea_init_ctx(struct eea_net *enet, struct eea_net_init_ctx *ctx);
 int eea_queues_check_and_reset(struct eea_device *edev);
 
 /* rx apis */
+
 void enet_rx_stop(struct eea_net_rx *rx);
 void enet_rx_start(struct eea_net_rx *rx);
 
diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/ethernet/alibaba/eea/eea_rx.c
index 9d2bc1ff2120..20546e7aed3c 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_rx.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_rx.c
@@ -17,6 +17,37 @@
 
 #define EEA_PAGE_FRAGS_NUM 1024
 
+#define EEA_RX_BUF_ALIGN 128
+
+struct eea_rx_ctx {
+	u32 len;
+	u32 hdr_len;
+
+	u16 flags;
+	bool more;
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
@@ -29,6 +60,70 @@ static void eea_free_rx_buffer(struct eea_net_rx *rx, struct eea_rx_meta *meta)
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
+static u32 eea_consume_rx_buffer(struct eea_net_rx *rx,
+				 struct eea_rx_meta *meta,
+				 u32 consumed)
+{
+	u32 offset;
+	int min;
+
+	offset = meta->offset;
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
+	if (min + meta->offset > PAGE_SIZE) {
+		eea_free_rx_buffer(rx, meta);
+		return PAGE_SIZE - offset;
+	}
+
+	return meta->offset - offset;
+}
+
 static void eea_free_rx_hdr(struct eea_net_rx *rx, struct eea_net_cfg *cfg)
 {
 	struct eea_rx_meta *meta;
@@ -87,6 +182,8 @@ static int eea_alloc_rx_hdr(struct eea_net_init_ctx *ctx, struct eea_net_rx *rx)
 		offset += hdrsize;
 	}
 
+	rx->dma_need_sync = dma_dev_need_sync(dmadev);
+
 	return 0;
 
 err:
@@ -94,12 +191,399 @@ static int eea_alloc_rx_hdr(struct eea_net_init_ctx *ctx, struct eea_net_rx *rx)
 	return -ENOMEM;
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
+{
+	int err;
+
+	err = eea_harden_check_overflow(ctx, enet);
+	if (err)
+		return err;
+
+	if (ctx->hdr_len) {
+		if (unlikely(ctx->hdr_len < ETH_HLEN)) {
+			pr_debug("%s: short hdr %u\n", enet->netdev->name,
+				 ctx->hdr_len);
+			return -EINVAL;
+		}
+
+		if (unlikely(ctx->hdr_len > enet->cfg.split_hdr)) {
+			pr_debug("%s: rx error: hdr len %u exceeds hdr buffer size %u\n",
+				 enet->netdev->name, ctx->hdr_len,
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
+	return 0;
+}
+
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
+	u32 truesize, offset;
+	struct sk_buff *skb;
+	struct page *page;
+
+	dma_sync_single_for_cpu(rx->enet->edev->dma_dev, meta->hdr_dma,
+				ctx->hdr_len, DMA_FROM_DEVICE);
+
+	skb = napi_alloc_skb(rx->napi, ctx->hdr_len);
+	if (unlikely(!skb))
+		return NULL;
+
+	skb_put_data(skb, ctx->meta->hdr_addr, ctx->hdr_len);
+
+	if (ctx->len) {
+		page = meta->page;
+		offset = meta->offset + meta->headroom;
+
+		truesize = eea_consume_rx_buffer(rx, meta,
+						 meta->headroom + ctx->len);
+
+		skb_add_rx_frag(skb, 0, page, offset, ctx->len, truesize);
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
+	u32 shinfo_size, bufsize, truesize;
+	struct sk_buff *skb;
+	struct page *page;
+	void *buf;
+
+	page = meta->page;
+	if (!page)
+		return NULL;
+
+	shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	buf = page_address(page) + meta->offset;
+	bufsize = meta->headroom + ctx->len + shinfo_size;
+
+	skb = eea_build_skb(buf, bufsize, meta->headroom, ctx->len);
+	if (unlikely(!skb))
+		return NULL;
+
+	truesize = eea_consume_rx_buffer(rx, meta, bufsize);
+	skb_mark_for_recycle(skb);
+
+	skb->truesize += truesize - bufsize;
+
+	return skb;
+}
+
+static void process_remain_buf(struct eea_net_rx *rx, struct eea_rx_ctx *ctx)
+{
+	struct eea_net *enet = rx->enet;
+	struct sk_buff *head_skb;
+	u32 offset, truesize, nr_frags;
+	struct page *page;
+
+	if (eea_harden_check_overflow(ctx, enet))
+		goto err;
+
+	head_skb = rx->pkt.head_skb;
+
+	nr_frags = skb_shinfo(head_skb)->nr_frags;
+	if (unlikely(nr_frags >= MAX_SKB_FRAGS))
+		goto err;
+
+	offset = ctx->meta->offset + ctx->meta->headroom;
+	page = ctx->meta->page;
+	truesize = eea_consume_rx_buffer(rx, ctx->meta,
+					 ctx->meta->headroom + ctx->len);
+
+	skb_add_rx_frag(head_skb, nr_frags, page, offset, ctx->len, truesize);
+
+	return;
+
+err:
+	dev_kfree_skb(rx->pkt.head_skb);
+	rx->pkt.do_drop = true;
+	rx->pkt.head_skb = NULL;
+}
+
+static void process_first_buf(struct eea_net_rx *rx, struct eea_rx_ctx *ctx)
 {
-	/* Empty function; will be implemented in a subsequent commit. */
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
+	return;
+
+err:
+	rx->pkt.do_drop = true;
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
+static int eea_rx_desc_to_ctx(struct eea_net_rx *rx,
+			      struct eea_rx_ctx *ctx,
+			      struct eea_rx_cdesc *desc)
+{
+	u16 id;
+
+	ctx->meta = NULL;
+
+	id = le16_to_cpu(desc->id);
+	if (unlikely(id >= rx->ering->num)) {
+		netdev_err(rx->enet->netdev, "rx invalid id %d\n", id);
+		return -EINVAL;
+	}
+
+	ctx->meta = &rx->meta[id];
+	ctx->len = le16_to_cpu(desc->len);
+	if (unlikely(ctx->len > ctx->meta->len)) {
+		netdev_err(rx->enet->netdev, "rx invalid len(%d) id:%d\n",
+			   ctx->len, id);
+		return -EINVAL;
+	}
+
+	ctx->flags = le16_to_cpu(desc->flags);
+
+	ctx->hdr_len = 0;
+	if (ctx->flags & EEA_DESC_F_SPLIT_HDR) {
+		ctx->hdr_len = le16_to_cpu(desc->len_ex) &
+			EEA_RX_CDESC_HDR_LEN_MASK;
+	}
+
+	ctx->more = ctx->flags & EEA_RING_DESC_F_MORE;
+
 	return 0;
 }
 
+static int eea_cleanrx(struct eea_net_rx *rx, int budget,
+		       struct eea_rx_ctx *ctx)
+{
+	struct eea_rx_cdesc *desc;
+	struct eea_rx_meta *meta;
+	int packets, err;
+
+	for (packets = 0; packets < budget; ) {
+		desc = ering_cq_get_desc(rx->ering);
+		if (!desc)
+			break;
+
+		err = eea_rx_desc_to_ctx(rx, ctx, desc);
+		if (unlikely(err)) {
+			if (ctx->meta)
+				eea_rx_meta_put(rx, ctx->meta);
+
+			if (rx->pkt.idx)
+				dev_kfree_skb(rx->pkt.head_skb);
+
+			ctx->more = false;
+			goto ack;
+		}
+
+		meta = ctx->meta;
+
+		if (unlikely(rx->pkt.do_drop))
+			goto skip;
+
+		eea_rx_meta_dma_sync_for_cpu(rx, meta, ctx->len);
+
+		rx->pkt.recv_len += ctx->len;
+		rx->pkt.recv_len += ctx->hdr_len;
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
+ack:
+		ering_cq_ack_desc(rx->ering, 1);
+
+		if (!ctx->more)
+			memset(&rx->pkt, 0, sizeof(rx->pkt));
+	}
+
+	return packets;
+}
+
+static void eea_rx_dma_sync_hdr(struct eea_net_rx *rx, dma_addr_t addr)
+{
+	if (!rx->dma_need_sync)
+		return;
+
+#if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
+	__dma_sync_single_for_device(rx->dma_dev, addr,
+				     rx->enet->cfg.split_hdr,
+				     DMA_FROM_DEVICE);
+#endif
+}
+
+static bool eea_rx_post(struct eea_net_rx *rx)
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
+		if (meta->hdr_addr) {
+			eea_rx_dma_sync_hdr(rx, meta->hdr_dma);
+			desc->hdr_addr = cpu_to_le64(meta->hdr_dma);
+		}
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
+	struct eea_rx_ctx ctx = {};
+	bool busy = false;
+	u32 received;
+
+	eea_poll_tx(tx, budget);
+
+	received = eea_cleanrx(rx, budget, &ctx);
+
+	if (rx->ering->num_free > budget)
+		busy |= eea_rx_post(rx);
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


