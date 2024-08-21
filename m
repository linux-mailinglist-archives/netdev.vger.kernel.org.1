Return-Path: <netdev+bounces-120739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 784E495A6C6
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEDB1C22AAE
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55E317B500;
	Wed, 21 Aug 2024 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTTsw+dQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5165178361;
	Wed, 21 Aug 2024 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276211; cv=none; b=ihILIp0tkzt9vDheOCFbUe4IoEk6aa629eMTvc73pZEe3ubmVzB+97U6bTU4qkMdfdF8F78mTtrqSyY2y8Af3pwbXOi2joqMCQ3zZLAf2yJ11266QAJf4Q/ytZQ8Q9/kVO/EMWCmtpSxGMQQT2kagnEcVgwNe71dzh+mBqRP6/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276211; c=relaxed/simple;
	bh=GuUGg7LnZOfJhh8E7ueHAphHX3K1J1UByxf37EL1ov8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhOAFzuNTzvJ4xldFsNQwT8XfUqDswa/FoMZQAcu/KJlwOa0yINwBSROtHjef6iDvUqHl0L7dp5LJNSKMy0oxV7kl2k+qWm3ZjxULPrhWyIRnaxh+5mquf8Vh0HbMV+qRy7SZNuY5S717/0Gs3u1k7OjZZNBxdImMS1z5eXj24U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTTsw+dQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724276210; x=1755812210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GuUGg7LnZOfJhh8E7ueHAphHX3K1J1UByxf37EL1ov8=;
  b=ZTTsw+dQjLOQrR9EIdP4lF/zq5xoeD89a5Uu1+nV7WUp8Qhanf4sI6dE
   B74zrYyJU69F2MOng+Qj0Ga110f/UulB9V7DQZctkV3M1NT3oc9TjRjyE
   o20+wr0YYmd6wJcX3mOHAUEN8XANFUjAQo4Il6/jjwbvV+3azQaew8pSd
   EN2oVRE6s/DfPLuHU3kORNJTX7ARqjloLMJuF7r1il2mhHysXzhD6p1F/
   gOc4CbD3LrPMp5oOon03WAjYf8TY/5rLm3khgTdLkYejvYExO7tcrtCst
   6n8UgRwnbOgUHn/lVwvDQO7ZOqt+BIqIVeTxvkrDanSfo9YzHnQ5N0oLV
   Q==;
X-CSE-ConnectionGUID: lJ1Vf2DLTh2JUKdTpoEy1Q==
X-CSE-MsgGUID: /kOhQDbnSsyqLrt/5ccNIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="34083839"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="34083839"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 14:36:48 -0700
X-CSE-ConnectionGUID: EV/R+ZVFR5Gbs9KgdSrEWQ==
X-CSE-MsgGUID: g7RFJimOQqG2nT8D7BbUJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="98724643"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa001.jf.intel.com with ESMTP; 21 Aug 2024 14:36:43 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v2 2/2] ice: add callbacks for Embedded SYNC enablement on dpll pins
Date: Wed, 21 Aug 2024 23:32:18 +0200
Message-Id: <20240821213218.232900-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240821213218.232900-1-arkadiusz.kubalewski@intel.com>
References: <20240821213218.232900-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the user to get and set configuration of Embedded SYNC feature
on the ice driver dpll pins.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v2:
- align to v2 changes of "dpll: add Embedded SYNC feature for a pin"

 drivers/net/ethernet/intel/ice/ice_dpll.c | 230 +++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h |   1 +
 2 files changed, 228 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index e92be6f130a3..aa6b87281ea6 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -9,6 +9,7 @@
 #define ICE_CGU_STATE_ACQ_ERR_THRESHOLD		50
 #define ICE_DPLL_PIN_IDX_INVALID		0xff
 #define ICE_DPLL_RCLK_NUM_PER_PF		1
+#define ICE_DPLL_PIN_ESYNC_PULSE_HIGH_PERCENT	25
 
 /**
  * enum ice_dpll_pin_type - enumerate ice pin types:
@@ -30,6 +31,10 @@ static const char * const pin_type_name[] = {
 	[ICE_DPLL_PIN_TYPE_RCLK_INPUT] = "rclk-input",
 };
 
+static const struct dpll_pin_frequency ice_esync_range[] = {
+	DPLL_PIN_FREQUENCY_RANGE(0, DPLL_PIN_FREQUENCY_1_HZ),
+};
+
 /**
  * ice_dpll_is_reset - check if reset is in progress
  * @pf: private board structure
@@ -394,8 +399,8 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 
 	switch (pin_type) {
 	case ICE_DPLL_PIN_TYPE_INPUT:
-		ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, NULL, NULL,
-					       NULL, &pin->flags[0],
+		ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, &pin->status,
+					       NULL, NULL, &pin->flags[0],
 					       &pin->freq, &pin->phase_adjust);
 		if (ret)
 			goto err;
@@ -430,7 +435,7 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 			goto err;
 
 		parent &= ICE_AQC_GET_CGU_OUT_CFG_DPLL_SRC_SEL;
-		if (ICE_AQC_SET_CGU_OUT_CFG_OUT_EN & pin->flags[0]) {
+		if (ICE_AQC_GET_CGU_OUT_CFG_OUT_EN & pin->flags[0]) {
 			pin->state[pf->dplls.eec.dpll_idx] =
 				parent == pf->dplls.eec.dpll_idx ?
 				DPLL_PIN_STATE_CONNECTED :
@@ -1098,6 +1103,221 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
 	return 0;
 }
 
+/**
+ * ice_dpll_output_esync_set - callback for setting embedded sync
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @esync_freq: requested embedded sync frequency
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for setting embedded sync frequency value
+ * on output pin.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_output_esync_set(const struct dpll_pin *pin, void *pin_priv,
+			  const struct dpll_device *dpll, void *dpll_priv,
+			  u64 esync_freq, struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_dpll *d = dpll_priv;
+	struct ice_pf *pf = d->pf;
+	u8 flags = 0;
+	int ret;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+	mutex_lock(&pf->dplls.lock);
+	if (p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_OUT_EN)
+		flags = ICE_AQC_SET_CGU_OUT_CFG_OUT_EN;
+	if (esync_freq == DPLL_PIN_FREQUENCY_1_HZ) {
+		if (p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN) {
+			ret = 0;
+		} else {
+			flags |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
+			ret = ice_aq_set_output_pin_cfg(&pf->hw, p->idx, flags,
+							0, 0, 0);
+		}
+	} else {
+		if (!(p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)) {
+			ret = 0;
+		} else {
+			flags &= ~ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
+			ret = ice_aq_set_output_pin_cfg(&pf->hw, p->idx, flags,
+							0, 0, 0);
+		}
+	}
+	mutex_unlock(&pf->dplls.lock);
+	if (ret)
+		NL_SET_ERR_MSG_FMT(extack,
+				   "err:%d %s failed to set e-sync freq\n",
+				   ret,
+				   ice_aq_str(pf->hw.adminq.sq_last_status));
+	return ret;
+}
+
+/**
+ * ice_dpll_output_esync_get - callback for getting embedded sync config
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @esync: on success holds embedded sync pin properties
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for getting embedded sync frequency value
+ * and capabilities on output pin.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_output_esync_get(const struct dpll_pin *pin, void *pin_priv,
+			  const struct dpll_device *dpll, void *dpll_priv,
+			  struct dpll_pin_esync *esync,
+			  struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_dpll *d = dpll_priv;
+	struct ice_pf *pf = d->pf;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+	mutex_lock(&pf->dplls.lock);
+	if (!(p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_ABILITY) ||
+	    p->freq != DPLL_PIN_FREQUENCY_10_MHZ) {
+		mutex_unlock(&pf->dplls.lock);
+		return -EOPNOTSUPP;
+	}
+	esync->range = ice_esync_range;
+	esync->range_num = ARRAY_SIZE(ice_esync_range);
+	if (p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN) {
+		esync->freq = DPLL_PIN_FREQUENCY_1_HZ;
+		esync->pulse = ICE_DPLL_PIN_ESYNC_PULSE_HIGH_PERCENT;
+	} else {
+		esync->freq = 0;
+		esync->pulse = 0;
+	}
+	mutex_unlock(&pf->dplls.lock);
+	return 0;
+}
+
+/**
+ * ice_dpll_input_esync_set - callback for setting embedded sync
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @esync_freq: requested embedded sync frequency
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for setting embedded sync frequency value
+ * on input pin.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_input_esync_set(const struct dpll_pin *pin, void *pin_priv,
+			 const struct dpll_device *dpll, void *dpll_priv,
+			 u64 esync_freq, struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_dpll *d = dpll_priv;
+	struct ice_pf *pf = d->pf;
+	u8 flags_en = 0;
+	int ret;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+	mutex_lock(&pf->dplls.lock);
+	if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_INPUT_EN)
+		flags_en = ICE_AQC_SET_CGU_IN_CFG_FLG2_INPUT_EN;
+	if (esync_freq == DPLL_PIN_FREQUENCY_1_HZ) {
+		if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN) {
+			ret = 0;
+		} else {
+			flags_en |= ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
+			ret = ice_aq_set_input_pin_cfg(&pf->hw, p->idx, 0,
+						       flags_en, 0, 0);
+		}
+	} else {
+		if (!(p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN)) {
+			ret = 0;
+		} else {
+			flags_en &= ~ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
+			ret = ice_aq_set_input_pin_cfg(&pf->hw, p->idx, 0,
+						       flags_en, 0, 0);
+		}
+	}
+	mutex_unlock(&pf->dplls.lock);
+	if (ret)
+		NL_SET_ERR_MSG_FMT(extack,
+				   "err:%d %s failed to set e-sync freq\n",
+				   ret,
+				   ice_aq_str(pf->hw.adminq.sq_last_status));
+
+	return ret;
+}
+
+/**
+ * ice_dpll_input_esync_get - callback for getting embedded sync config
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @esync: on success holds embedded sync pin properties
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for getting embedded sync frequency value
+ * and capabilities on input pin.
+ *
+ * Context: Acquires pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_input_esync_get(const struct dpll_pin *pin, void *pin_priv,
+			 const struct dpll_device *dpll, void *dpll_priv,
+			 struct dpll_pin_esync *esync,
+			 struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_dpll *d = dpll_priv;
+	struct ice_pf *pf = d->pf;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+	mutex_lock(&pf->dplls.lock);
+	if (!(p->status & ICE_AQC_GET_CGU_IN_CFG_STATUS_ESYNC_CAP) ||
+	    p->freq != DPLL_PIN_FREQUENCY_10_MHZ) {
+		mutex_unlock(&pf->dplls.lock);
+		return -EOPNOTSUPP;
+	}
+	esync->range = ice_esync_range;
+	esync->range_num = ARRAY_SIZE(ice_esync_range);
+	if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN) {
+		esync->freq = DPLL_PIN_FREQUENCY_1_HZ;
+		esync->pulse = ICE_DPLL_PIN_ESYNC_PULSE_HIGH_PERCENT;
+	} else {
+		esync->freq = 0;
+		esync->pulse = 0;
+	}
+	mutex_unlock(&pf->dplls.lock);
+	return 0;
+}
+
 /**
  * ice_dpll_rclk_state_on_pin_set - set a state on rclk pin
  * @pin: pointer to a pin
@@ -1222,6 +1442,8 @@ static const struct dpll_pin_ops ice_dpll_input_ops = {
 	.phase_adjust_get = ice_dpll_pin_phase_adjust_get,
 	.phase_adjust_set = ice_dpll_input_phase_adjust_set,
 	.phase_offset_get = ice_dpll_phase_offset_get,
+	.esync_set = ice_dpll_input_esync_set,
+	.esync_get = ice_dpll_input_esync_get,
 };
 
 static const struct dpll_pin_ops ice_dpll_output_ops = {
@@ -1232,6 +1454,8 @@ static const struct dpll_pin_ops ice_dpll_output_ops = {
 	.direction_get = ice_dpll_output_direction,
 	.phase_adjust_get = ice_dpll_pin_phase_adjust_get,
 	.phase_adjust_set = ice_dpll_output_phase_adjust_set,
+	.esync_set = ice_dpll_output_esync_set,
+	.esync_get = ice_dpll_output_esync_get,
 };
 
 static const struct dpll_device_ops ice_dpll_ops = {
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index 93172e93995b..c320f1bf7d6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -31,6 +31,7 @@ struct ice_dpll_pin {
 	struct dpll_pin_properties prop;
 	u32 freq;
 	s32 phase_adjust;
+	u8 status;
 };
 
 /** ice_dpll - store info required for DPLL control
-- 
2.38.1


