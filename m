Return-Path: <netdev+bounces-197269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4BCAD7FD3
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26DE1E1E97
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B171DDC15;
	Fri, 13 Jun 2025 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leNv5Cbk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6BB1DD88F;
	Fri, 13 Jun 2025 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776090; cv=none; b=WkNu9YeWn0Q9Wx0lH4Z7JzbYzuLll6ja/H9fcEVrnQ0LxcuPdsoNnBppHeEUa3yn1Pq938NTwH2DIrI2qzdrbJcmTmlwDgE63SvzWgV6L5/By+RvS7M88pMbPRru+v922069z6SXgn3b858Q4Z5cQPp4yqftnD6/femz+YWxa6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776090; c=relaxed/simple;
	bh=SsO+MNe1Az5ByiLm8Bh5U58EJCIGRb6VA8Ycas7uXhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBIT+p85KxFB/wx2VrLNNPNFpdyRtZjHzq67uabX0PBdFYz4sOdVZyaiJyVDZGdJ0PR3sSLAIbTLZCxx+G0Z70ARsIgCohDbWMshGfcV9ZczuZAd6R7FqGC8AXa+TOkqnJyU+kx+As18TEDZDam1YwwdVKWBh0i1octcXxelcjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leNv5Cbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F271C4CEF0;
	Fri, 13 Jun 2025 00:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749776090;
	bh=SsO+MNe1Az5ByiLm8Bh5U58EJCIGRb6VA8Ycas7uXhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=leNv5Cbk3cj+heEDRMCrkGm0O7oxoo+rXIsCxTYQPBEre+KUq0uf0/86iChosp3iz
	 pjy6lxLQE1L1ae9kXuJodZ3qMHCohntjD9erblg/DBExJld1slfbt/Ot/MptIEx0sn
	 ReT5bamvhH32pQqQYLcS82aUHvIRv9Hh+87qmUuAb2Cky+Z2ZGrz54haENwJ3sEzOa
	 Ar8nNsP/cmPseE7k0Y8+Q9Hj1B7m1LpU5Z0DYRRBfvwkpcrWyBuvsMQhnGS4TFJ2Sv
	 5IcTBsvHNm4nizE929sA4SoeES6z/rfdk51HVrgmc9ZrIpszWcSf8L+YeHIk9LdXDc
	 DAZ/i+XsLUTig==
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
Subject: [PATCH net-next 5/6] eth: enetc: migrate to new RXFH callbacks
Date: Thu, 12 Jun 2025 17:54:08 -0700
Message-ID: <20250613005409.3544529-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613005409.3544529-1-kuba@kernel.org>
References: <20250613005409.3544529-1-kuba@kernel.org>
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
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index d38cd36be4a6..bb0512d585c1 100644
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
-- 
2.49.0


