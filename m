Return-Path: <netdev+bounces-198387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BD7ADBECD
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 735AC7AA19A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60211DF968;
	Tue, 17 Jun 2025 01:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sdoscsu9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F471DE8BE
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124764; cv=none; b=lC1M9CfhLZvZYGSi36Twhrgymvk6jlahXGrIeSvTtNXZTlGshGOcZUH6ZSxb0wZcff04BD3Zf30YioN7EEIAWUiidFMFOALcBNtfp6NM6p1Pfzxl1bwwx8V+jfIfbH68qESO3n6RR314VKG5EaJ6w3T7NW6A0eUmdJC8C2s9hCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124764; c=relaxed/simple;
	bh=lzewaCuLW9tG2qNnOkRhxU/Euv4gGtP55yyt5ceAUwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zzjk/c6omqpqDd/+xJ7QM77uqRB+IM2OSL+MhpeFZXbMWDgETWv68gW9KmK68sWvMih5FC/6ggDDqHijW7X970loMOHKZ4i0i53gbPR1PXFgaKm2tzbsyKOj6t+E0DdKvyS0+UcncvGiYKhTtlEfwyBLI2IVeCxP6db4lPNNOkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sdoscsu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEFCC4CEEF;
	Tue, 17 Jun 2025 01:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124764;
	bh=lzewaCuLW9tG2qNnOkRhxU/Euv4gGtP55yyt5ceAUwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sdoscsu9nTbsqrjKadPOBmSgFnPvrAsL2Pyms42p1d4FR8VBh801T+nZrb+cJM7qQ
	 9Gx0zcA/yrEg+uvTo3zaquOk1gJI8Qr4FjIXXJwxiWJaHzLZEDX8nZosZIYVVJJOMO
	 jH3naQriq2QhxNZolf9iREOrQHDnqFwI22eCAnpN4bMMJ/u40upOYgle6JMJUpLwei
	 cxb5QLGjlV7nCoZRhKRzikduDihtyTOPVegR1CfSo0yG0uuO8Do5qepBQMV6FfbIlJ
	 QodKCgwWV0THiiMNFULqyyvj/e6Cz9bdZtGaTUgYMtGjgf0/PigNyUW1cupqe5/759
	 CZ0KIlLhY7IDw==
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
Subject: [PATCH net-next 5/5] eth: otx2: migrate to new RXFH callbacks
Date: Mon, 16 Jun 2025 18:45:55 -0700
Message-ID: <20250617014555.434790-6-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../marvell/octeontx2/nic/otx2_ethtool.c      | 31 ++++++++++++-------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 45b8c9230184..9b7f847b9c22 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -559,10 +559,13 @@ static int otx2_set_coalesce(struct net_device *netdev,
 	return 0;
 }
 
-static int otx2_get_rss_hash_opts(struct otx2_nic *pfvf,
-				  struct ethtool_rxnfc *nfc)
+static int otx2_get_rss_hash_opts(struct net_device *dev,
+				  struct ethtool_rxfh_fields *nfc)
 {
-	struct otx2_rss_info *rss = &pfvf->hw.rss_info;
+	struct otx2_nic *pfvf = netdev_priv(dev);
+	struct otx2_rss_info *rss;
+
+	rss = &pfvf->hw.rss_info;
 
 	if (!(rss->flowkey_cfg &
 	    (NIX_FLOW_KEY_TYPE_IPV4 | NIX_FLOW_KEY_TYPE_IPV6)))
@@ -609,12 +612,17 @@ static int otx2_get_rss_hash_opts(struct otx2_nic *pfvf,
 	return 0;
 }
 
-static int otx2_set_rss_hash_opts(struct otx2_nic *pfvf,
-				  struct ethtool_rxnfc *nfc)
+static int otx2_set_rss_hash_opts(struct net_device *dev,
+				  const struct ethtool_rxfh_fields *nfc,
+				  struct netlink_ext_ack *extack)
 {
-	struct otx2_rss_info *rss = &pfvf->hw.rss_info;
+	struct otx2_nic *pfvf = netdev_priv(dev);
 	u32 rxh_l4 = RXH_L4_B_0_1 | RXH_L4_B_2_3;
-	u32 rss_cfg = rss->flowkey_cfg;
+	struct otx2_rss_info *rss;
+	u32 rss_cfg;
+
+	rss = &pfvf->hw.rss_info;
+	rss_cfg = rss->flowkey_cfg;
 
 	if (!rss->enable) {
 		netdev_err(pfvf->netdev,
@@ -743,8 +751,6 @@ static int otx2_get_rxnfc(struct net_device *dev,
 		if (netif_running(dev) && ntuple)
 			ret = otx2_get_all_flows(pfvf, nfc, rules);
 		break;
-	case ETHTOOL_GRXFH:
-		return otx2_get_rss_hash_opts(pfvf, nfc);
 	default:
 		break;
 	}
@@ -759,9 +765,6 @@ static int otx2_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *nfc)
 
 	pfvf->flow_cfg->ntuple = ntuple;
 	switch (nfc->cmd) {
-	case ETHTOOL_SRXFH:
-		ret = otx2_set_rss_hash_opts(pfvf, nfc);
-		break;
 	case ETHTOOL_SRXCLSRLINS:
 		if (netif_running(dev) && ntuple)
 			ret = otx2_add_flow(pfvf, nfc);
@@ -1329,6 +1332,8 @@ static const struct ethtool_ops otx2_ethtool_ops = {
 	.get_rxfh_indir_size	= otx2_get_rxfh_indir_size,
 	.get_rxfh		= otx2_get_rxfh,
 	.set_rxfh		= otx2_set_rxfh,
+	.get_rxfh_fields	= otx2_get_rss_hash_opts,
+	.set_rxfh_fields	= otx2_set_rss_hash_opts,
 	.get_msglevel		= otx2_get_msglevel,
 	.set_msglevel		= otx2_set_msglevel,
 	.get_pauseparam		= otx2_get_pauseparam,
@@ -1442,6 +1447,8 @@ static const struct ethtool_ops otx2vf_ethtool_ops = {
 	.get_rxfh_indir_size	= otx2_get_rxfh_indir_size,
 	.get_rxfh		= otx2_get_rxfh,
 	.set_rxfh		= otx2_set_rxfh,
+	.get_rxfh_fields	= otx2_get_rss_hash_opts,
+	.set_rxfh_fields	= otx2_set_rss_hash_opts,
 	.get_ringparam		= otx2_get_ringparam,
 	.set_ringparam		= otx2_set_ringparam,
 	.get_coalesce		= otx2_get_coalesce,
-- 
2.49.0


