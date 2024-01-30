Return-Path: <netdev+bounces-67085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D907F842048
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3261C24960
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A386A35A;
	Tue, 30 Jan 2024 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MkKb8rFy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183C6A333
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608477; cv=none; b=l2WmRNdT2BMLN+tBVcwOIA8Vw6F+NVHaEH95v2SYp9UUys1KIxJgwDRB6878Wyll0/sC/c6aJJ5v1+vjWK8w186v9hGMUyzHWi4DlK3L8+FdHze87Gi+zc6Dm0x001qFUyvQGfLFDP68ufdNCIgmh8teN5Do5co3M7NWVNkjqxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608477; c=relaxed/simple;
	bh=axEs1Avo2Bl/MAyn8NOVso1kjCD0dlrxC1xR32D6VbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoHHc8FF7lOsphE3InoWE0TZMLqu2MOetG2q50gbzg4DJp8CTkS6jxH/jIBd7rr9U238l1PZa4XJDrRW2jX1zB4IJuOue+c3fZ5F8Iv65tUjDn4iuoB8SA8JzCJza4IkqA7nNZ/o0E8gzxm2b11en4DTBiZa+XcWO+QaAZ1u/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MkKb8rFy; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706608476; x=1738144476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=62WzVoD4EUf6uZOtZfZBCRqS3p3dSTiYDMUWfCoL0Ns=;
  b=MkKb8rFyKf6Avk6bxgqPeZtnDRpRxP1UDaXFCXuyUF2pugoxfNl48UWx
   NKsIQfqm4WSYNbCKc+/DC4zFb91n/XVPByCOxssEeGDQl4SConRLbn/O3
   AZiACyGh1zny2YT8IkXkw+HeFSZtJ/UV4zB0BAI2BQvdhTyEjDvkAH5ZG
   4=;
X-IronPort-AV: E=Sophos;i="6.05,707,1701129600"; 
   d="scan'208";a="269686633"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:54:32 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id 575F1A0775;
	Tue, 30 Jan 2024 09:54:29 +0000 (UTC)
Received: from EX19MTAUEA001.ant.amazon.com [10.0.29.78:11254]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.38.57:2525] with esmtp (Farcaster)
 id 79d19c7c-4781-4c3b-9d7c-95544e1096d2; Tue, 30 Jan 2024 09:54:28 +0000 (UTC)
X-Farcaster-Flow-ID: 79d19c7c-4781-4c3b-9d7c-95544e1096d2
Received: from EX19D008UEC002.ant.amazon.com (10.252.135.242) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:15 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEC002.ant.amazon.com (10.252.135.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:15 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Tue, 30 Jan 2024 09:54:13
 +0000
From: <darinzon@amazon.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
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
	<nkoler@amazon.com>
Subject: [PATCH v2 net-next 05/11] net: ena: Remove CQ tail pointer update
Date: Tue, 30 Jan 2024 09:53:47 +0000
Message-ID: <20240130095353.2881-6-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240130095353.2881-1-darinzon@amazon.com>
References: <20240130095353.2881-1-darinzon@amazon.com>
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
 drivers/net/ethernet/amazon/ena/ena_com.h     |  6 +----
 drivers/net/ethernet/amazon/ena/ena_eth_com.h | 24 -------------------
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  5 +---
 drivers/net/ethernet/amazon/ena/ena_xdp.c     |  1 -
 5 files changed, 2 insertions(+), 39 deletions(-)

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
index f3176fc..fea57eb 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -109,16 +109,13 @@ struct ena_com_io_cq {
 	/* Interrupt unmask register */
 	u32 __iomem *unmask_reg;
 
-	/* The completion queue head doorbell register */
-	u32 __iomem *cq_head_db_reg;
-
 	/* numa configuration register (for TPH) */
 	u32 __iomem *numa_node_cfg_reg;
 
 	/* The value to write to the above register to unmask
 	 * the interrupt of this queue
 	 */
-	u32 msix_vector;
+	u32 msix_vector ____cacheline_aligned;
 
 	enum queue_direction direction;
 
@@ -134,7 +131,6 @@ struct ena_com_io_cq {
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


