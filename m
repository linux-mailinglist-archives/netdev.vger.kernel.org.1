Return-Path: <netdev+bounces-199271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6433CADF967
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 362EB7ABB25
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEAF2857CD;
	Wed, 18 Jun 2025 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcTZdbl8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D917328002F
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750285512; cv=none; b=IlRATEhEGcru79proD9hzT6CdA2WynZUEb9W23kMPqP7XRaSdB3C37p9A1lmR40KN2Pvfq5AZcIuCafMtcCVd+U+kNBoyTjXHqsTMLFQ2XQ+AW2VSP1twtFaGEF7+Z+4zdj5A2U6w7Puv4sf+xeeZKnGRgXmAqjDuGrEBn7bq9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750285512; c=relaxed/simple;
	bh=rhq8dzIz8pax8Wh2vmobZ3l9cl/j650dJwwNvVc6lLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZb5RYjrcAcvHGYDCtxvl1QhGWhcEd1k4I2xrvsOhwkX+LxCte/nR1FoO9pfA6Hn8CgXH5ayjBeEVaPpAStScOeJNC4yWMjDgZKIUwBi2agT44XKTguald1XK9FDzRrPDoAo3w+JgOAfIESsx9TuLhkmea9zquxOCN5vncQw7cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcTZdbl8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750285511; x=1781821511;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rhq8dzIz8pax8Wh2vmobZ3l9cl/j650dJwwNvVc6lLA=;
  b=WcTZdbl8GNTHRaGkCR+U+xTbtuHpdjVlOCuApBAS0xJYM/X8ww2iNzH3
   TStDbwhZDaMCcxFkddJM5mpma5k0OCIW9bd7t0ox+wq9qmQ3wPq8nxXff
   LDjREMbexJSkJuTGmcrZhPvq5jiX2qygxHHbxuyFXC15y0SqV8HJECrYJ
   Vw7oH6Ja0Z9Yk+LbhXY5yWxInq51Ch3nXwHlTp5dWJrdGylzP7zY6pyau
   ykTcfnEKha36KTAEmAiWNxw9PU1JjoU9AFAHKmqrq+9nj8dXi/bT3MnfW
   lQyAzZEA+Au8mUvbonVf7aBZP7VHQvdYoPdEPMETA1pNLoazAnEKlIYxJ
   Q==;
X-CSE-ConnectionGUID: zaAYEv40RDOGH0fai2W9RA==
X-CSE-MsgGUID: lINi7CaAQtq3043swHU6Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52447742"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52447742"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:25:05 -0700
X-CSE-ConnectionGUID: PYL5fvQDTumpd28MpXVjtA==
X-CSE-MsgGUID: DoY/6CX5QCqTYK+r68ZviA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149870018"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:25:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 18 Jun 2025 15:24:40 -0700
Subject: [PATCH iwl-next 5/8] ice: expose VF functions used by live
 migration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-e810-live-migration-jk-migration-prep-v1-5-72a37485453e@intel.com>
References: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
In-Reply-To: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org, 
 Madhu Chittim <madhu.chittim@intel.com>, Yahui Cao <yahui.cao@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.2

The live migration process will require configuring the target VF with the
data provided from the source host. A few helper functions in ice_sriov.c
and ice_virtchnl.c will be needed for this process, but are currently
static.

Expose these functions in their respective headers so that the live
migration module can use them during the migration process.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.h    |  7 +++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl.h | 19 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 13 ++++++-------
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
index 96549ca5c52c5b0483266096a49e278d2206a01d..d1a998a4bef64c4d573abc8c3489e12d7d7a4471 100644
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
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.h b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
index b3eece8c67804a808e51875a975be2176b1cab37..71bb456e2d71a5fe73e0372ac3cf5ed67ee197b2 100644
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
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 691ebb143e75863d25d6c0fbd1f0f330b363f919..25796727307978a89815e94caf6fa75030426658 100644
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
@@ -2606,7 +2605,7 @@ static bool ice_vf_vlan_offload_ena(u32 caps)
  * ice_is_vlan_promisc_allowed - check if VLAN promiscuous config is allowed
  * @vf: VF used to determine if VLAN promiscuous config is allowed
  */
-static bool ice_is_vlan_promisc_allowed(struct ice_vf *vf)
+bool ice_is_vlan_promisc_allowed(struct ice_vf *vf)
 {
 	if ((test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states) ||
 	     test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states)) &&
@@ -2625,8 +2624,8 @@ static bool ice_is_vlan_promisc_allowed(struct ice_vf *vf)
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

-- 
2.48.1.397.gec9d649cc640


