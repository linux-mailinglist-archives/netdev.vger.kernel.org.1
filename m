Return-Path: <netdev+bounces-66635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D80AE8400AC
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 09:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DD128279A
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8CB54BE9;
	Mon, 29 Jan 2024 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="teNpyHG1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F154F91
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518564; cv=none; b=s7XXWCckUstbtA+NmadheNSVznN5hcpU+HYXmmH+i9BrAj1WBECBzMTHuSwwW5x7F9N5gznR+Eu04iop96fy/oKcLDXZO6Gkxhr6lZM+1JbMI/MqXPsENebx2xOYtGtQKDc88P2o63zEPnUEU1Te013DLLerP0EBiOJLJC6l9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518564; c=relaxed/simple;
	bh=wUrHGEUmqx947aVlD58JPGRgeN41dwl1lIoidiRv94M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCIAiMxRz9VsBEgOCI+LEfy+YWMqZ5qZsrWMzoGD43RnNmcSbK/rspP2wZMNl+/oMtHDrdmoib/GONZV/9NSRs1rPmP3kPTjhoba8vXimazHdbbq573XUOI0eZHqYZ3CtHAtvLX5nuCgChLvNuKCpG8D3IbeVUNMJPDslUZBzBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=teNpyHG1; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706518563; x=1738054563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZzxLTSTezCQ9cVhrTxeQfVrFlTbLsBxD7tMEvXcEmiw=;
  b=teNpyHG1uVKehMoE9EsMVsKyFW/RuhDfizOHbXwuBlYjdwwpRkdDWd8e
   UICA8drVTV6BfvzvVj8Tu4FGWSVhKdymokhW9XDEE/Qj6Rfjq//f4vM3k
   cPZTkKe7sWj7m0RnpFYq/wOdG7ziywnWWcN/KOKuzhXHsqvKnJ/xPxvEf
   A=;
X-IronPort-AV: E=Sophos;i="6.05,226,1701129600"; 
   d="scan'208";a="634147419"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:56:02 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com (Postfix) with ESMTPS id 2F4EC40D41;
	Mon, 29 Jan 2024 08:56:00 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:62317]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.103:2525] with esmtp (Farcaster)
 id 9d2b4952-2d06-4f1c-8f9c-6d7acb24eca3; Mon, 29 Jan 2024 08:56:00 +0000 (UTC)
X-Farcaster-Flow-ID: 9d2b4952-2d06-4f1c-8f9c-6d7acb24eca3
Received: from EX19D010UWB001.ant.amazon.com (10.13.138.63) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:56:00 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D010UWB001.ant.amazon.com (10.13.138.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:55:59 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 08:55:56
 +0000
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
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, "Koler, Nati"
	<nkolder@amazon.com>
Subject: [PATCH v1 net-next 05/11] net: ena: Remove CQ tail pointer update
Date: Mon, 29 Jan 2024 08:55:25 +0000
Message-ID: <20240129085531.15608-6-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240129085531.15608-1-darinzon@amazon.com>
References: <20240129085531.15608-1-darinzon@amazon.com>
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

The functionality was added to allow the drivers to create an
SQ and CQ of different sizes.
When the RX/TX SQ and CQ have the same size, such update isn't
necessary as the device can safely assume it doesn't override
unprocessed completions. However, if the SQ is larger than the CQ,
the device might "have" more completions it wants to update about
than there's room in the CQ.

There's no support for different SQ and CQ sizes, therefore,
removing the API and its usage.

'____cacheline_aligned' compiler attribute was added to
'struct ena_com_io_cq' to ensure that the removal of the
'cq_head_db_reg' field doesn't change the cache-line layout
of this struct.

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c     |  5 ----
 drivers/net/ethernet/amazon/ena/ena_com.h     |  5 +---
 drivers/net/ethernet/amazon/ena/ena_eth_com.h | 24 -------------------
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  5 +---
 drivers/net/ethernet/amazon/ena/ena_xdp.c     |  1 -
 5 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 9a8a43b..675ee72 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -1427,11 +1427,6 @@ int ena_com_create_io_cq(struct ena_com_dev *ena_dev,
 	io_cq->unmask_reg = (u32 __iomem *)((uintptr_t)ena_dev->reg_bar +
 		cmd_completion.cq_interrupt_unmask_register_offset);
 
-	if (cmd_completion.cq_head_db_register_offset)
-		io_cq->cq_head_db_reg =
-			(u32 __iomem *)((uintptr_t)ena_dev->reg_bar +
-			cmd_completion.cq_head_db_register_offset);
-
 	if (cmd_completion.numa_node_register_offset)
 		io_cq->numa_node_cfg_reg =
 			(u32 __iomem *)((uintptr_t)ena_dev->reg_bar +
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index f3176fc..8f90c3c 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -109,8 +109,6 @@ struct ena_com_io_cq {
 	/* Interrupt unmask register */
 	u32 __iomem *unmask_reg;
 
-	/* The completion queue head doorbell register */
-	u32 __iomem *cq_head_db_reg;
 
 	/* numa configuration register (for TPH) */
 	u32 __iomem *numa_node_cfg_reg;
@@ -118,7 +116,7 @@ struct ena_com_io_cq {
 	/* The value to write to the above register to unmask
 	 * the interrupt of this queue
 	 */
-	u32 msix_vector;
+	u32 msix_vector ____cacheline_aligned;
 
 	enum queue_direction direction;
 
@@ -134,7 +132,6 @@ struct ena_com_io_cq {
 	/* Device queue index */
 	u16 idx;
 	u16 head;
-	u16 last_head_update;
 	u8 phase;
 	u8 cdesc_entry_size_in_bytes;
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_com.h b/drivers/net/ethernet/amazon/ena/ena_eth_com.h
index 372b259..4d65d82 100644
--- a/drivers/net/ethernet/amazon/ena/ena_eth_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.h
@@ -8,8 +8,6 @@
 
 #include "ena_com.h"
 
-/* head update threshold in units of (queue size / ENA_COMP_HEAD_THRESH) */
-#define ENA_COMP_HEAD_THRESH 4
 /* we allow 2 DMA descriptors per LLQ entry */
 #define ENA_LLQ_ENTRY_DESC_CHUNK_SIZE	(2 * sizeof(struct ena_eth_io_tx_desc))
 #define ENA_LLQ_HEADER		(128UL - ENA_LLQ_ENTRY_DESC_CHUNK_SIZE)
@@ -172,28 +170,6 @@ static inline int ena_com_write_sq_doorbell(struct ena_com_io_sq *io_sq)
 	return 0;
 }
 
-static inline int ena_com_update_dev_comp_head(struct ena_com_io_cq *io_cq)
-{
-	u16 unreported_comp, head;
-	bool need_update;
-
-	if (unlikely(io_cq->cq_head_db_reg)) {
-		head = io_cq->head;
-		unreported_comp = head - io_cq->last_head_update;
-		need_update = unreported_comp > (io_cq->q_depth / ENA_COMP_HEAD_THRESH);
-
-		if (unlikely(need_update)) {
-			netdev_dbg(ena_com_io_cq_to_ena_dev(io_cq)->net_device,
-				   "Write completion queue doorbell for queue %d: head: %d\n",
-				   io_cq->qid, head);
-			writel(head, io_cq->cq_head_db_reg);
-			io_cq->last_head_update = head;
-		}
-	}
-
-	return 0;
-}
-
 static inline void ena_com_update_numa_node(struct ena_com_io_cq *io_cq,
 					    u8 numa_node)
 {
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 0b7f94f..cd75e5a 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -856,7 +856,6 @@ static int ena_clean_tx_irq(struct ena_ring *tx_ring, u32 budget)
 
 	tx_ring->next_to_clean = next_to_clean;
 	ena_com_comp_ack(tx_ring->ena_com_io_sq, total_done);
-	ena_com_update_dev_comp_head(tx_ring->ena_com_io_cq);
 
 	netdev_tx_completed_queue(txq, tx_pkts, tx_bytes);
 
@@ -1303,10 +1302,8 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 		      ENA_RX_REFILL_THRESH_PACKET);
 
 	/* Optimization, try to batch new rx buffers */
-	if (refill_required > refill_threshold) {
-		ena_com_update_dev_comp_head(rx_ring->ena_com_io_cq);
+	if (refill_required > refill_threshold)
 		ena_refill_rx_bufs(rx_ring, refill_required);
-	}
 
 	if (xdp_flags & ENA_XDP_REDIRECT)
 		xdp_do_flush();
diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.c b/drivers/net/ethernet/amazon/ena/ena_xdp.c
index fc1c4ef..337c435 100644
--- a/drivers/net/ethernet/amazon/ena/ena_xdp.c
+++ b/drivers/net/ethernet/amazon/ena/ena_xdp.c
@@ -412,7 +412,6 @@ static int ena_clean_xdp_irq(struct ena_ring *tx_ring, u32 budget)
 
 	tx_ring->next_to_clean = next_to_clean;
 	ena_com_comp_ack(tx_ring->ena_com_io_sq, total_done);
-	ena_com_update_dev_comp_head(tx_ring->ena_com_io_cq);
 
 	netif_dbg(tx_ring->adapter, tx_done, tx_ring->netdev,
 		  "tx_poll: q %d done. total pkts: %d\n",
-- 
2.40.1


