Return-Path: <netdev+bounces-101707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02288FFD27
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF152819B5
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E16A155747;
	Fri,  7 Jun 2024 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PyfVEk3U"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5E1552EF;
	Fri,  7 Jun 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745444; cv=none; b=TLIpODLvmyURMTXUDz4uZUUHZU/c7lydfs/s6OOfX/PHrppgTM5BOqdoCSlJ6GiqBm7mYF5jD701rMv24ugQIMhMpMPkrTIeN26Hd6GQR82ag3HJnN+Qv1vc0lhwIWnNicSI3GgurXS+8DuZRJNyrkgOmNMTNUE0AlJWTbifyKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745444; c=relaxed/simple;
	bh=vpziy2yt9uns9oOvuavclPcqfqF4YYX4KJozNt14TgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JfAyU+DFG8qmX+8k2hE5C0N6SynHWD28Bc8EvoMcORS3Ow05Htoc/itPglAyfuzEr1UYNhqZD6Ry2o+vpTIwAj4IKIxRqiRXzMiklInKOb7Awse7jKvs4ng+IYRnvKDAZp4zwPxKvJvza7TNvAWpLoe1phRV8CL5Kw5aqoepoJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PyfVEk3U; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E690940009;
	Fri,  7 Jun 2024 07:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717745440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wBEGqtaq+OZu9K40oURltPWmV587yw0Q9blDuzJ46g=;
	b=PyfVEk3Uq0kGLvRcE/qsiGagjkhU+UpNKPOGdvApHhh2ykgv0Ddcx35+goHy4OfN6eii3I
	Hv5lcxJN2vptu2MsJPx8y2+ubuv4vxzvWsN99AItc/tiy9VUqxjZQ+HtFryK6hckxzi9Ci
	T6aeE6y6h2KiQhtUkgEdvveA7u6noQQ9k8Fz5Xe35ybhxPgQ+lKkKTZh8gQx59TfaWp6/s
	lpL//MjSuJ1TjSUFFjWCZMFg3HYwBZi0zSiyp9+o4/cxSdWB2RgIWNOohouLYQ5/gSf6JR
	SOaDpis+pT8icZvVgUFtRH3pQq/Xb7AAiN8iyeBaMf+5ghZCU4R5As5w4UocIg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 07 Jun 2024 09:30:22 +0200
Subject: [PATCH net-next v2 5/8] net: pse-pd: Add new power limit get and
 set c33 features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-feature_poe_power_cap-v2-5-c03c2deb83ab@bootlin.com>
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

This patch add a way to get and set the power limit of a PSE PI.
For that it uses regulator API callbacks wrapper like get_voltage() and
get/set_current_limit() as power is simply V * I.
We used mW unit as defined by the IEEE 802.3-2022 standards.

set_current_limit() uses the voltage return by get_voltage() and the
desired power limit to calculate the current limit. get_voltage() callback
is then mandatory to set the power limit.

get_current_limit() callback is by default looking at a driver callback
and fallback to extracting the current limit from _pse_ethtool_get_status()
if the driver does not set its callback. We prefer let the user the choice
because ethtool_get_status return much more information than the current
limit.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Use uA and uV instead of mA and mV to have more precision in the power
  calculation. Need to use 64bit variables for the calculation.
---
 drivers/net/pse-pd/pse_core.c | 172 +++++++++++++++++++++++++++++++++++++++---
 include/linux/pse-pd/pse.h    |  34 +++++++++
 2 files changed, 195 insertions(+), 11 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 795ab264eaf2..98da4488a8fe 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -265,10 +265,113 @@ static int pse_pi_disable(struct regulator_dev *rdev)
 	return ret;
 }
 
+static int _pse_pi_get_voltage(struct regulator_dev *rdev)
+{
+	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
+	const struct pse_controller_ops *ops;
+	int id;
+
+	ops = pcdev->ops;
+	if (!ops->pi_get_voltage)
+		return -EOPNOTSUPP;
+
+	id = rdev_get_id(rdev);
+	return ops->pi_get_voltage(pcdev, id);
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
+	int id, uV, ret;
+	s64 tmp_64;
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
+	uV = ret;
+
+	ret = _pse_ethtool_get_status(pcdev, id, &extack, &st);
+	if (ret)
+		goto out;
+
+	if (!st.c33_pw_limit) {
+		ret = -ENODATA;
+		goto out;
+	}
+
+	tmp_64 = st.c33_pw_limit;
+	tmp_64 *= 1000000000ull;
+	/* uA = mW * 1000000000 / uV */
+	ret = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
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
+	ret = ops->pi_set_current_limit(pcdev, id, max_uA);
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
@@ -298,7 +401,9 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 	rdesc->ops = &pse_pi_ops;
 	rdesc->owner = pcdev->owner;
 
-	rinit_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
+	rinit_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS |
+						 REGULATOR_CHANGE_CURRENT;
+	rinit_data->constraints.max_uA = MAX_PI_CURRENT;
 	rinit_data->supply_regulator = "vpwr";
 
 	rconfig.dev = pcdev->dev;
@@ -626,6 +731,23 @@ struct pse_control *of_pse_control_get(struct device_node *node)
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
@@ -638,19 +760,10 @@ int pse_ethtool_get_status(struct pse_control *psec,
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
@@ -732,6 +845,43 @@ int pse_ethtool_set_config(struct pse_control *psec,
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
+	int uV, uA, ret;
+	s64 tmp_64;
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
+	tmp_64 = pw_limit;
+	tmp_64 *= 1000000000ull;
+	/* uA = mW * 1000000000 / uV */
+	uA = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
+
+	return regulator_set_current_limit(psec->ps, 0, uA);
+}
+EXPORT_SYMBOL_GPL(pse_ethtool_set_pw_limit);
+
 bool pse_has_podl(struct pse_control *psec)
 {
 	return psec->pcdev->types & ETHTOOL_PSE_PODL;
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 38b9308e5e7a..e9a7f0e5e555 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -9,6 +9,9 @@
 #include <linux/list.h>
 #include <uapi/linux/ethtool.h>
 
+/* Maximum current in uA according to IEEE 802.3-2022 Table 145-1 */
+#define MAX_PI_CURRENT 1920000
+
 struct phy_device;
 struct pse_controller_dev;
 
@@ -41,6 +44,7 @@ struct pse_control_config {
  * @c33_actual_pw: power currently delivered by the PSE in mW
  *	IEEE 802.3-2022 30.9.1.1.23 aPSEActualPower
  * @c33_ext_state_info: extended state information of the PSE
+ * @c33_pw_limit: power limit of the PSE
  */
 struct pse_control_status {
 	enum ethtool_podl_pse_admin_state podl_admin_state;
@@ -50,6 +54,7 @@ struct pse_control_status {
 	u32 c33_pw_class;
 	u32 c33_actual_pw;
 	struct ethtool_c33_pse_ext_state_info c33_ext_state_info;
+	u32 c33_pw_limit;
 };
 
 /**
@@ -61,6 +66,12 @@ struct pse_control_status {
  *		   May also return negative errno.
  * @pi_enable: Configure the PSE PI as enabled.
  * @pi_disable: Configure the PSE PI as disabled.
+ * @pi_get_voltage: Return voltage similarly to get_voltage regulator
+ *		    callback.
+ * @pi_get_current_limit: Get the configured current limit similarly to
+ *			  get_current_limit regulator callback.
+ * @pi_set_current_limit: Configure the current limit similarly to
+ *			  set_current_limit regulator callback.
  */
 struct pse_controller_ops {
 	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
@@ -70,6 +81,11 @@ struct pse_controller_ops {
 	int (*pi_is_enabled)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_enable)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_disable)(struct pse_controller_dev *pcdev, int id);
+	int (*pi_get_voltage)(struct pse_controller_dev *pcdev, int id);
+	int (*pi_get_current_limit)(struct pse_controller_dev *pcdev,
+				    int id);
+	int (*pi_set_current_limit)(struct pse_controller_dev *pcdev,
+				    int id, int max_uA);
 };
 
 struct module;
@@ -156,6 +172,11 @@ int pse_ethtool_get_status(struct pse_control *psec,
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
@@ -185,6 +206,19 @@ static inline int pse_ethtool_set_config(struct pse_control *psec,
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


