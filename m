Return-Path: <netdev+bounces-130958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 091D098C382
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4CAB21812
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6912B1C9ECE;
	Tue,  1 Oct 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mFBMszQ2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A696E1C9DCD
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800548; cv=none; b=UW0GdPGxnxSXVg/Bpu4Bf7SjdCHo0uCquaUGmTgdF3s+vIqAi2NcAre2YPUKdiWRE7IJ0kmotJE4uHx4ZnqKiZESAbEe8qWHq1Ln2L8w/n3IaX0FI/M8hujwiSpLBqoIAItxdJvPtN3TFRw8KIpBxZP1HzhNISaa2hioufa62Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800548; c=relaxed/simple;
	bh=5vHMfHp+yek3UnbzkpearqPDUw1Lgj1TwQOy0xsZFFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxzhOHGrDRjZOUZX0VPCUclTkUjAhyKYAIvhu0BEWSX4bCXkbsNiUEwR/jihPy7Rp2KwD7vkE3jk5Dpjp3aNYkc6/cbyfLqAt3s4rJFe4pVxxe0u1ltD091SqS7K/vCLvVUTXaopF/leCb3sOLnvLlSaX0wA1BDAcR5Qh2+ILsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mFBMszQ2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491GLSls013996;
	Tue, 1 Oct 2024 16:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=AHgxL6/NDjgLLdCxYq0mQvJ7JEh2OPIWQkEveU8
	PEqI=; b=mFBMszQ2m5ZAbpcCzuylSKT8J1XNQEA+N7wr/CwNfLRDeJyaUekzke8
	OGKzzrEODejS4lCdW6GWRDeX7ALIA7kpZEXtMNDysXVZ9zacK3nyKsNtnG9/NVV/
	H16gR/91JqhVQbYJV8RttnKCl3w8cLRoweHEj6mJP842vfpEl4N2Kn7FinmgZR8R
	1aBJzNbC20OEmE9tiuVo+gDiuuxQGv03mtzJPlZjK/M2PNtzFN5654JUd//nnid2
	hfxXKqU8fZLAGyxNLAn/iS4psRl1dmhy8EB6yTgXKQLjGUZHQXYPoNv3y3u/CQWM
	2bd0S1IiSu7aO7X66WuDSxqZXtepa8w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420mhfg2kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 16:35:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491EoUW1020424;
	Tue, 1 Oct 2024 16:35:42 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xv4s5r5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 16:35:42 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491GZddN43450838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 16:35:40 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D464158059;
	Tue,  1 Oct 2024 16:35:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7924858055;
	Tue,  1 Oct 2024 16:35:39 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.141.187])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 16:35:39 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v2] ibmvnic: Add stat for tx direct vs tx batched
Date: Tue,  1 Oct 2024 11:35:31 -0500
Message-ID: <20241001163531.1803152-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ULtC-t91YhWdXYTxRjcj1uHW-x2FvYME
X-Proofpoint-ORIG-GUID: ULtC-t91YhWdXYTxRjcj1uHW-x2FvYME
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_13,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 mlxlogscore=695
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010106

Allow tracking of packets sent with send_subcrq direct vs
indirect. `ethtool -S <dev>` will now provide a counter
of the number of uses of each xmit method. This metric will
be useful in performance debugging.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
Thanks Simon for review of v1 [1]
Changes in v2:
 - move this patch to net-next instead of net 
1 - https://lore.kernel.org/netdev/20240930175635.1670111-1-nnac123@linux.ibm.com/

 drivers/net/ethernet/ibm/ibmvnic.c | 23 ++++++++++++++++-------
 drivers/net/ethernet/ibm/ibmvnic.h |  3 ++-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 87e693a81433..53b309ddc63b 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2310,7 +2310,7 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 		tx_buff = &tx_pool->tx_buff[index];
 		adapter->netdev->stats.tx_packets--;
 		adapter->netdev->stats.tx_bytes -= tx_buff->skb->len;
-		adapter->tx_stats_buffers[queue_num].packets--;
+		adapter->tx_stats_buffers[queue_num].batched_packets--;
 		adapter->tx_stats_buffers[queue_num].bytes -=
 						tx_buff->skb->len;
 		dev_kfree_skb_any(tx_buff->skb);
@@ -2402,7 +2402,8 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	unsigned int tx_map_failed = 0;
 	union sub_crq indir_arr[16];
 	unsigned int tx_dropped = 0;
-	unsigned int tx_packets = 0;
+	unsigned int tx_dpackets = 0;
+	unsigned int tx_bpackets = 0;
 	unsigned int tx_bytes = 0;
 	dma_addr_t data_dma_addr;
 	struct netdev_queue *txq;
@@ -2573,6 +2574,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		if (lpar_rc != H_SUCCESS)
 			goto tx_err;
 
+		tx_dpackets++;
 		goto early_exit;
 	}
 
@@ -2601,6 +2603,8 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 			goto tx_err;
 	}
 
+	tx_bpackets++;
+
 early_exit:
 	if (atomic_add_return(num_entries, &tx_scrq->used)
 					>= adapter->req_tx_entries_per_subcrq) {
@@ -2608,7 +2612,6 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		netif_stop_subqueue(netdev, queue_num);
 	}
 
-	tx_packets++;
 	tx_bytes += skb->len;
 	txq_trans_cond_update(txq);
 	ret = NETDEV_TX_OK;
@@ -2638,10 +2641,11 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	rcu_read_unlock();
 	netdev->stats.tx_dropped += tx_dropped;
 	netdev->stats.tx_bytes += tx_bytes;
-	netdev->stats.tx_packets += tx_packets;
+	netdev->stats.tx_packets += tx_bpackets + tx_dpackets;
 	adapter->tx_send_failed += tx_send_failed;
 	adapter->tx_map_failed += tx_map_failed;
-	adapter->tx_stats_buffers[queue_num].packets += tx_packets;
+	adapter->tx_stats_buffers[queue_num].batched_packets += tx_bpackets;
+	adapter->tx_stats_buffers[queue_num].direct_packets += tx_dpackets;
 	adapter->tx_stats_buffers[queue_num].bytes += tx_bytes;
 	adapter->tx_stats_buffers[queue_num].dropped_packets += tx_dropped;
 
@@ -3806,7 +3810,10 @@ static void ibmvnic_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 		memcpy(data, ibmvnic_stats[i].name, ETH_GSTRING_LEN);
 
 	for (i = 0; i < adapter->req_tx_queues; i++) {
-		snprintf(data, ETH_GSTRING_LEN, "tx%d_packets", i);
+		snprintf(data, ETH_GSTRING_LEN, "tx%d_batched_packets", i);
+		data += ETH_GSTRING_LEN;
+
+		snprintf(data, ETH_GSTRING_LEN, "tx%d_direct_packets", i);
 		data += ETH_GSTRING_LEN;
 
 		snprintf(data, ETH_GSTRING_LEN, "tx%d_bytes", i);
@@ -3871,7 +3878,9 @@ static void ibmvnic_get_ethtool_stats(struct net_device *dev,
 				      (adapter, ibmvnic_stats[i].offset));
 
 	for (j = 0; j < adapter->req_tx_queues; j++) {
-		data[i] = adapter->tx_stats_buffers[j].packets;
+		data[i] = adapter->tx_stats_buffers[j].batched_packets;
+		i++;
+		data[i] = adapter->tx_stats_buffers[j].direct_packets;
 		i++;
 		data[i] = adapter->tx_stats_buffers[j].bytes;
 		i++;
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 94ac36b1408b..a189038d88df 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -213,7 +213,8 @@ struct ibmvnic_statistics {
 
 #define NUM_TX_STATS 3
 struct ibmvnic_tx_queue_stats {
-	u64 packets;
+	u64 batched_packets;
+	u64 direct_packets;
 	u64 bytes;
 	u64 dropped_packets;
 };
-- 
2.43.5


