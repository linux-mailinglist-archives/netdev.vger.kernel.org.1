Return-Path: <netdev+bounces-121182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8903B95C0DE
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 00:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DA21F2481C
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 22:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD281D27AB;
	Thu, 22 Aug 2024 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9J85Oxd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F07D1D279A;
	Thu, 22 Aug 2024 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724365785; cv=none; b=bLzEoGU8P+it32khfzpR2pw15u+MMGzMVKjYNu6ri7Rn0R5/HWf7T69Uo22KYFOVOvYWBJKiCBpBh8dVpZFDJ655HdeIQlzTINZw0K0dZB1kM2NKqeb39XdVG2Gwdv+ZyLlvAnonx3Q3tKGdR0gzNSbrXlGftvo1bZVH125i1HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724365785; c=relaxed/simple;
	bh=Ds8xiiqZ4J2jJZkrOEZ38f0QpCqETiTvKacS7ZnNWEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Th9VqN6NqLFpEkABg+un6aSbsNFujFKUn+ZAnJL8lZcyCZSNKb1Rop9So1MxoPahY9Oiok8T534vkLyn27u5SamS4Z0BGU7X23sb9I3YLcv8ehh+h9wW4FjTnanQm2MnzcozJetU5Y7Ro/XvxoBV2zYWxOFKkU6sSAzcrJ+tQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9J85Oxd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724365784; x=1755901784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ds8xiiqZ4J2jJZkrOEZ38f0QpCqETiTvKacS7ZnNWEQ=;
  b=f9J85OxdA7wmP2WJnleFc3hCs6des2jxsm75U/ei9hXvJSIez1mZIOxb
   LzxcEN9wpmqITll5gL29PHjQ3vhFAxSp7pXAn7LwBYSgVq/mMNxHE9PzD
   KPO7Dr/Jy0222nr0QFQU+aBbAkssu4SSB4aBZhiZw/nOmvyO6R6IXUeim
   Hz4tptLGR86w7nmEyQ5zytHQ5uq3E4t3FFAIpJNrKiaJjlBPJvqFdpnap
   2/gv3yHp4nx4mP8h2JNQA4/mg25CAIY+6oBHQ9rPcrQQw1Gzl9q9oSjzc
   H+FMs0fZMTO+OCV15hyLD+fhmGq9+lOZiIvykuuIh3nHGyCG5vgk6vRBq
   w==;
X-CSE-ConnectionGUID: rInglR14TiOgYYIaJQ1Zgw==
X-CSE-MsgGUID: 9VAKZsDdTW2YqpBtYqKNhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40325025"
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="40325025"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 15:29:43 -0700
X-CSE-ConnectionGUID: TMl5eyAOQyy3t9Bf5gBJmQ==
X-CSE-MsgGUID: c/arIMUMS4+nJNfSwSZCUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="61903157"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa006.jf.intel.com with ESMTP; 22 Aug 2024 15:29:40 -0700
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
Subject: [PATCH net-next v3 2/2] ice: add callbacks for Embedded SYNC enablement on dpll pins
Date: Fri, 23 Aug 2024 00:25:13 +0200
Message-Id: <20240822222513.255179-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240822222513.255179-1-arkadiusz.kubalewski@intel.com>
References: <20240822222513.255179-1-arkadiusz.kubalewski@intel.com>
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
v3:
- remove redundant extack error
- rename esync_freq -> freq

 drivers/net/ethernet/intel/ice/ice_dpll.c | 223 +++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h |   1 +
 2 files changed, 221 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index e92be6f130a3..cd95705d1e7f 100644
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
@@ -1098,6 +1103,214 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
 	return 0;
 }
 
+/**
+ * ice_dpll_output_esync_set - callback for setting embedded sync
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @freq: requested embedded sync frequency
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
+			  u64 freq, struct netlink_ext_ack *extack)
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
+	if (freq == DPLL_PIN_FREQUENCY_1_HZ) {
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
+
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
+
+	return 0;
+}
+
+/**
+ * ice_dpll_input_esync_set - callback for setting embedded sync
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @dpll: registered dpll pointer
+ * @dpll_priv: private data pointer passed on dpll registration
+ * @freq: requested embedded sync frequency
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
+			 u64 freq, struct netlink_ext_ack *extack)
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
+	if (freq == DPLL_PIN_FREQUENCY_1_HZ) {
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
+
+	return 0;
+}
+
 /**
  * ice_dpll_rclk_state_on_pin_set - set a state on rclk pin
  * @pin: pointer to a pin
@@ -1222,6 +1435,8 @@ static const struct dpll_pin_ops ice_dpll_input_ops = {
 	.phase_adjust_get = ice_dpll_pin_phase_adjust_get,
 	.phase_adjust_set = ice_dpll_input_phase_adjust_set,
 	.phase_offset_get = ice_dpll_phase_offset_get,
+	.esync_set = ice_dpll_input_esync_set,
+	.esync_get = ice_dpll_input_esync_get,
 };
 
 static const struct dpll_pin_ops ice_dpll_output_ops = {
@@ -1232,6 +1447,8 @@ static const struct dpll_pin_ops ice_dpll_output_ops = {
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


