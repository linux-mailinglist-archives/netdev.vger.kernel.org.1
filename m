Return-Path: <netdev+bounces-137673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBFA9A9423
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 01:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707841F22ADB
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 23:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEED1FF617;
	Mon, 21 Oct 2024 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TciH5guy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018111FF046
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553195; cv=none; b=VAEgT/cUEg9ARcYTC6Q1B82qtjOt795W1iR9jFsP3X+KNHu3+tSc7jv7oOz1jaeINxUf6+AbdBwHLA/XLdijtxecMgQdcFLUocIGXDVeAGKP1uUGI+nHPotAR9W9voo62Jsgpw8+u+nR4Kd4eQx+sDdI9SlAQdEde/B6fcLjdJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553195; c=relaxed/simple;
	bh=t0aZDrMKR9fhSGCmN4/snndHXV50BQv4sq+97NN4zv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMuzVKOEctl5g1YZALQHPLFsXV2l+hGzIBvy0c9QLhuzE6Wn6YHln9r6BKSqZPKGjIMmkKB9buM5es27HP0+HyQTGePISabJ+hDqg9VR2x9VAho6pxWRaKRU+Yla1IChRVzWbfbZv/bAifiYjfCb8mbTzUMjCoqPleV0gwcT3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TciH5guy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729553194; x=1761089194;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=t0aZDrMKR9fhSGCmN4/snndHXV50BQv4sq+97NN4zv0=;
  b=TciH5guyk2pokhCNV6nXo30Nl0UY5ug3JjVney0TDl4PqdUslKyf7Obs
   JAzuaSN9nrOpMmSN0lQaVD2882T7yi+w3yFXBliPCcjiMUACGOcOmGaXQ
   td4POo30m1bMzhPXLHnYOJRYVudE+zn1c3n2CHWWktt5P7pOnMSpC+8lu
   8+SCkxsPbUV9vQB5xMPf93NzBuOSuh4T1BnEUb8xvx+sdmktXzlZf6SZM
   QcQaj0YrWEV1ANHujmjL+aXeiHNobQNp614080gboQ42R+e8yAEPyhubp
   OQQy3pge8XrOYrXGmTiTSJXmCw44qw9O8qqPWlMT/WouS+D0AHV5QtJhu
   A==;
X-CSE-ConnectionGUID: JZoHDU1QTNKEBcf+HZYVjg==
X-CSE-MsgGUID: wTiZjs6NRyaDHSM5qjktLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="31927060"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="31927060"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 16:26:31 -0700
X-CSE-ConnectionGUID: JQLhjrj/RiaOlzHdHYeWnA==
X-CSE-MsgGUID: 9oHYaSWfTnOqJ0/bw+hyYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79761750"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 16:26:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 21 Oct 2024 16:26:26 -0700
Subject: [PATCH net 3/3] ice: fix crash on probe for DPLL enabled E810 LOM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-3-a50cb3059f55@intel.com>
References: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-0-a50cb3059f55@intel.com>
In-Reply-To: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-0-a50cb3059f55@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jeff Garzik <jgarzik@redhat.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Piotr Raczynski <piotr.raczynski@intel.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Milena Olech <milena.olech@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Michal Michalik <michal.michalik@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Jacob Keller <jacob.e.keller@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.14.1

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

The E810 Lan On Motherboard (LOM) design is vendor specific. Intel
provides the reference design, but it is up to vendor on the final
product design. For some cases, like Linux DPLL support, the static
values defined in the driver does not reflect the actual LOM design.
Current implementation of dpll pins is causing the crash on probe
of the ice driver for such DPLL enabled E810 LOM designs:

WARNING: (...) at drivers/dpll/dpll_core.c:495 dpll_pin_get+0x2c4/0x330
...
Call Trace:
 <TASK>
 ? __warn+0x83/0x130
 ? dpll_pin_get+0x2c4/0x330
 ? report_bug+0x1b7/0x1d0
 ? handle_bug+0x42/0x70
 ? exc_invalid_op+0x18/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? dpll_pin_get+0x117/0x330
 ? dpll_pin_get+0x2c4/0x330
 ? dpll_pin_get+0x117/0x330
 ice_dpll_get_pins.isra.0+0x52/0xe0 [ice]
...

The number of dpll pins enabled by LOM vendor is greater than expected
and defined in the driver for Intel designed NICs, which causes the crash.

Prevent the crash and allow generic pin initialization within Linux DPLL
subsystem for DPLL enabled E810 LOM designs.

Newly designed solution for described issue will be based on "per HW
design" pin initialization. It requires pin information dynamically
acquired from the firmware and is already in progress, planned for
next-tree only.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Reviewed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  1 +
 drivers/net/ethernet/intel/ice/ice_dpll.c   | 70 +++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 21 ++++++++-
 3 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 0852a34ade91..6cedc1a906af 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -404,6 +404,7 @@ int ice_read_sma_ctrl_e810t(struct ice_hw *hw, u8 *data);
 int ice_write_sma_ctrl_e810t(struct ice_hw *hw, u8 data);
 int ice_read_pca9575_reg_e810t(struct ice_hw *hw, u8 offset, u8 *data);
 bool ice_is_pca9575_present(struct ice_hw *hw);
+int ice_cgu_get_num_pins(struct ice_hw *hw, bool input);
 enum dpll_pin_type ice_cgu_get_pin_type(struct ice_hw *hw, u8 pin, bool input);
 struct dpll_pin_frequency *
 ice_cgu_get_pin_freq_supp(struct ice_hw *hw, u8 pin, bool input, u8 *num);
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 74c0e7319a4c..d5ad6d84007c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -10,6 +10,7 @@
 #define ICE_DPLL_PIN_IDX_INVALID		0xff
 #define ICE_DPLL_RCLK_NUM_PER_PF		1
 #define ICE_DPLL_PIN_ESYNC_PULSE_HIGH_PERCENT	25
+#define ICE_DPLL_PIN_GEN_RCLK_FREQ		1953125
 
 /**
  * enum ice_dpll_pin_type - enumerate ice pin types:
@@ -2063,6 +2064,73 @@ static int ice_dpll_init_worker(struct ice_pf *pf)
 	return 0;
 }
 
+/**
+ * ice_dpll_init_info_pins_generic - initializes generic pins info
+ * @pf: board private structure
+ * @input: if input pins initialized
+ *
+ * Init information for generic pins, cache them in PF's pins structures.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - init failure reason
+ */
+static int ice_dpll_init_info_pins_generic(struct ice_pf *pf, bool input)
+{
+	struct ice_dpll *de = &pf->dplls.eec, *dp = &pf->dplls.pps;
+	static const char labels[][sizeof("99")] = {
+		"0", "1", "2", "3", "4", "5", "6", "7", "8",
+		"9", "10", "11", "12", "13", "14", "15" };
+	u32 cap = DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+	enum ice_dpll_pin_type pin_type;
+	int i, pin_num, ret = -EINVAL;
+	struct ice_dpll_pin *pins;
+	u32 phase_adj_max;
+
+	if (input) {
+		pin_num = pf->dplls.num_inputs;
+		pins = pf->dplls.inputs;
+		phase_adj_max = pf->dplls.input_phase_adj_max;
+		pin_type = ICE_DPLL_PIN_TYPE_INPUT;
+		cap |= DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE;
+	} else {
+		pin_num = pf->dplls.num_outputs;
+		pins = pf->dplls.outputs;
+		phase_adj_max = pf->dplls.output_phase_adj_max;
+		pin_type = ICE_DPLL_PIN_TYPE_OUTPUT;
+	}
+	if (pin_num > ARRAY_SIZE(labels))
+		return ret;
+
+	for (i = 0; i < pin_num; i++) {
+		pins[i].idx = i;
+		pins[i].prop.board_label = labels[i];
+		pins[i].prop.phase_range.min = phase_adj_max;
+		pins[i].prop.phase_range.max = -phase_adj_max;
+		pins[i].prop.capabilities = cap;
+		pins[i].pf = pf;
+		ret = ice_dpll_pin_state_update(pf, &pins[i], pin_type, NULL);
+		if (ret)
+			break;
+		if (input && pins[i].freq == ICE_DPLL_PIN_GEN_RCLK_FREQ)
+			pins[i].prop.type = DPLL_PIN_TYPE_MUX;
+		else
+			pins[i].prop.type = DPLL_PIN_TYPE_EXT;
+		if (!input)
+			continue;
+		ret = ice_aq_get_cgu_ref_prio(&pf->hw, de->dpll_idx, i,
+					      &de->input_prio[i]);
+		if (ret)
+			break;
+		ret = ice_aq_get_cgu_ref_prio(&pf->hw, dp->dpll_idx, i,
+					      &dp->input_prio[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 /**
  * ice_dpll_init_info_direct_pins - initializes direct pins info
  * @pf: board private structure
@@ -2101,6 +2169,8 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 	default:
 		return -EINVAL;
 	}
+	if (num_pins != ice_cgu_get_num_pins(hw, input))
+		return ice_dpll_init_info_pins_generic(pf, input);
 
 	for (i = 0; i < num_pins; i++) {
 		caps = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a33e6b9b313..ec8db830ac73 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -34,7 +34,6 @@ static const struct ice_cgu_pin_desc ice_e810t_sfp_cgu_inputs[] = {
 		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
 	{ "GNSS-1PPS",	  ZL_REF4P, DPLL_PIN_TYPE_GNSS,
 		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
-	{ "OCXO",	  ZL_REF4N, DPLL_PIN_TYPE_INT_OSCILLATOR, 0, },
 };
 
 static const struct ice_cgu_pin_desc ice_e810t_qsfp_cgu_inputs[] = {
@@ -52,7 +51,6 @@ static const struct ice_cgu_pin_desc ice_e810t_qsfp_cgu_inputs[] = {
 		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
 	{ "GNSS-1PPS",	  ZL_REF4P, DPLL_PIN_TYPE_GNSS,
 		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
-	{ "OCXO",	  ZL_REF4N, DPLL_PIN_TYPE_INT_OSCILLATOR, },
 };
 
 static const struct ice_cgu_pin_desc ice_e810t_sfp_cgu_outputs[] = {
@@ -5964,6 +5962,25 @@ ice_cgu_get_pin_desc(struct ice_hw *hw, bool input, int *size)
 	return t;
 }
 
+/**
+ * ice_cgu_get_num_pins - get pin description array size
+ * @hw: pointer to the hw struct
+ * @input: if request is done against input or output pins
+ *
+ * Return: size of pin description array for given hw.
+ */
+int ice_cgu_get_num_pins(struct ice_hw *hw, bool input)
+{
+	const struct ice_cgu_pin_desc *t;
+	int size;
+
+	t = ice_cgu_get_pin_desc(hw, input, &size);
+	if (t)
+		return size;
+
+	return 0;
+}
+
 /**
  * ice_cgu_get_pin_type - get pin's type
  * @hw: pointer to the hw struct

-- 
2.47.0.265.g4ca455297942


