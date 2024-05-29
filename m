Return-Path: <netdev+bounces-99056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 175008D38CC
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399001C2061D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B0428DC3;
	Wed, 29 May 2024 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pju2ZMmY"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F2A1CD2C;
	Wed, 29 May 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991782; cv=none; b=kVmYATvU0fJhqMkXVZU7tkJ+/w3qZCo8sAN6OyElnB3kk+LtkjonnQ9rxk7nFl5jMN9J0fkkMewBeGemGsQ3cY96KNz6Y3Tn/qex3vgnpklvukXGQUo2qD6WRMpuKrB3SpN1WqF3YCq8v+l7Icxj0mxbdAA5Dk2w/LUN92zVLvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991782; c=relaxed/simple;
	bh=Y7OGJhWiKmo0TMiS+MmC2FCPbidwOhNSNMsithmGej8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PojogII8UfuDZ9zcKMyuzJAHW8jaNad4xYKOvMfczLz6soTnhKWN7s/bxXIS5YyEzf8spOEK2t2NbdtlA+T5+/XXSTEz4JPngv8GCwA2b2vk2EgfZFHmYcl6uUZKzOnkwGccbc0MSE6mRGMt7lPduab4SShAveanXktlFXxOpj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pju2ZMmY; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DD9D4000B;
	Wed, 29 May 2024 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716991778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HbELY3z7SEgeb5R/cvgER6KpGBkVV6b13kO0dOX4GY=;
	b=pju2ZMmY3aKdyJ1BJz1GZxv0dSwHVQHS32QePbxxXpsXkEGxtcqP2v9rbgirfZ0L2j35GU
	ylATByEOsPf/X7J20VvUSIgsVu91HiIKR5H3Q5f6eiV7M+/tqmgrjVUwK5UuUbO7P9pzPB
	83zsrVtHkAOl9a3p2XdEWOGkGmfF4gxYS1TeLKmbEppMdqAB2d05zm8pKR/zJl8U4cj9Sf
	DsrtskCGfrN5mxIiqD+oU/1TdWLO2nZBzmjWJW3bMQKkJuQQsPiDVXShb9p773QzkUAWw/
	v1VHXFWt7+0S0jwZZSOc5sCJIvYpbTBh8RrxfapYBwZhaEwGwMHkdN9t76eIcg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 29 May 2024 16:09:32 +0200
Subject: [PATCH 5/8] net: pse-pd: Add new power limit get and set c33
 features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-feature_poe_power_cap-v1-5-0c4b1d5953b8@bootlin.com>
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

This patch add a way to get and set the power limit of a PSE PI.
For that it uses regulator API callbacks wrapper like get_voltage() and
get/set_current_limit() as power is simply V * I.
We used mW unit as defined by the IEEE 802.3-2022 standards.

set_current_limit() uses the voltage return by get_voltage() and the desired
power limit to calculate the current limit. get_voltage() callback is then
mandatory to set the power limit.

get_current_limit() callback is by default looking at a driver callback
and fallback to extracting the current limit from _pse_ethtool_get_status()
if the driver does not set its callback. We prefer let the user the choice
because ethtool_get_status return much more information than the current
limit.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_core.c | 169 +++++++++++++++++++++++++++++++++++++++---
 include/linux/pse-pd/pse.h    |  36 +++++++++
 2 files changed, 194 insertions(+), 11 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 795ab264eaf2..d0f92e225cef 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -265,10 +265,110 @@ static int pse_pi_disable(struct regulator_dev *rdev)
 	return ret;
 }
 
+static int _pse_pi_get_voltage(struct regulator_dev *rdev)
+{
+	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
+	const struct pse_controller_ops *ops;
+	int id, ret;
+
+	ops = pcdev->ops;
+	if (!ops->pi_get_voltage)
+		return -EOPNOTSUPP;
+
+	id = rdev_get_id(rdev);
+	ret = ops->pi_get_voltage(pcdev, id);
+	if (ret > 0)
+		ret *= 1000;
+
+	return ret;
+}
+
+static int pse_pi_get_voltage(struct regulator_dev *rdev)
+{
+	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
+	int ret;
+
+	mutex_lock(&pcdev->lock);
+	ret = _pse_pi_get_voltage(rdev);
+	mutex_unlock(&pcdev->lock);
+
+	return ret;
+}
+
+static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
+				   int id,
+				   struct netlink_ext_ack *extack,
+				   struct pse_control_status *status);
+
+static int pse_pi_get_current_limit(struct regulator_dev *rdev)
+{
+	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
+	const struct pse_controller_ops *ops;
+	struct netlink_ext_ack extack = {};
+	struct pse_control_status st = {};
+	int id, mV, ret;
+
+	ops = pcdev->ops;
+	id = rdev_get_id(rdev);
+	mutex_lock(&pcdev->lock);
+	if (ops->pi_get_current_limit) {
+		ret = ops->pi_get_current_limit(pcdev, id);
+		goto out;
+	}
+
+	/* If pi_get_current_limit() callback not populated get voltage
+	 * from pi_get_voltage() and power limit from ethtool_get_status()
+	 *  to calculate current limit.
+	 */
+	ret = _pse_pi_get_voltage(rdev);
+	if (!ret) {
+		dev_err(pcdev->dev, "Voltage null\n");
+		ret = -ERANGE;
+		goto out;
+	}
+	if (ret < 0)
+		goto out;
+	mV = ret;
+
+	ret = _pse_ethtool_get_status(pcdev, id, &extack, &st);
+	if (ret)
+		goto out;
+
+	if (st.c33_pw_limit)
+		/* mA = mW * 1000 / mV */
+		ret = st.c33_pw_limit * 1000 / mV;
+
+out:
+	mutex_unlock(&pcdev->lock);
+	return ret;
+}
+
+static int pse_pi_set_current_limit(struct regulator_dev *rdev, int min_uA,
+				    int max_uA)
+{
+	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
+	const struct pse_controller_ops *ops;
+	int id, ret;
+
+	ops = pcdev->ops;
+	if (!ops->pi_set_current_limit)
+		return -EOPNOTSUPP;
+
+	id = rdev_get_id(rdev);
+	mutex_lock(&pcdev->lock);
+	ret = ops->pi_set_current_limit(pcdev, id, max_uA / 1000);
+	mutex_unlock(&pcdev->lock);
+
+	return ret;
+}
+
 static const struct regulator_ops pse_pi_ops = {
 	.is_enabled = pse_pi_is_enabled,
 	.enable = pse_pi_enable,
 	.disable = pse_pi_disable,
+	.get_voltage = pse_pi_get_voltage,
+	.get_current_limit = pse_pi_get_current_limit,
+	.set_current_limit = pse_pi_set_current_limit,
 };
 
 static int
@@ -298,7 +398,9 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 	rdesc->ops = &pse_pi_ops;
 	rdesc->owner = pcdev->owner;
 
-	rinit_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
+	rinit_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS |
+						 REGULATOR_CHANGE_CURRENT;
+	rinit_data->constraints.max_uA = MAX_PI_CURRENT * 1000;
 	rinit_data->supply_regulator = "vpwr";
 
 	rconfig.dev = pcdev->dev;
@@ -626,6 +728,23 @@ struct pse_control *of_pse_control_get(struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_pse_control_get);
 
+static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
+				   int id,
+				   struct netlink_ext_ack *extack,
+				   struct pse_control_status *status)
+{
+	const struct pse_controller_ops *ops;
+
+	ops = pcdev->ops;
+	if (!ops->ethtool_get_status) {
+		NL_SET_ERR_MSG(extack,
+			       "PSE driver does not support status report");
+		return -EOPNOTSUPP;
+	}
+
+	return ops->ethtool_get_status(pcdev, id, extack, status);
+}
+
 /**
  * pse_ethtool_get_status - get status of PSE control
  * @psec: PSE control pointer
@@ -638,19 +757,10 @@ int pse_ethtool_get_status(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
 			   struct pse_control_status *status)
 {
-	const struct pse_controller_ops *ops;
 	int err;
 
-	ops = psec->pcdev->ops;
-
-	if (!ops->ethtool_get_status) {
-		NL_SET_ERR_MSG(extack,
-			       "PSE driver does not support status report");
-		return -EOPNOTSUPP;
-	}
-
 	mutex_lock(&psec->pcdev->lock);
-	err = ops->ethtool_get_status(psec->pcdev, psec->id, extack, status);
+	err = _pse_ethtool_get_status(psec->pcdev, psec->id, extack, status);
 	mutex_unlock(&psec->pcdev->lock);
 
 	return err;
@@ -732,6 +842,43 @@ int pse_ethtool_set_config(struct pse_control *psec,
 }
 EXPORT_SYMBOL_GPL(pse_ethtool_set_config);
 
+/**
+ * pse_ethtool_set_pw_limit - set PSE control power limit
+ * @psec: PSE control pointer
+ * @extack: extack for reporting useful error messages
+ * @pw_limit: power limit value in mW
+ *
+ * Return: 0 on success and failure value on error
+ */
+int pse_ethtool_set_pw_limit(struct pse_control *psec,
+			     struct netlink_ext_ack *extack,
+			     const unsigned int pw_limit)
+{
+	int uV, mA, ret;
+
+	ret = regulator_get_voltage(psec->ps);
+	if (!ret) {
+		NL_SET_ERR_MSG(extack,
+			       "Can't read current voltage");
+		return ret;
+	}
+	if (ret < 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Error reading current voltage");
+		return ret;
+	}
+	uV = ret;
+
+	/* mA = mW * 1000 / ( uV / 1000)
+	 * mA precision is sufficient for PSE, and mW is the power unit
+	 * used in IEEE 802.3-2022 145 standard.
+	 */
+	mA = pw_limit * 1000 / (uV / 1000);
+
+	return regulator_set_current_limit(psec->ps, 0, mA * 1000);
+}
+EXPORT_SYMBOL_GPL(pse_ethtool_set_pw_limit);
+
 bool pse_has_podl(struct pse_control *psec)
 {
 	return psec->pcdev->types & ETHTOOL_PSE_PODL;
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 04219ca20d60..241b43c65137 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -9,6 +9,9 @@
 #include <linux/list.h>
 #include <uapi/linux/ethtool.h>
 
+/* Maximum current in mA according to IEEE 802.3-2022 Table 145-1 */
+#define MAX_PI_CURRENT 1920
+
 struct phy_device;
 struct pse_controller_dev;
 
@@ -41,6 +44,7 @@ struct pse_control_config {
  * @c33_actual_pw: power currently delivered by the PSE in mW
  *	IEEE 802.3-2022 30.9.1.1.23 aPSEActualPower
  * @c33_pw_status_msg: detailed power detection status of the PSE
+ * @c33_pw_limit: power limit of the PSE
  */
 struct pse_control_status {
 	enum ethtool_podl_pse_admin_state podl_admin_state;
@@ -50,6 +54,7 @@ struct pse_control_status {
 	u32 c33_pw_class;
 	u32 c33_actual_pw;
 	const char *c33_pw_status_msg;
+	u32 c33_pw_limit;
 };
 
 /**
@@ -61,6 +66,14 @@ struct pse_control_status {
  *		   May also return negative errno.
  * @pi_enable: Configure the PSE PI as enabled.
  * @pi_disable: Configure the PSE PI as disabled.
+ * @pi_get_voltage: Return voltage similarly to get_voltage regulator
+ *		    callback but in mV unit.
+ * @pi_get_current_limit: Get the configured current limit similarly to
+ *			  get_current_limit regulator callback but in mA
+ *			  unit.
+ * @pi_set_current_limit: Configure the current limit similarly to
+ *                        set_current_limit regulator callback but in mA
+ *                        unit.
  */
 struct pse_controller_ops {
 	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
@@ -70,6 +83,11 @@ struct pse_controller_ops {
 	int (*pi_is_enabled)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_enable)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_disable)(struct pse_controller_dev *pcdev, int id);
+	int (*pi_get_voltage)(struct pse_controller_dev *pcdev, int id);
+	int (*pi_get_current_limit)(struct pse_controller_dev *pcdev,
+				    int id);
+	int (*pi_set_current_limit)(struct pse_controller_dev *pcdev,
+				    int id, int max_mA);
 };
 
 struct module;
@@ -156,6 +174,11 @@ int pse_ethtool_get_status(struct pse_control *psec,
 int pse_ethtool_set_config(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
 			   const struct pse_control_config *config);
+int pse_ethtool_set_pw_limit(struct pse_control *psec,
+			     struct netlink_ext_ack *extack,
+			     const unsigned int pw_limit);
+int pse_ethtool_get_pw_limit(struct pse_control *psec,
+			     struct netlink_ext_ack *extack);
 
 bool pse_has_podl(struct pse_control *psec);
 bool pse_has_c33(struct pse_control *psec);
@@ -185,6 +208,19 @@ static inline int pse_ethtool_set_config(struct pse_control *psec,
 	return -EOPNOTSUPP;
 }
 
+static inline int pse_ethtool_set_pw_limit(struct pse_control *psec,
+					   struct netlink_ext_ack *extack,
+					   const unsigned int pw_limit)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int pse_ethtool_get_pw_limit(struct pse_control *psec,
+					   struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline bool pse_has_podl(struct pse_control *psec)
 {
 	return false;

-- 
2.34.1


