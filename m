Return-Path: <netdev+bounces-127621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FB1975E27
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204D11C21989
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 00:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2EB8C06;
	Thu, 12 Sep 2024 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="mYYNDeLX"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935AB1CD35
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102320; cv=none; b=Hk/1RiEGNfTafLcyd+Db9cII2qdBpl8MDsf9KAJnOKuBc3Fn73lztBbyKx863WJaxskSxoj0XHMAjpjZ7ZvDFTeJEJZCbXcJJhvta6tmMHpQIbvh5vR3J76WLrE6R5v34Oz0OrAsf+cWo83VaeJb0gYqeqs5skLIwlc8W1M0gg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102320; c=relaxed/simple;
	bh=D9y+ltzEGCMC+OktOb2IE5oiVW7gSM8uv7pCwxZyjp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mccO7T/yG1Q6jEps0V6GBiWU/pnisrcnwTC8GZ6rMJ951W5xaGTvyGrFLuNxbycZ8ouWdMvEqVsqfhTxgRirT86ZDTLdB+pPoOc6m4p9DS5JNk6ulSyptFTyyrUdOo8Yx27ZXBgucKfIitFHCIjJ5uaV/zGL7uhx2QbvkLyJcAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=mYYNDeLX; arc=none smtp.client-ip=173.37.86.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4610; q=dns/txt; s=iport;
  t=1726102318; x=1727311918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sPOvTXHqOuNMTwJ/RoHMWmdYik+sRBJlPfKR8cFkbiw=;
  b=mYYNDeLXrfCaLEnbtxaff62OwyKqkLOIT4ZoiWbMeJEgRBDwHnET/yh+
   j9R7S/RxUEkfleKIR3KUIMeHBzK0xU6kPtCoJT/X/gHbRhtfCHrKti9SC
   /AjfWaylRjDhXfk+JNODpqjmeCwHaK4QnxD4Y4pbCNN06gvUDd3hXR4nM
   E=;
X-CSE-ConnectionGUID: RZ3iACpQRfm94fOEnnVasQ==
X-CSE-MsgGUID: UN0B3vIfRQe4qtNUrqZb9w==
X-IronPort-AV: E=Sophos;i="6.10,221,1719878400"; 
   d="scan'208";a="259230652"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 00:51:57 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id 48C0pvV6032608;
	Thu, 12 Sep 2024 00:51:57 GMT
Received: by cisco.com (Postfix, from userid 412739)
	id 42C8520F2003; Wed, 11 Sep 2024 17:51:57 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com, johndale@cisco.com,
        Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v3 4/4] enic: Report some per queue statistics in ethtool
Date: Wed, 11 Sep 2024 17:50:39 -0700
Message-Id: <20240912005039.10797-5-neescoba@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20240912005039.10797-1-neescoba@cisco.com>
References: <20240912005039.10797-1-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-core-8.cisco.com

Make 'ethtool -S <intf>' output show some per rq/wq statistics that
don't exist in the netdev qstats.

Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 .../net/ethernet/cisco/enic/enic_ethtool.c    | 83 ++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index b71146209334..a4fc77a8fac7 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -32,6 +32,41 @@ struct enic_stat {
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
+	ENIC_PER_RQ_STAT(l4_rss_hash),
+	ENIC_PER_RQ_STAT(l3_rss_hash),
+	ENIC_PER_RQ_STAT(csum_unnecessary_encap),
+	ENIC_PER_RQ_STAT(vlan_stripped),
+	ENIC_PER_RQ_STAT(napi_complete),
+	ENIC_PER_RQ_STAT(napi_repoll),
+	ENIC_PER_RQ_STAT(no_skb),
+	ENIC_PER_RQ_STAT(desc_skip),
+};
+
+#define NUM_ENIC_PER_RQ_STATS   ARRAY_SIZE(enic_per_rq_stats)
+
+static const struct enic_stat enic_per_wq_stats[] = {
+	ENIC_PER_WQ_STAT(encap_tso),
+	ENIC_PER_WQ_STAT(encap_csum),
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
@@ -143,7 +178,9 @@ static void enic_get_drvinfo(struct net_device *netdev,
 static void enic_get_strings(struct net_device *netdev, u32 stringset,
 	u8 *data)
 {
+	struct enic *enic = netdev_priv(netdev);
 	unsigned int i;
+	unsigned int j;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
@@ -159,6 +196,20 @@ static void enic_get_strings(struct net_device *netdev, u32 stringset,
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
@@ -244,10 +295,19 @@ static int enic_set_ringparam(struct net_device *netdev,
 
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
@@ -259,6 +319,7 @@ static void enic_get_ethtool_stats(struct net_device *netdev,
 	struct enic *enic = netdev_priv(netdev);
 	struct vnic_stats *vstats;
 	unsigned int i;
+	unsigned int j;
 	int err;
 
 	err = enic_dev_stats_dump(enic, &vstats);
@@ -275,6 +336,24 @@ static void enic_get_ethtool_stats(struct net_device *netdev,
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


