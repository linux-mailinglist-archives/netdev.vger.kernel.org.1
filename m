Return-Path: <netdev+bounces-137713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9B59A97B8
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 06:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8F11C2305B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 04:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516E2824AD;
	Tue, 22 Oct 2024 04:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="mRSF1mKU"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44CA79B8E
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 04:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729570682; cv=none; b=mpxqVXAHKet0n3ZEPOr6aCN0o2Ks7MKZIwPYUa1rnEmJVv5D34G5FmxwUyV9DY39a82Av0K2aEt2ca8ItC3HUTfruFHGoujIRBGEZ8tIzmWNdQf9aIHys44JR9SRQVEvOaP5NEWNsYxywozpNz2/KUnZANOvudilwluJtwHb/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729570682; c=relaxed/simple;
	bh=1pwxduZoVN5bdAHKw6awCIT5VHEEoIswP1XXYlrl3L0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nFj5c2TTwgWhl+f95l4bGilXOgee6eDrXeuOTEe1q1U1djBkXTFvLWKmG5jEm9PfplnQInNbqtfVtdFEj9/H16WDzDDg/cktEwurxNXlwzayn3u7yQKsVDITNIokGnJ/y+Ppqrz+Viig3L313RMRc+Z5xGuPQ++qCaUYa7nOvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=mRSF1mKU; arc=none smtp.client-ip=173.37.86.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=18556; q=dns/txt;
  s=iport; t=1729570679; x=1730780279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QdXa6QPTyKWowknidBxofnQuP0Hla8Vbs+iSsCUbm3A=;
  b=mRSF1mKU/80VQ0DX27tC6o33aow21Hbm6s7rcM1ePiY41vKrxQ+osnEw
   NcqD6gq8e2/TzxqIHEVY4KhfZ9YopXITA1G6OEX0MsjlscynfuaagTj+K
   VeNXE2f1R2h/F9whEtyLkH3hlB8+TmaPhhwv60ldTd9JgRn1OcecJdlVZ
   g=;
X-CSE-ConnectionGUID: f4AufLEdTpufz8qx+NjbEg==
X-CSE-MsgGUID: 838GCxIfTF6S24Ljh4lr+A==
X-IPAS-Result: =?us-ascii?q?A0ANAAC6Jhdn/4z/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF/BgEBAQsBgkqBT0NIjHJfiHKLdZIiFIERA1YPAQEBD0QEAQGFBwKKI?=
 =?us-ascii?q?wImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQcFgQ4ThgiGWwIBA?=
 =?us-ascii?q?ycLAUYQUSsrGYMBgmUDr1uBeTOBAYR72TiBbIFIAY1FcIR3JxuBSUSCUIIth?=
 =?us-ascii?q?CqGXQSHaIwthQ2BD4FtVXwlgSACAgIHAogOkXZIgSEDWSECEQFVEw0KCwkFi?=
 =?us-ascii?q?TWDJimBa4EIgwiFJYFnCWGIR4EHLYERgR86ggOBNkqFN0c/gk9qTjcCDQI3g?=
 =?us-ascii?q?iSBAIJRhkdAAwsYDUgRLDUUGwY+bgesekaCZnsUf4EUMSY4klgJAZISgTSfS?=
 =?us-ascii?q?oQkoT8aM6pMHhCYSaQ6hGaBZzyBWTMaCBsVgyJSGQ+OKgMWzDwmMjsCBwsBA?=
 =?us-ascii?q?QMJhkuGfWABAQ?=
IronPort-Data: A9a23:KFbXuaP0aQUfB43vrR3ilsFynXyQoLVcMsEvi/4bfWQNrUor1zMCm
 GRNDGjSa/rbYmHxeYhxO9uy9RxVu8XczINrTHM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCdap1yFDmE/0fF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WlrlV
 e/a+ZWFZAb9gWQsawr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj6/syJVw4GaAUxv5qD3Me7
 OxbDjIHQx/W0opawJrjIgVtrt4oIM+uOMYUvWttiGmCS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzNHwsYDUXUrsTIJQzkfyjgXP2WzZZs1mS46Ew5gA/ySQrj+e1bYqLJ4ziqcN9zh3Ii
 UnW3mrFLE8hboC7yzrZ9mjvr7qa9c/8cMdIfFGizdZsjUGfy3I7FhIbTx24rOO/h0r4XMhQQ
 3H44QI0pqQ0sUjuRd7nUljg+ziPvwUXXJxbFOhSBByx95c4Kj2xXgAsJgOtovR83CPqbVTGD
 mO0ou4=
IronPort-HdrOrdr: A9a23:YbfblaA2WQZ12wDlHemr55DYdb4zR+YMi2TDGXofdfUzSL3+qy
 nAppUmPHPP5Qr5HUtQ++xoW5PwJU80i6QU3WB5B97LN2PbUSmTXeRfBODZrQEIdReTygck79
 YCT0C7Y+eAdGSTSq3BkW+FL+o=
X-Talos-CUID: 9a23:moMoBmCmIpfzTfL6Eyc73VMaPu0pTmXAwmWAOl/7L2RjZbLAHA==
X-Talos-MUID: 9a23:wjul6AmyrYJMEXR5gbFodnoyb5dHyLSPBnwjz65c5+2GNXB0IXS02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,222,1725321600"; 
   d="scan'208";a="277058658"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 22 Oct 2024 04:17:58 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTP id A76CC180001EE;
	Tue, 22 Oct 2024 04:17:57 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 412739)
	id 7D98E20F2003; Mon, 21 Oct 2024 21:17:57 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com,
	johndale@cisco.com,
	Nelson Escobar <neescoba@cisco.com>
Subject: [Patch net-next 1/5] enic: Create enic_wq/rq structures to bundle per wq/rq data
Date: Mon, 21 Oct 2024 21:17:03 -0700
Message-Id: <20241022041707.27402-2-neescoba@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241022041707.27402-1-neescoba@cisco.com>
References: <20241022041707.27402-1-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-03.cisco.com

Bundling the wq/rq specific data into dedicated enic_wq/rq structures
cleans up the enic structure and simplifies future changes related to
wq/rq.

Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h        |  18 ++-
 .../net/ethernet/cisco/enic/enic_ethtool.c    |   4 +-
 drivers/net/ethernet/cisco/enic/enic_main.c   | 120 +++++++++---------
 drivers/net/ethernet/cisco/enic/enic_res.c    |  12 +-
 4 files changed, 81 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 0cc3644ee855..e6edb43515b9 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -162,6 +162,17 @@ struct enic_rq_stats {
 	u64 desc_skip;			/* Rx pkt went into later buffer */
 };
 
+struct enic_wq {
+	struct vnic_wq vwq;
+	struct enic_wq_stats stats;
+	spinlock_t lock;		/* spinlock for wq */
+};
+
+struct enic_rq {
+	struct vnic_rq vrq;
+	struct enic_rq_stats stats;
+};
+
 /* Per-instance private data structure */
 struct enic {
 	struct net_device *netdev;
@@ -194,16 +205,13 @@ struct enic {
 	struct enic_port_profile *pp;
 
 	/* work queue cache line section */
-	____cacheline_aligned struct vnic_wq wq[ENIC_WQ_MAX];
-	spinlock_t wq_lock[ENIC_WQ_MAX];
-	struct enic_wq_stats wq_stats[ENIC_WQ_MAX];
+	____cacheline_aligned struct enic_wq wq[ENIC_WQ_MAX];
 	unsigned int wq_count;
 	u16 loop_enable;
 	u16 loop_tag;
 
 	/* receive queue cache line section */
-	____cacheline_aligned struct vnic_rq rq[ENIC_RQ_MAX];
-	struct enic_rq_stats rq_stats[ENIC_RQ_MAX];
+	____cacheline_aligned struct enic_rq rq[ENIC_RQ_MAX];
 	unsigned int rq_count;
 	struct vxlan_offload vxlan;
 	struct napi_struct napi[ENIC_RQ_MAX + ENIC_WQ_MAX];
diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index f7986f2b6a17..909d6f7000e1 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -337,7 +337,7 @@ static void enic_get_ethtool_stats(struct net_device *netdev,
 	for (i = 0; i < NUM_ENIC_GEN_STATS; i++)
 		*(data++) = ((u64 *)&enic->gen_stats)[enic_gen_stats[i].index];
 	for (i = 0; i < enic->rq_count; i++) {
-		struct enic_rq_stats *rqstats = &enic->rq_stats[i];
+		struct enic_rq_stats *rqstats = &enic->rq[i].stats;
 		int index;
 
 		for (j = 0; j < NUM_ENIC_PER_RQ_STATS; j++) {
@@ -346,7 +346,7 @@ static void enic_get_ethtool_stats(struct net_device *netdev,
 		}
 	}
 	for (i = 0; i < enic->wq_count; i++) {
-		struct enic_wq_stats *wqstats = &enic->wq_stats[i];
+		struct enic_wq_stats *wqstats = &enic->wq[i].stats;
 		int index;
 
 		for (j = 0; j < NUM_ENIC_PER_WQ_STATS; j++) {
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index ffed14b63d41..eb00058b6c68 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -342,8 +342,8 @@ static void enic_wq_free_buf(struct vnic_wq *wq,
 {
 	struct enic *enic = vnic_dev_priv(wq->vdev);
 
-	enic->wq_stats[wq->index].cq_work++;
-	enic->wq_stats[wq->index].cq_bytes += buf->len;
+	enic->wq[wq->index].stats.cq_work++;
+	enic->wq[wq->index].stats.cq_bytes += buf->len;
 	enic_free_wq_buf(wq, buf);
 }
 
@@ -352,20 +352,20 @@ static int enic_wq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
 {
 	struct enic *enic = vnic_dev_priv(vdev);
 
-	spin_lock(&enic->wq_lock[q_number]);
+	spin_lock(&enic->wq[q_number].lock);
 
-	vnic_wq_service(&enic->wq[q_number], cq_desc,
+	vnic_wq_service(&enic->wq[q_number].vwq, cq_desc,
 		completed_index, enic_wq_free_buf,
 		opaque);
 
 	if (netif_tx_queue_stopped(netdev_get_tx_queue(enic->netdev, q_number)) &&
-	    vnic_wq_desc_avail(&enic->wq[q_number]) >=
+	    vnic_wq_desc_avail(&enic->wq[q_number].vwq) >=
 	    (MAX_SKB_FRAGS + ENIC_DESC_MAX_SPLITS)) {
 		netif_wake_subqueue(enic->netdev, q_number);
-		enic->wq_stats[q_number].wake++;
+		enic->wq[q_number].stats.wake++;
 	}
 
-	spin_unlock(&enic->wq_lock[q_number]);
+	spin_unlock(&enic->wq[q_number].lock);
 
 	return 0;
 }
@@ -377,7 +377,7 @@ static bool enic_log_q_error(struct enic *enic)
 	bool err = false;
 
 	for (i = 0; i < enic->wq_count; i++) {
-		error_status = vnic_wq_error_status(&enic->wq[i]);
+		error_status = vnic_wq_error_status(&enic->wq[i].vwq);
 		err |= error_status;
 		if (error_status)
 			netdev_err(enic->netdev, "WQ[%d] error_status %d\n",
@@ -385,7 +385,7 @@ static bool enic_log_q_error(struct enic *enic)
 	}
 
 	for (i = 0; i < enic->rq_count; i++) {
-		error_status = vnic_rq_error_status(&enic->rq[i]);
+		error_status = vnic_rq_error_status(&enic->rq[i].vrq);
 		err |= error_status;
 		if (error_status)
 			netdev_err(enic->netdev, "RQ[%d] error_status %d\n",
@@ -598,9 +598,9 @@ static int enic_queue_wq_skb_vlan(struct enic *enic, struct vnic_wq *wq,
 		err = enic_queue_wq_skb_cont(enic, wq, skb, len_left, loopback);
 
 	/* The enic_queue_wq_desc() above does not do HW checksum */
-	enic->wq_stats[wq->index].csum_none++;
-	enic->wq_stats[wq->index].packets++;
-	enic->wq_stats[wq->index].bytes += skb->len;
+	enic->wq[wq->index].stats.csum_none++;
+	enic->wq[wq->index].stats.packets++;
+	enic->wq[wq->index].stats.bytes += skb->len;
 
 	return err;
 }
@@ -634,9 +634,9 @@ static int enic_queue_wq_skb_csum_l4(struct enic *enic, struct vnic_wq *wq,
 	if (!eop)
 		err = enic_queue_wq_skb_cont(enic, wq, skb, len_left, loopback);
 
-	enic->wq_stats[wq->index].csum_partial++;
-	enic->wq_stats[wq->index].packets++;
-	enic->wq_stats[wq->index].bytes += skb->len;
+	enic->wq[wq->index].stats.csum_partial++;
+	enic->wq[wq->index].stats.packets++;
+	enic->wq[wq->index].stats.bytes += skb->len;
 
 	return err;
 }
@@ -699,11 +699,11 @@ static int enic_queue_wq_skb_tso(struct enic *enic, struct vnic_wq *wq,
 	if (skb->encapsulation) {
 		hdr_len = skb_inner_tcp_all_headers(skb);
 		enic_preload_tcp_csum_encap(skb);
-		enic->wq_stats[wq->index].encap_tso++;
+		enic->wq[wq->index].stats.encap_tso++;
 	} else {
 		hdr_len = skb_tcp_all_headers(skb);
 		enic_preload_tcp_csum(skb);
-		enic->wq_stats[wq->index].tso++;
+		enic->wq[wq->index].stats.tso++;
 	}
 
 	/* Queue WQ_ENET_MAX_DESC_LEN length descriptors
@@ -757,8 +757,8 @@ static int enic_queue_wq_skb_tso(struct enic *enic, struct vnic_wq *wq,
 	pkts = len / mss;
 	if ((len % mss) > 0)
 		pkts++;
-	enic->wq_stats[wq->index].packets += pkts;
-	enic->wq_stats[wq->index].bytes += (len + (pkts * hdr_len));
+	enic->wq[wq->index].stats.packets += pkts;
+	enic->wq[wq->index].stats.bytes += (len + (pkts * hdr_len));
 
 	return 0;
 }
@@ -792,9 +792,9 @@ static inline int enic_queue_wq_skb_encap(struct enic *enic, struct vnic_wq *wq,
 	if (!eop)
 		err = enic_queue_wq_skb_cont(enic, wq, skb, len_left, loopback);
 
-	enic->wq_stats[wq->index].encap_csum++;
-	enic->wq_stats[wq->index].packets++;
-	enic->wq_stats[wq->index].bytes += skb->len;
+	enic->wq[wq->index].stats.encap_csum++;
+	enic->wq[wq->index].stats.packets++;
+	enic->wq[wq->index].stats.bytes += skb->len;
 
 	return err;
 }
@@ -812,7 +812,7 @@ static inline int enic_queue_wq_skb(struct enic *enic,
 		/* VLAN tag from trunking driver */
 		vlan_tag_insert = 1;
 		vlan_tag = skb_vlan_tag_get(skb);
-		enic->wq_stats[wq->index].add_vlan++;
+		enic->wq[wq->index].stats.add_vlan++;
 	} else if (enic->loop_enable) {
 		vlan_tag = enic->loop_tag;
 		loopback = 1;
@@ -859,11 +859,11 @@ static netdev_tx_t enic_hard_start_xmit(struct sk_buff *skb,
 	struct netdev_queue *txq;
 
 	txq_map = skb_get_queue_mapping(skb) % enic->wq_count;
-	wq = &enic->wq[txq_map];
+	wq = &enic->wq[txq_map].vwq;
 
 	if (skb->len <= 0) {
 		dev_kfree_skb_any(skb);
-		enic->wq_stats[wq->index].null_pkt++;
+		enic->wq[wq->index].stats.null_pkt++;
 		return NETDEV_TX_OK;
 	}
 
@@ -878,19 +878,19 @@ static netdev_tx_t enic_hard_start_xmit(struct sk_buff *skb,
 	    skb_shinfo(skb)->nr_frags + 1 > ENIC_NON_TSO_MAX_DESC &&
 	    skb_linearize(skb)) {
 		dev_kfree_skb_any(skb);
-		enic->wq_stats[wq->index].skb_linear_fail++;
+		enic->wq[wq->index].stats.skb_linear_fail++;
 		return NETDEV_TX_OK;
 	}
 
-	spin_lock(&enic->wq_lock[txq_map]);
+	spin_lock(&enic->wq[txq_map].lock);
 
 	if (vnic_wq_desc_avail(wq) <
 	    skb_shinfo(skb)->nr_frags + ENIC_DESC_MAX_SPLITS) {
 		netif_tx_stop_queue(txq);
 		/* This is a hard error, log it */
 		netdev_err(netdev, "BUG! Tx ring full when queue awake!\n");
-		spin_unlock(&enic->wq_lock[txq_map]);
-		enic->wq_stats[wq->index].desc_full_awake++;
+		spin_unlock(&enic->wq[txq_map].lock);
+		enic->wq[wq->index].stats.desc_full_awake++;
 		return NETDEV_TX_BUSY;
 	}
 
@@ -899,14 +899,14 @@ static netdev_tx_t enic_hard_start_xmit(struct sk_buff *skb,
 
 	if (vnic_wq_desc_avail(wq) < MAX_SKB_FRAGS + ENIC_DESC_MAX_SPLITS) {
 		netif_tx_stop_queue(txq);
-		enic->wq_stats[wq->index].stopped++;
+		enic->wq[wq->index].stats.stopped++;
 	}
 	skb_tx_timestamp(skb);
 	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
 		vnic_wq_doorbell(wq);
 
 error:
-	spin_unlock(&enic->wq_lock[txq_map]);
+	spin_unlock(&enic->wq[txq_map].lock);
 
 	return NETDEV_TX_OK;
 }
@@ -941,9 +941,9 @@ static void enic_get_stats(struct net_device *netdev,
 	net_stats->multicast = stats->rx.rx_multicast_frames_ok;
 
 	for (i = 0; i < ENIC_RQ_MAX; i++) {
-		struct enic_rq_stats *rqs = &enic->rq_stats[i];
+		struct enic_rq_stats *rqs = &enic->rq[i].stats;
 
-		if (!enic->rq->ctrl)
+		if (!enic->rq[i].vrq.ctrl)
 			break;
 		pkt_truncated += rqs->pkt_truncated;
 		bad_fcs += rqs->bad_fcs;
@@ -1313,7 +1313,7 @@ static int enic_rq_alloc_buf(struct vnic_rq *rq)
 	}
 	skb = netdev_alloc_skb_ip_align(netdev, len);
 	if (!skb) {
-		enic->rq_stats[rq->index].no_skb++;
+		enic->rq[rq->index].stats.no_skb++;
 		return -ENOMEM;
 	}
 
@@ -1366,7 +1366,7 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 	struct net_device *netdev = enic->netdev;
 	struct sk_buff *skb;
 	struct vnic_cq *cq = &enic->cq[enic_cq_rq(enic, rq->index)];
-	struct enic_rq_stats *rqstats = &enic->rq_stats[rq->index];
+	struct enic_rq_stats *rqstats = &enic->rq[rq->index].stats;
 
 	u8 type, color, eop, sop, ingress_port, vlan_stripped;
 	u8 fcoe, fcoe_sof, fcoe_fc_crc_ok, fcoe_enc_error, fcoe_eof;
@@ -1512,7 +1512,7 @@ static int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
 {
 	struct enic *enic = vnic_dev_priv(vdev);
 
-	vnic_rq_service(&enic->rq[q_number], cq_desc,
+	vnic_rq_service(&enic->rq[q_number].vrq, cq_desc,
 		completed_index, VNIC_RQ_RETURN_DESC,
 		enic_rq_indicate_buf, opaque);
 
@@ -1609,7 +1609,7 @@ static int enic_poll(struct napi_struct *napi, int budget)
 			0 /* don't unmask intr */,
 			0 /* don't reset intr timer */);
 
-	err = vnic_rq_fill(&enic->rq[0], enic_rq_alloc_buf);
+	err = vnic_rq_fill(&enic->rq[0].vrq, enic_rq_alloc_buf);
 
 	/* Buffer allocation failed. Stay in polling
 	 * mode so we can try to fill the ring again.
@@ -1621,7 +1621,7 @@ static int enic_poll(struct napi_struct *napi, int budget)
 		/* Call the function which refreshes the intr coalescing timer
 		 * value based on the traffic.
 		 */
-		enic_calc_int_moderation(enic, &enic->rq[0]);
+		enic_calc_int_moderation(enic, &enic->rq[0].vrq);
 
 	if ((rq_work_done < budget) && napi_complete_done(napi, rq_work_done)) {
 
@@ -1630,11 +1630,11 @@ static int enic_poll(struct napi_struct *napi, int budget)
 		 */
 
 		if (enic->rx_coalesce_setting.use_adaptive_rx_coalesce)
-			enic_set_int_moderation(enic, &enic->rq[0]);
+			enic_set_int_moderation(enic, &enic->rq[0].vrq);
 		vnic_intr_unmask(&enic->intr[intr]);
-		enic->rq_stats[0].napi_complete++;
+		enic->rq[0].stats.napi_complete++;
 	} else {
-		enic->rq_stats[0].napi_repoll++;
+		enic->rq[0].stats.napi_repoll++;
 	}
 
 	return rq_work_done;
@@ -1683,7 +1683,7 @@ static int enic_poll_msix_wq(struct napi_struct *napi, int budget)
 	struct net_device *netdev = napi->dev;
 	struct enic *enic = netdev_priv(netdev);
 	unsigned int wq_index = (napi - &enic->napi[0]) - enic->rq_count;
-	struct vnic_wq *wq = &enic->wq[wq_index];
+	struct vnic_wq *wq = &enic->wq[wq_index].vwq;
 	unsigned int cq;
 	unsigned int intr;
 	unsigned int wq_work_to_do = ENIC_WQ_NAPI_BUDGET;
@@ -1737,7 +1737,7 @@ static int enic_poll_msix_rq(struct napi_struct *napi, int budget)
 			0 /* don't unmask intr */,
 			0 /* don't reset intr timer */);
 
-	err = vnic_rq_fill(&enic->rq[rq], enic_rq_alloc_buf);
+	err = vnic_rq_fill(&enic->rq[rq].vrq, enic_rq_alloc_buf);
 
 	/* Buffer allocation failed. Stay in polling mode
 	 * so we can try to fill the ring again.
@@ -1749,7 +1749,7 @@ static int enic_poll_msix_rq(struct napi_struct *napi, int budget)
 		/* Call the function which refreshes the intr coalescing timer
 		 * value based on the traffic.
 		 */
-		enic_calc_int_moderation(enic, &enic->rq[rq]);
+		enic_calc_int_moderation(enic, &enic->rq[rq].vrq);
 
 	if ((work_done < budget) && napi_complete_done(napi, work_done)) {
 
@@ -1758,11 +1758,11 @@ static int enic_poll_msix_rq(struct napi_struct *napi, int budget)
 		 */
 
 		if (enic->rx_coalesce_setting.use_adaptive_rx_coalesce)
-			enic_set_int_moderation(enic, &enic->rq[rq]);
+			enic_set_int_moderation(enic, &enic->rq[rq].vrq);
 		vnic_intr_unmask(&enic->intr[intr]);
-		enic->rq_stats[rq].napi_complete++;
+		enic->rq[rq].stats.napi_complete++;
 	} else {
-		enic->rq_stats[rq].napi_repoll++;
+		enic->rq[rq].stats.napi_repoll++;
 	}
 
 	return work_done;
@@ -1989,10 +1989,10 @@ static int enic_open(struct net_device *netdev)
 
 	for (i = 0; i < enic->rq_count; i++) {
 		/* enable rq before updating rq desc */
-		vnic_rq_enable(&enic->rq[i]);
-		vnic_rq_fill(&enic->rq[i], enic_rq_alloc_buf);
+		vnic_rq_enable(&enic->rq[i].vrq);
+		vnic_rq_fill(&enic->rq[i].vrq, enic_rq_alloc_buf);
 		/* Need at least one buffer on ring to get going */
-		if (vnic_rq_desc_used(&enic->rq[i]) == 0) {
+		if (vnic_rq_desc_used(&enic->rq[i].vrq) == 0) {
 			netdev_err(netdev, "Unable to alloc receive buffers\n");
 			err = -ENOMEM;
 			goto err_out_free_rq;
@@ -2000,7 +2000,7 @@ static int enic_open(struct net_device *netdev)
 	}
 
 	for (i = 0; i < enic->wq_count; i++)
-		vnic_wq_enable(&enic->wq[i]);
+		vnic_wq_enable(&enic->wq[i].vwq);
 
 	if (!enic_is_dynamic(enic) && !enic_is_sriov_vf(enic))
 		enic_dev_add_station_addr(enic);
@@ -2027,9 +2027,9 @@ static int enic_open(struct net_device *netdev)
 
 err_out_free_rq:
 	for (i = 0; i < enic->rq_count; i++) {
-		ret = vnic_rq_disable(&enic->rq[i]);
+		ret = vnic_rq_disable(&enic->rq[i].vrq);
 		if (!ret)
-			vnic_rq_clean(&enic->rq[i], enic_free_rq_buf);
+			vnic_rq_clean(&enic->rq[i].vrq, enic_free_rq_buf);
 	}
 	enic_dev_notify_unset(enic);
 err_out_free_intr:
@@ -2071,12 +2071,12 @@ static int enic_stop(struct net_device *netdev)
 		enic_dev_del_station_addr(enic);
 
 	for (i = 0; i < enic->wq_count; i++) {
-		err = vnic_wq_disable(&enic->wq[i]);
+		err = vnic_wq_disable(&enic->wq[i].vwq);
 		if (err)
 			return err;
 	}
 	for (i = 0; i < enic->rq_count; i++) {
-		err = vnic_rq_disable(&enic->rq[i]);
+		err = vnic_rq_disable(&enic->rq[i].vrq);
 		if (err)
 			return err;
 	}
@@ -2086,9 +2086,9 @@ static int enic_stop(struct net_device *netdev)
 	enic_free_intr(enic);
 
 	for (i = 0; i < enic->wq_count; i++)
-		vnic_wq_clean(&enic->wq[i], enic_free_wq_buf);
+		vnic_wq_clean(&enic->wq[i].vwq, enic_free_wq_buf);
 	for (i = 0; i < enic->rq_count; i++)
-		vnic_rq_clean(&enic->rq[i], enic_free_rq_buf);
+		vnic_rq_clean(&enic->rq[i].vrq, enic_free_rq_buf);
 	for (i = 0; i < enic->cq_count; i++)
 		vnic_cq_clean(&enic->cq[i]);
 	for (i = 0; i < enic->intr_count; i++)
@@ -2576,7 +2576,7 @@ static void enic_get_queue_stats_rx(struct net_device *dev, int idx,
 				    struct netdev_queue_stats_rx *rxs)
 {
 	struct enic *enic = netdev_priv(dev);
-	struct enic_rq_stats *rqstats = &enic->rq_stats[idx];
+	struct enic_rq_stats *rqstats = &enic->rq[idx].stats;
 
 	rxs->bytes = rqstats->bytes;
 	rxs->packets = rqstats->packets;
@@ -2590,7 +2590,7 @@ static void enic_get_queue_stats_tx(struct net_device *dev, int idx,
 				    struct netdev_queue_stats_tx *txs)
 {
 	struct enic *enic = netdev_priv(dev);
-	struct enic_wq_stats *wqstats = &enic->wq_stats[idx];
+	struct enic_wq_stats *wqstats = &enic->wq[idx].stats;
 
 	txs->bytes = wqstats->bytes;
 	txs->packets = wqstats->packets;
@@ -2993,7 +2993,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&enic->change_mtu_work, enic_change_mtu_work);
 
 	for (i = 0; i < enic->wq_count; i++)
-		spin_lock_init(&enic->wq_lock[i]);
+		spin_lock_init(&enic->wq[i].lock);
 
 	/* Register net device
 	 */
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index 1c48aebdbab0..60be09acb9fd 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -176,9 +176,9 @@ void enic_free_vnic_resources(struct enic *enic)
 	unsigned int i;
 
 	for (i = 0; i < enic->wq_count; i++)
-		vnic_wq_free(&enic->wq[i]);
+		vnic_wq_free(&enic->wq[i].vwq);
 	for (i = 0; i < enic->rq_count; i++)
-		vnic_rq_free(&enic->rq[i]);
+		vnic_rq_free(&enic->rq[i].vrq);
 	for (i = 0; i < enic->cq_count; i++)
 		vnic_cq_free(&enic->cq[i]);
 	for (i = 0; i < enic->intr_count; i++)
@@ -233,7 +233,7 @@ void enic_init_vnic_resources(struct enic *enic)
 
 	for (i = 0; i < enic->rq_count; i++) {
 		cq_index = i;
-		vnic_rq_init(&enic->rq[i],
+		vnic_rq_init(&enic->rq[i].vrq,
 			cq_index,
 			error_interrupt_enable,
 			error_interrupt_offset);
@@ -241,7 +241,7 @@ void enic_init_vnic_resources(struct enic *enic)
 
 	for (i = 0; i < enic->wq_count; i++) {
 		cq_index = enic->rq_count + i;
-		vnic_wq_init(&enic->wq[i],
+		vnic_wq_init(&enic->wq[i].vwq,
 			cq_index,
 			error_interrupt_enable,
 			error_interrupt_offset);
@@ -322,7 +322,7 @@ int enic_alloc_vnic_resources(struct enic *enic)
 	 */
 
 	for (i = 0; i < enic->wq_count; i++) {
-		err = vnic_wq_alloc(enic->vdev, &enic->wq[i], i,
+		err = vnic_wq_alloc(enic->vdev, &enic->wq[i].vwq, i,
 			enic->config.wq_desc_count,
 			sizeof(struct wq_enet_desc));
 		if (err)
@@ -330,7 +330,7 @@ int enic_alloc_vnic_resources(struct enic *enic)
 	}
 
 	for (i = 0; i < enic->rq_count; i++) {
-		err = vnic_rq_alloc(enic->vdev, &enic->rq[i], i,
+		err = vnic_rq_alloc(enic->vdev, &enic->rq[i].vrq, i,
 			enic->config.rq_desc_count,
 			sizeof(struct rq_enet_desc));
 		if (err)
-- 
2.35.2


