Return-Path: <netdev+bounces-198391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B68EADBED1
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD140172CD8
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1531D5CD7;
	Tue, 17 Jun 2025 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H909ojWF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768A1CAA85
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124938; cv=none; b=bEqgE6iguD6BoUCbwGtGW7FP/nVvXDCvX6gyA43PrEH86AxYoNv0y38tzuu4ymZqX2dpSl25I7o/YdC/T1zmS9fV2p6j7y3Yoo6ffUNe8Ys1JgmYOUZRM8W7ezEmlL/Xnru6NNCI6nvMTOc1MF/TWf0UwUBIGQPGeFccMiQV+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124938; c=relaxed/simple;
	bh=5tcrJk7SF/GeRc/9xSb3F8R/FhbMWcJGPwgG658le4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3yNEyqPRJS7osOoqQ46HbGHkpyF+7RCDnA42MEc2y/gP0MX4ui0ildpLzQ3CtNbOdov6rWNLTnLEblUs4xB7y89L5c//IHeyeaRO9UKepO04wSMVzUJ5xKiyh7KwtWGtBva+TglUsFL1W3wmGvbysfVwefuiwexL/ReDGocaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H909ojWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358A3C4CEF0;
	Tue, 17 Jun 2025 01:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124937;
	bh=5tcrJk7SF/GeRc/9xSb3F8R/FhbMWcJGPwgG658le4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H909ojWFzrXWo8RDrSfODN5+OiiGogi7aBKSG4Smz++E/A/YZ0cdgUH8l6IQGMoE6
	 uhprZU1/uMMfYyy9Or+LQjh/lqPMscU45F7A7aiGItbqH8CojawEK7XeRfkn56B8Gf
	 FUYhKBfN/KuhCVwBamAicCxVZp9xNnQncLXBGPcy4e0uacczzJG0k/TwgSZIUb9PMB
	 WvvugAOmjezoLxnSIlgfIxnZcBGPABDm0Wt1nQVub7vktRIiIL9zWxo3yhV+jk8JGL
	 8diD8l8p3inByPTSUAyvzrJYlzpBKLMJkv2mV0D2tn6kGQCzuULaQOjlt9Dj66qo6C
	 Xb7taOhR5pMew==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	madalin.bucur@nxp.com,
	ioana.ciornei@nxp.com,
	marcin.s.wojtas@gmail.com,
	bh74.an@samsung.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/5] eth: dpaa: migrate to new RXFH callbacks
Date: Mon, 16 Jun 2025 18:48:46 -0700
Message-ID: <20250617014848.436741-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617014848.436741-1-kuba@kernel.org>
References: <20250617014848.436741-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").

RXFH is all this driver supports in RXNFC so old callbacks are
completely removed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../ethernet/freescale/dpaa/dpaa_ethtool.c    | 44 +++----------------
 1 file changed, 7 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 9986f6e1f587..0c588e03b15e 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -263,8 +263,8 @@ static void dpaa_get_strings(struct net_device *net_dev, u32 stringset,
 		ethtool_puts(&data, dpaa_stats_global[i]);
 }
 
-static int dpaa_get_hash_opts(struct net_device *dev,
-			      struct ethtool_rxnfc *cmd)
+static int dpaa_get_rxfh_fields(struct net_device *dev,
+				struct ethtool_rxfh_fields *cmd)
 {
 	struct dpaa_priv *priv = netdev_priv(dev);
 
@@ -299,22 +299,6 @@ static int dpaa_get_hash_opts(struct net_device *dev,
 	return 0;
 }
 
-static int dpaa_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
-			  u32 *unused)
-{
-	int ret = -EOPNOTSUPP;
-
-	switch (cmd->cmd) {
-	case ETHTOOL_GRXFH:
-		ret = dpaa_get_hash_opts(dev, cmd);
-		break;
-	default:
-		break;
-	}
-
-	return ret;
-}
-
 static void dpaa_set_hash(struct net_device *net_dev, bool enable)
 {
 	struct mac_device *mac_dev;
@@ -329,8 +313,9 @@ static void dpaa_set_hash(struct net_device *net_dev, bool enable)
 	priv->keygen_in_use = enable;
 }
 
-static int dpaa_set_hash_opts(struct net_device *dev,
-			      struct ethtool_rxnfc *nfc)
+static int dpaa_set_rxfh_fields(struct net_device *dev,
+				const struct ethtool_rxfh_fields *nfc,
+				struct netlink_ext_ack *extack)
 {
 	int ret = -EINVAL;
 
@@ -364,21 +349,6 @@ static int dpaa_set_hash_opts(struct net_device *dev,
 	return ret;
 }
 
-static int dpaa_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
-{
-	int ret = -EOPNOTSUPP;
-
-	switch (cmd->cmd) {
-	case ETHTOOL_SRXFH:
-		ret = dpaa_set_hash_opts(dev, cmd);
-		break;
-	default:
-		break;
-	}
-
-	return ret;
-}
-
 static int dpaa_get_ts_info(struct net_device *net_dev,
 			    struct kernel_ethtool_ts_info *info)
 {
@@ -510,8 +480,8 @@ const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_strings = dpaa_get_strings,
 	.get_link_ksettings = dpaa_get_link_ksettings,
 	.set_link_ksettings = dpaa_set_link_ksettings,
-	.get_rxnfc = dpaa_get_rxnfc,
-	.set_rxnfc = dpaa_set_rxnfc,
+	.get_rxfh_fields = dpaa_get_rxfh_fields,
+	.set_rxfh_fields = dpaa_set_rxfh_fields,
 	.get_ts_info = dpaa_get_ts_info,
 	.get_coalesce = dpaa_get_coalesce,
 	.set_coalesce = dpaa_set_coalesce,
-- 
2.49.0


