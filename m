Return-Path: <netdev+bounces-207509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1623B079A2
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 17:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E117502844
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2B22F5C53;
	Wed, 16 Jul 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aGkrjLP9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160732F50AC
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679287; cv=none; b=LxsmLeKzPz52KykDiXIOsITq7xK0WC1bgd41qgAi2jJxcBTlb0H1LcV4s3GvYxL3rvCzJOBy3Yw8Eol1k+EpYD2q4GAFMznzz5oqRG6qWmdgQmdvdOH/bsHPpftLPSCliS/XYcvC1CuJdsJo3FJxMudgdlaw5tOUclvsQKMH/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679287; c=relaxed/simple;
	bh=PDDuE/01z7uZiohT0yhL4f5s1HHKre9ORRNYL772QEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WEwlzh7/Lqs3XucX4BX3BZMyR0Tc0y3Tzh6LzS1y6qjH4NqsWiY7kpzVIHqb3YaC13Z5Mbc6kQGXY3cyDTIY0glYh0lUQu3gEn7o9iDikSsb52s2n9g5l7rKVFH8hJHJ42W9Yn0bPHxt+cvDJGrWRfIvHIhAsXpurePyanXqlM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aGkrjLP9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GDIPl7014755;
	Wed, 16 Jul 2025 15:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BfB0bJ6pYsqo76+PG1c3NWYGcCPo6TIyqKFk0lkT3
	gY=; b=aGkrjLP9Tr9UT7Jon5ouMaBYcUTmkM83Mh6NKakMubv2ASwDk1IE6ugCt
	4pHmDKnn9LZQtBtonw+omKNlhIf9SP5LfnjaGdxis3lYf441K5/9pMGSHEJqR1Pi
	+83Jb7yE/xbwGEZAB999oRg+C3dF8PIy3FsaJb85JeUAWvQ28TGt7TE1u5vrNJnp
	mhMYd9T5vR4h3jzsnN4JgF+pcXTX0FmJDjxsFZqDv4++X0HkFu/FN9+EaadSqs9S
	gBcuF95IAJBMxhS+M+Cq7L03XFMKKgL4W8Zh3Txxm3pE89hz/mSuTDgk9xXqHYxU
	7lgJ631GMEt+rQNjx5V6YbfisaTWg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4u5t50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 15:21:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCFDWK000758;
	Wed, 16 Jul 2025 15:21:20 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48m7pkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 15:21:20 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56GFLJiK10158658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 15:21:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 500AC58061;
	Wed, 16 Jul 2025 15:21:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE9C258058;
	Wed, 16 Jul 2025 15:21:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.241.202])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Jul 2025 15:21:18 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        mmc@linux.ibm.com
Subject: [PATCH net-next v4] ibmvnic: Use ndo_get_stats64 to fix inaccurate SAR reporting
Date: Wed, 16 Jul 2025 11:21:15 -0400
Message-Id: <20250716152115.61143-1-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=6877c371 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=OLL_FvSJAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ghiumMNqhBYHs4yLu9sA:9 a=CKu1xEVsSJoA:10
 a=7tqFqJQpia0A:10 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-GUID: U_LIkjt138weqOE4vVSZppXtxJ-uPzQ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOCBTYWx0ZWRfXwAcMo81iUBGp TbzIwDp2vfiPARdj36J0QmjHphYYT2dzzrYT7vsymY5sBJ1qxEql7i5rEhP319xzcsezkaONEax jlkmvhfvuJyMH4uXaS4Nb5M7q6xBhSSb9bExsxdjeh3D3m6QqylCBNf/v/4H/n/pKjccr6llgAO
 hANuCk9bunwuqDntMmOP3yXCIZ3qMqilQd36wHUWwX3ht1MkPJv2w3ZqiFwJWp04Gj/Xph3wFWZ VOVcOgm5gDWeTG/BnODFmd5+R6+40aVpdPfPCLoqKpK/QhoDSc2Pm5XW8/wGjHLI4yuOclTZuOV DzM35rzwjzpbWHW8KkizOQWnzqalvgKUA4aMi4OTPRwrgrmsBPrxnZ6ZuXKW+qUvHDjcRhxIVPh
 X1UmEkDwHhmkIN92L81H6JsVC7Rge/yN5ji4u1WTC5KJPDfXO2TczbSn2Jnc/bdWSEdOj/dD
X-Proofpoint-ORIG-GUID: U_LIkjt138weqOE4vVSZppXtxJ-uPzQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160138

VNIC testing on multi-core Power systems showed SAR stats drift
and packet rate inconsistencies under load.

Implements ndo_get_stats64 to provide safe aggregation of queue-level
atomic64 counters into rtnl_link_stats64 for use by tools like 'ip -s',
'ifconfig', and 'sar'. Switch to ndo_get_stats64 to align SAR reporting
with the standard kernel interface for retrieving netdev stats.

This removes redundant per-adapter stat updates, reduces overhead,
eliminates cacheline bouncing from hot path updates, and improves
the accuracy of reported packet rates.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Brian King <bjking1@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>

----
Changes since v3:
link to v3: https://www.spinics.net/lists/netdev/msg1107999.html
-- keep per queue counters as u64 (this patch) and drop off patch 1 in v3
---
 drivers/net/ethernet/ibm/ibmvnic.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 92647e137cf8..eec971567aac 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2312,8 +2312,6 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 					  tx_pool->num_buffers - 1 :
 					  tx_pool->consumer_index - 1;
 		tx_buff = &tx_pool->tx_buff[index];
-		adapter->netdev->stats.tx_packets--;
-		adapter->netdev->stats.tx_bytes -= tx_buff->skb->len;
 		adapter->tx_stats_buffers[queue_num].batched_packets--;
 		adapter->tx_stats_buffers[queue_num].bytes -=
 						tx_buff->skb->len;
@@ -2647,9 +2645,6 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	}
 out:
 	rcu_read_unlock();
-	netdev->stats.tx_dropped += tx_dropped;
-	netdev->stats.tx_bytes += tx_bytes;
-	netdev->stats.tx_packets += tx_bpackets + tx_dpackets;
 	adapter->tx_send_failed += tx_send_failed;
 	adapter->tx_map_failed += tx_map_failed;
 	adapter->tx_stats_buffers[queue_num].batched_packets += tx_bpackets;
@@ -3452,6 +3447,25 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 	return -ret;
 }
 
+static void ibmvnic_get_stats64(struct net_device *netdev,
+				struct rtnl_link_stats64 *stats)
+{
+	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
+	int i;
+
+	for (i = 0; i < adapter->req_rx_queues; i++) {
+		stats->rx_packets += adapter->rx_stats_buffers[i].packets;
+		stats->rx_bytes   += adapter->rx_stats_buffers[i].bytes;
+	}
+
+	for (i = 0; i < adapter->req_tx_queues; i++) {
+		stats->tx_packets += adapter->tx_stats_buffers[i].batched_packets;
+		stats->tx_packets += adapter->tx_stats_buffers[i].direct_packets;
+		stats->tx_bytes   += adapter->tx_stats_buffers[i].bytes;
+		stats->tx_dropped += adapter->tx_stats_buffers[i].dropped_packets;
+	}
+}
+
 static void ibmvnic_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct ibmvnic_adapter *adapter = netdev_priv(dev);
@@ -3567,8 +3581,6 @@ static int ibmvnic_poll(struct napi_struct *napi, int budget)
 
 		length = skb->len;
 		napi_gro_receive(napi, skb); /* send it up */
-		netdev->stats.rx_packets++;
-		netdev->stats.rx_bytes += length;
 		adapter->rx_stats_buffers[scrq_num].packets++;
 		adapter->rx_stats_buffers[scrq_num].bytes += length;
 		frames_processed++;
@@ -3678,6 +3690,7 @@ static const struct net_device_ops ibmvnic_netdev_ops = {
 	.ndo_set_rx_mode	= ibmvnic_set_multi,
 	.ndo_set_mac_address	= ibmvnic_set_mac,
 	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_get_stats64	= ibmvnic_get_stats64,
 	.ndo_tx_timeout		= ibmvnic_tx_timeout,
 	.ndo_change_mtu		= ibmvnic_change_mtu,
 	.ndo_features_check     = ibmvnic_features_check,
-- 
2.39.3 (Apple Git-146)


