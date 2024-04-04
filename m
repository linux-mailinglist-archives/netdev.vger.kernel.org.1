Return-Path: <netdev+bounces-84900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37089898977
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC745284008
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADC112880F;
	Thu,  4 Apr 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gak1jCun"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597CC1272BB
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239402; cv=none; b=N0ypBdl1iA00BSbfzo2QFgZidb+02n+Q7uQQnYFk7hOlwbSIrcQHraYRdUxG9VHQuoJ5TblMHUGSPnA9PUyWrtiElwDFJmfs4Zo2WtuaVTHZlMf97X14hzaNEoY+zGY6xap/9UItyB6Y+tfVOaFGNqZ8mX67evLuTFtflj6kA1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239402; c=relaxed/simple;
	bh=SljF2kBzyoZaZWPEsfGk9rAcXzLcG3u0RlGpIJ7vzTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byrsWnoLV9P55GDynEiqci/wlciZoJm+U+86nibBvfehK+aWfQ7LmS2E6lZ2MYrMlrjszHZYcB3b2T3iXMEH7D1o1VcDx+OWK9e3MjguH7jRrS9Y8CUe1kNCGzhZZZwjTZRi2XkgbbuM6ZbNzsmGQn7vs1XNHVeTQcQx0LbbmQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gak1jCun; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712239401; x=1743775401;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SljF2kBzyoZaZWPEsfGk9rAcXzLcG3u0RlGpIJ7vzTs=;
  b=gak1jCunMjA9c5BEMAqJ6l/KPrV16HCtPp9yYGeXYzQ/QIPXmpGKsnKr
   ChIIZ3avKLzjVP0Ew0JjlIYR36/xNmtSpwBsBTOhIMsJ2nrqUn+tz4FPB
   ftpSucKvzPAaRgouWbIPuTsozT4/zX3JiLCmDNEa323W4KyAWvaTOFBHm
   Ipl5ycy0lJ7z/blL0HUW3e0MrzkZRfsIAOv+Kuz8LNHhL/QJtXitvGJIj
   Di8T2EJRCinhSheJV/OilhGV4cV3U6CS5wrNKfqO2eTrOnaXKy/z9Dffp
   fXVqwfWhabiwrDdVf2Y4l4YT2Mr/DlE9m8oWXAUzhDpi2j3EOq4ppZe75
   A==;
X-CSE-ConnectionGUID: /f2tecE6Ro2r4NHklwln+w==
X-CSE-MsgGUID: P2LQ2NllSmC//EeteGzBKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18089634"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18089634"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:03:21 -0700
X-CSE-ConnectionGUID: RBJpi9RvQCu4LQTE3D2uaA==
X-CSE-MsgGUID: QHC3lwVFQ8W5PzcwbJYtyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="49759097"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 04 Apr 2024 07:03:18 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 144E637F7F;
	Thu,  4 Apr 2024 15:03:16 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	mschmidt@redhat.com,
	anthony.l.nguyen@intel.com,
	pawel.chmielewski@intel.com,
	horms@kernel.org,
	aleksandr.loktionov@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Liang-Min Wang <liang-min.wang@intel.com>
Subject: [PATCH iwl-next v5] ice: Add automatic VF reset on Tx MDD events
Date: Thu,  4 Apr 2024 16:04:51 +0200
Message-ID: <20240404140451.504359-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cases when VF sends malformed packets that are classified as malicious,
it can cause Tx queue to freeze as a result of Malicious Driver Detection
event. Such malformed packets can appear as a result of a faulty userspace
app running on VF. This frozen queue can be stuck for several minutes being
unusable.

User might prefer to immediately bring the VF back to operational state
after such event, which can be done by automatically resetting the VF which
caused MDD. This is already implemented for Rx events (mdd-auto-reset-vf
flag private flag needs to be set).

Extend the VF auto reset to also cover Tx MDD events. When any MDD event
occurs on VF (Tx or Rx) and the mdd-auto-reset-vf private flag is set,
perform a graceful VF reset to quickly bring it back to operational state.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Co-developed-by: Liang-Min Wang <liang-min.wang@intel.com>
Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v5: Reword title and commit message to be more explicit and informative
v4 [4]: Only perform auto-reset once per VF
v3 [3]: Only auto reset VF if the mdd-auto-reset-vf flag is set
v2 [2]: Revert an unneeded formatting change, fix commit message, fix a log
        message with a correct event name

[4] https://lore.kernel.org/intel-wired-lan/20240402165221.11669-1-marcin.szycik@linux.intel.com
[3] https://lore.kernel.org/intel-wired-lan/20240326164455.735739-1-marcin.szycik@linux.intel.com
[2] https://lore.kernel.org/netdev/20231102155149.2574209-1-pawel.chmielewski@intel.com
---
 drivers/net/ethernet/intel/ice/ice_main.c  | 57 +++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_sriov.c | 25 +++++++---
 drivers/net/ethernet/intel/ice/ice_sriov.h |  2 +
 3 files changed, 67 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 185c9b13efcf..80bc83f6e1ab 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1745,6 +1745,39 @@ static void ice_service_timer(struct timer_list *t)
 	ice_service_task_schedule(pf);
 }
 
+/**
+ * ice_mdd_maybe_reset_vf - reset VF after MDD event
+ * @pf: pointer to the PF structure
+ * @vf: pointer to the VF structure
+ * @reset_vf_tx: whether Tx MDD has occurred
+ * @reset_vf_rx: whether Rx MDD has occurred
+ *
+ * Since the queue can get stuck on VF MDD events, the PF can be configured to
+ * automatically reset the VF by enabling the private ethtool flag
+ * mdd-auto-reset-vf.
+ */
+static void ice_mdd_maybe_reset_vf(struct ice_pf *pf, struct ice_vf *vf,
+				   bool reset_vf_tx, bool reset_vf_rx)
+{
+	struct device *dev = ice_pf_to_dev(pf);
+
+	if (!test_bit(ICE_FLAG_MDD_AUTO_RESET_VF, pf->flags))
+		return;
+
+	/* VF MDD event counters will be cleared by reset, so print the event
+	 * prior to reset.
+	 */
+	if (reset_vf_tx)
+		ice_print_vf_tx_mdd_event(vf);
+
+	if (reset_vf_rx)
+		ice_print_vf_rx_mdd_event(vf);
+
+	dev_info(dev, "PF-to-VF reset on PF %d VF %d due to MDD event\n",
+		 pf->hw.pf_id, vf->vf_id);
+	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY | ICE_VF_RESET_LOCK);
+}
+
 /**
  * ice_handle_mdd_event - handle malicious driver detect event
  * @pf: pointer to the PF structure
@@ -1838,6 +1871,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 	 */
 	mutex_lock(&pf->vfs.table_lock);
 	ice_for_each_vf(pf, bkt, vf) {
+		bool reset_vf_tx = false, reset_vf_rx = false;
+
 		reg = rd32(hw, VP_MDET_TX_PQM(vf->vf_id));
 		if (reg & VP_MDET_TX_PQM_VALID_M) {
 			wr32(hw, VP_MDET_TX_PQM(vf->vf_id), 0xFFFF);
@@ -1846,6 +1881,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 			if (netif_msg_tx_err(pf))
 				dev_info(dev, "Malicious Driver Detection event TX_PQM detected on VF %d\n",
 					 vf->vf_id);
+
+			reset_vf_tx = true;
 		}
 
 		reg = rd32(hw, VP_MDET_TX_TCLAN(vf->vf_id));
@@ -1856,6 +1893,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 			if (netif_msg_tx_err(pf))
 				dev_info(dev, "Malicious Driver Detection event TX_TCLAN detected on VF %d\n",
 					 vf->vf_id);
+
+			reset_vf_tx = true;
 		}
 
 		reg = rd32(hw, VP_MDET_TX_TDPU(vf->vf_id));
@@ -1866,6 +1905,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 			if (netif_msg_tx_err(pf))
 				dev_info(dev, "Malicious Driver Detection event TX_TDPU detected on VF %d\n",
 					 vf->vf_id);
+
+			reset_vf_tx = true;
 		}
 
 		reg = rd32(hw, VP_MDET_RX(vf->vf_id));
@@ -1877,18 +1918,12 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 				dev_info(dev, "Malicious Driver Detection event RX detected on VF %d\n",
 					 vf->vf_id);
 
-			/* Since the queue is disabled on VF Rx MDD events, the
-			 * PF can be configured to reset the VF through ethtool
-			 * private flag mdd-auto-reset-vf.
-			 */
-			if (test_bit(ICE_FLAG_MDD_AUTO_RESET_VF, pf->flags)) {
-				/* VF MDD event counters will be cleared by
-				 * reset, so print the event prior to reset.
-				 */
-				ice_print_vf_rx_mdd_event(vf);
-				ice_reset_vf(vf, ICE_VF_RESET_LOCK);
-			}
+			reset_vf_rx = true;
 		}
+
+		if (reset_vf_tx || reset_vf_rx)
+			ice_mdd_maybe_reset_vf(pf, vf, reset_vf_tx,
+					       reset_vf_rx);
 	}
 	mutex_unlock(&pf->vfs.table_lock);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index fb2e96db647e..a60dacf8942a 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1861,6 +1861,24 @@ void ice_print_vf_rx_mdd_event(struct ice_vf *vf)
 			  ? "on" : "off");
 }
 
+/**
+ * ice_print_vf_tx_mdd_event - print VF Tx malicious driver detect event
+ * @vf: pointer to the VF structure
+ */
+void ice_print_vf_tx_mdd_event(struct ice_vf *vf)
+{
+	struct ice_pf *pf = vf->pf;
+	struct device *dev;
+
+	dev = ice_pf_to_dev(pf);
+
+	dev_info(dev, "%d Tx Malicious Driver Detection events detected on PF %d VF %d MAC %pM. mdd-auto-reset-vfs=%s\n",
+		 vf->mdd_tx_events.count, pf->hw.pf_id, vf->vf_id,
+		 vf->dev_lan_addr,
+		 test_bit(ICE_FLAG_MDD_AUTO_RESET_VF, pf->flags)
+			  ? "on" : "off");
+}
+
 /**
  * ice_print_vfs_mdd_events - print VFs malicious driver detect event
  * @pf: pointer to the PF structure
@@ -1869,8 +1887,6 @@ void ice_print_vf_rx_mdd_event(struct ice_vf *vf)
  */
 void ice_print_vfs_mdd_events(struct ice_pf *pf)
 {
-	struct device *dev = ice_pf_to_dev(pf);
-	struct ice_hw *hw = &pf->hw;
 	struct ice_vf *vf;
 	unsigned int bkt;
 
@@ -1897,10 +1913,7 @@ void ice_print_vfs_mdd_events(struct ice_pf *pf)
 		if (vf->mdd_tx_events.count != vf->mdd_tx_events.last_printed) {
 			vf->mdd_tx_events.last_printed =
 							vf->mdd_tx_events.count;
-
-			dev_info(dev, "%d Tx Malicious Driver Detection events detected on PF %d VF %d MAC %pM.\n",
-				 vf->mdd_tx_events.count, hw->pf_id, vf->vf_id,
-				 vf->dev_lan_addr);
+			ice_print_vf_tx_mdd_event(vf);
 		}
 	}
 	mutex_unlock(&pf->vfs.table_lock);
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
index 4ba8fb53aea1..8f22313474d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
@@ -58,6 +58,7 @@ void
 ice_vf_lan_overflow_event(struct ice_pf *pf, struct ice_rq_event_info *event);
 void ice_print_vfs_mdd_events(struct ice_pf *pf);
 void ice_print_vf_rx_mdd_event(struct ice_vf *vf);
+void ice_print_vf_tx_mdd_event(struct ice_vf *vf);
 bool
 ice_vc_validate_pattern(struct ice_vf *vf, struct virtchnl_proto_hdrs *proto);
 u32 ice_sriov_get_vf_total_msix(struct pci_dev *pdev);
@@ -69,6 +70,7 @@ static inline
 void ice_vf_lan_overflow_event(struct ice_pf *pf, struct ice_rq_event_info *event) { }
 static inline void ice_print_vfs_mdd_events(struct ice_pf *pf) { }
 static inline void ice_print_vf_rx_mdd_event(struct ice_vf *vf) { }
+static inline void ice_print_vf_tx_mdd_event(struct ice_vf *vf) { }
 static inline void ice_restore_all_vfs_msi_state(struct ice_pf *pf) { }
 
 static inline int
-- 
2.41.0


