Return-Path: <netdev+bounces-98390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062148D136E
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 06:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54107B21FC9
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 04:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F9326289;
	Tue, 28 May 2024 04:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPTqbZGk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D048E224D5
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 04:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716870829; cv=none; b=l1OfI3q5eXA7OfIXJFBHSyRBhQuRbUBih80coiBVaiLj0UKI52nVuMrCKDjVmKbdtgG3uDkIYOsvJVmHXrvI1W+La+MqG+jv5X2SVqKzztUTSNf6JLFbuC7x/Ijc+qjXIaOnS14fYJL/LehefI/37XMonzyyxdFD8eR4QjsHQZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716870829; c=relaxed/simple;
	bh=TX0usj/l+syM/ODSz7pz9bCkFQ2IKj+JKmLSZCYMga0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCFsvfY7LA4SPCgfXq1hIu0wtTvfX8qDD2ED2o9AJfxXBLT6AXxqaP49bPLqxPjfTW4N5Vyzfj5cZErXq9hQRLLQspuzTigJNT90iysXLPBUe2646nxg3xcR8JRGqeM4gDY3cIDDmMmSzR9AwwKa9vdBoYcoXLjRVAPCB/I/dcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPTqbZGk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716870828; x=1748406828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TX0usj/l+syM/ODSz7pz9bCkFQ2IKj+JKmLSZCYMga0=;
  b=VPTqbZGk784KZe3AJfv5061IrH644IM1IFe1KVbz7dj3E3FWwshque1G
   7S+jPRHa3W3dby5pw4v0oEAEq00C8nk+pwZGemCfVaMSP5nqZxFHVhGRG
   UlGPT6kOdAsxylGYeLBB2OvjX2tVD/YBywfue+6lid645j4ej53zurJiw
   BD7R8xjlYszHYznqt6XzhdbhbsuFSf0znlyVVA5T7bu+G7BLPoZEC+JdY
   y2NfFXsTf7OTeLJHGswWDtPfu00WlX6UYbm+I/7XNBK82IfOIVmY/+52v
   keeBDTFITErulWJrPt8weoFTPwXXfUxJp09sR3nYO/xjOjWLdn//rzxwM
   A==;
X-CSE-ConnectionGUID: /0GYnVd2TtyXZGM5K2uE3Q==
X-CSE-MsgGUID: oLuewYawQQ+gGuPx3gl4rA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13020150"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13020150"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 21:33:47 -0700
X-CSE-ConnectionGUID: 8RT/Yf0ARgyJ/OE23DfxQA==
X-CSE-MsgGUID: d7XCkl4BR1ePPmjqFJZRKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="66152441"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 27 May 2024 21:33:45 -0700
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
	kalesh-anakkur.purayil@broadcom.com
Subject: [iwl-next v3 13/15] ice: support subfunction devlink Tx topology
Date: Tue, 28 May 2024 06:38:11 +0200
Message-ID: <20240528043813.1342483-14-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
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
 .../net/ethernet/intel/ice/devlink/devlink_port.c    |  1 +
 drivers/net/ethernet/intel/ice/ice_repr.c            | 12 +++++++-----
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 58196c170b1b..327cc2767b03 100644
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
index fb3ff68e0666..4cfd90581d92 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -711,6 +711,7 @@ int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port)
  */
 void ice_devlink_destroy_sf_port(struct ice_dynamic_port *dyn_port)
 {
+	devl_rate_leaf_destroy(&dyn_port->devlink_port);
 	devl_port_unregister(&dyn_port->devlink_port);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 78abfdf5d47b..00d4a9125dfa 100644
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
 
@@ -480,6 +480,8 @@ static int ice_repr_add_sf(struct ice_repr *repr)
 	if (err)
 		goto err_netdev;
 
+	ice_repr_set_tx_topology(sf->vsi->back, priv_to_devlink(sf->vsi->back));
+
 	return 0;
 
 err_netdev:
-- 
2.42.0


