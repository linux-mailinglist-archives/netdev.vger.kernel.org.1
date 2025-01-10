Return-Path: <netdev+bounces-157057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6BCA08C8C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9C218870FC
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974B20E338;
	Fri, 10 Jan 2025 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O/VLTfN2"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3421320DD49;
	Fri, 10 Jan 2025 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502053; cv=none; b=iTXmkJz/zuMcMIEQwtn3KtmKBxKObneHFMhtUx0PTDpxeaw/yboug4xsUhvarzfXJ3ruebRWenwqgK7PLesKBtp6ohWFC4aWRX10zT1RV9ppAgijITGdCqkbSneSxyJ1DKZUpIlKSoy59G5IcKGLj4D+8ZLnkZ2w35ZH1APnrho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502053; c=relaxed/simple;
	bh=LzfMDZQKCZMbIY6JKxpom3Quh+zR5vaodbn32D3h1MM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mN+jzDyxN+aUGlQK4j0tpDTB8t0ic17jRp3/qGASVyyjsz5PrA6/pkUmdJ6yZ67arUh4J9RBTOVIsQeFWaI1Rnu8kBrjTnCgmszFM8IfWhUWpzzmw+DoonUP15TVZI4+YA90oTPIlL2YoRyRVxFwUVcFsPiCVmSMqnLVHzXUxWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O/VLTfN2; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B68206000C;
	Fri, 10 Jan 2025 09:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736502049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBrCefbndRgks1GFVJ+JeWEanfk65QgpSUf4z/fVIa4=;
	b=O/VLTfN2RcflF07StDXW500SwcJ0BunFbO3ZcevJO/4IwRH8xHl2WqeCe6MpUoOBz5i7wQ
	Oto3TkvanIMzWF2RpeJHvw308o7reFEMY+Ql17z3z9gAsbPI0k2G+rf56vC8dm2QgV63dv
	OBz4sT6u52roBJgC/oI5bmxhGtk51X+BqsC6MFi0MVHo1TJW15vs8JnOc1cTtt/DPJb4U7
	j5lgGxKWcM/r5BHD6p/yK5RjYILS/6JkWm+E/rqHiHQ4qElfXgBOZx5a/TRBKl44E3RgSZ
	3UumNTGQl4fuLbz6CHmg+0/oQ1fnkE2tHJ87XOX8BY5Yz5ciQL9WzqlHo2Kx/g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 10 Jan 2025 10:40:26 +0100
Subject: [PATCH net-next v3 07/12] net: pse-pd: Use power limit at driver
 side instead of current limit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-feature_poe_arrange-v3-7-142279aedb94@bootlin.com>
References: <20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com>
In-Reply-To: <20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: kory.maincent@bootlin.com

The regulator framework uses current limits, but the PSE standard and
known PSE controllers rely on power limits. Instead of converting
current to power within each driver, perform the conversion in the PSE
core. This avoids redundancy in driver implementation and aligns better
with the standard, simplifying driver development.

Remove at the same time the _pse_ethtool_get_status() function which is
not needed anymore.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pd692x0.c  | 45 +++++----------------
 drivers/net/pse-pd/pse_core.c | 91 +++++++++++++++++++------------------------
 include/linux/pse-pd/pse.h    | 16 +++-----
 3 files changed, 57 insertions(+), 95 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 0af7db80b2f8..9f00538f7e45 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -999,13 +999,12 @@ static int pd692x0_pi_get_voltage(struct pse_controller_dev *pcdev, int id)
 	return (buf.sub[0] << 8 | buf.sub[1]) * 100000;
 }
 
-static int pd692x0_pi_get_current_limit(struct pse_controller_dev *pcdev,
-					int id)
+static int pd692x0_pi_get_pw_limit(struct pse_controller_dev *pcdev,
+				   int id)
 {
 	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
 	struct pd692x0_msg msg, buf = {0};
-	int mW, uV, uA, ret;
-	s64 tmp_64;
+	int ret;
 
 	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_PARAM];
 	msg.sub[2] = id;
@@ -1013,48 +1012,24 @@ static int pd692x0_pi_get_current_limit(struct pse_controller_dev *pcdev,
 	if (ret < 0)
 		return ret;
 
-	ret = pd692x0_pi_get_pw_from_table(buf.data[2], buf.data[3]);
-	if (ret < 0)
-		return ret;
-	mW = ret;
-
-	ret = pd692x0_pi_get_voltage(pcdev, id);
-	if (ret < 0)
-		return ret;
-	uV = ret;
-
-	tmp_64 = mW;
-	tmp_64 *= 1000000000ull;
-	/* uA = mW * 1000000000 / uV */
-	uA = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
-	return uA;
+	return pd692x0_pi_get_pw_from_table(buf.data[2], buf.data[3]);
 }
 
-static int pd692x0_pi_set_current_limit(struct pse_controller_dev *pcdev,
-					int id, int max_uA)
+static int pd692x0_pi_set_pw_limit(struct pse_controller_dev *pcdev,
+				   int id, int max_mW)
 {
 	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
 	struct device *dev = &priv->client->dev;
 	struct pd692x0_msg msg, buf = {0};
-	int uV, ret, mW;
-	s64 tmp_64;
+	int ret;
 
 	ret = pd692x0_fw_unavailable(priv);
 	if (ret)
 		return ret;
 
-	ret = pd692x0_pi_get_voltage(pcdev, id);
-	if (ret < 0)
-		return ret;
-	uV = ret;
-
 	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
 	msg.sub[2] = id;
-	tmp_64 = uV;
-	tmp_64 *= max_uA;
-	/* mW = uV * uA / 1000000000 */
-	mW = DIV_ROUND_CLOSEST_ULL(tmp_64, 1000000000);
-	ret = pd692x0_pi_set_pw_from_table(dev, &msg, mW);
+	ret = pd692x0_pi_set_pw_from_table(dev, &msg, max_mW);
 	if (ret)
 		return ret;
 
@@ -1068,8 +1043,8 @@ static const struct pse_controller_ops pd692x0_ops = {
 	.pi_disable = pd692x0_pi_disable,
 	.pi_is_enabled = pd692x0_pi_is_enabled,
 	.pi_get_voltage = pd692x0_pi_get_voltage,
-	.pi_get_current_limit = pd692x0_pi_get_current_limit,
-	.pi_set_current_limit = pd692x0_pi_set_current_limit,
+	.pi_get_pw_limit = pd692x0_pi_get_pw_limit,
+	.pi_set_pw_limit = pd692x0_pi_set_pw_limit,
 };
 
 #define PD692X0_FW_LINE_MAX_SZ 0xff
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 432b6c2c04f8..ae819bfed1b1 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -291,33 +291,25 @@ static int pse_pi_get_voltage(struct regulator_dev *rdev)
 	return ret;
 }
 
-static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
-				   int id,
-				   struct netlink_ext_ack *extack,
-				   struct pse_control_status *status);
-
 static int pse_pi_get_current_limit(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
 	const struct pse_controller_ops *ops;
-	struct netlink_ext_ack extack = {};
-	struct pse_control_status st = {};
-	int id, uV, ret;
+	int id, uV, mW, ret;
 	s64 tmp_64;
 
 	ops = pcdev->ops;
 	id = rdev_get_id(rdev);
+	if (!ops->pi_get_pw_limit || !ops->pi_get_voltage)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&pcdev->lock);
-	if (ops->pi_get_current_limit) {
-		ret = ops->pi_get_current_limit(pcdev, id);
+	ret = ops->pi_get_pw_limit(pcdev, id);
+	if (ret < 0)
 		goto out;
-	}
+	mW = ret;
 
-	/* If pi_get_current_limit() callback not populated get voltage
-	 * from pi_get_voltage() and power limit from ethtool_get_status()
-	 *  to calculate current limit.
-	 */
-	ret = _pse_pi_get_voltage(rdev);
+	ret = pse_pi_get_voltage(rdev);
 	if (!ret) {
 		dev_err(pcdev->dev, "Voltage null\n");
 		ret = -ERANGE;
@@ -327,16 +319,7 @@ static int pse_pi_get_current_limit(struct regulator_dev *rdev)
 		goto out;
 	uV = ret;
 
-	ret = _pse_ethtool_get_status(pcdev, id, &extack, &st);
-	if (ret)
-		goto out;
-
-	if (!st.c33_avail_pw_limit) {
-		ret = -ENODATA;
-		goto out;
-	}
-
-	tmp_64 = st.c33_avail_pw_limit;
+	tmp_64 = mW;
 	tmp_64 *= 1000000000ull;
 	/* uA = mW * 1000000000 / uV */
 	ret = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
@@ -351,10 +334,11 @@ static int pse_pi_set_current_limit(struct regulator_dev *rdev, int min_uA,
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
 	const struct pse_controller_ops *ops;
-	int id, ret;
+	int id, mW, ret;
+	s64 tmp_64;
 
 	ops = pcdev->ops;
-	if (!ops->pi_set_current_limit)
+	if (!ops->pi_set_pw_limit || !ops->pi_get_voltage)
 		return -EOPNOTSUPP;
 
 	if (max_uA > MAX_PI_CURRENT)
@@ -362,7 +346,21 @@ static int pse_pi_set_current_limit(struct regulator_dev *rdev, int min_uA,
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
-	ret = ops->pi_set_current_limit(pcdev, id, max_uA);
+	ret = pse_pi_get_voltage(rdev);
+	if (!ret) {
+		dev_err(pcdev->dev, "Voltage null\n");
+		ret = -ERANGE;
+		goto out;
+	}
+	if (ret < 0)
+		goto out;
+
+	tmp_64 = ret;
+	tmp_64 *= max_uA;
+	/* mW = uA * uV / 1000000000 */
+	mW = DIV_ROUND_CLOSEST_ULL(tmp_64, 1000000000);
+	ret = ops->pi_set_pw_limit(pcdev, id, mW);
+out:
 	mutex_unlock(&pcdev->lock);
 
 	return ret;
@@ -406,7 +404,7 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 
 	rinit_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
 
-	if (pcdev->ops->pi_set_current_limit)
+	if (pcdev->ops->pi_set_pw_limit)
 		rinit_data->constraints.valid_ops_mask |=
 			REGULATOR_CHANGE_CURRENT;
 
@@ -737,23 +735,6 @@ struct pse_control *of_pse_control_get(struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_pse_control_get);
 
-static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
-				   int id,
-				   struct netlink_ext_ack *extack,
-				   struct pse_control_status *status)
-{
-	const struct pse_controller_ops *ops;
-
-	ops = pcdev->ops;
-	if (!ops->ethtool_get_status) {
-		NL_SET_ERR_MSG(extack,
-			       "PSE driver does not support status report");
-		return -EOPNOTSUPP;
-	}
-
-	return ops->ethtool_get_status(pcdev, id, extack, status);
-}
-
 /**
  * pse_ethtool_get_status - get status of PSE control
  * @psec: PSE control pointer
@@ -766,11 +747,21 @@ int pse_ethtool_get_status(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
 			   struct pse_control_status *status)
 {
+	const struct pse_controller_ops *ops;
+	struct pse_controller_dev *pcdev;
 	int err;
 
-	mutex_lock(&psec->pcdev->lock);
-	err = _pse_ethtool_get_status(psec->pcdev, psec->id, extack, status);
-	mutex_unlock(&psec->pcdev->lock);
+	pcdev = psec->pcdev;
+	ops = pcdev->ops;
+	if (!ops->ethtool_get_status) {
+		NL_SET_ERR_MSG(extack,
+			       "PSE driver does not support status report");
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&pcdev->lock);
+	err = ops->ethtool_get_status(pcdev, psec->id, extack, status);
+	mutex_unlock(&pcdev->lock);
 
 	return err;
 }
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index bc5addccbf32..a721651cd1e0 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -77,12 +77,8 @@ struct pse_control_status {
  * @pi_disable: Configure the PSE PI as disabled.
  * @pi_get_voltage: Return voltage similarly to get_voltage regulator
  *		    callback.
- * @pi_get_current_limit: Get the configured current limit similarly to
- *			  get_current_limit regulator callback.
- * @pi_set_current_limit: Configure the current limit similarly to
- *			  set_current_limit regulator callback.
- *			  Should not return an error in case of MAX_PI_CURRENT
- *			  current value set.
+ * @pi_get_pw_limit: Get the configured power limit of the PSE PI.
+ * @pi_set_pw_limit: Configure the power limit of the PSE PI.
  */
 struct pse_controller_ops {
 	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
@@ -93,10 +89,10 @@ struct pse_controller_ops {
 	int (*pi_enable)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_disable)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_get_voltage)(struct pse_controller_dev *pcdev, int id);
-	int (*pi_get_current_limit)(struct pse_controller_dev *pcdev,
-				    int id);
-	int (*pi_set_current_limit)(struct pse_controller_dev *pcdev,
-				    int id, int max_uA);
+	int (*pi_get_pw_limit)(struct pse_controller_dev *pcdev,
+			       int id);
+	int (*pi_set_pw_limit)(struct pse_controller_dev *pcdev,
+			       int id, int max_mW);
 };
 
 struct module;

-- 
2.34.1


