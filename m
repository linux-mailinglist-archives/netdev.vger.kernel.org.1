Return-Path: <netdev+bounces-207076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC747B0588E
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB1C1A62293
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442D02D839A;
	Tue, 15 Jul 2025 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HTo7qCKX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0C1FC0ED;
	Tue, 15 Jul 2025 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578076; cv=none; b=XYav3fi5yK983yk4sk9ChzqEqkTe1Tj4gsJ6J8lVhXLzDnxQakJz81Hi2GW7F6SWEfCaWJ+lyym6P7lJj+JoAjvpWVZT1evH58ZnzZKk83vFOMBtZc8ksY+4QGDKmJDocTt0We8qoR+H/pNtllW/ybzTDCW0i6eivl6Ypskk0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578076; c=relaxed/simple;
	bh=kOnxsamkJxHGeU/kH8gppKAVj7pXKQJWN0DtbvOTX+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qHYBe+NAZFq8HohskACs2BMK8pXAi58HBg72EGUtVml4kvTH6mi65Rb5iqCapc01iBkUg8muy1shObXYl9BObagNq6HmrloHU0fWc2ORLkJzGIfjwF44JZloSuQiY36TD+iptLJIgFDHsuDPSvIlh7WEwDU+GtImQYiJ8/MXFvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HTo7qCKX; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9Gic5019427;
	Tue, 15 Jul 2025 04:14:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=4hTMkXKsFSEAf63nM5ctrJU
	SP/NQnrGi0kBlkJughdQ=; b=HTo7qCKXIQHrpr0bTc0j+RU7E2UvjuB4HFUbWU4
	1vnszmdo+mmLIlaiNzI5/ajyMfpx8RUXXzQXK/zSmXM5CAxqqn8g1iQehscM/3lG
	DGFX+T/rZr8/+yTen76FJ35/e5CYQnmlOeoUilvukJb7F41hbXiDhMPJ1G/Xi98J
	dZ4sKSksSvKoochzJvzFw2vRTOowqkWd4sfEJKcw5WbRLd4A+loMuOrdJnisaUbh
	Oq4yG1G/X+ELeWI2YaAgwcMSqTnaQKXd56jW6NSgFJ/SXbXww8nEgYkAQbe+jMAz
	qTFMSzri2ynIBn2pfj49liU+vaGWnusEU1VrSDL4tggvpzA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47wajmsk6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 04:14:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Jul 2025 04:14:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Jul 2025 04:14:11 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id B3D3F5B692F;
	Tue, 15 Jul 2025 04:14:07 -0700 (PDT)
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
Subject: [net PatchV2] Octeontx2-vf: Fix max packet length errors
Date: Tue, 15 Jul 2025 16:43:51 +0530
Message-ID: <20250715111351.1440171-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEwMiBTYWx0ZWRfXw5p6TGsoH+9l dviGSsBY6IETLx/Ziv4if8PVy6yAA1jdtckoa1wbw+MT1yzgoDzYkzyaWaDX/voM2MTSfk79C4N LyuowzTZ+aK9G4RL0nNzMkD6j3gICMDNE+YdPKBkUBqIpHg6TWtTfWDs1u6Fz8X+YnWwPZMyLOX
 MF55YXIHl/6Tt1S2MkFCnAx44ytRvUqmwJzV4JgI4+ZyHZ78IrqsatMVhm34l7L7heSo4hK7ijg yqSOEy+YJW8oQPkUhgcmTB82A/xEmpa0JOgfKulfC1Jd4NmnsGj1igXtNtRa2oIoBZIH1iUWo19 Vgc5RcuSFN8GSR9D/pfUTii0oHAyTceNkrU/qGraUy4XHpszoiOYcoqBytcxPlhe+r1P9MIS1Ex
 vbZ1vTxfj+Nz8vqyp7K77YozGgd8HtngtY7udOQdetBWEK70r3K9jXFyGXlaWnfmQrSdQY1P
X-Proofpoint-GUID: vNkU5y4ncNlQf0hJ8ai3W4tYsTjAiBhh
X-Authority-Analysis: v=2.4 cv=W+c4VQWk c=1 sm=1 tr=0 ts=68763804 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=aPDGaqDItasCl3XjE_IA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: vNkU5y4ncNlQf0hJ8ai3W4tYsTjAiBhh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01

Implement packet length validation before submitting packets to
the hardware to prevent MAXLEN_ERR. Increment tx_dropped counter
on failure.

Fixes: 3184fb5ba96e ("octeontx2-vf: Virtual function driver support")
Fixes: 22f858796758 ("octeontx2-pf: Add basic net_device_ops")
Fixes: 3ca6c4c882a7 ("octeontx2-pf: Add packet transmission support")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
v2 * Add the packet length check for rep dev
     Increment tx_dropped counter on failure

 .../net/ethernet/marvell/octeontx2/nic/otx2_common.c  |  4 +++-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c  |  1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c  |  8 ++++++++
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c      | 11 ++++++++++-
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 6b5c9536d26d..c5beb6e61b56 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -139,6 +139,8 @@ void otx2_get_stats64(struct net_device *netdev,
 	struct otx2_nic *pfvf = netdev_priv(netdev);
 	struct otx2_dev_stats *dev_stats;
 
+	netdev_stats_to_stats64(stats, &netdev->stats);
+
 	otx2_get_dev_stats(pfvf);
 
 	dev_stats = &pfvf->hw.dev_stats;
@@ -149,7 +151,7 @@ void otx2_get_stats64(struct net_device *netdev,
 
 	stats->tx_bytes = dev_stats->tx_bytes;
 	stats->tx_packets = dev_stats->tx_frames;
-	stats->tx_dropped = dev_stats->tx_drops;
+	stats->tx_dropped += dev_stats->tx_drops;
 }
 EXPORT_SYMBOL(otx2_get_stats64);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index db7c466fdc39..8a93868b86bf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2165,6 +2165,7 @@ static netdev_tx_t otx2_xmit(struct sk_buff *skb, struct net_device *netdev)
 	/* Check for minimum and maximum packet length */
 	if (skb->len <= ETH_HLEN ||
 	    (!skb_shinfo(skb)->gso_size && skb->len > pf->tx_max_pktlen)) {
+		netdev->stats.tx_dropped++;
 		dev_kfree_skb(skb);
 		return NETDEV_TX_OK;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 8a8b598bd389..f9e15f389ad6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -394,6 +394,14 @@ static netdev_tx_t otx2vf_xmit(struct sk_buff *skb, struct net_device *netdev)
 	struct otx2_snd_queue *sq;
 	struct netdev_queue *txq;
 
+	/* Check for minimum and maximum packet length */
+	if (skb->len <= ETH_HLEN ||
+	    (!skb_shinfo(skb)->gso_size && skb->len > vf->tx_max_pktlen)) {
+		netdev->stats.tx_dropped++;
+		dev_kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	sq = &vf->qset.sq[qidx];
 	txq = netdev_get_tx_queue(netdev, qidx);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 2cd3da3b6843..a96545f9654e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -384,6 +384,7 @@ static void rvu_rep_get_stats64(struct net_device *dev,
 	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
 		return;
 
+	netdev_stats_to_stats64(stats, &dev->stats);
 	stats->rx_packets = rep->stats.rx_frames;
 	stats->rx_bytes = rep->stats.rx_bytes;
 	stats->rx_dropped = rep->stats.rx_drops;
@@ -391,7 +392,7 @@ static void rvu_rep_get_stats64(struct net_device *dev,
 
 	stats->tx_packets = rep->stats.tx_frames;
 	stats->tx_bytes = rep->stats.tx_bytes;
-	stats->tx_dropped = rep->stats.tx_drops;
+	stats->tx_dropped += rep->stats.tx_drops;
 
 	schedule_delayed_work(&rep->stats_wrk, msecs_to_jiffies(100));
 }
@@ -419,6 +420,14 @@ static netdev_tx_t rvu_rep_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct otx2_snd_queue *sq;
 	struct netdev_queue *txq;
 
+	/* Check for minimum and maximum packet length */
+	if (skb->len <= ETH_HLEN ||
+	    (!skb_shinfo(skb)->gso_size && skb->len > pf->tx_max_pktlen)) {
+		dev->stats.tx_dropped++;
+		dev_kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	sq = &pf->qset.sq[rep->rep_id];
 	txq = netdev_get_tx_queue(dev, 0);
 
-- 
2.34.1


