Return-Path: <netdev+bounces-159058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7187A143F8
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D73169202
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5342419FA;
	Thu, 16 Jan 2025 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4hZv2TV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E27236A87
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737062478; cv=none; b=t5m7IDNflycVBTCWEqzfAMDXYXvrZZPsj6AnLDFy7Uac+1Vp0XRLzANgRihiBY2MHoADWOO3nsflZqbZvgbwxkDI0UrH0gm6T6t9SbWymuGduCBS2L8q/SBnJFxf1S8Doc9PX6Zna1bfzXsmaEK97gUUg8o3JGW/fdbp/ehyW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737062478; c=relaxed/simple;
	bh=M6BndXKI15UFim+F3BZL7dQTHjrl7M1wsuCDAgcZU8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcOFl9fbkRa6YW/xeTP7BVCGDjY7tYlAqlko4B2+kftv/Tl46HyCj9ENYiCwmzgS5JD1Ic3vnZJnE4HQ/sqXamcuQbi+V59XDi4rcSXIDJl+qvOLTi83AI2d8Z8L2T+AEiocSuZXYNbd2IEQckv4Q7SrN3Ie2vQkMQjRRmnsWXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4hZv2TV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737062476; x=1768598476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M6BndXKI15UFim+F3BZL7dQTHjrl7M1wsuCDAgcZU8Y=;
  b=i4hZv2TVG3dJSwH+JQzzdw0sOIhBzj5uoIcCdSHttiiiAKo3oPOv4yPi
   LG5v7nG2ascGXomNg3RSMJU9W86APCrl4EnfyNMGeJbBT89qO+pmOglS2
   0tqRPI/2s93Cm7k7Sgq02UUV0rdOiAPkkwHJXI8UPIBquWkj3Yb/6eIPz
   m6O7T46JumlCehFSfUo9zqiwQhqPm+lwa8FeAw7H8k8t8/YvbLJI7I6DI
   Hj1hz02xai1UVo8frsGYoHZGAE4D794yLmEyWnP1mwHqoggVgyjXb7csz
   l895t0iXEizJpVq2dQ2shpNpL95KYKmRzNUFwgpkcK+Fg1FPUfVc9XiS7
   Q==;
X-CSE-ConnectionGUID: iltm82X1RmGgUa5Zmfn9uw==
X-CSE-MsgGUID: 75f8uwuERuqZeFjzjbqdVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="55019538"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="55019538"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 13:21:11 -0800
X-CSE-ConnectionGUID: Pj+n/MK9T+y0rzsz6gge1w==
X-CSE-MsgGUID: RzsbdWM4SiKrPusirFs+/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="105572576"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jan 2025 13:21:10 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Konrad Knitter <konrad.knitter@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org
Subject: [PATCH net-next 3/3] ice: support FW Recovery Mode
Date: Thu, 16 Jan 2025 13:20:57 -0800
Message-ID: <20250116212059.1254349-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116212059.1254349-1-anthony.l.nguyen@intel.com>
References: <20250116212059.1254349-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Knitter <konrad.knitter@intel.com>

Recovery Mode is intended to recover from a fatal failure scenario in
which the device is not accessible to the host, meaning the firmware is
non-responsive.

The purpose of the Firmware Recovery Mode is to enable software tools to
update firmware and/or device configuration so the fatal error can be
resolved.

Recovery Mode Firmware supports a limited set of admin commands required
for NVM update.
Recovery Firmware does not support hardware interrupts so a polling mode
is used.

The driver will expose only the minimum set of devlink commands required
for the recovery of the adapter.

Using an appropriate NVM image, the user can recover the adapter using
the devlink flash API.

Prior to 4.20 E810 Adapter Recovery Firmware supports only the update
and erase of the "fw.mgmt" component.

E810 Adapter Recovery Firmware doesn't support selected preservation of
cards settings or identifiers.

The following command can be used to recover the adapter:

$ devlink dev flash <pci-address> <update-image.bin> component fw.mgmt
  overwrite settings overwrite identifier

Newer FW versions (4.20 or newer) supports update of "fw.undi" and
"fw.netlist" components.

$ devlink dev flash <pci-address> <update-image.bin>

Tested on Intel Corporation Ethernet Controller E810-C for SFP
FW revision 3.20 and 4.30.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  |  8 ++-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 .../net/ethernet/intel/ice/ice_fw_update.c    | 14 ++++-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  6 +++
 drivers/net/ethernet/intel/ice/ice_lib.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 53 +++++++++++++++++++
 6 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index d1b9ccec5e05..d116e2b10bce 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -368,14 +368,18 @@ static int ice_devlink_info_get(struct devlink *devlink,
 			}
 			break;
 		case ICE_VERSION_RUNNING:
-			err = devlink_info_version_running_put(req, key, ctx->buf);
+			err = devlink_info_version_running_put_ext(req, key,
+								   ctx->buf,
+								   DEVLINK_INFO_VERSION_TYPE_COMPONENT);
 			if (err) {
 				NL_SET_ERR_MSG_MOD(extack, "Unable to set running version");
 				goto out_free_ctx;
 			}
 			break;
 		case ICE_VERSION_STORED:
-			err = devlink_info_version_stored_put(req, key, ctx->buf);
+			err = devlink_info_version_stored_put_ext(req, key,
+								  ctx->buf,
+								  DEVLINK_INFO_VERSION_TYPE_COMPONENT);
 			if (err) {
 				NL_SET_ERR_MSG_MOD(extack, "Unable to set stored version");
 				goto out_free_ctx;
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index dd41a4dcc0b9..1f65eedabf7c 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1814,6 +1814,7 @@ struct ice_aqc_nvm_pass_comp_tbl {
 #define ICE_AQ_NVM_PASS_COMP_CAN_BE_UPDATED		0x0
 #define ICE_AQ_NVM_PASS_COMP_CAN_MAY_BE_UPDATEABLE	0x1
 #define ICE_AQ_NVM_PASS_COMP_CAN_NOT_BE_UPDATED		0x2
+#define ICE_AQ_NVM_PASS_COMP_PARTIAL_CHECK		0x3
 	u8 component_response_code; /* Response only */
 #define ICE_AQ_NVM_PASS_COMP_CAN_BE_UPDATED_CODE	0x0
 #define ICE_AQ_NVM_PASS_COMP_STAMP_IDENTICAL_CODE	0x1
diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index 2702a0da5c3e..70c201f569ce 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -6,6 +6,7 @@
 #include <linux/crc32.h>
 #include <linux/pldmfw.h>
 #include "ice.h"
+#include "ice_lib.h"
 #include "ice_fw_update.h"
 
 struct ice_fwu_priv {
@@ -125,6 +126,10 @@ ice_check_component_response(struct ice_pf *pf, u16 id, u8 response, u8 code,
 	case ICE_AQ_NVM_PASS_COMP_CAN_NOT_BE_UPDATED:
 		dev_info(dev, "firmware has rejected updating %s\n", component);
 		break;
+	case ICE_AQ_NVM_PASS_COMP_PARTIAL_CHECK:
+		if (ice_is_recovery_mode(&pf->hw))
+			return 0;
+		break;
 	}
 
 	switch (code) {
@@ -1004,13 +1009,20 @@ int ice_devlink_flash_update(struct devlink *devlink,
 		return -EOPNOTSUPP;
 	}
 
-	if (!hw->dev_caps.common_cap.nvm_unified_update) {
+	if (!hw->dev_caps.common_cap.nvm_unified_update && !ice_is_recovery_mode(hw)) {
 		NL_SET_ERR_MSG_MOD(extack, "Current firmware does not support unified update");
 		return -EOPNOTSUPP;
 	}
 
 	memset(&priv, 0, sizeof(priv));
 
+	if (params->component && strcmp(params->component, "fw.mgmt") == 0) {
+		priv.context.mode = PLDMFW_UPDATE_MODE_SINGLE_COMPONENT;
+		priv.context.component_identifier = NVM_COMP_ID_NVM;
+	} else if (params->component) {
+		return -EOPNOTSUPP;
+	}
+
 	/* the E822 device needs a slightly different ops */
 	if (hw->mac_type == ICE_MAC_GENERIC)
 		priv.context.ops = &ice_fwu_ops_e822;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index a7d45a8ce7ac..38a1c8372180 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1700,6 +1700,12 @@ bool ice_pf_state_is_nominal(struct ice_pf *pf)
 	return true;
 }
 
+#define ICE_FW_MODE_REC_M BIT(1)
+bool ice_is_recovery_mode(struct ice_hw *hw)
+{
+	return rd32(hw, GL_MNG_FWSM) & ICE_FW_MODE_REC_M;
+}
+
 /**
  * ice_update_eth_stats - Update VSI-specific ethernet statistics counters
  * @vsi: the VSI to be updated
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 10d6fc479a32..eabb35834a24 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -90,6 +90,7 @@ void ice_set_q_vector_intrl(struct ice_q_vector *q_vector);
 
 bool ice_is_safe_mode(struct ice_pf *pf);
 bool ice_is_rdma_ena(struct ice_pf *pf);
+bool ice_is_recovery_mode(struct ice_hw *hw);
 bool ice_is_dflt_vsi_in_use(struct ice_port_info *pi);
 bool ice_is_vsi_dflt_vsi(struct ice_vsi *vsi);
 int ice_set_dflt_vsi(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 749b5e29e83a..2205ea871209 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2364,6 +2364,18 @@ static void ice_check_media_subtask(struct ice_pf *pf)
 	}
 }
 
+static void ice_service_task_recovery_mode(struct work_struct *work)
+{
+	struct ice_pf *pf = container_of(work, struct ice_pf, serv_task);
+
+	set_bit(ICE_ADMINQ_EVENT_PENDING, pf->state);
+	ice_clean_adminq_subtask(pf);
+
+	ice_service_task_complete(pf);
+
+	mod_timer(&pf->serv_tmr, jiffies + msecs_to_jiffies(100));
+}
+
 /**
  * ice_service_task - manage and run subtasks
  * @work: pointer to work_struct contained by the PF struct
@@ -5217,6 +5229,36 @@ void ice_unload(struct ice_pf *pf)
 	ice_decfg_netdev(vsi);
 }
 
+static int ice_probe_recovery_mode(struct ice_pf *pf)
+{
+	struct device *dev = ice_pf_to_dev(pf);
+	int err;
+
+	dev_err(dev, "Firmware recovery mode detected. Limiting functionality. Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode\n");
+
+	INIT_HLIST_HEAD(&pf->aq_wait_list);
+	spin_lock_init(&pf->aq_wait_lock);
+	init_waitqueue_head(&pf->aq_wait_queue);
+
+	timer_setup(&pf->serv_tmr, ice_service_timer, 0);
+	pf->serv_tmr_period = HZ;
+	INIT_WORK(&pf->serv_task, ice_service_task_recovery_mode);
+	clear_bit(ICE_SERVICE_SCHED, pf->state);
+	err = ice_create_all_ctrlq(&pf->hw);
+	if (err)
+		return err;
+
+	scoped_guard(devl, priv_to_devlink(pf)) {
+		err = ice_init_devlink(pf);
+		if (err)
+			return err;
+	}
+
+	ice_service_task_restart(pf);
+
+	return 0;
+}
+
 /**
  * ice_probe - Device initialization routine
  * @pdev: PCI device information struct
@@ -5308,6 +5350,9 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		hw->debug_mask = debug;
 #endif
 
+	if (ice_is_recovery_mode(hw))
+		return ice_probe_recovery_mode(pf);
+
 	err = ice_init_hw(hw);
 	if (err) {
 		dev_err(dev, "ice_init_hw failed: %d\n", err);
@@ -5425,6 +5470,14 @@ static void ice_remove(struct pci_dev *pdev)
 		msleep(100);
 	}
 
+	if (ice_is_recovery_mode(&pf->hw)) {
+		ice_service_task_stop(pf);
+		scoped_guard(devl, priv_to_devlink(pf)) {
+			ice_deinit_devlink(pf);
+		}
+		return;
+	}
+
 	if (test_bit(ICE_FLAG_SRIOV_ENA, pf->flags)) {
 		set_bit(ICE_VF_RESETS_DISABLED, pf->state);
 		ice_free_vfs(pf);
-- 
2.47.1


