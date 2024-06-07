Return-Path: <netdev+bounces-101704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618AF8FFD20
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3C81C20621
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396E51552E6;
	Fri,  7 Jun 2024 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D47WZkx/"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE8019D89B;
	Fri,  7 Jun 2024 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745442; cv=none; b=rlsDFpsl3UpcVNEtbpEQcnGSEFG0xHsKT2O74cLHvKc8KKCYL33x1hsd3pz2fPyQ9Z/b9Zvg7I1UpLn+l/83aMyg8q4DAjnH9hsJmezpd2S1Igi0UQhOU3mhLoBukSQBxxS1MOJz2vVfTIwLCJnFPCDH09CR+PA6Mne5FO+m1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745442; c=relaxed/simple;
	bh=XA7yXs98tBR+Y72hp0dM3tOORuRzx+vjQf+FlpZQy2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=awxMWIT/xHGdlxlk9MCRdsv+hIyjNYfUHqc4yvrODFWqsocZjXHjzczpIgh5XtGUswkv4ngF+CglHzF672sRXUqj9Ihy2ZReiIhoCv9K4gO24J6CvXUcFS8fwiuBXLtxSrQceClG5Q4F8uypMqT7N6Hvsz9SNYvhGU7GJa9giuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D47WZkx/; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC32640011;
	Fri,  7 Jun 2024 07:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717745438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VeJW7JHQpWdY0KjL1cAtvzlXlZZ8Tp/iJj/ay+emhQ=;
	b=D47WZkx/MwCxy0DNinourWkr4Nzke5EvAZ487X6zJtNuoHLvgKO+zbOywNzFwTc0bEgsII
	K4fAdeB9Q+mIRIjr/gwTg5Np8MCnU44W4+7N9jFFXh28v4P/cIATg91Bo1VeTgh7OBEG4D
	tQYfiaAVLyR/iZ5Co5vdw8qCy94UlURTfMwiH2z0a9QAYq1XKAeNTJLrXbVj4SpIePfUhB
	Rtr2gIOQHEI/vA6AHPz9+CXa4NC+iuP9/igbSlJ5Y38yGHcLQBMMQqfGJG4SSS3/vsZ7Mr
	9gQWHh1OomVJEIrmKSygIC0ouLSTcBgkINDBaY+97dvMugw+/eYbulYkzuCabw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 07 Jun 2024 09:30:19 +0200
Subject: [PATCH net-next v2 2/8] net: ethtool: pse-pd: Expand C33 PSE
 status with class, power and extended state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-feature_poe_power_cap-v2-2-c03c2deb83ab@bootlin.com>
References: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
In-Reply-To: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>

This update expands the status information provided by ethtool for PSE c33.
It includes details such as the detected class, current power delivered,
and extended state information.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Move on PSE string error messages to ETHTOOL_LINK_EXT_STATE and
  ETHTOOL_LINK_EXT_SUBSTATE with fixed enumeration in aim to unify
  interface diagnostic.
---
 include/linux/ethtool.h              | 11 ++++++++++
 include/linux/pse-pd/pse.h           |  8 +++++++
 include/uapi/linux/ethtool.h         | 41 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ethtool_netlink.h |  4 ++++
 net/ethtool/pse-pd.c                 | 29 ++++++++++++++++++++++++-
 5 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 6fd9107d3cc0..1a0c8d6a22a0 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1155,4 +1155,15 @@ struct ethtool_forced_speed_map {
 
 void
 ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size);
+
+/* C33 PSE extended state and substate. */
+struct ethtool_c33_pse_ext_state_info {
+	enum ethtool_c33_pse_ext_state c33_pse_ext_state;
+	union {
+		enum ethtool_c33_pse_ext_substate_voltage_issue voltage_issue;
+		enum ethtool_c33_pse_ext_substate_current_issue current_issue;
+		enum ethtool_c33_pse_ext_substate_config config;
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
index 8733a3117902..ef65ad4612d2 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -752,6 +752,47 @@ enum ethtool_module_power_mode {
 	ETHTOOL_MODULE_POWER_MODE_HIGH,
 };
 
+/* C33 PSE extended state */
+enum ethtool_c33_pse_ext_state {
+	ETHTOOL_C33_PSE_EXT_STATE_UNKNOWN = 1,
+	ETHTOOL_C33_PSE_EXT_STATE_DETECTION,
+	ETHTOOL_C33_PSE_EXT_STATE_CLASSIFICATION_FAILURE,
+	ETHTOOL_C33_PSE_EXT_STATE_HARDWARE_ISSUE,
+	ETHTOOL_C33_PSE_EXT_STATE_VOLTAGE_ISSUE,
+	ETHTOOL_C33_PSE_EXT_STATE_CURRENT_ISSUE,
+	ETHTOOL_C33_PSE_EXT_STATE_POWER_BUDGET_EXCEEDED,
+	ETHTOOL_C33_PSE_EXT_STATE_CONFIG,
+	ETHTOOL_C33_PSE_EXT_STATE_TEMP_ISSUE,
+};
+
+/* More information in addition to ETHTOOL_C33_PSE_EXT_STATE_DETECTION. */
+enum ethtool_c33_pse_ext_substate_detection {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_DET_IN_PROGRESS = 1,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_DET_FAILURE,
+};
+
+/* More information in addition to ETHTOOL_C33_PSE_EXT_STATE_VOLTAGE_ISSUE. */
+enum ethtool_c33_pse_ext_substate_voltage_issue {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_V_INJECTION = 1,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_V_SHORT_DETECTED,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_V_OVERVOLTAGE,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_V_UNDERVOLTAGE,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_V_OPEN,
+};
+
+/* More information in addition to ETHTOOL_C33_PSE_EXT_STATE_CURRENT_ISSUE. */
+enum ethtool_c33_pse_ext_substate_current_issue {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_CRT_OVERLOAD = 1,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_CRT_UNDERLOAD,
+};
+
+/* More information in addition to ETHTOOL_C33_PSE_EXT_STATE_CONFIG.
+ */
+enum ethtool_c33_pse_ext_substate_config {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_CFG_CHANGED = 1,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_CFG_UNDEFINED,
+};
+
 /**
  * enum ethtool_pse_types - Types of PSE controller.
  * @ETHTOOL_PSE_UNKNOWN: Type of PSE controller is unknown
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index b49b804b9495..ccbe8294dfd5 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -915,6 +915,10 @@ enum {
 	ETHTOOL_A_C33_PSE_ADMIN_STATE,		/* u32 */
 	ETHTOOL_A_C33_PSE_ADMIN_CONTROL,	/* u32 */
 	ETHTOOL_A_C33_PSE_PW_D_STATUS,		/* u32 */
+	ETHTOOL_A_C33_PSE_PW_CLASS,		/* u32 */
+	ETHTOOL_A_C33_PSE_ACTUAL_PW,		/* u32 */
+	ETHTOOL_A_C33_PSE_EXT_STATE,		/* u8 */
+	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,		/* u8 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PSE_CNT,
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 2c981d443f27..3d74cfe7765b 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -86,7 +86,14 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 		len += nla_total_size(sizeof(u32)); /* _C33_PSE_ADMIN_STATE */
 	if (st->c33_pw_status > 0)
 		len += nla_total_size(sizeof(u32)); /* _C33_PSE_PW_D_STATUS */
-
+	if (st->c33_pw_class > 0)
+		len += nla_total_size(sizeof(u32)); /* _C33_PSE_PW_CLASS */
+	if (st->c33_actual_pw > 0)
+		len += nla_total_size(sizeof(u32)); /* _C33_PSE_ACTUAL_PW */
+	if (st->c33_ext_state_info.c33_pse_ext_state)
+		len += nla_total_size(sizeof(u8)); /* _C33_PSE_EXT_STATE */
+	if (st->c33_ext_state_info.__c33_pse_ext_substate)
+		len += nla_total_size(sizeof(u8)); /* _C33_PSE_EXT_SUBSTATE */
 	return len;
 }
 
@@ -117,6 +124,26 @@ static int pse_fill_reply(struct sk_buff *skb,
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
+	if (st->c33_ext_state_info.c33_pse_ext_state > 0 &&
+	    nla_put_u8(skb, ETHTOOL_A_C33_PSE_EXT_STATE,
+		       st->c33_ext_state_info.c33_pse_ext_state))
+		return -EMSGSIZE;
+
+	if (st->c33_ext_state_info.__c33_pse_ext_substate > 0 &&
+	    nla_put_u8(skb, ETHTOOL_A_C33_PSE_EXT_SUBSTATE,
+		       st->c33_ext_state_info.__c33_pse_ext_substate))
+		return -EMSGSIZE;
+
 	return 0;
 }
 

-- 
2.34.1


