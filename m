Return-Path: <netdev+bounces-89701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9E8AB42D
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 19:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9471F228B2
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28441137C32;
	Fri, 19 Apr 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5ROR57C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69713A418
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546532; cv=none; b=Zmi01L+vPnGs+RhE23XlytJylfajZBbOZyj9vZ0fGYVXegoVnBa8AGMVX0TlCKupjQdIr9jJFrUrNmRAFLnG9JosNBdZlQGntX5uKzeVtH3lxZfQv6LnqZ/qXH/nJJ3v19FBoDN9Ncp39Pe2YgykhiM2x/uznIu5WALn3aCtrRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546532; c=relaxed/simple;
	bh=GyiODg4JIvgzDxR0uyPN5VpQruogz0ug9ATnURc1yx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFOgOs1M84i04XQ2AmSuAcqPjlvThy67LisE5iIVxz9Dix7IpvVR7fZoXexYAtFeoGrOfeBBnPArg2TD7lsF72VOTM0shKTcXLhprYL1Bu8XFTrw8krvtIv1/sY/SCDA/nK7Z+GCko8YpCYF5YdTfBo79K33vwaxt4Cv6gIWtSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5ROR57C; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713546530; x=1745082530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GyiODg4JIvgzDxR0uyPN5VpQruogz0ug9ATnURc1yx8=;
  b=F5ROR57CmPjle/IwebFqUwHzTutP/hNaysHrUJoRl5pBzfm1/LD668o8
   pRety4LcOZW9ypGp1S7uzNkv0eDrZhTG6qkfn9Ws/7K7492A5//L6/yht
   DP1uBkDlFW2FQoo15FPNF89/kcFRTBCO39zk6p2SPPiboaloUdCJJ0jLv
   w2ITHcqfZJdN/EbP6+2OXyyI1nhq6Erjo0GSo5/kiPUzBZqhbCLar9Og3
   SC47JGXbmpFYulAZ1KwlG3Yu4lcP1dL0Nmac2fkZZwkJHcCMgqY8K+gnM
   Ym0yRPqa91t/+NyCxxnrMSpDkXUgJiB4PxokL6+2odmp9Rdv2/baFbclK
   Q==;
X-CSE-ConnectionGUID: 2thb66vUSvy6+A71d3uXqg==
X-CSE-MsgGUID: Hlx8OX7ITHu8PLXhVu220w==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="26674301"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="26674301"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:08:50 -0700
X-CSE-ConnectionGUID: AXICHSpnRj+FYExBS64+Uw==
X-CSE-MsgGUID: 8K4QCRbBQIyo7zMbw1LjXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="27847174"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa005.fm.intel.com with ESMTP; 19 Apr 2024 10:08:47 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	jiri@nvidia.com,
	mateusz.polchlopek@intel.com,
	shayd@nvidia.com
Subject: [iwl-next v1 3/4] ice: move VSI configuration outside repr setup
Date: Fri, 19 Apr 2024 19:13:35 +0200
Message-ID: <20240419171336.11617-4-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240419171336.11617-1-michal.swiatkowski@linux.intel.com>
References: <20240419171336.11617-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is needed because subfunction port representor shouldn't configure
the source VSI during representor creation.

Move the code to separate function and call it only in case the VF port
representor is being created.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 53 ++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_eswitch.h | 10 ++++
 drivers/net/ethernet/intel/ice/ice_repr.c    |  7 +++
 3 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index aeee1eb17a03..998590223f02 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -117,17 +117,10 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
 	struct ice_vsi *vsi = repr->src_vsi;
 	struct metadata_dst *dst;
 
-	ice_remove_vsi_fltr(&pf->hw, vsi->idx);
 	repr->dst = metadata_dst_alloc(0, METADATA_HW_PORT_MUX,
 				       GFP_KERNEL);
 	if (!repr->dst)
-		goto err_add_mac_fltr;
-
-	if (ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof))
-		goto err_dst_free;
-
-	if (ice_vsi_add_vlan_zero(vsi))
-		goto err_update_security;
+		return -ENOMEM;
 
 	netif_keep_dst(uplink_vsi->netdev);
 
@@ -136,16 +129,46 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
 	dst->u.port_info.lower_dev = uplink_vsi->netdev;
 
 	return 0;
+}
 
-err_update_security:
+/**
+ * ice_eswitch_cfg_vsi - configure VSI to work in slow-path
+ * @vsi: VSI structure of representee
+ * @mac: representee MAC
+ */
+int ice_eswitch_cfg_vsi(struct ice_vsi *vsi, const u8 *mac)
+{
+	int err;
+
+	ice_remove_vsi_fltr(&vsi->back->hw, vsi->idx);
+
+	err = ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof);
+	if (err)
+		goto err_update_security;
+
+	err = ice_vsi_add_vlan_zero(vsi);
+	if (err)
+		goto err_vlan_zero;
+
+	return 0;
+
+err_vlan_zero:
 	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
-err_dst_free:
-	metadata_dst_free(repr->dst);
-	repr->dst = NULL;
-err_add_mac_fltr:
-	ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac, ICE_FWD_TO_VSI);
+err_update_security:
+	ice_fltr_add_mac_and_broadcast(vsi, mac, ICE_FWD_TO_VSI);
 
-	return -ENODEV;
+	return err;
+}
+
+/**
+ * ice_eswitch_decfg_vsi - unroll changes done to VSI for switchdev
+ * @vsi: VSI structure of representee
+ * @mac: representee MAC
+ */
+void ice_eswitch_decfg_vsi(struct ice_vsi *vsi, const u8 *mac)
+{
+	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
+	ice_fltr_add_mac_and_broadcast(vsi, mac, ICE_FWD_TO_VSI);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index e2e5c0c75e7d..9a25606e9740 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -28,6 +28,9 @@ netdev_tx_t
 ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev);
 struct net_device *ice_eswitch_get_target(struct ice_rx_ring *rx_ring,
 					  union ice_32b_rx_flex_desc *rx_desc);
+
+int ice_eswitch_cfg_vsi(struct ice_vsi *vsi, const u8 *mac);
+void ice_eswitch_decfg_vsi(struct ice_vsi *vsi, const u8 *mac);
 #else /* CONFIG_ICE_SWITCHDEV */
 static inline void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf) { }
 
@@ -85,5 +88,12 @@ ice_eswitch_get_target(struct ice_rx_ring *rx_ring,
 {
 	return rx_ring->netdev;
 }
+
+static inline int ice_eswitch_cfg_vsi(struct ice_vsi *vsi, const u8 *mac)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void ice_eswitch_decfg_vsi(struct ice_vsi *vsi, const u8 *mac) { }
 #endif /* CONFIG_ICE_SWITCHDEV */
 #endif /* _ICE_ESWITCH_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 35a6ac8c0466..bdda3401e343 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -306,6 +306,7 @@ static void ice_repr_rem(struct ice_repr *repr)
 void ice_repr_rem_vf(struct ice_repr *repr)
 {
 	ice_repr_remove_node(&repr->vf->devlink_port);
+	ice_eswitch_decfg_vsi(repr->src_vsi, repr->parent_mac);
 	unregister_netdev(repr->netdev);
 	ice_devlink_destroy_vf_port(repr->vf);
 	ice_virtchnl_set_dflt_ops(repr->vf);
@@ -401,11 +402,17 @@ struct ice_repr *ice_repr_add_vf(struct ice_vf *vf)
 	if (err)
 		goto err_netdev;
 
+	err = ice_eswitch_cfg_vsi(repr->src_vsi, repr->parent_mac);
+	if (err)
+		goto err_cfg_vsi;
+
 	ice_virtchnl_set_repr_ops(vf);
 	ice_repr_set_tx_topology(vf->pf);
 
 	return repr;
 
+err_cfg_vsi:
+	unregister_netdev(repr->netdev);
 err_netdev:
 	ice_repr_rem(repr);
 err_repr_add:
-- 
2.42.0


