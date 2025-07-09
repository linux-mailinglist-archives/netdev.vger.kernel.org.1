Return-Path: <netdev+bounces-205523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9541AFF0FE
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 20:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13A35A51C6
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F8823ABA9;
	Wed,  9 Jul 2025 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KhPdp3wv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA89023A9AB
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086472; cv=none; b=jg5jogHsgFhHDItIUWLWvFhrvfUsfZa88PZoAVsCfr4YBrms070ybm2pBH4O2paVJI7hl9fR3ssfoVSAwz6cMyfOzk/++B4ELKSqaaAIUHRkGayZssdN0QJdd08pAktPcfy9QhRZisnYZMhTKoBpvqCqwFmuZZwgTCkw9FGuT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086472; c=relaxed/simple;
	bh=NYF/wUA+27P5BT0FOAmz6/PjBJ8jVs46MKZ/MU5mOQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IloJmOMo4gtalB+2YTbPCTWYutKcP7NMkHqy1+vf0rDLOVqEEYwNeJ+LcpCQS5GBI5zkzrPIfKiKRwDSkthcwAjhgQVwlo64kmKHLPtMf4zVXA5KRUnXWSDwXuCw1Ly90Gw/MPpamkY/YkfVOI9NKxEx07P91wp+UCkzRdVHtnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KhPdp3wv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569HOGrk027403;
	Wed, 9 Jul 2025 18:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=i7XNepWE1PTv0IwuJ
	GDIC7w2ZU3n7ix1rtvNlnwTAcQ=; b=KhPdp3wvzCEFenyXlCIO0L7p74GBNORpN
	jg3lE1hZ33L6VLz/8WK9fUdkE9BhCL0C738IH4ioP2xbqnQweGoRMDYclXrAH0MB
	7qSyfZSMnGTviTClIykF3UahjF7xRAdgqCzw2VHUWwftfMRsRc8FGrUIR7YFpzjq
	cqu2W8aJ2DM54wm7U6/zMSfJBgkx+gOwsEJcF82uiOnc+MQp+bd/putUcDRnorOT
	k9yK8ZjIpvrjjDY3iFDtj+60CiJrfJtyyqS/UwMpIqfBtwoqqeGFExW0WTq9fZg7
	QFzRE93NB8DyyXrVZzIpAKbGDXKspsOvx6F3TttJPsNbv3tvBoGgQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puss86ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 18:41:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569GEZtT024277;
	Wed, 9 Jul 2025 18:41:06 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh32h9sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 18:41:06 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569IewXp27984428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 18:40:58 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BCAB5804B;
	Wed,  9 Jul 2025 18:41:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCA0858059;
	Wed,  9 Jul 2025 18:41:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.247.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 18:41:03 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        mmc@linux.ibm.com
Subject: [PATCH v3 net-next 2/2] ibmvnic: Use ndo_get_stats64 to fix inaccurate SAR reporting
Date: Wed,  9 Jul 2025 11:40:08 -0700
Message-Id: <20250709184008.8473-3-mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686eb7c3 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=WXPv24T5S-jwTN21q9UA:9
X-Proofpoint-GUID: _B_v_qLE82CmPh2FCQkcMkJZlXCAUyC_
X-Proofpoint-ORIG-GUID: _B_v_qLE82CmPh2FCQkcMkJZlXCAUyC_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2NSBTYWx0ZWRfX2Ha5bgRQumHg 6klsZvTJqAdXQksTE0f/GJh1UtO8LkIYcLTJCxrsCDsoJTGzSVgpwDPXvb75R+fXeUzUjUZyLqZ byiS348ALavuVMz710aaku1Q1hMu9RXAJqeWMQgJuI8jKFu2UkmDdnd6Egc54EHmmrCryvkIUic
 3d7od+Pta922jB9pwjiavwK94eRT2Pw2F5PaGPaJcX4klKgGPQS2d4PuWwlHOaV9KKFCV4GUaYK dZHrzWKTmbeP8n7QtS0q+PvzmLQ8y/dlo2nlZNxI2O99c6L1pt+VIfEIWsjvcaypT2eiDDRTZ4U yQs/9Orn4wuVxcvKkPmvrnRFuHjcfSvXh2HHNyQD34rLJGeJp0A39yeL0skkDmIMAGmEuvzy+N6
 a9fJxqZcyb8hWnI7sU/qXoZ30//E8mut4rpqjfaQNCtQ0vUHngHhB3SNIkmPCNgqWaX+7AFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090165

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
index 79fdba4293a4..6dd7809b1bc7 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2312,8 +2312,6 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 					  tx_pool->num_buffers - 1 :
 					  tx_pool->consumer_index - 1;
 		tx_buff = &tx_pool->tx_buff[index];
-		adapter->netdev->stats.tx_packets--;
-		adapter->netdev->stats.tx_bytes -= tx_buff->skb->len;
 		atomic64_dec(&adapter->tx_stats_buffers[queue_num].batched_packets);
 		if (atomic64_sub_return(tx_buff->skb->len,
 					&adapter->tx_stats_buffers[queue_num].bytes) < 0) {
@@ -2325,9 +2323,9 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 				    atomic64_read(&adapter->tx_stats_buffers[queue_num].bytes),
 				    tx_buff->skb->len);
 		}
+		atomic64_inc(&adapter->tx_stats_buffers[queue_num].dropped_packets);
 		dev_kfree_skb_any(tx_buff->skb);
 		tx_buff->skb = NULL;
-		adapter->netdev->stats.tx_dropped++;
 	}
 
 	ind_bufp->index = 0;
@@ -2655,9 +2653,6 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	}
 out:
 	rcu_read_unlock();
-	netdev->stats.tx_dropped += tx_dropped;
-	netdev->stats.tx_bytes += tx_bytes;
-	netdev->stats.tx_packets += tx_bpackets + tx_dpackets;
 	adapter->tx_send_failed += tx_send_failed;
 	adapter->tx_map_failed += tx_map_failed;
 	atomic64_add(tx_bpackets, &adapter->tx_stats_buffers[queue_num].batched_packets);
@@ -3460,6 +3455,25 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
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
@@ -3575,8 +3589,6 @@ static int ibmvnic_poll(struct napi_struct *napi, int budget)
 
 		length = skb->len;
 		napi_gro_receive(napi, skb); /* send it up */
-		netdev->stats.rx_packets++;
-		netdev->stats.rx_bytes += length;
 		atomic64_inc(&adapter->rx_stats_buffers[scrq_num].packets);
 		atomic64_add(length, &adapter->rx_stats_buffers[scrq_num].bytes);
 		frames_processed++;
@@ -3686,6 +3698,7 @@ static const struct net_device_ops ibmvnic_netdev_ops = {
 	.ndo_set_rx_mode	= ibmvnic_set_multi,
 	.ndo_set_mac_address	= ibmvnic_set_mac,
 	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_get_stats64	= ibmvnic_get_stats64,
 	.ndo_tx_timeout		= ibmvnic_tx_timeout,
 	.ndo_change_mtu		= ibmvnic_change_mtu,
 	.ndo_features_check     = ibmvnic_features_check,
-- 
2.39.3 (Apple Git-146)


