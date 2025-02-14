Return-Path: <netdev+bounces-166534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28277A3661B
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 20:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB087A5F13
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 19:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA95E1C8608;
	Fri, 14 Feb 2025 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgJCZL6x"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3B21C84B5
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561277; cv=none; b=WZKnCuppnNZQjiG2GHoi4eGkjElo+vQNyAOs5gFBHuJuyOe+X8a0XmJB36qs1uzTc4G5tDOeQucG8mUavSwUqoPbca1FjyI6qKTBlJ62JI9j7+51o31u2b42psL9tC+IYwpjjt9zJX89nMWqWNZnT7xXxAk9GLnh5Yr0rq27SsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561277; c=relaxed/simple;
	bh=vo/a02SWUYShX1ra7fnuMsFboSvv94XE+Dznl+oi5a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZenvlYORg7wkHhZbIQ7/+7R9ndyTOd/0W89MQErQC3FEET6LJJT40wbiRztnExidJlHlYaLjxawcnzXvvJvvLQ0iJeY4iTIpJG6mg55kxHlWL6uoVaVzFbZQs/imOs0HvIQqmTy9c22Q35SA5EIcwWvoBkoMhoWV2kBgLc1vMvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgJCZL6x; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739561275; x=1771097275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vo/a02SWUYShX1ra7fnuMsFboSvv94XE+Dznl+oi5a8=;
  b=KgJCZL6xz6AFGE4/dW8r5Cw33On7fdpEMxmi001ouxw9hmx+7yt9kIep
   EdK62CZR7VfL5Zt19GdM01b6uNkZwIP5LnTQhWY0E0QHnx7x376oWgKT1
   ohlTqetDAluYvrLQliVHd5fif09JOR5aBA26w0NCsVSylFWvVhwv3/O9O
   YqHjMAp7SRn5XkcNMHTu9tdZr42cs6wKze4yOQk+XDm71/3uXE70aToMD
   x1wam3xeDqp+fpAFslcurvcApppwtViAAv1bQ/yBExyIhWgOgv637bbuQ
   o3oKaUVlZdsX3nTDjBykrsTPERszUs+VbScICIuPzMISzntcFGWTPiWcD
   A==;
X-CSE-ConnectionGUID: E9VzJ3yCTHmrP06Cx/cQ3A==
X-CSE-MsgGUID: /9rPz7BmSmSgqSd5Olp1Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40244094"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40244094"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 11:27:53 -0800
X-CSE-ConnectionGUID: MsfeLcSuTbCdSl3uZurVRw==
X-CSE-MsgGUID: PbNkDHCaRAeVEXwACj4osw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="144393981"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 14 Feb 2025 11:27:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	mateusz.polchlopek@intel.com,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 02/14] ice: support Rx timestamp on flex descriptor
Date: Fri, 14 Feb 2025 11:27:23 -0800
Message-ID: <20250214192739.1175740-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250214192739.1175740-1-anthony.l.nguyen@intel.com>
References: <20250214192739.1175740-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Simei Su <simei.su@intel.com>

To support Rx timestamp offload, VIRTCHNL_OP_1588_PTP_CAPS is sent by
the VF to request PTP capability and responded by the PF what capability
is enabled for that VF.

Hardware captures timestamps which contain only 32 bits of nominal
nanoseconds, as opposed to the 64bit timestamps that the stack expects.
To convert 32b to 64b, we need a current PHC time.
VIRTCHNL_OP_1588_PTP_GET_TIME is sent by the VF and responded by the
PF with the current PHC time.

Signed-off-by: Simei Su <simei.su@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c     |  3 -
 drivers/net/ethernet/intel/ice/ice_lib.c      |  5 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  8 ++
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  3 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 76 ++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |  6 ++
 .../intel/ice/ice_virtchnl_allowlist.c        |  7 ++
 include/linux/avf/virtchnl.h                  | 15 +++-
 9 files changed, 116 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 0e862f20427a..b3234a55a253 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -473,9 +473,6 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	 */
 	if (vsi->type != ICE_VSI_VF)
 		ice_write_qrxflxp_cntxt(hw, pf_q, rxdid, 0x3, true);
-	else
-		ice_write_qrxflxp_cntxt(hw, pf_q, ICE_RXDID_LEGACY_1, 0x3,
-					false);
 
 	/* Absolute queue number out of 2K needs to be passed */
 	err = ice_write_rxq_ctx(hw, &rlan_ctx, pf_q);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 978f308d3b1b..7f5b229cab05 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1775,9 +1775,8 @@ void ice_update_eth_stats(struct ice_vsi *vsi)
  * @prio: priority for the RXDID for this queue
  * @ena_ts: true to enable timestamp and false to disable timestamp
  */
-void
-ice_write_qrxflxp_cntxt(struct ice_hw *hw, u16 pf_q, u32 rxdid, u32 prio,
-			bool ena_ts)
+void ice_write_qrxflxp_cntxt(struct ice_hw *hw, u16 pf_q, u32 rxdid, u32 prio,
+			     bool ena_ts)
 {
 	int regval = rd32(hw, QRXFLXP_CNTXT(pf_q));
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b65114ff487b..1bb0033347c7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -298,8 +298,8 @@ void ice_ptp_restore_timestamp_mode(struct ice_pf *pf)
  * @sts: Optional parameter for holding a pair of system timestamps from
  *       the system clock. Will be ignored if NULL is given.
  */
-static u64
-ice_ptp_read_src_clk_reg(struct ice_pf *pf, struct ptp_system_timestamp *sts)
+u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
+			     struct ptp_system_timestamp *sts)
 {
 	struct ice_hw *hw = &pf->hw;
 	u32 hi, lo, lo2;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 783139de7f74..3b769a0cad00 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -304,6 +304,8 @@ void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx);
 void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx);
 enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf);
 irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf);
+u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
+			     struct ptp_system_timestamp *sts);
 
 u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 			const struct ice_pkt_ctx *pkt_ctx);
@@ -347,6 +349,12 @@ static inline irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 	return IRQ_HANDLED;
 }
 
+static inline u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
+					   struct ptp_system_timestamp *sts)
+{
+	return 0;
+}
+
 static inline u64
 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 		    const struct ice_pkt_ctx *pkt_ctx)
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 4261fe1c2bcd..799b2c1f1184 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -124,6 +124,9 @@ struct ice_vf {
 	u8 spoofchk:1;
 	u8 link_forced:1;
 	u8 link_up:1;			/* only valid if VF link is forced */
+
+	u32 ptp_caps;
+
 	unsigned int min_tx_rate;	/* Minimum Tx bandwidth limit in Mbps */
 	unsigned int max_tx_rate;	/* Maximum Tx bandwidth limit in Mbps */
 	DECLARE_BITMAP(vf_states, ICE_VF_STATES_NBITS);	/* VF runtime states */
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index ff4ad788d96a..629f04d1c3ff 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -498,6 +498,9 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_QOS)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_QOS;
 
+	if (vf->driver_caps & VIRTCHNL_VF_CAP_PTP)
+		vfres->vf_cap_flags |= VIRTCHNL_VF_CAP_PTP;
+
 	vfres->num_vsis = 1;
 	/* Tx and Rx queue are equal for VF */
 	vfres->num_queue_pairs = vsi->num_txq;
@@ -1975,6 +1978,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 	struct ice_vsi *vsi;
 	u8 act_prt, pri_prt;
 	int i = -1, q_idx;
+	bool ena_ts;
 
 	lag = pf->lag;
 	mutex_lock(&pf->lag_mutex);
@@ -2104,9 +2108,14 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 				rxdid = ICE_RXDID_LEGACY_1;
 			}
 
+			ena_ts = ((vf->driver_caps &
+				  VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC) &&
+				  (vf->driver_caps & VIRTCHNL_VF_CAP_PTP) &&
+				  (qpi->rxq.flags & VIRTCHNL_PTP_RX_TSTAMP));
+
 			ice_write_qrxflxp_cntxt(&vsi->back->hw,
-						vsi->rxq_map[q_idx],
-						rxdid, 0x03, false);
+						vsi->rxq_map[q_idx], rxdid,
+						ICE_RXDID_PRIO, ena_ts);
 		}
 	}
 
@@ -4092,6 +4101,59 @@ static int ice_vc_dis_vlan_insertion_v2_msg(struct ice_vf *vf, u8 *msg)
 				     v_ret, NULL, 0);
 }
 
+static int ice_vc_get_ptp_cap(struct ice_vf *vf,
+			      const struct virtchnl_ptp_caps *msg)
+{
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+	u32 caps = VIRTCHNL_1588_PTP_CAP_RX_TSTAMP |
+		   VIRTCHNL_1588_PTP_CAP_READ_PHC;
+
+	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
+		goto err;
+
+	v_ret = VIRTCHNL_STATUS_SUCCESS;
+
+	if (msg->caps & caps)
+		vf->ptp_caps = caps;
+
+err:
+	/* send the response back to the VF */
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_1588_PTP_GET_CAPS, v_ret,
+				     (u8 *)&vf->ptp_caps,
+				     sizeof(struct virtchnl_ptp_caps));
+}
+
+static int ice_vc_get_phc_time(struct ice_vf *vf)
+{
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+	struct virtchnl_phc_time *phc_time = NULL;
+	struct ice_pf *pf = vf->pf;
+	u32 len = 0;
+	int ret;
+
+	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
+		goto err;
+
+	v_ret = VIRTCHNL_STATUS_SUCCESS;
+
+	phc_time = kzalloc(sizeof(*phc_time), GFP_KERNEL);
+	if (!phc_time) {
+		v_ret = VIRTCHNL_STATUS_ERR_NO_MEMORY;
+		goto err;
+	}
+
+	len = sizeof(*phc_time);
+
+	phc_time->time = ice_ptp_read_src_clk_reg(pf, NULL);
+
+err:
+	/* send the response back to the VF */
+	ret = ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_1588_PTP_GET_TIME, v_ret,
+				    (u8 *)phc_time, len);
+	kfree(phc_time);
+	return ret;
+}
+
 static const struct ice_virtchnl_ops ice_virtchnl_dflt_ops = {
 	.get_ver_msg = ice_vc_get_ver_msg,
 	.get_vf_res_msg = ice_vc_get_vf_res_msg,
@@ -4128,6 +4190,8 @@ static const struct ice_virtchnl_ops ice_virtchnl_dflt_ops = {
 	.get_qos_caps = ice_vc_get_qos_caps,
 	.cfg_q_bw = ice_vc_cfg_q_bw,
 	.cfg_q_quanta = ice_vc_cfg_q_quanta,
+	.get_ptp_cap = ice_vc_get_ptp_cap,
+	.get_phc_time = ice_vc_get_phc_time,
 	/* If you add a new op here please make sure to add it to
 	 * ice_virtchnl_repr_ops as well.
 	 */
@@ -4264,6 +4328,8 @@ static const struct ice_virtchnl_ops ice_virtchnl_repr_ops = {
 	.get_qos_caps = ice_vc_get_qos_caps,
 	.cfg_q_bw = ice_vc_cfg_q_bw,
 	.cfg_q_quanta = ice_vc_cfg_q_quanta,
+	.get_ptp_cap = ice_vc_get_ptp_cap,
+	.get_phc_time = ice_vc_get_phc_time,
 };
 
 /**
@@ -4501,6 +4567,12 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event,
 	case VIRTCHNL_OP_CONFIG_QUANTA:
 		err = ops->cfg_q_quanta(vf, msg);
 		break;
+	case VIRTCHNL_OP_1588_PTP_GET_CAPS:
+		err = ops->get_ptp_cap(vf, (const void *)msg);
+		break;
+	case VIRTCHNL_OP_1588_PTP_GET_TIME:
+		err = ops->get_phc_time(vf);
+		break;
 	case VIRTCHNL_OP_UNKNOWN:
 	default:
 		dev_err(dev, "Unsupported opcode %d from VF %d\n", v_opcode,
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.h b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
index 0c629aef9baf..222990f229d5 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
@@ -26,6 +26,9 @@
 #define ICE_MAX_MACADDR_PER_VF		18
 #define ICE_FLEX_DESC_RXDID_MAX_NUM	64
 
+/* Priority to be compared against previous priority from the pipe */
+#define ICE_RXDID_PRIO			0x03
+
 /* VFs only get a single VSI. For ice hardware, the VF does not need to know
  * its VSI index. However, the virtchnl interface requires a VSI number,
  * mainly due to legacy hardware.
@@ -72,6 +75,9 @@ struct ice_virtchnl_ops {
 	int (*cfg_q_tc_map)(struct ice_vf *vf, u8 *msg);
 	int (*cfg_q_bw)(struct ice_vf *vf, u8 *msg);
 	int (*cfg_q_quanta)(struct ice_vf *vf, u8 *msg);
+	int (*get_ptp_cap)(struct ice_vf *vf,
+			   const struct virtchnl_ptp_caps *msg);
+	int (*get_phc_time)(struct ice_vf *vf);
 };
 
 #ifdef CONFIG_PCI_IOV
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
index c105a82ee136..a3d1579a619a 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
@@ -84,6 +84,12 @@ static const u32 fdir_pf_allowlist_opcodes[] = {
 	VIRTCHNL_OP_ADD_FDIR_FILTER, VIRTCHNL_OP_DEL_FDIR_FILTER,
 };
 
+/* VIRTCHNL_VF_CAP_PTP */
+static const u32 ptp_allowlist_opcodes[] = {
+	VIRTCHNL_OP_1588_PTP_GET_CAPS,
+	VIRTCHNL_OP_1588_PTP_GET_TIME,
+};
+
 static const u32 tc_allowlist_opcodes[] = {
 	VIRTCHNL_OP_GET_QOS_CAPS, VIRTCHNL_OP_CONFIG_QUEUE_BW,
 	VIRTCHNL_OP_CONFIG_QUANTA,
@@ -110,6 +116,7 @@ static const struct allowlist_opcode_info allowlist_opcodes[] = {
 	ALLOW_ITEM(VIRTCHNL_VF_OFFLOAD_FDIR_PF, fdir_pf_allowlist_opcodes),
 	ALLOW_ITEM(VIRTCHNL_VF_OFFLOAD_VLAN_V2, vlan_v2_allowlist_opcodes),
 	ALLOW_ITEM(VIRTCHNL_VF_OFFLOAD_QOS, tc_allowlist_opcodes),
+	ALLOW_ITEM(VIRTCHNL_VF_CAP_PTP, ptp_allowlist_opcodes),
 };
 
 /**
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 92866e449b21..56baf97c44d0 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -313,6 +313,18 @@ struct virtchnl_txq_info {
 
 VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_txq_info);
 
+/* virtchnl_rxq_info_flags - definition of bits in the flags field of the
+ *			     virtchnl_rxq_info structure.
+ *
+ * @VIRTCHNL_PTP_RX_TSTAMP: request to enable Rx timestamping
+ *
+ * Other flag bits are currently reserved and they may be extended in the
+ * future.
+ */
+enum virtchnl_rxq_info_flags {
+	VIRTCHNL_PTP_RX_TSTAMP = BIT(0),
+};
+
 /* VIRTCHNL_OP_CONFIG_RX_QUEUE
  * VF sends this message to set up parameters for one RX queue.
  * External data buffer contains one instance of virtchnl_rxq_info.
@@ -336,7 +348,8 @@ struct virtchnl_rxq_info {
 	u32 max_pkt_size;
 	u8 crc_disable;
 	u8 rxdid;
-	u8 pad1[2];
+	enum virtchnl_rxq_info_flags flags:8; /* see virtchnl_rxq_info_flags */
+	u8 pad1;
 	u64 dma_ring_addr;
 
 	/* see enum virtchnl_rx_hsplit; deprecated with AVF 1.0 */
-- 
2.47.1


