Return-Path: <netdev+bounces-131591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E1A98EF61
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D5EB2318B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFB0186E3D;
	Thu,  3 Oct 2024 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VrknnEyI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B23E18893D
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959200; cv=none; b=WA6wJHyypLx55pzDzxD26wgysTBnsjld7Xklwv0X/MIEKGKQ9eMdk0cQtNj4Twu+fpbBM6G2XU+ti5J9SXNWt6WiOMKCfYg9aAL5lpyDoXl5OnBCrXKyIMQXnt83Xddbj1QKoGmuZkKDY0dyCAuq8WlFMW9CAScA34XdIJjOCPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959200; c=relaxed/simple;
	bh=3qPLFX/8GclK9EnJ62LRXpmnoiwMGVHZSJwvk9sdWEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRbX3taWjdOWbH+c3nuK7KaJoZGAoLUNji8ogO2DqyxzWrJ108dJ9zTiWRGgjGYzOnoaj8Y2ckmCYM51/yBzQWJxI8hIbyOTwfffyzVDSHXLdad2f1eo9QqPNUJoO9QCzgs35N8FQ2t5GBiQwqVCvTUCE1o77LTkd8ghdxQP6A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VrknnEyI; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4935dLZP001492;
	Thu, 3 Oct 2024 05:39:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=chRIzg/X1n/ddiNZWu5XggPDmewbp0jbuBf4Dl68S7A=; b=
	VrknnEyIAfvwVQiONGnVGqHbFqiPZxojvY1PfzOH4wowiRL6pwyEFjfOJDqszcTU
	JUJ2TIROAiNqDNmDrjAigAxqoF4ik8uT1hZPWC5iuy/Ro3rIDnAybtwqHOhMri8D
	ij5t8s11+56l8XcRBSgswdIKopQh1fxFuYxZ1s4986X4qXntw/s5icSqX3P6zBBk
	MOl8djHhwIHjiPzgKefCoOyDJ8jY8W1Q7F7CjJq7wkTe3uO4XpY9St6p2ct+x4bG
	PiYEGoHmqe1vV0DmoIXq+b3eMZKui5H08HC6/9P7J6CRuXiMKIVelv1HWDqFWIB5
	98b9cx/Wbz18rGYcPEEZWQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42163x71an-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 03 Oct 2024 05:39:51 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 3 Oct 2024 12:39:48 +0000
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
Subject: [PATCH net-next v3 5/5] eth: fbnic: add ethtool timestamping statistics
Date: Thu, 3 Oct 2024 05:39:33 -0700
Message-ID: <20241003123933.2589036-6-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241003123933.2589036-1-vadfed@meta.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: DrrWjjU573cqVBest_eBC8gQgoc1douy
X-Proofpoint-ORIG-GUID: DrrWjjU573cqVBest_eBC8gQgoc1douy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01

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
index d6f0f3faa82f..5e2c3512b4ab 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -383,7 +383,7 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 			     struct fbnic_ring *ring, bool discard,
 			     unsigned int hw_head)
 {
-	u64 total_bytes = 0, total_packets = 0;
+	u64 total_bytes = 0, total_packets = 0, ts_lost = 0;
 	unsigned int head = ring->head;
 	struct netdev_queue *txq;
 	unsigned int clean_desc;
@@ -402,6 +402,7 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 			FBNIC_XMIT_CB(skb)->hw_head = hw_head;
 			if (likely(!discard))
 				break;
+			ts_lost++;
 		}
 
 		ring->tx_buf[head] = NULL;
@@ -441,6 +442,7 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 	if (unlikely(discard)) {
 		u64_stats_update_begin(&ring->stats.syncp);
 		ring->stats.dropped += total_packets;
+		ring->stats.ts_lost += ts_lost;
 		u64_stats_update_end(&ring->stats.syncp);
 
 		netdev_tx_completed_queue(txq, total_packets, total_bytes);
@@ -502,6 +504,9 @@ static void fbnic_clean_tsq(struct fbnic_napi_vector *nv,
 	}
 
 	skb_tstamp_tx(skb, &hwtstamp);
+	u64_stats_update_begin(&ring->stats.syncp);
+	ring->stats.ts_packets++;
+	u64_stats_update_end(&ring->stats.syncp);
 }
 
 static void fbnic_page_pool_init(struct fbnic_ring *ring, unsigned int idx,
@@ -1058,6 +1063,8 @@ static void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
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


