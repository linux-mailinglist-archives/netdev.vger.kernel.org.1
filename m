Return-Path: <netdev+bounces-83792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFF189444F
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 19:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC9F1F2116B
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE9452F70;
	Mon,  1 Apr 2024 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDWgvNJ2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2184D9E7
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992275; cv=none; b=oFu2beD/+5cn0nsmLTAkMJr47Ujws50/2Atp6H3sLChpZcWPwarwadOUC4C6EnqFs+uaBekcw0XA3diYWAwmBLhuN6oJqhC3viB6Dw7eREt1IeIN7U5ubRDXBTQ247m6zG13Ez7tkcHVZJHssFLtlhjsC4QZTe/nWB4mlyzN+xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992275; c=relaxed/simple;
	bh=aKmxAS7vrCGA7ubp3Fzlz9b8Nj/OCb63h40KyPjKM6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqL7Ol5/l/O2gVKzQglOTsOwEag+aDTrBfn9+oIwzYAleBwYvKvP0IKr/0AHNYuCqWwTxncEAGsQMfyIiU6T3TRC3UGIdknWH2MleUNqPNQY/a9Y8/MDCyqfHHNriemjs2evvu40JRoKCs3OEFt54kim8QkDtnG142zWOQwAYyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDWgvNJ2; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711992273; x=1743528273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aKmxAS7vrCGA7ubp3Fzlz9b8Nj/OCb63h40KyPjKM6o=;
  b=cDWgvNJ202oq9yAhDRtXCF6qdC0PCGJ/YIcKmAGHUwSSt22NqyrkXAKh
   cWuEY4hh1MnX/cI0TK4UVdx74vIYArkNCAr1UsaSAHSTm5Swka3CYpviK
   nelaa8GbE5DVrIA37pa0U0jX2rDMEsgx/4ejb2gzylPVF1K5lVXS+9gOe
   +sIYkCANgdmf3ytZVZbU78HG/+rmVecQWQ+z0eOPO5+9JTFcj1aGZ3Mb7
   5OnHbVOPzeqUgSQaoXnq8TN4LDdiWn8S0R0WjU9TOcfbG7VdmL2SSZkDp
   8qRgRaSCwlCMRwqvxw7FwfYv9lt5ndKi15BoCBKV7IWLmmh6mMgstzMPL
   w==;
X-CSE-ConnectionGUID: ovO/OQ1qRi6HoGKTkrCnOw==
X-CSE-MsgGUID: GL/xOJ0rSr2zSMmTaBvMUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="29606180"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="29606180"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:24:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="55235100"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 01 Apr 2024 10:24:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Piotr Raczynski <piotr.raczynski@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 7/8] ice: move devlink port code to a separate file
Date: Mon,  1 Apr 2024 10:24:17 -0700
Message-ID: <20240401172421.1401696-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
References: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Raczynski <piotr.raczynski@intel.com>

Keep devlink related code in a separate file. More devlink port code and
handlers will be added here for other port operations.

Remove no longer needed include of our devlink.h in ice_lib.c.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 .../net/ethernet/intel/ice/devlink/devlink.c  | 423 -----------------
 .../ethernet/intel/ice/devlink/devlink_port.c | 430 ++++++++++++++++++
 .../ethernet/intel/ice/devlink/devlink_port.h |  12 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   1 -
 drivers/net/ethernet/intel/ice/ice_main.c     |   1 +
 drivers/net/ethernet/intel/ice/ice_repr.c     |   1 +
 7 files changed, 445 insertions(+), 424 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_port.c
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_port.h

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 736b1cae2033..03500e28ac99 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -30,6 +30,7 @@ ice-y := ice_main.o	\
 	 ice_flow.o	\
 	 ice_idc.o	\
 	 devlink/devlink.o	\
+	 devlink/devlink_port.o \
 	 ice_ddp.o	\
 	 ice_fw_update.o \
 	 ice_lag.o	\
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 82983eab52e0..926a14ac0d6f 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -10,8 +10,6 @@
 #include "ice_fw_update.h"
 #include "ice_dcb_lib.h"
 
-static int ice_active_port_option = -1;
-
 /* context for devlink info version reporting */
 struct ice_info_ctx {
 	char buf[128];
@@ -525,251 +523,6 @@ ice_devlink_reload_empr_finish(struct ice_pf *pf,
 	return 0;
 }
 
-/**
- * ice_devlink_port_opt_speed_str - convert speed to a string
- * @speed: speed value
- */
-static const char *ice_devlink_port_opt_speed_str(u8 speed)
-{
-	switch (speed & ICE_AQC_PORT_OPT_MAX_LANE_M) {
-	case ICE_AQC_PORT_OPT_MAX_LANE_100M:
-		return "0.1";
-	case ICE_AQC_PORT_OPT_MAX_LANE_1G:
-		return "1";
-	case ICE_AQC_PORT_OPT_MAX_LANE_2500M:
-		return "2.5";
-	case ICE_AQC_PORT_OPT_MAX_LANE_5G:
-		return "5";
-	case ICE_AQC_PORT_OPT_MAX_LANE_10G:
-		return "10";
-	case ICE_AQC_PORT_OPT_MAX_LANE_25G:
-		return "25";
-	case ICE_AQC_PORT_OPT_MAX_LANE_50G:
-		return "50";
-	case ICE_AQC_PORT_OPT_MAX_LANE_100G:
-		return "100";
-	}
-
-	return "-";
-}
-
-#define ICE_PORT_OPT_DESC_LEN	50
-/**
- * ice_devlink_port_options_print - Print available port split options
- * @pf: the PF to print split port options
- *
- * Prints a table with available port split options and max port speeds
- */
-static void ice_devlink_port_options_print(struct ice_pf *pf)
-{
-	u8 i, j, options_count, cnt, speed, pending_idx, active_idx;
-	struct ice_aqc_get_port_options_elem *options, *opt;
-	struct device *dev = ice_pf_to_dev(pf);
-	bool active_valid, pending_valid;
-	char desc[ICE_PORT_OPT_DESC_LEN];
-	const char *str;
-	int status;
-
-	options = kcalloc(ICE_AQC_PORT_OPT_MAX * ICE_MAX_PORT_PER_PCI_DEV,
-			  sizeof(*options), GFP_KERNEL);
-	if (!options)
-		return;
-
-	for (i = 0; i < ICE_MAX_PORT_PER_PCI_DEV; i++) {
-		opt = options + i * ICE_AQC_PORT_OPT_MAX;
-		options_count = ICE_AQC_PORT_OPT_MAX;
-		active_valid = 0;
-
-		status = ice_aq_get_port_options(&pf->hw, opt, &options_count,
-						 i, true, &active_idx,
-						 &active_valid, &pending_idx,
-						 &pending_valid);
-		if (status) {
-			dev_dbg(dev, "Couldn't read port option for port %d, err %d\n",
-				i, status);
-			goto err;
-		}
-	}
-
-	dev_dbg(dev, "Available port split options and max port speeds (Gbps):\n");
-	dev_dbg(dev, "Status  Split      Quad 0          Quad 1\n");
-	dev_dbg(dev, "        count  L0  L1  L2  L3  L4  L5  L6  L7\n");
-
-	for (i = 0; i < options_count; i++) {
-		cnt = 0;
-
-		if (i == ice_active_port_option)
-			str = "Active";
-		else if ((i == pending_idx) && pending_valid)
-			str = "Pending";
-		else
-			str = "";
-
-		cnt += snprintf(&desc[cnt], ICE_PORT_OPT_DESC_LEN - cnt,
-				"%-8s", str);
-
-		cnt += snprintf(&desc[cnt], ICE_PORT_OPT_DESC_LEN - cnt,
-				"%-6u", options[i].pmd);
-
-		for (j = 0; j < ICE_MAX_PORT_PER_PCI_DEV; ++j) {
-			speed = options[i + j * ICE_AQC_PORT_OPT_MAX].max_lane_speed;
-			str = ice_devlink_port_opt_speed_str(speed);
-			cnt += snprintf(&desc[cnt], ICE_PORT_OPT_DESC_LEN - cnt,
-					"%3s ", str);
-		}
-
-		dev_dbg(dev, "%s\n", desc);
-	}
-
-err:
-	kfree(options);
-}
-
-/**
- * ice_devlink_aq_set_port_option - Send set port option admin queue command
- * @pf: the PF to print split port options
- * @option_idx: selected port option
- * @extack: extended netdev ack structure
- *
- * Sends set port option admin queue command with selected port option and
- * calls NVM write activate.
- */
-static int
-ice_devlink_aq_set_port_option(struct ice_pf *pf, u8 option_idx,
-			       struct netlink_ext_ack *extack)
-{
-	struct device *dev = ice_pf_to_dev(pf);
-	int status;
-
-	status = ice_aq_set_port_option(&pf->hw, 0, true, option_idx);
-	if (status) {
-		dev_dbg(dev, "ice_aq_set_port_option, err %d aq_err %d\n",
-			status, pf->hw.adminq.sq_last_status);
-		NL_SET_ERR_MSG_MOD(extack, "Port split request failed");
-		return -EIO;
-	}
-
-	status = ice_acquire_nvm(&pf->hw, ICE_RES_WRITE);
-	if (status) {
-		dev_dbg(dev, "ice_acquire_nvm failed, err %d aq_err %d\n",
-			status, pf->hw.adminq.sq_last_status);
-		NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM semaphore");
-		return -EIO;
-	}
-
-	status = ice_nvm_write_activate(&pf->hw, ICE_AQC_NVM_ACTIV_REQ_EMPR, NULL);
-	if (status) {
-		dev_dbg(dev, "ice_nvm_write_activate failed, err %d aq_err %d\n",
-			status, pf->hw.adminq.sq_last_status);
-		NL_SET_ERR_MSG_MOD(extack, "Port split request failed to save data");
-		ice_release_nvm(&pf->hw);
-		return -EIO;
-	}
-
-	ice_release_nvm(&pf->hw);
-
-	NL_SET_ERR_MSG_MOD(extack, "Reboot required to finish port split");
-	return 0;
-}
-
-/**
- * ice_devlink_port_split - .port_split devlink handler
- * @devlink: devlink instance structure
- * @port: devlink port structure
- * @count: number of ports to split to
- * @extack: extended netdev ack structure
- *
- * Callback for the devlink .port_split operation.
- *
- * Unfortunately, the devlink expression of available options is limited
- * to just a number, so search for an FW port option which supports
- * the specified number. As there could be multiple FW port options with
- * the same port split count, allow switching between them. When the same
- * port split count request is issued again, switch to the next FW port
- * option with the same port split count.
- *
- * Return: zero on success or an error code on failure.
- */
-static int
-ice_devlink_port_split(struct devlink *devlink, struct devlink_port *port,
-		       unsigned int count, struct netlink_ext_ack *extack)
-{
-	struct ice_aqc_get_port_options_elem options[ICE_AQC_PORT_OPT_MAX];
-	u8 i, j, active_idx, pending_idx, new_option;
-	struct ice_pf *pf = devlink_priv(devlink);
-	u8 option_count = ICE_AQC_PORT_OPT_MAX;
-	struct device *dev = ice_pf_to_dev(pf);
-	bool active_valid, pending_valid;
-	int status;
-
-	status = ice_aq_get_port_options(&pf->hw, options, &option_count,
-					 0, true, &active_idx, &active_valid,
-					 &pending_idx, &pending_valid);
-	if (status) {
-		dev_dbg(dev, "Couldn't read port split options, err = %d\n",
-			status);
-		NL_SET_ERR_MSG_MOD(extack, "Failed to get available port split options");
-		return -EIO;
-	}
-
-	new_option = ICE_AQC_PORT_OPT_MAX;
-	active_idx = pending_valid ? pending_idx : active_idx;
-	for (i = 1; i <= option_count; i++) {
-		/* In order to allow switching between FW port options with
-		 * the same port split count, search for a new option starting
-		 * from the active/pending option (with array wrap around).
-		 */
-		j = (active_idx + i) % option_count;
-
-		if (count == options[j].pmd) {
-			new_option = j;
-			break;
-		}
-	}
-
-	if (new_option == active_idx) {
-		dev_dbg(dev, "request to split: count: %u is already set and there are no other options\n",
-			count);
-		NL_SET_ERR_MSG_MOD(extack, "Requested split count is already set");
-		ice_devlink_port_options_print(pf);
-		return -EINVAL;
-	}
-
-	if (new_option == ICE_AQC_PORT_OPT_MAX) {
-		dev_dbg(dev, "request to split: count: %u not found\n", count);
-		NL_SET_ERR_MSG_MOD(extack, "Port split requested unsupported port config");
-		ice_devlink_port_options_print(pf);
-		return -EINVAL;
-	}
-
-	status = ice_devlink_aq_set_port_option(pf, new_option, extack);
-	if (status)
-		return status;
-
-	ice_devlink_port_options_print(pf);
-
-	return 0;
-}
-
-/**
- * ice_devlink_port_unsplit - .port_unsplit devlink handler
- * @devlink: devlink instance structure
- * @port: devlink port structure
- * @extack: extended netdev ack structure
- *
- * Callback for the devlink .port_unsplit operation.
- * Calls ice_devlink_port_split with split count set to 1.
- * There could be no FW option available with split count 1.
- *
- * Return: zero on success or an error code on failure.
- */
-static int
-ice_devlink_port_unsplit(struct devlink *devlink, struct devlink_port *port,
-			 struct netlink_ext_ack *extack)
-{
-	return ice_devlink_port_split(devlink, port, 1, extack);
-}
-
 /**
  * ice_tear_down_devlink_rate_tree - removes devlink-rate exported tree
  * @pf: pf struct
@@ -1548,23 +1301,6 @@ void ice_devlink_unregister(struct ice_pf *pf)
 	devlink_unregister(priv_to_devlink(pf));
 }
 
-/**
- * ice_devlink_set_switch_id - Set unique switch id based on pci dsn
- * @pf: the PF to create a devlink port for
- * @ppid: struct with switch id information
- */
-static void
-ice_devlink_set_switch_id(struct ice_pf *pf, struct netdev_phys_item_id *ppid)
-{
-	struct pci_dev *pdev = pf->pdev;
-	u64 id;
-
-	id = pci_get_dsn(pdev);
-
-	ppid->id_len = sizeof(id);
-	put_unaligned_be64(id, &ppid->id);
-}
-
 int ice_devlink_register_params(struct ice_pf *pf)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
@@ -1579,165 +1315,6 @@ void ice_devlink_unregister_params(struct ice_pf *pf)
 				  ARRAY_SIZE(ice_devlink_params));
 }
 
-/**
- * ice_devlink_set_port_split_options - Set port split options
- * @pf: the PF to set port split options
- * @attrs: devlink attributes
- *
- * Sets devlink port split options based on available FW port options
- */
-static void
-ice_devlink_set_port_split_options(struct ice_pf *pf,
-				   struct devlink_port_attrs *attrs)
-{
-	struct ice_aqc_get_port_options_elem options[ICE_AQC_PORT_OPT_MAX];
-	u8 i, active_idx, pending_idx, option_count = ICE_AQC_PORT_OPT_MAX;
-	bool active_valid, pending_valid;
-	int status;
-
-	status = ice_aq_get_port_options(&pf->hw, options, &option_count,
-					 0, true, &active_idx, &active_valid,
-					 &pending_idx, &pending_valid);
-	if (status) {
-		dev_dbg(ice_pf_to_dev(pf), "Couldn't read port split options, err = %d\n",
-			status);
-		return;
-	}
-
-	/* find the biggest available port split count */
-	for (i = 0; i < option_count; i++)
-		attrs->lanes = max_t(int, attrs->lanes, options[i].pmd);
-
-	attrs->splittable = attrs->lanes ? 1 : 0;
-	ice_active_port_option = active_idx;
-}
-
-static const struct devlink_port_ops ice_devlink_port_ops = {
-	.port_split = ice_devlink_port_split,
-	.port_unsplit = ice_devlink_port_unsplit,
-};
-
-/**
- * ice_devlink_create_pf_port - Create a devlink port for this PF
- * @pf: the PF to create a devlink port for
- *
- * Create and register a devlink_port for this PF.
- * This function has to be called under devl_lock.
- *
- * Return: zero on success or an error code on failure.
- */
-int ice_devlink_create_pf_port(struct ice_pf *pf)
-{
-	struct devlink_port_attrs attrs = {};
-	struct devlink_port *devlink_port;
-	struct devlink *devlink;
-	struct ice_vsi *vsi;
-	struct device *dev;
-	int err;
-
-	devlink = priv_to_devlink(pf);
-
-	dev = ice_pf_to_dev(pf);
-
-	devlink_port = &pf->devlink_port;
-
-	vsi = ice_get_main_vsi(pf);
-	if (!vsi)
-		return -EIO;
-
-	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
-	attrs.phys.port_number = pf->hw.bus.func;
-
-	/* As FW supports only port split options for whole device,
-	 * set port split options only for first PF.
-	 */
-	if (pf->hw.pf_id == 0)
-		ice_devlink_set_port_split_options(pf, &attrs);
-
-	ice_devlink_set_switch_id(pf, &attrs.switch_id);
-
-	devlink_port_attrs_set(devlink_port, &attrs);
-
-	err = devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
-					  &ice_devlink_port_ops);
-	if (err) {
-		dev_err(dev, "Failed to create devlink port for PF %d, error %d\n",
-			pf->hw.pf_id, err);
-		return err;
-	}
-
-	return 0;
-}
-
-/**
- * ice_devlink_destroy_pf_port - Destroy the devlink_port for this PF
- * @pf: the PF to cleanup
- *
- * Unregisters the devlink_port structure associated with this PF.
- * This function has to be called under devl_lock.
- */
-void ice_devlink_destroy_pf_port(struct ice_pf *pf)
-{
-	devl_port_unregister(&pf->devlink_port);
-}
-
-/**
- * ice_devlink_create_vf_port - Create a devlink port for this VF
- * @vf: the VF to create a port for
- *
- * Create and register a devlink_port for this VF.
- *
- * Return: zero on success or an error code on failure.
- */
-int ice_devlink_create_vf_port(struct ice_vf *vf)
-{
-	struct devlink_port_attrs attrs = {};
-	struct devlink_port *devlink_port;
-	struct devlink *devlink;
-	struct ice_vsi *vsi;
-	struct device *dev;
-	struct ice_pf *pf;
-	int err;
-
-	pf = vf->pf;
-	dev = ice_pf_to_dev(pf);
-	devlink_port = &vf->devlink_port;
-
-	vsi = ice_get_vf_vsi(vf);
-	if (!vsi)
-		return -EINVAL;
-
-	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
-	attrs.pci_vf.pf = pf->hw.bus.func;
-	attrs.pci_vf.vf = vf->vf_id;
-
-	ice_devlink_set_switch_id(pf, &attrs.switch_id);
-
-	devlink_port_attrs_set(devlink_port, &attrs);
-	devlink = priv_to_devlink(pf);
-
-	err = devlink_port_register(devlink, devlink_port, vsi->idx);
-	if (err) {
-		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
-			vf->vf_id, err);
-		return err;
-	}
-
-	return 0;
-}
-
-/**
- * ice_devlink_destroy_vf_port - Destroy the devlink_port for this VF
- * @vf: the VF to cleanup
- *
- * Unregisters the devlink_port structure associated with this VF.
- */
-void ice_devlink_destroy_vf_port(struct ice_vf *vf)
-{
-	devl_rate_leaf_destroy(&vf->devlink_port);
-	devlink_port_unregister(&vf->devlink_port);
-}
-
 #define ICE_DEVLINK_READ_BLK_SIZE (1024 * 1024)
 
 static const struct devlink_region_ops ice_nvm_region_ops;
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
new file mode 100644
index 000000000000..13e6790d3cae
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Intel Corporation. */
+
+#include <linux/vmalloc.h>
+
+#include "ice.h"
+#include "devlink.h"
+
+static int ice_active_port_option = -1;
+
+/**
+ * ice_devlink_port_opt_speed_str - convert speed to a string
+ * @speed: speed value
+ */
+static const char *ice_devlink_port_opt_speed_str(u8 speed)
+{
+	switch (speed & ICE_AQC_PORT_OPT_MAX_LANE_M) {
+	case ICE_AQC_PORT_OPT_MAX_LANE_100M:
+		return "0.1";
+	case ICE_AQC_PORT_OPT_MAX_LANE_1G:
+		return "1";
+	case ICE_AQC_PORT_OPT_MAX_LANE_2500M:
+		return "2.5";
+	case ICE_AQC_PORT_OPT_MAX_LANE_5G:
+		return "5";
+	case ICE_AQC_PORT_OPT_MAX_LANE_10G:
+		return "10";
+	case ICE_AQC_PORT_OPT_MAX_LANE_25G:
+		return "25";
+	case ICE_AQC_PORT_OPT_MAX_LANE_50G:
+		return "50";
+	case ICE_AQC_PORT_OPT_MAX_LANE_100G:
+		return "100";
+	}
+
+	return "-";
+}
+
+#define ICE_PORT_OPT_DESC_LEN	50
+/**
+ * ice_devlink_port_options_print - Print available port split options
+ * @pf: the PF to print split port options
+ *
+ * Prints a table with available port split options and max port speeds
+ */
+static void ice_devlink_port_options_print(struct ice_pf *pf)
+{
+	u8 i, j, options_count, cnt, speed, pending_idx, active_idx;
+	struct ice_aqc_get_port_options_elem *options, *opt;
+	struct device *dev = ice_pf_to_dev(pf);
+	bool active_valid, pending_valid;
+	char desc[ICE_PORT_OPT_DESC_LEN];
+	const char *str;
+	int status;
+
+	options = kcalloc(ICE_AQC_PORT_OPT_MAX * ICE_MAX_PORT_PER_PCI_DEV,
+			  sizeof(*options), GFP_KERNEL);
+	if (!options)
+		return;
+
+	for (i = 0; i < ICE_MAX_PORT_PER_PCI_DEV; i++) {
+		opt = options + i * ICE_AQC_PORT_OPT_MAX;
+		options_count = ICE_AQC_PORT_OPT_MAX;
+		active_valid = 0;
+
+		status = ice_aq_get_port_options(&pf->hw, opt, &options_count,
+						 i, true, &active_idx,
+						 &active_valid, &pending_idx,
+						 &pending_valid);
+		if (status) {
+			dev_dbg(dev, "Couldn't read port option for port %d, err %d\n",
+				i, status);
+			goto err;
+		}
+	}
+
+	dev_dbg(dev, "Available port split options and max port speeds (Gbps):\n");
+	dev_dbg(dev, "Status  Split      Quad 0          Quad 1\n");
+	dev_dbg(dev, "        count  L0  L1  L2  L3  L4  L5  L6  L7\n");
+
+	for (i = 0; i < options_count; i++) {
+		cnt = 0;
+
+		if (i == ice_active_port_option)
+			str = "Active";
+		else if ((i == pending_idx) && pending_valid)
+			str = "Pending";
+		else
+			str = "";
+
+		cnt += snprintf(&desc[cnt], ICE_PORT_OPT_DESC_LEN - cnt,
+				"%-8s", str);
+
+		cnt += snprintf(&desc[cnt], ICE_PORT_OPT_DESC_LEN - cnt,
+				"%-6u", options[i].pmd);
+
+		for (j = 0; j < ICE_MAX_PORT_PER_PCI_DEV; ++j) {
+			speed = options[i + j * ICE_AQC_PORT_OPT_MAX].max_lane_speed;
+			str = ice_devlink_port_opt_speed_str(speed);
+			cnt += snprintf(&desc[cnt], ICE_PORT_OPT_DESC_LEN - cnt,
+					"%3s ", str);
+		}
+
+		dev_dbg(dev, "%s\n", desc);
+	}
+
+err:
+	kfree(options);
+}
+
+/**
+ * ice_devlink_aq_set_port_option - Send set port option admin queue command
+ * @pf: the PF to print split port options
+ * @option_idx: selected port option
+ * @extack: extended netdev ack structure
+ *
+ * Sends set port option admin queue command with selected port option and
+ * calls NVM write activate.
+ */
+static int
+ice_devlink_aq_set_port_option(struct ice_pf *pf, u8 option_idx,
+			       struct netlink_ext_ack *extack)
+{
+	struct device *dev = ice_pf_to_dev(pf);
+	int status;
+
+	status = ice_aq_set_port_option(&pf->hw, 0, true, option_idx);
+	if (status) {
+		dev_dbg(dev, "ice_aq_set_port_option, err %d aq_err %d\n",
+			status, pf->hw.adminq.sq_last_status);
+		NL_SET_ERR_MSG_MOD(extack, "Port split request failed");
+		return -EIO;
+	}
+
+	status = ice_acquire_nvm(&pf->hw, ICE_RES_WRITE);
+	if (status) {
+		dev_dbg(dev, "ice_acquire_nvm failed, err %d aq_err %d\n",
+			status, pf->hw.adminq.sq_last_status);
+		NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM semaphore");
+		return -EIO;
+	}
+
+	status = ice_nvm_write_activate(&pf->hw, ICE_AQC_NVM_ACTIV_REQ_EMPR, NULL);
+	if (status) {
+		dev_dbg(dev, "ice_nvm_write_activate failed, err %d aq_err %d\n",
+			status, pf->hw.adminq.sq_last_status);
+		NL_SET_ERR_MSG_MOD(extack, "Port split request failed to save data");
+		ice_release_nvm(&pf->hw);
+		return -EIO;
+	}
+
+	ice_release_nvm(&pf->hw);
+
+	NL_SET_ERR_MSG_MOD(extack, "Reboot required to finish port split");
+	return 0;
+}
+
+/**
+ * ice_devlink_port_split - .port_split devlink handler
+ * @devlink: devlink instance structure
+ * @port: devlink port structure
+ * @count: number of ports to split to
+ * @extack: extended netdev ack structure
+ *
+ * Callback for the devlink .port_split operation.
+ *
+ * Unfortunately, the devlink expression of available options is limited
+ * to just a number, so search for an FW port option which supports
+ * the specified number. As there could be multiple FW port options with
+ * the same port split count, allow switching between them. When the same
+ * port split count request is issued again, switch to the next FW port
+ * option with the same port split count.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+static int
+ice_devlink_port_split(struct devlink *devlink, struct devlink_port *port,
+		       unsigned int count, struct netlink_ext_ack *extack)
+{
+	struct ice_aqc_get_port_options_elem options[ICE_AQC_PORT_OPT_MAX];
+	u8 i, j, active_idx, pending_idx, new_option;
+	struct ice_pf *pf = devlink_priv(devlink);
+	u8 option_count = ICE_AQC_PORT_OPT_MAX;
+	struct device *dev = ice_pf_to_dev(pf);
+	bool active_valid, pending_valid;
+	int status;
+
+	status = ice_aq_get_port_options(&pf->hw, options, &option_count,
+					 0, true, &active_idx, &active_valid,
+					 &pending_idx, &pending_valid);
+	if (status) {
+		dev_dbg(dev, "Couldn't read port split options, err = %d\n",
+			status);
+		NL_SET_ERR_MSG_MOD(extack, "Failed to get available port split options");
+		return -EIO;
+	}
+
+	new_option = ICE_AQC_PORT_OPT_MAX;
+	active_idx = pending_valid ? pending_idx : active_idx;
+	for (i = 1; i <= option_count; i++) {
+		/* In order to allow switching between FW port options with
+		 * the same port split count, search for a new option starting
+		 * from the active/pending option (with array wrap around).
+		 */
+		j = (active_idx + i) % option_count;
+
+		if (count == options[j].pmd) {
+			new_option = j;
+			break;
+		}
+	}
+
+	if (new_option == active_idx) {
+		dev_dbg(dev, "request to split: count: %u is already set and there are no other options\n",
+			count);
+		NL_SET_ERR_MSG_MOD(extack, "Requested split count is already set");
+		ice_devlink_port_options_print(pf);
+		return -EINVAL;
+	}
+
+	if (new_option == ICE_AQC_PORT_OPT_MAX) {
+		dev_dbg(dev, "request to split: count: %u not found\n", count);
+		NL_SET_ERR_MSG_MOD(extack, "Port split requested unsupported port config");
+		ice_devlink_port_options_print(pf);
+		return -EINVAL;
+	}
+
+	status = ice_devlink_aq_set_port_option(pf, new_option, extack);
+	if (status)
+		return status;
+
+	ice_devlink_port_options_print(pf);
+
+	return 0;
+}
+
+/**
+ * ice_devlink_port_unsplit - .port_unsplit devlink handler
+ * @devlink: devlink instance structure
+ * @port: devlink port structure
+ * @extack: extended netdev ack structure
+ *
+ * Callback for the devlink .port_unsplit operation.
+ * Calls ice_devlink_port_split with split count set to 1.
+ * There could be no FW option available with split count 1.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+static int
+ice_devlink_port_unsplit(struct devlink *devlink, struct devlink_port *port,
+			 struct netlink_ext_ack *extack)
+{
+	return ice_devlink_port_split(devlink, port, 1, extack);
+}
+
+/**
+ * ice_devlink_set_port_split_options - Set port split options
+ * @pf: the PF to set port split options
+ * @attrs: devlink attributes
+ *
+ * Sets devlink port split options based on available FW port options
+ */
+static void
+ice_devlink_set_port_split_options(struct ice_pf *pf,
+				   struct devlink_port_attrs *attrs)
+{
+	struct ice_aqc_get_port_options_elem options[ICE_AQC_PORT_OPT_MAX];
+	u8 i, active_idx, pending_idx, option_count = ICE_AQC_PORT_OPT_MAX;
+	bool active_valid, pending_valid;
+	int status;
+
+	status = ice_aq_get_port_options(&pf->hw, options, &option_count,
+					 0, true, &active_idx, &active_valid,
+					 &pending_idx, &pending_valid);
+	if (status) {
+		dev_dbg(ice_pf_to_dev(pf), "Couldn't read port split options, err = %d\n",
+			status);
+		return;
+	}
+
+	/* find the biggest available port split count */
+	for (i = 0; i < option_count; i++)
+		attrs->lanes = max_t(int, attrs->lanes, options[i].pmd);
+
+	attrs->splittable = attrs->lanes ? 1 : 0;
+	ice_active_port_option = active_idx;
+}
+
+static const struct devlink_port_ops ice_devlink_port_ops = {
+	.port_split = ice_devlink_port_split,
+	.port_unsplit = ice_devlink_port_unsplit,
+};
+
+/**
+ * ice_devlink_set_switch_id - Set unique switch id based on pci dsn
+ * @pf: the PF to create a devlink port for
+ * @ppid: struct with switch id information
+ */
+static void
+ice_devlink_set_switch_id(struct ice_pf *pf, struct netdev_phys_item_id *ppid)
+{
+	struct pci_dev *pdev = pf->pdev;
+	u64 id;
+
+	id = pci_get_dsn(pdev);
+
+	ppid->id_len = sizeof(id);
+	put_unaligned_be64(id, &ppid->id);
+}
+
+/**
+ * ice_devlink_create_pf_port - Create a devlink port for this PF
+ * @pf: the PF to create a devlink port for
+ *
+ * Create and register a devlink_port for this PF.
+ * This function has to be called under devl_lock.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int ice_devlink_create_pf_port(struct ice_pf *pf)
+{
+	struct devlink_port_attrs attrs = {};
+	struct devlink_port *devlink_port;
+	struct devlink *devlink;
+	struct ice_vsi *vsi;
+	struct device *dev;
+	int err;
+
+	devlink = priv_to_devlink(pf);
+
+	dev = ice_pf_to_dev(pf);
+
+	devlink_port = &pf->devlink_port;
+
+	vsi = ice_get_main_vsi(pf);
+	if (!vsi)
+		return -EIO;
+
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
+	attrs.phys.port_number = pf->hw.bus.func;
+
+	/* As FW supports only port split options for whole device,
+	 * set port split options only for first PF.
+	 */
+	if (pf->hw.pf_id == 0)
+		ice_devlink_set_port_split_options(pf, &attrs);
+
+	ice_devlink_set_switch_id(pf, &attrs.switch_id);
+
+	devlink_port_attrs_set(devlink_port, &attrs);
+
+	err = devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
+					  &ice_devlink_port_ops);
+	if (err) {
+		dev_err(dev, "Failed to create devlink port for PF %d, error %d\n",
+			pf->hw.pf_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * ice_devlink_destroy_pf_port - Destroy the devlink_port for this PF
+ * @pf: the PF to cleanup
+ *
+ * Unregisters the devlink_port structure associated with this PF.
+ * This function has to be called under devl_lock.
+ */
+void ice_devlink_destroy_pf_port(struct ice_pf *pf)
+{
+	devl_port_unregister(&pf->devlink_port);
+}
+
+/**
+ * ice_devlink_create_vf_port - Create a devlink port for this VF
+ * @vf: the VF to create a port for
+ *
+ * Create and register a devlink_port for this VF.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int ice_devlink_create_vf_port(struct ice_vf *vf)
+{
+	struct devlink_port_attrs attrs = {};
+	struct devlink_port *devlink_port;
+	struct devlink *devlink;
+	struct ice_vsi *vsi;
+	struct device *dev;
+	struct ice_pf *pf;
+	int err;
+
+	pf = vf->pf;
+	dev = ice_pf_to_dev(pf);
+	devlink_port = &vf->devlink_port;
+
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		return -EINVAL;
+
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
+	attrs.pci_vf.pf = pf->hw.bus.func;
+	attrs.pci_vf.vf = vf->vf_id;
+
+	ice_devlink_set_switch_id(pf, &attrs.switch_id);
+
+	devlink_port_attrs_set(devlink_port, &attrs);
+	devlink = priv_to_devlink(pf);
+
+	err = devlink_port_register(devlink, devlink_port, vsi->idx);
+	if (err) {
+		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
+			vf->vf_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * ice_devlink_destroy_vf_port - Destroy the devlink_port for this VF
+ * @vf: the VF to cleanup
+ *
+ * Unregisters the devlink_port structure associated with this VF.
+ */
+void ice_devlink_destroy_vf_port(struct ice_vf *vf)
+{
+	devl_rate_leaf_destroy(&vf->devlink_port);
+	devlink_port_unregister(&vf->devlink_port);
+}
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
new file mode 100644
index 000000000000..9223bcdb6444
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024, Intel Corporation. */
+
+#ifndef _DEVLINK_PORT_H_
+#define _DEVLINK_PORT_H_
+
+int ice_devlink_create_pf_port(struct ice_pf *pf);
+void ice_devlink_destroy_pf_port(struct ice_pf *pf);
+int ice_devlink_create_vf_port(struct ice_vf *vf);
+void ice_devlink_destroy_vf_port(struct ice_vf *vf);
+
+#endif /* _DEVLINK_PORT_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 66eeaf345032..d06e7c82c433 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -7,7 +7,6 @@
 #include "ice_lib.h"
 #include "ice_fltr.h"
 #include "ice_dcb_lib.h"
-#include "devlink/devlink.h"
 #include "ice_vsi_vlan_ops.h"
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index eba1c18ea52e..1784382fe1ff 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -14,6 +14,7 @@
 #include "ice_dcb_lib.h"
 #include "ice_dcb_nl.h"
 #include "devlink/devlink.h"
+#include "devlink/devlink_port.h"
 #include "ice_hwmon.h"
 /* Including ice_trace.h with CREATE_TRACE_POINTS defined will generate the
  * ice tracepoint functions. This must be done exactly once across the
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 3b4ecbf0aa8e..b8009a301e39 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -4,6 +4,7 @@
 #include "ice.h"
 #include "ice_eswitch.h"
 #include "devlink/devlink.h"
+#include "devlink/devlink_port.h"
 #include "ice_sriov.h"
 #include "ice_tc_lib.h"
 #include "ice_dcb_lib.h"
-- 
2.41.0


