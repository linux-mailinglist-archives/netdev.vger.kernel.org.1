Return-Path: <netdev+bounces-205949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC79B00E0E
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C634E7352
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BF7293C7E;
	Thu, 10 Jul 2025 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nncuk1zU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0B129008F
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183931; cv=none; b=LYSbGxM18df/+oRwauZvid7I57gbzM8ArJmS7e6gKj0BOhFmtJpbLc8N6RJ8iBU6xaw7Au/mFR67WRf4P+sJhtxPLk1PvR3JXGAclFfqEIwxMfhesSr0rNECGCokyYNHx6pt4WSQFhQqE5vIRLPKzdiUQpKnnFaE/ApgTq53u28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183931; c=relaxed/simple;
	bh=rXcABTbaGaryer10VBbN64sUyww6zPo8asu698F4Z2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpABtlezToV4SUl0ihTxgl5nTkBmgx7i7RQXh7+iMVeAVIxlGutopWMc3/aM8bNOD3Km2j+3Shvb4T2wsa2R6oeLxbwUd25rzPD6b8YU2V7lN/I8ILVZM+IRdkohnImdRJuQYrcYAbYMBG+elp69hRtKWjgCZoL+vLsa+ifjhwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nncuk1zU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752183930; x=1783719930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rXcABTbaGaryer10VBbN64sUyww6zPo8asu698F4Z2g=;
  b=nncuk1zUAb/5G1GCBkId0yK9xtfts6JBqJkbQzoB8R2uOQJiknCZHE5c
   USXSHlSlN0BZgtaFC9UrRSE6omcmZEs9bTANRDD8A0FwpGwqR5CVIqTt2
   S/3Ww8CNRbVyfqfUNYagaLr+v7MSnLddCGoINPufVYc0DCMwOmXMXwVo8
   dnR2g/lvCO5wGXMCmmR0RW//Y1xUnG61GbSZt5NuxCOFuXCsQcSrHsdF+
   7TrPOvjPwFpRXm4+eSJlQad2Cthd1TGpX0UnjDRJPbl/2igjxa7R9mtC1
   GxioDjzIT3kgrMJ9EJSJEyx3pz8LKUBotFjlG7h+hSj/2LN8lztLMtmhk
   g==;
X-CSE-ConnectionGUID: y0hlDFaMRUWGgQjolmfMBQ==
X-CSE-MsgGUID: AUKq985iSI272acnn8fOdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54192373"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54192373"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 14:45:28 -0700
X-CSE-ConnectionGUID: WgZQdM4vS7SYSTHWz3F8sw==
X-CSE-MsgGUID: nKQ73p0WQWmZAaN9Bkv5bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="161764951"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 10 Jul 2025 14:45:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	madhu.chittim@intel.com,
	yahui.cao@intel.com,
	przemyslaw.kitszel@intel.com
Subject: [PATCH net-next 5/8] ice: expose VF functions used by live migration
Date: Thu, 10 Jul 2025 14:45:14 -0700
Message-ID: <20250710214518.1824208-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250710214518.1824208-1-anthony.l.nguyen@intel.com>
References: <20250710214518.1824208-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The live migration process will require configuring the target VF with the
data provided from the source host. A few helper functions in ice_sriov.c
and ice_virtchnl.c will be needed for this process, but are currently
static.

Expose these functions in their respective headers so that the live
migration module can use them during the migration process.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.h    |  7 +++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 13 ++++++-------
 drivers/net/ethernet/intel/ice/ice_virtchnl.h | 19 +++++++++++++++++++
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
index 96549ca5c52c..d1a998a4bef6 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
@@ -64,6 +64,7 @@ bool
 ice_vc_validate_pattern(struct ice_vf *vf, struct virtchnl_proto_hdrs *proto);
 u32 ice_sriov_get_vf_total_msix(struct pci_dev *pdev);
 int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count);
+int ice_vf_vsi_dis_single_txq(struct ice_vf *vf, struct ice_vsi *vsi, u16 q_id);
 #else /* CONFIG_PCI_IOV */
 static inline void ice_process_vflr_event(struct ice_pf *pf) { }
 static inline void ice_free_vfs(struct ice_pf *pf) { }
@@ -164,5 +165,11 @@ ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int ice_vf_vsi_dis_single_txq(struct ice_vf *vf,
+					    struct ice_vsi *vsi, u16 q_id)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_PCI_IOV */
 #endif /* _ICE_SRIOV_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 307252500f02..9460b6561b69 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1427,7 +1427,7 @@ static bool ice_vc_validate_vqs_bitmaps(struct virtchnl_queue_select *vqs)
  * @vsi: VSI of the VF to configure
  * @q_idx: VF queue index used to determine the queue in the PF's space
  */
-static void ice_vf_ena_txq_interrupt(struct ice_vsi *vsi, u32 q_idx)
+void ice_vf_ena_txq_interrupt(struct ice_vsi *vsi, u32 q_idx)
 {
 	struct ice_hw *hw = &vsi->back->hw;
 	u32 pfq = vsi->txq_map[q_idx];
@@ -1450,7 +1450,7 @@ static void ice_vf_ena_txq_interrupt(struct ice_vsi *vsi, u32 q_idx)
  * @vsi: VSI of the VF to configure
  * @q_idx: VF queue index used to determine the queue in the PF's space
  */
-static void ice_vf_ena_rxq_interrupt(struct ice_vsi *vsi, u32 q_idx)
+void ice_vf_ena_rxq_interrupt(struct ice_vsi *vsi, u32 q_idx)
 {
 	struct ice_hw *hw = &vsi->back->hw;
 	u32 pfq = vsi->rxq_map[q_idx];
@@ -1566,8 +1566,7 @@ static int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
  * disabled then clear q_id bit in the enabled queues bitmap and return
  * success. Otherwise return error.
  */
-static int
-ice_vf_vsi_dis_single_txq(struct ice_vf *vf, struct ice_vsi *vsi, u16 q_id)
+int ice_vf_vsi_dis_single_txq(struct ice_vf *vf, struct ice_vsi *vsi, u16 q_id)
 {
 	struct ice_txq_meta txq_meta = { 0 };
 	struct ice_tx_ring *ring;
@@ -2621,7 +2620,7 @@ static bool ice_vf_vlan_offload_ena(u32 caps)
  * ice_is_vlan_promisc_allowed - check if VLAN promiscuous config is allowed
  * @vf: VF used to determine if VLAN promiscuous config is allowed
  */
-static bool ice_is_vlan_promisc_allowed(struct ice_vf *vf)
+bool ice_is_vlan_promisc_allowed(struct ice_vf *vf)
 {
 	if ((test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states) ||
 	     test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states)) &&
@@ -2640,8 +2639,8 @@ static bool ice_is_vlan_promisc_allowed(struct ice_vf *vf)
  * This function should only be called if VLAN promiscuous mode is allowed,
  * which can be determined via ice_is_vlan_promisc_allowed().
  */
-static int ice_vf_ena_vlan_promisc(struct ice_vf *vf, struct ice_vsi *vsi,
-				   struct ice_vlan *vlan)
+int ice_vf_ena_vlan_promisc(struct ice_vf *vf, struct ice_vsi *vsi,
+			    struct ice_vlan *vlan)
 {
 	u8 promisc_m = 0;
 	int status;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.h b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
index b3eece8c6780..71bb456e2d71 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
@@ -92,12 +92,31 @@ ice_vc_send_msg_to_vf(struct ice_vf *vf, u32 v_opcode,
 bool ice_vc_isvalid_vsi_id(struct ice_vf *vf, u16 vsi_id);
 void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event,
 			   struct ice_mbx_data *mbxdata);
+void ice_vf_ena_rxq_interrupt(struct ice_vsi *vsi, u32 q_idx);
+void ice_vf_ena_txq_interrupt(struct ice_vsi *vsi, u32 q_idx);
+int ice_vf_ena_vlan_promisc(struct ice_vf *vf, struct ice_vsi *vsi,
+			    struct ice_vlan *vlan);
+bool ice_is_vlan_promisc_allowed(struct ice_vf *vf);
 #else /* CONFIG_PCI_IOV */
 static inline void ice_virtchnl_set_dflt_ops(struct ice_vf *vf) { }
 static inline void ice_virtchnl_set_repr_ops(struct ice_vf *vf) { }
 static inline void ice_vc_notify_vf_link_state(struct ice_vf *vf) { }
 static inline void ice_vc_notify_link_state(struct ice_pf *pf) { }
 static inline void ice_vc_notify_reset(struct ice_pf *pf) { }
+static inline void ice_vf_ena_rxq_interrupt(struct ice_vsi *vsi, u32 q_idx) { }
+static inline void ice_vf_ena_txq_interrupt(struct ice_vsi *vsi, u32 q_idx) { }
+
+static inline int ice_vf_ena_vlan_promisc(struct ice_vf *vf,
+					  struct ice_vsi *vsi,
+					  struct ice_vlan *vlan)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool ice_is_vlan_promisc_allowed(struct ice_vf *vf)
+{
+	return false;
+}
 
 static inline int
 ice_vc_send_msg_to_vf(struct ice_vf *vf, u32 v_opcode,
-- 
2.47.1


