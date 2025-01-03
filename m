Return-Path: <netdev+bounces-155076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAADA00F58
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CD71884B9D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4230C1C5F06;
	Fri,  3 Jan 2025 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e9p/RJAm"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941F31C549E;
	Fri,  3 Jan 2025 21:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938839; cv=none; b=lLnXmmrSJ8x7t5tNb1jZEg9xqoRpZCvIjosnPupR3Sn4Ub97+TEXrYpx287PAQJKT7MymOzVNKX5c4S5LirhJ/NZOI9h4tKgG+cVI6T/A5vvHIUKXDbqKudHQnYNjS3pvNfNJKyrV9pJjkU7cf1FLbV8z8mDXKK8iSUUDiwoGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938839; c=relaxed/simple;
	bh=Qp38QYybNczoa3SSjopEHp8smwUqeoLZZrXuxy8RiYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=to1H3fBF1pE3N8Rd+VgYN0rhBsAsD0wbU2ZghZC6pT1Am6Mri9ueZdiOE67BC0OX0EFvbV+tA3WC0amyBQp8v/xuoBCr0XWTLst6zLaa6/OaxylDePiwKRAYsy5bu0NMIQK135ImQ1ji5y5AONcwpzRez15XM0KSaNLvdQKbofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e9p/RJAm; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3928FFF802;
	Fri,  3 Jan 2025 21:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735938834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54qNTGj6kxMaF+ETUzvEkJH8KRuUxw4jkLAZ1mD1xLI=;
	b=e9p/RJAmKBSNxeBnFS4NEAWwN1aKbLE/H+XeB5aJ9c0gLz1h0tyjoSj5S8kBNtVDV+o2yH
	B8YsorN2xbwp85cXDZQZwE4XcK7H8PXpOCEV/ZUKg2/d3+zfA2j8k0jyeYIMIg6tOYwEyf
	gE4+i2vPigwwWrxBpPmnWwXOAvkL/IetGe22we3J97XL3iGlJZYIqyTp+2+83oYuyfhiHk
	W29J5c1m2iPxu+RI8YVU9Rv0N0ds0stcIYtAInKm936T+tkFio9RKtEInb/GeoS9XtPHE9
	bpK+4uhavQlLxfE/Fi6kYcr8cGMe4PN9kEz3PFT+SYaq3ChsILXQKq15NJZYqQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Jan 2025 22:12:57 +0100
Subject: [PATCH net-next v4 08/27] net: pse-pd: Split ethtool_get_status
 into multiple callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-feature_poe_port_prio-v4-8-dc91a3c0c187@bootlin.com>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
In-Reply-To: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

The ethtool_get_status callback currently handles all status and PSE
information within a single function. This approach has two key
drawbacks:

1. If the core requires some information for purposes other than
   ethtool_get_status, redundant code will be needed to fetch the same
   data from the driver (like is_enabled).

2. Drivers currently have access to all information passed to ethtool.
   New variables will soon be added to ethtool status, such as PSE ID,
   power domain IDs, and budget evaluation strategies, which are meant
   to be managed solely by the core. Drivers should not have the ability
   to modify these variables.

To resolve these issues, ethtool_get_status has been split into multiple
callbacks, with each handling a specific piece of information required
by ethtool or the core.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v4:
- New patch
---
 drivers/net/pse-pd/pd692x0.c       | 153 ++++++++++++++++++++++++++-----------
 drivers/net/pse-pd/pse_core.c      |  83 +++++++++++++++++---
 drivers/net/pse-pd/pse_regulator.c |  26 +++++--
 drivers/net/pse-pd/tps23881.c      |  60 +++++++++++----
 include/linux/ethtool.h            |  36 +++++++++
 include/linux/pse-pd/pse.h         |  87 +++++++++++++--------
 net/ethtool/pse-pd.c               |   8 +-
 7 files changed, 341 insertions(+), 112 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 9f00538f7e45..da5d09ed628a 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -517,21 +517,38 @@ pd692x0_pse_ext_state_map[] = {
 	{ /* sentinel */ }
 };
 
-static void
-pd692x0_get_ext_state(struct ethtool_c33_pse_ext_state_info *c33_ext_state_info,
-		      u32 status_code)
+static int
+pd692x0_pi_get_ext_state(struct pse_controller_dev *pcdev, int id,
+			 struct pse_ext_state_info *ext_state_info)
 {
+	struct ethtool_c33_pse_ext_state_info *c33_ext_state_info;
 	const struct pd692x0_pse_ext_state_mapping *ext_state_map;
+	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
+	struct pd692x0_msg msg, buf = {0};
+	int ret;
+
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		return ret;
 
+	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_STATUS];
+	msg.sub[2] = id;
+	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
+	if (ret < 0)
+		return ret;
+
+	c33_ext_state_info = &ext_state_info->c33_ext_state_info;
 	ext_state_map = pd692x0_pse_ext_state_map;
 	while (ext_state_map->status_code) {
-		if (ext_state_map->status_code == status_code) {
+		if (ext_state_map->status_code == buf.sub[0]) {
 			c33_ext_state_info->c33_pse_ext_state = ext_state_map->pse_ext_state;
 			c33_ext_state_info->__c33_pse_ext_substate = ext_state_map->pse_ext_substate;
-			return;
+			return  0;
 		}
 		ext_state_map++;
 	}
+
+	return 0;
 }
 
 struct pd692x0_class_pw {
@@ -613,35 +630,36 @@ static int pd692x0_pi_set_pw_from_table(struct device *dev,
 }
 
 static int
-pd692x0_pi_get_pw_ranges(struct pse_control_status *st)
+pd692x0_pi_get_pw_limit_ranges(struct pse_controller_dev *pcdev, int id,
+			       struct pse_pw_limit_ranges *pw_limit_ranges)
 {
+	struct ethtool_c33_pse_pw_limit_range *c33_pw_limit_ranges;
 	const struct pd692x0_class_pw *pw_table;
 	int i;
 
 	pw_table = pd692x0_class_pw_table;
-	st->c33_pw_limit_ranges = kcalloc(PD692X0_CLASS_PW_TABLE_SIZE,
-					  sizeof(struct ethtool_c33_pse_pw_limit_range),
-					  GFP_KERNEL);
-	if (!st->c33_pw_limit_ranges)
+	c33_pw_limit_ranges = kcalloc(PD692X0_CLASS_PW_TABLE_SIZE,
+				      sizeof(*c33_pw_limit_ranges),
+				      GFP_KERNEL);
+	if (!c33_pw_limit_ranges)
 		return -ENOMEM;
 
 	for (i = 0; i < PD692X0_CLASS_PW_TABLE_SIZE; i++, pw_table++) {
-		st->c33_pw_limit_ranges[i].min = pw_table->class_pw;
-		st->c33_pw_limit_ranges[i].max = pw_table->class_pw + pw_table->max_added_class_pw;
+		c33_pw_limit_ranges[i].min = pw_table->class_pw;
+		c33_pw_limit_ranges[i].max = pw_table->class_pw +
+					     pw_table->max_added_class_pw;
 	}
 
-	st->c33_pw_limit_nb_ranges = i;
-	return 0;
+	pw_limit_ranges->c33_pw_limit_ranges = c33_pw_limit_ranges;
+	return i;
 }
 
-static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
-				      unsigned long id,
-				      struct netlink_ext_ack *extack,
-				      struct pse_control_status *status)
+static int
+pd692x0_pi_get_admin_state(struct pse_controller_dev *pcdev, int id,
+			   struct pse_admin_state *admin_state)
 {
 	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
 	struct pd692x0_msg msg, buf = {0};
-	u32 class;
 	int ret;
 
 	ret = pd692x0_fw_unavailable(priv);
@@ -654,39 +672,65 @@ static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 	if (ret < 0)
 		return ret;
 
-	/* Compare Port Status (Communication Protocol Document par. 7.1) */
-	if ((buf.sub[0] & 0xf0) == 0x80 || (buf.sub[0] & 0xf0) == 0x90)
-		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
-	else if (buf.sub[0] == 0x1b || buf.sub[0] == 0x22)
-		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING;
-	else if (buf.sub[0] == 0x12)
-		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_FAULT;
-	else
-		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED;
-
 	if (buf.sub[1])
-		status->c33_admin_state = ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
+		admin_state->c33_admin_state =
+			ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
 	else
-		status->c33_admin_state = ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
+		admin_state->c33_admin_state =
+			ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
 
-	priv->admin_state[id] = status->c33_admin_state;
+	priv->admin_state[id] = admin_state->c33_admin_state;
 
-	pd692x0_get_ext_state(&status->c33_ext_state_info, buf.sub[0]);
-	status->c33_actual_pw = (buf.data[0] << 4 | buf.data[1]) * 100;
+	return 0;
+}
 
-	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_PARAM];
+static int
+pd692x0_pi_get_pw_status(struct pse_controller_dev *pcdev, int id,
+			 struct pse_pw_status *pw_status)
+{
+	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
+	struct pd692x0_msg msg, buf = {0};
+	int ret;
+
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		return ret;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_STATUS];
 	msg.sub[2] = id;
-	memset(&buf, 0, sizeof(buf));
 	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
 	if (ret < 0)
 		return ret;
 
-	ret = pd692x0_pi_get_pw_from_table(buf.data[0], buf.data[1]);
-	if (ret < 0)
+	/* Compare Port Status (Communication Protocol Document par. 7.1) */
+	if ((buf.sub[0] & 0xf0) == 0x80 || (buf.sub[0] & 0xf0) == 0x90)
+		pw_status->c33_pw_status =
+			ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
+	else if (buf.sub[0] == 0x1b || buf.sub[0] == 0x22)
+		pw_status->c33_pw_status =
+			ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING;
+	else if (buf.sub[0] == 0x12)
+		pw_status->c33_pw_status =
+			ETHTOOL_C33_PSE_PW_D_STATUS_FAULT;
+	else
+		pw_status->c33_pw_status =
+			ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED;
+
+	return 0;
+}
+
+static int
+pd692x0_pi_get_pw_class(struct pse_controller_dev *pcdev, int id)
+{
+	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
+	struct pd692x0_msg msg, buf = {0};
+	u32 class;
+	int ret;
+
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
 		return ret;
-	status->c33_avail_pw_limit = ret;
 
-	memset(&buf, 0, sizeof(buf));
 	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_CLASS];
 	msg.sub[2] = id;
 	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
@@ -695,13 +739,29 @@ static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 
 	class = buf.data[3] >> 4;
 	if (class <= 8)
-		status->c33_pw_class = class;
+		return class;
+
+	return 0;
+}
+
+static int
+pd692x0_pi_get_actual_pw(struct pse_controller_dev *pcdev, int id)
+{
+	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
+	struct pd692x0_msg msg, buf = {0};
+	int ret;
+
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		return ret;
 
-	ret = pd692x0_pi_get_pw_ranges(status);
+	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_STATUS];
+	msg.sub[2] = id;
+	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
 	if (ret < 0)
 		return ret;
 
-	return 0;
+	return (buf.data[0] << 4 | buf.data[1]) * 100;
 }
 
 static struct pd692x0_msg_ver pd692x0_get_sw_version(struct pd692x0_priv *priv)
@@ -1038,13 +1098,18 @@ static int pd692x0_pi_set_pw_limit(struct pse_controller_dev *pcdev,
 
 static const struct pse_controller_ops pd692x0_ops = {
 	.setup_pi_matrix = pd692x0_setup_pi_matrix,
-	.ethtool_get_status = pd692x0_ethtool_get_status,
+	.pi_get_admin_state = pd692x0_pi_get_admin_state,
+	.pi_get_pw_status = pd692x0_pi_get_pw_status,
+	.pi_get_ext_state = pd692x0_pi_get_ext_state,
+	.pi_get_pw_class = pd692x0_pi_get_pw_class,
+	.pi_get_actual_pw = pd692x0_pi_get_actual_pw,
 	.pi_enable = pd692x0_pi_enable,
 	.pi_disable = pd692x0_pi_disable,
 	.pi_is_enabled = pd692x0_pi_is_enabled,
 	.pi_get_voltage = pd692x0_pi_get_voltage,
 	.pi_get_pw_limit = pd692x0_pi_get_pw_limit,
 	.pi_set_pw_limit = pd692x0_pi_set_pw_limit,
+	.pi_get_pw_limit_ranges = pd692x0_pi_get_pw_limit_ranges,
 };
 
 #define PD692X0_FW_LINE_MAX_SZ 0xff
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index ae819bfed1b1..5f2a9f36e4ed 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -443,6 +443,13 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	if (!pcdev->nr_lines)
 		pcdev->nr_lines = 1;
 
+	if (!pcdev->ops->pi_get_admin_state ||
+	    !pcdev->ops->pi_get_pw_status) {
+		dev_err(pcdev->dev,
+			"Mandatory status report callbacks are missing");
+		return -EINVAL;
+	}
+
 	ret = of_load_pse_pis(pcdev);
 	if (ret)
 		return ret;
@@ -745,25 +752,81 @@ EXPORT_SYMBOL_GPL(of_pse_control_get);
  */
 int pse_ethtool_get_status(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
-			   struct pse_control_status *status)
+			   struct ethtool_pse_control_status *status)
 {
+	struct pse_admin_state admin_state = {0};
+	struct pse_pw_status pw_status = {0};
 	const struct pse_controller_ops *ops;
 	struct pse_controller_dev *pcdev;
-	int err;
+	int ret;
 
 	pcdev = psec->pcdev;
 	ops = pcdev->ops;
-	if (!ops->ethtool_get_status) {
-		NL_SET_ERR_MSG(extack,
-			       "PSE driver does not support status report");
-		return -EOPNOTSUPP;
+	mutex_lock(&pcdev->lock);
+	ret = ops->pi_get_admin_state(pcdev, psec->id, &admin_state);
+	if (ret)
+		goto out;
+	status->podl_admin_state = admin_state.podl_admin_state;
+	status->c33_admin_state = admin_state.c33_admin_state;
+
+	ret = ops->pi_get_pw_status(pcdev, psec->id, &pw_status);
+	if (ret)
+		goto out;
+	status->podl_pw_status = pw_status.podl_pw_status;
+	status->c33_pw_status = pw_status.c33_pw_status;
+
+	if (ops->pi_get_ext_state) {
+		struct pse_ext_state_info ext_state_info = {0};
+
+		ret = ops->pi_get_ext_state(pcdev, psec->id,
+					    &ext_state_info);
+		if (ret)
+			goto out;
+
+		memcpy(&status->c33_ext_state_info,
+		       &ext_state_info.c33_ext_state_info,
+		       sizeof(status->c33_ext_state_info));
 	}
 
-	mutex_lock(&pcdev->lock);
-	err = ops->ethtool_get_status(pcdev, psec->id, extack, status);
-	mutex_unlock(&pcdev->lock);
+	if (ops->pi_get_pw_class) {
+		ret = ops->pi_get_pw_class(pcdev, psec->id);
+		if (ret < 0)
+			goto out;
 
-	return err;
+		status->c33_pw_class = ret;
+	}
+
+	if (ops->pi_get_actual_pw) {
+		ret = ops->pi_get_actual_pw(pcdev, psec->id);
+		if (ret < 0)
+			goto out;
+
+		status->c33_actual_pw = ret;
+	}
+
+	if (ops->pi_get_pw_limit) {
+		ret = ops->pi_get_pw_limit(pcdev, psec->id);
+		if (ret < 0)
+			goto out;
+
+		status->c33_avail_pw_limit = ret;
+	}
+
+	if (ops->pi_get_pw_limit_ranges) {
+		struct pse_pw_limit_ranges pw_limit_ranges = {0};
+
+		ret = ops->pi_get_pw_limit_ranges(pcdev, psec->id,
+						  &pw_limit_ranges);
+		if (ret < 0)
+			goto out;
+
+		status->c33_pw_limit_ranges =
+			pw_limit_ranges.c33_pw_limit_ranges;
+		status->c33_pw_limit_nb_ranges = ret;
+	}
+out:
+	mutex_unlock(&psec->pcdev->lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pse_ethtool_get_status);
 
diff --git a/drivers/net/pse-pd/pse_regulator.c b/drivers/net/pse-pd/pse_regulator.c
index 64ab36974fe0..86360056b2f5 100644
--- a/drivers/net/pse-pd/pse_regulator.c
+++ b/drivers/net/pse-pd/pse_regulator.c
@@ -60,9 +60,19 @@ pse_reg_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
 }
 
 static int
-pse_reg_ethtool_get_status(struct pse_controller_dev *pcdev, unsigned long id,
-			   struct netlink_ext_ack *extack,
-			   struct pse_control_status *status)
+pse_reg_pi_get_admin_state(struct pse_controller_dev *pcdev, int id,
+			   struct pse_admin_state *admin_state)
+{
+	struct pse_reg_priv *priv = to_pse_reg(pcdev);
+
+	admin_state->podl_admin_state = priv->admin_state;
+
+	return 0;
+}
+
+static int
+pse_reg_pi_get_pw_status(struct pse_controller_dev *pcdev, int id,
+			 struct pse_pw_status *pw_status)
 {
 	struct pse_reg_priv *priv = to_pse_reg(pcdev);
 	int ret;
@@ -72,18 +82,18 @@ pse_reg_ethtool_get_status(struct pse_controller_dev *pcdev, unsigned long id,
 		return ret;
 
 	if (!ret)
-		status->podl_pw_status = ETHTOOL_PODL_PSE_PW_D_STATUS_DISABLED;
+		pw_status->podl_pw_status =
+			ETHTOOL_PODL_PSE_PW_D_STATUS_DISABLED;
 	else
-		status->podl_pw_status =
+		pw_status->podl_pw_status =
 			ETHTOOL_PODL_PSE_PW_D_STATUS_DELIVERING;
 
-	status->podl_admin_state = priv->admin_state;
-
 	return 0;
 }
 
 static const struct pse_controller_ops pse_reg_ops = {
-	.ethtool_get_status = pse_reg_ethtool_get_status,
+	.pi_get_admin_state = pse_reg_pi_get_admin_state,
+	.pi_get_pw_status = pse_reg_pi_get_pw_status,
 	.pi_enable = pse_reg_pi_enable,
 	.pi_is_enabled = pse_reg_pi_is_enabled,
 	.pi_disable = pse_reg_pi_disable,
diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index b87c391ae0f5..f735b6917f8b 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -201,14 +201,13 @@ static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
 	return enabled;
 }
 
-static int tps23881_ethtool_get_status(struct pse_controller_dev *pcdev,
-				       unsigned long id,
-				       struct netlink_ext_ack *extack,
-				       struct pse_control_status *status)
+static int
+tps23881_pi_get_admin_state(struct pse_controller_dev *pcdev, int id,
+			    struct pse_admin_state *admin_state)
 {
 	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
 	struct i2c_client *client = priv->client;
-	bool enabled, delivering;
+	bool enabled;
 	u8 chan;
 	u16 val;
 	int ret;
@@ -220,28 +219,56 @@ static int tps23881_ethtool_get_status(struct pse_controller_dev *pcdev,
 	chan = priv->port[id].chan[0];
 	val = tps23881_calc_val(ret, chan, 0, BIT(chan % 4));
 	enabled = !!(val);
-	val = tps23881_calc_val(ret, chan, 4, BIT(chan % 4));
-	delivering = !!(val);
 
 	if (priv->port[id].is_4p) {
 		chan = priv->port[id].chan[1];
 		val = tps23881_calc_val(ret, chan, 0, BIT(chan % 4));
 		enabled &= !!(val);
+	}
+
+	/* Return enabled status only if both channel are on this state */
+	if (enabled)
+		admin_state->c33_admin_state =
+			ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
+	else
+		admin_state->c33_admin_state =
+			ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
+
+	return 0;
+}
+
+static int
+tps23881_pi_get_pw_status(struct pse_controller_dev *pcdev, int id,
+			  struct pse_pw_status *pw_status)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	struct i2c_client *client = priv->client;
+	bool delivering;
+	u8 chan;
+	u16 val;
+	int ret;
+
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_PW_STATUS);
+	if (ret < 0)
+		return ret;
+
+	chan = priv->port[id].chan[0];
+	val = tps23881_calc_val(ret, chan, 4, BIT(chan % 4));
+	delivering = !!(val);
+
+	if (priv->port[id].is_4p) {
+		chan = priv->port[id].chan[1];
 		val = tps23881_calc_val(ret, chan, 4, BIT(chan % 4));
 		delivering &= !!(val);
 	}
 
 	/* Return delivering status only if both channel are on this state */
 	if (delivering)
-		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
-	else
-		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED;
-
-	/* Return enabled status only if both channel are on this state */
-	if (enabled)
-		status->c33_admin_state = ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
+		pw_status->c33_pw_status =
+			ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
 	else
-		status->c33_admin_state = ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
+		pw_status->c33_pw_status =
+			ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED;
 
 	return 0;
 }
@@ -664,7 +691,8 @@ static const struct pse_controller_ops tps23881_ops = {
 	.pi_enable = tps23881_pi_enable,
 	.pi_disable = tps23881_pi_disable,
 	.pi_is_enabled = tps23881_pi_is_enabled,
-	.ethtool_get_status = tps23881_ethtool_get_status,
+	.pi_get_admin_state = tps23881_pi_get_admin_state,
+	.pi_get_pw_status = tps23881_pi_get_pw_status,
 };
 
 static const char fw_parity_name[] = "ti/tps23881/tps23881-parity-14.bin";
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f711bfd75c4d..2bdf7e72ee50 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1323,4 +1323,40 @@ struct ethtool_c33_pse_pw_limit_range {
 	u32 min;
 	u32 max;
 };
+
+/**
+ * struct ethtool_pse_control_status - PSE control/channel status.
+ *
+ * @podl_admin_state: operational state of the PoDL PSE
+ *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
+ * @podl_pw_status: power detection status of the PoDL PSE.
+ *	IEEE 802.3-2018 30.15.1.1.3 aPoDLPSEPowerDetectionStatus:
+ * @c33_admin_state: operational state of the PSE
+ *	functions. IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
+ * @c33_pw_status: power detection status of the PSE.
+ *	IEEE 802.3-2022 30.9.1.1.5 aPSEPowerDetectionStatus:
+ * @c33_pw_class: detected class of a powered PD
+ *	IEEE 802.3-2022 30.9.1.1.8 aPSEPowerClassification
+ * @c33_actual_pw: power currently delivered by the PSE in mW
+ *	IEEE 802.3-2022 30.9.1.1.23 aPSEActualPower
+ * @c33_ext_state_info: extended state information of the PSE
+ * @c33_avail_pw_limit: available power limit of the PSE in mW
+ *	IEEE 802.3-2022 145.2.5.4 pse_avail_pwr
+ * @c33_pw_limit_ranges: supported power limit configuration range. The driver
+ *	is in charge of the memory allocation
+ * @c33_pw_limit_nb_ranges: number of supported power limit configuration
+ *	ranges
+ */
+struct ethtool_pse_control_status {
+	enum ethtool_podl_pse_admin_state podl_admin_state;
+	enum ethtool_podl_pse_pw_d_status podl_pw_status;
+	enum ethtool_c33_pse_admin_state c33_admin_state;
+	enum ethtool_c33_pse_pw_d_status c33_pw_status;
+	u32 c33_pw_class;
+	u32 c33_actual_pw;
+	struct ethtool_c33_pse_ext_state_info c33_ext_state_info;
+	u32 c33_avail_pw_limit;
+	struct ethtool_c33_pse_pw_limit_range *c33_pw_limit_ranges;
+	u32 c33_pw_limit_nb_ranges;
+};
 #endif /* _LINUX_ETHTOOL_H */
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index a721651cd1e0..db8b3db7b849 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -31,60 +31,84 @@ struct pse_control_config {
 };
 
 /**
- * struct pse_control_status - PSE control/channel status.
+ * struct pse_admin_state - PSE operational state
  *
  * @podl_admin_state: operational state of the PoDL PSE
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
- * @podl_pw_status: power detection status of the PoDL PSE.
- *	IEEE 802.3-2018 30.15.1.1.3 aPoDLPSEPowerDetectionStatus:
  * @c33_admin_state: operational state of the PSE
  *	functions. IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
+ */
+struct pse_admin_state {
+	enum ethtool_podl_pse_admin_state podl_admin_state;
+	enum ethtool_c33_pse_admin_state c33_admin_state;
+};
+
+/**
+ * struct pse_pw_status - PSE power detection status
+ *
+ * @podl_pw_status: power detection status of the PoDL PSE.
+ *	IEEE 802.3-2018 30.15.1.1.3 aPoDLPSEPowerDetectionStatus:
  * @c33_pw_status: power detection status of the PSE.
  *	IEEE 802.3-2022 30.9.1.1.5 aPSEPowerDetectionStatus:
- * @c33_pw_class: detected class of a powered PD
- *	IEEE 802.3-2022 30.9.1.1.8 aPSEPowerClassification
- * @c33_actual_pw: power currently delivered by the PSE in mW
- *	IEEE 802.3-2022 30.9.1.1.23 aPSEActualPower
- * @c33_ext_state_info: extended state information of the PSE
- * @c33_avail_pw_limit: available power limit of the PSE in mW
- *	IEEE 802.3-2022 145.2.5.4 pse_avail_pwr
- * @c33_pw_limit_ranges: supported power limit configuration range. The driver
- *	is in charge of the memory allocation.
- * @c33_pw_limit_nb_ranges: number of supported power limit configuration
- *	ranges
  */
-struct pse_control_status {
-	enum ethtool_podl_pse_admin_state podl_admin_state;
+struct pse_pw_status {
 	enum ethtool_podl_pse_pw_d_status podl_pw_status;
-	enum ethtool_c33_pse_admin_state c33_admin_state;
 	enum ethtool_c33_pse_pw_d_status c33_pw_status;
-	u32 c33_pw_class;
-	u32 c33_actual_pw;
+};
+
+/**
+ * struct pse_ext_state_info - PSE extended state information
+ *
+ * @c33_ext_state_info: extended state information of the PSE
+ */
+struct pse_ext_state_info {
 	struct ethtool_c33_pse_ext_state_info c33_ext_state_info;
-	u32 c33_avail_pw_limit;
+};
+
+/**
+ * struct pse_pw_limit_ranges - PSE power limit configuration range
+ *
+ * @c33_pw_limit_ranges: supported power limit configuration range. The driver
+ *			 is in charge of the memory allocation.
+ */
+struct pse_pw_limit_ranges {
 	struct ethtool_c33_pse_pw_limit_range *c33_pw_limit_ranges;
-	u32 c33_pw_limit_nb_ranges;
 };
 
 /**
  * struct pse_controller_ops - PSE controller driver callbacks
  *
- * @ethtool_get_status: get PSE control status for ethtool interface
  * @setup_pi_matrix: setup PI matrix of the PSE controller
+ * @pi_get_admin_state: Get the operational state of the PSE PI. This ops
+ *			is mandatory.
+ * @pi_get_pw_status: Get the power detection status of the PSE PI. This
+ *		      ops is mandatory.
+ * @pi_get_ext_state: Get the extended state of the PSE PI.
+ * @pi_get_pw_class: Get the power class of the PSE PI.
+ * @pi_get_actual_pw: Get actual power of the PSE PI in mW.
  * @pi_is_enabled: Return 1 if the PSE PI is enabled, 0 if not.
  *		   May also return negative errno.
  * @pi_enable: Configure the PSE PI as enabled.
  * @pi_disable: Configure the PSE PI as disabled.
  * @pi_get_voltage: Return voltage similarly to get_voltage regulator
- *		    callback.
- * @pi_get_pw_limit: Get the configured power limit of the PSE PI.
- * @pi_set_pw_limit: Configure the power limit of the PSE PI.
+ *		    callback in uV.
+ * @pi_get_pw_limit: Get the configured power limit of the PSE PI in mW.
+ * @pi_set_pw_limit: Configure the power limit of the PSE PI in mW.
+ * @pi_get_pw_limit_ranges: Get the supported power limit configuration
+ *			    range. The driver is in charge of the memory
+ *			    allocation and should return the number of
+ *			    ranges.
  */
 struct pse_controller_ops {
-	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
-		unsigned long id, struct netlink_ext_ack *extack,
-		struct pse_control_status *status);
 	int (*setup_pi_matrix)(struct pse_controller_dev *pcdev);
+	int (*pi_get_admin_state)(struct pse_controller_dev *pcdev, int id,
+				  struct pse_admin_state *admin_state);
+	int (*pi_get_pw_status)(struct pse_controller_dev *pcdev, int id,
+				struct pse_pw_status *pw_status);
+	int (*pi_get_ext_state)(struct pse_controller_dev *pcdev, int id,
+				struct pse_ext_state_info *ext_state_info);
+	int (*pi_get_pw_class)(struct pse_controller_dev *pcdev, int id);
+	int (*pi_get_actual_pw)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_is_enabled)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_enable)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_disable)(struct pse_controller_dev *pcdev, int id);
@@ -93,12 +117,15 @@ struct pse_controller_ops {
 			       int id);
 	int (*pi_set_pw_limit)(struct pse_controller_dev *pcdev,
 			       int id, int max_mW);
+	int (*pi_get_pw_limit_ranges)(struct pse_controller_dev *pcdev, int id,
+				      struct pse_pw_limit_ranges *pw_limit_ranges);
 };
 
 struct module;
 struct device_node;
 struct of_phandle_args;
 struct pse_control;
+struct ethtool_pse_control_status;
 
 /* PSE PI pairset pinout can either be Alternative A or Alternative B */
 enum pse_pi_pairset_pinout {
@@ -175,7 +202,7 @@ void pse_control_put(struct pse_control *psec);
 
 int pse_ethtool_get_status(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
-			   struct pse_control_status *status);
+			   struct ethtool_pse_control_status *status);
 int pse_ethtool_set_config(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
 			   const struct pse_control_config *config);
@@ -199,7 +226,7 @@ static inline void pse_control_put(struct pse_control *psec)
 
 static inline int pse_ethtool_get_status(struct pse_control *psec,
 					 struct netlink_ext_ack *extack,
-					 struct pse_control_status *status)
+					 struct ethtool_pse_control_status *status)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index a0705edca22a..2819e2ba6be2 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -19,7 +19,7 @@ struct pse_req_info {
 
 struct pse_reply_data {
 	struct ethnl_reply_data	base;
-	struct pse_control_status status;
+	struct ethtool_pse_control_status status;
 };
 
 #define PSE_REPDATA(__reply_base) \
@@ -80,7 +80,7 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 			  const struct ethnl_reply_data *reply_base)
 {
 	const struct pse_reply_data *data = PSE_REPDATA(reply_base);
-	const struct pse_control_status *st = &data->status;
+	const struct ethtool_pse_control_status *st = &data->status;
 	int len = 0;
 
 	if (st->podl_admin_state > 0)
@@ -114,7 +114,7 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 }
 
 static int pse_put_pw_limit_ranges(struct sk_buff *skb,
-				   const struct pse_control_status *st)
+				   const struct ethtool_pse_control_status *st)
 {
 	const struct ethtool_c33_pse_pw_limit_range *pw_limit_ranges;
 	int i;
@@ -146,7 +146,7 @@ static int pse_fill_reply(struct sk_buff *skb,
 			  const struct ethnl_reply_data *reply_base)
 {
 	const struct pse_reply_data *data = PSE_REPDATA(reply_base);
-	const struct pse_control_status *st = &data->status;
+	const struct ethtool_pse_control_status *st = &data->status;
 
 	if (st->podl_admin_state > 0 &&
 	    nla_put_u32(skb, ETHTOOL_A_PODL_PSE_ADMIN_STATE,

-- 
2.34.1


