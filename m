Return-Path: <netdev+bounces-157149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE21A0906B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5D33A2A76
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79707211468;
	Fri, 10 Jan 2025 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="D2rlX5lW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C42F211283;
	Fri, 10 Jan 2025 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512077; cv=none; b=GgAhm4t8ybaQ4m2jd0nC20TlTCrIPUiF4F7FobOcT53xE7u4gY5P5gmaGq4qmADxIFV85BHo2L2Qp6J1nJDMNButimPcWM9JPSf23lKuOXY6Mt1JPSYXOE3Er1GmKAsAQpW1CyUAfvacfc09G0+XvLiseeDB7Ymk/SBl5Bk3NLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512077; c=relaxed/simple;
	bh=dVhRorKlXF61pjLvjqDjW/T+EwXuQuLalmNMBYCxldo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cc3y8Nq1piBcSvp7AmKCPn9tnJ+xHt84ob1aukad26IjBxrfUi/j7J0ZZoAp2b9aywL/5Uo3+dpBf/StiVH2Rfgq2ahYZg2hvjvw0v7+KYdgSVfHhr9PP1pGYuQDwicYwQB58BD31KFiN02qyzod4A/a1kQdzinB2Yj87o/VGus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=D2rlX5lW; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A9b0K0004128;
	Fri, 10 Jan 2025 04:27:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
	lejQb1e1CEL1mY6h6l7R3BSE6RDEh/Ry3BPnYRuAts=; b=D2rlX5lWCj5coj84I
	bXKx73Qpbc64i1TrECSx8m44hwGGUyg7BJ5D3uHRHn4Wv3Q6Puru/UXC9I8lWV5v
	V1tFAW7ya1s03wOAqDzaPBzQDTr5EfryLw/5BUEM9+nIN4RVj8w7kI+CK/r/c/mM
	hKiGZyqah+87s1LY86mXj+uddm/YX7UGd5hHkKEWSTzcTgmU3n659PUWo4YKCZ1t
	ZdTv9JdPN0zq3yP3GxxxittUtmi8Bo1g14a7DOn/sTRrsIU51Q+iFn8yJ4RH3zjs
	LmNL84qGyo5iOf+YEnOc//d/lbh9N0pEzmpr7jMj3ZpuHVBCy/P5XfmES8FcUv1M
	2JOSQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44312qg8d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:27:41 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 04:27:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 04:27:41 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 94E083F705A;
	Fri, 10 Jan 2025 04:27:40 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla <sburla@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v6 3/4] octeon_ep_vf: update tx/rx stats locally for persistence
Date: Fri, 10 Jan 2025 04:27:29 -0800
Message-ID: <20250110122730.2551863-4-srasheed@marvell.com>
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
X-Proofpoint-ORIG-GUID: 5_97_2XR61IaA0OqpN4qzAs0a0BBiECK
X-Proofpoint-GUID: 5_97_2XR61IaA0OqpN4qzAs0a0BBiECK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Update tx/rx stats locally, so that ndo_get_stats64()
can use that and not rely on per queue resources to obtain statistics.
The latter used to cause race conditions when the device stopped.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V6:
  - No changes

V5: https://lore.kernel.org/all/20250109103221.2544467-4-srasheed@marvell.com/
  - Patch introduced

 .../marvell/octeon_ep_vf/octep_vf_ethtool.c   | 29 ++++++----------
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 34 ++++++++-----------
 .../marvell/octeon_ep_vf/octep_vf_main.h      | 11 ++++++
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 10 +++---
 .../marvell/octeon_ep_vf/octep_vf_rx.h        |  2 +-
 .../marvell/octeon_ep_vf/octep_vf_tx.c        |  7 ++--
 .../marvell/octeon_ep_vf/octep_vf_tx.h        |  2 +-
 7 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
index 7b21439a315f..9966a2ee3de8 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
@@ -114,12 +114,9 @@ static void octep_vf_get_ethtool_stats(struct net_device *netdev,
 	iface_tx_stats = &oct->iface_tx_stats;
 	iface_rx_stats = &oct->iface_rx_stats;
 
-	for (q = 0; q < oct->num_oqs; q++) {
-		struct octep_vf_iq *iq = oct->iq[q];
-		struct octep_vf_oq *oq = oct->oq[q];
-
-		tx_busy_errors += iq->stats.tx_busy;
-		rx_alloc_errors += oq->stats.alloc_failures;
+	for (q = 0; q < oct->num_ioq_stats; q++) {
+		tx_busy_errors += oct->stats_iq[q].tx_busy;
+		rx_alloc_errors += oct->stats_oq[q].alloc_failures;
 	}
 	i = 0;
 	data[i++] = rx_alloc_errors;
@@ -134,22 +131,18 @@ static void octep_vf_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = iface_rx_stats->dropped_octets_fifo_full;
 
 	/* Per Tx Queue stats */
-	for (q = 0; q < oct->num_iqs; q++) {
-		struct octep_vf_iq *iq = oct->iq[q];
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
 	for (q = 0; q < oct->num_oqs; q++) {
-		struct octep_vf_oq *oq = oct->oq[q];
-
-		data[i++] = oq->stats.packets;
-		data[i++] = oq->stats.bytes;
-		data[i++] = oq->stats.alloc_failures;
+		data[i++] = oct->stats_oq[q].packets;
+		data[i++] = oct->stats_oq[q].bytes;
+		data[i++] = oct->stats_oq[q].alloc_failures;
 	}
 }
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 7e6771c9cdbb..d58b3033364e 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -574,7 +574,7 @@ static int octep_vf_iq_full_check(struct octep_vf_iq *iq)
 		  * caused queues to get re-enabled after
 		  * being stopped
 		  */
-		iq->stats.restart_cnt++;
+		iq->stats->restart_cnt++;
 		fallthrough;
 	case 1: /* Queue left enabled, since IQ is not yet full*/
 		return 0;
@@ -731,7 +731,7 @@ static netdev_tx_t octep_vf_start_xmit(struct sk_buff *skb,
 	/* Flush the hw descriptors before writing to doorbell */
 	smp_wmb();
 	writel(iq->fill_cnt, iq->doorbell_reg);
-	iq->stats.instr_posted += iq->fill_cnt;
+	iq->stats->instr_posted += iq->fill_cnt;
 	iq->fill_cnt = 0;
 	return NETDEV_TX_OK;
 }
@@ -779,26 +779,22 @@ static void octep_vf_get_stats64(struct net_device *netdev,
 				 struct rtnl_link_stats64 *stats)
 {
 	struct octep_vf_device *oct = netdev_priv(netdev);
-	u64 tx_packets, tx_bytes, rx_packets, rx_bytes;
 	int q;
 
-	tx_packets = 0;
-	tx_bytes = 0;
-	rx_packets = 0;
-	rx_bytes = 0;
-	for (q = 0; q < oct->num_oqs; q++) {
-		struct octep_vf_iq *iq = oct->iq[q];
-		struct octep_vf_oq *oq = oct->oq[q];
-
-		tx_packets += iq->stats.instr_completed;
-		tx_bytes += iq->stats.bytes_sent;
-		rx_packets += oq->stats.packets;
-		rx_bytes += oq->stats.bytes;
+	oct->iface_tx_stats.pkts = 0;
+	oct->iface_tx_stats.octs = 0;
+	oct->iface_rx_stats.pkts = 0;
+	oct->iface_rx_stats.octets = 0;
+	for (q = 0; q < oct->num_ioq_stats; q++) {
+		oct->iface_tx_stats.pkts += oct->stats_iq[q].instr_completed;
+		oct->iface_tx_stats.octs += oct->stats_iq[q].bytes_sent;
+		oct->iface_rx_stats.pkts += oct->stats_oq[q].packets;
+		oct->iface_rx_stats.octets += oct->stats_oq[q].bytes;
 	}
-	stats->tx_packets = tx_packets;
-	stats->tx_bytes = tx_bytes;
-	stats->rx_packets = rx_packets;
-	stats->rx_bytes = rx_bytes;
+	stats->tx_packets = oct->iface_tx_stats.pkts;
+	stats->tx_bytes = oct->iface_tx_stats.octs;
+	stats->rx_packets = oct->iface_rx_stats.pkts;
+	stats->rx_bytes = oct->iface_rx_stats.octets;
 	if (!octep_vf_get_if_stats(oct)) {
 		stats->multicast = oct->iface_rx_stats.mcast_pkts;
 		stats->rx_errors = oct->iface_rx_stats.err_pkts;
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
index 5769f62545cd..91cfaa105d06 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
@@ -246,11 +246,22 @@ struct octep_vf_device {
 	/* Pointers to Octeon Tx queues */
 	struct octep_vf_iq *iq[OCTEP_VF_MAX_IQ];
 
+	/* Per iq stats */
+	struct octep_vf_iq_stats stats_iq[OCTEP_VF_MAX_IQ];
+
 	/* Rx queues (OQ: Output Queue) */
 	u16 num_oqs;
 	/* Pointers to Octeon Rx queues */
 	struct octep_vf_oq *oq[OCTEP_VF_MAX_OQ];
 
+	/* Number oq stats preserved
+	 * This number would remain constant when device goes down
+	 * This will be updated when device comes back up
+	 */
+	u16 num_ioq_stats;
+	/* Per oq stats */
+	struct octep_vf_oq_stats stats_oq[OCTEP_VF_MAX_OQ];
+
 	/* Hardware port number of the PCIe interface */
 	u16 pcie_port;
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index 82821bc28634..72399f388973 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -87,7 +87,7 @@ static int octep_vf_oq_refill(struct octep_vf_device *oct, struct octep_vf_oq *o
 		page = dev_alloc_page();
 		if (unlikely(!page)) {
 			dev_err(oq->dev, "refill: rx buffer alloc failed\n");
-			oq->stats.alloc_failures++;
+			oq->stats->alloc_failures++;
 			break;
 		}
 
@@ -98,7 +98,7 @@ static int octep_vf_oq_refill(struct octep_vf_device *oct, struct octep_vf_oq *o
 				"OQ-%d buffer refill: DMA mapping error!\n",
 				oq->q_no);
 			put_page(page);
-			oq->stats.alloc_failures++;
+			oq->stats->alloc_failures++;
 			break;
 		}
 		oq->buff_info[refill_idx].page = page;
@@ -134,6 +134,7 @@ static int octep_vf_setup_oq(struct octep_vf_device *oct, int q_no)
 	oq->netdev = oct->netdev;
 	oq->dev = &oct->pdev->dev;
 	oq->q_no = q_no;
+	oq->stats = &oct->stats_oq[q_no];
 	oq->max_count = CFG_GET_OQ_NUM_DESC(oct->conf);
 	oq->ring_size_mask = oq->max_count - 1;
 	oq->buffer_size = CFG_GET_OQ_BUF_SIZE(oct->conf);
@@ -263,6 +264,7 @@ int octep_vf_setup_oqs(struct octep_vf_device *oct)
 		dev_dbg(&oct->pdev->dev, "Successfully setup OQ(RxQ)-%d.\n", i);
 	}
 
+	oct->num_ioq_stats = oct->num_oqs;
 	return 0;
 
 oq_setup_err:
@@ -458,8 +460,8 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 
 	oq->host_read_idx = read_idx;
 	oq->refill_count += desc_used;
-	oq->stats.packets += pkt;
-	oq->stats.bytes += rx_bytes;
+	oq->stats->packets += pkt;
+	oq->stats->bytes += rx_bytes;
 
 	return pkt;
 }
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.h b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.h
index fe46838b5200..9e296b7d7e34 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.h
@@ -187,7 +187,7 @@ struct octep_vf_oq {
 	u8 __iomem *pkts_sent_reg;
 
 	/* Statistics for this OQ. */
-	struct octep_vf_oq_stats stats;
+	struct octep_vf_oq_stats *stats;
 
 	/* Packets pending to be processed */
 	u32 pkts_pending;
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.c
index 47a5c054fdb6..8180e5ce3d7e 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.c
@@ -82,9 +82,9 @@ int octep_vf_iq_process_completions(struct octep_vf_iq *iq, u16 budget)
 	}
 
 	iq->pkts_processed += compl_pkts;
-	iq->stats.instr_completed += compl_pkts;
-	iq->stats.bytes_sent += compl_bytes;
-	iq->stats.sgentry_sent += compl_sg;
+	iq->stats->instr_completed += compl_pkts;
+	iq->stats->bytes_sent += compl_bytes;
+	iq->stats->sgentry_sent += compl_sg;
 	iq->flush_index = fi;
 
 	netif_subqueue_completed_wake(iq->netdev, iq->q_no, compl_pkts,
@@ -186,6 +186,7 @@ static int octep_vf_setup_iq(struct octep_vf_device *oct, int q_no)
 	iq->netdev = oct->netdev;
 	iq->dev = &oct->pdev->dev;
 	iq->q_no = q_no;
+	iq->stats = &oct->stats_iq[q_no];
 	iq->max_count = CFG_GET_IQ_NUM_DESC(oct->conf);
 	iq->ring_size_mask = iq->max_count - 1;
 	iq->fill_threshold = CFG_GET_IQ_DB_MIN(oct->conf);
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.h b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.h
index f338b975103c..1cede90e3a5f 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.h
@@ -129,7 +129,7 @@ struct octep_vf_iq {
 	u16 flush_index;
 
 	/* Statistics for this input queue. */
-	struct octep_vf_iq_stats stats;
+	struct octep_vf_iq_stats *stats;
 
 	/* Pointer to the Virtual Base addr of the input ring. */
 	struct octep_vf_tx_desc_hw *desc_ring;
-- 
2.25.1


