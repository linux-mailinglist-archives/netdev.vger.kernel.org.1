Return-Path: <netdev+bounces-272407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNToHTAxxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:26:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 161F93405E7
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07A4530C6227
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57073CC9EE;
	Fri, 27 Mar 2026 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWvEt/3a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8603CA4BD
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596235; cv=none; b=o3xW7mVVtQC5utdHVN9CYEuMS015czFG9L3XbSz6AF+uENmWJV/B8ZxBfOnUjs2nbPhR5Zu24uXpApibaJ8HRfFm8bLhMNeBqgbr3JTLnS/RMDtTkdKHONqxu4F6xr+wq2u3R6EVcXKxv8qLZOprFYG2o7CfSZ14lw6q//4nlgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596235; c=relaxed/simple;
	bh=wNHNslyd6MNc9Q8hzBtoAtv+43HUwDJhNoUcYjJZM1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujE+GHjXcJDs4DJ863ihF19ApdwLbBmo8raA4iDl/6UHaguLfiNgL9NluFj6nuVK8ifPpwhfofQAunLPllY7KsFTiDO/bjsLFB/Y0zGEq7XmKjxXgEcTpJY0CMrYMK2KBmAk9/+bHvqyNLVEquhC1+1Ect+xWAqGhSg5x9JwByk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWvEt/3a; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596230; x=1806132230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wNHNslyd6MNc9Q8hzBtoAtv+43HUwDJhNoUcYjJZM1E=;
  b=EWvEt/3aPnsTNNTkjFssn3i0/uflkUf44HVO2JU4yS/wFxjMBDMBPx6j
   ffxDEPpChImeKNc/0IxcUmvl2RvAv/n9UhdTI9rg2uecRWHn1ntQhtoyA
   Ap3keRq/UeGxh9UNlKQ9Xn3F/AlYvRfNVkzmbTm4xRpZkK2sKeNxqHwXU
   SHVfWpTWzcfdkz1YzdnET6RBAUqACV8EGX/mUtrYtIYIr3q0ud25gXHoY
   Ltlx2xQJFqaFmJchtAL+IFo4v6lB0XtL133qvmXx0XLVN1gTd5VyQvs3V
   pLRTmDOGKUho/EC5oL362bgc4DA12K1V373x/9B00Fv4gUxWa++zFcIG3
   w==;
X-CSE-ConnectionGUID: gkugHslBSZuQMUfRkZZvdw==
X-CSE-MsgGUID: OVVL906AQPKouZIbPvb4zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75733982"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75733982"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:23:46 -0700
X-CSE-ConnectionGUID: v97pXds9RCm8WRrwnK8Jng==
X-CSE-MsgGUID: b0mRNXA+TXm2iIcLWcp5Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255739116"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:23:45 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Dave Ertman <david.m.ertman@intel.com>
Subject: [PATCH net] ice: stop DCBNL requests during driver unload
Date: Fri, 27 Mar 2026 08:23:31 +0100
Message-ID: <20260327072332.130320-8-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272407-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 161F93405E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dave Ertman <david.m.ertman@intel.com>

With a chatty lldpad, DCB configuration requests can arrive through
the DCBNL API while the driver is tearing down PF resources, leading
to use-after-free and NULL dereference crashes.

Set ICE_SHUTTING_DOWN in pf->state at the start of ice_remove() and
check this bit at the beginning of every DCBNL callback that accesses
resources freed during the remove path.

Fixes: b94b013eb626 ("ice: Implement DCBNL support")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/ice.h        |  1 +
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 46 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c   |  1 +
 3 files changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 2b2b22a..052c310 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -283,6 +283,7 @@ enum ice_pf_state {
 	ICE_EMPR_RECV,		/* set by OICR handler */
 	ICE_SUSPENDED,		/* set on module remove path */
 	ICE_RESET_FAILED,		/* set by reset/rebuild */
+	ICE_SHUTTING_DOWN,		/* set on module remove path, before releasing resources */
 	/* When checking for the PF to be in a nominal operating state, the
 	 * bits that are grouped at the beginning of the list need to be
 	 * checked. Bits occurring before ICE_STATE_NOMINAL_CHECK_BITS will
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index a10c1c8d..4a30129 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -15,6 +15,8 @@ static void ice_dcbnl_devreset(struct net_device *netdev)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return;
 	while (ice_is_reset_in_progress(pf->state))
 		usleep_range(1000, 2000);
 
@@ -35,6 +37,8 @@ static int ice_dcbnl_getets(struct net_device *netdev, struct ieee_ets *ets)
 	struct ice_pf *pf;
 
 	pf = ice_netdev_to_pf(netdev);
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return -EBUSY;
 	dcbxcfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
 
 	ets->willing = dcbxcfg->etscfg.willing;
@@ -66,6 +70,8 @@ static int ice_dcbnl_setets(struct net_device *netdev, struct ieee_ets *ets)
 	int bwcfg = 0, bwrec = 0;
 	int err, i;
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return -EBUSY;
 	if ((pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) ||
 	    !(pf->dcbx_cap & DCB_CAP_DCBX_VER_IEEE))
 		return -EINVAL;
@@ -135,6 +141,8 @@ ice_dcbnl_getnumtcs(struct net_device *dev, int __always_unused tcid, u8 *num)
 
 	if (!test_bit(ICE_FLAG_DCB_CAPABLE, pf->flags))
 		return -EINVAL;
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return -EBUSY;
 
 	*num = pf->hw.func_caps.common_cap.maxtc;
 	return 0;
@@ -148,6 +156,8 @@ static u8 ice_dcbnl_getdcbx(struct net_device *netdev)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return 0;
 	return pf->dcbx_cap;
 }
 
@@ -161,6 +171,8 @@ static u8 ice_dcbnl_setdcbx(struct net_device *netdev, u8 mode)
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_qos_cfg *qos_cfg;
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return 0;
 	/* if FW LLDP agent is running, DCBNL not allowed to change mode */
 	if (test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags))
 		return ICE_DCB_NO_HW_CHG;
@@ -208,6 +220,8 @@ static void ice_dcbnl_get_perm_hw_addr(struct net_device *netdev, u8 *perm_addr)
 	struct ice_port_info *pi = pf->hw.port_info;
 	int i, j;
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return;
 	memset(perm_addr, 0xff, MAX_ADDR_LEN);
 
 	for (i = 0; i < netdev->addr_len; i++)
@@ -242,6 +256,8 @@ static int ice_dcbnl_getpfc(struct net_device *netdev, struct ieee_pfc *pfc)
 	struct ice_dcbx_cfg *dcbxcfg;
 	int i;
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return -EBUSY;
 	dcbxcfg = &pi->qos_cfg.local_dcbx_cfg;
 	pfc->pfc_cap = dcbxcfg->pfc.pfccap;
 	pfc->pfc_en = dcbxcfg->pfc.pfcena;
@@ -267,6 +283,8 @@ static int ice_dcbnl_setpfc(struct net_device *netdev, struct ieee_pfc *pfc)
 	struct ice_dcbx_cfg *new_cfg;
 	int err;
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return -EBUSY;
 	if ((pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) ||
 	    !(pf->dcbx_cap & DCB_CAP_DCBX_VER_IEEE))
 		return -EINVAL;
@@ -308,6 +326,8 @@ ice_dcbnl_get_pfc_cfg(struct net_device *netdev, int prio, u8 *setting)
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_port_info *pi = pf->hw.port_info;
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return;
 	if ((pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) ||
 	    !(pf->dcbx_cap & DCB_CAP_DCBX_VER_CEE))
 		return;
@@ -331,6 +351,8 @@ static void ice_dcbnl_set_pfc_cfg(struct net_device *netdev, int prio, u8 set)
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_dcbx_cfg *new_cfg;
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return;
 	if ((pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) ||
 	    !(pf->dcbx_cap & DCB_CAP_DCBX_VER_CEE))
 		return;
@@ -364,6 +386,8 @@ static u8 ice_dcbnl_getpfcstate(struct net_device *netdev)
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_port_info *pi = pf->hw.port_info;
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return 0;
 	/* Return enabled if any UP enabled for PFC */
 	if (pi->qos_cfg.local_dcbx_cfg.pfc.pfcena)
 		return 1;
@@ -395,6 +419,8 @@ static u8 ice_dcbnl_setstate(struct net_device *netdev, u8 state)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return ICE_DCB_NO_HW_CHG;
 	if ((pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) ||
 	    !(pf->dcbx_cap & DCB_CAP_DCBX_VER_CEE))
 		return ICE_DCB_NO_HW_CHG;
@@ -469,6 +495,8 @@ ice_dcbnl_set_pg_tc_cfg_tx(struct net_device *netdev, int tc,
 	struct ice_dcbx_cfg *new_cfg;
 	int i;
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return;
 	if ((pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) ||
 	    !(pf->dcbx_cap & DCB_CAP_DCBX_VER_CEE))
 		return;
@@ -504,6 +532,8 @@ ice_dcbnl_get_pg_bwg_cfg_tx(struct net_device *netdev, int pgid, u8 *bw_pct)
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_port_info *pi = pf->hw.port_info;
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return;
 	if ((pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) ||
 	    !(pf->dcbx_cap & DCB_CAP_DCBX_VER_CEE))
 		return;
@@ -528,6 +558,8 @@ ice_dcbnl_set_pg_bwg_cfg_tx(struct net_device *netdev, int pgid, u8 bw_pct)
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_dcbx_cfg *new_cfg;
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return;
 	if ((pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) ||
 	    !(pf->dcbx_cap & DCB_CAP_DCBX_VER_CEE))
 		return;
@@ -609,6 +641,8 @@ ice_dcbnl_get_pg_bwg_cfg_rx(struct net_device *netdev, int __always_unused pgid,
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return;
 	if ((pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) ||
 	    !(pf->dcbx_cap & DCB_CAP_DCBX_VER_CEE))
 		return;
@@ -643,6 +677,8 @@ static u8 ice_dcbnl_get_cap(struct net_device *netdev, int capid, u8 *cap)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return ICE_DCB_NO_HW_CHG;
 	if (!(test_bit(ICE_FLAG_DCB_CAPABLE, pf->flags)))
 		return ICE_DCB_NO_HW_CHG;
 
@@ -695,6 +731,8 @@ static int ice_dcbnl_getapp(struct net_device *netdev, u8 idtype, u16 id)
 				.protocol = id,
 			     };
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return -EBUSY;
 	if ((pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) ||
 	    !(pf->dcbx_cap & DCB_CAP_DCBX_VER_CEE))
 		return -EINVAL;
@@ -738,6 +776,8 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
 	u8 max_tc;
 	int ret;
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return -EBUSY;
 	/* ONLY DSCP APP TLVs have operational significance */
 	if (app->selector != IEEE_8021QAZ_APP_SEL_DSCP)
 		return -EINVAL;
@@ -871,6 +911,8 @@ static int ice_dcbnl_delapp(struct net_device *netdev, struct dcb_app *app)
 	unsigned int i, j;
 	int ret = 0;
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return -EBUSY;
 	if (pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) {
 		netdev_err(netdev, "can't delete DSCP netlink app when FW DCB agent is active\n");
 		return -EINVAL;
@@ -978,6 +1020,8 @@ static u8 ice_dcbnl_cee_set_all(struct net_device *netdev)
 	struct ice_dcbx_cfg *new_cfg;
 	int err;
 
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return ICE_DCB_NO_HW_CHG;
 	if ((pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) ||
 	    !(pf->dcbx_cap & DCB_CAP_DCBX_VER_CEE))
 		return ICE_DCB_NO_HW_CHG;
@@ -1048,6 +1092,8 @@ void ice_dcbnl_set_all(struct ice_vsi *vsi)
 		return;
 
 	pf = ice_netdev_to_pf(netdev);
+	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
+		return;
 	pi = pf->hw.port_info;
 
 	/* SW DCB taken care of by SW Default Config */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 685c9618..eff48bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5424,6 +5424,7 @@ static void ice_remove(struct pci_dev *pdev)
 	struct ice_pf *pf = pci_get_drvdata(pdev);
 	int i;
 
+	set_bit(ICE_SHUTTING_DOWN, pf->state);
 	for (i = 0; i < ICE_MAX_RESET_WAIT; i++) {
 		if (!ice_is_reset_in_progress(pf->state))
 			break;
-- 
2.52.0


