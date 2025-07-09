Return-Path: <netdev+bounces-205522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3668DAFF0FC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 20:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770135A509F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18592239E66;
	Wed,  9 Jul 2025 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hzPlv6BV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700B419E806
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086469; cv=none; b=I7fuUMIXmpkO6W9smFPY4Ev4FDYYSrvmBn7IBxJoaY/6ZLhIOPrfJuA6wF3/oH0OcKGLIPEhgY2nIN6+hMz2ZdeUQSmOODKjRxyNLkdqLEYnN5okCKPM7uXTP1CwwymMqgNPWEfok6jPwSN+iTbyfdEsxWvYVOdapGL2+xKTrWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086469; c=relaxed/simple;
	bh=89NJB1logBv2AR8YRFxbbYYNAz8Z0iTHbz6EcSlwhgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wf8Rn/DchKxamRFriw6LbMVZKn3ZGqJMzgzlTFX3Apo3KxKHGNZGtGYJufrmIVaExJJlptNMvr2lTr4B/Nqj3/uVEEJGlb6sMMAcCMXeJLHMIwlR398lAfJWP5WTOlPdLCGb1XJ0miD7QbCiJytKc9umLzF6ayLL4wxmnhpMb/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hzPlv6BV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569HrdQs005946;
	Wed, 9 Jul 2025 18:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=X8rmingojCh5VIqV/
	FARZC676S6a13BudNAfdaEx9Vs=; b=hzPlv6BVLQu0iMaGuxw0NxIoUvOYV3eGK
	s4/QOcqj78hJgLcnt+a4ff05qK8J9YTJuAfWiYT02HXE3iqjY+fnr5yolyIyCGpw
	PWKRAFEG5w1cZUOr7s80azLUFTMR7SDgW8H8mehYD9DHkMsPXaZ7fHu8UWjENqpF
	lxxY3dGT1v4Y1vdfK60ex8zsbJuBSLNCHlfTvbkEzOQXe+tz9M2DaM472jkDC2TY
	swJ4suggypTMYcsF6lPKZ5dgt7wobqGb2N1oZHmgHCdQLYykWwpeWnS+zhFkzAEs
	wPqZ3dl9eltwyfefT1H7Gp9U9e3vwjfz8ihaP1hNMm9aPB4f0sdHg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur783t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 18:41:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569FYOkb003123;
	Wed, 9 Jul 2025 18:41:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmhfmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 18:41:03 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569If11L21168894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 18:41:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B2F658059;
	Wed,  9 Jul 2025 18:41:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9E9A5804B;
	Wed,  9 Jul 2025 18:41:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.247.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 18:41:00 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        mmc@linux.ibm.com
Subject: [PATCH v3 net-next 1/2] ibmvnic: Use atomic64_t for queue stats
Date: Wed,  9 Jul 2025 11:40:07 -0700
Message-Id: <20250709184008.8473-2-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250709184008.8473-1-mmc@linux.ibm.com>
References: <20250709184008.8473-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2NSBTYWx0ZWRfX9OZJ1J3RbJI4 7x41CUlcZsqAYBqY3SCpiGJz/gZhsVlxNYEZnAZ2dCJU0LSqGhl7z5fTVA0P1Pza3C+Z6Wy8EOo 9dgNGm9iDu7lQ4J3isiQqf1I6m7Cfzye2Bn0NS3KZ2X4ytS552m5LXfyvjJOzBv646NWtlsXlQQ
 HZL4hL/Flu+cPbl+yV8iUvr7cRKM2BtvsFZlA5rzXwhXwTOnlWaG89hI2e0D5dosR/aU8Cq7ept VAHMiuQC3mgHyGYbht8y5Hs2oCa1U3wIY/qUJXHuy7O9WlEsn2R/YBuYAevYkrK6u1faXmymqIr BBKmaQ6aSJOPyJf1nDm3J3+ZJQT2WcYF2cvDzehg5nN6XI6MfObhUlNNkK4NdsIVq2/kXZtx/ZJ
 sfxWLf22KRK6AGFypOLyGu1NfggcHpXsf52XoZlHp7G/A87aRF65uIGV5R/qQxEGA2uMo/l6
X-Proofpoint-GUID: Ho8pQLhbEtt8gju6TbLVB9Sr4Qe8KxXI
X-Proofpoint-ORIG-GUID: Ho8pQLhbEtt8gju6TbLVB9Sr4Qe8KxXI
X-Authority-Analysis: v=2.4 cv=W/M4VQWk c=1 sm=1 tr=0 ts=686eb7c0 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=5vo5R605__eMTnwomzYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090165

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


