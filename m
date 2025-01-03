Return-Path: <netdev+bounces-155085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E445A00F7E
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E513A51D2
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AA51FE452;
	Fri,  3 Jan 2025 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LlqWuUW4"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D211FCFFC;
	Fri,  3 Jan 2025 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938864; cv=none; b=nQaYCDsZG7tLXxSu8qF6rcwAF4qzSMVCYBzKBux77LGPkY2emQIkeOBUM2KOgRs4g01l2quGNhlsSkQDTsWu0sd+a5Kp7QbDTeq6+Z9Pby8pQSOPv4/JE3HSsWGK6623JcvLtVXlUQnwSJPULDBEZAFmdnqsTmv3j16DsM+NZb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938864; c=relaxed/simple;
	bh=ZOV9X4rvXX103k62Vp2UX4RRjvpp1bJC7AzLY1nPoZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VBRNzycrmyHfkCvTUE39cAa4+RGafzTe+4nCea7GmlINDRg5SqnZ4X6rga5IJbWYOdG4J42s32G2zPgEbbqZNspdBnx3uXtekjg0vibNpf3xQCgJJJWhAy+dGyluCtQAKzWZCjAT9Hf00mejCZQME99012N3SI/ts/Px0jiFcn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LlqWuUW4; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8537DFF802;
	Fri,  3 Jan 2025 21:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735938860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zght5A7UWtU0pjCa/BxxigORWTFX9odniFCryCBvyyk=;
	b=LlqWuUW4oXSSb4HU0Vsvxm1hzIRCHAG+tw0r7NvuYbyVFpy2ubJ9YCAEakhgakDoIBVjVT
	xUJQBUibn5BQcYDik3xtA83FmV/zDA7lW0f2H+bGvMtVMWpS+2pDvRAKC7pqxYx6qvtL1H
	chK0O/a91IBaRk+WWND219d5ZC2aaOanl2GkvbqfnbF1ABkZXfe0ULZs7yrJvjiZVeeyDv
	I2m3LWqWjV/DxU4v53/9plAuuGafjpGFTWr1dXLk3V3TeLzHeChDI3Pji2Eo8+gNzq0x7Z
	5DCJ9AF8EP6ZtvYdnAUK9DAUDZ+OL9p5I0yB/HeHjynWJMwMPNKj8af/XaoCTg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Jan 2025 22:13:06 +0100
Subject: [PATCH net-next v4 17/27] regulator: Add support for power budget
 description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-feature_poe_port_prio-v4-17-dc91a3c0c187@bootlin.com>
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

In preparation for future support of PSE port priority and power
management, we need the power budget value of the power supply.
This addition allows the regulator to track the available power
capacity, which will be essential for prioritizing ports when
making power allocation decisions.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v4:
- Add mW unit at the end of power variables.

Changes in v3:
- Add management of available power.

Changes in v2:
- new patch.
---
 drivers/regulator/core.c           | 89 ++++++++++++++++++++++++++++++++++++++
 drivers/regulator/of_regulator.c   |  3 ++
 include/linux/regulator/consumer.h | 21 +++++++++
 include/linux/regulator/driver.h   |  2 +
 include/linux/regulator/machine.h  |  2 +
 5 files changed, 117 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c092b78c5f12..c86092220b70 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -917,6 +917,15 @@ static ssize_t bypass_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(bypass);
 
+static ssize_t power_budget_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct regulator_dev *rdev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", rdev->pw_available_mW);
+}
+static DEVICE_ATTR_RO(power_budget);
+
 #define REGULATOR_ERROR_ATTR(name, bit)							\
 	static ssize_t name##_show(struct device *dev, struct device_attribute *attr,	\
 				   char *buf)						\
@@ -1149,6 +1158,10 @@ static void print_constraints_debug(struct regulator_dev *rdev)
 	if (constraints->valid_modes_mask & REGULATOR_MODE_STANDBY)
 		count += scnprintf(buf + count, len - count, "standby ");
 
+	if (constraints->pw_budget_mW)
+		count += scnprintf(buf + count, len - count, "%d mW budget",
+				   constraints->pw_budget_mW);
+
 	if (!count)
 		count = scnprintf(buf, len, "no parameters");
 	else
@@ -1627,6 +1640,13 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 		rdev->last_off = ktime_get();
 	}
 
+	if (rdev->constraints->pw_budget_mW)
+		rdev->pw_available_mW = rdev->constraints->pw_budget_mW;
+	else if (rdev->supply)
+		rdev->pw_available_mW = regulator_get_power_budget(rdev->supply);
+	else
+		rdev->pw_available_mW = INT_MAX;
+
 	print_constraints(rdev);
 	return 0;
 }
@@ -4601,6 +4621,71 @@ int regulator_get_current_limit(struct regulator *regulator)
 }
 EXPORT_SYMBOL_GPL(regulator_get_current_limit);
 
+/**
+ * regulator_get_power_budget - get regulator total power budget
+ * @regulator: regulator source
+ *
+ * Return: Power budget of the regulator in mW.
+ */
+int regulator_get_power_budget(struct regulator *regulator)
+{
+	return regulator->rdev->pw_available_mW;
+}
+EXPORT_SYMBOL_GPL(regulator_get_power_budget);
+
+/**
+ * regulator_request_power_budget - request power budget on a regulator
+ * @regulator: regulator source
+ * @pw_req: Power requested
+ *
+ * Return: 0 on success or a negative error number on failure.
+ */
+int regulator_request_power_budget(struct regulator *regulator,
+				   unsigned int pw_req)
+{
+	struct regulator_dev *rdev = regulator->rdev;
+	int ret = 0;
+
+	regulator_lock(rdev);
+	if (rdev->supply) {
+		ret = regulator_request_power_budget(rdev->supply, pw_req);
+		if (ret < 0)
+			goto out;
+	}
+	if (pw_req > rdev->pw_available_mW) {
+		rdev_dbg(rdev, "power requested %d mW out of budget %d mW",
+			 pw_req, rdev->pw_available_mW);
+		ret = -ERANGE;
+		goto out;
+	}
+
+	rdev->pw_available_mW -= pw_req;
+out:
+	regulator_unlock(rdev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regulator_request_power_budget);
+
+/**
+ * regulator_free_power_budget - free power budget on a regulator
+ * @regulator: regulator source
+ * @pw: Power to be released.
+ *
+ * Return: Power budget of the regulator in mW.
+ */
+void regulator_free_power_budget(struct regulator *regulator,
+				 unsigned int pw)
+{
+	struct regulator_dev *rdev = regulator->rdev;
+
+	regulator_lock(rdev);
+	if (rdev->supply)
+		regulator_free_power_budget(rdev->supply, pw);
+	rdev->pw_available_mW += pw;
+	regulator_unlock(rdev);
+}
+EXPORT_SYMBOL_GPL(regulator_free_power_budget);
+
 /**
  * regulator_set_mode - set regulator operating mode
  * @regulator: regulator source
@@ -5239,6 +5324,7 @@ static struct attribute *regulator_dev_attrs[] = {
 	&dev_attr_suspend_standby_mode.attr,
 	&dev_attr_suspend_mem_mode.attr,
 	&dev_attr_suspend_disk_mode.attr,
+	&dev_attr_power_budget.attr,
 	NULL
 };
 
@@ -5320,6 +5406,9 @@ static umode_t regulator_attr_is_visible(struct kobject *kobj,
 	    attr == &dev_attr_suspend_disk_mode.attr)
 		return ops->set_suspend_mode ? mode : 0;
 
+	if (attr == &dev_attr_power_budget.attr)
+		return rdev->pw_available_mW != INT_MAX ? mode : 0;
+
 	return mode;
 }
 
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 3d85762beda6..129a8c4ff62a 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -125,6 +125,9 @@ static int of_get_regulation_constraints(struct device *dev,
 	if (constraints->min_uA != constraints->max_uA)
 		constraints->valid_ops_mask |= REGULATOR_CHANGE_CURRENT;
 
+	if (!of_property_read_u32(np, "regulator-power-budget-miniwatt", &pval))
+		constraints->pw_budget_mW = pval;
+
 	constraints->boot_on = of_property_read_bool(np, "regulator-boot-on");
 	constraints->always_on = of_property_read_bool(np, "regulator-always-on");
 	if (!constraints->always_on) /* status change should be possible. */
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 8c3c372ad735..8598078c36d1 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -258,6 +258,11 @@ int regulator_sync_voltage(struct regulator *regulator);
 int regulator_set_current_limit(struct regulator *regulator,
 			       int min_uA, int max_uA);
 int regulator_get_current_limit(struct regulator *regulator);
+int regulator_get_power_budget(struct regulator *regulator);
+int regulator_request_power_budget(struct regulator *regulator,
+				   unsigned int pw_req);
+void regulator_free_power_budget(struct regulator *regulator,
+				 unsigned int pw);
 
 int regulator_set_mode(struct regulator *regulator, unsigned int mode);
 unsigned int regulator_get_mode(struct regulator *regulator);
@@ -571,6 +576,22 @@ static inline int regulator_get_current_limit(struct regulator *regulator)
 	return 0;
 }
 
+static inline int regulator_get_power_budget(struct regulator *regulator)
+{
+	return INT_MAX;
+}
+
+static inline int regulator_request_power_budget(struct regulator *regulator,
+						 unsigned int pw_req)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void regulator_free_power_budget(struct regulator *regulator,
+					       unsigned int pw)
+{
+}
+
 static inline int regulator_set_mode(struct regulator *regulator,
 	unsigned int mode)
 {
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 5b66caf1695d..9e436b4d7c4c 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -656,6 +656,8 @@ struct regulator_dev {
 	int cached_err;
 	bool use_cached_err;
 	spinlock_t err_lock;
+
+	int pw_available_mW;
 };
 
 /*
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index b3db09a7429b..1fc440c5c4c7 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -113,6 +113,7 @@ struct notification_limit {
  * @min_uA: Smallest current consumers may set.
  * @max_uA: Largest current consumers may set.
  * @ilim_uA: Maximum input current.
+ * @pw_budget_mW: Power budget for the regulator in mW.
  * @system_load: Load that isn't captured by any consumer requests.
  *
  * @over_curr_limits:		Limits for acting on over current.
@@ -185,6 +186,7 @@ struct regulation_constraints {
 	int max_uA;
 	int ilim_uA;
 
+	int pw_budget_mW;
 	int system_load;
 
 	/* used for coupled regulators */

-- 
2.34.1


