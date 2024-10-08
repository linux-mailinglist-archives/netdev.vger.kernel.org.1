Return-Path: <netdev+bounces-133249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9D8995643
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48632859ED
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D76C212D2C;
	Tue,  8 Oct 2024 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FGKoiC6y"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE42212D20
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411310; cv=none; b=uf2u2DPDnYfG2fuXvZsuWFcM2QrIIkZXxWs+M1GgeXNO1YZeM7n6N/GCNDPVIRcSU7zR7wxWQPIDIdpYFC+V6sY3PvJRIZjHS/E8qxlljUUROFVKNNujvahPvtbY7gwuM0fN7u/r3dS/V2B2tmENBgYvcSONh8JQ6pP9IgCEuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411310; c=relaxed/simple;
	bh=LhAGVG1zJbyn/z4IQpBmvzBmP2EOryb15cZYfxQJ+p0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oryB+mXZBP5C9Hz+vLIgUOtENvKVRZzAuT++7+MtC08tSDLlLC9L1+aoTPbUqWwSK81sOIaaxkA86JrGYlSDfp/NVN0/dr+NY6nkNQ2yTzzlyc0f03vNpXNkZ0KODgA6sO2OOLmPglfoGKFwpD4jRRbYVWXa61CBXjIPWLkD8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FGKoiC6y; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498GcIvc023369;
	Tue, 8 Oct 2024 11:15:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=NNgvCxVXRQ7gaKGjuyLHjJ1aFLPwVtPCkF//3+db8Uw=; b=FGKoiC6ynJhy
	NElCF6eIA/XGjfSSCU2UyITDuvqAU1iGzrIOkBdc8oarSFJfEC/9/scArXWhxx8j
	vaTaZdXDK4peiH0WsfhK6/K89ie9dVmEvl57ztGDgHTLkCaL9frFolwhHClxnLJL
	IHXMz5qF5I8ZZnrdIthwK1S3f2QFGw7dM+2tnLIgLK8PD4nQtqIKkMl/qrW8ZPkb
	jOV+JVh1d88gm2K+MrxqEpJcKEoEiBFWU/9zVfACTq3VOvLFgPl8/DEMmWieCbGb
	ulrSnxvAjvuH35oVUed2YSyyYTKuDx28HwhhT5KUYGACKo6kxiTqK/VJy8/Y2FCm
	5RgNWZhqag==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42339s279v-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 08 Oct 2024 11:15:00 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Tue, 8 Oct 2024 18:14:54 +0000
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
Subject: [PATCH net-next v4 5/5] eth: fbnic: add ethtool timestamping statistics
Date: Tue, 8 Oct 2024 11:14:36 -0700
Message-ID: <20241008181436.4120604-6-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008181436.4120604-1-vadfed@meta.com>
References: <20241008181436.4120604-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Qia-NCtd1Yj0qO8DKkMmFMtmjpxS1C9K
X-Proofpoint-ORIG-GUID: Qia-NCtd1Yj0qO8DKkMmFMtmjpxS1C9K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

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
index 2e3d06946e74..b5050fabe8fe 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -385,7 +385,7 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 			     struct fbnic_ring *ring, bool discard,
 			     unsigned int hw_head)
 {
-	u64 total_bytes = 0, total_packets = 0;
+	u64 total_bytes = 0, total_packets = 0, ts_lost = 0;
 	unsigned int head = ring->head;
 	struct netdev_queue *txq;
 	unsigned int clean_desc;
@@ -404,6 +404,7 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 			FBNIC_XMIT_CB(skb)->hw_head = hw_head;
 			if (likely(!discard))
 				break;
+			ts_lost++;
 		}
 
 		ring->tx_buf[head] = NULL;
@@ -443,6 +444,7 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 	if (unlikely(discard)) {
 		u64_stats_update_begin(&ring->stats.syncp);
 		ring->stats.dropped += total_packets;
+		ring->stats.ts_lost += ts_lost;
 		u64_stats_update_end(&ring->stats.syncp);
 
 		netdev_tx_completed_queue(txq, total_packets, total_bytes);
@@ -504,6 +506,9 @@ static void fbnic_clean_tsq(struct fbnic_napi_vector *nv,
 	}
 
 	skb_tstamp_tx(skb, &hwtstamp);
+	u64_stats_update_begin(&ring->stats.syncp);
+	ring->stats.ts_packets++;
+	u64_stats_update_end(&ring->stats.syncp);
 }
 
 static void fbnic_page_pool_init(struct fbnic_ring *ring, unsigned int idx,
@@ -1060,6 +1065,8 @@ static void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
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


