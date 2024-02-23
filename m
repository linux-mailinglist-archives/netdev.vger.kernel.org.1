Return-Path: <netdev+bounces-74473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3080186170C
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 17:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626D41C21291
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7398662B;
	Fri, 23 Feb 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxYMEKsd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC4C8565A
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704400; cv=none; b=tzzZEZDXrTtujvGZW6L6Qj8bR09MthMpW/j/ogCl994czu77WWyV8LLdXENrWJCGMzG3h8Bn0YWvKfns4Gjcg0wkaxaHvnVyG5qBp+cECOSVMfDvOJRvlD4klw31pLwUWPVFeIgXIlZ2h8lqr1ts4XKKeDK2opH5CG7PI4FT15w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704400; c=relaxed/simple;
	bh=0iiCC+b5YFY1rm3bvCk7VuHahm1aDlPhHiz0U2+D2yQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fc/jTSVoVpUHXvxCCXmjANZga1nMAVMwr835OAkt70TeqPicpb6M4KuOBuBjSz3HGD6ZXKZ2RRppG04sgDCrMQHrhU7X3d7zM9D8cBuR25AnclCYpN/b7MnrZa28k867kfl6xag8EgrQy/oNS2ri8bB3lP3hHl79SDSAEBxmVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxYMEKsd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708704399; x=1740240399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0iiCC+b5YFY1rm3bvCk7VuHahm1aDlPhHiz0U2+D2yQ=;
  b=nxYMEKsdz38pFo0hSoSsa5V05Ini2QWN9M1WFo3sW4hmp6vPyDtuTPSz
   Yr56ZWG3dvkbuBnzSGfBwwGPuC5usq3D1yj38c8gc/EFcA7FX36d42/1o
   bTj9A+X3h+yvCLxlOE0hnVyyQWHh2BUb9A5f7fzfdsSV+k6jZMGnC9CGT
   SB0xoNFy8Q36MHHobeGgqMTva43KMqo77J9qxAxWbDNtJ7tBa/Pc/v2mm
   N+a0dnIfPGRHdktBrbI6Z60aSv/jKbbC5MVWdTUnfPP6506lofMcz0OG5
   GgI4ndbqaNKeZv+mtikOpC7LNzNP6yktn0raHic52rPi9XzyOYy3FU/Kv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="14454679"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="14454679"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 08:06:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6161967"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa006.fm.intel.com with ESMTP; 23 Feb 2024 08:06:36 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	przemyslaw.kitszel@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 iwl-next 2/3] ice: avoid unnecessary devm_ usage
Date: Fri, 23 Feb 2024 17:06:28 +0100
Message-Id: <20240223160629.729433-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240223160629.729433-1-maciej.fijalkowski@intel.com>
References: <20240223160629.729433-1-maciej.fijalkowski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_common.c  | 34 +++++++-------------
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 ++----
 2 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 10c32cd80fff..a987dc063946 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -965,9 +965,9 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
  */
 int ice_init_hw(struct ice_hw *hw)
 {
-	struct ice_aqc_get_phy_caps_data *pcaps;
+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
+	void *mac_buf __free(kfree);
 	u16 mac_buf_len;
-	void *mac_buf;
 	int status;
 
 	/* Set MAC type based on DeviceID */
@@ -1045,7 +1045,7 @@ int ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_sched;
 
-	pcaps = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*pcaps), GFP_KERNEL);
+	pcaps = kzalloc(sizeof(*pcaps), GFP_KERNEL);
 	if (!pcaps) {
 		status = -ENOMEM;
 		goto err_unroll_sched;
@@ -1055,7 +1055,6 @@ int ice_init_hw(struct ice_hw *hw)
 	status = ice_aq_get_phy_caps(hw->port_info, false,
 				     ICE_AQC_REPORT_TOPO_CAP_MEDIA, pcaps,
 				     NULL);
-	devm_kfree(ice_hw_to_dev(hw), pcaps);
 	if (status)
 		dev_warn(ice_hw_to_dev(hw), "Get PHY capabilities failed status = %d, continuing anyway\n",
 			 status);
@@ -1082,18 +1081,15 @@ int ice_init_hw(struct ice_hw *hw)
 
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
 
 	if (status)
 		goto err_unroll_fltr_mgmt_struct;
@@ -3240,19 +3236,14 @@ int ice_update_link_info(struct ice_port_info *pi)
 		return status;
 
 	if (li->link_info & ICE_AQ_MEDIA_AVAILABLE) {
-		struct ice_aqc_get_phy_caps_data *pcaps;
-		struct ice_hw *hw;
+		struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
 
-		hw = pi->hw;
-		pcaps = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*pcaps),
-				     GFP_KERNEL);
+		pcaps = kzalloc(sizeof(*pcaps), GFP_KERNEL);
 		if (!pcaps)
 			return -ENOMEM;
 
 		status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP_MEDIA,
 					     pcaps, NULL);
-
-		devm_kfree(ice_hw_to_dev(hw), pcaps);
 	}
 
 	return status;
@@ -3393,8 +3384,8 @@ ice_cfg_phy_fc(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 int
 ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
 {
+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
 	struct ice_aqc_set_phy_cfg_data cfg = { 0 };
-	struct ice_aqc_get_phy_caps_data *pcaps;
 	struct ice_hw *hw;
 	int status;
 
@@ -3404,7 +3395,7 @@ ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
 	*aq_failures = 0;
 	hw = pi->hw;
 
-	pcaps = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*pcaps), GFP_KERNEL);
+	pcaps = kzalloc(sizeof(*pcaps), GFP_KERNEL);
 	if (!pcaps)
 		return -ENOMEM;
 
@@ -3456,7 +3447,6 @@ ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
 	}
 
 out:
-	devm_kfree(ice_hw_to_dev(hw), pcaps);
 	return status;
 }
 
@@ -3535,7 +3525,7 @@ int
 ice_cfg_phy_fec(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 		enum ice_fec_mode fec)
 {
-	struct ice_aqc_get_phy_caps_data *pcaps;
+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
 	struct ice_hw *hw;
 	int status;
 
@@ -3604,8 +3594,6 @@ ice_cfg_phy_fec(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 	}
 
 out:
-	kfree(pcaps);
-
 	return status;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a19b06f18e40..8a260a468a81 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -801,7 +801,7 @@ static int ice_lbtest_create_frame(struct ice_pf *pf, u8 **ret_data, u16 size)
 	if (!pf)
 		return -EINVAL;
 
-	data = devm_kzalloc(ice_pf_to_dev(pf), size, GFP_KERNEL);
+	data = kzalloc(size, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -944,11 +944,9 @@ static u64 ice_loopback_test(struct net_device *netdev)
 	int num_frames, valid_frames;
 	struct ice_tx_ring *tx_ring;
 	struct ice_rx_ring *rx_ring;
-	struct device *dev;
-	u8 *tx_frame;
+	u8 *tx_frame __free(kfree);
 	int i;
 
-	dev = ice_pf_to_dev(pf);
 	netdev_info(netdev, "loopback test\n");
 
 	test_vsi = ice_lb_vsi_setup(pf, pf->hw.port_info);
@@ -993,7 +991,7 @@ static u64 ice_loopback_test(struct net_device *netdev)
 	for (i = 0; i < num_frames; i++) {
 		if (ice_diag_send(tx_ring, tx_frame, ICE_LB_FRAME_SIZE)) {
 			ret = 8;
-			goto lbtest_free_frame;
+			goto remove_mac_filters;
 		}
 	}
 
@@ -1003,8 +1001,6 @@ static u64 ice_loopback_test(struct net_device *netdev)
 	else if (valid_frames != num_frames)
 		ret = 10;
 
-lbtest_free_frame:
-	devm_kfree(dev, tx_frame);
 remove_mac_filters:
 	if (ice_fltr_remove_mac(test_vsi, broadcast, ICE_FWD_TO_VSI))
 		netdev_err(netdev, "Could not remove MAC filter for the test VSI\n");
-- 
2.34.1


