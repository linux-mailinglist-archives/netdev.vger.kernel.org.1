Return-Path: <netdev+bounces-203469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D142AF5FC6
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCA44A28E9
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF82D292B2E;
	Wed,  2 Jul 2025 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MVji59x8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE530113D
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476701; cv=none; b=gVaWJXLtOXGLRtbwX5R9/ASbBocwFAOs4nz6oBQ9+1gcv8Cn3YnEF9OFq+NWMgKjbzar6iuWAao7zH9i9coVNROI+1bx3kLXmGZK/XSPT6fdslhJTf8eYUVIwAuXtCEWfmCLnkX8x42pRGNqGS81S5iHW5HszaHK4n0NIlwzyKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476701; c=relaxed/simple;
	bh=Zt+bx+/MKHre8wJJ7p3DkKDBdghfegm0Ge+4EbVbKiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N5IWauHuiDsjwN9VwG7aGF6e3O+JF8Y4MEh6XpnFgCSzB3+eacGUsg2SHaZExgyTAtaoZUhoZINQkpn1mnwPvpaOweiu8nmGZGosltMn2HvEX7dPR5zGNtOhUwGN7Y+r81pNjBar/X23h1BdM8N+I10tXMrTcln6O0HmDRI5cEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MVji59x8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562GGrA0005007
	for <netdev@vger.kernel.org>; Wed, 2 Jul 2025 17:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1uKTPVcgL17zpQHBZ
	lGwdFuXqBt/DbZZWSsafp/wi+E=; b=MVji59x8HNPYB9dfj3XyNrmbgXvcRIbcL
	wIngqDR69c/0r4hcGrN5HINaLRUDYKxy5PSork4wjD4CJLrumefvhGzlmpQm36Lv
	DqN1flVytZz1H55IJ2xSxKIgqXxglTrCivz68OIqOBvSZi1vrz7kDorNoI7G46Vj
	pKMXHfeSTtiXFZn9QoKsZ9pGfjrFrnT5I2HTaRleozz3oiuu8Wh22emLwxPWH759
	WDbXHVUin7d5Bs5dLgKpYBvLXdvaLulYWgO5UnN3hOuDjewdLfTTjD4LOLK1ywK7
	3fG+0o1Mq0R6WISl1Qk4PMpkBVoW+E7/vHjGhdm6iveNoeG52oqkA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5ttf0p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 17:18:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 562EuBY8006904
	for <netdev@vger.kernel.org>; Wed, 2 Jul 2025 17:18:17 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxmgfdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 17:18:17 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 562HIGMU27853328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 17:18:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 716BD5805C;
	Wed,  2 Jul 2025 17:18:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B203B5805A;
	Wed,  2 Jul 2025 17:18:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.2])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Jul 2025 17:18:15 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        davemarq@linux.ibm.com, mmc@linux.ibm.com
Subject: [PATCH v2 net-next 3/4] ibmvnic: Use ndo_get_stats64 to fix inaccurate SAR reporting
Date: Wed,  2 Jul 2025 10:18:03 -0700
Message-Id: <20250702171804.86422-4-mmc@linux.ibm.com>
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
X-Proofpoint-GUID: r-O9HIy9hnVOj8K2kOP_sVltcLn7NL3v
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=686569da cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=ghiumMNqhBYHs4yLu9sA:9
X-Proofpoint-ORIG-GUID: r-O9HIy9hnVOj8K2kOP_sVltcLn7NL3v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0MiBTYWx0ZWRfX2jCDUvbl/SWU atJ/cmElhA4mOIEJTFFBMsqaPTcvOpPonLmWuxSzkoXQk076BUmSiSzCMkQ4xlGBOP6+Pw971xO ICFA6zV8lgufrseg5JgR4XhV4coliHt5Mwo2DBaJiJHJup2zIQnT1PqeWzCFId6atpXYQpi6NeJ
 +pY484LVrCnmrXzr8Zmksa/b8NdGxFPUjToCnQtpaSz+yhwlo7N1igxoEAqillpRJo3b7xU96vN 7wGc7oDBFE9bzyJPm135bSx9rAT8IMFAqJaTIuNpF/ICqBAEGk462/HpdCJxbjRBCWhK/YdHJet XueIRnlt+Eeyacy6IcXepUqpwMvrnN9GlMB2BzgYOLGtq7be468beoiOab549klJE8LLFOjtTw9
 alK21wouOH+PjIcczrsaqfXD8FoaEUc68Ef04dGUIvGh28yByLIaIHfMTvQ0HKZgNH6GLaMD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020142

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
Reviewed by: Brian King <bjking1@linux.ibm.com>
Reviewed by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 8b1c518124..9406ea06d9 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2313,8 +2313,6 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 					  tx_pool->num_buffers - 1 :
 					  tx_pool->consumer_index - 1;
 		tx_buff = &tx_pool->tx_buff[index];
-		adapter->netdev->stats.tx_packets--;
-		adapter->netdev->stats.tx_bytes -= tx_buff->skb->len;
 		atomic64_dec(&adapter->tx_stats_buffers[queue_num].batched_packets);
 		if (atomic64_sub_return(tx_buff->skb->len,
 					&adapter->tx_stats_buffers[queue_num].bytes) < 0) {
@@ -2326,9 +2324,9 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 				    atomic64_read(&adapter->tx_stats_buffers[queue_num].bytes),
 				    tx_buff->skb->len);
 		}
+		atomic64_inc(&adapter->tx_stats_buffers[queue_num].dropped_packets);
 		dev_kfree_skb_any(tx_buff->skb);
 		tx_buff->skb = NULL;
-		adapter->netdev->stats.tx_dropped++;
 	}
 
 	ind_bufp->index = 0;
@@ -2656,9 +2654,6 @@ tx_err:
 	}
 out:
 	rcu_read_unlock();
-	netdev->stats.tx_dropped += tx_dropped;
-	netdev->stats.tx_bytes += tx_bytes;
-	netdev->stats.tx_packets += tx_bpackets + tx_dpackets;
 	adapter->tx_send_failed += tx_send_failed;
 	adapter->tx_map_failed += tx_map_failed;
 	atomic64_add(tx_bpackets, &adapter->tx_stats_buffers[queue_num].batched_packets);
@@ -3461,6 +3456,25 @@ err:
 	return -ret;
 }
 
+static void ibmvnic_get_stats64(struct net_device *netdev,
+				struct rtnl_link_stats64 *stats)
+{
+	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
+	int i;
+
+	for (i = 0; i < adapter->req_rx_queues; i++) {
+		stats->rx_packets += atomic64_read(&adapter->rx_stats_buffers[i].packets);
+		stats->rx_bytes   += atomic64_read(&adapter->rx_stats_buffers[i].bytes);
+	}
+
+	for (i = 0; i < adapter->req_tx_queues; i++) {
+		stats->tx_packets += atomic64_read(&adapter->tx_stats_buffers[i].batched_packets);
+		stats->tx_packets += atomic64_read(&adapter->tx_stats_buffers[i].direct_packets);
+		stats->tx_bytes   += atomic64_read(&adapter->tx_stats_buffers[i].bytes);
+		stats->tx_dropped += atomic64_read(&adapter->tx_stats_buffers[i].dropped_packets);
+	}
+}
+
 static void ibmvnic_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct ibmvnic_adapter *adapter = netdev_priv(dev);
@@ -3576,8 +3590,6 @@ restart_poll:
 
 		length = skb->len;
 		napi_gro_receive(napi, skb); /* send it up */
-		netdev->stats.rx_packets++;
-		netdev->stats.rx_bytes += length;
 		atomic64_inc(&adapter->rx_stats_buffers[scrq_num].packets);
 		atomic64_add(length, &adapter->rx_stats_buffers[scrq_num].bytes);
 		frames_processed++;
@@ -3687,6 +3699,7 @@ static const struct net_device_ops ibmvnic_netdev_ops = {
 	.ndo_set_rx_mode	= ibmvnic_set_multi,
 	.ndo_set_mac_address	= ibmvnic_set_mac,
 	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_get_stats64	= ibmvnic_get_stats64,
 	.ndo_tx_timeout		= ibmvnic_tx_timeout,
 	.ndo_change_mtu		= ibmvnic_change_mtu,
 	.ndo_features_check     = ibmvnic_features_check,
-- 
2.39.3 (Apple Git-146)


