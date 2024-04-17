Return-Path: <netdev+bounces-88813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BE38A896E
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C99B1C23169
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78EE171083;
	Wed, 17 Apr 2024 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIW1x6mR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12AE17106F
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373003; cv=none; b=m+VS5iBfkyAKSXAXyS7fbNYlrpzbIof5/v5F7ppgaFFmofNZuJrlbwAZTxOmNEY/e5BLcGbpz8W2yUwSuUTXk0cnDVucG1wP1OA14f9gLi6JE77BHRbhk37f6kfQOGl2AhN25e8TEU8+oVc3tEEqAjYSsof/d7D6TE6bIzH2nbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373003; c=relaxed/simple;
	bh=8G0AOzR4YLqIVIh/o9xogSBdb9A1bB3Ob+ben/O1WWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0tfFl01xmc7njd03yTXrAQpoN2fMNx7rI4o2twllRrGxaTNv1h1T+77e3xZqWXnHJQBX+uamQNBZki0MMfl/so8aAQFZWnWs1bBLS9WRxA0TtM8H+hq5IsfpF7QzS3pK0D2+Is3SK2GAzjomHefpkWlTeb9mHT/mfc1WQjuDhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIW1x6mR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713373002; x=1744909002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8G0AOzR4YLqIVIh/o9xogSBdb9A1bB3Ob+ben/O1WWM=;
  b=PIW1x6mRmAPzTCAmunUhkeXqEez57Ew4EjSkQxJLGlkvmY7STN0xZQVb
   Emo7osYo1SqC3Bgo3cblASiDgh0AzxELcAb5zmI1lieuGFAdHIEsL6w5C
   SiswB//UHCBy9LCTHsl9TkeHEhjAwDpoFY56Jrd37y4YPreJzEA8+H2BP
   dSiatlJ/ByorZ6sn8Q48+8lj3VWkIPbSkr7QaGWSmv3usPRhconE1hkej
   Nz0ldR1UIN9x7Kb9KBrTNxNnQJy9N3eZsglqu6ifdRtbsyptPJwqdRuQN
   AS9tP7g1UlGbSJ4EtnLodeSx83+F226cDkvA09FNPqP8tGmPjfXGBAGSt
   g==;
X-CSE-ConnectionGUID: yhTP0unnQ0ChGk8FR/UK7A==
X-CSE-MsgGUID: KpaENWjiSYGIxoyG42nO+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9047286"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9047286"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:56:40 -0700
X-CSE-ConnectionGUID: YkVc4TBKQfqcqE9NVLJwBQ==
X-CSE-MsgGUID: bmVThKN6QNOj8aeR2wmZ1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27257614"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 17 Apr 2024 09:56:39 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Liang-Min Wang <liang-min.wang@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 1/2] ice: Add automatic VF reset on Tx MDD events
Date: Wed, 17 Apr 2024 09:56:32 -0700
Message-ID: <20240417165634.2081793-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417165634.2081793-1-anthony.l.nguyen@intel.com>
References: <20240417165634.2081793-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c  | 57 +++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_sriov.c | 25 +++++++---
 drivers/net/ethernet/intel/ice/ice_sriov.h |  2 +
 3 files changed, 67 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9d751954782c..2b173638b877 100644
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


