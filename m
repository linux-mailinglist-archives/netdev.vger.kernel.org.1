Return-Path: <netdev+bounces-183312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126ADA904F7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A728A6C52
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D9124BD1A;
	Wed, 16 Apr 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZEWdDqam"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FF323BFA3;
	Wed, 16 Apr 2025 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811102; cv=none; b=qgtB1gKToBRFinnApR9k9048r8jn3JyeWgpzRBJe/lg64m5SU58K8OlYZY24Fx26YlYw0P7xVMLkbXaDXsja3CfMs/roLEe1tL7kueltzFDTS3uVVN0V27rvNsvlklVh9OBLCd1hG5xo6Tf2V/tCbn2I3KhlpQovz87KeS0doCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811102; c=relaxed/simple;
	bh=Zx3DmFx+lem2x4KgJW7RVfaFyubVDL9q7Agv1w9wHHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=puFKM1lzdz056IPf1TyIikNRnHGsLlCWOQcZAIg2T6E51eB7B+v2ywE+3GBSpT3rlgG3Bz3ir5NOPJutkb3SxBR2hyJo6wxdn5EGVt137cvso/eyQ+SXctgh1L2QTQwPOgMyhwGejqKBdr+Yn+lVQpInIBRr6u/t2ZmToTcVn3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZEWdDqam; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7CE1843915;
	Wed, 16 Apr 2025 13:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744811097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EJizdGT7wDuC8d4SmnzPdZshFCYiwSK/yJy+ndCqn4=;
	b=ZEWdDqam52AhJ6GDCcpBgR0CC6ERG73z/wrkNY/WOqz1h2iBfk/8rMgSd+jsvN+u0/QVDF
	wBz4GMStvOZ6jp2LskA1GfHizMtab58K5v6gGjcPzC+FVP9Vc9x/3CgnmotocBSLA26p3A
	OkrbPd59Tuww7N5gVkJONbv8Tyq2CjgmABXU8ztavI90LMcpKY6UhVStpUNHQ9rIH/CDiW
	W2FCBmqhowPLzm1NSJiZH7go1uNhvrZJwNMlDnmUuUJn7mckrnD+j1ChJfthTcqPGDysSp
	W4M8KIiytwEF8XCmsh0USWQLtt3hfsIVoYc9jr2I00X23r0b/x6JUIODttiUKw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 16 Apr 2025 15:44:24 +0200
Subject: [PATCH net-next v8 09/13] net: pse-pd: pd692x0: Add support for
 PSE PI priority feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-feature_poe_port_prio-v8-9-446c39dc3738@bootlin.com>
References: <20250416-feature_poe_port_prio-v8-0-446c39dc3738@bootlin.com>
In-Reply-To: <20250416-feature_poe_port_prio-v8-0-446c39dc3738@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehhohhrmhhssehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch extends the PSE callbacks by adding support for the newly
introduced pi_set_prio() callback, enabling the configuration of PSE PI
priorities. The current port priority is now also included in the status
information returned to users.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
---
Changes in v7:
- Nitpick change.

Changes in v3:
- New patch
---
 drivers/net/pse-pd/pd692x0.c | 205 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 7d60a714ca53..a4766c18f333 100644
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
@@ -739,6 +755,29 @@ pd692x0_pi_get_actual_pw(struct pse_controller_dev *pcdev, int id)
 	return (buf.data[0] << 4 | buf.data[1]) * 100;
 }
 
+static int
+pd692x0_pi_get_prio(struct pse_controller_dev *pcdev, int id)
+{
+	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
+	struct pd692x0_msg msg, buf = {0};
+	int ret;
+
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		return ret;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_PARAM];
+	msg.sub[2] = id;
+	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
+	if (ret < 0)
+		return ret;
+	if (!buf.data[2] || buf.data[2] > pcdev->pis_prio_max + 1)
+		return -ERANGE;
+
+	/* PSE core priority start at 0 */
+	return buf.data[2] - 1;
+}
+
 static struct pd692x0_msg_ver pd692x0_get_sw_version(struct pd692x0_priv *priv)
 {
 	struct device *dev = &priv->client->dev;
@@ -766,6 +805,7 @@ static struct pd692x0_msg_ver pd692x0_get_sw_version(struct pd692x0_priv *priv)
 
 struct pd692x0_manager {
 	struct device_node *port_node[PD692X0_MAX_MANAGER_PORTS];
+	struct device_node *node;
 	int nports;
 };
 
@@ -857,6 +897,8 @@ pd692x0_of_get_managers(struct pd692x0_priv *priv,
 		if (ret)
 			goto out;
 
+		of_node_get(node);
+		manager[manager_id].node = node;
 		nmanagers++;
 	}
 
@@ -869,6 +911,8 @@ pd692x0_of_get_managers(struct pd692x0_priv *priv,
 			of_node_put(manager[i].port_node[j]);
 			manager[i].port_node[j] = NULL;
 		}
+		of_node_put(manager[i].node);
+		manager[i].node = NULL;
 	}
 
 	of_node_put(node);
@@ -876,6 +920,130 @@ pd692x0_of_get_managers(struct pd692x0_priv *priv,
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
+		pw_budget = regulator_get_unclaimed_power_budget(supply);
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
@@ -998,6 +1166,14 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
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
@@ -1008,8 +1184,14 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 
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
@@ -1071,6 +1253,25 @@ static int pd692x0_pi_set_pw_limit(struct pse_controller_dev *pcdev,
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
 	.pi_get_admin_state = pd692x0_pi_get_admin_state,
@@ -1084,6 +1285,8 @@ static const struct pse_controller_ops pd692x0_ops = {
 	.pi_get_pw_limit = pd692x0_pi_get_pw_limit,
 	.pi_set_pw_limit = pd692x0_pi_set_pw_limit,
 	.pi_get_pw_limit_ranges = pd692x0_pi_get_pw_limit_ranges,
+	.pi_get_prio = pd692x0_pi_get_prio,
+	.pi_set_prio = pd692x0_pi_set_prio,
 };
 
 #define PD692X0_FW_LINE_MAX_SZ 0xff
@@ -1500,6 +1703,8 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
 	priv->pcdev.ops = &pd692x0_ops;
 	priv->pcdev.dev = dev;
 	priv->pcdev.types = ETHTOOL_PSE_C33;
+	priv->pcdev.supp_budget_eval_strategies = PSE_BUDGET_EVAL_STRAT_DYNAMIC;
+	priv->pcdev.pis_prio_max = 2;
 	ret = devm_pse_controller_register(dev, &priv->pcdev);
 	if (ret)
 		return dev_err_probe(dev, ret,

-- 
2.34.1


