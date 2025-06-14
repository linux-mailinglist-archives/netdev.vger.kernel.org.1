Return-Path: <netdev+bounces-197806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2702DAD9EA0
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177F11897C6D
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E632E7622;
	Sat, 14 Jun 2025 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtM5VDc1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7032E6D3C;
	Sat, 14 Jun 2025 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924411; cv=none; b=I4xTKiQjiTLvieM1OE8MRvtPID4Hb4DTmgMTkscpCnmYOm0oAh+yYK8Jni58sK+tSKy+Kj2THn/XZyhJW9E6xbWOLP72Fbb/4Pfop/ZmBwg9LTned3XaBWyTYZ/1AQEiXk8XWsH7jVcEXzCzqUP/6eHf5dLdQZHmz6ioQTBkIPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924411; c=relaxed/simple;
	bh=97fs4u8wMXHIZzEqobzRgcDOYb1oEzVs+qGSHU+gphU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vClaizFu4i5DDh8QT6j5yZtvtS94RbbWiaAi18UdwmJlyT3NUw8XWI/Pv6LRoAgSJRLOciK4ZFNAyD5nrSXqY3i++sdlMn3rbXEYRu0MdvmSm6JzOqoSnmd6a1sX+uBuxL18KO/z2wYJun0V5UwmiXn96xmNrzWS9GCEaBAr6Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtM5VDc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F022C4CEF2;
	Sat, 14 Jun 2025 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924411;
	bh=97fs4u8wMXHIZzEqobzRgcDOYb1oEzVs+qGSHU+gphU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtM5VDc1LXVU36Na699+jO2DQX357qzu2luSdCMrsipiRISMaP64mrl9JXYPla12x
	 1Pf83kjADH5Pr9Zmvytol9XJ6sfxC8pkEBzCWZ1zmotXKJN4Z6M622guLTA49aEOGe
	 r9fuReAKnbvruYvRsKHqugzdl8BQvMy9Q2SpvFN73DnvxYDf9BJS1nQW2CF/hF6be9
	 qbW9ZH2eX+RHubQmnl//8pAD0i44yaFusnSra41myrRouEm1n8w/e9JUHzfM8SVwLU
	 BaTkKL3zW7ChDer7WxwmsxC1MqmzmAyO2y1fRZ9yrnUN72UZ7yA9fWsvGIA/qe2V/k
	 lNEOi/LxJkipQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bharat@chelsio.com,
	benve@cisco.com,
	satishkh@cisco.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	bryan.whitehead@microchip.com,
	ecree.xilinx@gmail.com,
	rosenp@gmail.com,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 5/5] eth: enetc: migrate to new RXFH callbacks
Date: Sat, 14 Jun 2025 11:06:38 -0700
Message-ID: <20250614180638.4166766-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614180638.4166766-1-kuba@kernel.org>
References: <20250614180638.4166766-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").
This driver's RXFH config is read only / fixed so the conversion
is trivial.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - add get_rxfh_fields to enetc4_pf_ethtool_ops
v1: https://lore.kernel.org/20250613005409.3544529-6-kuba@kernel.org
---
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index d38cd36be4a6..2e5cef646741 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -467,7 +467,8 @@ static void enetc_get_rmon_stats(struct net_device *ndev,
 #define ENETC_RSSHASH_L3 (RXH_L2DA | RXH_VLAN | RXH_L3_PROTO | RXH_IP_SRC | \
 			  RXH_IP_DST)
 #define ENETC_RSSHASH_L4 (ENETC_RSSHASH_L3 | RXH_L4_B_0_1 | RXH_L4_B_2_3)
-static int enetc_get_rsshash(struct ethtool_rxnfc *rxnfc)
+static int enetc_get_rxfh_fields(struct net_device *netdev,
+				 struct ethtool_rxfh_fields *rxnfc)
 {
 	static const u32 rsshash[] = {
 			[TCP_V4_FLOW]    = ENETC_RSSHASH_L4,
@@ -584,9 +585,6 @@ static int enetc_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc,
 	case ETHTOOL_GRXRINGS:
 		rxnfc->data = priv->num_rx_rings;
 		break;
-	case ETHTOOL_GRXFH:
-		/* get RSS hash config */
-		return enetc_get_rsshash(rxnfc);
 	case ETHTOOL_GRXCLSRLCNT:
 		/* total number of entries */
 		rxnfc->data = priv->si->num_fs_entries;
@@ -639,8 +637,6 @@ static int enetc4_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc
 	case ETHTOOL_GRXRINGS:
 		rxnfc->data = priv->num_rx_rings;
 		break;
-	case ETHTOOL_GRXFH:
-		return enetc_get_rsshash(rxnfc);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1228,6 +1224,7 @@ const struct ethtool_ops enetc_pf_ethtool_ops = {
 	.get_rxfh_indir_size = enetc_get_rxfh_indir_size,
 	.get_rxfh = enetc_get_rxfh,
 	.set_rxfh = enetc_set_rxfh,
+	.get_rxfh_fields = enetc_get_rxfh_fields,
 	.get_ringparam = enetc_get_ringparam,
 	.get_coalesce = enetc_get_coalesce,
 	.set_coalesce = enetc_set_coalesce,
@@ -1258,6 +1255,7 @@ const struct ethtool_ops enetc_vf_ethtool_ops = {
 	.get_rxfh_indir_size = enetc_get_rxfh_indir_size,
 	.get_rxfh = enetc_get_rxfh,
 	.set_rxfh = enetc_set_rxfh,
+	.get_rxfh_fields = enetc_get_rxfh_fields,
 	.get_ringparam = enetc_get_ringparam,
 	.get_coalesce = enetc_get_coalesce,
 	.set_coalesce = enetc_set_coalesce,
@@ -1284,6 +1282,7 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
 	.get_rxfh_indir_size = enetc_get_rxfh_indir_size,
 	.get_rxfh = enetc_get_rxfh,
 	.set_rxfh = enetc_set_rxfh,
+	.get_rxfh_fields = enetc_get_rxfh_fields,
 };
 
 void enetc_set_ethtool_ops(struct net_device *ndev)
-- 
2.49.0


