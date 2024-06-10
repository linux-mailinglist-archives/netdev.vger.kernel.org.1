Return-Path: <netdev+bounces-102178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBD9901C06
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A8128353A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF06F2374E;
	Mon, 10 Jun 2024 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UALhmSxV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9142C1B4
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718005184; cv=none; b=XfpejUFdFLQmJAUw1tKqYNWWF+JMdeP4HQa4h6tHgLDvHX5UuJU/baU9LX8O096ATdz3aG7Fa65TPmM3MivV4/1QcmvjesPQ/jFBTC19/8r1WgksAiC0tObf+3jQxK/3si40q8P6uspmDUb6jwZ9j1KqkXj/NDzSqaNXvwmrI1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718005184; c=relaxed/simple;
	bh=QIYH+SUWr2sVYaDXWXxSRCtzA7094H02K5Slg6Tci6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCzGEXKCQt5+PECEiDWftL7qrvwRhhsMrCCMiLr0JLly1I9qZFbBFGDd43qIgg0osvcu3Kr9N1eZbGvtZcEuHxMTwoQn7RLHVdiEcf4KHmA5V9SAt2EJYz2iS4GsYpuwghPxPGT/atDKrjmgNt85QUWU2whdv2ehU7mUYUkVe10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UALhmSxV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718005183; x=1749541183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QIYH+SUWr2sVYaDXWXxSRCtzA7094H02K5Slg6Tci6Q=;
  b=UALhmSxVe7q3yh/tTO+KAtHdRUZ0jhjPZ0zUhU72dyBD0Ual7gaOoyNQ
   dwtjOLNDEQaIwYbBQEzzypkBWNmsoCZhjHgH2napg7XWYs0iGy3JT7jWq
   ab3KMF1HtqaJNyzlf2eMy0QrQY/qpaQrj0ZOqsqQAH1+xPFYQiPPfBxRx
   KBKWAQJtl2p5aCx7xjcNdxqMx3vBX0mQc9avQiwMVINcc8poNhmBFCZol
   Vl32s351JXblPL/S8LoqT+YqWOX30MmYqTCTGs1JhwAMZAXDf62oQceNv
   VbHH8dbW0PPvN75zVdGzBt7gEISK67LH2+sFc2rAn5upSiEgtK+HDx3cY
   w==;
X-CSE-ConnectionGUID: D4vkdUK8QGC+TG9PoEJ1BA==
X-CSE-MsgGUID: ZQjItr6/ROOiIor8nbNT1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="14448573"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14448573"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 00:39:43 -0700
X-CSE-ConnectionGUID: BJOwvaQVRBa3RPolE97mUA==
X-CSE-MsgGUID: T5zpgcBbQlaQTjb5FFCu2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="70151258"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 10 Jun 2024 00:39:40 -0700
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
	shayd@nvidia.com,
	kuba@kernel.org
Subject: [iwl-next v3 2/4] ice: move devlink locking outside the port creation
Date: Mon, 10 Jun 2024 09:44:32 +0200
Message-ID: <20240610074434.1962735-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240610074434.1962735-1-michal.swiatkowski@linux.intel.com>
References: <20240610074434.1962735-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of subfunction lock will be taken for whole port creation and
removing. Do the same in VF case.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c      | 2 --
 drivers/net/ethernet/intel/ice/devlink/devlink_port.c | 4 ++--
 drivers/net/ethernet/intel/ice/ice_eswitch.c          | 9 +++++++--
 drivers/net/ethernet/intel/ice/ice_repr.c             | 2 --
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 704e9ad5144e..f774781ab514 100644
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
index b102db8b829a..7b57a6561a5a 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -423,6 +423,7 @@ static void ice_eswitch_start_reprs(struct ice_pf *pf)
 int
 ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 {
+	struct devlink *devlink = priv_to_devlink(pf);
 	struct ice_repr *repr;
 	int err;
 
@@ -437,7 +438,9 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 
 	ice_eswitch_stop_reprs(pf);
 
+	devl_lock(devlink);
 	repr = ice_repr_add_vf(vf);
+	devl_unlock(devlink);
 	if (IS_ERR(repr)) {
 		err = PTR_ERR(repr);
 		goto err_create_repr;
@@ -460,7 +463,9 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 err_xa_alloc:
 	ice_eswitch_release_repr(pf, repr);
 err_setup_repr:
+	devl_lock(devlink);
 	ice_repr_rem_vf(repr);
+	devl_unlock(devlink);
 err_create_repr:
 	if (xa_empty(&pf->eswitch.reprs))
 		ice_eswitch_disable_switchdev(pf);
@@ -484,6 +489,7 @@ void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf)
 		ice_eswitch_disable_switchdev(pf);
 
 	ice_eswitch_release_repr(pf, repr);
+	devl_lock(devlink);
 	ice_repr_rem_vf(repr);
 
 	if (xa_empty(&pf->eswitch.reprs)) {
@@ -491,12 +497,11 @@ void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf)
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


