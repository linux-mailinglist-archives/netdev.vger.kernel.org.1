Return-Path: <netdev+bounces-89702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADB28AB42E
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 19:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340DE286D35
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 17:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13777139590;
	Fri, 19 Apr 2024 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nt3Z2ZuI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F20E13A877
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546535; cv=none; b=guEC80aMvvx+zWjs/FzwKzCAB/jHmVjcnRYYfA6GgBn5EbkbuebhDtRPBZZuX76lP/w75pfvLyDtOOPxBjg1AOTX6ZsBE0IMdxOhVqOgOT8hcnpOr5EjrrGpCZZQxblz2ngRmBNAB0o3GbKdgZ+3xhDvSO8yhvJ1DpNn3IP6rTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546535; c=relaxed/simple;
	bh=J45kRKvnHyS+3diwekn2tb6YqQK7kWm5g7ur8re4vSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qf61oDZdwHGAZWNb0dKMeS3oxfAcgczM5wPyoEwmXSKZwEuioifiVS3cSL/dM4XEuI3QjZul9KdetX3fswwFttOhgjR8lxjU8H5UWsRNDH3MvRlC94BcDweZxVuyDfiTbaQ+Dl4OU2JIwOui6KzlWI5aNm5B/bfGj771Her8S3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nt3Z2ZuI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713546533; x=1745082533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J45kRKvnHyS+3diwekn2tb6YqQK7kWm5g7ur8re4vSQ=;
  b=Nt3Z2ZuIjIQ2oGkYWWbI3TgxUV3jtsNPfuZaiIF2hRFVDDkbm+ajpjSh
   3wOnagZAMQy3iwbPsKOcanxM5JUTWamAnl3dfMuVOc75Nd9+z52k0KmRq
   Rmqk7xBTytlC9jYfbbeNghDftMp2s5pVomPQG/uSCYRmCdt6rbJ+UjdBq
   D/u01467UaL5kDKy6K+HxbrqS0fdDcGd/RRpA8vQsL8UiXA1AG9DTZ9OM
   hWVLbQCjY+rhzU0JdVLBI2+5MIafi9lGNtzw0aavdtVHSShLqJOMWzy00
   +8JYqWkRExwDxw687v4iYXpDcaCSSc4BZdqgEjQzOMj+PJa8iJaBI3CfJ
   Q==;
X-CSE-ConnectionGUID: 0gtf+mQuRRuFx8JgBB5dvg==
X-CSE-MsgGUID: PbNpmGhcQn+b33SXLjc0+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="26674312"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="26674312"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:08:53 -0700
X-CSE-ConnectionGUID: cfX4Rg1cSZqYCJwqdh2Szw==
X-CSE-MsgGUID: qvql3h4hTIemRdcXmvpDdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="27847181"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa005.fm.intel.com with ESMTP; 19 Apr 2024 10:08:50 -0700
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
Subject: [iwl-next v1 4/4] ice: update representor when VSI is ready
Date: Fri, 19 Apr 2024 19:13:36 +0200
Message-ID: <20240419171336.11617-5-michal.swiatkowski@linux.intel.com>
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

In case of reset of VF VSI can be reallocated. To handle this case it
should be properly updated.

Reload representor as vsi->vsi_num can be different than the one stored
when representor was created.

Instead of only changing antispoof do whole VSI configuration for
eswitch.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 21 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_eswitch.h |  4 ++--
 drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  2 +-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 998590223f02..4c1d29b8f105 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -176,16 +176,16 @@ void ice_eswitch_decfg_vsi(struct ice_vsi *vsi, const u8 *mac)
  * @repr_id: representor ID
  * @vsi: VSI for which port representor is configured
  */
-void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi)
+void ice_eswitch_update_repr(unsigned long *repr_id, struct ice_vsi *vsi)
 {
 	struct ice_pf *pf = vsi->back;
 	struct ice_repr *repr;
-	int ret;
+	int err;
 
 	if (!ice_is_switchdev_running(pf))
 		return;
 
-	repr = xa_load(&pf->eswitch.reprs, repr_id);
+	repr = xa_load(&pf->eswitch.reprs, *repr_id);
 	if (!repr)
 		return;
 
@@ -195,12 +195,19 @@ void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi)
 	if (repr->br_port)
 		repr->br_port->vsi = vsi;
 
-	ret = ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof);
-	if (ret) {
-		ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
-					       ICE_FWD_TO_VSI);
+	err = ice_eswitch_cfg_vsi(vsi, repr->parent_mac);
+	if (err)
 		dev_err(ice_pf_to_dev(pf), "Failed to update VSI of port representor %d",
 			repr->id);
+
+	/* The VSI number is different, reload the PR with new id */
+	if (repr->id != vsi->vsi_num) {
+		xa_erase(&pf->eswitch.reprs, repr->id);
+		repr->id = vsi->vsi_num;
+		if (xa_insert(&pf->eswitch.reprs, repr->id, repr, GFP_KERNEL))
+			dev_err(ice_pf_to_dev(pf), "Failed to reload port representor %d",
+				repr->id);
+		*repr_id = repr->id;
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index 9a25606e9740..09194d514f9b 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -18,7 +18,7 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		     struct netlink_ext_ack *extack);
 bool ice_is_eswitch_mode_switchdev(struct ice_pf *pf);
 
-void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi);
+void ice_eswitch_update_repr(unsigned long *repr_id, struct ice_vsi *vsi);
 
 void ice_eswitch_stop_all_tx_queues(struct ice_pf *pf);
 
@@ -47,7 +47,7 @@ ice_eswitch_set_target_vsi(struct sk_buff *skb,
 			   struct ice_tx_offload_params *off) { }
 
 static inline void
-ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi) { }
+ice_eswitch_update_repr(unsigned long *repr_id, struct ice_vsi *vsi) { }
 
 static inline int ice_eswitch_configure(struct ice_pf *pf)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index c51e2482cad2..424975d972f6 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -950,7 +950,7 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 		goto out_unlock;
 	}
 
-	ice_eswitch_update_repr(vf->repr_id, vsi);
+	ice_eswitch_update_repr(&vf->repr_id, vsi);
 
 	/* if the VF has been reset allow it to come up again */
 	ice_mbx_clear_malvf(&vf->mbx_info);
-- 
2.42.0


