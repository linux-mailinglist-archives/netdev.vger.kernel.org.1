Return-Path: <netdev+bounces-208523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CBCB0BF81
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943863B4AC7
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 08:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891A2286D62;
	Mon, 21 Jul 2025 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HofZH/Ct"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3EE284687;
	Mon, 21 Jul 2025 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088328; cv=none; b=FACGaMVWiAtZrMDBKLMkqwvzK/WLiu6AsgsafYbbfX2NqM6IFT73ZYU/n4XtNysKPXfM4xRQp98t4Nw2RgrTMqvJJ7kCaYM8GuFbsrwjYsWC2Y8LJXtNWyMBXLBYdbX7ItVLRjGi+2vBHLmv2grC3Max1FaNiz4O0b/PssCEUXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088328; c=relaxed/simple;
	bh=t6UeY4u7JL5ZMvuvo5Ief6AALkrgXuEuINx+l0QwRhA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M/iM+Pykao62UIW5Rk8BJIx3xvBvOuguXCRyK1nhXaOHFsIlJQ6bZN8QwUSbhDiPqywk4X/GyORx55ZeTh3IyA4N/Zp7Nl2ujZVqCNgNGCrN8VDS5TK5gK94dqOmPXNfpiJVPF72KLToI2dzt/44v0jMf1dRnThQAw2wJz3I8D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HofZH/Ct; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L3Ox3I013501;
	Mon, 21 Jul 2025 01:58:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Ij3m+FfWKb3GvCthETYkRFT
	z05vr4rtLfLipjuOODcA=; b=HofZH/CtxbT8GPyXAde6ROsmO4sIrDCz6U7hP63
	LRYvsUqOBgxNMio/7Vx6TgUvqrFvD2Tj8mhiC/uiXVGDTnmJF4N/2pEyDIk72Rfb
	LInQg+X288Td8QONsMPd8n0blsiFvhMRjkFEBNmzgCFVQlWAm+7TqeAI/vtqn1E1
	4/WnC0Fygt01wK9wXwLIGI4r8pEIp72ed0R8Vxbcp49Wsit79/GrBYw/8N05fDtd
	GHanjOTomZ+oFVYB1pxNu1/IR9sKL+ZW2Hi39k0+7yj9qbLn5Hkd9tE1eQGd+YA8
	O0NAgW5bPyqjWlTBgPUF4LzWlid/NPktFlg9nsssfief7Rw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4808qq32k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 01:58:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 21 Jul 2025 01:58:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Jul 2025 01:58:31 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 6837D3F703F;
	Mon, 21 Jul 2025 01:58:24 -0700 (PDT)
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
Subject: [net PatchV3] Octeontx2-vf: Fix max packet length errors
Date: Mon, 21 Jul 2025 14:28:15 +0530
Message-ID: <20250721085815.1720485-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA3OCBTYWx0ZWRfX4MnWBFJznIsv W+V74Def4qnHJoRxmJ9tUppVxfqOFt0WrHMq3bT6XUCCprQRoTytARJ6F/WJJN1nhfh6LdIhqa6 j45nOno02B7/HRwYPa/1K84r4o+PG/7l2HCu0wUAepeO15h9UB8QokWNsey93tkyh4+mig8FKdp
 XoDB3at4jcSxVcTHxNOHT2xhQ06mmGZiRWnTcqIQkVTuAAKYW5/cAokzQN+u2vhJPbqEt1NVY3R j+G8xYQ8jpVnBjAVL9IDK2laHu1y0rudN7S8WF9Lcvehii/09EmJ3FYPFRO3zMy5lEdwOK9ZdRm 4/JY15dsboIGBlpsQZLMKtA1OEgs7I7vj1/tFLL5yelShuCiQvKQNc2jft+pwWN85UzYT6fl6d3
 O4tDfAW4hq7/X96G7eEMGEju/Xf3TSZu13O5xaCH3vwgUF2ba2fk1oOxXZ60nABJ38d1hkOw
X-Proofpoint-GUID: kI5JLaXWSGrEfvZRHRXNokWHcxNO737V
X-Proofpoint-ORIG-GUID: kI5JLaXWSGrEfvZRHRXNokWHcxNO737V
X-Authority-Analysis: v=2.4 cv=TuLmhCXh c=1 sm=1 tr=0 ts=687e0137 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=PXy8wwuK2GTSNTtyd78A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_02,2025-07-21_01,2025-03-28_01

Implement packet length validation before submitting packets to
the hardware to prevent MAXLEN_ERR. Increment tx_dropped counter
on failure.

Fixes: 3184fb5ba96e ("octeontx2-vf: Virtual function driver support")
Fixes: 22f858796758 ("octeontx2-pf: Add basic net_device_ops")
Fixes: 3ca6c4c882a7 ("octeontx2-pf: Add packet transmission support")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
v3 * Define driver specific counter for storing dropped packets

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


