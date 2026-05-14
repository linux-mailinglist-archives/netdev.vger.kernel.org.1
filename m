Return-Path: <netdev+bounces-287890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ2ZO0ybBWq0YwIAu9opvQ
	(envelope-from <netdev+bounces-287890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:52:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 627EC54000B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F6F930471F7
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158573A785F;
	Thu, 14 May 2026 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yDpX4lGB"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE3385D60
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752315; cv=none; b=a6zvJk9cULMCDKwnZELF+COawkRA2jwu6VJaVUQuji4waZHteYxg9gzadJmyozRNZmUcuvopz1TaP+jnUH1+xiBshSinfZvm6Ph7mOUq/M7NeC5WqNrkQpy5aOtX/ERAoCakm0GIei3AKGf2y4PSR3TIlqELPJ78KRtu+EBaK4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752315; c=relaxed/simple;
	bh=A/1fe93AAmOZh/S7pgrECiUNbhosHt7qLtBFhf+Lqo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LVmgPVdOxi85rWif3wJTCUNNG6dg+iuMFDN5J+SFoWF/XbtvfbS5bbc7gtyXxCQiRjB3GbqoOxwpD00ikj9ruD1H3nH8Ksac7EbDPiheAvQze4CZ4fAiTYYXd1t8lHmRNm0jwWApN/mhHPaboRDsC+IoFzSn9aEW6SjjOrG0TSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yDpX4lGB; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778752305; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SKu5VejqC3NtDS/RQT5IfeqtPFIxtimNzrg8yNLjNeY=;
	b=yDpX4lGBw0oxzTT9gKj+xrzLOxZ1ptnbCeueEQOtuqVNb7OPImdggFgm11hfDcx583llaq/zxns3e+ZUNf/+hWEPby+nGFsyZulJSeQM+nVEQObBmlhCn2m54WFSeg8cpU0dxKF91629YxzAr6gCCMPmadVb9cSTLvH11DT1Vag=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X2wPDXW_1778752303;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X2wPDXW_1778752303 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 May 2026 17:51:43 +0800
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
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v43 5/8] eea: implement packet receive logic
Date: Thu, 14 May 2026 17:51:35 +0800
Message-Id: <20260514095138.80680-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
References: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 1b215e28dce9
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 627EC54000B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287890-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Action: no action

Implement the core logic for receiving packets in the EEA RX path,
including packet buffering and basic validation.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/eea_net.c |  13 +
 drivers/net/ethernet/alibaba/eea/eea_net.h |   7 +
 drivers/net/ethernet/alibaba/eea/eea_rx.c  | 532 ++++++++++++++++++++-
 3 files changed, 550 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
index cfb18a07e296..bf8581bc27ed 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -642,6 +642,15 @@ static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
 	return enet;
 }
 
+static void eea_update_ts_off(struct eea_device *edev, struct eea_net *enet)
+{
+	u64 ts;
+
+	ts = eea_pci_device_ts(edev);
+
+	enet->hw_ts_offset = ktime_get_real() - ts;
+}
+
 static int eea_net_reprobe(struct eea_device *edev)
 {
 	struct eea_net *enet = edev->enet;
@@ -659,6 +668,8 @@ static int eea_net_reprobe(struct eea_device *edev)
 	if (err)
 		goto err_destroy_aq;
 
+	eea_update_ts_off(edev, enet);
+
 	rtnl_lock();
 
 	enet->link_err = 0;
@@ -711,6 +722,8 @@ int eea_net_probe(struct eea_device *edev)
 	if (err)
 		goto err_reset_dev;
 
+	eea_update_ts_off(edev, enet);
+
 	netdev_dbg(enet->netdev, "eea probe success.\n");
 
 	/* Queue TX/RX implementation is still in progress. register_netdev is
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
index 9639f0c5c618..1ff9ef1a8fbe 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -41,6 +41,7 @@ struct eea_rx_meta {
 	struct page *page;
 	dma_addr_t dma;
 	u32 offset;
+	u32 sync_for_cpu;
 	u32 frags;
 
 	struct page *hdr_page;
@@ -54,6 +55,8 @@ struct eea_rx_meta {
 	u32 tailroom;
 
 	u32 len;
+
+	bool in_use;
 };
 
 struct eea_net_rx_pkt_ctx {
@@ -62,6 +65,7 @@ struct eea_net_rx_pkt_ctx {
 	bool data_valid;
 	bool do_drop;
 
+	u32 recv_len;
 	struct sk_buff *head_skb;
 };
 
@@ -154,6 +158,8 @@ struct eea_net {
 
 	u8 duplex;
 	u32 speed;
+
+	u64 hw_ts_offset;
 };
 
 int eea_net_probe(struct eea_device *edev);
@@ -165,6 +171,7 @@ void eea_init_ctx(struct eea_net *enet, struct eea_net_init_ctx *ctx);
 int eea_queues_check_and_reset(struct eea_device *edev);
 
 /* rx apis */
+
 void enet_rx_stop(struct eea_net_rx *rx);
 void enet_rx_start(struct eea_net_rx *rx);
 
diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/ethernet/alibaba/eea/eea_rx.c
index b1265048fbc3..9c71a7cf950e 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_rx.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_rx.c
@@ -17,6 +17,39 @@
 
 #define EEA_PAGE_FRAGS_NUM 1024
 
+#define EEA_RX_BUF_ALIGN 128
+
+#define EEA_RX_BUF_MAX_LEN (10 * 1024)
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
 static void eea_free_rx_buffer(struct eea_net_rx *rx, struct eea_rx_meta *meta,
 			       bool allow_direct)
 {
@@ -31,6 +64,89 @@ static void eea_free_rx_buffer(struct eea_net_rx *rx, struct eea_rx_meta *meta,
 	meta->page = NULL;
 }
 
+static void eea_rx_meta_dma_sync_for_device(struct eea_net_rx *rx,
+					    struct eea_rx_meta *meta)
+{
+	u32 len;
+
+	if (meta->sync_for_cpu <= meta->offset + rx->headroom)
+		return;
+
+	len = meta->sync_for_cpu - meta->offset - rx->headroom;
+
+	dma_sync_single_for_device(rx->enet->edev->dma_dev,
+				   meta->dma + meta->offset + rx->headroom,
+				   len, DMA_FROM_DEVICE);
+	meta->sync_for_cpu = 0;
+}
+
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
+	if (meta->page) {
+		eea_rx_meta_dma_sync_for_device(rx, meta);
+		return 0;
+	}
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
+	meta->sync_for_cpu = 0;
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
+	min += SKB_DATA_ALIGN(ETH_DATA_LEN);
+
+	meta_align_offset(rx, meta);
+
+	if (min + meta->offset > PAGE_SIZE) {
+		eea_free_rx_buffer(rx, meta, true);
+		return PAGE_SIZE - offset;
+	}
+
+	return meta->offset - offset;
+}
+
 static void eea_free_rx_hdr(struct eea_net_rx *rx, struct eea_net_cfg *cfg)
 {
 	struct eea_rx_meta *meta;
@@ -96,17 +212,429 @@ static int eea_alloc_rx_hdr(struct eea_net_init_ctx *ctx, struct eea_net_rx *rx)
 	return -ENOMEM;
 }
 
-static int eea_poll(struct napi_struct *napi, int budget)
+static void eea_rx_meta_dma_sync_for_cpu(struct eea_net_rx *rx,
+					 struct eea_rx_meta *meta, u32 len)
+{
+	dma_sync_single_for_cpu(rx->enet->edev->dma_dev,
+				meta->dma + meta->offset + meta->headroom,
+				len, DMA_FROM_DEVICE);
+	meta->sync_for_cpu = meta->offset + meta->headroom + len;
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
+
+	shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	buf = page_address(page) + meta->offset;
+	bufsize = meta->headroom + SKB_DATA_ALIGN(ctx->len) + shinfo_size;
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
+		if (net_ratelimit())
+			netdev_err(rx->enet->netdev, "rx invalid id %d\n", id);
+		return -EINVAL;
+	}
+
+	ctx->meta = &rx->meta[id];
+	if (!ctx->meta->in_use) {
+		if (net_ratelimit())
+			netdev_err(rx->enet->netdev, "rx invalid id %d\n", id);
+		ctx->meta = NULL;
+		return -EINVAL;
+	}
+
+	ctx->meta->in_use = false;
+
+	ctx->len = le16_to_cpu(desc->len);
+	if (unlikely(ctx->len > ctx->meta->len)) {
+		if (net_ratelimit())
+			netdev_err(rx->enet->netdev, "rx invalid len(%d) id:%d\n",
+				   ctx->len, id);
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
+	return 0;
+}
+
+static int eea_cleanrx(struct eea_net_rx *rx, int budget,
+		       struct eea_rx_ctx *ctx)
+{
+	struct eea_rx_cdesc *desc;
+	struct eea_rx_meta *meta;
+	int recv, err;
+
+	for (recv = 0; recv < budget; ) {
+		desc = eea_ering_cq_get_desc(rx->ering);
+		if (!desc)
+			break;
+
+		err = eea_rx_desc_to_ctx(rx, ctx, desc);
+		if (unlikely(err)) {
+			if (ctx->meta)
+				eea_rx_meta_put(rx, ctx->meta);
+
+			if (rx->pkt.head_skb)
+				dev_kfree_skb(rx->pkt.head_skb);
+
+			/* A hardware error occurred; we are attempting to
+			 * mitigate the impact. Subsequent packets may be
+			 * corrupted.
+			 */
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
+		if (!ctx->more && rx->pkt.head_skb)
+			eea_submit_skb(rx, rx->pkt.head_skb, desc);
+
+skip:
+		eea_rx_meta_put(rx, meta);
+ack:
+		eea_ering_cq_ack_desc(rx->ering, 1);
+
+		if (!ctx->more) {
+			memset(&rx->pkt, 0, sizeof(rx->pkt));
+			++recv;
+		}
+	}
+
+	return recv;
+}
+
+static void eea_rx_dma_sync_hdr(struct eea_net_rx *rx, dma_addr_t addr)
+{
+	dma_sync_single_for_device(rx->dma_dev, addr,
+				   rx->enet->cfg.split_hdr,
+				   DMA_FROM_DEVICE);
+}
+
+/* Only be called from napi. */
+static void eea_rx_post(struct eea_net_rx *rx)
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
+		len = min_t(u32, PAGE_SIZE - meta->offset - room,
+			    EEA_RX_BUF_MAX_LEN);
+
+		len = ALIGN_DOWN(len, SMP_CACHE_BYTES);
+
+		addr = meta->dma + meta->offset + headroom;
+
+		desc = eea_ering_sq_alloc_desc(rx->ering, meta->id, true, 0);
+		desc->addr = cpu_to_le64(addr);
+		desc->len = cpu_to_le16(len);
+
+		if (meta->hdr_addr) {
+			eea_rx_dma_sync_hdr(rx, meta->hdr_dma);
+			desc->hdr_addr = cpu_to_le64(meta->hdr_dma);
+		}
+
+		eea_ering_sq_commit_desc(rx->ering);
+
+		meta->truesize = len + room;
+		meta->headroom = headroom;
+		meta->tailroom = tailroom;
+		meta->len = len;
+		meta->in_use = true;
+		++num;
+	}
+
+	if (num)
+		eea_ering_kick(rx->ering);
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
+	busy |= eea_poll_tx(tx, budget) >= budget;
+
+	received = eea_cleanrx(rx, budget, &ctx);
+
+	if (rx->ering->num_free > budget) {
+		/* Due to the hardware design, there is no notification when
+		 * buffers are exhausted. Therefore, we should proactively
+		 * pre-fill the buffers to avoid starvation.
+		 */
+		eea_rx_post(rx);
+
+		if (rx->ering->num - rx->ering->num_free < budget)
+			busy = true;
+	}
+
+	busy |= received >= budget;
+
+	if (busy)
+		return budget;
+
+	if (napi_complete_done(napi, received))
+		eea_ering_irq_active(rx->ering, tx->ering);
+
+	return received;
+}
+
 static void eea_free_rx_buffers(struct eea_net_rx *rx, struct eea_net_cfg *cfg)
 {
 	struct eea_rx_meta *meta;
 	u32 i;
 
+	if (rx->pkt.head_skb) {
+		dev_kfree_skb(rx->pkt.head_skb);
+		rx->pkt.head_skb = NULL;
+	}
+
 	for (i = 0; i < cfg->rx_ring_depth; ++i) {
 		meta = &rx->meta[i];
 		if (!meta->page)
-- 
2.32.0.3.g01195cf9f


