Return-Path: <netdev+bounces-215503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FC8B2EE2C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924597A2D88
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7273286408;
	Thu, 21 Aug 2025 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="h9brIErO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E9243374;
	Thu, 21 Aug 2025 06:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757551; cv=none; b=geOg583z9Dh5AaUlpKAs2i9vYek3zKyqRotkBBUrR4xLELQnGidMfUhDR/guHvpIVjPcCouwG6TjwhzSLZXdBNw8jhhxxkImAxjk33qMdpZor67pBMupeEL3lJ1Wpnzt6i1ieH1bCwYRMFB9gdk4Pf84KyT+GMdADRDOOLnPvMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757551; c=relaxed/simple;
	bh=BT6UtkZw4VncDF3vHkIsVNwWKvyG74pL2K93zvteJ6c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FiWWoEJ14R58GYAXdLd9o0HdyfLJm2SsPmiTUJzJb2YbVJ9VcoRGD8lIR4moQrb84FDRDG3B+V0+B0WOpdEIXvXaHMKNoEl04PLawZye9wGuwuJWdUxTIvw1zjb5ivROQwL+W7yCFAKKCKW3vvKYay3EDTdv6FSEpb9If+QBSJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=h9brIErO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L68OEq018176;
	Wed, 20 Aug 2025 23:25:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=vzvMYbfn3b4yJVgp8V2rzVy
	hZtovYpJxMv2PXHImTk4=; b=h9brIErO2zQvD49fATrVtlyJNjR5SQX8Gwm7KO5
	OxwdE+PsUrnK5MdxCOD7EkWeWjbqAnNr0kCLfYbPZnnQwdeghhYMEeQErDOWuVLK
	HxrGM0ZIcmlszeixbviBlHZhPNBzLfO/CJNuoiUmPShPMv1P9J9DdH4HYFvTrNCX
	+4ryUpNPgT38fBZeJND7UqdQPf6OilUWhorSl+6QPXMYzEpNYqxtPCq/j6tKjDtE
	3wZ5iINkvnyr+h9lU5wNQteS45JRVk2qiIOKXddpgwP2/YL/Om4oChV28zoPAa6F
	mU7LMsDdnO8CbcgGnyjtsneB2aNgUHS2UdU8wmQz8p9+efA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48nwx380w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 23:25:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 23:25:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 23:25:41 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id AE5663F708F;
	Wed, 20 Aug 2025 23:25:31 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Tomasz Duszynski
	<tduszynski@marvell.com>,
        Simon Horman <horms@kernel.org>
Subject: [net PatchV5] Octeontx2-vf: Fix max packet length errors
Date: Thu, 21 Aug 2025 11:55:28 +0530
Message-ID: <20250821062528.1697992-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YmnnbFaafeMCfs6WKyOyc8ENWJMUMXiS
X-Authority-Analysis: v=2.4 cv=JJtic8Kb c=1 sm=1 tr=0 ts=68a6bbe1 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=f3LP5gomXtjGGsWn-KkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: YmnnbFaafeMCfs6WKyOyc8ENWJMUMXiS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDA0NyBTYWx0ZWRfXzCHGYsFVz+Mf OpASQ5wTzpVpH0RyDzRJxLtCKBQ3JMDWnQKKzUddQK72fiu7AtAhjE4S8F6znGZsUAf7x9lI6Rs /hY+7PFCT43p2BNcKRu/sz86gCWWWoC5rLv5260NJ8kk1NCNFsFQhORB3QKbw7CZWAJk/t3H04D
 jgcULbXz8RfYDE1sIxR+WWTt6H0jbZvyEhusv1a4vcovUBdy5aoyTovTtkSkLiVEFQ9M8WO/4ex YKnnDeNu07MT1IewfoWITjhn6IXB1gYnzOOI+DwrEcQKXaqhIIDrmBCiDUIHnF0egkulJXzMFwH oNl7lkgLCbssOFJ4I9mIRac/VrGivX0P2A7K1A62uZ9tKQPSJcv9N6YsH+5QkghXFb9XGrzJTCu
 0c4HC/em5qCGxw87OLTsOg3Zk7BbhhsxYqgmxzNw3Z0KH5ETSYMSm3oVpsgjoS24Zv5kRVyg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_01,2025-08-20_03,2025-03-28_01

Once driver submits the packets to the hardware, each packet
traverse through multiple transmit levels in the following
order:
	SMQ -> TL4 -> TL3 -> TL2 -> TL1

The SMQ supports configurable minimum and maximum packet sizes.
It enters to a hang state, if driver submits packets with
out of bound lengths.

To avoid the same, implement packet length validation before
submitting packets to the hardware. Increment tx_dropped counter
on failure.

Fixes: 3184fb5ba96e ("octeontx2-vf: Virtual function driver support")
Fixes: 22f858796758 ("octeontx2-pf: Add basic net_device_ops")
Fixes: 3ca6c4c882a7 ("octeontx2-pf: Add packet transmission support")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
v5 * use atomic_long_t for tx_discards counter

v4 * Update commit description with hardware limitation details.

v3 * Define driver specific counter for storing dropped packets.

v2 * Add the packet length check for rep dev
     Increment tx_dropped counter on failure

 .../ethernet/marvell/octeontx2/nic/otx2_common.c    |  4 +++-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h    |  1 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c    |  3 +++
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c    | 10 ++++++++++
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c    | 13 ++++++++++++-
 drivers/net/ethernet/marvell/octeontx2/nic/rep.h    |  1 +
 6 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index f674729124e6..aff17c37ddde 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -124,7 +124,9 @@ void otx2_get_dev_stats(struct otx2_nic *pfvf)
 			       dev_stats->rx_ucast_frames;
 
 	dev_stats->tx_bytes = OTX2_GET_TX_STATS(TX_OCTS);
-	dev_stats->tx_drops = OTX2_GET_TX_STATS(TX_DROP);
+	dev_stats->tx_drops = OTX2_GET_TX_STATS(TX_DROP) +
+			       (unsigned long)atomic_long_read(&dev_stats->tx_discards);
+
 	dev_stats->tx_bcast_frames = OTX2_GET_TX_STATS(TX_BCAST);
 	dev_stats->tx_mcast_frames = OTX2_GET_TX_STATS(TX_MCAST);
 	dev_stats->tx_ucast_frames = OTX2_GET_TX_STATS(TX_UCAST);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index e3765b73c434..1c8a3c078a64 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -153,6 +153,7 @@ struct otx2_dev_stats {
 	u64 tx_bcast_frames;
 	u64 tx_mcast_frames;
 	u64 tx_drops;
+	atomic_long_t tx_discards;
 };
 
 /* Driver counted stats */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index b23585c5e5c2..5027fae0aa77 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2220,6 +2220,7 @@ static netdev_tx_t otx2_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct otx2_nic *pf = netdev_priv(netdev);
 	int qidx = skb_get_queue_mapping(skb);
+	struct otx2_dev_stats *dev_stats;
 	struct otx2_snd_queue *sq;
 	struct netdev_queue *txq;
 	int sq_idx;
@@ -2232,6 +2233,8 @@ static netdev_tx_t otx2_xmit(struct sk_buff *skb, struct net_device *netdev)
 	/* Check for minimum and maximum packet length */
 	if (skb->len <= ETH_HLEN ||
 	    (!skb_shinfo(skb)->gso_size && skb->len > pf->tx_max_pktlen)) {
+		dev_stats = &pf->hw.dev_stats;
+		atomic_long_inc(&dev_stats->tx_discards);
 		dev_kfree_skb(skb);
 		return NETDEV_TX_OK;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 5589fccd370b..7ebb6e656884 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -417,9 +417,19 @@ static netdev_tx_t otx2vf_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct otx2_nic *vf = netdev_priv(netdev);
 	int qidx = skb_get_queue_mapping(skb);
+	struct otx2_dev_stats *dev_stats;
 	struct otx2_snd_queue *sq;
 	struct netdev_queue *txq;
 
+	/* Check for minimum and maximum packet length */
+	if (skb->len <= ETH_HLEN ||
+	    (!skb_shinfo(skb)->gso_size && skb->len > vf->tx_max_pktlen)) {
+		dev_stats = &vf->hw.dev_stats;
+		atomic_long_inc(&dev_stats->tx_discards);
+		dev_kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	sq = &vf->qset.sq[qidx];
 	txq = netdev_get_tx_queue(netdev, qidx);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 25af98034e2e..b476733a0234 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -371,7 +371,8 @@ static void rvu_rep_get_stats(struct work_struct *work)
 	stats->rx_mcast_frames = rsp->rx.mcast;
 	stats->tx_bytes = rsp->tx.octs;
 	stats->tx_frames = rsp->tx.ucast + rsp->tx.bcast + rsp->tx.mcast;
-	stats->tx_drops = rsp->tx.drop;
+	stats->tx_drops = rsp->tx.drop +
+			  (unsigned long)atomic_long_read(&stats->tx_discards);
 exit:
 	mutex_unlock(&priv->mbox.lock);
 }
@@ -418,6 +419,16 @@ static netdev_tx_t rvu_rep_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct otx2_nic *pf = rep->mdev;
 	struct otx2_snd_queue *sq;
 	struct netdev_queue *txq;
+	struct rep_stats *stats;
+
+	/* Check for minimum and maximum packet length */
+	if (skb->len <= ETH_HLEN ||
+	    (!skb_shinfo(skb)->gso_size && skb->len > pf->tx_max_pktlen)) {
+		stats = &rep->stats;
+		atomic_long_inc(&stats->tx_discards);
+		dev_kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
 
 	sq = &pf->qset.sq[rep->rep_id];
 	txq = netdev_get_tx_queue(dev, 0);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
index 38446b3e4f13..5bc9e2c7d800 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
@@ -27,6 +27,7 @@ struct rep_stats {
 	u64 tx_bytes;
 	u64 tx_frames;
 	u64 tx_drops;
+	atomic_long_t tx_discards;
 };
 
 struct rep_dev {
-- 
2.34.1


