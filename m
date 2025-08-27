Return-Path: <netdev+bounces-217498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F361B38EA4
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E86366D56
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 22:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEE926A08C;
	Wed, 27 Aug 2025 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5Lzzhxh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF9230F94E
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334815; cv=none; b=cCvJzDO7Zw7V0lCoZ5c3+3r3tF90x2sPP3STirYZewv27WRzXGbh6L4tCxXgpzQB84BDP9DaQmN9RbgKOIv1rm8NKAZV5EhOW75qXLtmiryS7RDk+YUcO8RPwYP3DjmOmyfNQru3sQdWEWkFDjrLJ0LudM0TkxJ877fUKIIQOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334815; c=relaxed/simple;
	bh=cH3gPopnVGsea7O7zyzZNDDGBZBL0nEH+68m9dWCa/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHPpt6k7LH0Lu1+CNTYZIBYZWtkgb9akeYZyI7ODTAG6+uOHtZnmqmywJ4ub+QDYELqp8BtM9aJMEj5dBJUe/cOr9pusnniVvZq8XUY2wu005Cvm5NzZPj4+Gvi8utvRJwwpSc81QXb0gBhoOlg0SxmWfM8/JEvpdVzCQ0Ci2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5Lzzhxh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756334814; x=1787870814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cH3gPopnVGsea7O7zyzZNDDGBZBL0nEH+68m9dWCa/s=;
  b=l5LzzhxhHd5qdf4Bj02AVtpXjg5szjH945IFjR/ADy3cwzxalGrN9iec
   /XJv9f7zO1QpNAlICD6tPM/bu1H4394Q9c8ojXbRwbp1SuJuXlupqX8q1
   RWwQjhC1PLt0pxua3Co1fXi4jUC+NZVteDDXRorHADhGrF6Ow6jLBUWle
   RkOZ9CR/YnXSqborg/Xn7GzZn9JW+hOSU3jqFtcwdbOzvkK883bi06USb
   GEKFtvTVLHRLWPqNd1xkM+0xPtTCivuMDoX+TuDX+Xl1yXXyFS5+LlRyh
   fi9CY+7wSwf/Ut0rtZaB60vmo1DW2TmUUm6PzAt1krwWHi0JEtH5i0w7A
   Q==;
X-CSE-ConnectionGUID: 3qh6dnLSTay8sIobX20ipg==
X-CSE-MsgGUID: KYOlmCpZQZa26thBzYPykQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70037244"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70037244"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 15:46:50 -0700
X-CSE-ConnectionGUID: VO66+Nf2TyirE5wxQ/bJRQ==
X-CSE-MsgGUID: w6FIiTGHREiClCQ0JuL1aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169555014"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 27 Aug 2025 15:46:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	kuniyu@google.com
Subject: [PATCH net-next 05/12] ice: extract virt/queues.c: cleanup - p2
Date: Wed, 27 Aug 2025 15:46:20 -0700
Message-ID: <20250827224641.415806-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250827224641.415806-1-anthony.l.nguyen@intel.com>
References: <20250827224641.415806-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Remove next piece of the content that stays in virtchnl.c,
(separate commits to have nicer git history).

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/virt/queues.c | 181 -------------------
 1 file changed, 181 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index 7765ac50a6cd..c1da10aa2151 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
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
2.47.1


