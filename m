Return-Path: <netdev+bounces-39954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8817C4FD8
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 12:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348521C20F20
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABBD1DA5B;
	Wed, 11 Oct 2023 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SH2x4keU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80761DA59;
	Wed, 11 Oct 2023 10:15:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EE6A7;
	Wed, 11 Oct 2023 03:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697019333; x=1728555333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=be4eUH2Ldwl+vuGHWCvFOPxAQkfJ89MRK98Bu9/bNN8=;
  b=SH2x4keUnCjUITcueLrFpJvgcOuyfvmvpyBsd3JpuTI/JlJtjAT9J/M/
   lj9OMuBxjhSqn+zR40XjIN2anyUWCEV+uzKi8XsVRai/XUVBFa4qKxgg+
   0KzmeIa5S0cMkv0d9aHfp4ccRASuZt6cfuQAtG8pHLNEdpbuobMjaOeaa
   biBY3fuHab8N35Kjprqx/s642wOFGHaZoc7V7RUud37llhoNX9T77A4tq
   vO63bFBQwbtONu5c8tqylP6oxtFdcjziHAXCRHoLLn3xws4Ibzp1V8Hdu
   b3/JbmpuC6jekzr/RoTNwObArGmLDlEtuojfLVLv7EKSZdxlSNvfHcrke
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415672217"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415672217"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:15:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="897576362"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="897576362"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2023 03:13:45 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	corbet@lwn.net,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v5 4/5] ice: dpll: implement phase related callbacks
Date: Wed, 11 Oct 2023 12:12:35 +0200
Message-Id: <20231011101236.23160-5-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231011101236.23160-1-arkadiusz.kubalewski@intel.com>
References: <20231011101236.23160-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement new callback ops related to measurement and adjustment of
signal phase for pin-dpll in ice driver.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 220 +++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h |  10 +-
 2 files changed, 226 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 1faee9cb944d..835c419ccc74 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -878,6 +878,199 @@ ice_dpll_output_direction(const struct dpll_pin *pin, void *pin_priv,
 	return 0;
 }
 
+/**
+ * ice_dpll_pin_phase_adjust_get - callback for get pin phase adjust value
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @phase_adjust: on success holds pin phase_adjust value
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for getting phase adjust value of a pin.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_pin_phase_adjust_get(const struct dpll_pin *pin, void *pin_priv,
+			      const struct dpll_device *dpll, void *dpll_priv,
+			      s32 *phase_adjust,
+			      struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_pf *pf = p->pf;
+
+	mutex_lock(&pf->dplls.lock);
+	*phase_adjust = p->phase_adjust;
+	mutex_unlock(&pf->dplls.lock);
+
+	return 0;
+}
+
+/**
+ * ice_dpll_pin_phase_adjust_set - helper for setting a pin phase adjust value
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @phase_adjust: phase_adjust to be set
+ * @extack: error reporting
+ * @type: type of a pin
+ *
+ * Helper for dpll subsystem callback. Handler for setting phase adjust value
+ * of a pin.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_pin_phase_adjust_set(const struct dpll_pin *pin, void *pin_priv,
+			      const struct dpll_device *dpll, void *dpll_priv,
+			      s32 phase_adjust,
+			      struct netlink_ext_ack *extack,
+			      enum ice_dpll_pin_type type)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_dpll *d = dpll_priv;
+	struct ice_pf *pf = d->pf;
+	u8 flag, flags_en = 0;
+	int ret;
+
+	mutex_lock(&pf->dplls.lock);
+	switch (type) {
+	case ICE_DPLL_PIN_TYPE_INPUT:
+		flag = ICE_AQC_SET_CGU_IN_CFG_FLG1_UPDATE_DELAY;
+		if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN)
+			flags_en |= ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
+		if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_INPUT_EN)
+			flags_en |= ICE_AQC_SET_CGU_IN_CFG_FLG2_INPUT_EN;
+		ret = ice_aq_set_input_pin_cfg(&pf->hw, p->idx, flag, flags_en,
+					       0, phase_adjust);
+		break;
+	case ICE_DPLL_PIN_TYPE_OUTPUT:
+		flag = ICE_AQC_SET_CGU_OUT_CFG_UPDATE_PHASE;
+		if (p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_OUT_EN)
+			flag |= ICE_AQC_SET_CGU_OUT_CFG_OUT_EN;
+		if (p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)
+			flag |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
+		ret = ice_aq_set_output_pin_cfg(&pf->hw, p->idx, flag, 0, 0,
+						phase_adjust);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	if (!ret)
+		p->phase_adjust = phase_adjust;
+	mutex_unlock(&pf->dplls.lock);
+	if (ret)
+		NL_SET_ERR_MSG_FMT(extack,
+				   "err:%d %s failed to set pin phase_adjust:%d for pin:%u on dpll:%u\n",
+				   ret,
+				   ice_aq_str(pf->hw.adminq.sq_last_status),
+				   phase_adjust, p->idx, d->dpll_idx);
+
+	return ret;
+}
+
+/**
+ * ice_dpll_input_phase_adjust_set - callback for set input pin phase adjust
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @phase_adjust: phase_adjust to be set
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Wraps a handler for setting phase adjust on input
+ * pin.
+ *
+ * Context: Calls a function which acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_input_phase_adjust_set(const struct dpll_pin *pin, void *pin_priv,
+				const struct dpll_device *dpll, void *dpll_priv,
+				s32 phase_adjust,
+				struct netlink_ext_ack *extack)
+{
+	return ice_dpll_pin_phase_adjust_set(pin, pin_priv, dpll, dpll_priv,
+					     phase_adjust, extack,
+					     ICE_DPLL_PIN_TYPE_INPUT);
+}
+
+/**
+ * ice_dpll_output_phase_adjust_set - callback for set output pin phase adjust
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @phase_adjust: phase_adjust to be set
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Wraps a handler for setting phase adjust on output
+ * pin.
+ *
+ * Context: Calls a function which acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_output_phase_adjust_set(const struct dpll_pin *pin, void *pin_priv,
+				 const struct dpll_device *dpll, void *dpll_priv,
+				 s32 phase_adjust,
+				 struct netlink_ext_ack *extack)
+{
+	return ice_dpll_pin_phase_adjust_set(pin, pin_priv, dpll, dpll_priv,
+					     phase_adjust, extack,
+					     ICE_DPLL_PIN_TYPE_OUTPUT);
+}
+
+#define ICE_DPLL_PHASE_OFFSET_DIVIDER	100
+#define ICE_DPLL_PHASE_OFFSET_FACTOR		\
+	(DPLL_PHASE_OFFSET_DIVIDER / ICE_DPLL_PHASE_OFFSET_DIVIDER)
+/**
+ * ice_dpll_phase_offset_get - callback for get dpll phase shift value
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @phase_offset: on success holds pin phase_offset value
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for getting phase shift value between
+ * dpll's input and output.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
+			  const struct dpll_device *dpll, void *dpll_priv,
+			  s64 *phase_offset, struct netlink_ext_ack *extack)
+{
+	struct ice_dpll *d = dpll_priv;
+	struct ice_pf *pf = d->pf;
+
+	mutex_lock(&pf->dplls.lock);
+	if (d->active_input == pin)
+		*phase_offset = d->phase_offset * ICE_DPLL_PHASE_OFFSET_FACTOR;
+	else
+		*phase_offset = 0;
+	mutex_unlock(&pf->dplls.lock);
+
+	return 0;
+}
+
 /**
  * ice_dpll_rclk_state_on_pin_set - set a state on rclk pin
  * @pin: pointer to a pin
@@ -993,6 +1186,9 @@ static const struct dpll_pin_ops ice_dpll_input_ops = {
 	.prio_get = ice_dpll_input_prio_get,
 	.prio_set = ice_dpll_input_prio_set,
 	.direction_get = ice_dpll_input_direction,
+	.phase_adjust_get = ice_dpll_pin_phase_adjust_get,
+	.phase_adjust_set = ice_dpll_input_phase_adjust_set,
+	.phase_offset_get = ice_dpll_phase_offset_get,
 };
 
 static const struct dpll_pin_ops ice_dpll_output_ops = {
@@ -1001,6 +1197,8 @@ static const struct dpll_pin_ops ice_dpll_output_ops = {
 	.state_on_dpll_get = ice_dpll_output_state_get,
 	.state_on_dpll_set = ice_dpll_output_state_set,
 	.direction_get = ice_dpll_output_direction,
+	.phase_adjust_get = ice_dpll_pin_phase_adjust_get,
+	.phase_adjust_set = ice_dpll_output_phase_adjust_set,
 };
 
 static const struct dpll_device_ops ice_dpll_ops = {
@@ -1031,6 +1229,8 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
  */
 static void ice_dpll_notify_changes(struct ice_dpll *d)
 {
+	bool pin_notified = false;
+
 	if (d->prev_dpll_state != d->dpll_state) {
 		d->prev_dpll_state = d->dpll_state;
 		dpll_device_change_ntf(d->dpll);
@@ -1039,7 +1239,14 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
 		if (d->prev_input)
 			dpll_pin_change_ntf(d->prev_input);
 		d->prev_input = d->active_input;
-		if (d->active_input)
+		if (d->active_input) {
+			dpll_pin_change_ntf(d->active_input);
+			pin_notified = true;
+		}
+	}
+	if (d->prev_phase_offset != d->phase_offset) {
+		d->prev_phase_offset = d->phase_offset;
+		if (!pin_notified && d->active_input)
 			dpll_pin_change_ntf(d->active_input);
 	}
 }
@@ -1065,7 +1272,7 @@ ice_dpll_update_state(struct ice_pf *pf, struct ice_dpll *d, bool init)
 
 	ret = ice_get_cgu_state(&pf->hw, d->dpll_idx, d->prev_dpll_state,
 				&d->input_idx, &d->ref_state, &d->eec_mode,
-				&d->phase_shift, &d->dpll_state);
+				&d->phase_offset, &d->dpll_state);
 
 	dev_dbg(ice_pf_to_dev(pf),
 		"update dpll=%d, prev_src_idx:%u, src_idx:%u, state:%d, prev:%d mode:%d\n",
@@ -1656,6 +1863,15 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 				return ret;
 			pins[i].prop.capabilities |=
 				DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE;
+			pins[i].prop.phase_range.min =
+				pf->dplls.input_phase_adj_max;
+			pins[i].prop.phase_range.max =
+				-pf->dplls.input_phase_adj_max;
+		} else {
+			pins[i].prop.phase_range.min =
+				pf->dplls.output_phase_adj_max;
+			pins[i].prop.phase_range.max =
+				-pf->dplls.output_phase_adj_max;
 		}
 		pins[i].prop.capabilities |=
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index 2dfe764b81e1..bb32b6d88373 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -19,6 +19,7 @@
  * @state: state of a pin
  * @prop: pin properties
  * @freq: current frequency of a pin
+ * @phase_adjust: current phase adjust value
  */
 struct ice_dpll_pin {
 	struct dpll_pin *pin;
@@ -30,6 +31,7 @@ struct ice_dpll_pin {
 	u8 state[ICE_DPLL_RCLK_NUM_MAX];
 	struct dpll_pin_properties prop;
 	u32 freq;
+	s32 phase_adjust;
 };
 
 /** ice_dpll - store info required for DPLL control
@@ -40,7 +42,8 @@ struct ice_dpll_pin {
  * @prev_input_idx: previously selected input index
  * @ref_state: state of dpll reference signals
  * @eec_mode: eec_mode dpll is configured for
- * @phase_shift: phase shift delay of a dpll
+ * @phase_offset: phase offset of active pin vs dpll signal
+ * @prev_phase_offset: previous phase offset of active pin vs dpll signal
  * @input_prio: priorities of each input
  * @dpll_state: current dpll sync state
  * @prev_dpll_state: last dpll sync state
@@ -55,7 +58,8 @@ struct ice_dpll {
 	u8 prev_input_idx;
 	u8 ref_state;
 	u8 eec_mode;
-	s64 phase_shift;
+	s64 phase_offset;
+	s64 prev_phase_offset;
 	u8 *input_prio;
 	enum dpll_lock_status dpll_state;
 	enum dpll_lock_status prev_dpll_state;
@@ -78,6 +82,8 @@ struct ice_dpll {
  * @cgu_state_acq_err_num: number of errors returned during periodic work
  * @base_rclk_idx: idx of first pin used for clock revocery pins
  * @clock_id: clock_id of dplls
+ * @input_phase_adj_max: max phase adjust value for an input pins
+ * @output_phase_adj_max: max phase adjust value for an output pins
  */
 struct ice_dplls {
 	struct kthread_worker *kworker;
-- 
2.38.1


