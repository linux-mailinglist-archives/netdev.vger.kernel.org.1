Return-Path: <netdev+bounces-197278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F975AD7FF5
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C3D189800B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A410E1DFD86;
	Fri, 13 Jun 2025 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgv6xrFS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D81DF987
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776499; cv=none; b=ceMpExV04U9likPO2PVK3Kj7leZT0lgo9bvwE2KCD/9ik9e3GrBjay6myKGUSwjINxXKJdrQ/bGryy7Lc6umZ0oaeCJ6F56WvvBlr5l6Cl5aJdrM9U9QUIvJVo6eXJ5BOzpwC9yRHxB2XbhhtBhOabkWmPP58n3gKwq43KQqTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776499; c=relaxed/simple;
	bh=iqaX8+NFX5CbJ1m2/rcDhdqFSndIMpO0hb8Vmrtf3A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pn+HK/+lqFNIwRmghZz9wqZYWc1NmP32Nh0LYXVcAAaJnrQ66rG4K4uGII1dEzhqxgIV3RbxAAhgh0DbWYulGlzRO6lNA7sHHQJzD298p9CRzcOXLQg3MZFX9+4uRqxirrBAph17VABW47XTkfy+v5XYarrw0U1mU0tUGkHsOwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qgv6xrFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87865C4CEF1;
	Fri, 13 Jun 2025 01:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749776499;
	bh=iqaX8+NFX5CbJ1m2/rcDhdqFSndIMpO0hb8Vmrtf3A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qgv6xrFSoOcY1EMisRQYX+kh/RFwAQpAMN9+c06Tuho7dLA2ADAnj/w95X3Yv2Qj8
	 15DFXJN+oV9vXAgSP1uj1T8KfBFe0fQLAdsLDf9UjC+2fenCHSF8JZYnBZ5VPw1ffD
	 DfvW7jD9EJqelOMWGTtySgCyMsAUN0kXLAiajYsg0apGjhPS1WCtx+qbFy0USYNQO8
	 GkwBr/pyW5jNa6HP00dZz6ceeTXtctyLpT1ZQuSn/x6RecHPcmpy98AzzM4oBgmH1W
	 Al2vcP+snPADDXv6DFdtsOvwtwqTkLDpK1tSEgUmxOa4N6bYrPTuRLYE56mr0012ZY
	 DNE3MumUoV4Jg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 7/7] eth: iavf: migrate to new RXFH callbacks
Date: Thu, 12 Jun 2025 18:01:11 -0700
Message-ID: <20250613010111.3548291-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613010111.3548291-1-kuba@kernel.org>
References: <20250613010111.3548291-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").

I'm deleting all the boilerplate kdoc from the affected functions.
It is somewhere between pointless and incorrect, just a burden for
people refactoring the code.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 52 ++++---------------
 1 file changed, 11 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 2b2b315205b5..05d72be3fe80 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1307,14 +1307,7 @@ static int iavf_del_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	return iavf_fdir_del_fltr(adapter, false, fsp->location);
 }
 
-/**
- * iavf_adv_rss_parse_hdrs - parses headers from RSS hash input
- * @cmd: ethtool rxnfc command
- *
- * This function parses the rxnfc command and returns intended
- * header types for RSS configuration
- */
-static u32 iavf_adv_rss_parse_hdrs(struct ethtool_rxnfc *cmd)
+static u32 iavf_adv_rss_parse_hdrs(const struct ethtool_rxfh_fields *cmd)
 {
 	u32 hdrs = IAVF_ADV_RSS_FLOW_SEG_HDR_NONE;
 
@@ -1350,15 +1343,8 @@ static u32 iavf_adv_rss_parse_hdrs(struct ethtool_rxnfc *cmd)
 	return hdrs;
 }
 
-/**
- * iavf_adv_rss_parse_hash_flds - parses hash fields from RSS hash input
- * @cmd: ethtool rxnfc command
- * @symm: true if Symmetric Topelitz is set
- *
- * This function parses the rxnfc command and returns intended hash fields for
- * RSS configuration
- */
-static u64 iavf_adv_rss_parse_hash_flds(struct ethtool_rxnfc *cmd, bool symm)
+static u64
+iavf_adv_rss_parse_hash_flds(const struct ethtool_rxfh_fields *cmd, bool symm)
 {
 	u64 hfld = IAVF_ADV_RSS_HASH_INVALID;
 
@@ -1416,17 +1402,12 @@ static u64 iavf_adv_rss_parse_hash_flds(struct ethtool_rxnfc *cmd, bool symm)
 	return hfld;
 }
 
-/**
- * iavf_set_adv_rss_hash_opt - Enable/Disable flow types for RSS hash
- * @adapter: pointer to the VF adapter structure
- * @cmd: ethtool rxnfc command
- *
- * Returns Success if the flow input set is supported.
- */
 static int
-iavf_set_adv_rss_hash_opt(struct iavf_adapter *adapter,
-			  struct ethtool_rxnfc *cmd)
+iavf_set_rxfh_fields(struct net_device *netdev,
+		     const struct ethtool_rxfh_fields *cmd,
+		     struct netlink_ext_ack *extack)
 {
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	struct iavf_adv_rss *rss_old, *rss_new;
 	bool rss_new_add = false;
 	bool symm = false;
@@ -1493,17 +1474,10 @@ iavf_set_adv_rss_hash_opt(struct iavf_adapter *adapter,
 	return err;
 }
 
-/**
- * iavf_get_adv_rss_hash_opt - Retrieve hash fields for a given flow-type
- * @adapter: pointer to the VF adapter structure
- * @cmd: ethtool rxnfc command
- *
- * Returns Success if the flow input set is supported.
- */
 static int
-iavf_get_adv_rss_hash_opt(struct iavf_adapter *adapter,
-			  struct ethtool_rxnfc *cmd)
+iavf_get_rxfh_fields(struct net_device *netdev, struct ethtool_rxfh_fields *cmd)
 {
+	struct iavf_adapter *adapter = netdev_priv(netdev);
 	struct iavf_adv_rss *rss;
 	u64 hash_flds;
 	u32 hdrs;
@@ -1568,9 +1542,6 @@ static int iavf_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 	case ETHTOOL_SRXCLSRLDEL:
 		ret = iavf_del_fdir_ethtool(adapter, cmd);
 		break;
-	case ETHTOOL_SRXFH:
-		ret = iavf_set_adv_rss_hash_opt(adapter, cmd);
-		break;
 	default:
 		break;
 	}
@@ -1612,9 +1583,6 @@ static int iavf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	case ETHTOOL_GRXCLSRLALL:
 		ret = iavf_get_fdir_fltr_ids(adapter, cmd, (u32 *)rule_locs);
 		break;
-	case ETHTOOL_GRXFH:
-		ret = iavf_get_adv_rss_hash_opt(adapter, cmd);
-		break;
 	default:
 		break;
 	}
@@ -1812,6 +1780,8 @@ static const struct ethtool_ops iavf_ethtool_ops = {
 	.get_rxfh_indir_size	= iavf_get_rxfh_indir_size,
 	.get_rxfh		= iavf_get_rxfh,
 	.set_rxfh		= iavf_set_rxfh,
+	.get_rxfh_fields	= iavf_get_rxfh_fields,
+	.set_rxfh_fields	= iavf_set_rxfh_fields,
 	.get_channels		= iavf_get_channels,
 	.set_channels		= iavf_set_channels,
 	.get_rxfh_key_size	= iavf_get_rxfh_key_size,
-- 
2.49.0


