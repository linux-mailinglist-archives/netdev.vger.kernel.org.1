Return-Path: <netdev+bounces-198386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02574ADBECC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407927A9EEA
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F841D54E3;
	Tue, 17 Jun 2025 01:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohO2n604"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1D1CAA85
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124763; cv=none; b=bewkUuyPNeTs2wyfBlR2Q6tves3WvKajUzRCq2IBc8Qi1bREEGMk8jD2YnCc2RHGFlaEYnYZ2ulIPmRliNV78xCFiZb5bTQpSnoiaRyygqjN0btzXdJVNC4FbUsl24YoUHD2L0fkzWA+3FeV3pNeTqo9fKSiSAT9xt+sEPLgkC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124763; c=relaxed/simple;
	bh=sDaQTmzJ0ki97EaolxWkklsVwitCHqkQGZd+1szI5UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFtVfgbw43VK5PFa2jFtSF/FBQuxTU4rWAIxLeOQxldoFOasxVaDhn4b6rceIw7OdvOtDTN47EsDgPcXzB91JiM8wfnA61dfb0G15U77hQNRLQDxjtDKqet8mijBhXAaBEaXstGrGPys49IUDt0TwIeL5rtsfYx7AhxAlb/Z+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohO2n604; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259BFC4CEF0;
	Tue, 17 Jun 2025 01:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124763;
	bh=sDaQTmzJ0ki97EaolxWkklsVwitCHqkQGZd+1szI5UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohO2n604Im7lprmapQNo+6SgzsJEblPkeJAmo8Tozb1ksWqMlCaI+32oEzzajUciS
	 Li4VPSUnrSQxaMDDbFEfkG6a7WLTvzXiAhG/f/HWGw1u/zrixR2awGeccgQL/mC1Xy
	 Mm8+oqiuatol3Dgz8rqxv7G4g/kacJfBuyyfU/ssV+045xH8klfSVrG+S8OGMG92Iy
	 dKRFkVxSrzBqQb81M+A5o7bLtDuhowhn3B2B5qGYztOzl2DZJ8zHphf5vMSjKSMWdc
	 HELI00rVSfPjNUXsBWfFY/lJ2np5KfYWvqQD2kFT1O66Jh7gVgXgiufvYMkcaMd86a
	 mDiaGI00zf/Pw==
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
Subject: [PATCH net-next 4/5] eth: thunder: migrate to new RXFH callbacks
Date: Mon, 16 Jun 2025 18:45:54 -0700
Message-ID: <20250617014555.434790-5-kuba@kernel.org>
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
 .../ethernet/cavium/thunder/nicvf_ethtool.c   | 37 +++++++------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
index d0ff0c170b1a..fc6053414b7d 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
@@ -516,8 +516,8 @@ static int nicvf_set_ringparam(struct net_device *netdev,
 	return 0;
 }
 
-static int nicvf_get_rss_hash_opts(struct nicvf *nic,
-				   struct ethtool_rxnfc *info)
+static int nicvf_get_rxfh_fields(struct net_device *dev,
+				 struct ethtool_rxfh_fields *info)
 {
 	info->data = 0;
 
@@ -552,25 +552,28 @@ static int nicvf_get_rxnfc(struct net_device *dev,
 		info->data = nic->rx_queues;
 		ret = 0;
 		break;
-	case ETHTOOL_GRXFH:
-		return nicvf_get_rss_hash_opts(nic, info);
 	default:
 		break;
 	}
 	return ret;
 }
 
-static int nicvf_set_rss_hash_opts(struct nicvf *nic,
-				   struct ethtool_rxnfc *info)
+static int nicvf_set_rxfh_fields(struct net_device *dev,
+				 const struct ethtool_rxfh_fields *info,
+				 struct netlink_ext_ack *extack)
 {
-	struct nicvf_rss_info *rss = &nic->rss_info;
-	u64 rss_cfg = nicvf_reg_read(nic, NIC_VNIC_RSS_CFG);
+	struct nicvf *nic = netdev_priv(dev);
+	struct nicvf_rss_info *rss;
+	u64 rss_cfg;
+
+	rss = &nic->rss_info;
+	rss_cfg = nicvf_reg_read(nic, NIC_VNIC_RSS_CFG);
 
 	if (!rss->enable)
 		netdev_err(nic->netdev,
 			   "RSS is disabled, hash cannot be set\n");
 
-	netdev_info(nic->netdev, "Set RSS flow type = %d, data = %lld\n",
+	netdev_info(nic->netdev, "Set RSS flow type = %d, data = %u\n",
 		    info->flow_type, info->data);
 
 	if (!(info->data & RXH_IP_SRC) || !(info->data & RXH_IP_DST))
@@ -628,19 +631,6 @@ static int nicvf_set_rss_hash_opts(struct nicvf *nic,
 	return 0;
 }
 
-static int nicvf_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
-{
-	struct nicvf *nic = netdev_priv(dev);
-
-	switch (info->cmd) {
-	case ETHTOOL_SRXFH:
-		return nicvf_set_rss_hash_opts(nic, info);
-	default:
-		break;
-	}
-	return -EOPNOTSUPP;
-}
-
 static u32 nicvf_get_rxfh_key_size(struct net_device *netdev)
 {
 	return RSS_HASH_KEY_SIZE * sizeof(u64);
@@ -872,11 +862,12 @@ static const struct ethtool_ops nicvf_ethtool_ops = {
 	.get_ringparam		= nicvf_get_ringparam,
 	.set_ringparam		= nicvf_set_ringparam,
 	.get_rxnfc		= nicvf_get_rxnfc,
-	.set_rxnfc		= nicvf_set_rxnfc,
 	.get_rxfh_key_size	= nicvf_get_rxfh_key_size,
 	.get_rxfh_indir_size	= nicvf_get_rxfh_indir_size,
 	.get_rxfh		= nicvf_get_rxfh,
 	.set_rxfh		= nicvf_set_rxfh,
+	.get_rxfh_fields	= nicvf_get_rxfh_fields,
+	.set_rxfh_fields	= nicvf_set_rxfh_fields,
 	.get_channels		= nicvf_get_channels,
 	.set_channels		= nicvf_set_channels,
 	.get_pauseparam         = nicvf_get_pauseparam,
-- 
2.49.0


