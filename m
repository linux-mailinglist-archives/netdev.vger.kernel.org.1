Return-Path: <netdev+bounces-47794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BE27EB63D
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DE69B20CB4
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D842FC54;
	Tue, 14 Nov 2023 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwmKl6mG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB0F26AFD
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:15:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441B112A
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699985726; x=1731521726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cBPVgZxMIijm1JL9SShegT7OpDRHU5HjqTKVTKXO/Fc=;
  b=VwmKl6mGNqskHIwE3OWwYHhpkju0UM+FUFoJzlIl0QCe7qnoPJdDFIIo
   /6tA6i+o1PQW93wrlFSUjDARxLu71qbDNdEKd++bMSKIi0Y4695vAwpzN
   ziPW+aFA0PkI7G5X+nXPoZ0iYvGl4R0OITE2+Fzos0iH7QII5S4lRDHeT
   LGcanQEjye7TWjM2N5z8VmayAhAWvQuSTQUxJgi9gA1nr0zVpYIMsHX+m
   +Ha6FQd+s70qkc8ff0a+uPquoCjEvI2NnLTccURC3Yu1UCO6gB9Mgl1qX
   +QNOabYY+dVN/BRpKakgSWlaXTDO+6xC2SKLXKzj+x+RnTGv0cCcVfD8N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390514539"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390514539"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:15:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741160971"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741160971"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2023 10:15:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	piotr.raczynski@intel.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 14/15] ice: adjust switchdev rebuild path
Date: Tue, 14 Nov 2023 10:14:34 -0800
Message-ID: <20231114181449.1290117-15-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
References: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

There is no need to use specific functions for rebuilding path. Let's
use current implementation by removing all representors and as the
result remove switchdev environment.

It will be added in devices rebuild path. For example during adding VFs,
port representors for them also will be created.

Rebuild control plane VSI before removing representors with INIT_VSI
flag set to reinit VSI in hardware after reset.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 66 +++++++-------------
 drivers/net/ethernet/intel/ice/ice_main.c    |  4 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  7 +--
 3 files changed, 28 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index de5744aa5c2a..9ff4fe4fb133 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -406,19 +406,6 @@ ice_eswitch_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi)
 	return ice_vsi_setup(pf, &params);
 }
 
-/**
- * ice_eswitch_napi_del - remove NAPI handle for all port representors
- * @reprs: xarray of reprs
- */
-static void ice_eswitch_napi_del(struct xarray *reprs)
-{
-	struct ice_repr *repr;
-	unsigned long id;
-
-	xa_for_each(reprs, id, repr)
-		netif_napi_del(&repr->q_vector->napi);
-}
-
 /**
  * ice_eswitch_napi_enable - enable NAPI for all port representors
  * @reprs: xarray of reprs
@@ -624,36 +611,6 @@ static void ice_eswitch_start_reprs(struct ice_pf *pf)
 	ice_eswitch_add_sp_rules(pf);
 }
 
-/**
- * ice_eswitch_rebuild - rebuild eswitch
- * @pf: pointer to PF structure
- */
-int ice_eswitch_rebuild(struct ice_pf *pf)
-{
-	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
-	int status;
-
-	ice_eswitch_napi_disable(&pf->eswitch.reprs);
-	ice_eswitch_napi_del(&pf->eswitch.reprs);
-
-	status = ice_eswitch_setup_env(pf);
-	if (status)
-		return status;
-
-	ice_eswitch_remap_rings_to_vectors(&pf->eswitch);
-
-	ice_replay_tc_fltrs(pf);
-
-	status = ice_vsi_open(ctrl_vsi);
-	if (status)
-		return status;
-
-	ice_eswitch_napi_enable(&pf->eswitch.reprs);
-	ice_eswitch_start_all_tx_queues(pf);
-
-	return 0;
-}
-
 static void
 ice_eswitch_cp_change_queues(struct ice_eswitch *eswitch, int change)
 {
@@ -752,3 +709,26 @@ void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf)
 		ice_eswitch_start_reprs(pf);
 	}
 }
+
+/**
+ * ice_eswitch_rebuild - rebuild eswitch
+ * @pf: pointer to PF structure
+ */
+int ice_eswitch_rebuild(struct ice_pf *pf)
+{
+	struct ice_repr *repr;
+	unsigned long id;
+	int err;
+
+	if (!ice_is_switchdev_running(pf))
+		return 0;
+
+	err = ice_vsi_rebuild(pf->eswitch.control_vsi, ICE_VSI_FLAG_INIT);
+	if (err)
+		return err;
+
+	xa_for_each(&pf->eswitch.reprs, id, repr)
+		ice_eswitch_detach(pf, repr->vf);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7ea6e2ad3272..10822011de22 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7412,9 +7412,9 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 			ice_ptp_cfg_timestamp(pf, true);
 	}
 
-	err = ice_vsi_rebuild_by_type(pf, ICE_VSI_SWITCHDEV_CTRL);
+	err = ice_eswitch_rebuild(pf);
 	if (err) {
-		dev_err(dev, "Switchdev CTRL VSI rebuild failed: %d\n", err);
+		dev_err(dev, "Switchdev rebuild failed: %d\n", err);
 		goto err_vsi_rebuild;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 68f9de0a7a8f..d2a99a20c4ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -760,6 +760,7 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 	ice_for_each_vf(pf, bkt, vf) {
 		mutex_lock(&vf->cfg_lock);
 
+		ice_eswitch_detach(pf, vf);
 		vf->driver_caps = 0;
 		ice_vc_set_default_allowlist(vf);
 
@@ -775,13 +776,11 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 		ice_vf_rebuild_vsi(vf);
 		ice_vf_post_vsi_rebuild(vf);
 
+		ice_eswitch_attach(pf, vf);
+
 		mutex_unlock(&vf->cfg_lock);
 	}
 
-	if (ice_is_eswitch_mode_switchdev(pf))
-		if (ice_eswitch_rebuild(pf))
-			dev_warn(dev, "eswitch rebuild failed\n");
-
 	ice_flush(hw);
 	clear_bit(ICE_VF_DIS, pf->state);
 
-- 
2.41.0


