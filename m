Return-Path: <netdev+bounces-203467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF87BAF5FC4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DEEA4A3C17
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7605B2D781E;
	Wed,  2 Jul 2025 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PtI0W1b2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8467292B2E
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476696; cv=none; b=LeUH+ci2Zgq415x1ul2ARzTKpiFE+mqzl1xq4CLmltiUzhwKG805CRkQy+NZaRZG4WeuDk87CEoBzckFhYTcpEyYpMuVQsI8ARAuaCl9xBUoP8UbqxYm7e3fzU7oy1Vn3YH07dLmi3Nn7YMNCsWUtELLFBVqWB52IiNkXb+7rYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476696; c=relaxed/simple;
	bh=QdGIIqreBo92i5OzAhDFrvuafz+DU1xikiSMoOE8MqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XPd/ZorDB5cn+GrEi6DuwQZjrBiV3MHzNPyYupQ8bz5e8crtAaS45hLdNrJy5vD07XHCtOWeXO9Ftr3cqI/H1QRrAAb5zj8kgkKAKiVB/fphGxhHmUoI8lQuu/e/uXG3u8uagbTfUEU8hl9EJyDKQTsL8YnD/qENEIOladlAO6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PtI0W1b2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562CPv3d015392
	for <netdev@vger.kernel.org>; Wed, 2 Jul 2025 17:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=K8h6dzCJz7lxeWwoW
	xd7z5DIXrhYA4fN0Exm0kZdsy8=; b=PtI0W1b2Xo4sYgi8F6yp57iE1I0oNPOsq
	ImOhnkiSZb7r6XESEciKmPGaYqU/XLyLUlJOeOj3zCu9KcI9Vbm+yTZ2fsbX4nvQ
	v6vHN57PXELzaJq1QPltM4s6ouD45JTisaTBc1kJ7wp936W5eHYysb102zKD9+oC
	If8ZHBErsEKGy/S97+90MnFDHYG8kyybt4iJbv6S8+3pag5ujXnqAYB0WpgEmgye
	AAYh5t7bkrIVti+vBybxvvPWr1OC9TAxTDppmQtpHWawL4d0Vnl6sOR+JuFRrIQ8
	ZcSdIAm5sLAgSeJB7BLKzpXsTL5Rgh/oGBQrpYpW/gcV5p1k1Yy8Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830xywm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 17:18:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 562GsKJn021084
	for <netdev@vger.kernel.org>; Wed, 2 Jul 2025 17:18:12 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jtqugujk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 17:18:12 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 562HIBtB61669884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 17:18:11 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F01558062;
	Wed,  2 Jul 2025 17:18:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C13358054;
	Wed,  2 Jul 2025 17:18:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.2])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Jul 2025 17:18:10 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        davemarq@linux.ibm.com, mmc@linux.ibm.com
Subject: [PATCH v2 net-next 1/4] ibmvnic: Use atomic64_t for queue stats
Date: Wed,  2 Jul 2025 10:18:01 -0700
Message-Id: <20250702171804.86422-2-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250702171804.86422-1-mmc@linux.ibm.com>
References: <20250702171804.86422-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ay67HFdGBcW9WWEt8RR6wZ1UObj7Y2gu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0MiBTYWx0ZWRfX1iA75gTqfg5+ QeL0ejtACFRps6v3igCmBkQ1U6oFq3cgFJqU/LGf4VoNDGM1lZLMWqDopmBOVG4cX4Vau1ytfQO B2uqtXeHgc4+V7Tt7GNDoTfJWpwRYlyg31mMY1TVbfW9a/puPg+JObUeuiJ9xU7FuDFDLBD4/11
 Ya6c1VfcHg+LDeEUy4xIJNVLAvIhAbpDk8dfKOMu5QqJAexpFl6mwEo/IU34MLXIIlghWGW5bDh MCK9+v7M4UXM8FLEhQRxqIKrggTliY5shLgoPaRbC50SL7PLxUo7oZuqC6dGGy5+oKFQ6GPmRl/ 43OVAL3XlKUm42LjaUtFd6YYjPyQaFE+cTAMwJ0NSS2cgh/CA59QypdR3riv4eWiGfUDaHGX9pA
 ocWfylqHfVJrn2tX/8zNr49rRxpXfgO2dD/g3J74ciu8bP4K81eRIYp4mUP+eCGyOj8Qn1he
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=686569d5 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=5vo5R605__eMTnwomzYA:9
X-Proofpoint-GUID: Ay67HFdGBcW9WWEt8RR6wZ1UObj7Y2gu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020142

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
 drivers/net/ethernet/ibm/ibmvnic.c | 43 ++++++++++++++++++------------
 drivers/net/ethernet/ibm/ibmvnic.h | 14 +++++-----
 2 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 92647e137c..8b1c518124 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -69,6 +69,7 @@
 #include <linux/if_vlan.h>
 #include <linux/utsname.h>
 #include <linux/cpu.h>
+#include <linux/atomic.h>
 
 #include "ibmvnic.h"
 
@@ -2314,9 +2315,17 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
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
@@ -2652,10 +2661,10 @@ out:
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
@@ -3569,8 +3578,8 @@ restart_poll:
 		napi_gro_receive(napi, skb); /* send it up */
 		netdev->stats.rx_packets++;
 		netdev->stats.rx_bytes += length;
-		adapter->rx_stats_buffers[scrq_num].packets++;
-		adapter->rx_stats_buffers[scrq_num].bytes += length;
+		atomic64_inc(&adapter->rx_stats_buffers[scrq_num].packets);
+		atomic64_add(length, &adapter->rx_stats_buffers[scrq_num].bytes);
 		frames_processed++;
 	}
 
@@ -3874,22 +3883,22 @@ static void ibmvnic_get_ethtool_stats(struct net_device *dev,
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
@@ -4307,7 +4316,7 @@ static irqreturn_t ibmvnic_interrupt_rx(int irq, void *instance)
 	if (unlikely(adapter->state != VNIC_OPEN))
 		return IRQ_NONE;
 
-	adapter->rx_stats_buffers[scrq->scrq_num].interrupts++;
+	atomic64_inc(&adapter->rx_stats_buffers[scrq->scrq_num].interrupts);
 
 	if (napi_schedule_prep(&adapter->napi[scrq->scrq_num])) {
 		disable_scrq_irq(adapter, scrq);
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index a189038d88..9b1693d817 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -213,17 +213,17 @@ struct ibmvnic_statistics {
 
 #define NUM_TX_STATS 3
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
 
 #define NUM_RX_STATS 3
 struct ibmvnic_rx_queue_stats {
-	u64 packets;
-	u64 bytes;
-	u64 interrupts;
+	atomic64_t packets;
+	atomic64_t bytes;
+	atomic64_t interrupts;
 };
 
 struct ibmvnic_acl_buffer {
-- 
2.39.3 (Apple Git-146)


