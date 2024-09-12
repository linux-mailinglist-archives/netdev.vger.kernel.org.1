Return-Path: <netdev+bounces-127870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF2B976EBB
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2ED328697E
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A86187874;
	Thu, 12 Sep 2024 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DxwAV3hn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF31850AF
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158720; cv=none; b=IEvSSX/2yiToUspr8Gs+1tdNF+/gSjzIEdwAj1OJaXEAee/EwUK3YOj3k9Rz5mczMUHVoxQSWIffJr7O/ZMIMQ6VaomBJa/qurQGvWViQJOfIjWD9L/yeNKeg9W1OOVHk2qHcyZ+UDPkyc0TziBlwUInQqMKQ0VGCXUglg6o0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158720; c=relaxed/simple;
	bh=lVl7Ujg1BQweJ9Y7Vu/WuWv6U/4bneP8l1GSbKZl+iE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7/AvB5/FSZY1innzbGtB/VUCspoeg6UOqeO8Xfgj5wtrnVOo8y2/K56DWhay7M2PMO6huopPBfHqDeXJNXvxHIy2kV3DrjJFKocPVz2IwUEHVr32utXbvzfXxIcN+zjZQ4WnXCczlajZYfE+UkkcG3GbMENSdX+wfzQSLrMnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DxwAV3hn; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CFJPL9003510;
	Thu, 12 Sep 2024 09:31:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=glQSoJYUV1aFxN9b4L+ai053R4JC3WO6cnGWO+vb7xA=; b=
	DxwAV3hnx+XzZtzlG4t0Kftr5Y3d3ZYnvzCt8DSF5sabjm6sxcyfROeOSPKsh4/e
	764caIrB0sGQUswSZ8jCjQphjhZOUXIAR05dK6FhR5dVQiEQUpw2J+EKlOnjaW51
	nz3LcnXeJ4wDIR65uwmL4zzOdLNCMAgZ0CnGghitgJk4k8FHt6yh7AUA/sl+KdMV
	1f2AUZ/FwwiF5cQ9xoQ7fAWaKJkZPlsNovz7h4KtxhVKoYcKDneLsZwsaj/nmwA5
	mrWhKZUN6k/Xg9ZY/mU0iuVo5bFbW234lhS6bpHFixglUEQlXYTgrWvJdM4YHUN/
	YsH22aRzp7ywwR+0O/K7AQ==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41kr50w16h-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Sep 2024 09:31:49 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 12 Sep 2024 16:31:44 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Duyck
	<alexanderduyck@fb.com>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>,
        "Richard
 Cochran" <richardcochran@gmail.com>
Subject: [PATCH net-next v2 5/5] eth: fbnic: add ethtool timestamping statistics
Date: Thu, 12 Sep 2024 09:31:23 -0700
Message-ID: <20240912163123.551882-6-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240912163123.551882-1-vadfed@meta.com>
References: <20240912163123.551882-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: vGlZGi_W0_omdGoMcpbo5bULeFWbE-cN
X-Proofpoint-ORIG-GUID: vGlZGi_W0_omdGoMcpbo5bULeFWbE-cN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_05,2024-09-12_01,2024-09-02_01

Add counters of packets with HW timestamps requests and lost timestamps
with no associated skbs. Use ethtool interface to report these counters.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 24 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |  9 ++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  2 ++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 24e059443264..1117d5a32867 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -93,9 +93,33 @@ fbnic_get_eth_mac_stats(struct net_device *netdev,
 			  &mac_stats->eth_mac.FrameTooLongErrors);
 }
 
+static void fbnic_get_ts_stats(struct net_device *netdev,
+			       struct ethtool_ts_stats *ts_stats)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	u64 ts_packets, ts_lost;
+	struct fbnic_ring *ring;
+	unsigned int start;
+	int i;
+
+	ts_stats->pkts = fbn->tx_stats.ts_packets;
+	ts_stats->lost = fbn->tx_stats.ts_lost;
+	for (i = 0; i < fbn->num_tx_queues; i++) {
+		ring = fbn->tx[i];
+		do {
+			start = u64_stats_fetch_begin(&ring->stats.syncp);
+			ts_packets = ring->stats.ts_packets;
+			ts_lost = ring->stats.ts_lost;
+		} while (u64_stats_fetch_retry(&ring->stats.syncp, start));
+		ts_stats->pkts += ts_packets;
+		ts_stats->lost += ts_lost;
+	}
+}
+
 static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_drvinfo		= fbnic_get_drvinfo,
 	.get_ts_info		= fbnic_get_ts_info,
+	.get_ts_stats		= fbnic_get_ts_stats,
 	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
 };
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index cd6d666d8905..3fe08360801e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -382,7 +382,7 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 			     struct fbnic_ring *ring, bool discard,
 			     unsigned int hw_head)
 {
-	u64 total_bytes = 0, total_packets = 0;
+	u64 total_bytes = 0, total_packets = 0, ts_lost = 0;
 	unsigned int head = ring->head;
 	struct netdev_queue *txq;
 	unsigned int clean_desc;
@@ -401,6 +401,7 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 			FBNIC_XMIT_CB(skb)->hw_head = hw_head;
 			if (likely(!discard))
 				break;
+			ts_lost++;
 		}
 
 		ring->tx_buf[head] = NULL;
@@ -440,6 +441,7 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 	if (unlikely(discard)) {
 		u64_stats_update_begin(&ring->stats.syncp);
 		ring->stats.dropped += total_packets;
+		ring->stats.ts_lost += ts_lost;
 		u64_stats_update_end(&ring->stats.syncp);
 
 		netdev_tx_completed_queue(txq, total_packets, total_bytes);
@@ -501,6 +503,9 @@ static void fbnic_clean_tsq(struct fbnic_napi_vector *nv,
 	}
 
 	skb_tstamp_tx(skb, &hwtstamp);
+	u64_stats_update_begin(&ring->stats.syncp);
+	ring->stats.ts_packets++;
+	u64_stats_update_end(&ring->stats.syncp);
 }
 
 static void fbnic_page_pool_init(struct fbnic_ring *ring, unsigned int idx,
@@ -1057,6 +1062,8 @@ static void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
 	fbn->tx_stats.bytes += stats->bytes;
 	fbn->tx_stats.packets += stats->packets;
 	fbn->tx_stats.dropped += stats->dropped;
+	fbn->tx_stats.ts_lost += stats->ts_lost;
+	fbn->tx_stats.ts_packets += stats->ts_packets;
 }
 
 static void fbnic_remove_tx_ring(struct fbnic_net *fbn,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 682d875f08c0..8d626287c3f4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -57,6 +57,8 @@ struct fbnic_queue_stats {
 	u64 packets;
 	u64 bytes;
 	u64 dropped;
+	u64 ts_packets;
+	u64 ts_lost;
 	struct u64_stats_sync syncp;
 };
 
-- 
2.43.5


