Return-Path: <netdev+bounces-99060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FD18D38D3
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4BF1F240F9
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609514E1D9;
	Wed, 29 May 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pxNLvIe2"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B691F5F6;
	Wed, 29 May 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991784; cv=none; b=Y7lH7rlTtrLUictwe9t5EXKlzcb9pnL+P3vKPG1etmHguBRMkTu3mncLaCdtBlRocxLtRJki2AnNS3WaTAMvv/RyzAySaq01HsHxsmiS/HtCrL78qiT+56Kz1h5LylwRjh1SgZPMyWpWiilGwHZemeDnIhBvuwIPRlO74wb049M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991784; c=relaxed/simple;
	bh=dWt0+KRRjy3rE0jXtXtL3sGVHSL4Kd130bmGWzBJSmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WBIGatPrKOBA9AMIFmswGypukLafKSxCSc4YtDArAgQRPxl/WcBi5ZpKV7qfYNou5TvBHpxbPyIS8QfFv4pdt9xMkKGzwEmeaIk9ki/zTR/htKPFXcMiHE/ZheKyEdhHVD1sXZhxwQZbry1Tmvj5OGVgtnd+qwA24nOmvKbW4ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pxNLvIe2; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 073D340013;
	Wed, 29 May 2024 14:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716991780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZO88xtC56xKY5roWDT00Bzj+hSNHbnhaJYEU2ZQZkU=;
	b=pxNLvIe21tffg/oFOoys88UPUTrlyvebJGg5iC1mvNYGmW0qDXDboWhgwJfCzLtkR0pdkQ
	931ajtT2yIHqdSWkvH2pny6XHApLA2JUAOADPdklgGiDQ06G2ZaJxX2xwKFZpWAY+xrRCE
	QpLvez7RhJpIbdYZge6R8Xl6lEr6XgBxeI2IJ42ez5iVfBE5nQGEPkETdJsZKIT3dYCUkf
	xI8rXFbuadccSTik017gn642Ije5YCxDr4+fWpISDhgjfQEYwmKXDAox11gr0dkclZUdzx
	AEedK/9STOS87zgLMHd3xYjBBp3pUOAn1K220THTyUXuF1uPRaU7H3RJt/l7ig==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 29 May 2024 16:09:35 +0200
Subject: [PATCH 8/8] net: pse-pd: pd692x0: Enhance with new current limit
 and voltage read callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-feature_poe_power_cap-v1-8-0c4b1d5953b8@bootlin.com>
References: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
In-Reply-To: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
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
 drivers/net/pse-pd/pd692x0.c | 167 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 017a8efc43c4..c5fd4964d7bd 100644
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
@@ -515,6 +529,68 @@ static const char *pd692x0_get_status_msg(int id)
 	return NULL;
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
+static int pd692x0_pi_set_pw_from_table(struct pd692x0_msg *msg, int pw)
+{
+	const struct pd692x0_class_pw *pw_table;
+
+	pw_table = pd692x0_class_pw_table;
+	while (pw_table->class) {
+		if (pw <= (pw_table->class_pw + pw_table->max_added_class_pw)) {
+			int added_pw;
+
+			msg->data[2] = pw_table->class_cfg_value;
+			added_pw = (pw - pw_table->class_pw) / 100;
+			if (added_pw > 0)
+				msg->data[3] = added_pw;
+			else
+				msg->data[3] = 0;
+
+			return 0;
+		}
+
+		pw_table++;
+	}
+
+	/* Set max power ie. last line of pd692x0_class_pw_table */
+	pw_table--;
+	msg->data[2] = pw_table->class_cfg_value;
+	msg->data[3] = pw_table->max_added_class_pw;
+	return 0;
+}
+
 static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 				      unsigned long id,
 				      struct netlink_ext_ack *extack,
@@ -553,9 +629,20 @@ static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 	priv->admin_state[id] = status->c33_admin_state;
 
 	status->c33_pw_status_msg = pd692x0_get_status_msg(buf.sub[0]);
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
@@ -845,12 +932,88 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
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
+	/* Convert 0.1V unit to mV */
+	return (buf.sub[0] << 8 | buf.sub[1]) * 100;
+}
+
+static int pd692x0_pi_get_current_limit(struct pse_controller_dev *pcdev,
+					int id)
+{
+	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
+	struct pd692x0_msg msg, buf = {0};
+	int mW, mV, mA, ret;
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
+	mV = ret;
+
+	mA = mW * 1000 / mV;
+	return mA;
+}
+
+static int pd692x0_pi_set_current_limit(struct pse_controller_dev *pcdev,
+					int id, int max_mA)
+{
+	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
+	struct pd692x0_msg msg, buf = {0};
+	int mV, ret;
+
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		return ret;
+
+	/* If */
+	if (max_mA == MAX_PI_CURRENT)
+		return 0;
+
+	ret = pd692x0_pi_get_voltage(pcdev, id);
+	if (ret < 0)
+		return ret;
+	mV = ret;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
+	msg.sub[2] = id;
+	pd692x0_pi_set_pw_from_table(&msg, mV * max_mA / 1000);
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


