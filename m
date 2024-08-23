Return-Path: <netdev+bounces-121552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3442795D9F7
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 01:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71FCCB2259D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 23:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535FF1C9458;
	Fri, 23 Aug 2024 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="huKtI+oy"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B891C9446
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457344; cv=none; b=QjXdSFBdmcaQP12HQM+9ijaCbnNLBzKzAsaVk5UCLouqP5ETrQxFanw8qWXR8XhEc2XyENQsYGnX4aCKjuQsS6HwJHg/ngUCL1p6TOaL9jxgAjm76MS8mhVPK30CA1Y8wRCDi7nEilDK3h8MXXIndpuT69Ef34ncFuxb6Tuqm0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457344; c=relaxed/simple;
	bh=rEb1S2PZi4zWfuDbIn4FNlTxwvcCuNeZZ74jXpgX0bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NkfvPOouDJjHRN48U49Ds6x3FPQNgH8cyU0Z4UZA/Hs6pXnmnizxkN/lBcHIwx3K9eatENc7HYKJVJbLn0rFBrbA4YAgC2zBt5Y0uW6/HRZ1tlIVIDpy3lXF76AqptQDOPNXtPQK+DvtCpxgBDFvQkJhYHIikFZHMM6VWuKhrfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=huKtI+oy; arc=none smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=17481; q=dns/txt;
  s=iport; t=1724457342; x=1725666942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V38iZhgcXWPOomz+QA1mKaXl0Ls5FOR8NR6GMwgwmaM=;
  b=huKtI+oy6IVR0Tn+eQoy93puIxqTJvF+kFWS6fKBlT/XpijUKkC8hDTb
   GX0xfEtQ8N4cPzM8ibUEnpOzQwMVr5KNDV85hHu0jwaipasm+SywMj9t1
   h0Nkg4sm4LBs0TLGTaFXuK2EIClT+USWWKql28w3ufumRh2YLs1XzYZx1
   M=;
X-CSE-ConnectionGUID: Gr4jqpP+SHaSkU1aVXXPkA==
X-CSE-MsgGUID: lASB8CslSFOfi1y7i/cERQ==
X-IronPort-AV: E=Sophos;i="6.10,171,1719878400"; 
   d="scan'208";a="249609145"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 23:54:34 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTP id 47NNsYrn027214;
	Fri, 23 Aug 2024 23:54:34 GMT
Received: by cisco.com (Postfix, from userid 412739)
	id 4080420F2003; Fri, 23 Aug 2024 16:54:34 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com, johndale@cisco.com,
        Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next 2/2] enic: Expand statistics gathering and reporting
Date: Fri, 23 Aug 2024 16:54:01 -0700
Message-Id: <20240823235401.29996-3-neescoba@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20240823235401.29996-1-neescoba@cisco.com>
References: <20240823235401.29996-1-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-core-6.cisco.com

Collect and report per rq/wq statistics in ethtool.

Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h        | 38 +++++++-
 .../net/ethernet/cisco/enic/enic_ethtool.c    | 95 ++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_main.c   | 89 +++++++++++++----
 3 files changed, 200 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 300ad05ee05b..774ba7415dc4 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -128,6 +128,40 @@ struct vxlan_offload {
 	u8 flags;
 };
 
+struct enic_wq_stats {
+	u64 packets;		/* pkts queued for Tx */
+	u64 stopped;		/* Tx ring almost full, queue stopped */
+	u64 wake;		/* Tx ring no longer full, queue woken up*/
+	u64 tso;		/* non-encap tso pkt */
+	u64 encap_tso;		/* encap vxlan tso pkt */
+	u64 encap_csum;		/* encap vxlan WQ_ENET_OFFLOAD_MODE_CSUM */
+	u64 csum_partial;	/* skb->ip_summed = CHECKSUM_PARTIAL */
+	u64 csum;		/* WQ_ENET_OFFLOAD_MODE_CSUM */
+	u64 bytes;		/* bytes queued for Tx */
+	u64 add_vlan;		/* HW adds vlan tag */
+	u64 cq_work;		/* Tx completions processed */
+	u64 cq_bytes;		/* Tx bytes processed */
+	u64 null_pkt;		/* skb length <= 0 */
+	u64 skb_linear_fail;	/* linearize failures */
+	u64 desc_full_awake;	/* TX ring full while queue awake */
+};
+
+struct enic_rq_stats {
+	u64 packets;			/* pkts received */
+	u64 bytes;			/* bytes received */
+	u64 l4_rss_hash;		/* hashed on l4 */
+	u64 l3_rss_hash;		/* hashed on l3 */
+	u64 csum_unnecessary;		/* HW verified csum */
+	u64 csum_unnecessary_encap;	/* HW verified csum on encap packet */
+	u64 vlan_stripped;		/* HW stripped vlan */
+	u64 napi_complete;		/* napi complete intr reenabled */
+	u64 napi_repoll;		/* napi poll again */
+	u64 bad_fcs;			/* bad pkts */
+	u64 pkt_truncated;		/* truncated pkts */
+	u64 no_skb;			/* out of skbs */
+	u64 desc_skip;			/* Rx pkt went into later buffer */
+};
+
 /* Per-instance private data structure */
 struct enic {
 	struct net_device *netdev;
@@ -162,16 +196,16 @@ struct enic {
 	/* work queue cache line section */
 	____cacheline_aligned struct vnic_wq wq[ENIC_WQ_MAX];
 	spinlock_t wq_lock[ENIC_WQ_MAX];
+	struct enic_wq_stats wq_stats[ENIC_WQ_MAX];
 	unsigned int wq_count;
 	u16 loop_enable;
 	u16 loop_tag;
 
 	/* receive queue cache line section */
 	____cacheline_aligned struct vnic_rq rq[ENIC_RQ_MAX];
+	struct enic_rq_stats rq_stats[ENIC_RQ_MAX];
 	unsigned int rq_count;
 	struct vxlan_offload vxlan;
-	u64 rq_truncated_pkts;
-	u64 rq_bad_fcs;
 	struct napi_struct napi[ENIC_RQ_MAX + ENIC_WQ_MAX];
 
 	/* interrupt resource cache line section */
diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index b71146209334..50ab04845547 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -32,6 +32,53 @@ struct enic_stat {
 	.index = offsetof(struct vnic_gen_stats, stat) / sizeof(u64)\
 }
 
+#define ENIC_PER_RQ_STAT(stat) { \
+	.name = "rq[%d]_"#stat, \
+	.index = offsetof(struct enic_rq_stats, stat) / sizeof(u64) \
+}
+
+#define ENIC_PER_WQ_STAT(stat) { \
+	.name = "wq[%d]_"#stat, \
+	.index = offsetof(struct enic_wq_stats, stat) / sizeof(u64) \
+}
+
+static const struct enic_stat enic_per_rq_stats[] = {
+	ENIC_PER_RQ_STAT(packets),
+	ENIC_PER_RQ_STAT(bytes),
+	ENIC_PER_RQ_STAT(l4_rss_hash),
+	ENIC_PER_RQ_STAT(l3_rss_hash),
+	ENIC_PER_RQ_STAT(csum_unnecessary),
+	ENIC_PER_RQ_STAT(csum_unnecessary_encap),
+	ENIC_PER_RQ_STAT(vlan_stripped),
+	ENIC_PER_RQ_STAT(napi_complete),
+	ENIC_PER_RQ_STAT(napi_repoll),
+	ENIC_PER_RQ_STAT(bad_fcs),
+	ENIC_PER_RQ_STAT(pkt_truncated),
+	ENIC_PER_RQ_STAT(no_skb),
+	ENIC_PER_RQ_STAT(desc_skip),
+};
+
+#define NUM_ENIC_PER_RQ_STATS   ARRAY_SIZE(enic_per_rq_stats)
+
+static const struct enic_stat enic_per_wq_stats[] = {
+	ENIC_PER_WQ_STAT(packets),
+	ENIC_PER_WQ_STAT(stopped),
+	ENIC_PER_WQ_STAT(wake),
+	ENIC_PER_WQ_STAT(tso),
+	ENIC_PER_WQ_STAT(encap_tso),
+	ENIC_PER_WQ_STAT(encap_csum),
+	ENIC_PER_WQ_STAT(csum_partial),
+	ENIC_PER_WQ_STAT(csum),
+	ENIC_PER_WQ_STAT(bytes),
+	ENIC_PER_WQ_STAT(add_vlan),
+	ENIC_PER_WQ_STAT(cq_work),
+	ENIC_PER_WQ_STAT(cq_bytes),
+	ENIC_PER_WQ_STAT(null_pkt),
+	ENIC_PER_WQ_STAT(skb_linear_fail),
+	ENIC_PER_WQ_STAT(desc_full_awake),
+};
+
+#define NUM_ENIC_PER_WQ_STATS   ARRAY_SIZE(enic_per_wq_stats)
 static const struct enic_stat enic_tx_stats[] = {
 	ENIC_TX_STAT(tx_frames_ok),
 	ENIC_TX_STAT(tx_unicast_frames_ok),
@@ -143,7 +190,9 @@ static void enic_get_drvinfo(struct net_device *netdev,
 static void enic_get_strings(struct net_device *netdev, u32 stringset,
 	u8 *data)
 {
+	struct enic *enic = netdev_priv(netdev);
 	unsigned int i;
+	unsigned int j;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
@@ -159,6 +208,20 @@ static void enic_get_strings(struct net_device *netdev, u32 stringset,
 			memcpy(data, enic_gen_stats[i].name, ETH_GSTRING_LEN);
 			data += ETH_GSTRING_LEN;
 		}
+		for (i = 0; i < enic->rq_count; i++) {
+			for (j = 0; j < NUM_ENIC_PER_RQ_STATS; j++) {
+				snprintf(data, ETH_GSTRING_LEN,
+					 enic_per_rq_stats[j].name, i);
+				data += ETH_GSTRING_LEN;
+			}
+		}
+		for (i = 0; i < enic->wq_count; i++) {
+			for (j = 0; j < NUM_ENIC_PER_WQ_STATS; j++) {
+				snprintf(data, ETH_GSTRING_LEN,
+					 enic_per_wq_stats[j].name, i);
+				data += ETH_GSTRING_LEN;
+			}
+		}
 		break;
 	}
 }
@@ -244,10 +307,19 @@ static int enic_set_ringparam(struct net_device *netdev,
 
 static int enic_get_sset_count(struct net_device *netdev, int sset)
 {
+	struct enic *enic = netdev_priv(netdev);
+	unsigned int n_per_rq_stats;
+	unsigned int n_per_wq_stats;
+	unsigned int n_stats;
+
 	switch (sset) {
 	case ETH_SS_STATS:
-		return NUM_ENIC_TX_STATS + NUM_ENIC_RX_STATS +
-			NUM_ENIC_GEN_STATS;
+		n_per_rq_stats = NUM_ENIC_PER_RQ_STATS * enic->rq_count;
+		n_per_wq_stats = NUM_ENIC_PER_WQ_STATS * enic->wq_count;
+		n_stats = NUM_ENIC_TX_STATS + NUM_ENIC_RX_STATS +
+			NUM_ENIC_GEN_STATS +
+			n_per_rq_stats + n_per_wq_stats;
+		return n_stats;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -259,6 +331,7 @@ static void enic_get_ethtool_stats(struct net_device *netdev,
 	struct enic *enic = netdev_priv(netdev);
 	struct vnic_stats *vstats;
 	unsigned int i;
+	unsigned int j;
 	int err;
 
 	err = enic_dev_stats_dump(enic, &vstats);
@@ -275,6 +348,24 @@ static void enic_get_ethtool_stats(struct net_device *netdev,
 		*(data++) = ((u64 *)&vstats->rx)[enic_rx_stats[i].index];
 	for (i = 0; i < NUM_ENIC_GEN_STATS; i++)
 		*(data++) = ((u64 *)&enic->gen_stats)[enic_gen_stats[i].index];
+	for (i = 0; i < enic->rq_count; i++) {
+		struct enic_rq_stats *rqstats = &enic->rq_stats[i];
+		int index;
+
+		for (j = 0; j < NUM_ENIC_PER_RQ_STATS; j++) {
+			index = enic_per_rq_stats[j].index;
+			*(data++) = ((u64 *)rqstats)[index];
+		}
+	}
+	for (i = 0; i < enic->wq_count; i++) {
+		struct enic_wq_stats *wqstats = &enic->wq_stats[i];
+		int index;
+
+		for (j = 0; j < NUM_ENIC_PER_WQ_STATS; j++) {
+			index = enic_per_wq_stats[j].index;
+			*(data++) = ((u64 *)wqstats)[index];
+		}
+	}
 }
 
 static u32 enic_get_msglevel(struct net_device *netdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 5f26fc3ad655..3dc9e4e6a7af 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -339,6 +339,10 @@ static void enic_free_wq_buf(struct vnic_wq *wq, struct vnic_wq_buf *buf)
 static void enic_wq_free_buf(struct vnic_wq *wq,
 	struct cq_desc *cq_desc, struct vnic_wq_buf *buf, void *opaque)
 {
+	struct enic *enic = (struct enic *)opaque;
+
+	enic->wq_stats[wq->index].cq_work++;
+	enic->wq_stats[wq->index].cq_bytes += buf->len;
 	enic_free_wq_buf(wq, buf);
 }
 
@@ -355,8 +359,10 @@ static int enic_wq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
 
 	if (netif_tx_queue_stopped(netdev_get_tx_queue(enic->netdev, q_number)) &&
 	    vnic_wq_desc_avail(&enic->wq[q_number]) >=
-	    (MAX_SKB_FRAGS + ENIC_DESC_MAX_SPLITS))
+	    (MAX_SKB_FRAGS + ENIC_DESC_MAX_SPLITS)) {
 		netif_wake_subqueue(enic->netdev, q_number);
+		enic->wq_stats[q_number].wake++;
+	}
 
 	spin_unlock(&enic->wq_lock[q_number]);
 
@@ -574,6 +580,8 @@ static int enic_queue_wq_skb_vlan(struct enic *enic, struct vnic_wq *wq,
 	dma_addr_t dma_addr;
 	int err = 0;
 
+	enic->wq_stats[wq->index].csum++;
+
 	dma_addr = dma_map_single(&enic->pdev->dev, skb->data, head_len,
 				  DMA_TO_DEVICE);
 	if (unlikely(enic_dma_map_check(enic, dma_addr)))
@@ -605,6 +613,8 @@ static int enic_queue_wq_skb_csum_l4(struct enic *enic, struct vnic_wq *wq,
 	dma_addr_t dma_addr;
 	int err = 0;
 
+	enic->wq_stats[wq->index].csum_partial++;
+
 	dma_addr = dma_map_single(&enic->pdev->dev, skb->data, head_len,
 				  DMA_TO_DEVICE);
 	if (unlikely(enic_dma_map_check(enic, dma_addr)))
@@ -682,9 +692,11 @@ static int enic_queue_wq_skb_tso(struct enic *enic, struct vnic_wq *wq,
 	if (skb->encapsulation) {
 		hdr_len = skb_inner_tcp_all_headers(skb);
 		enic_preload_tcp_csum_encap(skb);
+		enic->wq_stats[wq->index].encap_tso++;
 	} else {
 		hdr_len = skb_tcp_all_headers(skb);
 		enic_preload_tcp_csum(skb);
+		enic->wq_stats[wq->index].tso++;
 	}
 
 	/* Queue WQ_ENET_MAX_DESC_LEN length descriptors
@@ -752,6 +764,7 @@ static inline int enic_queue_wq_skb_encap(struct enic *enic, struct vnic_wq *wq,
 	dma_addr_t dma_addr;
 	int err = 0;
 
+	enic->wq_stats[wq->index].encap_csum++;
 	dma_addr = dma_map_single(&enic->pdev->dev, skb->data, head_len,
 				  DMA_TO_DEVICE);
 	if (unlikely(enic_dma_map_check(enic, dma_addr)))
@@ -780,6 +793,7 @@ static inline int enic_queue_wq_skb(struct enic *enic,
 		/* VLAN tag from trunking driver */
 		vlan_tag_insert = 1;
 		vlan_tag = skb_vlan_tag_get(skb);
+		enic->wq_stats[wq->index].add_vlan++;
 	} else if (enic->loop_enable) {
 		vlan_tag = enic->loop_tag;
 		loopback = 1;
@@ -825,13 +839,15 @@ static netdev_tx_t enic_hard_start_xmit(struct sk_buff *skb,
 	unsigned int txq_map;
 	struct netdev_queue *txq;
 
+	txq_map = skb_get_queue_mapping(skb) % enic->wq_count;
+	wq = &enic->wq[txq_map];
+
 	if (skb->len <= 0) {
 		dev_kfree_skb_any(skb);
+		enic->wq_stats[wq->index].null_pkt++;
 		return NETDEV_TX_OK;
 	}
 
-	txq_map = skb_get_queue_mapping(skb) % enic->wq_count;
-	wq = &enic->wq[txq_map];
 	txq = netdev_get_tx_queue(netdev, txq_map);
 
 	/* Non-TSO sends must fit within ENIC_NON_TSO_MAX_DESC descs,
@@ -843,6 +859,7 @@ static netdev_tx_t enic_hard_start_xmit(struct sk_buff *skb,
 	    skb_shinfo(skb)->nr_frags + 1 > ENIC_NON_TSO_MAX_DESC &&
 	    skb_linearize(skb)) {
 		dev_kfree_skb_any(skb);
+		enic->wq_stats[wq->index].skb_linear_fail++;
 		return NETDEV_TX_OK;
 	}
 
@@ -854,18 +871,23 @@ static netdev_tx_t enic_hard_start_xmit(struct sk_buff *skb,
 		/* This is a hard error, log it */
 		netdev_err(netdev, "BUG! Tx ring full when queue awake!\n");
 		spin_unlock(&enic->wq_lock[txq_map]);
+		enic->wq_stats[wq->index].desc_full_awake++;
 		return NETDEV_TX_BUSY;
 	}
 
 	if (enic_queue_wq_skb(enic, wq, skb))
 		goto error;
 
-	if (vnic_wq_desc_avail(wq) < MAX_SKB_FRAGS + ENIC_DESC_MAX_SPLITS)
+	if (vnic_wq_desc_avail(wq) < MAX_SKB_FRAGS + ENIC_DESC_MAX_SPLITS) {
 		netif_tx_stop_queue(txq);
+		enic->wq_stats[wq->index].stopped++;
+	}
 	skb_tx_timestamp(skb);
 	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
 		vnic_wq_doorbell(wq);
 
+	enic->wq_stats[wq->index].packets++;
+	enic->wq_stats[wq->index].bytes += skb->len;
 error:
 	spin_unlock(&enic->wq_lock[txq_map]);
 
@@ -878,7 +900,10 @@ static void enic_get_stats(struct net_device *netdev,
 {
 	struct enic *enic = netdev_priv(netdev);
 	struct vnic_stats *stats;
+	u64 pkt_truncated = 0;
+	u64 bad_fcs = 0;
 	int err;
+	int i;
 
 	err = enic_dev_stats_dump(enic, &stats);
 	/* return only when dma_alloc_coherent fails in vnic_dev_stats_dump
@@ -897,8 +922,17 @@ static void enic_get_stats(struct net_device *netdev,
 	net_stats->rx_bytes = stats->rx.rx_bytes_ok;
 	net_stats->rx_errors = stats->rx.rx_errors;
 	net_stats->multicast = stats->rx.rx_multicast_frames_ok;
-	net_stats->rx_over_errors = enic->rq_truncated_pkts;
-	net_stats->rx_crc_errors = enic->rq_bad_fcs;
+
+	for (i = 0; i < ENIC_RQ_MAX; i++) {
+		struct enic_rq_stats *rqs = &enic->rq_stats[i];
+
+		if (!enic->rq->ctrl)
+			break;
+		pkt_truncated += rqs->pkt_truncated;
+		bad_fcs += rqs->bad_fcs;
+	}
+	net_stats->rx_over_errors = pkt_truncated;
+	net_stats->rx_crc_errors = bad_fcs;
 	net_stats->rx_dropped = stats->rx.rx_no_bufs + stats->rx.rx_drop;
 }
 
@@ -1261,8 +1295,10 @@ static int enic_rq_alloc_buf(struct vnic_rq *rq)
 		return 0;
 	}
 	skb = netdev_alloc_skb_ip_align(netdev, len);
-	if (!skb)
+	if (!skb) {
+		enic->rq_stats[rq->index].no_skb++;
 		return -ENOMEM;
+	}
 
 	dma_addr = dma_map_single(&enic->pdev->dev, skb->data, len,
 				  DMA_FROM_DEVICE);
@@ -1313,6 +1349,7 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 	struct net_device *netdev = enic->netdev;
 	struct sk_buff *skb;
 	struct vnic_cq *cq = &enic->cq[enic_cq_rq(enic, rq->index)];
+	struct enic_rq_stats *rqstats = &enic->rq_stats[rq->index];
 
 	u8 type, color, eop, sop, ingress_port, vlan_stripped;
 	u8 fcoe, fcoe_sof, fcoe_fc_crc_ok, fcoe_enc_error, fcoe_eof;
@@ -1323,8 +1360,11 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 	u32 rss_hash;
 	bool outer_csum_ok = true, encap = false;
 
-	if (skipped)
+	rqstats->packets++;
+	if (skipped) {
+		rqstats->desc_skip++;
 		return;
+	}
 
 	skb = buf->os_buf;
 
@@ -1342,9 +1382,9 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 
 		if (!fcs_ok) {
 			if (bytes_written > 0)
-				enic->rq_bad_fcs++;
+				rqstats->bad_fcs++;
 			else if (bytes_written == 0)
-				enic->rq_truncated_pkts++;
+				rqstats->pkt_truncated++;
 		}
 
 		dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
@@ -1359,7 +1399,7 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 
 		/* Good receive
 		 */
-
+		rqstats->bytes += bytes_written;
 		if (!enic_rxcopybreak(netdev, &skb, buf, bytes_written)) {
 			buf->os_buf = NULL;
 			dma_unmap_single(&enic->pdev->dev, buf->dma_addr,
@@ -1377,11 +1417,13 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 			case CQ_ENET_RQ_DESC_RSS_TYPE_TCP_IPv6:
 			case CQ_ENET_RQ_DESC_RSS_TYPE_TCP_IPv6_EX:
 				skb_set_hash(skb, rss_hash, PKT_HASH_TYPE_L4);
+				rqstats->l4_rss_hash++;
 				break;
 			case CQ_ENET_RQ_DESC_RSS_TYPE_IPv4:
 			case CQ_ENET_RQ_DESC_RSS_TYPE_IPv6:
 			case CQ_ENET_RQ_DESC_RSS_TYPE_IPv6_EX:
 				skb_set_hash(skb, rss_hash, PKT_HASH_TYPE_L3);
+				rqstats->l3_rss_hash++;
 				break;
 			}
 		}
@@ -1418,11 +1460,16 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 		    (ipv4_csum_ok || ipv6)) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 			skb->csum_level = encap;
+			if (encap)
+				rqstats->csum_unnecessary_encap++;
+			else
+				rqstats->csum_unnecessary++;
 		}
 
-		if (vlan_stripped)
+		if (vlan_stripped) {
 			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);
-
+			rqstats->vlan_stripped++;
+		}
 		skb_mark_napi_id(skb, &enic->napi[rq->index]);
 		if (!(netdev->features & NETIF_F_GRO))
 			netif_receive_skb(skb);
@@ -1435,7 +1482,7 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 
 		/* Buffer overflow
 		 */
-
+		rqstats->pkt_truncated++;
 		dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
 				 DMA_FROM_DEVICE);
 		dev_kfree_skb_any(skb);
@@ -1526,11 +1573,11 @@ static int enic_poll(struct napi_struct *napi, int budget)
 	int err;
 
 	wq_work_done = vnic_cq_service(&enic->cq[cq_wq], wq_work_to_do,
-				       enic_wq_service, NULL);
+				       enic_wq_service, enic);
 
 	if (budget > 0)
 		rq_work_done = vnic_cq_service(&enic->cq[cq_rq],
-			rq_work_to_do, enic_rq_service, NULL);
+			rq_work_to_do, enic_rq_service, enic);
 
 	/* Accumulate intr event credits for this polling
 	 * cycle.  An intr event is the completion of a
@@ -1568,6 +1615,9 @@ static int enic_poll(struct napi_struct *napi, int budget)
 		if (enic->rx_coalesce_setting.use_adaptive_rx_coalesce)
 			enic_set_int_moderation(enic, &enic->rq[0]);
 		vnic_intr_unmask(&enic->intr[intr]);
+		enic->rq_stats[0].napi_complete++;
+	} else {
+		enic->rq_stats[0].napi_repoll++;
 	}
 
 	return rq_work_done;
@@ -1627,7 +1677,7 @@ static int enic_poll_msix_wq(struct napi_struct *napi, int budget)
 	cq = enic_cq_wq(enic, wq_irq);
 	intr = enic_msix_wq_intr(enic, wq_irq);
 	wq_work_done = vnic_cq_service(&enic->cq[cq], wq_work_to_do,
-				       enic_wq_service, NULL);
+				       enic_wq_service, enic);
 
 	vnic_intr_return_credits(&enic->intr[intr], wq_work_done,
 				 0 /* don't unmask intr */,
@@ -1657,7 +1707,7 @@ static int enic_poll_msix_rq(struct napi_struct *napi, int budget)
 
 	if (budget > 0)
 		work_done = vnic_cq_service(&enic->cq[cq],
-			work_to_do, enic_rq_service, NULL);
+			work_to_do, enic_rq_service, enic);
 
 	/* Return intr event credits for this polling
 	 * cycle.  An intr event is the completion of a
@@ -1693,6 +1743,9 @@ static int enic_poll_msix_rq(struct napi_struct *napi, int budget)
 		if (enic->rx_coalesce_setting.use_adaptive_rx_coalesce)
 			enic_set_int_moderation(enic, &enic->rq[rq]);
 		vnic_intr_unmask(&enic->intr[intr]);
+		enic->rq_stats[rq].napi_complete++;
+	} else {
+		enic->rq_stats[rq].napi_repoll++;
 	}
 
 	return work_done;
-- 
2.35.2


