Return-Path: <netdev+bounces-101710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2D88FFD2E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F38E1F21B57
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83697156962;
	Fri,  7 Jun 2024 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MT4HxJbg"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029F31553AF;
	Fri,  7 Jun 2024 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745446; cv=none; b=kT5dCIib7vkCEGYJG6Vh43Hus3HJHbMifefGurzA6KPgaAmB+wcQEzeUfqdfpKQZrloKzZ5a4e0mTRBlcc8hzVceB3nlkqDijQTwzpPA9C7YGcY9cwd08h76nplqYG4tDb2tNZ6XcAHSmnXvd0cqhTRQIzEbLoJLRmbsgjQGt/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745446; c=relaxed/simple;
	bh=nclUHiO5gvB5PY2/xvF2HtvGK7qS6AnG7bkx7YUzeGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RCaehz9SE5yeQTevJ4TgOQ+83mx5UCxN3FJ1IXtJ2m2SxCC7yz1P4CmCdxYG2QVmdRprwNdLrr+i5oowph/yWlITxNUCewF5Pxyw//SG4zth2Yg8Ib4RNc2hawOICVjbi9yF5+7kJzxBlHr0if/0QzBnNZK6XyEpF1cpvWQsjRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MT4HxJbg; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F26444000D;
	Fri,  7 Jun 2024 07:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717745442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ntSTNeXccNfT0VJp5Rsgt/AU8amS/pkFoZRsCOGOeU=;
	b=MT4HxJbgmzKPOjxmyKZoBBYvTRsWYYqVZW2EYMUK+XwkkbAqlj15r7axMYXJgnz/0dqDPg
	RPnXwV+3sJzdM45eYumQJ3q/SqYrsvU1XmRMvlmbB8lXonT+RQgik68MxglXisn1vFgHd8
	bpPPx+WznI2TnQUteK3oZSUD+ImbQVdlOqhyGhiQOoh47X5/dkTIgKVwGBX35jRF2hwcva
	m2Av59k3foq6Cn9MHrNkYvJd2IhP8lcIgPID+Xv8aAReL5WjIC/jp3g605xoUpaYbK1qou
	p7f0wm/XtCJ+4NuD5t4bPqPT2mbZSmx+R8kXNC5IkAq1YUieNHpCZmlDij6f+A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 07 Jun 2024 09:30:25 +0200
Subject: [PATCH net-next v2 8/8] net: pse-pd: pd692x0: Enhance with new
 current limit and voltage read callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-feature_poe_power_cap-v2-8-c03c2deb83ab@bootlin.com>
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

This patch expands PSE callbacks with newly introduced
pi_get/set_current_limit() and pi_get_voltage() callback.
The only way to set ps692x0 port power limit is by configure the power
class plus a small power supplement which maximum depends on each class.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Use uA and uV instead of mA and mV to have more precision in the power
  calculation. Need to use 64bit variables for the calculation.
- Modify the behavior in case of setting the current out of the available
  ranges. Report an error now.
---
 drivers/net/pse-pd/pd692x0.c | 193 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 191 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 6b7367d009d6..4425e4ba2cfb 100644
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
@@ -511,6 +525,85 @@ pd692x0_get_ext_state(struct ethtool_c33_pse_ext_state_info *c33_ext_state_info,
 	}
 }
 
+struct pd692x0_class_pw {
+	int class;
+	int class_cfg_value;
+	int class_pw;
+	int max_added_class_pw;
+};
+
+/* 4/2 pairs class configuration power table in compliance mode.
+ * Need to be arranged in ascending order of power support.
+ */
+static const struct pd692x0_class_pw pd692x0_class_pw_table[] = {
+	{.class = 3, .class_cfg_value = 0x3, .class_pw = 15000, .max_added_class_pw = 3100},
+	{.class = 4, .class_cfg_value = 0x2, .class_pw = 30000, .max_added_class_pw = 8000},
+	{.class = 6, .class_cfg_value = 0x1, .class_pw = 60000, .max_added_class_pw = 5000},
+	{.class = 8, .class_cfg_value = 0x0, .class_pw = 90000, .max_added_class_pw = 7500},
+	{ /* sentinel */ }
+};
+
+static int pd692x0_pi_get_pw_from_table(int op_mode, int added_pw)
+{
+	const struct pd692x0_class_pw *pw_table;
+
+	pw_table = pd692x0_class_pw_table;
+	while (pw_table->class) {
+		if (pw_table->class_cfg_value == op_mode)
+			return pw_table->class_pw + added_pw * 100;
+
+		pw_table++;
+	}
+
+	return -ERANGE;
+}
+
+static int pd692x0_pi_set_pw_from_table(struct device *dev,
+					struct pd692x0_msg *msg, int pw)
+{
+	const struct pd692x0_class_pw *pw_table;
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
+	while (pw_table->class) {
+		if (pw > (pw_table->class_pw + pw_table->max_added_class_pw)) {
+			pw_table++;
+			continue;
+		}
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
 static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 				      unsigned long id,
 				      struct netlink_ext_ack *extack,
@@ -549,9 +642,20 @@ static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
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
+	status->c33_pw_limit = ret;
+
 	memset(&buf, 0, sizeof(buf));
 	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_CLASS];
 	msg.sub[2] = id;
@@ -841,12 +945,97 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
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


