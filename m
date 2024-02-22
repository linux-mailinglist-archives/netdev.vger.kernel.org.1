Return-Path: <netdev+bounces-74044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10CD85FB98
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD7A1C20A67
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67728148FFF;
	Thu, 22 Feb 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjeFeo4B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E21482FB
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613438; cv=none; b=ShS3bY1a1deCFjG6ZHKig0bgEjm9A7kNkADmpaJORhFBQr9APQ8RTIPK6TW3V7TyMXCTitoHsa9Z2U5AvmiM3fmVkPrlFh4Z/aQflFIN7sUq5yLQ45xbXYCdtzr+scU5udseGXWrzCn2kfjfj27kIV/g8n/tipVO+J6xdk9atus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613438; c=relaxed/simple;
	bh=YqRFN4LOB4soEKDh9rNGojnxZFHVm6gh55pZZG+9xjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YVyzQ46nOxGHMyN6pDzCWxyOU2b2ei4rFaIiFry+5AdSj19XVqNlFqUgKfBhtMDs+jndV6p/8y6dFRiDzi0qNdgo5pOLJDLKPPzzFMK2AE3Q8CkxTUS6LNw/iySc7rTZMuPcnG5j8rDmFbNvMGrJmjLNz2KnwpJ6e9qoE+cLiCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjeFeo4B; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708613436; x=1740149436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YqRFN4LOB4soEKDh9rNGojnxZFHVm6gh55pZZG+9xjs=;
  b=UjeFeo4Bg4R6ABSoDkgmVRE4kk6HLKuwdC7/IhXf2xpEMjN2nrJw5V+w
   9mJpj545Fnx6sTjsXsrYl8eebI69C2vVsMM0jvw2OH6xRfifY1UwWJNQS
   kx7ZFclBPZscowtzFuma4YiDEIVH97ddWD7ne36AaI/z80s6aegDxDk5K
   ctbgLTJ1/sBEbY64CwsJPgPiP+KBanDaRiMkyCEhUx4AhVVMSLcDcaK96
   2fzHqmd4hdtG52R/+NMZPJfyqVqtrnn+6/c0OqYpeYy6f3V+Rz7SkExva
   OklPMmfn5bBepA8Iuo6ZMUL2QNral1kxHPpaIsVrUwnC9LxEMlNoC4YN+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2949308"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2949308"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 06:50:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5670951"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa008.fm.intel.com with ESMTP; 22 Feb 2024 06:50:34 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-next 2/3] ice: avoid unnecessary devm_ usage
Date: Thu, 22 Feb 2024 15:50:24 +0100
Message-Id: <20240222145025.722515-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240222145025.722515-1-maciej.fijalkowski@intel.com>
References: <20240222145025.722515-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. pcaps are free'd right after AQ routines are done, no need for
   devm_'s
2. a test frame for loopback test in ethtool -t is destroyed at the end
   of the test so we don't need devm_ here either.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  | 23 +++++++++-----------
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  4 ++--
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 10c32cd80fff..6de93e12ead3 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1045,7 +1045,7 @@ int ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_sched;
 
-	pcaps = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*pcaps), GFP_KERNEL);
+	pcaps = kzalloc(sizeof(*pcaps), GFP_KERNEL);
 	if (!pcaps) {
 		status = -ENOMEM;
 		goto err_unroll_sched;
@@ -1055,7 +1055,7 @@ int ice_init_hw(struct ice_hw *hw)
 	status = ice_aq_get_phy_caps(hw->port_info, false,
 				     ICE_AQC_REPORT_TOPO_CAP_MEDIA, pcaps,
 				     NULL);
-	devm_kfree(ice_hw_to_dev(hw), pcaps);
+	kfree(pcaps);
 	if (status)
 		dev_warn(ice_hw_to_dev(hw), "Get PHY capabilities failed status = %d, continuing anyway\n",
 			 status);
@@ -1082,18 +1082,16 @@ int ice_init_hw(struct ice_hw *hw)
 
 	/* Get MAC information */
 	/* A single port can report up to two (LAN and WoL) addresses */
-	mac_buf = devm_kcalloc(ice_hw_to_dev(hw), 2,
-			       sizeof(struct ice_aqc_manage_mac_read_resp),
-			       GFP_KERNEL);
-	mac_buf_len = 2 * sizeof(struct ice_aqc_manage_mac_read_resp);
-
+	mac_buf = kcalloc(2, sizeof(struct ice_aqc_manage_mac_read_resp),
+			  GFP_KERNEL);
 	if (!mac_buf) {
 		status = -ENOMEM;
 		goto err_unroll_fltr_mgmt_struct;
 	}
 
+	mac_buf_len = 2 * sizeof(struct ice_aqc_manage_mac_read_resp);
 	status = ice_aq_manage_mac_read(hw, mac_buf, mac_buf_len, NULL);
-	devm_kfree(ice_hw_to_dev(hw), mac_buf);
+	kfree(mac_buf);
 
 	if (status)
 		goto err_unroll_fltr_mgmt_struct;
@@ -3244,15 +3242,14 @@ int ice_update_link_info(struct ice_port_info *pi)
 		struct ice_hw *hw;
 
 		hw = pi->hw;
-		pcaps = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*pcaps),
-				     GFP_KERNEL);
+		pcaps = kzalloc(sizeof(*pcaps), GFP_KERNEL);
 		if (!pcaps)
 			return -ENOMEM;
 
 		status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP_MEDIA,
 					     pcaps, NULL);
 
-		devm_kfree(ice_hw_to_dev(hw), pcaps);
+		kfree(pcaps);
 	}
 
 	return status;
@@ -3404,7 +3401,7 @@ ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
 	*aq_failures = 0;
 	hw = pi->hw;
 
-	pcaps = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*pcaps), GFP_KERNEL);
+	pcaps = kzalloc(sizeof(*pcaps), GFP_KERNEL);
 	if (!pcaps)
 		return -ENOMEM;
 
@@ -3456,7 +3453,7 @@ ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
 	}
 
 out:
-	devm_kfree(ice_hw_to_dev(hw), pcaps);
+	kfree(pcaps);
 	return status;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a19b06f18e40..cec3d796546e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -801,7 +801,7 @@ static int ice_lbtest_create_frame(struct ice_pf *pf, u8 **ret_data, u16 size)
 	if (!pf)
 		return -EINVAL;
 
-	data = devm_kzalloc(ice_pf_to_dev(pf), size, GFP_KERNEL);
+	data = kzalloc(size, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -1004,7 +1004,7 @@ static u64 ice_loopback_test(struct net_device *netdev)
 		ret = 10;
 
 lbtest_free_frame:
-	devm_kfree(dev, tx_frame);
+	kfree(tx_frame);
 remove_mac_filters:
 	if (ice_fltr_remove_mac(test_vsi, broadcast, ICE_FWD_TO_VSI))
 		netdev_err(netdev, "Could not remove MAC filter for the test VSI\n");
-- 
2.34.1


