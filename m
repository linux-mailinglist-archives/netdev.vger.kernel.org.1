Return-Path: <netdev+bounces-71208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2798529CE
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320CA1C2290D
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF4917561;
	Tue, 13 Feb 2024 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YigdkLWP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885531AAD0
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809026; cv=none; b=NKxVpCcBk+UPcht52WY2FM0QyYBkx2/YUODZ/eEVvsO3n8IAuyalFuLQ4CwuQjxvuQsJnkUzKWW0MkmyPvDp0gaP0JKofCGRXPf4uAbxnAMm5x9kNR9GS/99FvxH2y65Qcd5V4eYZ4gj2DMzorp4u1vhaMWNFPGmEpWOtHxrPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809026; c=relaxed/simple;
	bh=VmI/PtpXcW9Gvn2IejRZMeIizERy58OcwOlW6tQ82MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNxE0vZwwe/mTf2nzBMO2xAeTNHWQDXKh7WgSf4RICcRl7ZtXb0iPCQwKQ23zn9Hhj+eAKtI8ow7PENsHlmN+OkJcpIJdpfUXz8DBiwRNmWGI7hwgAGZ5Tbnd4txP+myunknkuWN3ern4lODfbqkafU8Sj6tkkILYdJCGuiIt70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YigdkLWP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707809024; x=1739345024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VmI/PtpXcW9Gvn2IejRZMeIizERy58OcwOlW6tQ82MA=;
  b=YigdkLWPUmFaeHE94ah84GCA2MZ5cle7hupchNNyx/7nzJhSqJloN0Ye
   dd3jvQKOwSbQomTNKXshTzz92e0MCtxJqkDAdPRituEpxD+8ddy/p3o7i
   FLpWFlIaNfU82McwgaA3HLBTi9vUpkxg/VrTk9HeQKDj4PU+duKDkYxkQ
   oyTae34arUlj4NAwFYiH7HxHJNQhRen+yDdwJyP8xuE4QELgqP6P0Vhez
   8xnH5kF8nU23VHa6Dd2tE88QrJgll0gTb5NS+Bs5rq5FHdKeM5eKKmy0S
   SxmwgC527/NAsHDhmtSYXPG40pRQjtYVOHF+5EQwyTSBtR4F6Z7TtseCC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27248037"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="27248037"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 23:23:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="7385481"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa003.fm.intel.com with ESMTP; 12 Feb 2024 23:23:40 -0800
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v1 13/15] ice: support subfunction devlink Tx topology
Date: Tue, 13 Feb 2024 08:27:22 +0100
Message-ID: <20240213072724.77275-14-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
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
 drivers/net/ethernet/intel/ice/ice_devlink.c | 14 ++++++++++++--
 drivers/net/ethernet/intel/ice/ice_repr.c    | 14 +++++++++-----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 6278ff3eb7c9..503e175140ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -595,6 +595,7 @@ static void ice_traverse_tx_tree(struct devlink *devlink, struct ice_sched_node
 				 struct ice_sched_node *tc_node, struct ice_pf *pf)
 {
 	struct devlink_rate *rate_node = NULL;
+	struct ice_dynamic_port *sf;
 	struct ice_vf *vf;
 	int i;
 
@@ -606,6 +607,7 @@ static void ice_traverse_tx_tree(struct devlink *devlink, struct ice_sched_node
 		/* create root node */
 		rate_node = devl_rate_node_create(devlink, node, node->name, NULL);
 	} else if (node->vsi_handle &&
+		   pf->vsi[node->vsi_handle]->type == ICE_VSI_VF &&
 		   pf->vsi[node->vsi_handle]->vf) {
 		vf = pf->vsi[node->vsi_handle]->vf;
 		if (!vf->devlink_port.devlink_rate)
@@ -614,6 +616,16 @@ static void ice_traverse_tx_tree(struct devlink *devlink, struct ice_sched_node
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
@@ -645,10 +657,8 @@ int ice_devlink_rate_init_tx_topology(struct devlink *devlink, struct ice_vsi *v
 
 	tc_node = pi->root->children[0];
 	mutex_lock(&pi->sched_lock);
-	devl_lock(devlink);
 	for (i = 0; i < tc_node->num_children; i++)
 		ice_traverse_tx_tree(devlink, tc_node->children[i], tc_node, pf);
-	devl_unlock(devlink);
 	mutex_unlock(&pi->sched_lock);
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 125bcf2e4c00..fb0171afa43e 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -380,19 +380,17 @@ static void ice_repr_rem_vf(struct ice_repr *repr)
 
 static void ice_repr_rem_sf(struct ice_repr *repr)
 {
+	devl_rate_leaf_destroy(&repr->sf->devlink_port);
 	unregister_netdev(repr->netdev);
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
 
@@ -444,6 +442,7 @@ static struct ice_repr *ice_repr_create(struct ice_vsi *src_vsi)
 static int ice_repr_add_vf(struct ice_repr *repr)
 {
 	struct ice_vf *vf = repr->vf;
+	struct devlink *devlink;
 	int err;
 
 	err = ice_devlink_create_vf_port(vf);
@@ -456,7 +455,9 @@ static int ice_repr_add_vf(struct ice_repr *repr)
 		goto err_netdev;
 
 	ice_virtchnl_set_repr_ops(vf);
-	ice_repr_set_tx_topology(vf->pf);
+
+	devlink = priv_to_devlink(vf->pf);
+	ice_repr_set_tx_topology(vf->pf, devlink);
 
 	return 0;
 
@@ -493,6 +494,9 @@ static int ice_repr_add_sf(struct ice_repr *repr)
 	struct ice_dynamic_port *sf = repr->sf;
 
 	SET_NETDEV_DEVLINK_PORT(repr->netdev, &sf->devlink_port);
+
+	ice_repr_set_tx_topology(sf->vsi->back, priv_to_devlink(sf->vsi->back));
+
 	return ice_repr_reg_netdev(repr->netdev, &ice_repr_sf_netdev_ops);
 }
 
-- 
2.42.0


