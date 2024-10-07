Return-Path: <netdev+bounces-132658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAF0992B7E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161B728636E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448F31D27A5;
	Mon,  7 Oct 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SbOHT48j"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B9A14AD17;
	Mon,  7 Oct 2024 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303567; cv=none; b=gEODS3frqsveVG76FuxwJr8kgfzJsB4r3ZN6GxX3ZpLlPIB9sNT2Bzj8GgEH7zv426zXNEGh4Q6E44Uc5Ob2P/HzItHmvt8NNTlFIdyIZ5ev1HPsHpXnL1AEhmpR9wJV+zdFpL0jByzOeLkkDY8jB14F8cDn6AyZnrTy+v+p26s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303567; c=relaxed/simple;
	bh=tDckWo0UbmYUf+BlPAczXZBwQD1wdzA84d/LK+hfSnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bD1Xhxe/h41g6UyncCy82h/f7I9F7NCMB8VtJTW1O9YYm5LFp+vSN+wiFAIXmNIt6I0pBNHv9N+b+UX16DdgOKeeftwX9m8UPGOgzs1CH44vAoldIhTYyvPFjRWjJivClDcKiL9iLk8zYx0jCimG+t2OxLUSY3t6zllKJan7Ckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SbOHT48j; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8C1120007;
	Mon,  7 Oct 2024 12:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728303557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=anLbPr5EQkL9U+UhabNgHfpg3VPrYoVibUnevxjLXKw=;
	b=SbOHT48jMWMdR8EIJxb4MyMZ5ps3W358WEwluwOmg1ECEADy2cMJMW9cttlO3zTVyucDlI
	ncm1aCkSjQnWKugD+Naaku05ylx8GSlkU5g19IOqT4aatiRIN8sws4Ec6X2cNd/Ml0RU2c
	Yxoh/GF2pkoNSB+y8+o26B7k5+HBgi6YHh+CzsSa3eOSB030/RnkSvAGTw3cNwY0J36RHY
	o7UJV4rsqQ79+7RKifFTh9HfAhldvCfK/zlByYYSRDLJXZNI6l3K1j2PVS+Y8c0SZHru34
	2dGjCqxS1zAoGBXgpV/giqjKZhSEmvDb902djtru8vbJ6f9yrM3lX+84tePEEw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 07 Oct 2024 14:18:49 +0200
Subject: [PATCH ethtool-next v2 1/2] ethtool: pse-pd: Expand C33 PSE with
 several new features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-feature_poe_power_cap-v2-1-cbd1aa1064df@bootlin.com>
References: <20241007-feature_poe_power_cap-v2-0-cbd1aa1064df@bootlin.com>
In-Reply-To: <20241007-feature_poe_power_cap-v2-0-cbd1aa1064df@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Kyle Swenson <kyle.swenson@est.tech>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch adds support for several new features to the C33 PSE commands:
- Get the Class negotiated between the Powered Device and the PSE
- Get Extended state and substate
- Get the Actual power
- Configure the power limit
- Get the Power limit ranges available

Example:
$ ethtool --set-pse eth1 c33-pse-avail-pw-limit 18000
$ ethtool --show-pse eth1
PSE attributes for eth1:
Clause 33 PSE Admin State: enabled
Clause 33 PSE Power Detection Status: disabled
Clause 33 PSE Extended State: Group of mr_mps_valid states
Clause 33 PSE Extended Substate: Port is not connected
Clause 33 PSE Available Power Limit: 18000
Clause 33 PSE Power Limit Ranges:
	range:
		min 15000
		max 18100
	range:
		min 30000
		max 38000
	range:
		min 60000
		max 65000
	range:
		min 90000
		max 97500

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

If you think the Power Limit Ranges display does not fit your liking
please do not hesitate to ask for change.

Change in v2:
- Add the missing c33-pse-avail-pw-limit help usage.
---
 ethtool.c        |   1 +
 netlink/pse-pd.c | 275 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 276 insertions(+)

diff --git a/ethtool.c b/ethtool.c
index 2813098..b9227fa 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6246,6 +6246,7 @@ static const struct option args[] = {
 		.help	= "Set Power Sourcing Equipment settings",
 		.xhelp	= "		[ podl-pse-admin-control enable|disable ]\n"
 			  "		[ c33-pse-admin-control enable|disable ]\n"
+			  "		[ c33-pse-avail-pw-limit N ]\n"
 	},
 	{
 		.opts	= "--flash-module-firmware",
diff --git a/netlink/pse-pd.c b/netlink/pse-pd.c
index 3f6b6aa..fd1fc4d 100644
--- a/netlink/pse-pd.c
+++ b/netlink/pse-pd.c
@@ -89,10 +89,226 @@ static const char *c33_pse_pw_d_status_name(u32 val)
 		return "unsupported";
 	}
 }
+
+static const char *c33_pse_ext_state_name(u32 val)
+{
+	switch (val) {
+	case ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION:
+		return "Group of error_condition states";
+	case ETHTOOL_C33_PSE_EXT_STATE_MR_MPS_VALID:
+		return "Group of mr_mps_valid states";
+	case ETHTOOL_C33_PSE_EXT_STATE_MR_PSE_ENABLE:
+		return "Group of mr_pse_enable states";
+	case ETHTOOL_C33_PSE_EXT_STATE_OPTION_DETECT_TED:
+		return "Group of option_detect_ted";
+	case ETHTOOL_C33_PSE_EXT_STATE_OPTION_VPORT_LIM:
+		return "Group of option_vport_lim states";
+	case ETHTOOL_C33_PSE_EXT_STATE_OVLD_DETECTED:
+		return "Group of ovld_detected states";
+	case ETHTOOL_C33_PSE_EXT_STATE_PD_DLL_POWER_TYPE:
+		return "Group of pd_dll_power_type states";
+	case ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE:
+		return "Group of power_not_available states";
+	case ETHTOOL_C33_PSE_EXT_STATE_SHORT_DETECTED:
+		return "Group of short_detected states";
+	default:
+		return "unsupported";
+	}
+}
+
+static const char *c33_pse_ext_substate_mr_mps_valid_name(u32 val)
+{
+	switch (val) {
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_MPS_VALID_DETECTED_UNDERLOAD:
+		return "Underload state";
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_MPS_VALID_CONNECTION_OPEN:
+		return "Port is not connected";
+	default:
+		return "unsupported";
+	}
+}
+
+static const char *c33_pse_ext_substate_error_condition_name(u32 val)
+{
+	switch (val) {
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_NON_EXISTING_PORT:
+		return "Non-existing port number";
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNDEFINED_PORT:
+		return "Undefined port";
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_INTERNAL_HW_FAULT:
+		return "Internal hardware fault";
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_COMM_ERROR_AFTER_FORCE_ON:
+		return "Communication error after force on";
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS:
+		return "Unknown port status";
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_TURN_OFF:
+		return "Host crash turn off";
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_FORCE_SHUTDOWN:
+		return "Host crash force shutdown";
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_CONFIG_CHANGE:
+		return "Configuration change";
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_OVER_TEMP:
+		return "Over temperature detected";
+	default:
+		return "unsupported";
+	}
+}
+
+static const char *c33_pse_ext_substate_mr_pse_enable_name(u32 val)
+{
+	switch (val) {
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_PSE_ENABLE_DISABLE_PIN_ACTIVE:
+		return "Disable pin active";
+	default:
+		return "unsupported";
+	}
+}
+
+static const char *c33_pse_ext_substate_option_detect_ted_name(u32 val)
+{
+	switch (val) {
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_DET_IN_PROCESS:
+		return "Detection in process";
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_CONNECTION_CHECK_ERROR:
+		return "Connection check error";
+	default:
+		return "unsupported";
+	}
+}
+
+static const char *c33_pse_ext_substate_option_vport_lim_name(u32 val)
+{
+	switch (val) {
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_HIGH_VOLTAGE:
+		return "Main supply voltage is high";
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_LOW_VOLTAGE:
+		return "Main supply voltage is low";
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_VOLTAGE_INJECTION:
+		return "Voltage injection into the port";
+	default:
+		return "unsupported";
+	}
+}
+
+static const char *c33_pse_ext_substate_ovld_detected_name(u32 val)
+{
+	switch (val) {
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_OVLD_DETECTED_OVERLOAD:
+		return "Overload state";
+	default:
+		return "unsupported";
+	}
+}
+
+static const char *c33_pse_ext_substate_power_not_available_name(u32 val)
+{
+	switch (val) {
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_BUDGET_EXCEEDED:
+		return "Power budget exceeded for the controller";
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PORT_PW_LIMIT_EXCEEDS_CONTROLLER_BUDGET:
+		return "Configured port power limit exceeded controller power budget";
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PD_REQUEST_EXCEEDS_PORT_LIMIT:
+		return "Power request from PD exceeds port limit";
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_HW_PW_LIMIT:
+		return "Power denied due to Hardware power limit";
+	default:
+		return "unsupported";
+	}
+}
+
+static const char *c33_pse_ext_substate_short_detected_name(u32 val)
+{
+	switch (val) {
+	case ETHTOOL_C33_PSE_EXT_SUBSTATE_SHORT_DETECTED_SHORT_CONDITION:
+		return "Short condition was detected";
+	default:
+		return "unsupported";
+	}
+}
+
+struct c33_pse_ext_substate_desc {
+	u32 state;
+	const char *(*substate_name)(u32 val);
+};
+
+static const struct c33_pse_ext_substate_desc c33_pse_ext_substate_map[] = {
+	{ ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+	  c33_pse_ext_substate_error_condition_name },
+	{ ETHTOOL_C33_PSE_EXT_STATE_MR_MPS_VALID,
+	  c33_pse_ext_substate_mr_mps_valid_name },
+	{ ETHTOOL_C33_PSE_EXT_STATE_MR_PSE_ENABLE,
+	  c33_pse_ext_substate_mr_pse_enable_name },
+	{ ETHTOOL_C33_PSE_EXT_STATE_OPTION_DETECT_TED,
+	  c33_pse_ext_substate_option_detect_ted_name },
+	{ ETHTOOL_C33_PSE_EXT_STATE_OPTION_VPORT_LIM,
+	  c33_pse_ext_substate_option_vport_lim_name },
+	{ ETHTOOL_C33_PSE_EXT_STATE_OVLD_DETECTED,
+	  c33_pse_ext_substate_ovld_detected_name },
+	{ ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE,
+	  c33_pse_ext_substate_power_not_available_name },
+	{ ETHTOOL_C33_PSE_EXT_STATE_SHORT_DETECTED,
+	  c33_pse_ext_substate_short_detected_name },
+	{ /* sentinel */ }
+};
+
+static void c33_pse_print_ext_substate(u32 state, u32 substate)
+{
+	const struct c33_pse_ext_substate_desc *substate_map;
+
+	substate_map = c33_pse_ext_substate_map;
+	while (substate_map->state) {
+		if (substate_map->state == state) {
+			print_string(PRINT_ANY, "c33-pse-extended-substate",
+				     "Clause 33 PSE Extended Substate: %s\n",
+				     substate_map->substate_name(substate));
+			return;
+		}
+		substate_map++;
+	}
+}
+
+static int c33_pse_dump_pw_limit_range(const struct nlattr *range)
+{
+	const struct nlattr *range_tb[ETHTOOL_A_C33_PSE_PW_LIMIT_MAX + 1] = {};
+	DECLARE_ATTR_TB_INFO(range_tb);
+	const struct nlattr *attr;
+	u32 min, max;
+	int ret;
+
+	ret = mnl_attr_parse_nested(range, attr_cb, &range_tb_info);
+	if (ret < 0) {
+		fprintf(stderr,
+			"malformed netlink message (power limit range)\n");
+		return 1;
+	}
+
+	attr = range_tb[ETHTOOL_A_C33_PSE_PW_LIMIT_MIN];
+	if (!attr || mnl_attr_validate(attr, MNL_TYPE_U32) < 0) {
+		fprintf(stderr,
+			"malformed netlink message (power limit min)\n");
+		return 1;
+	}
+	min = mnl_attr_get_u32(attr);
+
+	attr = range_tb[ETHTOOL_A_C33_PSE_PW_LIMIT_MAX];
+	if (!attr || mnl_attr_validate(attr, MNL_TYPE_U32) < 0) {
+		fprintf(stderr,
+			"malformed netlink message (power limit max)\n");
+		return 1;
+	}
+	max = mnl_attr_get_u32(attr);
+
+	print_string(PRINT_ANY, "range", "\trange:\n", NULL);
+	print_uint(PRINT_ANY, "min", "\t\tmin %u\n", min);
+	print_uint(PRINT_ANY, "max", "\t\tmax %u\n", max);
+	return 0;
+}
+
 int pse_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 {
 	const struct nlattr *tb[ETHTOOL_A_PSE_MAX + 1] = {};
 	struct nl_context *nlctx = data;
+	const struct nlattr *attr;
 	DECLARE_ATTR_TB_INFO(tb);
 	bool silent;
 	int err_ret;
@@ -151,6 +367,59 @@ int pse_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 			     c33_pse_pw_d_status_name(val));
 	}
 
+	if (tb[ETHTOOL_A_C33_PSE_EXT_STATE]) {
+		u32 val;
+
+		val = mnl_attr_get_u32(tb[ETHTOOL_A_C33_PSE_EXT_STATE]);
+		print_string(PRINT_ANY, "c33-pse-extended-state",
+			     "Clause 33 PSE Extended State: %s\n",
+			     c33_pse_ext_state_name(val));
+
+		if (tb[ETHTOOL_A_C33_PSE_EXT_SUBSTATE]) {
+			u32 substate;
+
+			substate = mnl_attr_get_u32(tb[ETHTOOL_A_C33_PSE_EXT_SUBSTATE]);
+			c33_pse_print_ext_substate(val, substate);
+		}
+	}
+
+	if (tb[ETHTOOL_A_C33_PSE_PW_CLASS]) {
+		u32 val;
+
+		val = mnl_attr_get_u32(tb[ETHTOOL_A_C33_PSE_PW_CLASS]);
+		print_uint(PRINT_ANY, "c33-pse-power-class",
+			   "Clause 33 PSE Power Class: %u\n", val);
+	}
+
+	if (tb[ETHTOOL_A_C33_PSE_ACTUAL_PW]) {
+		u32 val;
+
+		val = mnl_attr_get_u32(tb[ETHTOOL_A_C33_PSE_ACTUAL_PW]);
+		print_uint(PRINT_ANY, "c33-pse-actual-power",
+			   "Clause 33 PSE Actual Power: %u\n", val);
+	}
+
+	if (tb[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT]) {
+		u32 val;
+
+		val = mnl_attr_get_u32(tb[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT]);
+		print_uint(PRINT_ANY, "c33-pse-available-power-limit",
+			   "Clause 33 PSE Available Power Limit: %u\n", val);
+	}
+
+	if (tb[ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES]) {
+		print_string(PRINT_ANY, "c33-pse-power-limit-ranges",
+			     "Clause 33 PSE Power Limit Ranges:\n", NULL);
+		mnl_attr_for_each(attr, nlhdr, GENL_HDRLEN) {
+			if (mnl_attr_get_type(attr) == ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES) {
+				if (c33_pse_dump_pw_limit_range(attr)) {
+					close_json_object();
+					return err_ret;
+				}
+			}
+		}
+	}
+
 	close_json_object();
 
 	return MNL_CB_OK;
@@ -212,6 +481,12 @@ static const struct param_parser spse_params[] = {
 		.handler_data	= c33_pse_admin_control_values,
 		.min_argc	= 1,
 	},
+	{
+		.arg		= "c33-pse-avail-pw-limit",
+		.type		= ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
 	{}
 };
 

-- 
2.34.1


