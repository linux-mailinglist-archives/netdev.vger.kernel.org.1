Return-Path: <netdev+bounces-100394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF02B8FA5D6
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 00:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE3D1F23FAE
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 22:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85881411C3;
	Mon,  3 Jun 2024 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRcJXYJF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF5613FD6D
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454307; cv=none; b=T5NSTqlLWo9G5Y5ctL72yxT3dw/8n0HEhxT5wznBCZVIX+NHMQEHtkY9epbeArL+EvSV+zL65Ou4yJFR46jgGUBE/M8Oae3/KXZgcucIX70dW0IG2AEkYubiweHQCiqxVV306uGCTvIUVAvQP0ZyYcqGTpb6TEIQxcYCy33l/cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454307; c=relaxed/simple;
	bh=VYsk72x/Nd4uuR65GzdJOXFPPRAZ3Rq29nRvCNngo7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dS7d7w5wpca78GX24YIf1SLSprbrIwcmCl7duCMHqQhVsrWUtU+izuyI76CxfbQnM17Uj9dmn16zPpmmfZn7qU0RvjZzhqs+AnZOWO5aO1qafE5R6+PPPj0bJ8x9ZhQs+53s23nxOn+f8r5ZfmMkgRtSVvcFa/47YxpoWUZ2htk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRcJXYJF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717454306; x=1748990306;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=VYsk72x/Nd4uuR65GzdJOXFPPRAZ3Rq29nRvCNngo7E=;
  b=JRcJXYJF9hzd0eNyieB4mEy64QTYN1dZVQU3iCZZ4v22M53AoyjIwSgL
   ZVbYp1vMX58yJyQIDZKriK70PBZ+0f59RH6vRn6k4cdC/7eEYYHetSrdj
   YAHQcBw+VKriJNMxlfkC0dSbUsYGbwJ+5vev6YLWx1J3UTMexvsbFpS39
   3138P7BAUAH/UC630bJMmA6U1pOTz5m82oIPcc7F+uMgiE1jpacUnoPdO
   RGaFDaKsfGvm2l+qjGNU3wG8w1wKFvz5v1H9cX+7q46YG/JZRNSoadLVB
   F7ZpJBSZtoYIBorO7eR95n2/IGs0m69YLerqf9l1zYWneizkeBdm2Kl6l
   w==;
X-CSE-ConnectionGUID: a7FOzs/mT72ZjZuRVVqklA==
X-CSE-MsgGUID: z6CgPzyIQQOSckLUSy41NA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13780115"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="13780115"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 15:38:22 -0700
X-CSE-ConnectionGUID: D2OWzlUNSumkscDP3Go+6w==
X-CSE-MsgGUID: gzi6sWieT+a5Ja0kRHZWfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="41471184"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 15:38:21 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Jun 2024 15:38:16 -0700
Subject: [PATCH 4/9] ice: move VSI configuration outside repr setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-next-2024-06-03-intel-next-batch-v1-4-e0523b28f325@intel.com>
References: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
In-Reply-To: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
To: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>
X-Mailer: b4 0.13.0

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

It is needed because subfunction port representor shouldn't configure
the source VSI during representor creation.

Move the code to separate function and call it only in case the VF port
representor is being created.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 55 ++++++++++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_eswitch.h | 10 +++++
 drivers/net/ethernet/intel/ice/ice_repr.c    |  7 ++++
 3 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 7b57a6561a5a..3f73f46111fc 100644
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
 
@@ -136,16 +129,48 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
 	dst->u.port_info.lower_dev = uplink_vsi->netdev;
 
 	return 0;
+}
 
-err_update_security:
+/**
+ * ice_eswitch_cfg_vsi - configure VSI to work in slow-path
+ * @vsi: VSI structure of representee
+ * @mac: representee MAC
+ *
+ * Return: 0 on success, non-zero on error.
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
2.44.0.53.g0f9d4d28b7e6


