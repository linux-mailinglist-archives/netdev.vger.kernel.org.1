Return-Path: <netdev+bounces-209627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF70BB10151
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 09:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10146582F4C
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 07:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039142288EE;
	Thu, 24 Jul 2025 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="b7w5CnuP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81B6226CF3;
	Thu, 24 Jul 2025 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340828; cv=none; b=No4Z8QgaXy3QU69UTxJUhTdITCP1UDzMW+DQspgxHGhlxv6JvffmzDp+7JMDCNlVyJ3bv9L9x/gnvPm4zUn113pRrYNs2WSqH7nC2gPY3afvEQza6HkfUwfmkH/eMRteclu8b7sb7BcSvo4Ki0R67aUL6OgvwWx1KfBXVXyNlO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340828; c=relaxed/simple;
	bh=0PIzkE7uIu5A/VvtZ+PBwOyUXsUEf9fNI/Bd/bj+h3I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C584ooqxkH1Xy1mzmMhxGx0R/oTVoeQcavdlrsKo5pP3p/0KjWxxmRilCjy8tqZT385J8MRl8iBckuBOz+raR2HXVf+k/rpD9kgmDs06ssb61Yv4siZkj4Y/LwVrCJCX5izpFjp6IQHf0jG+d8NYc0MZvgmRJiaMND46QugaPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=b7w5CnuP; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NNVnKO001804;
	Thu, 24 Jul 2025 00:06:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=sgFLYVyTcfU8C8Hj15Ij14P
	PobslTvFoO5GKLQRH73I=; b=b7w5CnuPJevyEeNUU9hSD31ZjeGukfzQmivC9MG
	7SP5diHMhodf6MsLEtEndLUewGwFJl1qx8yJ5Jyav2+hba5B9biM5IfNQ2qcD+AV
	ghwOjliAfxfpnJSsm3XxIIZWeVYNMNVZ48GpTQ9ldLX5WKZxOx6WDMyRHjAK9aI+
	74SbRUB1jxss7siQLRoI57mKB9352rHL599z97NWgrSHoxPT71QMmUGwePT9SV7W
	fQO3eoI2pwL/2OJLSzpvxtNHPQp4RNaXrb5VtFD9mf9J2ZgSq5lSbE+cdBssgvKA
	eXZqGIyoO6q5mg1ofS41T+EXF3XwUT7LIJkRxb/8wcMnbfw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4839fgrqnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 00:06:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Jul 2025 00:06:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Jul 2025 00:06:44 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 3AA2A3F7093;
	Thu, 24 Jul 2025 00:06:38 -0700 (PDT)
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
Subject: [net PatchV4] Octeontx2-vf: Fix max packet length errors
Date: Thu, 24 Jul 2025 12:36:22 +0530
Message-ID: <20250724070623.2354509-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA0OCBTYWx0ZWRfXxFbN/bopozKD ZtmhmaoO0kbwd//rKV/0gXgR6VghitfdB7+YJ4Djeuz0KvLYDvSGKntoJc64NW7S+EBBi8/DFuD XwcRljZowXbT7QQr2ZomU5VCFRozBSr03DnDIZeICkMLszVhiZjYD4Lt1lAEawH4AENDHKvYNzg
 jYiSMahwGV4AIQPvCYGON5pZA4SypfJUK8+3WSE6kfLjCSuErhS/uR3iXF5fxKk0RhfDNKW//pZ uc3swCARlSWEP8h8Uex9KqOix+kwmrrrXzJmp8QsPPLUrRQnjaxkq4ovak5w8JROxq2Lgnzt69S 9sVVChOAeyE7kiUjts6Vewwx9NGAfAvZ8CcQkhQyTjyXjO1kErlc0XJ4Y+KW8AXkVoKyJQPfI3A
 T7vmOAr2k8ZtKxyZbOLvCToccfEnmXOV6GWHPeMraE8u7txYyWJHivMhoeIOQqy9PKTmFAhN
X-Authority-Analysis: v=2.4 cv=Na7m13D4 c=1 sm=1 tr=0 ts=6881db84 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=f3LP5gomXtjGGsWn-KkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: qiJ8AddKyCVtWeCVLFAfS1zXniZu3iYw
X-Proofpoint-ORIG-GUID: qiJ8AddKyCVtWeCVLFAfS1zXniZu3iYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01

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
v4 * Update commit description with hardware limitation details.

v3 * Define driver specific counter for storing dropped packets.

v2 * Add the packet length check for rep dev
     Increment tx_dropped counter on failure

 .../net/ethernet/marvell/octeontx2/nic/otx2_common.c |  3 ++-
 .../net/ethernet/marvell/octeontx2/nic/otx2_common.h |  1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c |  3 +++
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 10 ++++++++++
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c     | 12 +++++++++++-
 drivers/net/ethernet/marvell/octeontx2/nic/rep.h     |  1 +
 6 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 6b5c9536d26d..e480c8692baa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -124,7 +124,8 @@ void otx2_get_dev_stats(struct otx2_nic *pfvf)
 			       dev_stats->rx_ucast_frames;
 
 	dev_stats->tx_bytes = OTX2_GET_TX_STATS(TX_OCTS);
-	dev_stats->tx_drops = OTX2_GET_TX_STATS(TX_DROP);
+	dev_stats->tx_drops = OTX2_GET_TX_STATS(TX_DROP) +
+			      dev_stats->tx_discards;
 	dev_stats->tx_bcast_frames = OTX2_GET_TX_STATS(TX_BCAST);
 	dev_stats->tx_mcast_frames = OTX2_GET_TX_STATS(TX_MCAST);
 	dev_stats->tx_ucast_frames = OTX2_GET_TX_STATS(TX_UCAST);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index ca0e6ab12ceb..a58c902eb75d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -149,6 +149,7 @@ struct otx2_dev_stats {
 	u64 tx_bcast_frames;
 	u64 tx_mcast_frames;
 	u64 tx_drops;
+	u64 tx_discards;
 };
 
 /* Driver counted stats */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index db7c466fdc39..f9cf6a8f2f9b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2153,6 +2153,7 @@ static netdev_tx_t otx2_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct otx2_nic *pf = netdev_priv(netdev);
 	int qidx = skb_get_queue_mapping(skb);
+	struct otx2_dev_stats *dev_stats;
 	struct otx2_snd_queue *sq;
 	struct netdev_queue *txq;
 	int sq_idx;
@@ -2165,6 +2166,8 @@ static netdev_tx_t otx2_xmit(struct sk_buff *skb, struct net_device *netdev)
 	/* Check for minimum and maximum packet length */
 	if (skb->len <= ETH_HLEN ||
 	    (!skb_shinfo(skb)->gso_size && skb->len > pf->tx_max_pktlen)) {
+		dev_stats = &pf->hw.dev_stats;
+		dev_stats->tx_discards++;
 		dev_kfree_skb(skb);
 		return NETDEV_TX_OK;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 8a8b598bd389..3bb55e4a11d3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -391,9 +391,19 @@ static netdev_tx_t otx2vf_xmit(struct sk_buff *skb, struct net_device *netdev)
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
+		dev_stats->tx_discards++;
+		dev_kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	sq = &vf->qset.sq[qidx];
 	txq = netdev_get_tx_queue(netdev, qidx);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 2cd3da3b6843..d2412d027f6f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -371,7 +371,7 @@ static void rvu_rep_get_stats(struct work_struct *work)
 	stats->rx_mcast_frames = rsp->rx.mcast;
 	stats->tx_bytes = rsp->tx.octs;
 	stats->tx_frames = rsp->tx.ucast + rsp->tx.bcast + rsp->tx.mcast;
-	stats->tx_drops = rsp->tx.drop;
+	stats->tx_drops = rsp->tx.drop + stats->tx_discards;
 exit:
 	mutex_unlock(&priv->mbox.lock);
 }
@@ -418,6 +418,16 @@ static netdev_tx_t rvu_rep_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct otx2_nic *pf = rep->mdev;
 	struct otx2_snd_queue *sq;
 	struct netdev_queue *txq;
+	struct rep_stats *stats;
+
+	/* Check for minimum and maximum packet length */
+	if (skb->len <= ETH_HLEN ||
+	    (!skb_shinfo(skb)->gso_size && skb->len > pf->tx_max_pktlen)) {
+		stats = &rep->stats;
+		stats->tx_discards++;
+		dev_kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
 
 	sq = &pf->qset.sq[rep->rep_id];
 	txq = netdev_get_tx_queue(dev, 0);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
index 38446b3e4f13..277615ed7174 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
@@ -27,6 +27,7 @@ struct rep_stats {
 	u64 tx_bytes;
 	u64 tx_frames;
 	u64 tx_drops;
+	u64 tx_discards;
 };
 
 struct rep_dev {
-- 
2.34.1


