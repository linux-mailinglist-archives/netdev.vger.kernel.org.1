Return-Path: <netdev+bounces-197814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B191AAD9EBB
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE653B43A1
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6353D2E7F08;
	Sat, 14 Jun 2025 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNK4W8Hj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7B7DA6A
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924556; cv=none; b=AAiteXCzrAJYlSI9pm0g5vxbO7K++OszUDDI3bteXgyMSRo7jFJlPKeAl6FNlnpnq+yYTrvtJj5Fe7H53PPDKrwncg651546tx0qe1eozigY4LQJ+nusS7uxoxXSmt/gTdVY8DW0foHcIHTWkeG0oBAd/SuzNEZeoYCiT87ibGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924556; c=relaxed/simple;
	bh=X0mP9OHWTTAw1gQ3zIlbt3YiOvIsGkRLLNr6heRWY0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrwnwpHTa/O3n+UDDg7aiOFhbKIzo3xUUtlu/tbM2MA72uJ3bkN7z2Tf8pbt7LERjPzRhcZsLa0KOzwFB/pnPmsW9Y18HdtPTiFYfL9xzsOi1WsYg4tE+oLeQHb1nYo3ec/UgeqAet36K5Udzw1gVEWdqCQGwGp5qi0pSjlU1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNK4W8Hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E4EC4CEF0;
	Sat, 14 Jun 2025 18:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924555;
	bh=X0mP9OHWTTAw1gQ3zIlbt3YiOvIsGkRLLNr6heRWY0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNK4W8Hj85ZZ33too2Rt1MVCX5IGDObS0slyViC5x76LPtPfJnG4i1sDy8dGkkmZj
	 gM7YGPZmXw7May9y5wbLSOCwj39An9gH0bB6kWKuDXxrzgLyV/33w0V9ymjOtu3DjE
	 /iLrJUpw9lclvV9jfoTr4FEcjNOFf9bRwK7IK4xgoy4o7N99kXBvSiblJmW78kDFmx
	 k6IKMSr603V05M6EmMOX0pjrsATrQ09s/5yULl58WN6nac8P0u7D+KMYffuy8C1j7i
	 qMggOEVoFHQQbSAk7XLNDqWAIeTS90yicPHtz6NBlBVN3aQK1FVv7RNA7Sh2n0YoBU
	 e9LNArsYxxPxw==
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
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v2 7/7] eth: iavf: migrate to new RXFH callbacks
Date: Sat, 14 Jun 2025 11:09:07 -0700
Message-ID: <20250614180907.4167714-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614180907.4167714-1-kuba@kernel.org>
References: <20250614180907.4167714-1-kuba@kernel.org>
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

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
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


