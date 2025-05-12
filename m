Return-Path: <netdev+bounces-189742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1E6AB3724
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B678622AC
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E90D2920A2;
	Mon, 12 May 2025 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oma+lmw9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD6813635E
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053323; cv=none; b=rJX/Whdloz5V6Znu9Ix/IsgHbqWhx2r4Z3aqqXuR71x9Spj+2buWnHWu4iRcLZ8r/l+9YRkVsj6C1PQfrLAPh0RSjShIS55XlG246sOeOC/F/ObBtOKrP6OKKj5TrsO+gFAAOBrZW6MYfkXil8MZow53ymGGvTdP4hPIZW58H2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053323; c=relaxed/simple;
	bh=vmSWxpGFDTrdWKUCaWo051UNIY/9ZBUNlmWHIEqIfSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pICjN2sX/YXZn1ymSu34lzmoUEfWLuTebegjXQNrY96BpERLN2X7M4W6+ngofgaOx8voPUIdR14iy5fV7RUVqBZq7gZ31VuteiMNFtX/vfJeusTrfuh+5nZ6rKSVE+rbQQpK8trJ/R+8i2xWACvUpvuKQlKVnp6U2h+f7IrGjXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oma+lmw9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747053322; x=1778589322;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vmSWxpGFDTrdWKUCaWo051UNIY/9ZBUNlmWHIEqIfSI=;
  b=Oma+lmw9nxRFTt5NmwiG1xiqdfcQ3M5KVhLNyTg9ZzDtfhhqw+1vUcOj
   DhyipQV5ozfrMKCfYfBx+YLT1Bpwj7VSjMLg1ay2K/RHGPG6ZujXKqme9
   jiy83biBa3Mw0RKvG9v4gFe0EAZ68nnWh+LDI2z3kwpqlvi7k1L9xb8bn
   69cXsUcKO+AF7HxyDC3IDCO/nFezCnz3f/Cu6sZch1HaB5pkfYin21o1y
   QJu5QNz5U7kAXsKWqpcl+VMwPSFOCEM7A9GjcaKU1KpWfrVgVc6lXBsUF
   3uk6sUGDGNeOX8ktQFrWDIl/arC2nUY0OMem/4lfCCvCO8vE5OT1AbGza
   w==;
X-CSE-ConnectionGUID: kE4nosoOT3iUMoDT6Q9Onw==
X-CSE-MsgGUID: 92FcDaGOR6yHBdfSRsGUUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48541789"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="48541789"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 05:35:20 -0700
X-CSE-ConnectionGUID: wKCL6bwGQ0W4IrP4Pwgbcw==
X-CSE-MsgGUID: WaLhORkWR0izdWHW1ZFg6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="138322794"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.155])
  by fmviesa009.fm.intel.com with ESMTP; 12 May 2025 05:35:17 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-next 1/2] ice: move two ice_ptp_* functions
Date: Mon, 12 May 2025 14:34:57 +0200
Message-ID: <20250512123509.1194023-3-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move ice_ptp_maybe_trigger_tx_interrupt() and ice_ptp_periodic_work().

This will allow to assign ice_ptp_periodic_work() to PTP API's
do_aux_work function pointer.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 132 +++++++++++------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 3278b96d8f01..0a1f6e0e4a22 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2530,6 +2530,72 @@ static void ice_ptp_set_funcs_e830(struct ice_pf *pf)
 	ice_ptp_setup_pin_cfg(pf);
 }
 
+/**
+ * ice_ptp_maybe_trigger_tx_interrupt - Trigger Tx timstamp interrupt
+ * @pf: Board private structure
+ *
+ * The device PHY issues Tx timestamp interrupts to the driver for processing
+ * timestamp data from the PHY. It will not interrupt again until all
+ * current timestamp data is read. In rare circumstances, it is possible that
+ * the driver fails to read all outstanding data.
+ *
+ * To avoid getting permanently stuck, periodically check if the PHY has
+ * outstanding timestamp data. If so, trigger an interrupt from software to
+ * process this data.
+ */
+static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
+{
+	struct device *dev = ice_pf_to_dev(pf);
+	struct ice_hw *hw = &pf->hw;
+	bool trigger_oicr = false;
+	unsigned int i;
+
+	if (!pf->ptp.port.tx.has_ready_bitmap)
+		return;
+
+	if (!ice_pf_src_tmr_owned(pf))
+		return;
+
+	for (i = 0; i < ICE_GET_QUAD_NUM(hw->ptp.num_lports); i++) {
+		u64 tstamp_ready;
+		int err;
+
+		err = ice_get_phy_tx_tstamp_ready(&pf->hw, i, &tstamp_ready);
+		if (!err && tstamp_ready) {
+			trigger_oicr = true;
+			break;
+		}
+	}
+
+	if (trigger_oicr) {
+		/* Trigger a software interrupt, to ensure this data
+		 * gets processed.
+		 */
+		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
+
+		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
+		ice_flush(hw);
+	}
+}
+
+static void ice_ptp_periodic_work(struct kthread_work *work)
+{
+	struct ice_ptp *ptp = container_of(work, struct ice_ptp, work.work);
+	struct ice_pf *pf = container_of(ptp, struct ice_pf, ptp);
+	int err;
+
+	if (pf->ptp.state != ICE_PTP_READY)
+		return;
+
+	err = ice_ptp_update_cached_phctime(pf);
+
+	ice_ptp_maybe_trigger_tx_interrupt(pf);
+
+	/* Run twice a second or reschedule if phc update failed */
+	kthread_queue_delayed_work(ptp->kworker, &ptp->work,
+				   msecs_to_jiffies(err ? 10 : 500));
+}
+
 /**
  * ice_ptp_set_caps - Set PTP capabilities
  * @pf: Board private structure
@@ -2739,72 +2805,6 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 	}
 }
 
-/**
- * ice_ptp_maybe_trigger_tx_interrupt - Trigger Tx timstamp interrupt
- * @pf: Board private structure
- *
- * The device PHY issues Tx timestamp interrupts to the driver for processing
- * timestamp data from the PHY. It will not interrupt again until all
- * current timestamp data is read. In rare circumstances, it is possible that
- * the driver fails to read all outstanding data.
- *
- * To avoid getting permanently stuck, periodically check if the PHY has
- * outstanding timestamp data. If so, trigger an interrupt from software to
- * process this data.
- */
-static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
-{
-	struct device *dev = ice_pf_to_dev(pf);
-	struct ice_hw *hw = &pf->hw;
-	bool trigger_oicr = false;
-	unsigned int i;
-
-	if (!pf->ptp.port.tx.has_ready_bitmap)
-		return;
-
-	if (!ice_pf_src_tmr_owned(pf))
-		return;
-
-	for (i = 0; i < ICE_GET_QUAD_NUM(hw->ptp.num_lports); i++) {
-		u64 tstamp_ready;
-		int err;
-
-		err = ice_get_phy_tx_tstamp_ready(&pf->hw, i, &tstamp_ready);
-		if (!err && tstamp_ready) {
-			trigger_oicr = true;
-			break;
-		}
-	}
-
-	if (trigger_oicr) {
-		/* Trigger a software interrupt, to ensure this data
-		 * gets processed.
-		 */
-		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
-
-		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
-		ice_flush(hw);
-	}
-}
-
-static void ice_ptp_periodic_work(struct kthread_work *work)
-{
-	struct ice_ptp *ptp = container_of(work, struct ice_ptp, work.work);
-	struct ice_pf *pf = container_of(ptp, struct ice_pf, ptp);
-	int err;
-
-	if (pf->ptp.state != ICE_PTP_READY)
-		return;
-
-	err = ice_ptp_update_cached_phctime(pf);
-
-	ice_ptp_maybe_trigger_tx_interrupt(pf);
-
-	/* Run twice a second or reschedule if phc update failed */
-	kthread_queue_delayed_work(ptp->kworker, &ptp->work,
-				   msecs_to_jiffies(err ? 10 : 500));
-}
-
 /**
  * ice_ptp_prepare_rebuild_sec - Prepare second NAC for PTP reset or rebuild
  * @pf: Board private structure

base-commit: b74ad830a99f47b47e3f8d98d7d78614edab6217
-- 
2.49.0


