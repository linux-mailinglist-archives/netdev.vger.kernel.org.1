Return-Path: <netdev+bounces-155077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7847AA00F5F
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C4B3A46D3
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2651C5F32;
	Fri,  3 Jan 2025 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fih9azxq"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F81C3C09;
	Fri,  3 Jan 2025 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938840; cv=none; b=HKlnftIFEfOxyIh2AzDEFGTi4wZAW9/dhxDOPUKmQZzWW5/DFA2S5KvlaW1TwtkRE7CBAdbiewy5EsWpstlC6NGjPMpzVEeiqiOT/TWdBb5oLdkuygvIfuvsNEvddfwnF4RqYl/8b61GTqs99uvp+qtjbDi+tG8tW+JJsH/ZYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938840; c=relaxed/simple;
	bh=02yxfFpuyy3eHQSErRK91xv6nDU2zdpt3tlsLc+rrBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PnuEzN/BWSbQZK/RoU9ZZnkN2eGKv0CSA5e3Iy1Lcdd9M/oM8mlOLjTTJ8HN2aMHUxPs0xVopH77dApKndo7Ha9ONJiVWvEZ7cC1Q+CELPg/c24uXHAQ5j/nngxqoTxAK1byQre1mM3F6wyk8kx+WNu7wRwdv2ety+AfTWdRT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fih9azxq; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29817FF803;
	Fri,  3 Jan 2025 21:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735938836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bx/oL81Qn70YOj6YTWkxB3N+eikTPaHJ82VDKx1BKeY=;
	b=fih9azxqj3s12UH+hCjM78RfZ0SDEAvbKwaZjysCUf9W0ntNFc+fLs29NrIjE59iv1vlyu
	TmWviTdcXXfWHU/PnktCsiSxFgL4bDfaIzHr6ZBDFgZh8ww/0kIQshL9AfHPfFNXifpqLD
	5aIVOuDCr9PHNK2FljLZ7pp74fAzoWRWKleZPh0bnm9ihYxHo+Sf4co8wBRb73DaAw4tzA
	K4ZmJafeJsHiBaNSdmSlsW0x2S1DvbqLG3pRPDYZAYic+FUBXnBtMTHZRGcd/LjMPJYaKW
	Iub8iaSLcAU9sG/1Ed0xtOSMLrFf5dxzQByi0OegEqDlsbDanghTwsLuW0T2oQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Jan 2025 22:12:58 +0100
Subject: [PATCH net-next v4 09/27] net: pse-pd: Remove is_enabled callback
 from drivers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-feature_poe_port_prio-v4-9-dc91a3c0c187@bootlin.com>
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

The is_enabled callback is now redundant as the admin_state can be obtained
directly from the driver and provides the same information.

To simplify functionality, the core will handle this internally, making
the is_enabled callback unnecessary at the driver level. This patch
removes the callback from all drivers.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v4:
- New patch
---
 drivers/net/pse-pd/pd692x0.c       | 26 --------------------------
 drivers/net/pse-pd/pse_core.c      | 13 +++++++++++--
 drivers/net/pse-pd/pse_regulator.c |  9 ---------
 drivers/net/pse-pd/tps23881.c      | 28 ----------------------------
 include/linux/pse-pd/pse.h         |  3 ---
 5 files changed, 11 insertions(+), 68 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index da5d09ed628a..fc9e23927b3b 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -431,31 +431,6 @@ static int pd692x0_pi_disable(struct pse_controller_dev *pcdev, int id)
 	return 0;
 }
 
-static int pd692x0_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
-{
-	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
-	struct pd692x0_msg msg, buf = {0};
-	int ret;
-
-	ret = pd692x0_fw_unavailable(priv);
-	if (ret)
-		return ret;
-
-	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_STATUS];
-	msg.sub[2] = id;
-	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
-	if (ret < 0)
-		return ret;
-
-	if (buf.sub[1]) {
-		priv->admin_state[id] = ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
-		return 1;
-	} else {
-		priv->admin_state[id] = ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
-		return 0;
-	}
-}
-
 struct pd692x0_pse_ext_state_mapping {
 	u32 status_code;
 	enum ethtool_c33_pse_ext_state pse_ext_state;
@@ -1105,7 +1080,6 @@ static const struct pse_controller_ops pd692x0_ops = {
 	.pi_get_actual_pw = pd692x0_pi_get_actual_pw,
 	.pi_enable = pd692x0_pi_enable,
 	.pi_disable = pd692x0_pi_disable,
-	.pi_is_enabled = pd692x0_pi_is_enabled,
 	.pi_get_voltage = pd692x0_pi_get_voltage,
 	.pi_get_pw_limit = pd692x0_pi_get_pw_limit,
 	.pi_set_pw_limit = pd692x0_pi_set_pw_limit,
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 5f2a9f36e4ed..887a477197a6 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -210,16 +210,25 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
 static int pse_pi_is_enabled(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
+	struct pse_admin_state admin_state = {0};
 	const struct pse_controller_ops *ops;
 	int id, ret;
 
 	ops = pcdev->ops;
-	if (!ops->pi_is_enabled)
+	if (!ops->pi_get_admin_state)
 		return -EOPNOTSUPP;
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
-	ret = ops->pi_is_enabled(pcdev, id);
+	ret = ops->pi_get_admin_state(pcdev, id, &admin_state);
+	if (ret)
+		goto out;
+
+	if (admin_state.podl_admin_state == ETHTOOL_PODL_PSE_ADMIN_STATE_ENABLED ||
+	    admin_state.c33_admin_state == ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED)
+		ret = 1;
+
+out:
 	mutex_unlock(&pcdev->lock);
 
 	return ret;
diff --git a/drivers/net/pse-pd/pse_regulator.c b/drivers/net/pse-pd/pse_regulator.c
index 86360056b2f5..6ce6773fff31 100644
--- a/drivers/net/pse-pd/pse_regulator.c
+++ b/drivers/net/pse-pd/pse_regulator.c
@@ -51,14 +51,6 @@ pse_reg_pi_disable(struct pse_controller_dev *pcdev, int id)
 	return 0;
 }
 
-static int
-pse_reg_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
-{
-	struct pse_reg_priv *priv = to_pse_reg(pcdev);
-
-	return regulator_is_enabled(priv->ps);
-}
-
 static int
 pse_reg_pi_get_admin_state(struct pse_controller_dev *pcdev, int id,
 			   struct pse_admin_state *admin_state)
@@ -95,7 +87,6 @@ static const struct pse_controller_ops pse_reg_ops = {
 	.pi_get_admin_state = pse_reg_pi_get_admin_state,
 	.pi_get_pw_status = pse_reg_pi_get_pw_status,
 	.pi_enable = pse_reg_pi_enable,
-	.pi_is_enabled = pse_reg_pi_is_enabled,
 	.pi_disable = pse_reg_pi_disable,
 };
 
diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index f735b6917f8b..340d70ee37fe 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -174,33 +174,6 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 	return i2c_smbus_write_word_data(client, TPS23881_REG_DET_CLA_EN, val);
 }
 
-static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
-{
-	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
-	struct i2c_client *client = priv->client;
-	bool enabled;
-	u8 chan;
-	u16 val;
-	int ret;
-
-	ret = i2c_smbus_read_word_data(client, TPS23881_REG_PW_STATUS);
-	if (ret < 0)
-		return ret;
-
-	chan = priv->port[id].chan[0];
-	val = tps23881_calc_val(ret, chan, 0, BIT(chan % 4));
-	enabled = !!(val);
-
-	if (priv->port[id].is_4p) {
-		chan = priv->port[id].chan[1];
-		val = tps23881_calc_val(ret, chan, 0, BIT(chan % 4));
-		enabled &= !!(val);
-	}
-
-	/* Return enabled status only if both channel are on this state */
-	return enabled;
-}
-
 static int
 tps23881_pi_get_admin_state(struct pse_controller_dev *pcdev, int id,
 			    struct pse_admin_state *admin_state)
@@ -690,7 +663,6 @@ static const struct pse_controller_ops tps23881_ops = {
 	.setup_pi_matrix = tps23881_setup_pi_matrix,
 	.pi_enable = tps23881_pi_enable,
 	.pi_disable = tps23881_pi_disable,
-	.pi_is_enabled = tps23881_pi_is_enabled,
 	.pi_get_admin_state = tps23881_pi_get_admin_state,
 	.pi_get_pw_status = tps23881_pi_get_pw_status,
 };
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index db8b3db7b849..09e62d8c3271 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -86,8 +86,6 @@ struct pse_pw_limit_ranges {
  * @pi_get_ext_state: Get the extended state of the PSE PI.
  * @pi_get_pw_class: Get the power class of the PSE PI.
  * @pi_get_actual_pw: Get actual power of the PSE PI in mW.
- * @pi_is_enabled: Return 1 if the PSE PI is enabled, 0 if not.
- *		   May also return negative errno.
  * @pi_enable: Configure the PSE PI as enabled.
  * @pi_disable: Configure the PSE PI as disabled.
  * @pi_get_voltage: Return voltage similarly to get_voltage regulator
@@ -109,7 +107,6 @@ struct pse_controller_ops {
 				struct pse_ext_state_info *ext_state_info);
 	int (*pi_get_pw_class)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_get_actual_pw)(struct pse_controller_dev *pcdev, int id);
-	int (*pi_is_enabled)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_enable)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_disable)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_get_voltage)(struct pse_controller_dev *pcdev, int id);

-- 
2.34.1


