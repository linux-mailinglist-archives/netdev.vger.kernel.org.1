Return-Path: <netdev+bounces-198383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92580ADBEC9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDE217575F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D47B18DB35;
	Tue, 17 Jun 2025 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d16oyZeA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295AA15B0EC
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124762; cv=none; b=CN3ioilxUbVDK+cTB6kjwQpLI4P8yc2MBQM3SXjjY+uOWOX0Kpme1dESA1h1o1+Wsej2qp+Yv2rtvTvkcAF9206vol4kqZr+cchaVRsB1tNpf24/VfZvsO1ciQ7AcYF82TEsXMIJKQV4TX0TPLmaRT0mSUDYv0t00oRia2v7X8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124762; c=relaxed/simple;
	bh=EspybNWz96a8SsKay7lVMYQKFHr61YfoXMkIgj6Tl7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=munryR3nivoTgCqXE74Q5tSsbxj+qyOEO6r2xi8xvc7L9Zy9+/KuNnV4Io+EJvP1JSc1Ik3+pOP9ve8eBPJ0RoOqiLDt3YCXb9GELBm/fbb5UPhmPzthVfwA7k6e0/9cAlDGYz1mI8g1F0GA58k2mA+HbdqHR/QT25kCzNMavZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d16oyZeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1087BC4CEEF;
	Tue, 17 Jun 2025 01:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124761;
	bh=EspybNWz96a8SsKay7lVMYQKFHr61YfoXMkIgj6Tl7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d16oyZeADeqR9u3zRA+w5UfU7lB/dG35/UmN8j3gOVSQKbq/zAmfccetoF7EtAxCp
	 SiPCDdiOG8sO8JlXOvogy0sc0f6/HRVD6jK7x1ilhjQVjWDmSc44tiTvEwmp6gJaXt
	 tPeK+MCZ8dU0M5r8Xx44iyKRLh/vkeJiFvyor3WO/vfR+byv8TjhbmSc+t0zsoJ37K
	 UxHJbL/nNsXextBXmy2kRCoHd54/dOLw4dbbGj6qLH69aBzAFk6LvjLgMY5HdOQHzB
	 F1uREn9SRSLaGC/aamD4cMVvGAOqQiwfFr/hSJwQYxLxZQXlI3WojWJJECbnkH2BPM
	 O4dpqDT82oI4w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shayagr@amazon.com,
	akiyano@amazon.com,
	darinzon@amazon.com,
	skalluru@marvell.com,
	manishc@marvell.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/5] eth: bnx2x: migrate to new RXFH callbacks
Date: Mon, 16 Jun 2025 18:45:51 -0700
Message-ID: <20250617014555.434790-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617014555.434790-1-kuba@kernel.org>
References: <20250617014555.434790-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").

The driver as no other RXNFC functionality so the SET callback can
be now removed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   | 33 ++++++++-----------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index 44199855ebfb..528ce9ca4f54 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -3318,8 +3318,11 @@ static int bnx2x_set_phys_id(struct net_device *dev,
 	return 0;
 }
 
-static int bnx2x_get_rss_flags(struct bnx2x *bp, struct ethtool_rxnfc *info)
+static int bnx2x_get_rxfh_fields(struct net_device *dev,
+				 struct ethtool_rxfh_fields *info)
 {
+	struct bnx2x *bp = netdev_priv(dev);
+
 	switch (info->flow_type) {
 	case TCP_V4_FLOW:
 	case TCP_V6_FLOW:
@@ -3361,20 +3364,21 @@ static int bnx2x_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 	case ETHTOOL_GRXRINGS:
 		info->data = BNX2X_NUM_ETH_QUEUES(bp);
 		return 0;
-	case ETHTOOL_GRXFH:
-		return bnx2x_get_rss_flags(bp, info);
 	default:
 		DP(BNX2X_MSG_ETHTOOL, "Command parameters not supported\n");
 		return -EOPNOTSUPP;
 	}
 }
 
-static int bnx2x_set_rss_flags(struct bnx2x *bp, struct ethtool_rxnfc *info)
+static int bnx2x_set_rxfh_fields(struct net_device *dev,
+				 const struct ethtool_rxfh_fields *info,
+				 struct netlink_ext_ack *extack)
 {
+	struct bnx2x *bp = netdev_priv(dev);
 	int udp_rss_requested;
 
 	DP(BNX2X_MSG_ETHTOOL,
-	   "Set rss flags command parameters: flow type = %d, data = %llu\n",
+	   "Set rss flags command parameters: flow type = %d, data = %u\n",
 	   info->flow_type, info->data);
 
 	switch (info->flow_type) {
@@ -3460,19 +3464,6 @@ static int bnx2x_set_rss_flags(struct bnx2x *bp, struct ethtool_rxnfc *info)
 	}
 }
 
-static int bnx2x_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
-{
-	struct bnx2x *bp = netdev_priv(dev);
-
-	switch (info->cmd) {
-	case ETHTOOL_SRXFH:
-		return bnx2x_set_rss_flags(bp, info);
-	default:
-		DP(BNX2X_MSG_ETHTOOL, "Command parameters not supported\n");
-		return -EOPNOTSUPP;
-	}
-}
-
 static u32 bnx2x_get_rxfh_indir_size(struct net_device *dev)
 {
 	return T_ETH_INDIRECTION_TABLE_SIZE;
@@ -3684,10 +3675,11 @@ static const struct ethtool_ops bnx2x_ethtool_ops = {
 	.set_phys_id		= bnx2x_set_phys_id,
 	.get_ethtool_stats	= bnx2x_get_ethtool_stats,
 	.get_rxnfc		= bnx2x_get_rxnfc,
-	.set_rxnfc		= bnx2x_set_rxnfc,
 	.get_rxfh_indir_size	= bnx2x_get_rxfh_indir_size,
 	.get_rxfh		= bnx2x_get_rxfh,
 	.set_rxfh		= bnx2x_set_rxfh,
+	.get_rxfh_fields	= bnx2x_get_rxfh_fields,
+	.set_rxfh_fields	= bnx2x_set_rxfh_fields,
 	.get_channels		= bnx2x_get_channels,
 	.set_channels		= bnx2x_set_channels,
 	.get_module_info	= bnx2x_get_module_info,
@@ -3711,10 +3703,11 @@ static const struct ethtool_ops bnx2x_vf_ethtool_ops = {
 	.get_strings		= bnx2x_get_strings,
 	.get_ethtool_stats	= bnx2x_get_ethtool_stats,
 	.get_rxnfc		= bnx2x_get_rxnfc,
-	.set_rxnfc		= bnx2x_set_rxnfc,
 	.get_rxfh_indir_size	= bnx2x_get_rxfh_indir_size,
 	.get_rxfh		= bnx2x_get_rxfh,
 	.set_rxfh		= bnx2x_set_rxfh,
+	.get_rxfh_fields	= bnx2x_get_rxfh_fields,
+	.set_rxfh_fields	= bnx2x_set_rxfh_fields,
 	.get_channels		= bnx2x_get_channels,
 	.set_channels		= bnx2x_set_channels,
 	.get_link_ksettings	= bnx2x_get_vf_link_ksettings,
-- 
2.49.0


