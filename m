Return-Path: <netdev+bounces-163298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10BDA29DB7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 00:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9DF167BB9
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2F321E08B;
	Wed,  5 Feb 2025 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="f6tcqD8f"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BFA21C160
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738799743; cv=none; b=BLCG+eo6ONOfg1UjqAYwaJxmfBc2STR4JJE/iA40JdkYbcNy9a6Mxc9Yoy9M5Pd/qbbMFjCFoRsYv/7U76KNBXvmQ/CscdBoHYBImS7cUldGHxvMpHCbK6PDZsmfr18kf4C6Cnku2cCwi2mucWEbP3J+yb35aoPmLhEcNqxFM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738799743; c=relaxed/simple;
	bh=HqMfERiUi1mKvr1M75VloGuuC8UvaGHcckOAGk3KIRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pFQyuE3gn/NXJU6QNMB/Hz2J3RACGUyC6cScHH/2m2WS1cYmwF+GoTNNfifnW0RLgNuxwz3ihApVSVUmChN8+xBGMzQH0CbMLUQalAawXffpjntSwqeAtn1np2FIh9D/rOxUgDZI29Y5tVO8zMTZM40gKrzIRsUOEtAJhVRi5SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=f6tcqD8f; arc=none smtp.client-ip=173.37.86.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11296; q=dns/txt;
  s=iport; t=1738799741; x=1740009341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FeyjU/3HJPwEff8DDclrtSA4sSiJFv12zMCbIXaIy6k=;
  b=f6tcqD8foxfIzgGaUZsIifp2Kwr8+rT3QdB7QOl5h7XWgIp88dqW7n5m
   e6yxFjNK35yff+hfflibu72EZRf527jqJdSe6gtsdO7uIHTJApJC8fCW0
   O5sTwINGPSmW/0NxdAPP7qtQj7mN4RG2gD0Sek4gMkmbOy4HbOaQl+qv5
   4=;
X-CSE-ConnectionGUID: AKvbnKC8Ro+nQJ/TyS8cnQ==
X-CSE-MsgGUID: v/zgVEGtS7CnwlfwwZkyqA==
X-IPAS-Result: =?us-ascii?q?A0AWAABv+aNn/5L/Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBggICAQEBAQsBgkqBT0NIjVGIdJ88A1YPAQEBD0QEAQGFBwKLA?=
 =?us-ascii?q?AImNwYOAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZbA?=
 =?us-ascii?q?gEDJwsBRhBRKysHEoMCgmUDsFGBeTOBAd40gW6BSAGFa4dfcIR3JxuBSUSBF?=
 =?us-ascii?q?YE7gT5viwcEh16idEiBIQNZLAFVEw0KCwcFgTk4AyAKCwwLFBwVAhQdDwYQB?=
 =?us-ascii?q?GpEN4JHaUk6Ag0CNYIeJFiCK4RahEOETYJDVIJEghJ0gRqIPEADCxgNSBEsN?=
 =?us-ascii?q?wYOGwY+bgedTTyDUkV7CQsbCoEBbVeTJ5ABgiChBIQlgWOfYxozqlOYfCKkJ?=
 =?us-ascii?q?oRmgX0mgVkzGggbFYMiUhkPjioDFswmJTI8AgcLAQEDCZF8AQE?=
IronPort-Data: A9a23:rcaZ5q0bEgw3mx569fbD5fFwkn2cJEfYwER7XKvMYLTBsI5bp2MAx
 mMfWDjVa62PZjD8LYh1bIvl9k9X6pTdn943SVA93Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmE4E/watANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXU4
 rsen+WFYAX4g2QsbzpOg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGJWIoN4s70bZNBiJIz
 N5fFCE2PhuFvrfjqF67YrEEasULNsLnOsYb/3pn1zycVadgSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNUieC/FMEg9/5JYWnuCogHX2dzBwo1OOrq1x6G/WpOB0+OO0bYOFI4TVHK25mG6G4
 XDJwUnWHipFH9qAzTSa7UCvl/bmyHaTtIU6UefQGuRRqFGa2GEWIBEfS1a+pf63lgi4Vs43A
 0EY5y8nv6Uu3EOsSdb5Uluzp3vslh0BUdN4EOAg7gyJjK3O7G6xD24IVDNeK9orqMM7WxQuy
 1mP2djpbRR3ubeYT3O17LqYrTqufyMSKAcqYyIYQQYby8fsrZt1jR/VSNtnVqmvgbXI9SrY2
 TuGqm06wr4Ul8NOj/T99lHciDXqrZ/MJuIo2jjqsquexlsRTOaYi0aAsDA3Md4owF6lc2S8
IronPort-HdrOrdr: A9a23:eJewsK5NH5haHzBJcwPXwM/XdLJyesId70hD6qm+c3Nom6uj5q
 eTdZsgtCMc5Ax9ZJhko6HjBEDiewK5yXcK2+ks1N6ZNWGM0ldAbrsSiLcKqAePJ8SRzIJgPN
 9bAstD4BmaNykCsS48izPIdeod/A==
X-Talos-CUID: 9a23:+d15BmMFFTloAO5DcQp5/kg3MZAfdT7b9VWXH16DWW1vcejA
X-Talos-MUID: 9a23:CYo9swYFllFwkeBTqXj+iw9PG9tTvI+oF0QDjoo0uNidHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,262,1732579200"; 
   d="scan'208";a="315181071"
Received: from rcdn-l-core-09.cisco.com ([173.37.255.146])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 Feb 2025 23:54:32 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-09.cisco.com (Postfix) with ESMTP id 2F85A18000234;
	Wed,  5 Feb 2025 23:54:32 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 04EB620F2003; Wed,  5 Feb 2025 15:54:32 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v8 3/4] enic: Use the Page Pool API for RX
Date: Wed,  5 Feb 2025 15:54:15 -0800
Message-Id: <20250205235416.25410-4-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250205235416.25410-1-johndale@cisco.com>
References: <20250205235416.25410-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-09.cisco.com

The Page Pool API improves bandwidth and CPU overhead by recycling pages
instead of allocating new buffers in the driver. Make use of page pool
fragment allocation for smaller MTUs so that multiple packets can share
a page. For MTUs larger than PAGE_SIZE, adjust the 'order' page
parameter so that contiguous pages can be used to receive the larger
packets.

The RQ descriptor field 'os_buf' is repurposed to hold page pointers
allocated from page_pool instead of SKBs. When packets arrive, SKBs are
allocated and the page pointers are attached instead of preallocating SKBs.

'alloc_fail' netdev statistic is incremented when page_pool_dev_alloc()
fails.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  3 +
 drivers/net/ethernet/cisco/enic/enic_main.c | 33 +++++++-
 drivers/net/ethernet/cisco/enic/enic_rq.c   | 94 ++++++++-------------
 drivers/net/ethernet/cisco/enic/vnic_rq.h   |  2 +
 4 files changed, 71 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 10b7e02ba4d0..2ccf2d2a77db 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -17,6 +17,7 @@
 #include "vnic_nic.h"
 #include "vnic_rss.h"
 #include <linux/irq.h>
+#include <net/page_pool/helpers.h>
 
 #define DRV_NAME		"enic"
 #define DRV_DESCRIPTION		"Cisco VIC Ethernet NIC Driver"
@@ -158,6 +159,7 @@ struct enic_rq_stats {
 	u64 pkt_truncated;		/* truncated pkts */
 	u64 no_skb;			/* out of skbs */
 	u64 desc_skip;			/* Rx pkt went into later buffer */
+	u64 pp_alloc_fail;		/* page pool alloc failure */
 };
 
 struct enic_wq {
@@ -169,6 +171,7 @@ struct enic_wq {
 struct enic_rq {
 	struct vnic_rq vrq;
 	struct enic_rq_stats stats;
+	struct page_pool *pool;
 } ____cacheline_aligned;
 
 /* Per-instance private data structure */
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 1d9f109346b8..447c54dcd89b 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1736,6 +1736,17 @@ static int enic_open(struct net_device *netdev)
 	struct enic *enic = netdev_priv(netdev);
 	unsigned int i;
 	int err, ret;
+	unsigned int max_pkt_len = netdev->mtu + VLAN_ETH_HLEN;
+	struct page_pool_params pp_params = {
+		.order = get_order(max_pkt_len),
+		.pool_size = enic->config.rq_desc_count,
+		.nid = dev_to_node(&enic->pdev->dev),
+		.dev = &enic->pdev->dev,
+		.dma_dir = DMA_FROM_DEVICE,
+		.max_len = (max_pkt_len > PAGE_SIZE) ? max_pkt_len : PAGE_SIZE,
+		.netdev = netdev,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+	};
 
 	err = enic_request_intr(enic);
 	if (err) {
@@ -1753,6 +1764,16 @@ static int enic_open(struct net_device *netdev)
 	}
 
 	for (i = 0; i < enic->rq_count; i++) {
+		/* create a page pool for each RQ */
+		pp_params.napi = &enic->napi[i];
+		pp_params.queue_idx = i;
+		enic->rq[i].pool = page_pool_create(&pp_params);
+		if (IS_ERR(enic->rq[i].pool)) {
+			err = PTR_ERR(enic->rq[i].pool);
+			enic->rq[i].pool = NULL;
+			goto err_out_free_rq;
+		}
+
 		/* enable rq before updating rq desc */
 		vnic_rq_enable(&enic->rq[i].vrq);
 		vnic_rq_fill(&enic->rq[i].vrq, enic_rq_alloc_buf);
@@ -1793,8 +1814,11 @@ static int enic_open(struct net_device *netdev)
 err_out_free_rq:
 	for (i = 0; i < enic->rq_count; i++) {
 		ret = vnic_rq_disable(&enic->rq[i].vrq);
-		if (!ret)
+		if (!ret) {
 			vnic_rq_clean(&enic->rq[i].vrq, enic_free_rq_buf);
+			page_pool_destroy(enic->rq[i].pool);
+			enic->rq[i].pool = NULL;
+		}
 	}
 	enic_dev_notify_unset(enic);
 err_out_free_intr:
@@ -1852,8 +1876,11 @@ static int enic_stop(struct net_device *netdev)
 
 	for (i = 0; i < enic->wq_count; i++)
 		vnic_wq_clean(&enic->wq[i].vwq, enic_free_wq_buf);
-	for (i = 0; i < enic->rq_count; i++)
+	for (i = 0; i < enic->rq_count; i++) {
 		vnic_rq_clean(&enic->rq[i].vrq, enic_free_rq_buf);
+		page_pool_destroy(enic->rq[i].pool);
+		enic->rq[i].pool = NULL;
+	}
 	for (i = 0; i < enic->cq_count; i++)
 		vnic_cq_clean(&enic->cq[i]);
 	for (i = 0; i < enic->intr_count; i++)
@@ -2363,6 +2390,7 @@ static void enic_get_queue_stats_rx(struct net_device *dev, int idx,
 	rxs->hw_drop_overruns = rqstats->pkt_truncated;
 	rxs->csum_unnecessary = rqstats->csum_unnecessary +
 				rqstats->csum_unnecessary_encap;
+	rxs->alloc_fail = rqstats->pp_alloc_fail;
 }
 
 static void enic_get_queue_stats_tx(struct net_device *dev, int idx,
@@ -2390,6 +2418,7 @@ static void enic_get_base_stats(struct net_device *dev,
 	rxs->hw_drops = 0;
 	rxs->hw_drop_overruns = 0;
 	rxs->csum_unnecessary = 0;
+	rxs->alloc_fail = 0;
 	txs->bytes = 0;
 	txs->packets = 0;
 	txs->csum_none = 0;
diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.c b/drivers/net/ethernet/cisco/enic/enic_rq.c
index 48aa385aa831..e3228ef7988a 100644
--- a/drivers/net/ethernet/cisco/enic/enic_rq.c
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.c
@@ -21,25 +21,6 @@ static void enic_intr_update_pkt_size(struct vnic_rx_bytes_counter *pkt_size,
 		pkt_size->small_pkt_bytes_cnt += pkt_len;
 }
 
-static bool enic_rxcopybreak(struct net_device *netdev, struct sk_buff **skb,
-			     struct vnic_rq_buf *buf, u16 len)
-{
-	struct enic *enic = netdev_priv(netdev);
-	struct sk_buff *new_skb;
-
-	if (len > enic->rx_copybreak)
-		return false;
-	new_skb = netdev_alloc_skb_ip_align(netdev, len);
-	if (!new_skb)
-		return false;
-	dma_sync_single_for_cpu(&enic->pdev->dev, buf->dma_addr, len,
-				DMA_FROM_DEVICE);
-	memcpy(new_skb->data, (*skb)->data, len);
-	*skb = new_skb;
-
-	return true;
-}
-
 int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc, u8 type,
 		    u16 q_number, u16 completed_index, void *opaque)
 {
@@ -142,11 +123,15 @@ int enic_rq_alloc_buf(struct vnic_rq *rq)
 {
 	struct enic *enic = vnic_dev_priv(rq->vdev);
 	struct net_device *netdev = enic->netdev;
-	struct sk_buff *skb;
+	struct enic_rq *erq = &enic->rq[rq->index];
+	struct enic_rq_stats *rqstats = &erq->stats;
+	unsigned int offset = 0;
 	unsigned int len = netdev->mtu + VLAN_ETH_HLEN;
 	unsigned int os_buf_index = 0;
 	dma_addr_t dma_addr;
 	struct vnic_rq_buf *buf = rq->to_use;
+	struct page *page;
+	unsigned int truesize = len;
 
 	if (buf->os_buf) {
 		enic_queue_rq_desc(rq, buf->os_buf, os_buf_index, buf->dma_addr,
@@ -154,20 +139,16 @@ int enic_rq_alloc_buf(struct vnic_rq *rq)
 
 		return 0;
 	}
-	skb = netdev_alloc_skb_ip_align(netdev, len);
-	if (!skb) {
-		enic->rq[rq->index].stats.no_skb++;
-		return -ENOMEM;
-	}
 
-	dma_addr = dma_map_single(&enic->pdev->dev, skb->data, len,
-				  DMA_FROM_DEVICE);
-	if (unlikely(enic_dma_map_check(enic, dma_addr))) {
-		dev_kfree_skb(skb);
+	page = page_pool_dev_alloc(erq->pool, &offset, &truesize);
+	if (unlikely(!page)) {
+		rqstats->pp_alloc_fail++;
 		return -ENOMEM;
 	}
-
-	enic_queue_rq_desc(rq, skb, os_buf_index, dma_addr, len);
+	buf->offset = offset;
+	buf->truesize = truesize;
+	dma_addr = page_pool_get_dma_addr(page) + offset;
+	enic_queue_rq_desc(rq, (void *)page, os_buf_index, dma_addr, len);
 
 	return 0;
 }
@@ -175,13 +156,12 @@ int enic_rq_alloc_buf(struct vnic_rq *rq)
 void enic_free_rq_buf(struct vnic_rq *rq, struct vnic_rq_buf *buf)
 {
 	struct enic *enic = vnic_dev_priv(rq->vdev);
+	struct enic_rq *erq = &enic->rq[rq->index];
 
 	if (!buf->os_buf)
 		return;
 
-	dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
-			 DMA_FROM_DEVICE);
-	dev_kfree_skb_any(buf->os_buf);
+	page_pool_put_full_page(erq->pool, (struct page *)buf->os_buf, true);
 	buf->os_buf = NULL;
 }
 
@@ -189,10 +169,10 @@ void enic_rq_indicate_buf(struct vnic_rq *rq, struct cq_desc *cq_desc,
 			  struct vnic_rq_buf *buf, int skipped, void *opaque)
 {
 	struct enic *enic = vnic_dev_priv(rq->vdev);
-	struct net_device *netdev = enic->netdev;
 	struct sk_buff *skb;
 	struct vnic_cq *cq = &enic->cq[enic_cq_rq(enic, rq->index)];
 	struct enic_rq_stats *rqstats = &enic->rq[rq->index].stats;
+	struct napi_struct *napi;
 
 	u8 type, color, eop, sop, ingress_port, vlan_stripped;
 	u8 fcoe, fcoe_sof, fcoe_fc_crc_ok, fcoe_enc_error, fcoe_eof;
@@ -208,8 +188,6 @@ void enic_rq_indicate_buf(struct vnic_rq *rq, struct cq_desc *cq_desc,
 		return;
 	}
 
-	skb = buf->os_buf;
-
 	cq_enet_rq_desc_dec((struct cq_enet_rq_desc *)cq_desc, &type, &color,
 			    &q_number, &completed_index, &ingress_port, &fcoe,
 			    &eop, &sop, &rss_type, &csum_not_calc, &rss_hash,
@@ -219,48 +197,46 @@ void enic_rq_indicate_buf(struct vnic_rq *rq, struct cq_desc *cq_desc,
 			    &tcp, &ipv4_csum_ok, &ipv6, &ipv4, &ipv4_fragment,
 			    &fcs_ok);
 
-	if (enic_rq_pkt_error(rq, packet_error, fcs_ok, bytes_written)) {
-		dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
-				 DMA_FROM_DEVICE);
-		dev_kfree_skb_any(skb);
-		buf->os_buf = NULL;
-
+	if (enic_rq_pkt_error(rq, packet_error, fcs_ok, bytes_written))
 		return;
-	}
 
 	if (eop && bytes_written > 0) {
 		/* Good receive
 		 */
 		rqstats->bytes += bytes_written;
-		if (!enic_rxcopybreak(netdev, &skb, buf, bytes_written)) {
-			buf->os_buf = NULL;
-			dma_unmap_single(&enic->pdev->dev, buf->dma_addr,
-					 buf->len, DMA_FROM_DEVICE);
+		napi = &enic->napi[rq->index];
+		skb = napi_get_frags(napi);
+		if (unlikely(!skb)) {
+			net_warn_ratelimited("%s: skb alloc error rq[%d], desc[%d]\n",
+					     enic->netdev->name, rq->index,
+					     completed_index);
+			rqstats->no_skb++;
+			return;
 		}
+
 		prefetch(skb->data - NET_IP_ALIGN);
 
-		skb_put(skb, bytes_written);
-		skb->protocol = eth_type_trans(skb, netdev);
+		dma_sync_single_for_cpu(&enic->pdev->dev, buf->dma_addr,
+					bytes_written, DMA_FROM_DEVICE);
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				(struct page *)buf->os_buf, buf->offset,
+				bytes_written, buf->truesize);
 		skb_record_rx_queue(skb, q_number);
 		enic_rq_set_skb_flags(rq, type, rss_hash, rss_type, fcoe,
 				      fcoe_fc_crc_ok, vlan_stripped,
 				      csum_not_calc, tcp_udp_csum_ok, ipv6,
 				      ipv4_csum_ok, vlan_tci, skb);
-		skb_mark_napi_id(skb, &enic->napi[rq->index]);
-		if (!(netdev->features & NETIF_F_GRO))
-			netif_receive_skb(skb);
-		else
-			napi_gro_receive(&enic->napi[q_number], skb);
+		skb_mark_for_recycle(skb);
+		napi_gro_frags(napi);
 		if (enic->rx_coalesce_setting.use_adaptive_rx_coalesce)
 			enic_intr_update_pkt_size(&cq->pkt_size_counter,
 						  bytes_written);
+		buf->os_buf = NULL;
+		buf->dma_addr = 0;
+		buf = buf->next;
 	} else {
 		/* Buffer overflow
 		 */
 		rqstats->pkt_truncated++;
-		dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
-				 DMA_FROM_DEVICE);
-		dev_kfree_skb_any(skb);
-		buf->os_buf = NULL;
 	}
 }
diff --git a/drivers/net/ethernet/cisco/enic/vnic_rq.h b/drivers/net/ethernet/cisco/enic/vnic_rq.h
index 0bc595abc03b..2ee4be2b9a34 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_rq.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_rq.h
@@ -61,6 +61,8 @@ struct vnic_rq_buf {
 	unsigned int index;
 	void *desc;
 	uint64_t wr_id;
+	unsigned int offset;
+	unsigned int truesize;
 };
 
 enum enic_poll_state {
-- 
2.44.0


