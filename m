Return-Path: <netdev+bounces-106463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E16A79167F3
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D50D1F28530
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA43157A6C;
	Tue, 25 Jun 2024 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U14RaYhm"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703FB1553A7;
	Tue, 25 Jun 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318844; cv=none; b=FCkqDPk2kq2MsnPygNrUgtMtfctoigF3agYeF/w2bwwZfnn9mPRQ9BBcd6iGeuFF4VGywTTCyRuSAQXAbRlSNrABVKrI45SvF4rK6DospGQRdxNyTTk3dLESyE21kYQhaEatZE8iFMQCFzF9oyvLy6AlHFljquIZVTJHi8vdFXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318844; c=relaxed/simple;
	bh=Nx2RwQ5Cb8TM4b8DvQ5NetRnGlP7SgivgCFU+vFVtkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yh44Vg6qA5G/iUkNfRmznwnVQ6HSWg2XhY3RV5yIzF8l6RUjjTJUdVPNqgSakdq8MJ5QFzufIF5Q43q9Rm1xhhR77orBHIiqsMrnk+G6RDbygZKmpm0OSRHxRdRqIAqOYMHiPUT8+NJll2X0xqQ/iof6xTXXZVBQh7WFmbXJDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U14RaYhm; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CDD260004;
	Tue, 25 Jun 2024 12:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719318839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1nBIv7y8Ey9Ns7UjK0pm+oS/fuQqSnRlFQo7O4sWR9M=;
	b=U14RaYhmVN4ffDpRYXQ7qlGbrGpszxDINZ2XEya0QcgUKi1B+MPA6S/8OZdEkSdGseh5Bh
	0qZP6iSAn+G9ZB6CwvUNTJZlCvCRCIluYmQ+K0qn7JvvWGcU3GNZX0tRgkB3rWDTLUDRt9
	3tuFaoWDXim9Z476Lk3Tvhk+YeNGvyy135bhcQTgmdfdetxYotzFYJAJ626HXHXbn01wyQ
	uqWbe6q0fUO4/6l+byL72/Q7SKdH3x9GO0OaoXYi8xEg9ES/gAdbsa53qsM0D3dSH1WTDn
	FbndgnGZ+upZmUEX2LVw6aSwHZ42YDk6R1jzAlDuttxRLZmWMV9qUlFqFjyh6g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 25 Jun 2024 14:33:46 +0200
Subject: [PATCH net-next v4 1/7] net: ethtool: pse-pd: Expand C33 PSE
 status with class, power and extended state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240625-feature_poe_power_cap-v4-1-b0813aad57d5@bootlin.com>
References: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
In-Reply-To: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 linux-doc@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This update expands the status information provided by ethtool for PSE c33.
It includes details such as the detected class, current power delivered,
and extended state information.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Move on PSE string error messages to ETHTOOL_LINK_EXT_STATE and
  ETHTOOL_LINK_EXT_SUBSTATE with fixed enumeration in aim to unify
  interface diagnostic.

Change in v3:
- Add ethtool netlink documentation and kdoc.
- Move on to u32 for state and substate.
- Update C33 pse extended state and substate following Oleksij proposal.

Change in v4:
- Made few changes in the c33 pse extended state and substate enumerations.
- Update pse_reply to send extended substate only if extended state is present.
---
 Documentation/networking/ethtool-netlink.rst |  37 ++++++
 include/linux/ethtool.h                      |  15 +++
 include/linux/pse-pd/pse.h                   |   8 ++
 include/uapi/linux/ethtool.h                 | 191 +++++++++++++++++++++++++++
 include/uapi/linux/ethtool_netlink.h         |   4 +
 net/ethtool/pse-pd.c                         |  32 ++++-
 6 files changed, 286 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 160bfb0ae8ba..7dbf2ef3ac0e 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1730,6 +1730,13 @@ Kernel response contents:
                                                   PSE functions.
   ``ETHTOOL_A_C33_PSE_PW_D_STATUS``          u32  power detection status of the
                                                   PoE PSE.
+  ``ETHTOOL_A_C33_PSE_PW_CLASS``             u32  power class of the PoE PSE.
+  ``ETHTOOL_A_C33_PSE_ACTUAL_PW``            u32  actual power drawn on the
+                                                  PoE PSE.
+  ``ETHTOOL_A_C33_PSE_EXT_STATE``            u32  power extended state of the
+                                                  PoE PSE.
+  ``ETHTOOL_A_C33_PSE_EXT_SUBSTATE``         u32  power extended substatus of
+                                                  the PoE PSE.
   ======================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
@@ -1762,6 +1769,36 @@ The same goes for ``ETHTOOL_A_C33_PSE_ADMIN_PW_D_STATUS`` implementing
 .. kernel-doc:: include/uapi/linux/ethtool.h
     :identifiers: ethtool_c33_pse_pw_d_status
 
+When set, the optional ``ETHTOOL_A_C33_PSE_PW_CLASS`` attribute identifies
+the power class of the C33 PSE. It depends on the class negotiated between
+the PSE and the PD. This option is corresponding to ``IEEE 802.3-2022``
+30.9.1.1.8 aPSEPowerClassification.
+
+When set, the optional ``ETHTOOL_A_C33_PSE_ACTUAL_PW`` attribute identifies
+This option is corresponding to ``IEEE 802.3-2022`` 30.9.1.1.23 aPSEActualPower.
+Actual power is reported in mW.
+
+When set, the optional ``ETHTOOL_A_C33_PSE_EXT_STATE`` attribute identifies
+the extended error state of the C33 PSE. Possible values are:
+
+.. kernel-doc:: include/uapi/linux/ethtool.h
+    :identifiers: ethtool_c33_pse_ext_state
+
+When set, the optional ``ETHTOOL_A_C33_PSE_EXT_SUBSTATE`` attribute identifies
+the extended error state of the C33 PSE. Possible values are:
+Possible values are:
+
+.. kernel-doc:: include/uapi/linux/ethtool.h
+    :identifiers: ethtool_c33_pse_ext_substate_class_num_events
+		  ethtool_c33_pse_ext_substate_error_condition
+		  ethtool_c33_pse_ext_substate_mr_pse_enable
+		  ethtool_c33_pse_ext_substate_option_detect_ted
+		  ethtool_c33_pse_ext_substate_option_vport_lim
+		  ethtool_c33_pse_ext_substate_ovld_detected
+		  ethtool_c33_pse_ext_substate_pd_dll_power_type
+		  ethtool_c33_pse_ext_substate_power_not_available
+		  ethtool_c33_pse_ext_substate_short_detected
+
 PSE_SET
 =======
 
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 6fd9107d3cc0..3c96aa8765d9 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1155,4 +1155,19 @@ struct ethtool_forced_speed_map {
 
 void
 ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size);
+
+/* C33 PSE extended state and substate. */
+struct ethtool_c33_pse_ext_state_info {
+	enum ethtool_c33_pse_ext_state c33_pse_ext_state;
+	union {
+		enum ethtool_c33_pse_ext_substate_error_condition error_condition;
+		enum ethtool_c33_pse_ext_substate_mr_pse_enable mr_pse_enable;
+		enum ethtool_c33_pse_ext_substate_option_detect_ted option_detect_ted;
+		enum ethtool_c33_pse_ext_substate_option_vport_lim option_vport_lim;
+		enum ethtool_c33_pse_ext_substate_ovld_detected ovld_detected;
+		enum ethtool_c33_pse_ext_substate_power_not_available power_not_available;
+		enum ethtool_c33_pse_ext_substate_short_detected short_detected;
+		u32 __c33_pse_ext_substate;
+	};
+};
 #endif /* _LINUX_ETHTOOL_H */
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 6eec24ffa866..38b9308e5e7a 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -36,12 +36,20 @@ struct pse_control_config {
  *	functions. IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
  * @c33_pw_status: power detection status of the PSE.
  *	IEEE 802.3-2022 30.9.1.1.5 aPSEPowerDetectionStatus:
+ * @c33_pw_class: detected class of a powered PD
+ *	IEEE 802.3-2022 30.9.1.1.8 aPSEPowerClassification
+ * @c33_actual_pw: power currently delivered by the PSE in mW
+ *	IEEE 802.3-2022 30.9.1.1.23 aPSEActualPower
+ * @c33_ext_state_info: extended state information of the PSE
  */
 struct pse_control_status {
 	enum ethtool_podl_pse_admin_state podl_admin_state;
 	enum ethtool_podl_pse_pw_d_status podl_pw_status;
 	enum ethtool_c33_pse_admin_state c33_admin_state;
 	enum ethtool_c33_pse_pw_d_status c33_pw_status;
+	u32 c33_pw_class;
+	u32 c33_actual_pw;
+	struct ethtool_c33_pse_ext_state_info c33_ext_state_info;
 };
 
 /**
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 8733a3117902..36b488780f20 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -752,6 +752,197 @@ enum ethtool_module_power_mode {
 	ETHTOOL_MODULE_POWER_MODE_HIGH,
 };
 
+/**
+ * enum ethtool_c33_pse_ext_state - groups of PSE extended states
+ *      functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION: Group of error_condition states
+ * @ETHTOOL_C33_PSE_EXT_STATE_MR_MPS_VALID: Group of mr_mps_valid states
+ * @ETHTOOL_C33_PSE_EXT_STATE_MR_PSE_ENABLE: Group of mr_pse_enable states
+ * @ETHTOOL_C33_PSE_EXT_STATE_OPTION_DETECT_TED: Group of option_detect_ted
+ *	states
+ * @ETHTOOL_C33_PSE_EXT_STATE_OPTION_VPORT_LIM: Group of option_vport_lim states
+ * @ETHTOOL_C33_PSE_EXT_STATE_OVLD_DETECTED: Group of ovld_detected states
+ * @ETHTOOL_C33_PSE_EXT_STATE_PD_DLL_POWER_TYPE: Group of pd_dll_power_type
+ *	states
+ * @ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE: Group of power_not_available
+ *	states
+ * @ETHTOOL_C33_PSE_EXT_STATE_SHORT_DETECTED: Group of short_detected states
+ */
+enum ethtool_c33_pse_ext_state {
+	ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION = 1,
+	ETHTOOL_C33_PSE_EXT_STATE_MR_MPS_VALID,
+	ETHTOOL_C33_PSE_EXT_STATE_MR_PSE_ENABLE,
+	ETHTOOL_C33_PSE_EXT_STATE_OPTION_DETECT_TED,
+	ETHTOOL_C33_PSE_EXT_STATE_OPTION_VPORT_LIM,
+	ETHTOOL_C33_PSE_EXT_STATE_OVLD_DETECTED,
+	ETHTOOL_C33_PSE_EXT_STATE_PD_DLL_POWER_TYPE,
+	ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE,
+	ETHTOOL_C33_PSE_EXT_STATE_SHORT_DETECTED,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_mr_mps_valid - mr_mps_valid states
+ *      functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_MPS_VALID_DETECTED_UNDERLOAD: Underload
+ *	state
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_MPS_VALID_CONNECTION_OPEN: Port is not
+ *	connected
+ *
+ * The PSE monitors either the DC or AC Maintain Power Signature
+ * (MPS, see 33.2.9.1). This variable indicates the presence or absence of
+ * a valid MPS.
+ */
+enum ethtool_c33_pse_ext_substate_mr_mps_valid {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_MPS_VALID_DETECTED_UNDERLOAD = 1,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_MPS_VALID_CONNECTION_OPEN,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_error_condition - error_condition states
+ *      functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_NON_EXISTING_PORT: Non-existing
+ *	port number
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNDEFINED_PORT: Undefined port
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_INTERNAL_HW_FAULT: Internal
+ *	hardware fault
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_COMM_ERROR_AFTER_FORCE_ON:
+ *	Communication error after force on
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS: Unknown
+ *	port status
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_TURN_OFF: Host
+ *	crash turn off
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_FORCE_SHUTDOWN:
+ *	Host crash force shutdown
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_CONFIG_CHANGE: Configuration
+ *	change
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_OVER_TEMP: Over
+ *	temperature detected
+ *
+ * error_condition is a variable indicating the status of
+ * implementation-specific fault conditions or optionally other system faults
+ * that prevent the PSE from meeting the specifications in Table 33–11 and that
+ * require the PSE not to source power. These error conditions are different
+ * from those monitored by the state diagrams in Figure 33–10.
+ */
+enum ethtool_c33_pse_ext_substate_error_condition {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_NON_EXISTING_PORT = 1,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNDEFINED_PORT,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_INTERNAL_HW_FAULT,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_COMM_ERROR_AFTER_FORCE_ON,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_TURN_OFF,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_FORCE_SHUTDOWN,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_CONFIG_CHANGE,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_OVER_TEMP,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_mr_pse_enable - mr_pse_enable states
+ *      functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_PSE_ENABLE_DISABLE_PIN_ACTIVE: Disable
+ *	pin active
+ *
+ * mr_pse_enable is control variable that selects PSE operation and test
+ * functions.
+ */
+enum ethtool_c33_pse_ext_substate_mr_pse_enable {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_PSE_ENABLE_DISABLE_PIN_ACTIVE = 1,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_option_detect_ted - option_detect_ted
+ *	states functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_DET_IN_PROCESS: Detection
+ *	in process
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_CONNECTION_CHECK_ERROR:
+ *	Connection check error
+ *
+ * option_detect_ted is a variable indicating if detection can be performed
+ * by the PSE during the ted_timer interval.
+ */
+enum ethtool_c33_pse_ext_substate_option_detect_ted {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_DET_IN_PROCESS = 1,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_CONNECTION_CHECK_ERROR,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_option_vport_lim - option_vport_lim states
+ *      functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_HIGH_VOLTAGE: Main supply
+ *	voltage is high
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_LOW_VOLTAGE: Main supply
+ *	voltage is low
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_VOLTAGE_INJECTION: Voltage
+ *	injection into the port
+ *
+ * option_vport_lim is an optional variable indicates if VPSE is out of the
+ * operating range during normal operating state.
+ */
+enum ethtool_c33_pse_ext_substate_option_vport_lim {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_HIGH_VOLTAGE = 1,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_LOW_VOLTAGE,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_VOLTAGE_INJECTION,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_ovld_detected - ovld_detected states
+ *      functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OVLD_DETECTED_OVERLOAD: Overload state
+ *
+ * ovld_detected is a variable indicating if the PSE output current has been
+ * in an overload condition (see 33.2.7.6) for at least TCUT of a one-second
+ * sliding time.
+ */
+enum ethtool_c33_pse_ext_substate_ovld_detected {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_OVLD_DETECTED_OVERLOAD = 1,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_power_not_available - power_not_available
+ *	states functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_BUDGET_EXCEEDED: Power
+ *	budget exceeded for the controller
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PORT_PW_LIMIT_EXCEEDS_CONTROLLER_BUDGET:
+ *	Configured port power limit exceeded controller power budget
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PD_REQUEST_EXCEEDS_PORT_LIMIT:
+ *	Power request from PD exceeds port limit
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_HW_PW_LIMIT: Power
+ *	denied due to Hardware power limit
+ *
+ * power_not_available is a variable that is asserted in an
+ * implementation-dependent manner when the PSE is no longer capable of
+ * sourcing sufficient power to support the attached PD. Sufficient power
+ * is defined by classification; see 33.2.6.
+ */
+enum ethtool_c33_pse_ext_substate_power_not_available {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_BUDGET_EXCEEDED =  1,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PORT_PW_LIMIT_EXCEEDS_CONTROLLER_BUDGET,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PD_REQUEST_EXCEEDS_PORT_LIMIT,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_HW_PW_LIMIT,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_short_detected - short_detected states
+ *      functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_SHORT_DETECTED_SHORT_CONDITION: Short
+ *	condition was detected
+ *
+ * short_detected is a variable indicating if the PSE output current has been
+ * in a short circuit condition for TLIM within a sliding window (see 33.2.7.7).
+ */
+enum ethtool_c33_pse_ext_substate_short_detected {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_SHORT_DETECTED_SHORT_CONDITION = 1,
+};
+
 /**
  * enum ethtool_pse_types - Types of PSE controller.
  * @ETHTOOL_PSE_UNKNOWN: Type of PSE controller is unknown
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index b49b804b9495..398a0aa8daad 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -915,6 +915,10 @@ enum {
 	ETHTOOL_A_C33_PSE_ADMIN_STATE,		/* u32 */
 	ETHTOOL_A_C33_PSE_ADMIN_CONTROL,	/* u32 */
 	ETHTOOL_A_C33_PSE_PW_D_STATUS,		/* u32 */
+	ETHTOOL_A_C33_PSE_PW_CLASS,		/* u32 */
+	ETHTOOL_A_C33_PSE_ACTUAL_PW,		/* u32 */
+	ETHTOOL_A_C33_PSE_EXT_STATE,		/* u32 */
+	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,		/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PSE_CNT,
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 2c981d443f27..d2a1c14d789f 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -86,7 +86,16 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 		len += nla_total_size(sizeof(u32)); /* _C33_PSE_ADMIN_STATE */
 	if (st->c33_pw_status > 0)
 		len += nla_total_size(sizeof(u32)); /* _C33_PSE_PW_D_STATUS */
-
+	if (st->c33_pw_class > 0)
+		len += nla_total_size(sizeof(u32)); /* _C33_PSE_PW_CLASS */
+	if (st->c33_actual_pw > 0)
+		len += nla_total_size(sizeof(u32)); /* _C33_PSE_ACTUAL_PW */
+	if (st->c33_ext_state_info.c33_pse_ext_state > 0) {
+		len += nla_total_size(sizeof(u32)); /* _C33_PSE_EXT_STATE */
+		if (st->c33_ext_state_info.__c33_pse_ext_substate > 0)
+			/* _C33_PSE_EXT_SUBSTATE */
+			len += nla_total_size(sizeof(u32));
+	}
 	return len;
 }
 
@@ -117,6 +126,27 @@ static int pse_fill_reply(struct sk_buff *skb,
 			st->c33_pw_status))
 		return -EMSGSIZE;
 
+	if (st->c33_pw_class > 0 &&
+	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_PW_CLASS,
+			st->c33_pw_class))
+		return -EMSGSIZE;
+
+	if (st->c33_actual_pw > 0 &&
+	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_ACTUAL_PW,
+			st->c33_actual_pw))
+		return -EMSGSIZE;
+
+	if (st->c33_ext_state_info.c33_pse_ext_state > 0) {
+		if (nla_put_u32(skb, ETHTOOL_A_C33_PSE_EXT_STATE,
+				st->c33_ext_state_info.c33_pse_ext_state))
+			return -EMSGSIZE;
+
+		if (st->c33_ext_state_info.__c33_pse_ext_substate > 0 &&
+		    nla_put_u32(skb, ETHTOOL_A_C33_PSE_EXT_SUBSTATE,
+				st->c33_ext_state_info.__c33_pse_ext_substate))
+			return -EMSGSIZE;
+	}
+
 	return 0;
 }
 

-- 
2.34.1


