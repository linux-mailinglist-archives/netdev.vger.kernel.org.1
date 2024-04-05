Return-Path: <netdev+bounces-85159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F74D899A53
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153CA284F67
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09DB16132A;
	Fri,  5 Apr 2024 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6VqqYD3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DFE15FCEC
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311645; cv=none; b=ryUTaRu+SQgK4UnXq3/eDvOlBV4DATCOWQxb/VailEvf4BrMRZeDgVEVIw8WBHKNARJdCHsphO5NKo4jyL5x+UnBvYn2AZTG2kuulT680C6kuUNxvbqp093Nmzf7ofdYMBcr3WC1su4iwq662+NHqKp9AqVGzoHijmr7dCtmhcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311645; c=relaxed/simple;
	bh=xADsJFgmB+pvKtpxAajrAsooXi+q2ifMLgq9FbzNqys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lb+inv8zy7p1gG9fNNNddpgVWzdey289i0LHuVVfStJaUQB62uFeVY6UbOfgNwqmfd0OqOp2CsObj9d65f8D30LT+S7jg/1DoQJBEsJlA5A5983R+1AcpAnMiY2mjERbwhYjQBYV1TNJ20r6H1wfkNKr0SXB22vhQypoLEBANYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6VqqYD3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712311644; x=1743847644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xADsJFgmB+pvKtpxAajrAsooXi+q2ifMLgq9FbzNqys=;
  b=B6VqqYD3h3AicELXCDm/+J1sP0ieK4UBCfKWmYLY0tyHJvtDqOsAS6Kg
   PXURAtLS0OFv9s4aBhzX12/OZ+hcaNaSMvbazYXnECLmBP6fqq847S3ie
   Jka8toORlJtqeZDSu7PyH3uts/pfr8Qoz8oO0O4lY0CwUaBPWELhlWu38
   fhsL7lWH7zAkCIev74+GG6LiuKAr+otBnPXSo+cZ2r6Pv7tfl4u+Y/qz0
   WuKfbahlgq/TpNDbHhw41BkD+I1YrMg4nCy9Kp3VOrDqk+pRvu+ukC4oB
   Rj9gCdZJk3DNFKcPqyd00VvpIIMz45oARo8Bk7oBkl7rlWmchjj0LIEZM
   w==;
X-CSE-ConnectionGUID: ORHmYfjuQl+8DgvpdD60Dg==
X-CSE-MsgGUID: xgOHdX57TPW1PaiXGuWX7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7494022"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7494022"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 03:07:23 -0700
X-CSE-ConnectionGUID: NJ9jCvBEQQS3IDw7n0dExQ==
X-CSE-MsgGUID: iXgt92KbQ/6eENobBYF4RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19536303"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa007.jf.intel.com with ESMTP; 05 Apr 2024 03:07:21 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v6 iwl-next 11/12] ice: Support 2XNAC configuration using auxbus
Date: Fri,  5 Apr 2024 11:57:23 +0200
Message-ID: <20240405100648.144756-25-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240405100648.144756-14-karol.kolacinski@intel.com>
References: <20240405100648.144756-14-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are E825C products featuring 2 NACs. Those have only one source
clock on the primary NAC.
For those devices, there
should be only one clock controller on the primary NAC. All PFs from
both NACs should connect as auxiliary devices to the auxiliary driver on
the primary NAC.

Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h        | 23 +++++++-
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 62 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 28 ++++++++--
 drivers/net/ethernet/intel/ice/ice_type.h   |  2 +
 4 files changed, 101 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 67a3236ab1fc..b8319851bef1 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -197,8 +197,6 @@
 
 #define ice_pf_to_dev(pf) (&((pf)->pdev->dev))
 
-#define ice_pf_src_tmr_owned(pf) ((pf)->hw.func_caps.ts_func_info.src_tmr_owned)
-
 enum ice_feature {
 	ICE_F_DSCP,
 	ICE_F_PHY_RCLK,
@@ -1010,4 +1008,25 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
 }
 
 extern const struct xdp_metadata_ops ice_xdp_md_ops;
+
+/**
+ * ice_pf_src_tmr_owned - check if PF is owner of source timer
+ * @pf: Board private structure
+ */
+static inline bool ice_pf_src_tmr_owned(struct ice_pf *pf)
+{
+	if (pf->hw.ptp.phy_model == ICE_PHY_ETH56G && !pf->hw.ptp.primary_nac)
+		return false;
+	else
+		return pf->hw.func_caps.ts_func_info.src_tmr_owned;
+}
+
+/**
+ * ice_is_primary - check if PF is on a primary NAC
+ * @pf: Board private structure
+ */
+static inline bool ice_is_primary(struct ice_pf *pf)
+{
+	return pf->hw.dev_caps.nac_topo.mode & ICE_NAC_TOPO_PRIMARY_M;
+}
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 105caf51261a..29a86fcfd312 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -371,6 +371,9 @@ ice_ptp_read_src_clk_reg(struct ice_pf *pf, struct ptp_system_timestamp *sts)
 	u32 hi, lo, lo2;
 	u8 tmr_idx;
 
+	if (!hw->ptp.primary_nac)
+		hw = hw->ptp.primary_hw;
+
 	tmr_idx = ice_get_ptp_src_clock_index(hw);
 	guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
 	/* Read the system timestamp pre PHC read */
@@ -2673,6 +2676,31 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 				   msecs_to_jiffies(err ? 10 : 500));
 }
 
+/**
+ * ice_ptp_prepare_rebuild_sec - Prepare second NAC for PTP reset or rebuild
+ * @pf: Board private structure
+ * @rebuild: rebuild if true, prepare if false
+ * @reset_type: the reset type being performed
+ */
+static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
+					enum ice_reset_req reset_type)
+{
+	struct ice_ptp_port *port;
+
+	mutex_lock(&pf->ptp.ports_owner.lock);
+	list_for_each_entry(port, &pf->ptp.ports_owner.ports, list_member) {
+		struct ice_pf *peer_pf = ptp_port_to_pf(port);
+
+		if (!peer_pf->hw.ptp.primary_nac) {
+			if (rebuild)
+				ice_ptp_rebuild(peer_pf, reset_type);
+			else
+				ice_ptp_prepare_for_reset(peer_pf, reset_type);
+		}
+	}
+	mutex_unlock(&pf->ptp.ports_owner.lock);
+}
+
 /**
  * ice_ptp_prepare_for_reset - Prepare PTP for reset
  * @pf: Board private structure
@@ -2681,6 +2709,7 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 {
 	struct ice_ptp *ptp = &pf->ptp;
+	struct ice_hw *hw = &pf->hw;
 	u8 src_tmr;
 
 	if (ptp->state != ICE_PTP_READY)
@@ -2696,15 +2725,18 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (reset_type == ICE_RESET_PFR)
 		return;
 
+	if (ice_pf_src_tmr_owned(pf) && ice_is_e825c(hw))
+		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
+
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
 	/* Disable periodic outputs */
 	ice_ptp_disable_all_clkout(pf);
 
-	src_tmr = ice_get_ptp_src_clock_index(&pf->hw);
+	src_tmr = ice_get_ptp_src_clock_index(hw);
 
 	/* Disable source clock */
-	wr32(&pf->hw, GLTSYN_ENA(src_tmr), (u32)~GLTSYN_ENA_TSYN_ENA_M);
+	wr32(hw, GLTSYN_ENA(src_tmr), (u32)~GLTSYN_ENA_TSYN_ENA_M);
 
 	/* Acquire PHC and system timer to restore after reset */
 	ptp->reset_time = ktime_get_real_ns();
@@ -2800,6 +2832,9 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		err = ice_ptp_rebuild_owner(pf);
 		if (err)
 			goto err;
+
+		if (ice_is_e825c(&pf->hw))
+			ice_ptp_prepare_rebuild_sec(pf, true, reset_type);
 	}
 
 	ptp->state = ICE_PTP_READY;
@@ -2872,6 +2907,9 @@ static int ice_ptp_auxbus_probe(struct auxiliary_device *aux_dev,
 		 &owner_pf->ptp.ports_owner.ports);
 	mutex_unlock(&owner_pf->ptp.ports_owner.lock);
 
+	if (!aux_pf->hw.ptp.primary_nac)
+		aux_pf->hw.ptp.primary_hw = &owner_pf->hw;
+
 	return 0;
 }
 
@@ -2949,6 +2987,7 @@ static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
 {
 	struct auxiliary_driver *aux_driver;
 	struct ice_ptp *ptp;
+	char busdev[8] = {};
 	struct device *dev;
 	char *name;
 	int err;
@@ -2958,8 +2997,10 @@ static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
 	aux_driver = &ptp->ports_owner.aux_driver;
 	INIT_LIST_HEAD(&ptp->ports_owner.ports);
 	mutex_init(&ptp->ports_owner.lock);
-	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
-			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
+	if (ice_is_e810(&pf->hw))
+		sprintf(busdev, "%u_%u_", pf->pdev->bus->number,
+			PCI_SLOT(pf->pdev->devfn));
+	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_%sclk%u", busdev,
 			      ice_get_ptp_src_clock_index(&pf->hw));
 	if (!name)
 		return -ENOMEM;
@@ -3163,6 +3204,7 @@ static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
 {
 	struct auxiliary_device *aux_dev;
 	struct ice_ptp *ptp;
+	char busdev[8] = {};
 	struct device *dev;
 	char *name;
 	int err;
@@ -3174,8 +3216,11 @@ static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
 
 	aux_dev = &ptp->port.aux_dev;
 
-	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
-			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
+	if (ice_is_e810(&pf->hw))
+		sprintf(busdev, "%u_%u_", pf->pdev->bus->number,
+			PCI_SLOT(pf->pdev->devfn));
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_%sclk%u", busdev,
 			      ice_get_ptp_src_clock_index(&pf->hw));
 	if (!name)
 		return -ENOMEM;
@@ -3263,6 +3308,11 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	ptp->state = ICE_PTP_INITIALIZING;
 
+	if (ice_is_e825c(hw) && !ice_is_primary(pf))
+		hw->ptp.primary_nac = false;
+	else
+		hw->ptp.primary_nac = true;
+
 	ice_ptp_init_hw(hw);
 
 	ice_ptp_init_tx_interrupt_mode(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 0e0771fa04cd..f1f65171212e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -835,7 +835,10 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 {
 	u32 cmd_val = ice_ptp_tmr_cmd_to_src_reg(hw, cmd);
 
-	wr32(hw, GLTSYN_CMD, cmd_val);
+	if (hw->ptp.primary_nac)
+		wr32(hw, GLTSYN_CMD, cmd_val);
+	else
+		wr32(hw->ptp.primary_hw, GLTSYN_CMD, cmd_val);
 }
 
 /**
@@ -851,7 +854,10 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 
 	guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
-	wr32(hw, GLTSYN_CMD_SYNC, SYNC_EXEC_CMD);
+	if (hw->ptp.primary_nac)
+		wr32(hw, GLTSYN_CMD_SYNC, SYNC_EXEC_CMD);
+	else
+		wr32(hw->ptp.primary_hw, GLTSYN_CMD_SYNC, SYNC_EXEC_CMD);
 	ice_flush(hw);
 }
 
@@ -2169,8 +2175,13 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 	ice_ptp_exec_tmr_cmd(hw);
 
 	/* Read the captured PHC time from the shadow time registers */
-	zo = rd32(hw, GLTSYN_SHTIME_0(tmr_idx));
-	lo = rd32(hw, GLTSYN_SHTIME_L(tmr_idx));
+	if (hw->ptp.primary_nac) {
+		zo = rd32(hw, GLTSYN_SHTIME_0(tmr_idx));
+		lo = rd32(hw, GLTSYN_SHTIME_L(tmr_idx));
+	} else {
+		zo = rd32(hw->ptp.primary_hw, GLTSYN_SHTIME_0(tmr_idx));
+		lo = rd32(hw->ptp.primary_hw, GLTSYN_SHTIME_L(tmr_idx));
+	}
 	*phc_time = (u64)lo << 32 | zo;
 
 	/* Read the captured PHY time from the PHY shadow registers */
@@ -2320,8 +2331,13 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
-	lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
-	hi = rd32(hw, GLTSYN_INCVAL_H(tmr_idx));
+	if (hw->ptp.primary_nac) {
+		lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
+		hi = rd32(hw, GLTSYN_INCVAL_H(tmr_idx));
+	} else {
+		lo = rd32(hw->ptp.primary_hw, GLTSYN_INCVAL_L(tmr_idx));
+		hi = rd32(hw->ptp.primary_hw, GLTSYN_INCVAL_H(tmr_idx));
+	}
 	incval = (u64)hi << 32 | lo;
 
 	err = ice_write_40b_ptp_reg_eth56g(hw, port, PHY_REG_TIMETUS_L, incval);
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 948c4bdbb206..e019dad56819 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -856,6 +856,8 @@ struct ice_ptp_hw {
 	union ice_phy_params phy;
 	u8 num_lports;
 	u8 ports_per_phy;
+	bool primary_nac;
+	struct ice_hw *primary_hw;
 };
 
 /* Port hardware description */
-- 
2.43.0


