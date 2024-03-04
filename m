Return-Path: <netdev+bounces-77256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FE9870CF9
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22051C243E0
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426F37CF32;
	Mon,  4 Mar 2024 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qw5Ygulh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB807C0BF
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587788; cv=none; b=Z3RxogqQpNaLvjo+HdD+ZoNsjl3xlYFJK7bk0vo6aALm5oPlWtexbi2gWauEFTCERIY3gpLmbONKWvv8d477GOzc8ZnMb810QdrdjDtnKg0uDWgpLpavnR2wCFPdbSwzNViiabrnrtngcDwY7iho8sgrHvDCgtJ251/x/dGeIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587788; c=relaxed/simple;
	bh=1H2j1cyLjcTyGpYuB1ABKIMXN0GSrMdUiQNAo9qHQfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvqZBXa00fB1o0QqK/bstl1EQzWUycH73U/BndD9ptBnaoF4HDgDTfF7coHJjRDyxnK7TuZEmo/s8WgO7aDOGLCpcRGAR6djGXsR7S+JMZhQHGR5La0ygzet5bInmoMTes30xuuPCxcbXlSSZtxPDC83tnbNf0xAscZfmCROJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qw5Ygulh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709587786; x=1741123786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1H2j1cyLjcTyGpYuB1ABKIMXN0GSrMdUiQNAo9qHQfE=;
  b=Qw5Ygulhk/V+bSe8W624eA8LkC14YJ7wUzv5g815jbU1LwsA2Qx0uhkr
   LVEF0odoxsYiBZ+UIi9AAOpwl75fQaPkOKi2SdEEb0LEjEdaIFOwWUTan
   413oHkokw6ZNd6y6o7RFiwZfyb0I4k3hZG2ARnPFvQFP2kdZ42GQMQLWB
   dgLseG1Y+GqqNgCdOHKEId7WHTHiQKNDzy5D+Q873ipVYVaer5B9coda5
   m3Zo5NFNys3fgXLz3pW7y5+Zx5ifg0td5JPPt9aLwGmM/CdRmf29ubgD9
   h8QuOkxuGW5qk0RyEOtJBbne6K5KV9RUGsGZHsk+cGNzAQmAEfPFrGAfH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3968098"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="3968098"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:29:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="46647893"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 04 Mar 2024 13:29:41 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 9/9] ice: avoid unnecessary devm_ usage
Date: Mon,  4 Mar 2024 13:29:30 -0800
Message-ID: <20240304212932.3412641-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
References: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

1. pcaps are free'd right after AQ routines are done, no need for
   devm_'s
2. a test frame for loopback test in ethtool -t is destroyed at the end
   of the test so we don't need devm_ here either.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  | 34 +++++++-------------
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 ++----
 2 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 7d9315ffae57..4d8111aeb0ff 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1002,9 +1002,9 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
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
@@ -1082,7 +1082,7 @@ int ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_sched;
 
-	pcaps = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*pcaps), GFP_KERNEL);
+	pcaps = kzalloc(sizeof(*pcaps), GFP_KERNEL);
 	if (!pcaps) {
 		status = -ENOMEM;
 		goto err_unroll_sched;
@@ -1092,7 +1092,6 @@ int ice_init_hw(struct ice_hw *hw)
 	status = ice_aq_get_phy_caps(hw->port_info, false,
 				     ICE_AQC_REPORT_TOPO_CAP_MEDIA, pcaps,
 				     NULL);
-	devm_kfree(ice_hw_to_dev(hw), pcaps);
 	if (status)
 		dev_warn(ice_hw_to_dev(hw), "Get PHY capabilities failed status = %d, continuing anyway\n",
 			 status);
@@ -1119,18 +1118,15 @@ int ice_init_hw(struct ice_hw *hw)
 
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
@@ -3276,19 +3272,14 @@ int ice_update_link_info(struct ice_port_info *pi)
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
@@ -3429,8 +3420,8 @@ ice_cfg_phy_fc(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 int
 ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
 {
+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
 	struct ice_aqc_set_phy_cfg_data cfg = { 0 };
-	struct ice_aqc_get_phy_caps_data *pcaps;
 	struct ice_hw *hw;
 	int status;
 
@@ -3440,7 +3431,7 @@ ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
 	*aq_failures = 0;
 	hw = pi->hw;
 
-	pcaps = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*pcaps), GFP_KERNEL);
+	pcaps = kzalloc(sizeof(*pcaps), GFP_KERNEL);
 	if (!pcaps)
 		return -ENOMEM;
 
@@ -3492,7 +3483,6 @@ ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
 	}
 
 out:
-	devm_kfree(ice_hw_to_dev(hw), pcaps);
 	return status;
 }
 
@@ -3571,7 +3561,7 @@ int
 ice_cfg_phy_fec(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 		enum ice_fec_mode fec)
 {
-	struct ice_aqc_get_phy_caps_data *pcaps;
+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
 	struct ice_hw *hw;
 	int status;
 
@@ -3640,8 +3630,6 @@ ice_cfg_phy_fec(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 	}
 
 out:
-	kfree(pcaps);
-
 	return status;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 3cc364a4d682..bb912155676e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -802,7 +802,7 @@ static int ice_lbtest_create_frame(struct ice_pf *pf, u8 **ret_data, u16 size)
 	if (!pf)
 		return -EINVAL;
 
-	data = devm_kzalloc(ice_pf_to_dev(pf), size, GFP_KERNEL);
+	data = kzalloc(size, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -945,11 +945,9 @@ static u64 ice_loopback_test(struct net_device *netdev)
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
@@ -994,7 +992,7 @@ static u64 ice_loopback_test(struct net_device *netdev)
 	for (i = 0; i < num_frames; i++) {
 		if (ice_diag_send(tx_ring, tx_frame, ICE_LB_FRAME_SIZE)) {
 			ret = 8;
-			goto lbtest_free_frame;
+			goto remove_mac_filters;
 		}
 	}
 
@@ -1004,8 +1002,6 @@ static u64 ice_loopback_test(struct net_device *netdev)
 	else if (valid_frames != num_frames)
 		ret = 10;
 
-lbtest_free_frame:
-	devm_kfree(dev, tx_frame);
 remove_mac_filters:
 	if (ice_fltr_remove_mac(test_vsi, broadcast, ICE_FWD_TO_VSI))
 		netdev_err(netdev, "Could not remove MAC filter for the test VSI\n");
-- 
2.41.0


