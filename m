Return-Path: <netdev+bounces-202695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4E0AEEB07
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1230F1BC3C02
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 23:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF34923F43C;
	Mon, 30 Jun 2025 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nSTlZv6N"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA82258CD4
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751327300; cv=none; b=ABGPfI3trjPJqw42p0VtMpx3Y7+aA7jtPmqFpVT4rGE7Z7G9nj2Yp5yEvI7LsHLsi75jjxg3NuagXU4T/cvNHuWkGQACsuLnLad+vYkHag/STIN8zpZOdNGBtg2+MsB/KOtHusBvqsna2B2f6OPqzmn/j9cyCGzE+43IMA5R1Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751327300; c=relaxed/simple;
	bh=OtSICl8sCeS42dQVhpmNHJZoCz+aYtuxKQDZENokLI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u5jCAdNMUghRW8C08x5HgDpbdyA/ALINe66Ou6ABc1wr+pj2+QL8K+Id/LVjF6fbYkAaWbCqTf0w8c9LySRW5aO50H2KwVJxWRfr7UtJhYJwvOfws3sjGZwgRxV4LF7YQNKSa6qGWG7aUnFTEq1+mZ+oExNHAPSFP0jBnqcxbcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nSTlZv6N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UJhxeD008074
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9gjxAHh/xyAifyTbi
	tfxdKS+w2bnnXoWdmCl+EKqqvc=; b=nSTlZv6NDg8UI1L/Dsa/Pvvrj625MKEkR
	gV5ERq3p1wRH5zQAh1DjgKwtkSQCP2lxbNWp9j0m0xhj9RvtMIE1p5gFgtZrkJxj
	PDPAKcfL4dCM5bwzqpRUrx1q8y3f6y1UV8FYOl3clvasJaYatJuFio/xqSHhTnI0
	zAygB5Qrtm+e/FAZKQISDZ1Rr+kEOCZokJF4M41H/AWyvZv0oez/RmaRXZh8+xLu
	nQ0ZFbeYVtCvvAch+TB8JBbwrSwoxnC1GkLBwS/w8/zGdJ7lzBGlwEtnHPHc2IrR
	Tm1X+kwCB+XG6JsoenLjhV5btNyLw5DCkCtc8s1nTjrA0xVIUxplw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrcaxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55UJqsjH021430
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:16 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jwe37ud4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:16 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55UNmFkx524860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 23:48:15 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8EBD58059;
	Mon, 30 Jun 2025 23:48:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3566758058;
	Mon, 30 Jun 2025 23:48:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.36])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 23:48:14 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        mmc@linux.ibm.com, Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next 2/4] ibmvnic: Use atomic64_t for queue stats
Date: Mon, 30 Jun 2025 16:48:04 -0700
Message-Id: <20250630234806.10885-3-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250630234806.10885-1-mmc@linux.ibm.com>
References: <20250630234806.10885-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E/PNpbdl c=1 sm=1 tr=0 ts=68632241 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=5vo5R605__eMTnwomzYA:9
X-Proofpoint-GUID: wfv4-KS8-Fph_moIMZuALJBP9DDLWnNm
X-Proofpoint-ORIG-GUID: wfv4-KS8-Fph_moIMZuALJBP9DDLWnNm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE5NiBTYWx0ZWRfXyc5rMHBxSQQl f/+gTWNMsFy1xEg9uhZjc5ZHPhuOPwMp0i2248gxNQoRXMie0wPvx4+XpSXECIpAx/XzcChp/VC 6heHz6mJmDwANHTSIgYy4BNq+f/wbpXvopR2xtp0bHtBUDt1kBEb2v5t798Y/EjOFxGcbdoWF9N
 cEEnmvkdOt9wGj//EQBc2brHGCXEg6C+50uKVBiu7Rhmwhvc3WYcI20PIzgrIDMjoZh/w47iAl3 WYjLcHU+HYljDDhGSJEMn8m2nRvq3aKwThE5Ciyq0SXpjQNJtftXAySxrwiMMjtJRDcd3humQa3 CmumdWewXJNIy9qVOaLTXaWjKIFK7XZDlZqWwllVhpoILZ++OoKajIsmSXOYvn2hmNGwCD0g6SR
 uBGPJMGSbCEhHVbL0MUfXrRVjkGs2BAciB0s4wrgrj5dEcfJ5cRMOeirWdNEvZKuOgJCl/UT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_06,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300196

This patch improves the ibmvnic driver by changing the per-queue
packet and byte counters to atomic64_t types. This makes updates
thread-safe and easier to manage across multiple cores.

It also updates the ethtool statistics to safely read these new counters.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Brian King <bjking1@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Reviewed by: Rick Lindsley <ricklind@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 34 +++++++++++++++---------------
 drivers/net/ethernet/ibm/ibmvnic.h | 14 ++++++------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 92647e137c..7b2be8eeb5 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -69,6 +69,7 @@
 #include <linux/if_vlan.h>
 #include <linux/utsname.h>
 #include <linux/cpu.h>
+#include <linux/atomic.h>
 
 #include "ibmvnic.h"
 
@@ -2314,9 +2315,8 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 		tx_buff = &tx_pool->tx_buff[index];
 		adapter->netdev->stats.tx_packets--;
 		adapter->netdev->stats.tx_bytes -= tx_buff->skb->len;
-		adapter->tx_stats_buffers[queue_num].batched_packets--;
-		adapter->tx_stats_buffers[queue_num].bytes -=
-						tx_buff->skb->len;
+		atomic64_dec(&adapter->tx_stats_buffers[queue_num].batched_packets);
+		atomic64_sub(tx_buff->skb->len, &adapter->tx_stats_buffers[queue_num].bytes);
 		dev_kfree_skb_any(tx_buff->skb);
 		tx_buff->skb = NULL;
 		adapter->netdev->stats.tx_dropped++;
@@ -2652,10 +2652,10 @@ out:
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
@@ -3569,8 +3569,8 @@ restart_poll:
 		napi_gro_receive(napi, skb); /* send it up */
 		netdev->stats.rx_packets++;
 		netdev->stats.rx_bytes += length;
-		adapter->rx_stats_buffers[scrq_num].packets++;
-		adapter->rx_stats_buffers[scrq_num].bytes += length;
+		atomic64_inc(&adapter->rx_stats_buffers[scrq_num].packets);
+		atomic64_add(length, &adapter->rx_stats_buffers[scrq_num].bytes);
 		frames_processed++;
 	}
 
@@ -3874,22 +3874,22 @@ static void ibmvnic_get_ethtool_stats(struct net_device *dev,
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
@@ -4307,7 +4307,7 @@ static irqreturn_t ibmvnic_interrupt_rx(int irq, void *instance)
 	if (unlikely(adapter->state != VNIC_OPEN))
 		return IRQ_NONE;
 
-	adapter->rx_stats_buffers[scrq->scrq_num].interrupts++;
+	atomic64_inc(&adapter->rx_stats_buffers[scrq->scrq_num].interrupts);
 
 	if (napi_schedule_prep(&adapter->napi[scrq->scrq_num])) {
 		disable_scrq_irq(adapter, scrq);
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 246ddce753..1cc6e2d13a 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -212,19 +212,19 @@ struct ibmvnic_statistics {
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
 	(sizeof(struct ibmvnic_tx_queue_stats) / sizeof(u64))
 
 struct ibmvnic_rx_queue_stats {
-	u64 packets;
-	u64 bytes;
-	u64 interrupts;
+	atomic64_t packets;
+	atomic64_t bytes;
+	atomic64_t interrupts;
 };
 
 #define NUM_RX_STATS \
-- 
2.39.3 (Apple Git-146)


