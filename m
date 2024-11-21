Return-Path: <netdev+bounces-146676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C14B49D4F22
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36031B280D4
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC281DDC08;
	Thu, 21 Nov 2024 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m03yPGHf"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD451E25F9;
	Thu, 21 Nov 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200275; cv=none; b=DaQ3BCx+BGyNmQcNpo9nstJvpiY5+HnzoZLOB4C3bcHR10PUSvbOP/z6SF9RF0J1XXQ2XEM3faY05YHrwP2oTDw+72IGxPf6QIXZdzECwqL5/69ps8YT1KlYtvFYLqFA1HipKvYPOVqEPnEwf21ExFv/LQkHg1I+kyD1vsLCZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200275; c=relaxed/simple;
	bh=bnUXPyLx7iAkFU20XjCdcMR55Cku/ESx2wvQ0EUs5Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZf6IIbpRU1zcipOrGEJiXPdCk5mEOKwLD1Mnmk5NsG7F1GrC1jAlM44nzLgK+/qGvPZyMEIeBfD4k0Izot0uX2XHFmfPiTLOsJ3AXrTsXMaZ36SsV2kVS5aN1jmKfGwuRrmfXMLlZu0+zKzxLc63j6fhOx4ZWj5GHkX6fiJv5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m03yPGHf; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A706440009;
	Thu, 21 Nov 2024 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOP1IkfFRlL4Pq7d7OAf+/sTC6P+RABrKmfkbVwNO/0=;
	b=m03yPGHfa3kJe6MncevMvD+YUB4QJ0xD/j+rb8JzDb2bDSDbM1i8+EGKmQuI7wri3w7kfY
	GNtKFS7SqaDvbT5dqomxk3VU86/B9IVPDeRK/2jhzTjc8VdwG7DicyHtHcVaZH72Vzoj0t
	WdlsA+ejizqRbTlOQ+qKdxxN1QWO+MZfgFxx4EoiDPe4AsBFpsF5YYcPwKO61cewUytPwR
	DOmp61OhQl4npXt/cY5Hhd5FEviicrfP+FI4EtwBDMDUo/j5JrwMpfoFD1G5dNvIbvaqqC
	MY8KrJHuvquXcISqWnQ4ssOF+hJ8q2Vt7gQrs7x2DJUG9EKpOLBlZmaJkI7dLg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:50 +0100
Subject: [PATCH RFC net-next v3 24/27] net: pse-pd: pd692x0: Add support
 for PSE PI priority feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-24-83299fa6967c@bootlin.com>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
In-Reply-To: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch extends the PSE callbacks by adding support for the newly
introduced pi_set_prio() callback, enabling the configuration of PSE PI
priorities. The current port priority is now also included in the status
information returned to users.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 drivers/net/pse-pd/pd692x0.c | 183 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 0af7db80b2f8..be9fc4afaf97 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -12,6 +12,8 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pse-pd/pse.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
 
 #define PD692X0_PSE_NAME "pd692x0_pse"
 
@@ -76,6 +78,8 @@ enum {
 	PD692X0_MSG_GET_PORT_CLASS,
 	PD692X0_MSG_GET_PORT_MEAS,
 	PD692X0_MSG_GET_PORT_PARAM,
+	PD692X0_MSG_GET_POWER_BANK,
+	PD692X0_MSG_SET_POWER_BANK,
 
 	/* add new message above here */
 	PD692X0_MSG_CNT
@@ -95,6 +99,8 @@ struct pd692x0_priv {
 	unsigned long last_cmd_key_time;
 
 	enum ethtool_c33_pse_admin_state admin_state[PD692X0_MAX_PIS];
+	struct regulator_dev *manager_reg[PD692X0_MAX_MANAGERS];
+	int manager_pw_budget[PD692X0_MAX_MANAGERS];
 };
 
 /* Template list of communication messages. The non-null bytes defined here
@@ -170,6 +176,16 @@ static const struct pd692x0_msg pd692x0_msg_template_list[PD692X0_MSG_CNT] = {
 		.data = {0x4e, 0x4e, 0x4e, 0x4e,
 			 0x4e, 0x4e, 0x4e, 0x4e},
 	},
+	[PD692X0_MSG_GET_POWER_BANK] = {
+		.key = PD692X0_KEY_REQ,
+		.sub = {0x07, 0x0b, 0x57},
+		.data = {   0, 0x4e, 0x4e, 0x4e,
+			 0x4e, 0x4e, 0x4e, 0x4e},
+	},
+	[PD692X0_MSG_SET_POWER_BANK] = {
+		.key = PD692X0_KEY_CMD,
+		.sub = {0x07, 0x0b, 0x57},
+	},
 };
 
 static u8 pd692x0_build_msg(struct pd692x0_msg *msg, u8 echo)
@@ -685,6 +701,8 @@ static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 	if (ret < 0)
 		return ret;
 	status->c33_avail_pw_limit = ret;
+	/* PSE core priority start at 0 */
+	status->c33_prio = buf.data[2] - 1;
 
 	memset(&buf, 0, sizeof(buf));
 	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_CLASS];
@@ -731,6 +749,7 @@ static struct pd692x0_msg_ver pd692x0_get_sw_version(struct pd692x0_priv *priv)
 
 struct pd692x0_manager {
 	struct device_node *port_node[PD692X0_MAX_MANAGER_PORTS];
+	struct device_node *node;
 	int nports;
 };
 
@@ -822,6 +841,8 @@ pd692x0_of_get_managers(struct pd692x0_priv *priv,
 		if (ret)
 			goto out;
 
+		of_node_get(node);
+		manager[manager_id].node = node;
 		nmanagers++;
 	}
 
@@ -834,6 +855,8 @@ pd692x0_of_get_managers(struct pd692x0_priv *priv,
 			of_node_put(manager[i].port_node[j]);
 			manager[i].port_node[j] = NULL;
 		}
+		of_node_put(manager[i].node);
+		manager[i].node = NULL;
 	}
 
 	of_node_put(node);
@@ -841,6 +864,130 @@ pd692x0_of_get_managers(struct pd692x0_priv *priv,
 	return ret;
 }
 
+static const struct regulator_ops dummy_ops;
+
+static struct regulator_dev *
+pd692x0_register_manager_regulator(struct device *dev, char *reg_name,
+				   struct device_node *node)
+{
+	struct regulator_init_data *rinit_data;
+	struct regulator_config rconfig = {0};
+	struct regulator_desc *rdesc;
+	struct regulator_dev *rdev;
+
+	rinit_data = devm_kzalloc(dev, sizeof(*rinit_data),
+				  GFP_KERNEL);
+	if (!rinit_data)
+		return ERR_PTR(-ENOMEM);
+
+	rdesc = devm_kzalloc(dev, sizeof(*rdesc), GFP_KERNEL);
+	if (!rdesc)
+		return ERR_PTR(-ENOMEM);
+
+	rdesc->name = reg_name;
+	rdesc->type = REGULATOR_VOLTAGE;
+	rdesc->ops = &dummy_ops;
+	rdesc->owner = THIS_MODULE;
+
+	rinit_data->supply_regulator = "vmain";
+
+	rconfig.dev = dev;
+	rconfig.init_data = rinit_data;
+	rconfig.of_node = node;
+
+	rdev = devm_regulator_register(dev, rdesc, &rconfig);
+	if (IS_ERR(rdev)) {
+		dev_err_probe(dev, PTR_ERR(rdev),
+			      "Failed to register regulator\n");
+		return rdev;
+	}
+
+	return rdev;
+}
+
+static int
+pd692x0_register_managers_regulator(struct pd692x0_priv *priv,
+				    const struct pd692x0_manager *manager,
+				    int nmanagers)
+{
+	struct device *dev = &priv->client->dev;
+	size_t reg_name_len;
+	int i;
+
+	/* Each regulator name len is dev name + 12 char +
+	 * int max digit number (10) + 1
+	 */
+	reg_name_len = strlen(dev_name(dev)) + 23;
+
+	for (i = 0; i < nmanagers; i++) {
+		struct regulator_dev *rdev;
+		char *reg_name;
+
+		reg_name = devm_kzalloc(dev, reg_name_len, GFP_KERNEL);
+		if (!reg_name)
+			return -ENOMEM;
+		snprintf(reg_name, 26, "pse-%s-manager%d", dev_name(dev), i);
+		rdev = pd692x0_register_manager_regulator(dev, reg_name,
+							  manager[i].node);
+		if (IS_ERR(rdev))
+			return PTR_ERR(rdev);
+
+		priv->manager_reg[i] = rdev;
+	}
+
+	return 0;
+}
+
+static int
+pd692x0_conf_manager_power_budget(struct pd692x0_priv *priv, int id, int pw)
+{
+	struct pd692x0_msg msg, buf;
+	int ret, pw_mW = pw / 1000;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_POWER_BANK];
+	msg.data[0] = id;
+	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
+	if (ret < 0)
+		return ret;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_POWER_BANK];
+	msg.data[0] = id;
+	msg.data[1] = pw_mW >> 8;
+	msg.data[2] = pw_mW & 0xff;
+	msg.data[3] = buf.sub[2];
+	msg.data[4] = buf.data[0];
+	msg.data[5] = buf.data[1];
+	msg.data[6] = buf.data[2];
+	msg.data[7] = buf.data[3];
+	return pd692x0_sendrecv_msg(priv, &msg, &buf);
+}
+
+static int
+pd692x0_configure_managers(struct pd692x0_priv *priv, int nmanagers)
+{
+	int i, ret;
+
+	for (i = 0; i < nmanagers; i++) {
+		struct regulator *supply = priv->manager_reg[i]->supply;
+		int pw_budget;
+
+		pw_budget = regulator_get_power_budget(supply);
+		/* Max power budget per manager */
+		if (pw_budget > 6000000)
+			pw_budget = 6000000;
+		ret = regulator_request_power_budget(supply, pw_budget);
+		if (ret < 0)
+			return ret;
+
+		priv->manager_pw_budget[i] = pw_budget;
+		ret = pd692x0_conf_manager_power_budget(priv, i, pw_budget);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int
 pd692x0_set_port_matrix(const struct pse_pi_pairset *pairset,
 			const struct pd692x0_manager *manager,
@@ -963,6 +1110,14 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 		return ret;
 
 	nmanagers = ret;
+	ret = pd692x0_register_managers_regulator(priv, manager, nmanagers);
+	if (ret)
+		goto out;
+
+	ret = pd692x0_configure_managers(priv, nmanagers);
+	if (ret)
+		goto out;
+
 	ret = pd692x0_set_ports_matrix(priv, manager, nmanagers, port_matrix);
 	if (ret)
 		goto out;
@@ -973,8 +1128,14 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 
 out:
 	for (i = 0; i < nmanagers; i++) {
+		struct regulator *supply = priv->manager_reg[i]->supply;
+
+		regulator_free_power_budget(supply,
+					    priv->manager_pw_budget[i]);
+
 		for (j = 0; j < manager[i].nports; j++)
 			of_node_put(manager[i].port_node[j]);
+		of_node_put(manager[i].node);
 	}
 	return ret;
 }
@@ -1061,6 +1222,25 @@ static int pd692x0_pi_set_current_limit(struct pse_controller_dev *pcdev,
 	return pd692x0_sendrecv_msg(priv, &msg, &buf);
 }
 
+static int pd692x0_pi_set_prio(struct pse_controller_dev *pcdev, int id,
+			       unsigned int prio)
+{
+	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
+	struct pd692x0_msg msg, buf = {0};
+	int ret;
+
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		return ret;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
+	msg.sub[2] = id;
+	/* Controller priority from 1 to 3 */
+	msg.data[4] = prio + 1;
+
+	return pd692x0_sendrecv_msg(priv, &msg, &buf);
+}
+
 static const struct pse_controller_ops pd692x0_ops = {
 	.setup_pi_matrix = pd692x0_setup_pi_matrix,
 	.ethtool_get_status = pd692x0_ethtool_get_status,
@@ -1070,6 +1250,7 @@ static const struct pse_controller_ops pd692x0_ops = {
 	.pi_get_voltage = pd692x0_pi_get_voltage,
 	.pi_get_current_limit = pd692x0_pi_get_current_limit,
 	.pi_set_current_limit = pd692x0_pi_set_current_limit,
+	.pi_set_prio = pd692x0_pi_set_prio,
 };
 
 #define PD692X0_FW_LINE_MAX_SZ 0xff
@@ -1486,6 +1667,8 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
 	priv->pcdev.ops = &pd692x0_ops;
 	priv->pcdev.dev = dev;
 	priv->pcdev.types = ETHTOOL_PSE_C33;
+	priv->pcdev.port_prio_supp_modes = ETHTOOL_PSE_PORT_PRIO_DYNAMIC;
+	priv->pcdev.pis_prio_max = 2;
 	ret = devm_pse_controller_register(dev, &priv->pcdev);
 	if (ret)
 		return dev_err_probe(dev, ret,

-- 
2.34.1


