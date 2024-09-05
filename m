Return-Path: <netdev+bounces-125335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CA196CC16
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 03:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAEB2B23FB7
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73144522F;
	Thu,  5 Sep 2024 01:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="LQsTY0jP"
X-Original-To: netdev@vger.kernel.org
Received: from bgl-iport-4.cisco.com (bgl-iport-4.cisco.com [72.163.197.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA89473
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 01:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.163.197.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498696; cv=none; b=OkvD2mpiYa5vA1FeWrqA1FPe6j3rG9mgL3YEj/255WTUPg983eQO+1vZhaaSedCnXvctvoJkrh1mzpSvkTNQlk8+wZF7CAPeewuraXNwOIucywv9DuPS6mBYWtB/F+d4zUokMtqv2Y/NirMsczrfw3TPIK+JGfLVKa91UuQOpCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498696; c=relaxed/simple;
	bh=zbuWg15/Ac8PthznN0n1vo5zeiMOXXPD6EycRaN3dRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tfdRraK/8D6Te8kegSeDbHT8smXqzVT1ZVrT4LafamP3KVpbAu3aiEYBlpKioakVW5L4SZ/adoE1zvk0HItumAMuCoEMmyu8AjxpnQb3kBTNzL3XQ8xCrZicEPYMx43HAUkZLrpyU/W+Lx6htQjfW/Nynk9oXOyKbDzL3YdIIgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=LQsTY0jP; arc=none smtp.client-ip=72.163.197.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4932; q=dns/txt; s=iport;
  t=1725498694; x=1726708294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gOibplaPboOIR9m5P7JnqsAur99wOXMUFf//qSukomM=;
  b=LQsTY0jP9wAaiqK3hwrrFFpbLDjCxJhef3kc0sIni//7jLctzn40lOMz
   hfvnW0tqrjv76ou/EfmJ2Krer8TJDg9xM86TeoIJFZJDo1v/7ZkNcfLBq
   JVbYSYa10RTeFFEit/+qii1LfqSU7xoq8cV/7GBoakoUspGpNGK7TGije
   c=;
X-CSE-ConnectionGUID: KKoQHK3KQ96ANyHdxEcTag==
X-CSE-MsgGUID: Eoou23nPR0yWcDydRPbQtQ==
X-IronPort-AV: E=Sophos;i="6.10,203,1719878400"; 
   d="scan'208";a="39217392"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by bgl-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:10:20 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTP id 4851AH1m002692;
	Thu, 5 Sep 2024 01:10:17 GMT
Received: by cisco.com (Postfix, from userid 412739)
	id B469D20F2003; Wed,  4 Sep 2024 18:10:17 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com, johndale@cisco.com,
        Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v2 3/4] enic: Report per queue statistics in ethtool
Date: Wed,  4 Sep 2024 18:08:59 -0700
Message-Id: <20240905010900.24152-4-neescoba@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20240905010900.24152-1-neescoba@cisco.com>
References: <20240905010900.24152-1-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-core-4.cisco.com

Make 'ethtool -S <intf>' output show per rq/wq statistics.

Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 .../net/ethernet/cisco/enic/enic_ethtool.c    | 95 ++++++++++++++++++-
 1 file changed, 93 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index b71146209334..50ab04845547 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -32,6 +32,53 @@ struct enic_stat {
 	.index = offsetof(struct vnic_gen_stats, stat) / sizeof(u64)\
 }
 
+#define ENIC_PER_RQ_STAT(stat) { \
+	.name = "rq[%d]_"#stat, \
+	.index = offsetof(struct enic_rq_stats, stat) / sizeof(u64) \
+}
+
+#define ENIC_PER_WQ_STAT(stat) { \
+	.name = "wq[%d]_"#stat, \
+	.index = offsetof(struct enic_wq_stats, stat) / sizeof(u64) \
+}
+
+static const struct enic_stat enic_per_rq_stats[] = {
+	ENIC_PER_RQ_STAT(packets),
+	ENIC_PER_RQ_STAT(bytes),
+	ENIC_PER_RQ_STAT(l4_rss_hash),
+	ENIC_PER_RQ_STAT(l3_rss_hash),
+	ENIC_PER_RQ_STAT(csum_unnecessary),
+	ENIC_PER_RQ_STAT(csum_unnecessary_encap),
+	ENIC_PER_RQ_STAT(vlan_stripped),
+	ENIC_PER_RQ_STAT(napi_complete),
+	ENIC_PER_RQ_STAT(napi_repoll),
+	ENIC_PER_RQ_STAT(bad_fcs),
+	ENIC_PER_RQ_STAT(pkt_truncated),
+	ENIC_PER_RQ_STAT(no_skb),
+	ENIC_PER_RQ_STAT(desc_skip),
+};
+
+#define NUM_ENIC_PER_RQ_STATS   ARRAY_SIZE(enic_per_rq_stats)
+
+static const struct enic_stat enic_per_wq_stats[] = {
+	ENIC_PER_WQ_STAT(packets),
+	ENIC_PER_WQ_STAT(stopped),
+	ENIC_PER_WQ_STAT(wake),
+	ENIC_PER_WQ_STAT(tso),
+	ENIC_PER_WQ_STAT(encap_tso),
+	ENIC_PER_WQ_STAT(encap_csum),
+	ENIC_PER_WQ_STAT(csum_partial),
+	ENIC_PER_WQ_STAT(csum),
+	ENIC_PER_WQ_STAT(bytes),
+	ENIC_PER_WQ_STAT(add_vlan),
+	ENIC_PER_WQ_STAT(cq_work),
+	ENIC_PER_WQ_STAT(cq_bytes),
+	ENIC_PER_WQ_STAT(null_pkt),
+	ENIC_PER_WQ_STAT(skb_linear_fail),
+	ENIC_PER_WQ_STAT(desc_full_awake),
+};
+
+#define NUM_ENIC_PER_WQ_STATS   ARRAY_SIZE(enic_per_wq_stats)
 static const struct enic_stat enic_tx_stats[] = {
 	ENIC_TX_STAT(tx_frames_ok),
 	ENIC_TX_STAT(tx_unicast_frames_ok),
@@ -143,7 +190,9 @@ static void enic_get_drvinfo(struct net_device *netdev,
 static void enic_get_strings(struct net_device *netdev, u32 stringset,
 	u8 *data)
 {
+	struct enic *enic = netdev_priv(netdev);
 	unsigned int i;
+	unsigned int j;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
@@ -159,6 +208,20 @@ static void enic_get_strings(struct net_device *netdev, u32 stringset,
 			memcpy(data, enic_gen_stats[i].name, ETH_GSTRING_LEN);
 			data += ETH_GSTRING_LEN;
 		}
+		for (i = 0; i < enic->rq_count; i++) {
+			for (j = 0; j < NUM_ENIC_PER_RQ_STATS; j++) {
+				snprintf(data, ETH_GSTRING_LEN,
+					 enic_per_rq_stats[j].name, i);
+				data += ETH_GSTRING_LEN;
+			}
+		}
+		for (i = 0; i < enic->wq_count; i++) {
+			for (j = 0; j < NUM_ENIC_PER_WQ_STATS; j++) {
+				snprintf(data, ETH_GSTRING_LEN,
+					 enic_per_wq_stats[j].name, i);
+				data += ETH_GSTRING_LEN;
+			}
+		}
 		break;
 	}
 }
@@ -244,10 +307,19 @@ static int enic_set_ringparam(struct net_device *netdev,
 
 static int enic_get_sset_count(struct net_device *netdev, int sset)
 {
+	struct enic *enic = netdev_priv(netdev);
+	unsigned int n_per_rq_stats;
+	unsigned int n_per_wq_stats;
+	unsigned int n_stats;
+
 	switch (sset) {
 	case ETH_SS_STATS:
-		return NUM_ENIC_TX_STATS + NUM_ENIC_RX_STATS +
-			NUM_ENIC_GEN_STATS;
+		n_per_rq_stats = NUM_ENIC_PER_RQ_STATS * enic->rq_count;
+		n_per_wq_stats = NUM_ENIC_PER_WQ_STATS * enic->wq_count;
+		n_stats = NUM_ENIC_TX_STATS + NUM_ENIC_RX_STATS +
+			NUM_ENIC_GEN_STATS +
+			n_per_rq_stats + n_per_wq_stats;
+		return n_stats;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -259,6 +331,7 @@ static void enic_get_ethtool_stats(struct net_device *netdev,
 	struct enic *enic = netdev_priv(netdev);
 	struct vnic_stats *vstats;
 	unsigned int i;
+	unsigned int j;
 	int err;
 
 	err = enic_dev_stats_dump(enic, &vstats);
@@ -275,6 +348,24 @@ static void enic_get_ethtool_stats(struct net_device *netdev,
 		*(data++) = ((u64 *)&vstats->rx)[enic_rx_stats[i].index];
 	for (i = 0; i < NUM_ENIC_GEN_STATS; i++)
 		*(data++) = ((u64 *)&enic->gen_stats)[enic_gen_stats[i].index];
+	for (i = 0; i < enic->rq_count; i++) {
+		struct enic_rq_stats *rqstats = &enic->rq_stats[i];
+		int index;
+
+		for (j = 0; j < NUM_ENIC_PER_RQ_STATS; j++) {
+			index = enic_per_rq_stats[j].index;
+			*(data++) = ((u64 *)rqstats)[index];
+		}
+	}
+	for (i = 0; i < enic->wq_count; i++) {
+		struct enic_wq_stats *wqstats = &enic->wq_stats[i];
+		int index;
+
+		for (j = 0; j < NUM_ENIC_PER_WQ_STATS; j++) {
+			index = enic_per_wq_stats[j].index;
+			*(data++) = ((u64 *)wqstats)[index];
+		}
+	}
 }
 
 static u32 enic_get_msglevel(struct net_device *netdev)
-- 
2.35.2


