Return-Path: <netdev+bounces-94083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33578BE139
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A07B21701
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D939156662;
	Tue,  7 May 2024 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVp31S0e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91C156640
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082050; cv=none; b=XrhTBI1JHoW3olrR4evn94HuKOFff0nxqEpocKmMXRTyYmqqslusbbjPKzL8Nyyk0cjoPFc7GFMzrBKgh/3nuA+eYp/FWlZZBjbsZKQ2/QK2/4lpx4X1Fwz7bQN1rDgjKQRHyozebGmVCJQn5Ydk3qHXkeaD4s3+DfuL5DfLjcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082050; c=relaxed/simple;
	bh=31Jejpe3OCSHK0a4fqPAn9kRSu7BW8zo2Jx5VlDmJB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OilwkF4y9iff690BBN6D/srrWyspekTUhCpmc9wsf6/kqitvRkbeTNpMFpnSEGbPrIH5N8TZmStldijhcJ9Dw+kcR8gl7sQaeohB9AwW7hlIq9U2xxIyjzUfyHqMSn3nhuJkky9pL74IqkuNqE0VHrCxidUOFFM+jyMhs14Diz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVp31S0e; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715082049; x=1746618049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=31Jejpe3OCSHK0a4fqPAn9kRSu7BW8zo2Jx5VlDmJB0=;
  b=IVp31S0eKykCCbhS7qreAcQJ/H8IAps/Md+t/bqjPYES/cswOPWfM/fR
   b2BAuz9jZSno2vn7plxssthXgqTnM/tpG1l0xc0KQdI/l6Q/lZAWeDApp
   D5rpEJflA5V61rEspQez40rlWYue1Ri0p9ETwGV8emEKT9jZ4t6RGKf2g
   CRfVdnDy8OLiSr7Py+X0W7qKVCcyR+UBRo9Lu5270obkOfW5UHuuGPzUJ
   L7J1sLRic//8ytNUuv5L1PUzqgtZ0g7oINiTrgmj0bMF32N/N+qXA74W/
   mMFlnH3i49XyS9847QndpUGCr8iiFoqZ7z1R4o+fq2nS21LkxQsE/iqzm
   A==;
X-CSE-ConnectionGUID: s55rPqsUR3qD2XCyPZXrUA==
X-CSE-MsgGUID: QJOGs8nTQqmUn8nYUlX5lw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22029319"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="22029319"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 04:40:49 -0700
X-CSE-ConnectionGUID: HTz5vSOcQTGxzYiWUNCPVQ==
X-CSE-MsgGUID: dwhDXAsnS/aHYs5xQu74HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="28576731"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 07 May 2024 04:40:45 -0700
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
Subject: [iwl-next v1 12/14] ice: support subfunction devlink Tx topology
Date: Tue,  7 May 2024 13:45:13 +0200
Message-ID: <20240507114516.9765-13-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flow for creating Tx topology is the same as for VF port representors,
but the devlink port is stored in different place (sf->devlink_port).

When creating VF devlink lock isn't taken, when creating subfunction it
is. Setting Tx topology function needs to take this lock, check if it
was taken before to not do it twice.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c     | 12 ++++++++++++
 .../net/ethernet/intel/ice/devlink/devlink_port.c    |  3 ++-
 drivers/net/ethernet/intel/ice/ice_repr.c            | 12 +++++++-----
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index c1fe3726f6c0..22aa19c3c784 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -746,6 +746,7 @@ static void ice_traverse_tx_tree(struct devlink *devlink, struct ice_sched_node
 				 struct ice_sched_node *tc_node, struct ice_pf *pf)
 {
 	struct devlink_rate *rate_node = NULL;
+	struct ice_dynamic_port *sf;
 	struct ice_vf *vf;
 	int i;
 
@@ -757,6 +758,7 @@ static void ice_traverse_tx_tree(struct devlink *devlink, struct ice_sched_node
 		/* create root node */
 		rate_node = devl_rate_node_create(devlink, node, node->name, NULL);
 	} else if (node->vsi_handle &&
+		   pf->vsi[node->vsi_handle]->type == ICE_VSI_VF &&
 		   pf->vsi[node->vsi_handle]->vf) {
 		vf = pf->vsi[node->vsi_handle]->vf;
 		if (!vf->devlink_port.devlink_rate)
@@ -765,6 +767,16 @@ static void ice_traverse_tx_tree(struct devlink *devlink, struct ice_sched_node
 			 */
 			devl_rate_leaf_create(&vf->devlink_port, node,
 					      node->parent->rate_node);
+	} else if (node->vsi_handle &&
+		   pf->vsi[node->vsi_handle]->type == ICE_VSI_SF &&
+		   pf->vsi[node->vsi_handle]->sf) {
+		sf = pf->vsi[node->vsi_handle]->sf;
+		if (!sf->devlink_port.devlink_rate)
+			/* leaf nodes doesn't have children
+			 * so we don't set rate_node
+			 */
+			devl_rate_leaf_create(&sf->devlink_port, node,
+					      node->parent->rate_node);
 	} else if (node->info.data.elem_type != ICE_AQC_ELEM_TYPE_LEAF &&
 		   node->parent->rate_node) {
 		rate_node = devl_rate_node_create(devlink, node, node->name,
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index 3d887e7ee78c..e8929e91aff2 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -732,7 +732,8 @@ int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port)
  */
 void ice_devlink_destroy_sf_port(struct ice_dynamic_port *dyn_port)
 {
-       devl_port_unregister(&dyn_port->devlink_port);
+	devl_rate_leaf_destroy(&dyn_port->devlink_port);
+	devl_port_unregister(&dyn_port->devlink_port);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index ec4f5b8b46e6..da7489f8d9a7 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -347,16 +347,13 @@ static void ice_repr_rem_sf(struct ice_repr *repr)
 	ice_devlink_destroy_sf_port(repr->sf);
 }
 
-static void ice_repr_set_tx_topology(struct ice_pf *pf)
+static void ice_repr_set_tx_topology(struct ice_pf *pf, struct devlink *devlink)
 {
-	struct devlink *devlink;
-
 	/* only export if ADQ and DCB disabled and eswitch enabled*/
 	if (ice_is_adq_active(pf) || ice_is_dcb_active(pf) ||
 	    !ice_is_switchdev_running(pf))
 		return;
 
-	devlink = priv_to_devlink(pf);
 	ice_devlink_rate_init_tx_topology(devlink, ice_get_main_vsi(pf));
 }
 
@@ -408,6 +405,7 @@ static struct ice_repr *ice_repr_create(struct ice_vsi *src_vsi)
 static int ice_repr_add_vf(struct ice_repr *repr)
 {
 	struct ice_vf *vf = repr->vf;
+	struct devlink *devlink;
 	int err;
 
 	err = ice_devlink_create_vf_port(vf);
@@ -424,7 +422,9 @@ static int ice_repr_add_vf(struct ice_repr *repr)
 		goto err_cfg_vsi;
 
 	ice_virtchnl_set_repr_ops(vf);
-	ice_repr_set_tx_topology(vf->pf);
+
+	devlink = priv_to_devlink(vf->pf);
+	ice_repr_set_tx_topology(vf->pf, devlink);
 
 	return 0;
 
@@ -472,6 +472,8 @@ static int ice_repr_add_sf(struct ice_repr *repr)
 	if (err)
 		goto err_netdev;
 
+	ice_repr_set_tx_topology(sf->vsi->back, priv_to_devlink(sf->vsi->back));
+
 	return 0;
 
 err_netdev:
-- 
2.42.0


