Return-Path: <netdev+bounces-106469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D59916805
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040F41F2868B
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B9C16C848;
	Tue, 25 Jun 2024 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y1UncwwX"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59ED15F3FF;
	Tue, 25 Jun 2024 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318848; cv=none; b=DIFZvdOC97XgyamS+c2UDkhdML29UdaoXYFXDOEirlHodMvIxDBDRwVCwBOwhSCyNrwtlnMA8N4QC4ADZNS+i7jqEnDrT/QD1MmFh9x69rD5jrih7HybhXXxNRy6XLpr5JBsVWj3w0THC+GQRdntvT13UY/5NuxdyQUnOmyV0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318848; c=relaxed/simple;
	bh=SpfHqfa9hfIHdc1CLA4uD7hZE61S37qx3XNIwWLUlfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZfgiPxIkSD/DDzeJ+mw5evBgfnUakC8G8JfhRYwWoph7TMaak/AKNYt1aRG8C5q9r9tpSXQ6JAONecSYtq7C3+vyw/4TIwIxnLsrfZnLUBqYSv/CvW+gat7kRbsR5FJIHbqLw4ZtIf4pCN7dvBpmbY2o8PBTZggGrLKIT4MXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y1UncwwX; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 970B060011;
	Tue, 25 Jun 2024 12:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719318844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FR8jLvUCzfhWKi2Pz/S1QIOEZDQt3ON1P/We2KXcOc=;
	b=Y1UncwwXUrOXRVj1ut4zl8KdJUtxx5oFNMA0EkECoohdeRUnm8iy9CQbwsXLWyAj22i4BU
	Lg02PdN8NSNtMQ+F7zrQdYVgT+0wFZxKMfMWXhEwRAwBVetyDqkrT7MPLoSU49Db+BG5uc
	HSIyYR3fjRtPqeJV4KsITQYi1yUJQHXAmm4nbyFnWjYpKBnL910eEkIrYwjJzn/Zo/nD6G
	rGxVXo8E3Ytfdf4HoPfHG4AJywFKIXvNYfniVZcykIlmGPRNygUNGQU333ax5LhnxRL+Z6
	Eiyz5zUPdfA/6GryBC11AeNo1B7a+qvn3k78rkJWRm08l+zGrDsB90gYfm8Ftw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 25 Jun 2024 14:33:52 +0200
Subject: [PATCH net-next v4 7/7] net: pse-pd: pd692x0: Enhance with new
 current limit and voltage read callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-feature_poe_power_cap-v4-7-b0813aad57d5@bootlin.com>
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

This patch expands PSE callbacks with newly introduced
pi_get/set_current_limit() and pi_get_voltage() callback.
It also add the power limit ranges description in the status returned.
The only way to set ps692x0 port power limit is by configure the power
class plus a small power supplement which maximum depends on each class.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Use uA and uV instead of mA and mV to have more precision in the power
  calculation. Need to use 64bit variables for the calculation.
- Modify the behavior in case of setting the current out of the available
  ranges. Report an error now.

Change in v4:
- Add support for c33 pse power limit ranges.
---
 drivers/net/pse-pd/pd692x0.c | 218 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 216 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 021b22d4b931..261767522788 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -74,6 +74,8 @@ enum {
 	PD692X0_MSG_GET_PORT_STATUS,
 	PD692X0_MSG_DOWNLOAD_CMD,
 	PD692X0_MSG_GET_PORT_CLASS,
+	PD692X0_MSG_GET_PORT_MEAS,
+	PD692X0_MSG_GET_PORT_PARAM,
 
 	/* add new message above here */
 	PD692X0_MSG_CNT
@@ -135,7 +137,7 @@ static const struct pd692x0_msg pd692x0_msg_template_list[PD692X0_MSG_CNT] = {
 	[PD692X0_MSG_SET_PORT_PARAM] = {
 		.key = PD692X0_KEY_CMD,
 		.sub = {0x05, 0xc0},
-		.data = {   0, 0xff, 0xff, 0xff,
+		.data = { 0xf, 0xff, 0xff, 0xff,
 			 0x4e, 0x4e, 0x4e, 0x4e},
 	},
 	[PD692X0_MSG_GET_PORT_STATUS] = {
@@ -156,6 +158,18 @@ static const struct pd692x0_msg pd692x0_msg_template_list[PD692X0_MSG_CNT] = {
 		.data = {0x4e, 0x4e, 0x4e, 0x4e,
 			 0x4e, 0x4e, 0x4e, 0x4e},
 	},
+	[PD692X0_MSG_GET_PORT_MEAS] = {
+		.key = PD692X0_KEY_REQ,
+		.sub = {0x05, 0xc5},
+		.data = {0x4e, 0x4e, 0x4e, 0x4e,
+			 0x4e, 0x4e, 0x4e, 0x4e},
+	},
+	[PD692X0_MSG_GET_PORT_PARAM] = {
+		.key = PD692X0_KEY_REQ,
+		.sub = {0x05, 0xc0},
+		.data = {0x4e, 0x4e, 0x4e, 0x4e,
+			 0x4e, 0x4e, 0x4e, 0x4e},
+	},
 };
 
 static u8 pd692x0_build_msg(struct pd692x0_msg *msg, u8 echo)
@@ -520,6 +534,106 @@ pd692x0_get_ext_state(struct ethtool_c33_pse_ext_state_info *c33_ext_state_info,
 	}
 }
 
+struct pd692x0_class_pw {
+	int class;
+	int class_cfg_value;
+	int class_pw;
+	int max_added_class_pw;
+};
+
+#define PD692X0_CLASS_PW_TABLE_SIZE 4
+/* 4/2 pairs class configuration power table in compliance mode.
+ * Need to be arranged in ascending order of power support.
+ */
+static const struct pd692x0_class_pw
+pd692x0_class_pw_table[PD692X0_CLASS_PW_TABLE_SIZE] = {
+	{.class = 3, .class_cfg_value = 0x3, .class_pw = 15000, .max_added_class_pw = 3100},
+	{.class = 4, .class_cfg_value = 0x2, .class_pw = 30000, .max_added_class_pw = 8000},
+	{.class = 6, .class_cfg_value = 0x1, .class_pw = 60000, .max_added_class_pw = 5000},
+	{.class = 8, .class_cfg_value = 0x0, .class_pw = 90000, .max_added_class_pw = 7500},
+};
+
+static int pd692x0_pi_get_pw_from_table(int op_mode, int added_pw)
+{
+	const struct pd692x0_class_pw *pw_table;
+	int i;
+
+	pw_table = pd692x0_class_pw_table;
+	for (i = 0; i < PD692X0_CLASS_PW_TABLE_SIZE; i++, pw_table++) {
+		if (pw_table->class_cfg_value == op_mode)
+			return pw_table->class_pw + added_pw * 100;
+	}
+
+	return -ERANGE;
+}
+
+static int pd692x0_pi_set_pw_from_table(struct device *dev,
+					struct pd692x0_msg *msg, int pw)
+{
+	const struct pd692x0_class_pw *pw_table;
+	int i;
+
+	pw_table = pd692x0_class_pw_table;
+	if (pw < pw_table->class_pw) {
+		dev_err(dev,
+			"Power limit %dmW not supported. Ranges minimal available: [%d-%d]\n",
+			pw,
+			pw_table->class_pw,
+			pw_table->class_pw + pw_table->max_added_class_pw);
+		return -ERANGE;
+	}
+
+	for (i = 0; i < PD692X0_CLASS_PW_TABLE_SIZE; i++, pw_table++) {
+		if (pw > (pw_table->class_pw + pw_table->max_added_class_pw))
+			continue;
+
+		if (pw < pw_table->class_pw) {
+			dev_err(dev,
+				"Power limit %dmW not supported. Ranges availables: [%d-%d] or [%d-%d]\n",
+				pw,
+				(pw_table - 1)->class_pw,
+				(pw_table - 1)->class_pw + (pw_table - 1)->max_added_class_pw,
+				pw_table->class_pw,
+				pw_table->class_pw + pw_table->max_added_class_pw);
+			return -ERANGE;
+		}
+
+		msg->data[2] = pw_table->class_cfg_value;
+		msg->data[3] = (pw - pw_table->class_pw) / 100;
+		return 0;
+	}
+
+	pw_table--;
+	dev_warn(dev,
+		 "Power limit %dmW not supported. Set to highest power limit %dmW\n",
+		 pw, pw_table->class_pw + pw_table->max_added_class_pw);
+	msg->data[2] = pw_table->class_cfg_value;
+	msg->data[3] = pw_table->max_added_class_pw / 100;
+	return 0;
+}
+
+static int
+pd692x0_pi_get_pw_ranges(struct pse_control_status *st)
+{
+	const struct pd692x0_class_pw *pw_table;
+	int i;
+
+	pw_table = pd692x0_class_pw_table;
+	st->c33_pw_limit_ranges = kcalloc(PD692X0_CLASS_PW_TABLE_SIZE,
+					  sizeof(struct ethtool_c33_pse_pw_limit_range),
+					  GFP_KERNEL);
+	if (!st->c33_pw_limit_ranges)
+		return -ENOMEM;
+
+	for (i = 0; i < PD692X0_CLASS_PW_TABLE_SIZE; i++, pw_table++) {
+		st->c33_pw_limit_ranges[i].min = pw_table->class_pw;
+		st->c33_pw_limit_ranges[i].max = pw_table->class_pw + pw_table->max_added_class_pw;
+	}
+
+	st->c33_pw_limit_nb_ranges = i;
+	return 0;
+}
+
 static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 				      unsigned long id,
 				      struct netlink_ext_ack *extack,
@@ -558,9 +672,20 @@ static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 	priv->admin_state[id] = status->c33_admin_state;
 
 	pd692x0_get_ext_state(&status->c33_ext_state_info, buf.sub[0]);
-
 	status->c33_actual_pw = (buf.data[0] << 4 | buf.data[1]) * 100;
 
+	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_PARAM];
+	msg.sub[2] = id;
+	memset(&buf, 0, sizeof(buf));
+	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
+	if (ret < 0)
+		return ret;
+
+	ret = pd692x0_pi_get_pw_from_table(buf.data[0], buf.data[1]);
+	if (ret < 0)
+		return ret;
+	status->c33_avail_pw_limit = ret;
+
 	memset(&buf, 0, sizeof(buf));
 	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_CLASS];
 	msg.sub[2] = id;
@@ -572,6 +697,10 @@ static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 	if (class <= 8)
 		status->c33_pw_class = class;
 
+	ret = pd692x0_pi_get_pw_ranges(status);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
@@ -850,12 +979,97 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 	return ret;
 }
 
+static int pd692x0_pi_get_voltage(struct pse_controller_dev *pcdev, int id)
+{
+	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
+	struct pd692x0_msg msg, buf = {0};
+	int ret;
+
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		return ret;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_MEAS];
+	msg.sub[2] = id;
+	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
+	if (ret < 0)
+		return ret;
+
+	/* Convert 0.1V unit to uV */
+	return (buf.sub[0] << 8 | buf.sub[1]) * 100000;
+}
+
+static int pd692x0_pi_get_current_limit(struct pse_controller_dev *pcdev,
+					int id)
+{
+	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
+	struct pd692x0_msg msg, buf = {0};
+	int mW, uV, uA, ret;
+	s64 tmp_64;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_PARAM];
+	msg.sub[2] = id;
+	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
+	if (ret < 0)
+		return ret;
+
+	ret = pd692x0_pi_get_pw_from_table(buf.data[2], buf.data[3]);
+	if (ret < 0)
+		return ret;
+	mW = ret;
+
+	ret = pd692x0_pi_get_voltage(pcdev, id);
+	if (ret < 0)
+		return ret;
+	uV = ret;
+
+	tmp_64 = mW;
+	tmp_64 *= 1000000000ull;
+	/* uA = mW * 1000000000 / uV */
+	uA = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
+	return uA;
+}
+
+static int pd692x0_pi_set_current_limit(struct pse_controller_dev *pcdev,
+					int id, int max_uA)
+{
+	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
+	struct device *dev = &priv->client->dev;
+	struct pd692x0_msg msg, buf = {0};
+	int uV, ret, mW;
+	s64 tmp_64;
+
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		return ret;
+
+	ret = pd692x0_pi_get_voltage(pcdev, id);
+	if (ret < 0)
+		return ret;
+	uV = ret;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
+	msg.sub[2] = id;
+	tmp_64 = uV;
+	tmp_64 *= max_uA;
+	/* mW = uV * uA / 1000000000 */
+	mW = DIV_ROUND_CLOSEST_ULL(tmp_64, 1000000000);
+	ret = pd692x0_pi_set_pw_from_table(dev, &msg, mW);
+	if (ret)
+		return ret;
+
+	return pd692x0_sendrecv_msg(priv, &msg, &buf);
+}
+
 static const struct pse_controller_ops pd692x0_ops = {
 	.setup_pi_matrix = pd692x0_setup_pi_matrix,
 	.ethtool_get_status = pd692x0_ethtool_get_status,
 	.pi_enable = pd692x0_pi_enable,
 	.pi_disable = pd692x0_pi_disable,
 	.pi_is_enabled = pd692x0_pi_is_enabled,
+	.pi_get_voltage = pd692x0_pi_get_voltage,
+	.pi_get_current_limit = pd692x0_pi_get_current_limit,
+	.pi_set_current_limit = pd692x0_pi_set_current_limit,
 };
 
 #define PD692X0_FW_LINE_MAX_SZ 0xff

-- 
2.34.1


