Return-Path: <netdev+bounces-157147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EF2A09065
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359A216B9C6
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5140820E00D;
	Fri, 10 Jan 2025 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XtHa4/5n"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D51020D4E0;
	Fri, 10 Jan 2025 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512074; cv=none; b=opWKgVGkctzscwH+5PX0cPuJOS+r64i8y8SZ9iKJy7iht3kV+IVQ4rCWisOmXB6fI2bkI+yddBDIR6l1dYDQhvfEBPR7IiUYn/qyoK7qw70NkC8GhCZ2R5SkKGReAlRlswaaR+oNT1NzNJbTyceZE04/rl8YIo3UGXp6oweDvyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512074; c=relaxed/simple;
	bh=HyN1YIgx7AYgJmZSsGhspgM7XeDhEP2f8yZM08QnT1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1o3q+B7VVcQG/PLmzh4RUnm1fak5STGHuV0AY140Srla+XgEhqROyQzBGQym02ii5a8aZ2uaYKmkqm9s4B0nYWGgJUflkvLw+6nWJto5jvck+vXIv2A7FEvJWO+POrQx4IO7+jKsxXxpRwbtjtMBfG/XowlsNNG6DIjaN1u7wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XtHa4/5n; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A9MEqt004384;
	Fri, 10 Jan 2025 04:27:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
	jB/6HAtXWXgVXdhuFVKzX0BIz0yqrpzDTV+yZaTVKI=; b=XtHa4/5nmpDHSs8tl
	g6w26DAJEPoqKpo5YjlmsklOAkhe1CrL/KAAAaoEcgQZVYU3C/oNiWGIbmF+W2Y4
	Nc15CrZp4YaOhgkg55vKiSD4+4Mnya/r4FB66mMUTIJB2F9hGakYEuaupq3GGAnO
	VTU/9buZ5mL6Ltt537pjwFqrtL5SZ0gdUuYJrOhCKHtmenXNLG97zrwlEktGswb/
	OxXFhtjHeyEv8ODzMEDsKORJqg9oXqug2zV4HSNJfIu0jkaBTN9fyAHYjkAkpkRJ
	2ONV5P35/WB2N+pEhtL1vwlp609cHLl+QEcQaVdPZCZssLeqRXwxrAekbRHx6VNR
	IZrAw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4430umr9rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:27:36 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 04:27:36 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 04:27:36 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 87DAB3F705A;
	Fri, 10 Jan 2025 04:27:35 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>
Subject: [PATCH net v6 1/4] octeon_ep: update tx/rx stats locally for persistence
Date: Fri, 10 Jan 2025 04:27:27 -0800
Message-ID: <20250110122730.2551863-2-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110122730.2551863-1-srasheed@marvell.com>
References: <20250110122730.2551863-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Hz-iMbWgiDmf4t7_bnYr350SDDngxf5o
X-Proofpoint-ORIG-GUID: Hz-iMbWgiDmf4t7_bnYr350SDDngxf5o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Update tx/rx stats locally, so that ndo_get_stats64()
can use that and not rely on per queue resources to obtain statistics.
The latter used to cause race conditions when the device stopped.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V6:
  - No changes

V5: https://lore.kernel.org/all/20250109103221.2544467-2-srasheed@marvell.com/
  - Patch introduced

 .../marvell/octeon_ep/octep_ethtool.c         | 41 ++++++++-----------
 .../ethernet/marvell/octeon_ep/octep_main.c   | 37 ++++++++---------
 .../ethernet/marvell/octeon_ep/octep_main.h   | 11 +++++
 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 12 +++---
 .../net/ethernet/marvell/octeon_ep/octep_rx.h |  4 +-
 .../net/ethernet/marvell/octeon_ep/octep_tx.c |  7 ++--
 .../net/ethernet/marvell/octeon_ep/octep_tx.h |  4 +-
 7 files changed, 60 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
index 4f4d58189118..79d66426c1da 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
@@ -150,17 +150,14 @@ octep_get_ethtool_stats(struct net_device *netdev,
 				    iface_rx_stats,
 				    iface_tx_stats);
 
-	for (q = 0; q < oct->num_oqs; q++) {
-		struct octep_iq *iq = oct->iq[q];
-		struct octep_oq *oq = oct->oq[q];
-
-		tx_packets += iq->stats.instr_completed;
-		tx_bytes += iq->stats.bytes_sent;
-		tx_busy_errors += iq->stats.tx_busy;
-
-		rx_packets += oq->stats.packets;
-		rx_bytes += oq->stats.bytes;
-		rx_alloc_errors += oq->stats.alloc_failures;
+	for (q = 0; q < oct->num_ioq_stats; q++) {
+		tx_packets += oct->stats_iq[q].instr_completed;
+		tx_bytes += oct->stats_iq[q].bytes_sent;
+		tx_busy_errors += oct->stats_iq[q].tx_busy;
+
+		rx_packets += oct->stats_oq[q].packets;
+		rx_bytes += oct->stats_oq[q].bytes;
+		rx_alloc_errors += oct->stats_oq[q].alloc_failures;
 	}
 	i = 0;
 	data[i++] = rx_packets;
@@ -198,22 +195,18 @@ octep_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = iface_rx_stats->err_pkts;
 
 	/* Per Tx Queue stats */
-	for (q = 0; q < oct->num_iqs; q++) {
-		struct octep_iq *iq = oct->iq[q];
-
-		data[i++] = iq->stats.instr_posted;
-		data[i++] = iq->stats.instr_completed;
-		data[i++] = iq->stats.bytes_sent;
-		data[i++] = iq->stats.tx_busy;
+	for (q = 0; q < oct->num_ioq_stats; q++) {
+		data[i++] = oct->stats_iq[q].instr_posted;
+		data[i++] = oct->stats_iq[q].instr_completed;
+		data[i++] = oct->stats_iq[q].bytes_sent;
+		data[i++] = oct->stats_iq[q].tx_busy;
 	}
 
 	/* Per Rx Queue stats */
-	for (q = 0; q < oct->num_oqs; q++) {
-		struct octep_oq *oq = oct->oq[q];
-
-		data[i++] = oq->stats.packets;
-		data[i++] = oq->stats.bytes;
-		data[i++] = oq->stats.alloc_failures;
+	for (q = 0; q < oct->num_ioq_stats; q++) {
+		data[i++] = oct->stats_oq[q].packets;
+		data[i++] = oct->stats_oq[q].bytes;
+		data[i++] = oct->stats_oq[q].alloc_failures;
 	}
 }
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 549436efc204..c5fdedd3ea78 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -822,7 +822,7 @@ static inline int octep_iq_full_check(struct octep_iq *iq)
 	if (unlikely(IQ_INSTR_SPACE(iq) >
 		     OCTEP_WAKE_QUEUE_THRESHOLD)) {
 		netif_start_subqueue(iq->netdev, iq->q_no);
-		iq->stats.restart_cnt++;
+		iq->stats->restart_cnt++;
 		return 0;
 	}
 
@@ -960,7 +960,7 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 	wmb();
 	/* Ring Doorbell to notify the NIC of new packets */
 	writel(iq->fill_cnt, iq->doorbell_reg);
-	iq->stats.instr_posted += iq->fill_cnt;
+	iq->stats->instr_posted += iq->fill_cnt;
 	iq->fill_cnt = 0;
 	return NETDEV_TX_OK;
 
@@ -991,33 +991,30 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 static void octep_get_stats64(struct net_device *netdev,
 			      struct rtnl_link_stats64 *stats)
 {
-	u64 tx_packets, tx_bytes, rx_packets, rx_bytes;
 	struct octep_device *oct = netdev_priv(netdev);
 	int q;
 
+	oct->iface_tx_stats.pkts = 0;
+	oct->iface_tx_stats.octs = 0;
+	oct->iface_rx_stats.pkts = 0;
+	oct->iface_rx_stats.octets = 0;
+	for (q = 0; q < oct->num_ioq_stats; q++) {
+		oct->iface_tx_stats.pkts += oct->stats_iq[q].instr_completed;
+		oct->iface_tx_stats.octs += oct->stats_iq[q].bytes_sent;
+		oct->iface_rx_stats.pkts += oct->stats_oq[q].packets;
+		oct->iface_rx_stats.octets += oct->stats_oq[q].bytes;
+	}
+
 	if (netif_running(netdev))
 		octep_ctrl_net_get_if_stats(oct,
 					    OCTEP_CTRL_NET_INVALID_VFID,
 					    &oct->iface_rx_stats,
 					    &oct->iface_tx_stats);
 
-	tx_packets = 0;
-	tx_bytes = 0;
-	rx_packets = 0;
-	rx_bytes = 0;
-	for (q = 0; q < oct->num_oqs; q++) {
-		struct octep_iq *iq = oct->iq[q];
-		struct octep_oq *oq = oct->oq[q];
-
-		tx_packets += iq->stats.instr_completed;
-		tx_bytes += iq->stats.bytes_sent;
-		rx_packets += oq->stats.packets;
-		rx_bytes += oq->stats.bytes;
-	}
-	stats->tx_packets = tx_packets;
-	stats->tx_bytes = tx_bytes;
-	stats->rx_packets = rx_packets;
-	stats->rx_bytes = rx_bytes;
+	stats->tx_packets = oct->iface_tx_stats.pkts;
+	stats->tx_bytes = oct->iface_tx_stats.octs;
+	stats->rx_packets = oct->iface_rx_stats.pkts;
+	stats->rx_bytes = oct->iface_rx_stats.octets;
 	stats->multicast = oct->iface_rx_stats.mcast_pkts;
 	stats->rx_errors = oct->iface_rx_stats.err_pkts;
 	stats->collisions = oct->iface_tx_stats.xscol;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index fee59e0e0138..231ff863310b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -257,11 +257,22 @@ struct octep_device {
 	/* Pointers to Octeon Tx queues */
 	struct octep_iq *iq[OCTEP_MAX_IQ];
 
+	/* Per iq stats */
+	struct octep_iq_stats stats_iq[OCTEP_MAX_IQ];
+
 	/* Rx queues (OQ: Output Queue) */
 	u16 num_oqs;
 	/* Pointers to Octeon Rx queues */
 	struct octep_oq *oq[OCTEP_MAX_OQ];
 
+	/* Number oq stats preserved
+	 * This number would remain constant when device goes down
+	 * This will be updated when device comes back up
+	 */
+	u16 num_ioq_stats;
+	/* Per oq stats */
+	struct octep_oq_stats stats_oq[OCTEP_MAX_OQ];
+
 	/* Hardware port number of the PCIe interface */
 	u16 pcie_port;
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index 8af75cb37c3e..a7337f391a21 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -87,7 +87,7 @@ static int octep_oq_refill(struct octep_device *oct, struct octep_oq *oq)
 		page = dev_alloc_page();
 		if (unlikely(!page)) {
 			dev_err(oq->dev, "refill: rx buffer alloc failed\n");
-			oq->stats.alloc_failures++;
+			oq->stats->alloc_failures++;
 			break;
 		}
 
@@ -98,7 +98,7 @@ static int octep_oq_refill(struct octep_device *oct, struct octep_oq *oq)
 				"OQ-%d buffer refill: DMA mapping error!\n",
 				oq->q_no);
 			put_page(page);
-			oq->stats.alloc_failures++;
+			oq->stats->alloc_failures++;
 			break;
 		}
 		oq->buff_info[refill_idx].page = page;
@@ -134,6 +134,7 @@ static int octep_setup_oq(struct octep_device *oct, int q_no)
 	oq->netdev = oct->netdev;
 	oq->dev = &oct->pdev->dev;
 	oq->q_no = q_no;
+	oq->stats = &oct->stats_oq[q_no];
 	oq->max_count = CFG_GET_OQ_NUM_DESC(oct->conf);
 	oq->ring_size_mask = oq->max_count - 1;
 	oq->buffer_size = CFG_GET_OQ_BUF_SIZE(oct->conf);
@@ -262,6 +263,7 @@ int octep_setup_oqs(struct octep_device *oct)
 		dev_dbg(&oct->pdev->dev, "Successfully setup OQ(RxQ)-%d.\n", i);
 	}
 
+	oct->num_ioq_stats = oct->num_oqs;
 	return 0;
 
 oq_setup_err:
@@ -443,7 +445,7 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 		if (!skb) {
 			octep_oq_drop_rx(oq, buff_info,
 					 &read_idx, &desc_used);
-			oq->stats.alloc_failures++;
+			oq->stats->alloc_failures++;
 			continue;
 		}
 		skb_reserve(skb, data_offset);
@@ -494,8 +496,8 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 
 	oq->host_read_idx = read_idx;
 	oq->refill_count += desc_used;
-	oq->stats.packets += pkt;
-	oq->stats.bytes += rx_bytes;
+	oq->stats->packets += pkt;
+	oq->stats->bytes += rx_bytes;
 
 	return pkt;
 }
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
index 3b08e2d560dc..b4696c93d0e6 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
@@ -186,8 +186,8 @@ struct octep_oq {
 	 */
 	u8 __iomem *pkts_sent_reg;
 
-	/* Statistics for this OQ. */
-	struct octep_oq_stats stats;
+	/* Pointer to statistics for this OQ. */
+	struct octep_oq_stats *stats;
 
 	/* Packets pending to be processed */
 	u32 pkts_pending;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
index 06851b78aa28..08ee90013fef 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
@@ -81,9 +81,9 @@ int octep_iq_process_completions(struct octep_iq *iq, u16 budget)
 	}
 
 	iq->pkts_processed += compl_pkts;
-	iq->stats.instr_completed += compl_pkts;
-	iq->stats.bytes_sent += compl_bytes;
-	iq->stats.sgentry_sent += compl_sg;
+	iq->stats->instr_completed += compl_pkts;
+	iq->stats->bytes_sent += compl_bytes;
+	iq->stats->sgentry_sent += compl_sg;
 	iq->flush_index = fi;
 
 	netdev_tx_completed_queue(iq->netdev_q, compl_pkts, compl_bytes);
@@ -187,6 +187,7 @@ static int octep_setup_iq(struct octep_device *oct, int q_no)
 	iq->netdev = oct->netdev;
 	iq->dev = &oct->pdev->dev;
 	iq->q_no = q_no;
+	iq->stats = &oct->stats_iq[q_no];
 	iq->max_count = CFG_GET_IQ_NUM_DESC(oct->conf);
 	iq->ring_size_mask = iq->max_count - 1;
 	iq->fill_threshold = CFG_GET_IQ_DB_MIN(oct->conf);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
index 875a2c34091f..58fb39dda977 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
@@ -170,8 +170,8 @@ struct octep_iq {
 	 */
 	u16 flush_index;
 
-	/* Statistics for this input queue. */
-	struct octep_iq_stats stats;
+	/* Pointer to statistics for this input queue. */
+	struct octep_iq_stats *stats;
 
 	/* Pointer to the Virtual Base addr of the input ring. */
 	struct octep_tx_desc_hw *desc_ring;
-- 
2.25.1


