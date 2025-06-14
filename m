Return-Path: <netdev+bounces-197813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89936AD9EBA
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B810B3B4740
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C82D2E764B;
	Sat, 14 Jun 2025 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc2oyWi/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381DF2E7648
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924555; cv=none; b=Ul2pusx1aHYTAR7hITf851ye/hBJwvZ6hHCS7f5G4tjxPEJ2LnJNVzDhS2GB6x0DdiDrEVdo8oehW6OLSkm3Ei1Mx274zz/8vwPvDLk+2+Jbm67GH/leDqRnUbdlZxiVObrGnv717HA0NH+BtPEmuTxYtmNP8IDg7RLG2sX7fE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924555; c=relaxed/simple;
	bh=KNIACJe6x9oNwcWL3LLP7JjD3ww7BSRVaLKKHwihEiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vi7mFa8MlnHUm7gmquo+4eADgE1ArZH8Kjw4ZmYh9WGqx24may7YZAP61+/hQ62XvtwsJYHPdn8cAzNnrGI8lY6MNgCGHfbY066o1gFy36eJSJdCyP6vpAfEFj0hw8zSOOQ2Gl3jiCo09XRwBquPyFktYb0r35Ka4yhsMyNPf7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc2oyWi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D58DC4AF09;
	Sat, 14 Jun 2025 18:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924555;
	bh=KNIACJe6x9oNwcWL3LLP7JjD3ww7BSRVaLKKHwihEiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bc2oyWi/Pynx1/B1TgAF9fDXjtYKaiVr+Xzq7/NbLlpYXTfWcZpIDhvPi0LIu2Aoh
	 qSB2eqPSPRd5nx7WWP+F+ZqhQ0wJF4W0EWvBNy/0Z02XT0hUN5+bnyR4CYdz+mkggF
	 wVrhcR6jpsWHGJBppHY6WcTxvTyQ2trrzEJhlW2TKES2+ebavdDUlBnYdt7Yh4rjqf
	 +HJ64aRRgp6Bh36SRwZhrWWSkVad/fHi9lbD/5wGrEuBwm9O7W4C6xVA2zR9WoztWr
	 x33bn6wZgN7VBAimQcazJ4XnJECbwD7B8Uzzpk+JP2j4uK29y8j2vLWXxpeqbEPARm
	 38hrBpU/hvZoQ==
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
Subject: [PATCH net-next v2 6/7] eth: ice: migrate to new RXFH callbacks
Date: Sat, 14 Jun 2025 11:09:06 -0700
Message-ID: <20250614180907.4167714-7-kuba@kernel.org>
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
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 59 ++++++--------------
 1 file changed, 18 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 5863a86482f5..ea7e8b879b48 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2797,14 +2797,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 	return err;
 }
 
-/**
- * ice_parse_hdrs - parses headers from RSS hash input
- * @nfc: ethtool rxnfc command
- *
- * This function parses the rxnfc command and returns intended
- * header types for RSS configuration
- */
-static u32 ice_parse_hdrs(struct ethtool_rxnfc *nfc)
+static u32 ice_parse_hdrs(const struct ethtool_rxfh_fields *nfc)
 {
 	u32 hdrs = ICE_FLOW_SEG_HDR_NONE;
 
@@ -2869,15 +2862,7 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *nfc)
 	return hdrs;
 }
 
-/**
- * ice_parse_hash_flds - parses hash fields from RSS hash input
- * @nfc: ethtool rxnfc command
- * @symm: true if Symmetric Topelitz is set
- *
- * This function parses the rxnfc command and returns intended
- * hash fields for RSS configuration
- */
-static u64 ice_parse_hash_flds(struct ethtool_rxnfc *nfc, bool symm)
+static u64 ice_parse_hash_flds(const struct ethtool_rxfh_fields *nfc, bool symm)
 {
 	u64 hfld = ICE_HASH_INVALID;
 
@@ -2974,16 +2959,13 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnfc *nfc, bool symm)
 	return hfld;
 }
 
-/**
- * ice_set_rss_hash_opt - Enable/Disable flow types for RSS hash
- * @vsi: the VSI being configured
- * @nfc: ethtool rxnfc command
- *
- * Returns Success if the flow input set is supported.
- */
 static int
-ice_set_rss_hash_opt(struct ice_vsi *vsi, struct ethtool_rxnfc *nfc)
+ice_set_rxfh_fields(struct net_device *netdev,
+		    const struct ethtool_rxfh_fields *nfc,
+		    struct netlink_ext_ack *extack)
 {
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
 	struct ice_rss_hash_cfg cfg;
 	struct device *dev;
@@ -3029,14 +3011,11 @@ ice_set_rss_hash_opt(struct ice_vsi *vsi, struct ethtool_rxnfc *nfc)
 	return 0;
 }
 
-/**
- * ice_get_rss_hash_opt - Retrieve hash fields for a given flow-type
- * @vsi: the VSI being configured
- * @nfc: ethtool rxnfc command
- */
-static void
-ice_get_rss_hash_opt(struct ice_vsi *vsi, struct ethtool_rxnfc *nfc)
+static int
+ice_get_rxfh_fields(struct net_device *netdev, struct ethtool_rxfh_fields *nfc)
 {
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
 	struct device *dev;
 	u64 hash_flds;
@@ -3049,21 +3028,21 @@ ice_get_rss_hash_opt(struct ice_vsi *vsi, struct ethtool_rxnfc *nfc)
 	if (ice_is_safe_mode(pf)) {
 		dev_dbg(dev, "Advanced RSS disabled. Package download failed, vsi num = %d\n",
 			vsi->vsi_num);
-		return;
+		return 0;
 	}
 
 	hdrs = ice_parse_hdrs(nfc);
 	if (hdrs == ICE_FLOW_SEG_HDR_NONE) {
 		dev_dbg(dev, "Header type is not valid, vsi num = %d\n",
 			vsi->vsi_num);
-		return;
+		return 0;
 	}
 
 	hash_flds = ice_get_rss_cfg(&pf->hw, vsi->idx, hdrs, &symm);
 	if (hash_flds == ICE_HASH_INVALID) {
 		dev_dbg(dev, "No hash fields found for the given header type, vsi num = %d\n",
 			vsi->vsi_num);
-		return;
+		return 0;
 	}
 
 	if (hash_flds & ICE_FLOW_HASH_FLD_IPV4_SA ||
@@ -3090,6 +3069,8 @@ ice_get_rss_hash_opt(struct ice_vsi *vsi, struct ethtool_rxnfc *nfc)
 	    hash_flds & ICE_FLOW_HASH_FLD_GTPU_UP_TEID ||
 	    hash_flds & ICE_FLOW_HASH_FLD_GTPU_DWN_TEID)
 		nfc->data |= (u64)RXH_GTP_TEID;
+
+	return 0;
 }
 
 /**
@@ -3109,8 +3090,6 @@ static int ice_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 		return ice_add_fdir_ethtool(vsi, cmd);
 	case ETHTOOL_SRXCLSRLDEL:
 		return ice_del_fdir_ethtool(vsi, cmd);
-	case ETHTOOL_SRXFH:
-		return ice_set_rss_hash_opt(vsi, cmd);
 	default:
 		break;
 	}
@@ -3153,10 +3132,6 @@ ice_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	case ETHTOOL_GRXCLSRLALL:
 		ret = ice_get_fdir_fltr_ids(hw, cmd, (u32 *)rule_locs);
 		break;
-	case ETHTOOL_GRXFH:
-		ice_get_rss_hash_opt(vsi, cmd);
-		ret = 0;
-		break;
 	default:
 		break;
 	}
@@ -4816,6 +4791,8 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.get_rxfh_indir_size	= ice_get_rxfh_indir_size,
 	.get_rxfh		= ice_get_rxfh,
 	.set_rxfh		= ice_set_rxfh,
+	.get_rxfh_fields	= ice_get_rxfh_fields,
+	.set_rxfh_fields	= ice_set_rxfh_fields,
 	.get_channels		= ice_get_channels,
 	.set_channels		= ice_set_channels,
 	.get_ts_info		= ice_get_ts_info,
-- 
2.49.0


