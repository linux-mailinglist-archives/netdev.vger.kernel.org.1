Return-Path: <netdev+bounces-60740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFF8821523
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 20:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DBF1B20AB1
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 19:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD299DDC4;
	Mon,  1 Jan 2024 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="q/bxk7Xx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E8DDA1
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704136175; x=1735672175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xmToaz677AadL30RL/TbmREJQ0W3uHfveZ+RnwnRAQA=;
  b=q/bxk7XxA6RE2JBE1Gz7s/fbLUZJecU+J69kfhCtV4C7vzoslkzSr5NU
   thfs0TArg9EawfCDbEGzqSP6zUjB4dtH9WajqJ+DjN6fok2nanEWuWugY
   0kf5WO4Mf0t3J11ltZiCROsg8jJAJxpmP6RjrZzlV7jp1yJr1dl5fiz05
   w=;
X-IronPort-AV: E=Sophos;i="6.04,322,1695686400"; 
   d="scan'208";a="319681660"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 19:09:28 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id 5A27A8A869;
	Mon,  1 Jan 2024 19:09:27 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:53729]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.123:2525] with esmtp (Farcaster)
 id 948845c9-3d88-4fc8-8bde-27926b6d7a24; Mon, 1 Jan 2024 19:09:26 +0000 (UTC)
X-Farcaster-Flow-ID: 948845c9-3d88-4fc8-8bde-27926b6d7a24
Received: from EX19D021UWC001.ant.amazon.com (10.13.139.226) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 19:09:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D021UWC001.ant.amazon.com (10.13.139.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 19:09:26 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 1 Jan 2024 19:09:23 +0000
From: <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: [PATCH v2 net-next 05/11] net: ena: Use tx_ring instead of xdp_ring for XDP channel TX
Date: Mon, 1 Jan 2024 19:08:49 +0000
Message-ID: <20240101190855.18739-6-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240101190855.18739-1-darinzon@amazon.com>
References: <20240101190855.18739-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: Bulk

From: David Arinzon <darinzon@amazon.com>

When an XDP program is loaded the existing channels in the driver split
into two halves:
- The first half of the channels contain RX and TX rings, these queues
  are used for receiving traffic and sending packets originating from
  kernel.
- The second half of the channels contain only a TX ring. These queues
  are used for sending packets that were redirected using XDP_TX
  or XDP_REDIRECT.

Referring to the queues in the second half of the channels as "xdp_ring"
can be confusing and may give the impression that ENA has the capability
to generate an additional special queue.

This patch ensures that the xdp_ring field is exclusively used to
describe the XDP TX queue that a specific RX queue needs to utilize when
forwarding packets with XDP TX and XDP REDIRECT, preserving the
integrity of the xdp_ring field in ena_ring.

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |  12 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.h |   1 -
 drivers/net/ethernet/amazon/ena/ena_xdp.c    | 111 +++++++++----------
 drivers/net/ethernet/amazon/ena/ena_xdp.h    |   2 +-
 4 files changed, 61 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 3c84259..6ababac 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1746,8 +1746,8 @@ static void ena_del_napi_in_range(struct ena_adapter *adapter,
 	for (i = first_index; i < first_index + count; i++) {
 		netif_napi_del(&adapter->ena_napi[i].napi);
 
-		WARN_ON(!ENA_IS_XDP_INDEX(adapter, i) &&
-			adapter->ena_napi[i].xdp_ring);
+		WARN_ON(ENA_IS_XDP_INDEX(adapter, i) &&
+			adapter->ena_napi[i].rx_ring);
 	}
 }
 
@@ -1762,12 +1762,10 @@ static void ena_init_napi_in_range(struct ena_adapter *adapter,
 		netif_napi_add(adapter->netdev, &napi->napi,
 			       ENA_IS_XDP_INDEX(adapter, i) ? ena_xdp_io_poll : ena_io_poll);
 
-		if (!ENA_IS_XDP_INDEX(adapter, i)) {
+		if (!ENA_IS_XDP_INDEX(adapter, i))
 			napi->rx_ring = &adapter->rx_ring[i];
-			napi->tx_ring = &adapter->tx_ring[i];
-		} else {
-			napi->xdp_ring = &adapter->tx_ring[i];
-		}
+
+		napi->tx_ring = &adapter->tx_ring[i];
 		napi->qid = i;
 	}
 }
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index d3fc03f..6d2cc20 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -125,7 +125,6 @@ struct ena_napi {
 	struct napi_struct napi;
 	struct ena_ring *tx_ring;
 	struct ena_ring *rx_ring;
-	struct ena_ring *xdp_ring;
 	u32 qid;
 	struct dim dim;
 };
diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.c b/drivers/net/ethernet/amazon/ena/ena_xdp.c
index 42370fa..363e361 100644
--- a/drivers/net/ethernet/amazon/ena/ena_xdp.c
+++ b/drivers/net/ethernet/amazon/ena/ena_xdp.c
@@ -5,23 +5,23 @@
 
 #include "ena_xdp.h"
 
-static int validate_xdp_req_id(struct ena_ring *xdp_ring, u16 req_id)
+static int validate_xdp_req_id(struct ena_ring *tx_ring, u16 req_id)
 {
 	struct ena_tx_buffer *tx_info;
 
-	tx_info = &xdp_ring->tx_buffer_info[req_id];
+	tx_info = &tx_ring->tx_buffer_info[req_id];
 	if (likely(tx_info->xdpf))
 		return 0;
 
-	return handle_invalid_req_id(xdp_ring, req_id, tx_info, true);
+	return handle_invalid_req_id(tx_ring, req_id, tx_info, true);
 }
 
-static int ena_xdp_tx_map_frame(struct ena_ring *xdp_ring,
+static int ena_xdp_tx_map_frame(struct ena_ring *tx_ring,
 				struct ena_tx_buffer *tx_info,
 				struct xdp_frame *xdpf,
 				struct ena_com_tx_ctx *ena_tx_ctx)
 {
-	struct ena_adapter *adapter = xdp_ring->adapter;
+	struct ena_adapter *adapter = tx_ring->adapter;
 	struct ena_com_buf *ena_buf;
 	int push_len = 0;
 	dma_addr_t dma;
@@ -32,9 +32,9 @@ static int ena_xdp_tx_map_frame(struct ena_ring *xdp_ring,
 	data = tx_info->xdpf->data;
 	size = tx_info->xdpf->len;
 
-	if (xdp_ring->tx_mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV) {
+	if (tx_ring->tx_mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV) {
 		/* Designate part of the packet for LLQ */
-		push_len = min_t(u32, size, xdp_ring->tx_max_header_size);
+		push_len = min_t(u32, size, tx_ring->tx_max_header_size);
 
 		ena_tx_ctx->push_header = data;
 
@@ -45,11 +45,11 @@ static int ena_xdp_tx_map_frame(struct ena_ring *xdp_ring,
 	ena_tx_ctx->header_len = push_len;
 
 	if (size > 0) {
-		dma = dma_map_single(xdp_ring->dev,
+		dma = dma_map_single(tx_ring->dev,
 				     data,
 				     size,
 				     DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(xdp_ring->dev, dma)))
+		if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
 			goto error_report_dma_error;
 
 		tx_info->map_linear_data = 0;
@@ -65,14 +65,14 @@ static int ena_xdp_tx_map_frame(struct ena_ring *xdp_ring,
 	return 0;
 
 error_report_dma_error:
-	ena_increase_stat(&xdp_ring->tx_stats.dma_mapping_err, 1,
-			  &xdp_ring->syncp);
+	ena_increase_stat(&tx_ring->tx_stats.dma_mapping_err, 1,
+			  &tx_ring->syncp);
 	netif_warn(adapter, tx_queued, adapter->netdev, "Failed to map xdp buff\n");
 
 	return -EINVAL;
 }
 
-int ena_xdp_xmit_frame(struct ena_ring *xdp_ring,
+int ena_xdp_xmit_frame(struct ena_ring *tx_ring,
 		       struct ena_adapter *adapter,
 		       struct xdp_frame *xdpf,
 		       int flags)
@@ -82,19 +82,19 @@ int ena_xdp_xmit_frame(struct ena_ring *xdp_ring,
 	u16 next_to_use, req_id;
 	int rc;
 
-	next_to_use = xdp_ring->next_to_use;
-	req_id = xdp_ring->free_ids[next_to_use];
-	tx_info = &xdp_ring->tx_buffer_info[req_id];
+	next_to_use = tx_ring->next_to_use;
+	req_id = tx_ring->free_ids[next_to_use];
+	tx_info = &tx_ring->tx_buffer_info[req_id];
 	tx_info->num_of_bufs = 0;
 
-	rc = ena_xdp_tx_map_frame(xdp_ring, tx_info, xdpf, &ena_tx_ctx);
+	rc = ena_xdp_tx_map_frame(tx_ring, tx_info, xdpf, &ena_tx_ctx);
 	if (unlikely(rc))
 		return rc;
 
 	ena_tx_ctx.req_id = req_id;
 
 	rc = ena_xmit_common(adapter,
-			     xdp_ring,
+			     tx_ring,
 			     tx_info,
 			     &ena_tx_ctx,
 			     next_to_use,
@@ -106,12 +106,12 @@ int ena_xdp_xmit_frame(struct ena_ring *xdp_ring,
 	 * calls a memory barrier inside it.
 	 */
 	if (flags & XDP_XMIT_FLUSH)
-		ena_ring_tx_doorbell(xdp_ring);
+		ena_ring_tx_doorbell(tx_ring);
 
 	return rc;
 
 error_unmap_dma:
-	ena_unmap_tx_buff(xdp_ring, tx_info);
+	ena_unmap_tx_buff(tx_ring, tx_info);
 	tx_info->xdpf = NULL;
 	return rc;
 }
@@ -120,7 +120,7 @@ int ena_xdp_xmit(struct net_device *dev, int n,
 		 struct xdp_frame **frames, u32 flags)
 {
 	struct ena_adapter *adapter = netdev_priv(dev);
-	struct ena_ring *xdp_ring;
+	struct ena_ring *tx_ring;
 	int qid, i, nxmit = 0;
 
 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
@@ -135,22 +135,22 @@ int ena_xdp_xmit(struct net_device *dev, int n,
 
 	qid = smp_processor_id() % adapter->xdp_num_queues;
 	qid += adapter->xdp_first_ring;
-	xdp_ring = &adapter->tx_ring[qid];
+	tx_ring = &adapter->tx_ring[qid];
 
 	/* Other CPU ids might try to send thorugh this queue */
-	spin_lock(&xdp_ring->xdp_tx_lock);
+	spin_lock(&tx_ring->xdp_tx_lock);
 
 	for (i = 0; i < n; i++) {
-		if (ena_xdp_xmit_frame(xdp_ring, adapter, frames[i], 0))
+		if (ena_xdp_xmit_frame(tx_ring, adapter, frames[i], 0))
 			break;
 		nxmit++;
 	}
 
 	/* Ring doorbell to make device aware of the packets */
 	if (flags & XDP_XMIT_FLUSH)
-		ena_ring_tx_doorbell(xdp_ring);
+		ena_ring_tx_doorbell(tx_ring);
 
-	spin_unlock(&xdp_ring->xdp_tx_lock);
+	spin_unlock(&tx_ring->xdp_tx_lock);
 
 	/* Return number of packets sent */
 	return nxmit;
@@ -355,7 +355,7 @@ int ena_xdp(struct net_device *netdev, struct netdev_bpf *bpf)
 	return 0;
 }
 
-static int ena_clean_xdp_irq(struct ena_ring *xdp_ring, u32 budget)
+static int ena_clean_xdp_irq(struct ena_ring *tx_ring, u32 budget)
 {
 	u32 total_done = 0;
 	u16 next_to_clean;
@@ -363,55 +363,54 @@ static int ena_clean_xdp_irq(struct ena_ring *xdp_ring, u32 budget)
 	u16 req_id;
 	int rc;
 
-	if (unlikely(!xdp_ring))
+	if (unlikely(!tx_ring))
 		return 0;
-	next_to_clean = xdp_ring->next_to_clean;
+	next_to_clean = tx_ring->next_to_clean;
 
 	while (tx_pkts < budget) {
 		struct ena_tx_buffer *tx_info;
 		struct xdp_frame *xdpf;
 
-		rc = ena_com_tx_comp_req_id_get(xdp_ring->ena_com_io_cq,
+		rc = ena_com_tx_comp_req_id_get(tx_ring->ena_com_io_cq,
 						&req_id);
 		if (rc) {
 			if (unlikely(rc == -EINVAL))
-				handle_invalid_req_id(xdp_ring, req_id, NULL,
-						      true);
+				handle_invalid_req_id(tx_ring, req_id, NULL, true);
 			break;
 		}
 
 		/* validate that the request id points to a valid xdp_frame */
-		rc = validate_xdp_req_id(xdp_ring, req_id);
+		rc = validate_xdp_req_id(tx_ring, req_id);
 		if (rc)
 			break;
 
-		tx_info = &xdp_ring->tx_buffer_info[req_id];
+		tx_info = &tx_ring->tx_buffer_info[req_id];
 		xdpf = tx_info->xdpf;
 
 		tx_info->xdpf = NULL;
 		tx_info->last_jiffies = 0;
-		ena_unmap_tx_buff(xdp_ring, tx_info);
+		ena_unmap_tx_buff(tx_ring, tx_info);
 
-		netif_dbg(xdp_ring->adapter, tx_done, xdp_ring->netdev,
-			  "tx_poll: q %d skb %p completed\n", xdp_ring->qid,
+		netif_dbg(tx_ring->adapter, tx_done, tx_ring->netdev,
+			  "tx_poll: q %d skb %p completed\n", tx_ring->qid,
 			  xdpf);
 
 		tx_pkts++;
 		total_done += tx_info->tx_descs;
 
 		xdp_return_frame(xdpf);
-		xdp_ring->free_ids[next_to_clean] = req_id;
+		tx_ring->free_ids[next_to_clean] = req_id;
 		next_to_clean = ENA_TX_RING_IDX_NEXT(next_to_clean,
-						     xdp_ring->ring_size);
+						     tx_ring->ring_size);
 	}
 
-	xdp_ring->next_to_clean = next_to_clean;
-	ena_com_comp_ack(xdp_ring->ena_com_io_sq, total_done);
-	ena_com_update_dev_comp_head(xdp_ring->ena_com_io_cq);
+	tx_ring->next_to_clean = next_to_clean;
+	ena_com_comp_ack(tx_ring->ena_com_io_sq, total_done);
+	ena_com_update_dev_comp_head(tx_ring->ena_com_io_cq);
 
-	netif_dbg(xdp_ring->adapter, tx_done, xdp_ring->netdev,
+	netif_dbg(tx_ring->adapter, tx_done, tx_ring->netdev,
 		  "tx_poll: q %d done. total pkts: %d\n",
-		  xdp_ring->qid, tx_pkts);
+		  tx_ring->qid, tx_pkts);
 
 	return tx_pkts;
 }
@@ -423,43 +422,43 @@ int ena_xdp_io_poll(struct napi_struct *napi, int budget)
 {
 	struct ena_napi *ena_napi = container_of(napi, struct ena_napi, napi);
 	u32 xdp_work_done, xdp_budget;
-	struct ena_ring *xdp_ring;
+	struct ena_ring *tx_ring;
 	int napi_comp_call = 0;
 	int ret;
 
-	xdp_ring = ena_napi->xdp_ring;
+	tx_ring = ena_napi->tx_ring;
 
 	xdp_budget = budget;
 
-	if (!test_bit(ENA_FLAG_DEV_UP, &xdp_ring->adapter->flags) ||
-	    test_bit(ENA_FLAG_TRIGGER_RESET, &xdp_ring->adapter->flags)) {
+	if (!test_bit(ENA_FLAG_DEV_UP, &tx_ring->adapter->flags) ||
+	    test_bit(ENA_FLAG_TRIGGER_RESET, &tx_ring->adapter->flags)) {
 		napi_complete_done(napi, 0);
 		return 0;
 	}
 
-	xdp_work_done = ena_clean_xdp_irq(xdp_ring, xdp_budget);
+	xdp_work_done = ena_clean_xdp_irq(tx_ring, xdp_budget);
 
 	/* If the device is about to reset or down, avoid unmask
 	 * the interrupt and return 0 so NAPI won't reschedule
 	 */
-	if (unlikely(!test_bit(ENA_FLAG_DEV_UP, &xdp_ring->adapter->flags))) {
+	if (unlikely(!test_bit(ENA_FLAG_DEV_UP, &tx_ring->adapter->flags))) {
 		napi_complete_done(napi, 0);
 		ret = 0;
 	} else if (xdp_budget > xdp_work_done) {
 		napi_comp_call = 1;
 		if (napi_complete_done(napi, xdp_work_done))
-			ena_unmask_interrupt(xdp_ring, NULL);
-		ena_update_ring_numa_node(xdp_ring, NULL);
+			ena_unmask_interrupt(tx_ring, NULL);
+		ena_update_ring_numa_node(tx_ring, NULL);
 		ret = xdp_work_done;
 	} else {
 		ret = xdp_budget;
 	}
 
-	u64_stats_update_begin(&xdp_ring->syncp);
-	xdp_ring->tx_stats.napi_comp += napi_comp_call;
-	xdp_ring->tx_stats.tx_poll++;
-	u64_stats_update_end(&xdp_ring->syncp);
-	xdp_ring->tx_stats.last_napi_jiffies = jiffies;
+	u64_stats_update_begin(&tx_ring->syncp);
+	tx_ring->tx_stats.napi_comp += napi_comp_call;
+	tx_ring->tx_stats.tx_poll++;
+	u64_stats_update_end(&tx_ring->syncp);
+	tx_ring->tx_stats.last_napi_jiffies = jiffies;
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.h b/drivers/net/ethernet/amazon/ena/ena_xdp.h
index 6e472ba..3fa8e80 100644
--- a/drivers/net/ethernet/amazon/ena/ena_xdp.h
+++ b/drivers/net/ethernet/amazon/ena/ena_xdp.h
@@ -35,7 +35,7 @@ void ena_xdp_exchange_program_rx_in_range(struct ena_adapter *adapter,
 					  struct bpf_prog *prog,
 					  int first, int count);
 int ena_xdp_io_poll(struct napi_struct *napi, int budget);
-int ena_xdp_xmit_frame(struct ena_ring *xdp_ring,
+int ena_xdp_xmit_frame(struct ena_ring *tx_ring,
 		       struct ena_adapter *adapter,
 		       struct xdp_frame *xdpf,
 		       int flags);
-- 
2.40.1


