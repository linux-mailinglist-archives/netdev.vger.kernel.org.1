Return-Path: <netdev+bounces-250335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C90D2902F
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03519303D35D
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B0332AAD1;
	Thu, 15 Jan 2026 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYY1VEiF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeJdZ1wa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD7732C33A
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515981; cv=none; b=u1CoKsBPO5dZ+w1jSDqtOFiKVWrBXGurVS75vjoZ3MSKkBH38mHSBD4qb6RKz2C41y4Ry9KpwUFuvnAY1KyvUMZKSjzGUOGTr28rsydYKXchDqqrJlU4bu6mvGbGmnRMx9/lQOYzfGv8UHNxD/aw1SdK7iu5z4ia192xrKJd7I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515981; c=relaxed/simple;
	bh=UdYtRcsDFQcsM5dtvgj4vNPjmZMWLhY42NMX3hbykqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGEYqfiZSrgFXcqDhyDn55ybYVIx4yYL9VV+NjHUenBNJLWw+1lhNFI72uh8AnmsnqeN4GkN1HV9f+Hfr3bgBTZ4iWeaBeBHvuiv6AQRk7tgxxaIJVAYJVQF6ejgMW2qEQPXcLdLG52RMCAXOV6Z7KIpxXV3b11nFYQxyISLjic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYY1VEiF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SeJdZ1wa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768515976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0CTjAkrn14YmJ1j6E30Q3pbhx8qQ6AptV4wAq4uGZY=;
	b=JYY1VEiFzTVhWkGKes2dCAxrDtooq+igpLUVvw6HFF5ud7D6q7AP9So5KcbK3AL0HszHcR
	0+9l/WN7esEfsKH1C2eAx2TMaP4TxkHQxHxkMrFH2O5YQ6LXQy7n7OWkkxy6w2VglSFmT0
	aSyBBMbNdIyNBuhpzdjYp4hteQ7P71U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-VXCO0Oi-PZm2Phlh59Y25g-1; Thu, 15 Jan 2026 17:26:15 -0500
X-MC-Unique: VXCO0Oi-PZm2Phlh59Y25g-1
X-Mimecast-MFC-AGG-ID: VXCO0Oi-PZm2Phlh59Y25g_1768515974
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477964c22e0so10359965e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768515973; x=1769120773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0CTjAkrn14YmJ1j6E30Q3pbhx8qQ6AptV4wAq4uGZY=;
        b=SeJdZ1waGvIRssWpog+9HGdEMdGcmbnh9/zQjfRK8dUdaI+1lBz9A1rkO1KqEQWjbF
         zHppFiRoP6xZstoSRGT4KgcsOYFOQVJkOHUVel75KX72r1XLCQ7pVbn9rICeW30rqpgp
         vlEJ14Oa2Kr3gMD4IRlyoGjCtFOG7xXo8WJqWGCdilNrvKCFdjy3JvIlwrU/H+G7e0tN
         C1FHoqnkes9HUCZ3qBAA4mPTFGACO4d/UZkegqSYc+nuXm8v1cXHycgY9CutfVmQkefV
         nmnQEHWWTGEe6QoFkTSr2+1AHA/l4uBlQwhpou1GxGcbpO3Qfls3g5FMMJ6IehPEAld2
         zHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768515973; x=1769120773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r0CTjAkrn14YmJ1j6E30Q3pbhx8qQ6AptV4wAq4uGZY=;
        b=V3U6aCJgKE5izTYT0VhSHI/gmpzkPmlRP/RvgnXMCJgFddnJxzHj3XG8D3Ujw2L1IN
         ezmISyZg3RL0KY1jYuhSbsELZX8YvrMNdaZjl4g2DGVAmNoOv7nX2F5Eg1ZP+xRwJUqe
         bpFrR86KksozOwaAgp6G5xUCMi1knv3FPYG0iG8GB/HQsTAN1ihOhkE10XLdkyWgNr0B
         /4xWocce5JuzSq3VKvOZxN4XVLZZz0y/KJdBm8/O+XiwaGNtr5VWf8KlZn3j9rPfNeZ1
         l1eBgr+jbEaZHBoeKEAryMeoeyKSnQCgsS2Q5uT/270L3sHkYA9x1aybQtFxQK7IciSF
         scIw==
X-Gm-Message-State: AOJu0Ywpwob6/gJdKr18DjiPjdtuZw11LkYe/6jiUXLJ4qVd0kB/w3qh
	5UfZ6si801wsjBnujAktpHCBAEZz+PervPHqcKYlr+gxXGiX2azwrDmkvbFE35h1IVTuTzU46nW
	60AvltdI2VY2zXl+S7RWbrTcDZYO4xUFrpRktvvmFEbb/VDAbPn68sR7DKDqDsH7CI1UZV6f4HH
	Cd1QipgP49xIb5Z1bhJwdLntlO3qNB8ODyPvM1IByxxA==
X-Gm-Gg: AY/fxX69MNeG287iNCgrtt0YXppsbo19BgvzUQM5hLUiYbR6TDZliDeMjt2PPNgGseQ
	ZP/c72wLJ1l8jnZnc4BWGDIiuKwXNY9U3/S/5TVGpJqxuhB7Ypw7Z0nZ0CmPW0BgrHf0IdMNewk
	djwYbeq4vTboDgeWbx6wW/xd4U0hYuMUdAVU3PvA+jFSiF6jZueZXD6pOrOAQilRGGanGDl8WkI
	8DiwsWQs0mVvQGm7u7fJadfDuF53qgX975JemIdcCl71Bgh5a/bHF4tjjrJSE23M5vGHUB1RjL+
	SPAnV6FS+IgpkhzDq3W7Ex7I9UFuVRzMrRp1yKvidJ2CbiGaY1sGqj47vUm/h2JteDzgRI9fWH5
	3D6MshT1AbtHDDbNP4tiXVz7DVuvxN8YpmjblNzWpiquFfA==
X-Received: by 2002:a05:600c:8b6c:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-4801e66fcc5mr11310465e9.10.1768515972793;
        Thu, 15 Jan 2026 14:26:12 -0800 (PST)
X-Received: by 2002:a05:600c:8b6c:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-4801e66fcc5mr11310095e9.10.1768515972244;
        Thu, 15 Jan 2026 14:26:12 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm1484778f8f.2.2026.01.15.14.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:26:11 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next 5/8] cadence: macb: add XDP support for gem
Date: Thu, 15 Jan 2026 23:25:28 +0100
Message-ID: <20260115222531.313002-6-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115222531.313002-1-pvalerio@redhat.com>
References: <20260115222531.313002-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce basic XDP support for macb/gem with the XDP_PASS,
XDP_DROP, XDP_REDIRECT verdict support.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      |   3 +
 drivers/net/ethernet/cadence/macb_main.c | 178 +++++++++++++++++++++--
 2 files changed, 167 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index eb775e576646..d46d8523198d 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -15,6 +15,7 @@
 #include <linux/phy/phy.h>
 #include <linux/workqueue.h>
 #include <net/page_pool/helpers.h>
+#include <net/xdp.h>
 
 #define MACB_GREGS_NBR 16
 #define MACB_GREGS_VERSION 2
@@ -1269,6 +1270,7 @@ struct macb_queue {
 	struct queue_stats stats;
 	struct page_pool	*page_pool;
 	struct sk_buff		*skb;
+	struct xdp_rxq_info	xdp_rxq;
 };
 
 struct ethtool_rx_fs_item {
@@ -1368,6 +1370,7 @@ struct macb {
 
 	struct macb_pm_data pm_data;
 	const struct macb_usrio_config *usrio;
+	struct bpf_prog	__rcu *prog;
 };
 
 #ifdef CONFIG_MACB_USE_HWSTAMP
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 89f0c4dc3884..1f62100a4c4d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -6,6 +6,7 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/bpf_trace.h>
 #include <linux/circ_buf.h>
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
@@ -1249,9 +1250,19 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
+static unsigned int gem_max_rx_data_size(int base_sz)
+{
+	return SKB_DATA_ALIGN(base_sz + ETH_HLEN + ETH_FCS_LEN);
+}
+
+static unsigned int gem_max_rx_buffer_size(int data_sz, struct macb *bp)
+{
+	return SKB_HEAD_ALIGN(data_sz + bp->rx_headroom);
+}
+
 static unsigned int gem_total_rx_buffer_size(struct macb *bp)
 {
-	return SKB_HEAD_ALIGN(bp->rx_buffer_size + bp->rx_headroom);
+	return gem_max_rx_buffer_size(bp->rx_buffer_size, bp);
 }
 
 static int gem_rx_refill(struct macb_queue *queue, bool napi)
@@ -1336,12 +1347,61 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 	 */
 }
 
+static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
+		       unsigned int len)
+{
+	struct net_device *dev;
+	struct bpf_prog *prog;
+	struct xdp_buff xdp;
+
+	u32 act = XDP_PASS;
+
+	rcu_read_lock();
+
+	prog = rcu_dereference(queue->bp->prog);
+	if (!prog)
+		goto out;
+
+	xdp_init_buff(&xdp, gem_total_rx_buffer_size(queue->bp), &queue->xdp_rxq);
+	xdp_prepare_buff(&xdp, buff_head, queue->bp->rx_headroom, len, false);
+	xdp_buff_clear_frags_flag(&xdp);
+	dev = queue->bp->dev;
+
+	act = bpf_prog_run_xdp(prog, &xdp);
+	switch (act) {
+	case XDP_PASS:
+		goto out;
+	case XDP_REDIRECT:
+		if (unlikely(xdp_do_redirect(dev, &xdp, prog))) {
+			act = XDP_DROP;
+			break;
+		}
+		goto out;
+	default:
+		bpf_warn_invalid_xdp_action(dev, prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+		trace_xdp_exception(dev, prog, act);
+		fallthrough;
+	case XDP_DROP:
+		break;
+	}
+
+	page_pool_put_full_page(queue->page_pool,
+				virt_to_head_page(xdp.data), true);
+out:
+	rcu_read_unlock();
+
+	return act;
+}
+
 static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
 	struct skb_shared_info *shinfo;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
+	bool xdp_flush = false;
 	unsigned int entry;
 	struct page *page;
 	void *buff_head;
@@ -1349,11 +1409,11 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 	int data_len;
 	int nr_frags;
 
-
 	while (count < budget) {
 		bool rxused, first_frame, last_frame;
 		dma_addr_t addr;
 		u32 ctrl;
+		u32 ret;
 
 		entry = macb_rx_ring_wrap(bp, queue->rx_tail);
 		desc = macb_rx_desc(queue, entry);
@@ -1401,6 +1461,17 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			data_len = bp->rx_buffer_size;
 		}
 
+		if (!(first_frame && last_frame))
+			goto skip_xdp;
+
+		ret = gem_xdp_run(queue, buff_head, data_len);
+		if (ret == XDP_REDIRECT)
+			xdp_flush = true;
+
+		if (ret != XDP_PASS)
+			goto next_frame;
+
+skip_xdp:
 		if (first_frame) {
 			queue->skb = napi_build_skb(buff_head, gem_total_rx_buffer_size(bp));
 			if (unlikely(!queue->skb)) {
@@ -1450,10 +1521,6 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		}
 
 		/* now everything is ready for receiving packet */
-		queue->rx_buff[entry] = NULL;
-
-		netdev_vdbg(bp->dev, "%s %u (len %u)\n", __func__, entry, data_len);
-
 		if (last_frame) {
 			bp->dev->stats.rx_packets++;
 			queue->stats.rx_packets++;
@@ -1474,6 +1541,8 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->skb = NULL;
 		}
 
+next_frame:
+		queue->rx_buff[entry] = NULL;
 		continue;
 
 free_frags:
@@ -1491,6 +1560,9 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		queue->rx_buff[entry] = NULL;
 	}
 
+	if (xdp_flush)
+		xdp_do_flush();
+
 	gem_rx_refill(queue, true);
 
 	return count;
@@ -2428,13 +2500,11 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 static void macb_init_rx_buffer_size(struct macb *bp, unsigned int mtu)
 {
 	unsigned int overhead;
-	size_t size;
 
 	if (!macb_is_gem(bp)) {
 		bp->rx_buffer_size = MACB_RX_BUFFER_SIZE;
 	} else {
-		size = mtu + ETH_HLEN + ETH_FCS_LEN;
-		bp->rx_buffer_size = SKB_DATA_ALIGN(size);
+		bp->rx_buffer_size = gem_max_rx_data_size(mtu);
 		if (gem_total_rx_buffer_size(bp) > PAGE_SIZE) {
 			overhead = bp->rx_headroom +
 				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
@@ -2480,6 +2550,8 @@ static void gem_free_rx_buffers(struct macb *bp)
 
 		kfree(queue->rx_buff);
 		queue->rx_buff = NULL;
+		if (xdp_rxq_info_is_reg(&queue->xdp_rxq))
+			xdp_rxq_info_unreg(&queue->xdp_rxq);
 		page_pool_destroy(queue->page_pool);
 		queue->page_pool = NULL;
 	}
@@ -2636,30 +2708,55 @@ static int macb_alloc_consistent(struct macb *bp)
 	return -ENOMEM;
 }
 
-static int gem_create_page_pool(struct macb_queue *queue)
+static int gem_create_page_pool(struct macb_queue *queue, int qid)
 {
 	struct page_pool_params pp_params = {
 		.order = 0,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.pool_size = queue->bp->rx_ring_size,
 		.nid = NUMA_NO_NODE,
-		.dma_dir = DMA_FROM_DEVICE,
+		.dma_dir = rcu_access_pointer(queue->bp->prog)
+				? DMA_BIDIRECTIONAL
+				: DMA_FROM_DEVICE,
 		.dev = &queue->bp->pdev->dev,
 		.napi = &queue->napi_rx,
 		.max_len = PAGE_SIZE,
 	};
 	struct page_pool *pool;
-	int err = 0;
+	int err;
 
 	pool = page_pool_create(&pp_params);
 	if (IS_ERR(pool)) {
 		netdev_err(queue->bp->dev, "cannot create rx page pool\n");
 		err = PTR_ERR(pool);
-		pool = NULL;
+		goto clear_pool;
 	}
 
 	queue->page_pool = pool;
 
+	err = xdp_rxq_info_reg(&queue->xdp_rxq, queue->bp->dev, qid,
+			       queue->napi_rx.napi_id);
+	if (err < 0) {
+		netdev_err(queue->bp->dev, "xdp: failed to register rxq info\n");
+		goto destroy_pool;
+	}
+
+	err = xdp_rxq_info_reg_mem_model(&queue->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 queue->page_pool);
+	if (err) {
+		netdev_err(queue->bp->dev, "xdp: failed to register rxq memory model\n");
+		goto unreg_info;
+	}
+
+	return 0;
+
+unreg_info:
+	xdp_rxq_info_unreg(&queue->xdp_rxq);
+destroy_pool:
+	page_pool_destroy(pool);
+clear_pool:
+	queue->page_pool = NULL;
+
 	return err;
 }
 
@@ -2701,7 +2798,7 @@ static int gem_init_rings(struct macb *bp, bool fail_early)
 		/* This is a hard failure, so the best we can do is try the
 		 * next queue in case of HRESP error.
 		 */
-		err = gem_create_page_pool(queue);
+		err = gem_create_page_pool(queue, q);
 		if (err) {
 			last_err = err;
 			if (fail_early)
@@ -3152,11 +3249,27 @@ static int macb_close(struct net_device *dev)
 	return 0;
 }
 
+static bool gem_xdp_valid_mtu(struct macb *bp, int mtu)
+{
+	int max_frame_size;
+
+	max_frame_size = gem_max_rx_buffer_size(gem_max_rx_data_size(mtu), bp);
+
+	return max_frame_size <= PAGE_SIZE;
+}
+
 static int macb_change_mtu(struct net_device *dev, int new_mtu)
 {
+	struct macb *bp = netdev_priv(dev);
+
 	if (netif_running(dev))
 		return -EBUSY;
 
+	if (rcu_access_pointer(bp->prog) && !gem_xdp_valid_mtu(bp, new_mtu)) {
+		netdev_err(dev, "MTU %d too large for XDP", new_mtu);
+		return -EINVAL;
+	}
+
 	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
@@ -3174,6 +3287,39 @@ static int macb_set_mac_addr(struct net_device *dev, void *addr)
 	return 0;
 }
 
+static int gem_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
+			 struct netlink_ext_ack *extack)
+{
+	struct macb *bp = netdev_priv(dev);
+	struct bpf_prog *old_prog;
+
+	if (prog && !gem_xdp_valid_mtu(bp, dev->mtu)) {
+		NL_SET_ERR_MSG_MOD(extack, "MTU too large for XDP");
+		return -EOPNOTSUPP;
+	}
+
+	old_prog = rcu_replace_pointer(bp->prog, prog, lockdep_rtnl_is_held());
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	return 0;
+}
+
+static int gem_xdp(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	struct macb *bp = netdev_priv(dev);
+
+	if (!macb_is_gem(bp))
+		return -EOPNOTSUPP;
+
+	switch (xdp->command) {
+	case XDP_SETUP_PROG:
+		return gem_xdp_setup(dev, xdp->prog, xdp->extack);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void gem_update_stats(struct macb *bp)
 {
 	struct macb_queue *queue;
@@ -4427,6 +4573,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_set	= macb_hwtstamp_set,
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
+	.ndo_bpf		= gem_xdp,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -5732,6 +5879,9 @@ static int macb_probe(struct platform_device *pdev)
 		bp->rx_headroom = XDP_PACKET_HEADROOM;
 		if (!(bp->caps & MACB_CAPS_RSC))
 			bp->rx_headroom += NET_IP_ALIGN;
+
+		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
+				    NETDEV_XDP_ACT_REDIRECT;
 	}
 
 	netif_carrier_off(dev);
-- 
2.52.0


