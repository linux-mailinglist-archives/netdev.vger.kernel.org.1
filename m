Return-Path: <netdev+bounces-206799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B33B04693
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 19:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F493B4A99
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADA125F997;
	Mon, 14 Jul 2025 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pqkj9dq4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02AA1C28E
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752514522; cv=none; b=GPZ/ryFKePR42/KPqzSHDWbE2LnsiSQFgsjqEo+R835sp2YVfFis8xPwaE99tb0jcfOIjsloblRql2AxL3hMyhmtxMr1Vwfx9nU9BIiAgy5cykA5p9uCFpkMr/1lwLZrxea9DfwPfWLLGhRCYyNXG+a3h+nBg2v3hOXhCIaByj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752514522; c=relaxed/simple;
	bh=89NJB1logBv2AR8YRFxbbYYNAz8Z0iTHbz6EcSlwhgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=arwfPLzxUhmdf+2/sB/zY6QDYK2WgefT4fgHQS7Qbc498gp5B1bvYM4jYkhgIg2URXEFPKtaid6I8zTvwZijQ9zs1yMIMC59xjQN9hTG+Q1FuUDuxcSKYEOYbQ65QTh3cFLbQpvMFJtrJLXI13q9T7QgJwWZ0GShOc6fze0ii5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pqkj9dq4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E86f6i012614;
	Mon, 14 Jul 2025 17:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=X8rmingojCh5VIqV/
	FARZC676S6a13BudNAfdaEx9Vs=; b=Pqkj9dq40enNhPmVjJz93MnTy3uOGRcwT
	YJ7P407gS8o8T7NTDT3dXTZP7212o9IyorFaqHHiURYsNv00NZN4G4kxc2frg/UN
	jApOf1J7mLWCPW/aPpy6bcXtSI6epacEkNc0T547Dot3a4PTt2C4gS7y3IZu4UA0
	4bcOQo6lEVb2udi2Tf6wIJ21G2XqnnVs4BEstcT+tw0jADLscQBBxfLyjnV9/3zu
	/cOVm60J+x3nSqLZImoxb5TReA/Tk9vVUUaKkxcJAxqWdiFA/A14CXU0HuhJRaby
	d2OL5+ZfaMaaJrGU3nPgJcCnjNF0n/V2+OzU5mO+7suEGydGFzmBQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc6trb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 17:35:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EFZAGq000758;
	Mon, 14 Jul 2025 17:35:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48kxmw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 17:35:16 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56EHZEJd30999168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 17:35:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7D9E58059;
	Mon, 14 Jul 2025 17:35:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D34B758055;
	Mon, 14 Jul 2025 17:35:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.243.148])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 17:35:13 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        mmc@linux.ibm.com
Subject: [PATCH v3 net-next 1/2] ibmvnic: Use atomic64_t for queue stats
Date: Mon, 14 Jul 2025 13:35:06 -0400
Message-Id: <20250714173507.73096-2-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250714173507.73096-1-mmc@linux.ibm.com>
References: <20250714173507.73096-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=68753fd5 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=5vo5R605__eMTnwomzYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEwOCBTYWx0ZWRfXzJxBg4DCZHQr D+V3lWMJVPwXArA8cp5cf54Pq0If0mEDIvooFZoilK77bkXf7vs89xeYnvvkl9WBpvBKHNeQ5ZR xHq6nrIwW/ZYYXxMHKDhsreAk9BB8uJE1g/SlFG/H4r7KHAXL4FHgs9PYJ0uqyKpzy07QTIu1OH
 aDRe+gGVzNqStAnAb/uUBjtM1x9XWzLTOx2J0tc/cWA/+576Pe2K5h7ovSwywW5bqAWhOB2V27l TptNetki92Bdi0cjBJWJ30Roq8EvE7yNuFCRKvHYkRMgztstR37yTH6HZKHZZVLQtr06NOjSGfZ /wvNtdw38hgbiFOiAGFEGZFEnvQ9yJCv//k5veqeTiLhjn/bxbmfUdiMNlj2PC8h0Q6ejFzRT/O
 8Bt5fmS3i0E75Yqz/yabTCaIIlG1kVBFLLcGDZrhSY7XuvZTElIjLMJ/nLmEfLtO7QCquN5g
X-Proofpoint-GUID: -1RO12lHMwQs_eu6TC4iwxIMF1Y1dboR
X-Proofpoint-ORIG-GUID: -1RO12lHMwQs_eu6TC4iwxIMF1Y1dboR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140108

This patch improves the ibmvnic driver by changing the per-queue
packet and byte counters to atomic64_t types. This makes updates
thread-safe and easier to manage across multiple cores.

It also updates the ethtool statistics to safely read these new counters.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Brian King <bjking1@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Reviewed by: Rick Lindsley <ricklind@linux.ibm.com>
Reviewed by: Haren Myneni <haren@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 42 ++++++++++++++++++------------
 drivers/net/ethernet/ibm/ibmvnic.h | 18 ++++++-------
 2 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 92647e137cf8..79fdba4293a4 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2314,9 +2314,17 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 		tx_buff = &tx_pool->tx_buff[index];
 		adapter->netdev->stats.tx_packets--;
 		adapter->netdev->stats.tx_bytes -= tx_buff->skb->len;
-		adapter->tx_stats_buffers[queue_num].batched_packets--;
-		adapter->tx_stats_buffers[queue_num].bytes -=
-						tx_buff->skb->len;
+		atomic64_dec(&adapter->tx_stats_buffers[queue_num].batched_packets);
+		if (atomic64_sub_return(tx_buff->skb->len,
+					&adapter->tx_stats_buffers[queue_num].bytes) < 0) {
+			atomic64_set(&adapter->tx_stats_buffers[queue_num].bytes, 0);
+			netdev_warn(adapter->netdev,
+				    "TX stats underflow on queue %u: bytes (%lld) < skb->len (%u),\n"
+				    "clamping to 0\n",
+				    queue_num,
+				    atomic64_read(&adapter->tx_stats_buffers[queue_num].bytes),
+				    tx_buff->skb->len);
+		}
 		dev_kfree_skb_any(tx_buff->skb);
 		tx_buff->skb = NULL;
 		adapter->netdev->stats.tx_dropped++;
@@ -2652,10 +2660,10 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	netdev->stats.tx_packets += tx_bpackets + tx_dpackets;
 	adapter->tx_send_failed += tx_send_failed;
 	adapter->tx_map_failed += tx_map_failed;
-	adapter->tx_stats_buffers[queue_num].batched_packets += tx_bpackets;
-	adapter->tx_stats_buffers[queue_num].direct_packets += tx_dpackets;
-	adapter->tx_stats_buffers[queue_num].bytes += tx_bytes;
-	adapter->tx_stats_buffers[queue_num].dropped_packets += tx_dropped;
+	atomic64_add(tx_bpackets, &adapter->tx_stats_buffers[queue_num].batched_packets);
+	atomic64_add(tx_dpackets, &adapter->tx_stats_buffers[queue_num].direct_packets);
+	atomic64_add(tx_bytes, &adapter->tx_stats_buffers[queue_num].bytes);
+	atomic64_add(tx_dropped, &adapter->tx_stats_buffers[queue_num].dropped_packets);
 
 	return ret;
 }
@@ -3569,8 +3577,8 @@ static int ibmvnic_poll(struct napi_struct *napi, int budget)
 		napi_gro_receive(napi, skb); /* send it up */
 		netdev->stats.rx_packets++;
 		netdev->stats.rx_bytes += length;
-		adapter->rx_stats_buffers[scrq_num].packets++;
-		adapter->rx_stats_buffers[scrq_num].bytes += length;
+		atomic64_inc(&adapter->rx_stats_buffers[scrq_num].packets);
+		atomic64_add(length, &adapter->rx_stats_buffers[scrq_num].bytes);
 		frames_processed++;
 	}
 
@@ -3874,22 +3882,22 @@ static void ibmvnic_get_ethtool_stats(struct net_device *dev,
 				      (adapter, ibmvnic_stats[i].offset));
 
 	for (j = 0; j < adapter->req_tx_queues; j++) {
-		data[i] = adapter->tx_stats_buffers[j].batched_packets;
+		data[i] = atomic64_read(&adapter->tx_stats_buffers[j].batched_packets);
 		i++;
-		data[i] = adapter->tx_stats_buffers[j].direct_packets;
+		data[i] = atomic64_read(&adapter->tx_stats_buffers[j].direct_packets);
 		i++;
-		data[i] = adapter->tx_stats_buffers[j].bytes;
+		data[i] = atomic64_read(&adapter->tx_stats_buffers[j].bytes);
 		i++;
-		data[i] = adapter->tx_stats_buffers[j].dropped_packets;
+		data[i] = atomic64_read(&adapter->tx_stats_buffers[j].dropped_packets);
 		i++;
 	}
 
 	for (j = 0; j < adapter->req_rx_queues; j++) {
-		data[i] = adapter->rx_stats_buffers[j].packets;
+		data[i] = atomic64_read(&adapter->rx_stats_buffers[j].packets);
 		i++;
-		data[i] = adapter->rx_stats_buffers[j].bytes;
+		data[i] = atomic64_read(&adapter->rx_stats_buffers[j].bytes);
 		i++;
-		data[i] = adapter->rx_stats_buffers[j].interrupts;
+		data[i] = atomic64_read(&adapter->rx_stats_buffers[j].interrupts);
 		i++;
 	}
 }
@@ -4307,7 +4315,7 @@ static irqreturn_t ibmvnic_interrupt_rx(int irq, void *instance)
 	if (unlikely(adapter->state != VNIC_OPEN))
 		return IRQ_NONE;
 
-	adapter->rx_stats_buffers[scrq->scrq_num].interrupts++;
+	atomic64_inc(&adapter->rx_stats_buffers[scrq->scrq_num].interrupts);
 
 	if (napi_schedule_prep(&adapter->napi[scrq->scrq_num])) {
 		disable_scrq_irq(adapter, scrq);
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 246ddce753f9..e574eed97cc0 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -212,23 +212,23 @@ struct ibmvnic_statistics {
 } __packed __aligned(8);
 
 struct ibmvnic_tx_queue_stats {
-	u64 batched_packets;
-	u64 direct_packets;
-	u64 bytes;
-	u64 dropped_packets;
+	atomic64_t batched_packets;
+	atomic64_t direct_packets;
+	atomic64_t bytes;
+	atomic64_t dropped_packets;
 };
 
 #define NUM_TX_STATS \
-	(sizeof(struct ibmvnic_tx_queue_stats) / sizeof(u64))
+	(sizeof(struct ibmvnic_tx_queue_stats) / sizeof(atomic64_t))
 
 struct ibmvnic_rx_queue_stats {
-	u64 packets;
-	u64 bytes;
-	u64 interrupts;
+	atomic64_t packets;
+	atomic64_t bytes;
+	atomic64_t interrupts;
 };
 
 #define NUM_RX_STATS \
-	(sizeof(struct ibmvnic_rx_queue_stats) / sizeof(u64))
+	(sizeof(struct ibmvnic_rx_queue_stats) / sizeof(atomic64_t))
 
 struct ibmvnic_acl_buffer {
 	__be32 len;
-- 
2.39.3 (Apple Git-146)


