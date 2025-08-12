Return-Path: <netdev+bounces-212930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DDAB22912
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2E06836A6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99564287508;
	Tue, 12 Aug 2025 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miV2TkYT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091C2857C9
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005949; cv=none; b=RWaKlQVYhyXJtPGSvnUTduD+R9j9hSHs05X3JUk299M9FQ7XoTrpRH3weZIlRxF7yn9fyruW/wZyYDxrwlapEPNBOEhv5FMFnwvlFtIux1uznJn4WtH4s5wNlOl2Y84eN4fvYMcCKaXn2M6OqA7WrgCESCQ3+PDoii+bgAWHldA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005949; c=relaxed/simple;
	bh=gOWghwsPVbmAb5+OMOFwbIOTGyGJZN582YrTaUFzRMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AnzN4jfmN4gvQwxeVHcr/0NeBEs7RcW0BIfJMg1Z4d5bNcriiD4XBal+bmCGJKZ0kuQUy/pM0DwUuaANAqHLr4FuoZQvrIsjIA2Ekrl/qw9j3YR2HoPEf/ompYfclePSwxPZR4KMwZG420Dl7kR0gEc5gY/VTpWQAA/ukt42RFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miV2TkYT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755005948; x=1786541948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gOWghwsPVbmAb5+OMOFwbIOTGyGJZN582YrTaUFzRMM=;
  b=miV2TkYTqQT2f9KX6l177fcQgPM4u22Gxd92Pdj+iBEY8ZpQYT/0OC2D
   rWE7tLCoIJGrRK68CBy5/PsV4dLwI6n4jIj0xYBKHdFfvxeZ4MKC6chfy
   iTAGGEfLBwC1g+tMVVcpMZ2zC6lr20dvaEynwgINi4rew+I5+B0lhNkFd
   Je97qASN6p7cusGRCccrAKWDTtd2AIJQVxWO1ViYeqcBxUOr+7ANpZLcc
   3BNAqHkIEnC08AxrF9ehtf1xMgoFitI0EDk4OyQhRKYrG7MjXwcpL2Svm
   Qq/hVO/JKyIWsSBobBsNE7oHHa6WYq3xE1XTiG8DZtNvPrpJagcRwvMMv
   w==;
X-CSE-ConnectionGUID: lmuuScZlS1KM6ygNZEVKsQ==
X-CSE-MsgGUID: AwtpF8RlSeywhFN1rlb12g==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56994329"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="56994329"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 06:39:06 -0700
X-CSE-ConnectionGUID: pCcQQRn5QLCSokgAIMtXGQ==
X-CSE-MsgGUID: DhBp8UUbTLiLZfXEaqmCJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170416070"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2025 06:39:03 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A4A2C32CB9;
	Tue, 12 Aug 2025 14:39:02 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH 04/12] ice: extract ice_virtchnl_queues.c: cleanup - p2
Date: Tue, 12 Aug 2025 15:29:02 +0200
Message-Id: <20250812132910.99626-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
References: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove next piece of the content that stays in ice_virtchnl.c,
(separate commits to have nicer git history).

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 .../ethernet/intel/ice/ice_virtchnl_queues.c  | 181 ------------------
 1 file changed, 181 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_queues.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_queues.c
index 9ee7ec92e331..0600151ebee1 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_queues.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_queues.c
@@ -161,187 +161,6 @@ static int ice_vf_cfg_q_quanta_profile(struct ice_vf *vf, u16 quanta_size,
 	return 0;
 }
 
-/**
- * ice_vc_cfg_promiscuous_mode_msg
- * @vf: pointer to the VF info
- * @msg: pointer to the msg buffer
- *
- * called from the VF to configure VF VSIs promiscuous mode
- */
-static int ice_vc_cfg_promiscuous_mode_msg(struct ice_vf *vf, u8 *msg)
-{
-	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	bool rm_promisc, alluni = false, allmulti = false;
-	struct virtchnl_promisc_info *info =
-	    (struct virtchnl_promisc_info *)msg;
-	struct ice_vsi_vlan_ops *vlan_ops;
-	int mcast_err = 0, ucast_err = 0;
-	struct ice_pf *pf = vf->pf;
-	struct ice_vsi *vsi;
-	u8 mcast_m, ucast_m;
-	struct device *dev;
-	int ret = 0;
-
-	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (!ice_vc_isvalid_vsi_id(vf, info->vsi_id)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	vsi = ice_get_vf_vsi(vf);
-	if (!vsi) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	dev = ice_pf_to_dev(pf);
-	if (!ice_is_vf_trusted(vf)) {
-		dev_err(dev, "Unprivileged VF %d is attempting to configure promiscuous mode\n",
-			vf->vf_id);
-		/* Leave v_ret alone, lie to the VF on purpose. */
-		goto error_param;
-	}
-
-	if (info->flags & FLAG_VF_UNICAST_PROMISC)
-		alluni = true;
-
-	if (info->flags & FLAG_VF_MULTICAST_PROMISC)
-		allmulti = true;
-
-	rm_promisc = !allmulti && !alluni;
-
-	vlan_ops = ice_get_compat_vsi_vlan_ops(vsi);
-	if (rm_promisc)
-		ret = vlan_ops->ena_rx_filtering(vsi);
-	else
-		ret = vlan_ops->dis_rx_filtering(vsi);
-	if (ret) {
-		dev_err(dev, "Failed to configure VLAN pruning in promiscuous mode\n");
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	ice_vf_get_promisc_masks(vf, vsi, &ucast_m, &mcast_m);
-
-	if (!test_bit(ICE_FLAG_VF_TRUE_PROMISC_ENA, pf->flags)) {
-		if (alluni) {
-			/* in this case we're turning on promiscuous mode */
-			ret = ice_set_dflt_vsi(vsi);
-		} else {
-			/* in this case we're turning off promiscuous mode */
-			if (ice_is_dflt_vsi_in_use(vsi->port_info))
-				ret = ice_clear_dflt_vsi(vsi);
-		}
-
-		/* in this case we're turning on/off only
-		 * allmulticast
-		 */
-		if (allmulti)
-			mcast_err = ice_vf_set_vsi_promisc(vf, vsi, mcast_m);
-		else
-			mcast_err = ice_vf_clear_vsi_promisc(vf, vsi, mcast_m);
-
-		if (ret) {
-			dev_err(dev, "Turning on/off promiscuous mode for VF %d failed, error: %d\n",
-				vf->vf_id, ret);
-			v_ret = VIRTCHNL_STATUS_ERR_ADMIN_QUEUE_ERROR;
-			goto error_param;
-		}
-	} else {
-		if (alluni)
-			ucast_err = ice_vf_set_vsi_promisc(vf, vsi, ucast_m);
-		else
-			ucast_err = ice_vf_clear_vsi_promisc(vf, vsi, ucast_m);
-
-		if (allmulti)
-			mcast_err = ice_vf_set_vsi_promisc(vf, vsi, mcast_m);
-		else
-			mcast_err = ice_vf_clear_vsi_promisc(vf, vsi, mcast_m);
-
-		if (ucast_err || mcast_err)
-			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-	}
-
-	if (!mcast_err) {
-		if (allmulti &&
-		    !test_and_set_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states))
-			dev_info(dev, "VF %u successfully set multicast promiscuous mode\n",
-				 vf->vf_id);
-		else if (!allmulti &&
-			 test_and_clear_bit(ICE_VF_STATE_MC_PROMISC,
-					    vf->vf_states))
-			dev_info(dev, "VF %u successfully unset multicast promiscuous mode\n",
-				 vf->vf_id);
-	} else {
-		dev_err(dev, "Error while modifying multicast promiscuous mode for VF %u, error: %d\n",
-			vf->vf_id, mcast_err);
-	}
-
-	if (!ucast_err) {
-		if (alluni &&
-		    !test_and_set_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states))
-			dev_info(dev, "VF %u successfully set unicast promiscuous mode\n",
-				 vf->vf_id);
-		else if (!alluni &&
-			 test_and_clear_bit(ICE_VF_STATE_UC_PROMISC,
-					    vf->vf_states))
-			dev_info(dev, "VF %u successfully unset unicast promiscuous mode\n",
-				 vf->vf_id);
-	} else {
-		dev_err(dev, "Error while modifying unicast promiscuous mode for VF %u, error: %d\n",
-			vf->vf_id, ucast_err);
-	}
-
-error_param:
-	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE,
-				     v_ret, NULL, 0);
-}
-
-/**
- * ice_vc_get_stats_msg
- * @vf: pointer to the VF info
- * @msg: pointer to the msg buffer
- *
- * called from the VF to get VSI stats
- */
-static int ice_vc_get_stats_msg(struct ice_vf *vf, u8 *msg)
-{
-	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	struct virtchnl_queue_select *vqs =
-		(struct virtchnl_queue_select *)msg;
-	struct ice_eth_stats stats = { 0 };
-	struct ice_vsi *vsi;
-
-	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (!ice_vc_isvalid_vsi_id(vf, vqs->vsi_id)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	vsi = ice_get_vf_vsi(vf);
-	if (!vsi) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	ice_update_eth_stats(vsi);
-
-	stats = vsi->eth_stats;
-
-error_param:
-	/* send the response to the VF */
-	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_GET_STATS, v_ret,
-				     (u8 *)&stats, sizeof(stats));
-}
-
 /**
  * ice_vc_validate_vqs_bitmaps - validate Rx/Tx queue bitmaps from VIRTCHNL
  * @vqs: virtchnl_queue_select structure containing bitmaps to validate
-- 
2.39.3


