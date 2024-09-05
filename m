Return-Path: <netdev+bounces-125333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F8F96CC13
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 03:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6051C246EC
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0D179CC;
	Thu,  5 Sep 2024 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Kr/Hb1YO"
X-Original-To: netdev@vger.kernel.org
Received: from aer-iport-3.cisco.com (aer-iport-3.cisco.com [173.38.203.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5AD4C83
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 01:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498683; cv=none; b=Zf8FUiIEZOA+fhE53r8Kf2pndjI28XsavwyER5gm8VEfifCmb9m7oq5DVPsWQx53zFME11e27ijbJQmC3F8mem/29Dz5IadLdPfx4FSIQU1UB6xwqXDzGSi+BOpjfbzkFBlU4Dw2TseD0h41pBp67IivUjYoJRQAI8iuoTEWaaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498683; c=relaxed/simple;
	bh=Jx7iLieqH/OwwgSozcuz3h65grtX9yc2WZGIcJd/kQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EOmjdf8dUM08UzwY2/+9Fd6Ysiyrpc9xQWRt4hkY7VGDmG8rP5I/h7i3sBFmo7HSZx9ILw1YUiNrEZG5ynV8/35feDrXVJrFaGgDB1G0oLNN1JvQzWQ4BAFhsIlghIxgmP8Xjo6l7Zuojnw+HYI8eoto7Pml7VJagFtB9x8V+oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Kr/Hb1YO; arc=none smtp.client-ip=173.38.203.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=13858; q=dns/txt;
  s=iport; t=1725498681; x=1726708281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zPUYE6jABZCM9Zp+LnBGQuJ8aW6ouG4b+2qMkmZXVLc=;
  b=Kr/Hb1YORHp7H8Tn703teMGyZikFsRTq4OcAZescgnElDSaZEKMjCzAr
   YwKRRRKilBPJZi4iSGv41YQyWbmrH26rtQYVTd97LxYm/Q/LVG54G0Mrv
   0JGTdssGyiLJw2CaYGX/K2uyRNNs+p7D0ZoG7e+JAomIF9NFSqk9dYrBg
   I=;
X-CSE-ConnectionGUID: EwiNLtOjSlG92I8AhJiw8A==
X-CSE-MsgGUID: 89L4/OnERLetQJ/wKNoegQ==
X-IronPort-AV: E=Sophos;i="6.10,203,1719878400"; 
   d="scan'208";a="14120878"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by aer-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:10:09 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-core-2.cisco.com (8.15.2/8.15.2) with ESMTP id 4851A8j9007585;
	Thu, 5 Sep 2024 01:10:08 GMT
Received: by cisco.com (Postfix, from userid 412739)
	id F166320F2003; Wed,  4 Sep 2024 18:10:07 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com, johndale@cisco.com,
        Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v2 2/4] enic: Collect per queue statistics
Date: Wed,  4 Sep 2024 18:08:58 -0700
Message-Id: <20240905010900.24152-3-neescoba@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20240905010900.24152-1-neescoba@cisco.com>
References: <20240905010900.24152-1-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-core-2.cisco.com

Collect and per rq/wq statistics.

Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  38 ++++++-
 drivers/net/ethernet/cisco/enic/enic_main.c | 108 ++++++++++++++++----
 2 files changed, 124 insertions(+), 22 deletions(-)

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
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 5f26fc3ad655..7d4b44f1abb2 100644
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
 
@@ -590,6 +596,10 @@ static int enic_queue_wq_skb_vlan(struct enic *enic, struct vnic_wq *wq,
 	if (!eop)
 		err = enic_queue_wq_skb_cont(enic, wq, skb, len_left, loopback);
 
+	enic->wq_stats[wq->index].csum++;
+	enic->wq_stats[wq->index].packets++;
+	enic->wq_stats[wq->index].bytes += skb->len;
+
 	return err;
 }
 
@@ -622,6 +632,10 @@ static int enic_queue_wq_skb_csum_l4(struct enic *enic, struct vnic_wq *wq,
 	if (!eop)
 		err = enic_queue_wq_skb_cont(enic, wq, skb, len_left, loopback);
 
+	enic->wq_stats[wq->index].csum_partial++;
+	enic->wq_stats[wq->index].packets++;
+	enic->wq_stats[wq->index].bytes += skb->len;
+
 	return err;
 }
 
@@ -676,15 +690,18 @@ static int enic_queue_wq_skb_tso(struct enic *enic, struct vnic_wq *wq,
 	unsigned int offset = 0;
 	unsigned int hdr_len;
 	dma_addr_t dma_addr;
+	unsigned int pkts;
 	unsigned int len;
 	skb_frag_t *frag;
 
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
@@ -705,7 +722,7 @@ static int enic_queue_wq_skb_tso(struct enic *enic, struct vnic_wq *wq,
 	}
 
 	if (eop)
-		return 0;
+		goto tso_out_stats;
 
 	/* Queue WQ_ENET_MAX_DESC_LEN length descriptors
 	 * for additional data fragments
@@ -732,6 +749,15 @@ static int enic_queue_wq_skb_tso(struct enic *enic, struct vnic_wq *wq,
 		}
 	}
 
+tso_out_stats:
+	/* calculate how many packets tso sent */
+	len = skb->len - hdr_len;
+	pkts = len / mss;
+	if ((len % mss) > 0)
+		pkts++;
+	enic->wq_stats[wq->index].packets += pkts;
+	enic->wq_stats[wq->index].bytes += (len + (pkts * hdr_len));
+
 	return 0;
 }
 
@@ -764,6 +790,10 @@ static inline int enic_queue_wq_skb_encap(struct enic *enic, struct vnic_wq *wq,
 	if (!eop)
 		err = enic_queue_wq_skb_cont(enic, wq, skb, len_left, loopback);
 
+	enic->wq_stats[wq->index].encap_csum++;
+	enic->wq_stats[wq->index].packets++;
+	enic->wq_stats[wq->index].bytes += skb->len;
+
 	return err;
 }
 
@@ -780,6 +810,7 @@ static inline int enic_queue_wq_skb(struct enic *enic,
 		/* VLAN tag from trunking driver */
 		vlan_tag_insert = 1;
 		vlan_tag = skb_vlan_tag_get(skb);
+		enic->wq_stats[wq->index].add_vlan++;
 	} else if (enic->loop_enable) {
 		vlan_tag = enic->loop_tag;
 		loopback = 1;
@@ -792,7 +823,7 @@ static inline int enic_queue_wq_skb(struct enic *enic,
 	else if (skb->encapsulation)
 		err = enic_queue_wq_skb_encap(enic, wq, skb, vlan_tag_insert,
 					      vlan_tag, loopback);
-	else if	(skb->ip_summed == CHECKSUM_PARTIAL)
+	else if (skb->ip_summed == CHECKSUM_PARTIAL)
 		err = enic_queue_wq_skb_csum_l4(enic, wq, skb, vlan_tag_insert,
 						vlan_tag, loopback);
 	else
@@ -825,13 +856,15 @@ static netdev_tx_t enic_hard_start_xmit(struct sk_buff *skb,
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
@@ -843,6 +876,7 @@ static netdev_tx_t enic_hard_start_xmit(struct sk_buff *skb,
 	    skb_shinfo(skb)->nr_frags + 1 > ENIC_NON_TSO_MAX_DESC &&
 	    skb_linearize(skb)) {
 		dev_kfree_skb_any(skb);
+		enic->wq_stats[wq->index].skb_linear_fail++;
 		return NETDEV_TX_OK;
 	}
 
@@ -854,14 +888,17 @@ static netdev_tx_t enic_hard_start_xmit(struct sk_buff *skb,
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
@@ -878,7 +915,10 @@ static void enic_get_stats(struct net_device *netdev,
 {
 	struct enic *enic = netdev_priv(netdev);
 	struct vnic_stats *stats;
+	u64 pkt_truncated = 0;
+	u64 bad_fcs = 0;
 	int err;
+	int i;
 
 	err = enic_dev_stats_dump(enic, &stats);
 	/* return only when dma_alloc_coherent fails in vnic_dev_stats_dump
@@ -897,8 +937,17 @@ static void enic_get_stats(struct net_device *netdev,
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
 
@@ -1261,8 +1310,10 @@ static int enic_rq_alloc_buf(struct vnic_rq *rq)
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
@@ -1313,6 +1364,7 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 	struct net_device *netdev = enic->netdev;
 	struct sk_buff *skb;
 	struct vnic_cq *cq = &enic->cq[enic_cq_rq(enic, rq->index)];
+	struct enic_rq_stats *rqstats = &enic->rq_stats[rq->index];
 
 	u8 type, color, eop, sop, ingress_port, vlan_stripped;
 	u8 fcoe, fcoe_sof, fcoe_fc_crc_ok, fcoe_enc_error, fcoe_eof;
@@ -1323,8 +1375,11 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 	u32 rss_hash;
 	bool outer_csum_ok = true, encap = false;
 
-	if (skipped)
+	rqstats->packets++;
+	if (skipped) {
+		rqstats->desc_skip++;
 		return;
+	}
 
 	skb = buf->os_buf;
 
@@ -1342,9 +1397,9 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 
 		if (!fcs_ok) {
 			if (bytes_written > 0)
-				enic->rq_bad_fcs++;
+				rqstats->bad_fcs++;
 			else if (bytes_written == 0)
-				enic->rq_truncated_pkts++;
+				rqstats->pkt_truncated++;
 		}
 
 		dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
@@ -1359,7 +1414,7 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 
 		/* Good receive
 		 */
-
+		rqstats->bytes += bytes_written;
 		if (!enic_rxcopybreak(netdev, &skb, buf, bytes_written)) {
 			buf->os_buf = NULL;
 			dma_unmap_single(&enic->pdev->dev, buf->dma_addr,
@@ -1377,11 +1432,13 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
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
@@ -1418,11 +1475,16 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
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
@@ -1435,7 +1497,7 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 
 		/* Buffer overflow
 		 */
-
+		rqstats->pkt_truncated++;
 		dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
 				 DMA_FROM_DEVICE);
 		dev_kfree_skb_any(skb);
@@ -1526,11 +1588,11 @@ static int enic_poll(struct napi_struct *napi, int budget)
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
@@ -1568,6 +1630,9 @@ static int enic_poll(struct napi_struct *napi, int budget)
 		if (enic->rx_coalesce_setting.use_adaptive_rx_coalesce)
 			enic_set_int_moderation(enic, &enic->rq[0]);
 		vnic_intr_unmask(&enic->intr[intr]);
+		enic->rq_stats[0].napi_complete++;
+	} else {
+		enic->rq_stats[0].napi_repoll++;
 	}
 
 	return rq_work_done;
@@ -1627,7 +1692,7 @@ static int enic_poll_msix_wq(struct napi_struct *napi, int budget)
 	cq = enic_cq_wq(enic, wq_irq);
 	intr = enic_msix_wq_intr(enic, wq_irq);
 	wq_work_done = vnic_cq_service(&enic->cq[cq], wq_work_to_do,
-				       enic_wq_service, NULL);
+				       enic_wq_service, enic);
 
 	vnic_intr_return_credits(&enic->intr[intr], wq_work_done,
 				 0 /* don't unmask intr */,
@@ -1657,7 +1722,7 @@ static int enic_poll_msix_rq(struct napi_struct *napi, int budget)
 
 	if (budget > 0)
 		work_done = vnic_cq_service(&enic->cq[cq],
-			work_to_do, enic_rq_service, NULL);
+			work_to_do, enic_rq_service, enic);
 
 	/* Return intr event credits for this polling
 	 * cycle.  An intr event is the completion of a
@@ -1693,6 +1758,9 @@ static int enic_poll_msix_rq(struct napi_struct *napi, int budget)
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


