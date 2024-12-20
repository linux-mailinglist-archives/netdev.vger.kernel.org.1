Return-Path: <netdev+bounces-153551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7529F8A43
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CF01892DBF
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796C4273F9;
	Fri, 20 Dec 2024 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhh6UU5X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2D23774
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734663169; cv=none; b=hc+rRhLHHua2uog0+sAYLBxRHEBByLbV1VTk0gaf28pANZkG6SPM8pxKK5Q0+wVQ157cwkvYSU6oahZpy6mNI4lbnAvM2CQh6GzlVWESt8R8j5F5WvSVQWKBTxAaNLqRNSs3Dz6m6DEwU0IsvR6wri6rgsKg4fecc4INevT/f+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734663169; c=relaxed/simple;
	bh=2sAJr6N5XknN+c33hqXvcfqOn2SFHAx7bOmRZRSTERE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4Q7dOplwN31g1GMt30Z65fTJBoL45VUtxLKbLRQGhSt5gETGmLm9iAFDxS7lqaCYNd45GFCIg6c//p8cVojDu9rdEUrKHqEUcaR8C64loyLhcGbRknK2qzCo1qMjrRfryf2kjCSLT5YveiyDLCP26gVh6yfDKW0LS/1texuL/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhh6UU5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA74C4CED7;
	Fri, 20 Dec 2024 02:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734663168;
	bh=2sAJr6N5XknN+c33hqXvcfqOn2SFHAx7bOmRZRSTERE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fhh6UU5X9Aa+01Q65jrirvBYUzO/jKtrX3Vbs0tIi/Gu8Y/0ze9piBSU8mwC9Zcxt
	 pDdnllFHqtkdm8XkxeYWwsU6IG67rRJ+usfyi59OtQWWI1nMxd1g1I4yuVwKF+94vV
	 56KUALWKEHmc9d3rNvTo50WtM6eHVWI2PoB5+18Mt5hGOCuKDEtrY98O80Z8LFAgPs
	 aF3BIlDqY2677Cp8kfiDY/zhuuxQMi/wXlaKvXrgegknptJiKMCIyETiO4o1474N5v
	 TPxJbg+Sqzh/4+1V94E8iFDmsCloq5I8kUzUg3MI9l945cWimzNyDeDzUm/3ddcrI1
	 MoPXm/I7UHPEg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 01/10] eth: fbnic: reorder ethtool code
Date: Thu, 19 Dec 2024 18:52:32 -0800
Message-ID: <20241220025241.1522781-2-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220025241.1522781-1-kuba@kernel.org>
References: <20241220025241.1522781-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define ethtool callback handlers in order in which they are defined
in the ops struct. It doesn't really matter what the order is,
but it's good to have an order.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 160 +++++++++---------
 1 file changed, 80 insertions(+), 80 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index cc8ca94529ca..777e083acae9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -40,6 +40,68 @@ static const struct fbnic_stat fbnic_gstrings_hw_stats[] = {
 #define FBNIC_HW_FIXED_STATS_LEN ARRAY_SIZE(fbnic_gstrings_hw_stats)
 #define FBNIC_HW_STATS_LEN	FBNIC_HW_FIXED_STATS_LEN
 
+static void
+fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	fbnic_get_fw_ver_commit_str(fbd, drvinfo->fw_version,
+				    sizeof(drvinfo->fw_version));
+}
+
+static int fbnic_get_regs_len(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	return fbnic_csr_regs_len(fbn->fbd) * sizeof(u32);
+}
+
+static void fbnic_get_regs(struct net_device *netdev,
+			   struct ethtool_regs *regs, void *data)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	fbnic_csr_get_regs(fbn->fbd, data, &regs->version);
+}
+
+static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
+{
+	int i;
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < FBNIC_HW_STATS_LEN; i++)
+			ethtool_puts(&data, fbnic_gstrings_hw_stats[i].string);
+		break;
+	}
+}
+
+static void fbnic_get_ethtool_stats(struct net_device *dev,
+				    struct ethtool_stats *stats, u64 *data)
+{
+	struct fbnic_net *fbn = netdev_priv(dev);
+	const struct fbnic_stat *stat;
+	int i;
+
+	fbnic_get_hw_stats(fbn->fbd);
+
+	for (i = 0; i < FBNIC_HW_STATS_LEN; i++) {
+		stat = &fbnic_gstrings_hw_stats[i];
+		data[i] = *(u64 *)((u8 *)&fbn->fbd->hw_stats + stat->offset);
+	}
+}
+
+static int fbnic_get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return FBNIC_HW_STATS_LEN;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int
 fbnic_get_ts_info(struct net_device *netdev,
 		  struct kernel_ethtool_ts_info *tsinfo)
@@ -69,14 +131,27 @@ fbnic_get_ts_info(struct net_device *netdev,
 	return 0;
 }
 
-static void
-fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
+static void fbnic_get_ts_stats(struct net_device *netdev,
+			       struct ethtool_ts_stats *ts_stats)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
-	struct fbnic_dev *fbd = fbn->fbd;
+	u64 ts_packets, ts_lost;
+	struct fbnic_ring *ring;
+	unsigned int start;
+	int i;
 
-	fbnic_get_fw_ver_commit_str(fbd, drvinfo->fw_version,
-				    sizeof(drvinfo->fw_version));
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
 }
 
 static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
@@ -85,43 +160,6 @@ static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
 		*stat = counter->value;
 }
 
-static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
-{
-	int i;
-
-	switch (sset) {
-	case ETH_SS_STATS:
-		for (i = 0; i < FBNIC_HW_STATS_LEN; i++)
-			ethtool_puts(&data, fbnic_gstrings_hw_stats[i].string);
-		break;
-	}
-}
-
-static int fbnic_get_sset_count(struct net_device *dev, int sset)
-{
-	switch (sset) {
-	case ETH_SS_STATS:
-		return FBNIC_HW_STATS_LEN;
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
-static void fbnic_get_ethtool_stats(struct net_device *dev,
-				    struct ethtool_stats *stats, u64 *data)
-{
-	struct fbnic_net *fbn = netdev_priv(dev);
-	const struct fbnic_stat *stat;
-	int i;
-
-	fbnic_get_hw_stats(fbn->fbd);
-
-	for (i = 0; i < FBNIC_HW_STATS_LEN; i++) {
-		stat = &fbnic_gstrings_hw_stats[i];
-		data[i] = *(u64 *)((u8 *)&fbn->fbd->hw_stats + stat->offset);
-	}
-}
-
 static void
 fbnic_get_eth_mac_stats(struct net_device *netdev,
 			struct ethtool_eth_mac_stats *eth_mac_stats)
@@ -164,44 +202,6 @@ fbnic_get_eth_mac_stats(struct net_device *netdev,
 			  &mac_stats->eth_mac.FrameTooLongErrors);
 }
 
-static void fbnic_get_ts_stats(struct net_device *netdev,
-			       struct ethtool_ts_stats *ts_stats)
-{
-	struct fbnic_net *fbn = netdev_priv(netdev);
-	u64 ts_packets, ts_lost;
-	struct fbnic_ring *ring;
-	unsigned int start;
-	int i;
-
-	ts_stats->pkts = fbn->tx_stats.ts_packets;
-	ts_stats->lost = fbn->tx_stats.ts_lost;
-	for (i = 0; i < fbn->num_tx_queues; i++) {
-		ring = fbn->tx[i];
-		do {
-			start = u64_stats_fetch_begin(&ring->stats.syncp);
-			ts_packets = ring->stats.ts_packets;
-			ts_lost = ring->stats.ts_lost;
-		} while (u64_stats_fetch_retry(&ring->stats.syncp, start));
-		ts_stats->pkts += ts_packets;
-		ts_stats->lost += ts_lost;
-	}
-}
-
-static void fbnic_get_regs(struct net_device *netdev,
-			   struct ethtool_regs *regs, void *data)
-{
-	struct fbnic_net *fbn = netdev_priv(netdev);
-
-	fbnic_csr_get_regs(fbn->fbd, data, &regs->version);
-}
-
-static int fbnic_get_regs_len(struct net_device *netdev)
-{
-	struct fbnic_net *fbn = netdev_priv(netdev);
-
-	return fbnic_csr_regs_len(fbn->fbd) * sizeof(u32);
-}
-
 static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_drvinfo		= fbnic_get_drvinfo,
 	.get_regs_len		= fbnic_get_regs_len,
-- 
2.47.1


