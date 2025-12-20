Return-Path: <netdev+bounces-245621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D8CD38EA
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 00:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F212C300312E
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 23:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC92FF65F;
	Sat, 20 Dec 2025 23:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0cVKy7V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q9V4agRm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595232FF158
	for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 23:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766274724; cv=none; b=Eie4DwitaDlmbFpgTzAkbf3mYgVww0jGaYEmGF+z972viuqZOaHOJWzbxp9JR+QVZ+2J63NmQvfcAt33Ba0dLorhKz2D93xOLyKPcbIIkrCg/WW18JgnDlxhHixN/Hibxm75BseNha/6AAXihLPyowTE0KEDoMP5Yssog3DTCE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766274724; c=relaxed/simple;
	bh=IbwAuwWGbqPMG3qUQwb1iAmBi9PHQmvPxAEIR8d/EO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5ia6XOe4fAYGeWfLUzkJgSt/VHAGSIbGdVvy1zDwAivywvzzG3bWOIIpfpVNOTsxAxgSloVeWTwNgylz87fB3rD9N8UC4CczEiiLho4q99kBRE6GQ7YnzmidodLCtzwS9rHL1VxRIKy5Kso7Gtqy7zWxkNIDQcDexGs5O/qOMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a0cVKy7V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q9V4agRm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766274719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5GhBMR0tgbyKgiMhHUt4MtsN6iRlFjjnY0u5OpzLv7Q=;
	b=a0cVKy7VCb/1QNhGgQ6gzv7M0pn9D4ZPbq6aiEJou4SpjUcbTM8WHQBHyGSkEyLpkTnmxJ
	5+RZDm+m5i3oJ52reS6QieAC52WEU2jDFbRjVHlHGhMIy5VJ8tFC7+qE4a+FakJ/H+Vzrx
	FQdsOhP40iozqVhVCNvIAoFCITXDHyQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-43N7XOndPOeoiaiZNKGmUw-1; Sat, 20 Dec 2025 18:51:57 -0500
X-MC-Unique: 43N7XOndPOeoiaiZNKGmUw-1
X-Mimecast-MFC-AGG-ID: 43N7XOndPOeoiaiZNKGmUw_1766274716
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b7a041a9121so398269266b.3
        for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 15:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766274715; x=1766879515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GhBMR0tgbyKgiMhHUt4MtsN6iRlFjjnY0u5OpzLv7Q=;
        b=q9V4agRmiz85ZfdIGRGAq1dk1fo9o3N53jYVxMmOq5WE7hVwglwwMw+HHOSoBH0ID0
         7DYtk9h/qDMZ7XJLIqlARLUxDHzFPTpC+8GrAfGB0Vw1eQoqKprYUcl/RA+KJI8kLeRA
         ZsibwpJ+of55GEImdkJ4LvS0KH+Im27T56/qUQ8XRyEazzbFONVQg0NdjowuZG8Nisbr
         bcejiUHpmtNIe3UyzJbUkC9dt/f8LPj76KHseQ793HK9ikAIHlmf1X4Uqe+V+Ms0qHIV
         wW9KGlraQzAXF249gp+oKQV5vKVbwW33dGOGFY8vE4E7hQlCXsNmFNYB2aoR3XpICc4s
         qN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766274715; x=1766879515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5GhBMR0tgbyKgiMhHUt4MtsN6iRlFjjnY0u5OpzLv7Q=;
        b=u+hPM081SHDR7COo3QHFSrmfFO5rIJwx6mT8T+MRiUgkt0Bhcm2wp3v14BjMxBzgz1
         14fzotRDgYd1H5j9ib2tvQ5ObVabv5fLaC4DkTLe8ZQlTorBZD2IQzsdElHLapPGZD2q
         jcv+ViPOuUoRt5wMQugyy57apw0Vh3ENfsdTH26X/Z915hf9JvbJgbwZf9o9X+JBU5XD
         NSEEkiEC20zVPZ3Q8Dqa+koP0PZ3AqVbJk88CNkStvFzvkfLweVYY3YCj5AnTLJ02Ld9
         L/oPhy3xIZDwREuKvdjcthxnKSpkbezJgxVrKanQDRzQhx8l08pGt9zpSTMKcw+RRiu6
         fdNA==
X-Gm-Message-State: AOJu0Yx/mEHKTSNjJW8ng36ku08Fm0arR3jVQ/Bx95p5OCjOVCMVvd5M
	JHxl5TuXpzn/dqC78Hy2VmNrfNJgx76tKX5VEIVXqtfwhzmEj38Z0hDD7WE0Al56mAB9YCtAqdF
	nGhZvKucCX7kuhUzp5YV79VcwonFyKaUeLOUx6oSemjTa19752vtV+vc7kYGoqn2x6zWuRVvudi
	9KtoRzz2YRmGqGKpx+94frZCp/4+2f1wgQkjyG1oGePQ==
X-Gm-Gg: AY/fxX6WWqw/dJI0IW7smBFK2QpUR5KfQc2zj8BNxZb7v0SlBQJUcZ31jYG5TzxHZUe
	rmY+7aCVNiytEVB1cNbX/QDPTxM58inh6nUwlagFPNqOuSWItNdAWSkgo0ReIHJC3aXqIzIpiv1
	gszpOLa/XPCJcaGOBOlRA6st4EpKg9RpVLvEj68aVqy+86/MWGTc/sXtZZ2MI/OFQFNU+P1EzPg
	R/8SigBvRUUyxCpdVmBtcN19spF7wfFyS7CXs9ra2qGv6swhYlYAArpz7B/kHojhYwni/xpb8sd
	XvapWBzT6/1eVuqNgpXLgPtCp1zbZpQvbqERfhJmn86Jk20qjGDZkaHcgimMJrIylCFGzxUYDJh
	o8cz2IPCjCVSlvAr2W9UbD8bcX+6P+U0aRgkQ8XA=
X-Received: by 2002:a17:907:ca05:b0:b80:3fb3:bea0 with SMTP id a640c23a62f3a-b803fb3cademr458350166b.56.1766274714894;
        Sat, 20 Dec 2025 15:51:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6G5k11r/VWGFtcmKHRJiTE/C6UMwKzUP2cNGOC7wZHmv+COEee4Isbt2dCnM1fEGLAMbwDA==
X-Received: by 2002:a17:907:ca05:b0:b80:3fb3:bea0 with SMTP id a640c23a62f3a-b803fb3cademr458348366b.56.1766274714484;
        Sat, 20 Dec 2025 15:51:54 -0800 (PST)
Received: from localhost (net-5-94-8-139.cust.vodafonedsl.it. [5.94.8.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ad2732sm623827666b.20.2025.12.20.15.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 15:51:54 -0800 (PST)
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
Subject: [PATCH RFC net-next v2 5/8] cadence: macb: add XDP support for gem
Date: Sun, 21 Dec 2025 00:51:32 +0100
Message-ID: <20251220235135.1078587-6-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251220235135.1078587-1-pvalerio@redhat.com>
References: <20251220235135.1078587-1-pvalerio@redhat.com>
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
 drivers/net/ethernet/cadence/macb_main.c | 184 ++++++++++++++++++++---
 2 files changed, 169 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 45c04157f153..815d50574267 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -16,6 +16,7 @@
 #include <linux/workqueue.h>
 #include <net/page_pool/helpers.h>
 #include <net/xdp.h>
+#include <linux/bpf_trace.h>
 
 #define MACB_GREGS_NBR 16
 #define MACB_GREGS_VERSION 2
@@ -1270,6 +1271,7 @@ struct macb_queue {
 	struct queue_stats stats;
 	struct page_pool	*page_pool;
 	struct sk_buff		*skb;
+	struct xdp_rxq_info	xdp_rxq;
 };
 
 struct ethtool_rx_fs_item {
@@ -1369,6 +1371,7 @@ struct macb {
 
 	struct macb_pm_data pm_data;
 	const struct macb_usrio_config *usrio;
+	struct bpf_prog	__rcu *prog;
 };
 
 #ifdef CONFIG_MACB_USE_HWSTAMP
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 582ceb728124..f767eb2e272e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2004-2006 Atmel Corporation
  */
 
+#include <asm-generic/errno.h>
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/circ_buf.h>
 #include <linux/clk-provider.h>
@@ -1249,9 +1250,19 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
+static int gem_max_rx_data_size(int base_sz)
+{
+	return SKB_DATA_ALIGN(base_sz + ETH_HLEN + ETH_FCS_LEN);
+}
+
+static int gem_max_rx_buffer_size(int data_sz, struct macb *bp)
+{
+	return SKB_HEAD_ALIGN(data_sz + bp->rx_headroom);
+}
+
 static int gem_total_rx_buffer_size(struct macb *bp)
 {
-	return SKB_HEAD_ALIGN(bp->rx_buffer_size + bp->rx_headroom);
+	return gem_max_rx_buffer_size(bp->rx_buffer_size, bp);
 }
 
 static int gem_rx_refill(struct macb_queue *queue, bool napi)
@@ -1336,10 +1347,59 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
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
 	struct macb *bp = queue->bp;
+	bool			xdp_flush = false;
 	unsigned int		len;
 	unsigned int		entry;
 	struct macb_dma_desc	*desc;
@@ -1352,9 +1412,10 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 
 	while (count < budget) {
-		u32 ctrl;
-		dma_addr_t addr;
 		bool rxused, first_frame;
+		dma_addr_t addr;
+		u32 ctrl;
+		u32 ret;
 
 		entry = macb_rx_ring_wrap(bp, queue->rx_tail);
 		desc = macb_rx_desc(queue, entry);
@@ -1402,6 +1463,17 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			data_len = bp->rx_buffer_size;
 		}
 
+		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF)))
+			goto skip_xdp;
+
+		ret = gem_xdp_run(queue, buff_head, len);
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
@@ -1451,10 +1523,6 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		}
 
 		/* now everything is ready for receiving packet */
-		queue->rx_buff[entry] = NULL;
-
-		netdev_vdbg(bp->dev, "%s %u (len %u)\n", __func__, entry, data_len);
-
 		if (ctrl & MACB_BIT(RX_EOF)) {
 			bp->dev->stats.rx_packets++;
 			queue->stats.rx_packets++;
@@ -1476,6 +1544,8 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->skb = NULL;
 		}
 
+next_frame:
+		queue->rx_buff[entry] = NULL;
 		continue;
 
 free_frags:
@@ -1493,6 +1563,9 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		queue->rx_buff[entry] = NULL;
 	}
 
+	if (xdp_flush)
+		xdp_do_flush();
+
 	gem_rx_refill(queue, true);
 
 	return count;
@@ -2430,16 +2503,11 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 static void macb_init_rx_buffer_size(struct macb *bp, unsigned int mtu)
 {
 	int overhead;
-	size_t size;
 
 	if (!macb_is_gem(bp)) {
 		bp->rx_buffer_size = MACB_RX_BUFFER_SIZE;
 	} else {
-		size = mtu + ETH_HLEN + ETH_FCS_LEN;
-		if (!(bp->caps & MACB_CAPS_RSC))
-			size += NET_IP_ALIGN;
-
-		bp->rx_buffer_size = SKB_DATA_ALIGN(size);
+		bp->rx_buffer_size = gem_max_rx_data_size(mtu);
 		if (gem_total_rx_buffer_size(bp) > PAGE_SIZE) {
 			overhead = bp->rx_headroom +
 				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
@@ -2484,6 +2552,8 @@ static void gem_free_rx_buffers(struct macb *bp)
 
 		kfree(queue->rx_buff);
 		queue->rx_buff = NULL;
+		if (xdp_rxq_info_is_reg(&queue->xdp_rxq))
+			xdp_rxq_info_unreg(&queue->xdp_rxq);
 		page_pool_destroy(queue->page_pool);
 		queue->page_pool = NULL;
 	}
@@ -2640,30 +2710,55 @@ static int macb_alloc_consistent(struct macb *bp)
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
 
@@ -2705,7 +2800,7 @@ static int gem_init_rings(struct macb *bp, bool fail_early)
 		/* This is a hard failure, so the best we can do is try the
 		 * next queue in case of HRESP error.
 		 */
-		err = gem_create_page_pool(queue);
+		err = gem_create_page_pool(queue, q);
 		if (err) {
 			last_err = err;
 			if (fail_early)
@@ -3156,11 +3251,27 @@ static int macb_close(struct net_device *dev)
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
@@ -3178,6 +3289,39 @@ static int macb_set_mac_addr(struct net_device *dev, void *addr)
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
@@ -4431,6 +4575,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_set	= macb_hwtstamp_set,
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
+	.ndo_bpf		= gem_xdp,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -5734,6 +5879,9 @@ static int macb_probe(struct platform_device *pdev)
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


