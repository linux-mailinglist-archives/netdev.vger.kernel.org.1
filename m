Return-Path: <netdev+bounces-139475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E931A9B2C3E
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67698B21901
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 10:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64C41CCB34;
	Mon, 28 Oct 2024 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ro9e73kg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6F1D0DF7
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109834; cv=none; b=pqGcA/VjI+NW9p+gpbxLtAjFA/Jf60l31a+dhZFvOxWkPolRjgkXJTriTy3aElXVyg0DDbPv91CMciY8XAv65MhMpx/+f88WIUzRKVIbasyy2KEYpssUq5o3Hv66tCYH6pfKmQt0hCT9sXUhqcvGrDeS4SOvSJnXp8ScIWl9viE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109834; c=relaxed/simple;
	bh=8oKc2MmG4R7odW5G1k98XLyef5TSCgK6ngSyHoLByLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYqo3jHGDK2i+NXsd4Z94tL1nrSSchEWzvT/a7HDbO14dIJu5a3PJ9+ugWqTjpVj31wQuJxPODIfND3CuEsHo3mOg2pO0BJB7ZwHcOpk4vOb5TUs3Ya2zUMcbYqaPIRdXpmv03g9NZaAq7gKqSBhBavm8SoD398j58QuH0O4ZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ro9e73kg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730109833; x=1761645833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8oKc2MmG4R7odW5G1k98XLyef5TSCgK6ngSyHoLByLM=;
  b=Ro9e73kgqFAtSPyXciPhcHDOmhgWKPB0EiYyU2iuabXO9gRAAAgCgpPX
   ELoZBkDo7/C9MD7ZEz6ImR+EpBQOv2I5kmklVwmdAoG/3WKIHPQfB2IoB
   t3S+MRlFh1qG+XqLc/+yD/NqkeRnssvOvUyylBJrIJklBbhy0726zHsXh
   kTsS/ZlI1uUIQME24+2IavA3i4ij2G02Jl+Pebs96ig2y2CzDL3YVGZMp
   V0bw5pmUH2S+3Ap4EOJgE8SrTWQIK5h0UX8O5v23OaYiYvUaiV5XI2mAl
   GkEJVjhdEg9cbr6G+McSrE86FxW+PMjhDWrjnD9ZxTDE83EHyCX5LX9Qh
   Q==;
X-CSE-ConnectionGUID: kb7PFCNSQlaK5n+JfIxTlg==
X-CSE-MsgGUID: LsnBfAh3SFq9BzRKRGX+cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29560725"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29560725"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 03:03:53 -0700
X-CSE-ConnectionGUID: PRV5OX/dQ7GZjkY65wbARw==
X-CSE-MsgGUID: xpwCXzbESBOsYVBKwhZtCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86182287"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa004.fm.intel.com with ESMTP; 28 Oct 2024 03:03:48 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pio.raczynski@gmail.com,
	konrad.knitter@intel.com,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Laight@ACULAB.COM
Subject: [iwl-next v6 2/9] ice: devlink PF MSI-X max and min parameter
Date: Mon, 28 Oct 2024 11:03:34 +0100
Message-ID: <20241028100341.16631-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241028100341.16631-1-michal.swiatkowski@linux.intel.com>
References: <20241028100341.16631-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use generic devlink PF MSI-X parameter to allow user to change MSI-X
range.

Add notes about this parameters into ice devlink documentation.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 Documentation/networking/devlink/ice.rst      | 11 +++
 .../net/ethernet/intel/ice/devlink/devlink.c  | 83 ++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice.h          |  7 ++
 drivers/net/ethernet/intel/ice/ice_irq.c      |  7 ++
 4 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index e3972d03cea0..792e9f8c846a 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -69,6 +69,17 @@ Parameters
 
        To verify that value has been set:
        $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
+   * - ``msix_vec_per_pf_max``
+     - driverinit
+     - Set the max MSI-X that can be used by the PF, rest can be utilized for
+       SRIOV. The range is from min value set in msix_vec_per_pf_min to
+       2k/number of ports.
+   * - ``msix_vec_per_pf_min``
+     - driverinit
+     - Set the min MSI-X that will be used by the PF. This value inform how many
+       MSI-X will be allocated statically. The range is from 2 to value set
+       in msix_vec_per_pf_max.
+
 .. list-table:: Driver specific parameters implemented
     :widths: 5 5 90
 
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index d1b9ccec5e05..29c1fec4fa93 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1198,6 +1198,25 @@ static int ice_devlink_set_parent(struct devlink_rate *devlink_rate,
 	return status;
 }
 
+static void ice_set_min_max_msix(struct ice_pf *pf)
+{
+	struct devlink *devlink = priv_to_devlink(pf);
+	union devlink_param_value val;
+	int err;
+
+	err = devl_param_driverinit_value_get(devlink,
+					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
+					      &val);
+	if (!err)
+		pf->msix.min = val.vu16;
+
+	err = devl_param_driverinit_value_get(devlink,
+					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
+					      &val);
+	if (!err)
+		pf->msix.max = val.vu16;
+}
+
 /**
  * ice_devlink_reinit_up - do reinit of the given PF
  * @pf: pointer to the PF struct
@@ -1207,6 +1226,9 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 	struct ice_vsi *vsi = ice_get_main_vsi(pf);
 	int err;
 
+	/* load MSI-X values */
+	ice_set_min_max_msix(pf);
+
 	err = ice_init_hw(&pf->hw);
 	if (err) {
 		dev_err(ice_pf_to_dev(pf), "ice_init_hw failed: %d\n", err);
@@ -1526,6 +1548,37 @@ static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int
+ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
+				 union devlink_param_value val,
+				 struct netlink_ext_ack *extack)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+
+	if (val.vu16 > pf->hw.func_caps.common_cap.num_msix_vectors ||
+	    val.vu16 < pf->msix.min) {
+		NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
+				 union devlink_param_value val,
+				 struct netlink_ext_ack *extack)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+
+	if (val.vu16 <= ICE_MIN_MSIX || val.vu16 > pf->msix.max) {
+		NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 enum ice_param_id {
 	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
@@ -1543,6 +1596,15 @@ static const struct devlink_param ice_dvl_rdma_params[] = {
 			      ice_devlink_enable_iw_validate),
 };
 
+static const struct devlink_param ice_dvl_msix_params[] = {
+	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MAX,
+			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
+			      NULL, NULL, ice_devlink_msix_max_pf_validate),
+	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MIN,
+			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
+			      NULL, NULL, ice_devlink_msix_min_pf_validate),
+};
+
 static const struct devlink_param ice_dvl_sched_params[] = {
 	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
 			     "tx_scheduling_layers",
@@ -1644,6 +1706,7 @@ void ice_devlink_unregister(struct ice_pf *pf)
 int ice_devlink_register_params(struct ice_pf *pf)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
+	union devlink_param_value value;
 	struct ice_hw *hw = &pf->hw;
 	int status;
 
@@ -1652,11 +1715,27 @@ int ice_devlink_register_params(struct ice_pf *pf)
 	if (status)
 		return status;
 
+	status = devl_params_register(devlink, ice_dvl_msix_params,
+				      ARRAY_SIZE(ice_dvl_msix_params));
+	if (status)
+		return status;
+
 	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
 		status = devl_params_register(devlink, ice_dvl_sched_params,
 					      ARRAY_SIZE(ice_dvl_sched_params));
+	if (status)
+		return status;
 
-	return status;
+	value.vu16 = pf->msix.max;
+	devl_param_driverinit_value_set(devlink,
+					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
+					value);
+	value.vu16 = pf->msix.min;
+	devl_param_driverinit_value_set(devlink,
+					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
+					value);
+
+	return 0;
 }
 
 void ice_devlink_unregister_params(struct ice_pf *pf)
@@ -1666,6 +1745,8 @@ void ice_devlink_unregister_params(struct ice_pf *pf)
 
 	devl_params_unregister(devlink, ice_dvl_rdma_params,
 			       ARRAY_SIZE(ice_dvl_rdma_params));
+	devl_params_unregister(devlink, ice_dvl_msix_params,
+			       ARRAY_SIZE(ice_dvl_msix_params));
 
 	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
 		devl_params_unregister(devlink, ice_dvl_sched_params,
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 7997745686b3..c6cd7e993ed8 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -543,6 +543,12 @@ struct ice_agg_node {
 	u8 valid;
 };
 
+struct ice_pf_msix {
+	u16 cur;
+	u16 min;
+	u16 max;
+};
+
 struct ice_pf {
 	struct pci_dev *pdev;
 	struct ice_adapter *adapter;
@@ -613,6 +619,7 @@ struct ice_pf {
 	struct msi_map ll_ts_irq;	/* LL_TS interrupt MSIX vector */
 	u16 max_pf_txqs;	/* Total Tx queues PF wide */
 	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
+	struct ice_pf_msix msix;
 	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
 	u16 num_lan_tx;		/* num LAN Tx queues setup */
 	u16 num_lan_rx;		/* num LAN Rx queues setup */
diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index ad82ff7d1995..0659b96b9b8c 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -254,6 +254,13 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
 	int vectors, max_vectors;
 
+	/* load default PF MSI-X range */
+	if (!pf->msix.min)
+		pf->msix.min = ICE_MIN_MSIX;
+
+	if (!pf->msix.max)
+		pf->msix.max = total_vectors / 2;
+
 	vectors = ice_ena_msix_range(pf);
 
 	if (vectors < 0)
-- 
2.42.0


