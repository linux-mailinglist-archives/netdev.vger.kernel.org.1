Return-Path: <netdev+bounces-89700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E06A8AB42A
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 19:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D369E282815
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 17:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D101369AA;
	Fri, 19 Apr 2024 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHswuvAO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D570139D15
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546529; cv=none; b=CtUNZhWEj9gE0SeUboxyUMPfDy+u0Q7rEuHtQgbW2jtSXv0U4H63JwVgoNoRchWunixbvs8EhCWsWCi/5AfbK4PtnJC7mzXfNMiLJAro+KABXzbx6Jj06jwEt5g41opVx0KZkoVcS1cjsFwfE4NQVQX5EVA7udpUGjdgUYTzKAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546529; c=relaxed/simple;
	bh=Ve378FFAuh6ujx2bfirUF+q8me2wL6AE4VK5U++MuzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLhclQZ/6xD9MvFVeygpo++7mSk1Nbql4x4FqApaAFMgyh0e3USCXBE5pNh/HeJFkMcZN6xv9H5vK8RgTm/dDtHR1h83Ypbm9Oo2Su5Mbqdr7LzD8BGNzRWIvfzlxx3cEzwOAl/j2f3sWQdogo5yMq3X5mixepXGk2TTyJfmcA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHswuvAO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713546528; x=1745082528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ve378FFAuh6ujx2bfirUF+q8me2wL6AE4VK5U++MuzA=;
  b=FHswuvAOxyv9vGARX7hrrmRX8mtEpd0lpVHu+eQscPL3voyZN69F+Wk5
   dfXZGdZlhzKS4Vm9bj7pEMwbhq+WuCIfTJ9jR40PUmWLzFCw6mYrtl6yQ
   Im0rdS+dDQp0YcgOkERp0OcQQRCNVKSFBNdzaUiHe6Nj4lGAR2un4XwFt
   TyYYIcWHhKRrPzx3c5ZH9Jb0De7Q4DFvEGCiF9gQv9xgKYXo2PmLeDbiL
   ug9vjhKmY/HNrsffvxH1FwTLKMzqWFYEs0dHbxmKOkDadX3PQfpjjGaK0
   bEGxjTLMqxwFbMgS1GfxBDImESIw3zVyK4Fa+4LRdnKfuKU2NRocZzVUW
   w==;
X-CSE-ConnectionGUID: iEj0xwO6Rk+JlgNPufbC1g==
X-CSE-MsgGUID: d9pYHnWAT52Yav/9kTp8zQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="26674295"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="26674295"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:08:47 -0700
X-CSE-ConnectionGUID: 41OvF0zaSfKxlv68FUP/KQ==
X-CSE-MsgGUID: KYYNKwR6S+2eft2TM352MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="27847166"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa005.fm.intel.com with ESMTP; 19 Apr 2024 10:08:45 -0700
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
Subject: [iwl-next v1 2/4] ice: move devlink locking outside the port creation
Date: Fri, 19 Apr 2024 19:13:34 +0200
Message-ID: <20240419171336.11617-3-michal.swiatkowski@linux.intel.com>
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

In case of subfunction lock will be taken for whole port creation. Do
the same in VF case.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c      | 2 --
 drivers/net/ethernet/intel/ice/devlink/devlink_port.c | 4 ++--
 drivers/net/ethernet/intel/ice/ice_eswitch.c          | 9 +++++++--
 drivers/net/ethernet/intel/ice/ice_repr.c             | 2 --
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index b179eaccc774..6af7a940b6fe 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -794,10 +794,8 @@ int ice_devlink_rate_init_tx_topology(struct devlink *devlink, struct ice_vsi *v
 
 	tc_node = pi->root->children[0];
 	mutex_lock(&pi->sched_lock);
-	devl_lock(devlink);
 	for (i = 0; i < tc_node->num_children; i++)
 		ice_traverse_tx_tree(devlink, tc_node->children[i], tc_node, pf);
-	devl_unlock(devlink);
 	mutex_unlock(&pi->sched_lock);
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index 13e6790d3cae..c9fbeebf7fb9 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -407,7 +407,7 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
 	devlink_port_attrs_set(devlink_port, &attrs);
 	devlink = priv_to_devlink(pf);
 
-	err = devlink_port_register(devlink, devlink_port, vsi->idx);
+	err = devl_port_register(devlink, devlink_port, vsi->idx);
 	if (err) {
 		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
 			vf->vf_id, err);
@@ -426,5 +426,5 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
 void ice_devlink_destroy_vf_port(struct ice_vf *vf)
 {
 	devl_rate_leaf_destroy(&vf->devlink_port);
-	devlink_port_unregister(&vf->devlink_port);
+	devl_port_unregister(&vf->devlink_port);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index c902848cf88e..aeee1eb17a03 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -420,6 +420,7 @@ static void ice_eswitch_start_reprs(struct ice_pf *pf)
 int
 ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 {
+	struct devlink *devlink = priv_to_devlink(pf);
 	struct ice_repr *repr;
 	int err;
 
@@ -434,7 +435,9 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 
 	ice_eswitch_stop_reprs(pf);
 
+	devl_lock(devlink);
 	repr = ice_repr_add_vf(vf);
+	devl_unlock(devlink);
 	if (IS_ERR(repr)) {
 		err = PTR_ERR(repr);
 		goto err_create_repr;
@@ -457,7 +460,9 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 err_xa_alloc:
 	ice_eswitch_release_repr(pf, repr);
 err_setup_repr:
+	devl_lock(devlink);
 	ice_repr_rem_vf(repr);
+	devl_unlock(devlink);
 err_create_repr:
 	if (xa_empty(&pf->eswitch.reprs))
 		ice_eswitch_disable_switchdev(pf);
@@ -481,6 +486,7 @@ void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf)
 		ice_eswitch_disable_switchdev(pf);
 
 	ice_eswitch_release_repr(pf, repr);
+	devl_lock(devlink);
 	ice_repr_rem_vf(repr);
 
 	if (xa_empty(&pf->eswitch.reprs)) {
@@ -488,12 +494,11 @@ void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf)
 		 * no point in keeping the nodes
 		 */
 		ice_devlink_rate_clear_tx_topology(ice_get_main_vsi(pf));
-		devl_lock(devlink);
 		devl_rate_nodes_destroy(devlink);
-		devl_unlock(devlink);
 	} else {
 		ice_eswitch_start_reprs(pf);
 	}
+	devl_unlock(devlink);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index fe83f305cc7d..35a6ac8c0466 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -285,9 +285,7 @@ ice_repr_reg_netdev(struct net_device *netdev)
 
 static void ice_repr_remove_node(struct devlink_port *devlink_port)
 {
-	devl_lock(devlink_port->devlink);
 	devl_rate_leaf_destroy(devlink_port);
-	devl_unlock(devlink_port->devlink);
 }
 
 /**
-- 
2.42.0


