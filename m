Return-Path: <netdev+bounces-89564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C168AAB60
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 11:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C207F1F228A8
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 09:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB2776056;
	Fri, 19 Apr 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6kTlc73"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A729F7581A
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518439; cv=none; b=os8lIXuCVv3LQhxsrWYGz8OyJVL4uOKpGr4E3nK4LhCGeNmhLJ13q4Jp80roo8PwbBfSX+kzjf5Z8Qi6GIFhA+aAtQOBQMvZOQJcw9zA12w0Ec/nC5k7TVZUtrlv00/a/g14/1x8OVDN9Dnz4NXQUve4Q6oqvm7u8q1jY6DEfYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518439; c=relaxed/simple;
	bh=kLUTdPqERbSM74gcLikb57dC1Eif7yEcCMXkhnb6xPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jC+ucrdn7jlkftMml+LtANJFZKRFQC1DPMPATwglKyK7+hcp3BKOAM0iveRUDdL5qYgUBt0SCDelsTAc/OLDrUeyD7SpFwaWh0HD/ZYVVqmRRfTkUGXXn5KL8YM67GI/gH5zx8/BRrXzSrYTnANzhz01IBZ6cjK5knvkhzYb3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6kTlc73; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713518438; x=1745054438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kLUTdPqERbSM74gcLikb57dC1Eif7yEcCMXkhnb6xPo=;
  b=d6kTlc73NVNTxh/QKyVCWtfpuKMpwca/nxx4QE+uWkvsktZdxEqXlTP5
   f5a5gCOqHUQI1aady3cvDCCSKoTuOPVIW6liOhSSEe6bp4iB1PRbl2m0m
   Vr5ZUWiYRuU71VZ9G2xxti+x6N2OyRp6gWOMotzt0mhmSA62r3uzkmFHv
   VSUWsW/RdrB1EUKu8s0pp/LBk7PsjQ9V/Q7KPSXShEXAkEvdpyq8w1RIW
   NBb6TANyMTZ/SCH8kuPCk94m16gjGcP00Tl9ThO0Rdvope0rZH+U3urYq
   tI49SnVfvB3Wnq2wZb1JHLjHZGXWPBTB8dNEUVTaw5QimKsdwXKmawtSA
   g==;
X-CSE-ConnectionGUID: RJA2e51xTganBtHH2RZJeg==
X-CSE-MsgGUID: uloYkovTRmilCT8skFRDlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9238400"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9238400"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 02:20:37 -0700
X-CSE-ConnectionGUID: HwqDJ7lqQs+uRd1N6u90Mg==
X-CSE-MsgGUID: M4Pp741XSSSFRXlUYqLYpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="60716016"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 19 Apr 2024 02:20:33 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1A99428197;
	Fri, 19 Apr 2024 10:20:25 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Vaishnavi Tipireddy <vaishnavi.tipireddy@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v1] ice: refactor struct ice_vsi_cfg_params to be inside of struct ice_vsi
Date: Fri, 19 Apr 2024 05:11:04 -0400
Message-Id: <20240419091104.13495-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor struct ice_vsi_cfg_params to be embedded into struct ice_vsi.
Prior to that the members of the struct were scattered around ice_vsi,
and were copy-pasted for purposes of reinit.
Now we have struct handy, and it is easier to have something sticky
in the flags field.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Vaishnavi Tipireddy <vaishnavi.tipireddy@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  |  6 +--
 drivers/net/ethernet/intel/ice/ice.h          | 14 ++++---
 drivers/net/ethernet/intel/ice/ice_lib.c      | 33 ++++++----------
 drivers/net/ethernet/intel/ice/ice_lib.h      | 39 +------------------
 drivers/net/ethernet/intel/ice/ice_main.c     |  8 ++--
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  8 ++--
 7 files changed, 30 insertions(+), 80 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index be9244bb8bbc..0f1a46636b45 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1043,18 +1043,16 @@ static int ice_devlink_set_parent(struct devlink_rate *devlink_rate,
 static int ice_devlink_reinit_up(struct ice_pf *pf)
 {
 	struct ice_vsi *vsi = ice_get_main_vsi(pf);
-	struct ice_vsi_cfg_params params;
 	int err;
 
 	err = ice_init_dev(pf);
 	if (err)
 		return err;
 
-	params = ice_vsi_to_params(vsi);
-	params.flags = ICE_VSI_FLAG_INIT;
+	vsi->flags = ICE_VSI_FLAG_INIT;
 
 	rtnl_lock();
-	err = ice_vsi_cfg(vsi, &params);
+	err = ice_vsi_cfg(vsi);
 	rtnl_unlock();
 	if (err)
 		goto err_vsi_cfg;
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 67a3236ab1fc..6ad8002b22e1 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -331,7 +331,6 @@ struct ice_vsi {
 	struct net_device *netdev;
 	struct ice_sw *vsw;		 /* switch this VSI is on */
 	struct ice_pf *back;		 /* back pointer to PF */
-	struct ice_port_info *port_info; /* back pointer to port_info */
 	struct ice_rx_ring **rx_rings;	 /* Rx ring array */
 	struct ice_tx_ring **tx_rings;	 /* Tx ring array */
 	struct ice_q_vector **q_vectors; /* q_vector array */
@@ -349,12 +348,9 @@ struct ice_vsi {
 	/* tell if only dynamic irq allocation is allowed */
 	bool irq_dyn_alloc;
 
-	enum ice_vsi_type type;
 	u16 vsi_num;			/* HW (absolute) index of this VSI */
 	u16 idx;			/* software index in pf->vsi[] */
 
-	struct ice_vf *vf;		/* VF associated with this VSI */
-
 	u16 num_gfltr;
 	u16 num_bfltr;
 
@@ -446,12 +442,18 @@ struct ice_vsi {
 	u8 old_numtc;
 	u16 old_ena_tc;
 
-	struct ice_channel *ch;
-
 	/* setup back reference, to which aggregator node this VSI
 	 * corresponds to
 	 */
 	struct ice_agg_node *agg_node;
+
+	struct_group_tagged(ice_vsi_cfg_params, params,
+		struct ice_port_info *port_info; /* back pointer to port_info */
+		struct ice_channel *ch; /* VSI's channel structure, may be NULL */
+		struct ice_vf *vf; /* VF associated with this VSI, may be NULL */
+		u32 flags; /* VSI flags used for rebuild and configuration */
+		enum ice_vsi_type type; /* the type of the VSI */
+	);
 } ____cacheline_internodealigned_in_smp;
 
 /* struct that defines an interrupt vector */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d06e7c82c433..5371e91f6bbb 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2227,10 +2227,8 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
 /**
  * ice_vsi_cfg_def - configure default VSI based on the type
  * @vsi: pointer to VSI
- * @params: the parameters to configure this VSI with
  */
-static int
-ice_vsi_cfg_def(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
+static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 {
 	struct device *dev = ice_pf_to_dev(vsi->back);
 	struct ice_pf *pf = vsi->back;
@@ -2238,7 +2236,7 @@ ice_vsi_cfg_def(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
 
 	vsi->vsw = pf->first_sw;
 
-	ret = ice_vsi_alloc_def(vsi, params->ch);
+	ret = ice_vsi_alloc_def(vsi, vsi->ch);
 	if (ret)
 		return ret;
 
@@ -2263,7 +2261,7 @@ ice_vsi_cfg_def(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
 	ice_vsi_set_tc_cfg(vsi);
 
 	/* create the VSI */
-	ret = ice_vsi_init(vsi, params->flags);
+	ret = ice_vsi_init(vsi, vsi->flags);
 	if (ret)
 		goto unroll_get_qs;
 
@@ -2383,23 +2381,16 @@ ice_vsi_cfg_def(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
 /**
  * ice_vsi_cfg - configure a previously allocated VSI
  * @vsi: pointer to VSI
- * @params: parameters used to configure this VSI
  */
-int ice_vsi_cfg(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
+int ice_vsi_cfg(struct ice_vsi *vsi)
 {
 	struct ice_pf *pf = vsi->back;
 	int ret;
 
-	if (WARN_ON(params->type == ICE_VSI_VF && !params->vf))
+	if (WARN_ON(vsi->type == ICE_VSI_VF && !vsi->vf))
 		return -EINVAL;
 
-	vsi->type = params->type;
-	vsi->port_info = params->pi;
-
-	/* For VSIs which don't have a connected VF, this will be NULL */
-	vsi->vf = params->vf;
-
-	ret = ice_vsi_cfg_def(vsi, params);
+	ret = ice_vsi_cfg_def(vsi);
 	if (ret)
 		return ret;
 
@@ -2485,7 +2476,7 @@ ice_vsi_setup(struct ice_pf *pf, struct ice_vsi_cfg_params *params)
 	 * a port_info structure for it.
 	 */
 	if (WARN_ON(!(params->flags & ICE_VSI_FLAG_INIT)) ||
-	    WARN_ON(!params->pi))
+	    WARN_ON(!params->port_info))
 		return NULL;
 
 	vsi = ice_vsi_alloc(pf);
@@ -2494,7 +2485,8 @@ ice_vsi_setup(struct ice_pf *pf, struct ice_vsi_cfg_params *params)
 		return NULL;
 	}
 
-	ret = ice_vsi_cfg(vsi, params);
+	vsi->params = *params;
+	ret = ice_vsi_cfg(vsi);
 	if (ret)
 		goto err_vsi_cfg;
 
@@ -3041,7 +3033,6 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
  */
 int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 {
-	struct ice_vsi_cfg_params params = {};
 	struct ice_coalesce_stored *coalesce;
 	int prev_num_q_vectors;
 	struct ice_pf *pf;
@@ -3050,9 +3041,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 	if (!vsi)
 		return -EINVAL;
 
-	params = ice_vsi_to_params(vsi);
-	params.flags = vsi_flags;
-
+	vsi->flags = vsi_flags;
 	pf = vsi->back;
 	if (WARN_ON(vsi->type == ICE_VSI_VF && !vsi->vf))
 		return -EINVAL;
@@ -3062,7 +3051,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 		goto err_vsi_cfg;
 
 	ice_vsi_decfg(vsi);
-	ret = ice_vsi_cfg_def(vsi, &params);
+	ret = ice_vsi_cfg_def(vsi);
 	if (ret)
 		goto err_vsi_cfg;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 9cd23afe5f15..94ce8964dda6 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -11,43 +11,6 @@
 #define ICE_VSI_FLAG_INIT	BIT(0)
 #define ICE_VSI_FLAG_NO_INIT	0
 
-/**
- * struct ice_vsi_cfg_params - VSI configuration parameters
- * @pi: pointer to the port_info instance for the VSI
- * @ch: pointer to the channel structure for the VSI, may be NULL
- * @vf: pointer to the VF associated with this VSI, may be NULL
- * @type: the type of VSI to configure
- * @flags: VSI flags used for rebuild and configuration
- *
- * Parameter structure used when configuring a new VSI.
- */
-struct ice_vsi_cfg_params {
-	struct ice_port_info *pi;
-	struct ice_channel *ch;
-	struct ice_vf *vf;
-	enum ice_vsi_type type;
-	u32 flags;
-};
-
-/**
- * ice_vsi_to_params - Get parameters for an existing VSI
- * @vsi: the VSI to get parameters for
- *
- * Fill a parameter structure for reconfiguring a VSI with its current
- * parameters, such as during a rebuild operation.
- */
-static inline struct ice_vsi_cfg_params ice_vsi_to_params(struct ice_vsi *vsi)
-{
-	struct ice_vsi_cfg_params params = {};
-
-	params.pi = vsi->port_info;
-	params.ch = vsi->ch;
-	params.vf = vsi->vf;
-	params.type = vsi->type;
-
-	return params;
-}
-
 const char *ice_vsi_type_str(enum ice_vsi_type vsi_type);
 
 bool ice_pf_state_is_nominal(struct ice_pf *pf);
@@ -101,7 +64,7 @@ void ice_vsi_decfg(struct ice_vsi *vsi);
 void ice_dis_vsi(struct ice_vsi *vsi, bool locked);
 
 int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags);
-int ice_vsi_cfg(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params);
+int ice_vsi_cfg(struct ice_vsi *vsi);
 
 bool ice_is_reset_in_progress(unsigned long *state);
 int ice_wait_for_reset(struct ice_pf *pf, unsigned long timeout);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 80bc83f6e1ab..6e4d261d9e84 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3684,7 +3684,7 @@ ice_pf_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi)
 	struct ice_vsi_cfg_params params = {};
 
 	params.type = ICE_VSI_PF;
-	params.pi = pi;
+	params.port_info = pi;
 	params.flags = ICE_VSI_FLAG_INIT;
 
 	return ice_vsi_setup(pf, &params);
@@ -3697,7 +3697,7 @@ ice_chnl_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi,
 	struct ice_vsi_cfg_params params = {};
 
 	params.type = ICE_VSI_CHNL;
-	params.pi = pi;
+	params.port_info = pi;
 	params.ch = ch;
 	params.flags = ICE_VSI_FLAG_INIT;
 
@@ -3718,7 +3718,7 @@ ice_ctrl_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi)
 	struct ice_vsi_cfg_params params = {};
 
 	params.type = ICE_VSI_CTRL;
-	params.pi = pi;
+	params.port_info = pi;
 	params.flags = ICE_VSI_FLAG_INIT;
 
 	return ice_vsi_setup(pf, &params);
@@ -3738,7 +3738,7 @@ ice_lb_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi)
 	struct ice_vsi_cfg_params params = {};
 
 	params.type = ICE_VSI_LB;
-	params.pi = pi;
+	params.port_info = pi;
 	params.flags = ICE_VSI_FLAG_INIT;
 
 	return ice_vsi_setup(pf, &params);
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index a60dacf8942a..067712f4923f 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -225,7 +225,7 @@ static struct ice_vsi *ice_vf_vsi_setup(struct ice_vf *vf)
 	struct ice_vsi *vsi;
 
 	params.type = ICE_VSI_VF;
-	params.pi = ice_vf_get_port_info(vf);
+	params.port_info = ice_vf_get_port_info(vf);
 	params.vf = vf;
 	params.flags = ICE_VSI_FLAG_INIT;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index c51e2482cad2..cf9f56a39b61 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -259,20 +259,18 @@ static void ice_vf_pre_vsi_rebuild(struct ice_vf *vf)
 int ice_vf_reconfig_vsi(struct ice_vf *vf)
 {
 	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
-	struct ice_vsi_cfg_params params = {};
 	struct ice_pf *pf = vf->pf;
 	int err;
 
 	if (WARN_ON(!vsi))
 		return -EINVAL;
 
-	params = ice_vsi_to_params(vsi);
-	params.flags = ICE_VSI_FLAG_NO_INIT;
+	vsi->flags = ICE_VSI_FLAG_NO_INIT;
 
 	ice_vsi_decfg(vsi);
 	ice_fltr_remove_all(vsi);
 
-	err = ice_vsi_cfg(vsi, &params);
+	err = ice_vsi_cfg(vsi);
 	if (err) {
 		dev_err(ice_pf_to_dev(pf),
 			"Failed to reconfigure the VF%u's VSI, error %d\n",
@@ -1243,7 +1241,7 @@ struct ice_vsi *ice_vf_ctrl_vsi_setup(struct ice_vf *vf)
 	struct ice_vsi *vsi;
 
 	params.type = ICE_VSI_CTRL;
-	params.pi = ice_vf_get_port_info(vf);
+	params.port_info = ice_vf_get_port_info(vf);
 	params.vf = vf;
 	params.flags = ICE_VSI_FLAG_INIT;
 
-- 
2.38.1


