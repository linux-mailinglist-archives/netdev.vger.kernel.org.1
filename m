Return-Path: <netdev+bounces-202696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F66AEEB08
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B975344083A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 23:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B7525A2A2;
	Mon, 30 Jun 2025 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FKywpvIc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0CB20F07C
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751327302; cv=none; b=gPnLkO1s2Y15f1SoULwfzbHTqa4C9v3VELr1liHd2mwp9kfmtFxig7HthE5FmyLZwNv/KCIXBgLaQzg48POTbyZImTsJAq1q6r4JCRbrr5s8cNgN4s+H2yp3xA5BBWOK6fJmyWLEwJIZfHdhytFczpwLBN2i93Mao01lH9Raga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751327302; c=relaxed/simple;
	bh=pl0lTeuqfn0jX9MQFyAL9hyVcan65BfbBb0njSAOGso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rwfndt6eM87bXtmjQ1BIt5v+cz2dBuKCYQTClRQ2nAySyj5MUMZxcWfLBg0TYef3pDKpmU1jdaovXJ2FgEXzYyZQmd/iAfa2LOcquD6KnR/Vj4WnVhE24jctf4uiICQW6ndE2boeIu3P2MkpYbUPQ+QeiclSgIvcWhok8FcNfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FKywpvIc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UDgKMA000747
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=W0x/HeIhyjh7GW+up
	bzBDs/qraxsEB0BXQf/EzAwWFM=; b=FKywpvIcNrXi5aU5ztyMMDEMjI6fk+xUP
	2W9NsaeIJBmIydHdXMgwNBm/hsD3sZq3zIC1aAW4a4FKauWEQCUK2vaunqb0ACXj
	0K2e6+L70gFybbqmQ6YCH9UyjosrV72GyJsOjBW7XEcOmHM0/zimk+ZrvgEdznU9
	Uklmah7VuYT1zZtiaEU43xVf+CuW9v7Wfv5pOViCzMvD28EaTdUiq4NvowOPnPop
	J1mrC22/NQNojck4EvcQiO5mD++MLe6GhlulxFMPVEB6YWFQid/tgo3oxYl0huB3
	vzrhm81JgQEDTVBJCXjOk21BBXbmQ+3fZ3HQ1eQx41xReFyp2Gx6g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84d4ah2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55UMGRJm011802
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:18 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7mr21c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:18 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55UNmGFG29688376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 23:48:17 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A38EE5805B;
	Mon, 30 Jun 2025 23:48:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE7C358058;
	Mon, 30 Jun 2025 23:48:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.36])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 23:48:15 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        mmc@linux.ibm.com
Subject: [PATCH net-next 3/4] ibmvnic: Use ndo_get_stats64 to fix inaccurate SAR reporting
Date: Mon, 30 Jun 2025 16:48:05 -0700
Message-Id: <20250630234806.10885-4-mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 6bt_ERTudV0k7qJxsLN-UOgGJZgw4Uor
X-Proofpoint-GUID: 6bt_ERTudV0k7qJxsLN-UOgGJZgw4Uor
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=68632243 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=ghiumMNqhBYHs4yLu9sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE5NiBTYWx0ZWRfX1mcoJwlf6Hyx 5vGu90u1ZO+GbvCsSg4sHHCx5NNsWcZ1szScW7Cn2urSZtHOAs2RdhhnIjtAYRBQ4yc9LNmPU4d 2hK593m3p6RKpflevBxPRIfAU0gkN/xFQrXPAbzgmDrbxq47t6VbY9MEH354JfkzZNCeGTPNG+H
 k3lnOR5VVEcH0GrDTTb9uvNf6S16n6Ns92IjX5fO+6nTLnfq4h4WTnMVpaiZgxldTS4nongLSRg yclJ5XUB4MmsIHY2QxR2RKPQkMAsIfyfFuADRT5cY4Gv6JtpCfr2pfwZ+/T6mMQfcccwMvfSkO/ eTHri+PVMJnsvjoKQaK69a806iyvR9Zf+Cs5Lj3bpvZJ9ePmgZ7cIoSxw4nvyXFMX9tMOWGlA0D
 ASLTeFKXkzdN5g5OJz/OfhM3kA4hgafGdadVuGG4tAersLK6N9pSbByyc3A4LXImQbpzVtCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_06,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300196

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
index 7b2be8eeb5..8c959d5db2 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2313,13 +2313,11 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 					  tx_pool->num_buffers - 1 :
 					  tx_pool->consumer_index - 1;
 		tx_buff = &tx_pool->tx_buff[index];
-		adapter->netdev->stats.tx_packets--;
-		adapter->netdev->stats.tx_bytes -= tx_buff->skb->len;
 		atomic64_dec(&adapter->tx_stats_buffers[queue_num].batched_packets);
 		atomic64_sub(tx_buff->skb->len, &adapter->tx_stats_buffers[queue_num].bytes);
+		atomic64_inc(&adapter->tx_stats_buffers[queue_num].dropped_packets);
 		dev_kfree_skb_any(tx_buff->skb);
 		tx_buff->skb = NULL;
-		adapter->netdev->stats.tx_dropped++;
 	}
 
 	ind_bufp->index = 0;
@@ -2647,9 +2645,6 @@ tx_err:
 	}
 out:
 	rcu_read_unlock();
-	netdev->stats.tx_dropped += tx_dropped;
-	netdev->stats.tx_bytes += tx_bytes;
-	netdev->stats.tx_packets += tx_bpackets + tx_dpackets;
 	adapter->tx_send_failed += tx_send_failed;
 	adapter->tx_map_failed += tx_map_failed;
 	atomic64_add(tx_bpackets, &adapter->tx_stats_buffers[queue_num].batched_packets);
@@ -3452,6 +3447,25 @@ err:
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
@@ -3567,8 +3581,6 @@ restart_poll:
 
 		length = skb->len;
 		napi_gro_receive(napi, skb); /* send it up */
-		netdev->stats.rx_packets++;
-		netdev->stats.rx_bytes += length;
 		atomic64_inc(&adapter->rx_stats_buffers[scrq_num].packets);
 		atomic64_add(length, &adapter->rx_stats_buffers[scrq_num].bytes);
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


