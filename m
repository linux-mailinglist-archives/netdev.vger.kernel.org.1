Return-Path: <netdev+bounces-146668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6FC9D4F08
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020F21F21244
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF1C1E00BE;
	Thu, 21 Nov 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VdPQ1Pzt"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290FD1E009B;
	Thu, 21 Nov 2024 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200251; cv=none; b=mp+TGU9PRwgBnGR2uv8pnZhKt+xbJa1uYUtcfyNSNbQaCaCkzRDKBPK3++WUZNCloTJsMs9sTrCShlhqszTmZG1W7CF3+k9mSjYDCgDAXz9ixmfuiV/zwfguEdhOlTxbupqOff8nRelCYglCgcEB26hrMl0/DnBeCjUATAWcE9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200251; c=relaxed/simple;
	bh=f8G5srbt+NdUisJx7UVblCJrh84QznUzTZYMEE2Brcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d6POmhbqJluNrrK2YAYCmSM5et5Ut4v/ohlgedbKVvN0ZQxUIyaKBYW4MaGbzz9V1BOpDR7VsvEyOLDntd3atX2CthvlIvkSK3SEjsqGc+XJjHkjNMzTGJBq+XIAfxPEHMtedx6gqGRQdOYX4SFG+u0pP2cJnVmiLq7wxR8ghts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VdPQ1Pzt; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 555974000E;
	Thu, 21 Nov 2024 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oitQokj0j3eWr60sys9itIeEYJx4Zq/Y2Qd1sTJJauM=;
	b=VdPQ1Pztpctb4Q8xW4uto+ktk+o6pm6TDPEtbazVur+WfZehQ29MqwTUHgl/9FF1w4qvRY
	PVTvdesBEj+iyXdws50/wFe7071W6DAj22m4xxfhCYTr9zxPuK71gEeibrBjI52nZCWVzy
	V9k58St61T/CN3irGADmOjhvqPg8xKMZtlwXeG8z5vwTSHRwWolVHjgNzpJmrxNPyqMcic
	SOJKA+vGs+Lys8NVbgF5ISgqN0LrJyltZzttUj1XLEjoV1Sf0IFBVSqP8yaf7qAcs2hGg5
	nYgwj65pmcd5uzrJm2a8+F0o7NLaZ1FJZ8aziMHKjv3XWIW673A8M5h4FldMnw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:42 +0100
Subject: [PATCH RFC net-next v3 16/27] regulator: Add support for power
 budget description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-16-83299fa6967c@bootlin.com>
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

In preparation for future support of PSE port priority and power
management, we need the power budget value of the power supply.
This addition allows the regulator to track the available power
capacity, which will be essential for prioritizing ports when
making power allocation decisions.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

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
index b49f751893b9..828b4dd10f68 100644
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
+	return sprintf(buf, "%d\n", rdev->pw_available);
+}
+static DEVICE_ATTR_RO(power_budget);
+
 #define REGULATOR_ERROR_ATTR(name, bit)							\
 	static ssize_t name##_show(struct device *dev, struct device_attribute *attr,	\
 				   char *buf)						\
@@ -1149,6 +1158,10 @@ static void print_constraints_debug(struct regulator_dev *rdev)
 	if (constraints->valid_modes_mask & REGULATOR_MODE_STANDBY)
 		count += scnprintf(buf + count, len - count, "standby ");
 
+	if (constraints->pw_budget)
+		count += scnprintf(buf + count, len - count, "%d mW budget",
+				   constraints->pw_budget);
+
 	if (!count)
 		count = scnprintf(buf, len, "no parameters");
 	else
@@ -1627,6 +1640,13 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 		rdev->last_off = ktime_get();
 	}
 
+	if (rdev->constraints->pw_budget)
+		rdev->pw_available = rdev->constraints->pw_budget;
+	else if (rdev->supply)
+		rdev->pw_available = regulator_get_power_budget(rdev->supply);
+	else
+		rdev->pw_available = INT_MAX;
+
 	print_constraints(rdev);
 	return 0;
 }
@@ -4641,6 +4661,71 @@ int regulator_get_current_limit(struct regulator *regulator)
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
+	return regulator->rdev->pw_available;
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
+	if (pw_req > rdev->pw_available) {
+		rdev_dbg(rdev, "power requested %d mW out of budget %d mW",
+			 pw_req, rdev->pw_available);
+		ret = -ERANGE;
+		goto out;
+	}
+
+	rdev->pw_available -= pw_req;
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
+	rdev->pw_available += pw;
+	regulator_unlock(rdev);
+}
+EXPORT_SYMBOL_GPL(regulator_free_power_budget);
+
 /**
  * regulator_set_mode - set regulator operating mode
  * @regulator: regulator source
@@ -5279,6 +5364,7 @@ static struct attribute *regulator_dev_attrs[] = {
 	&dev_attr_suspend_standby_mode.attr,
 	&dev_attr_suspend_mem_mode.attr,
 	&dev_attr_suspend_disk_mode.attr,
+	&dev_attr_power_budget.attr,
 	NULL
 };
 
@@ -5360,6 +5446,9 @@ static umode_t regulator_attr_is_visible(struct kobject *kobj,
 	    attr == &dev_attr_suspend_disk_mode.attr)
 		return ops->set_suspend_mode ? mode : 0;
 
+	if (attr == &dev_attr_power_budget.attr)
+		return rdev->pw_available != INT_MAX ? mode : 0;
+
 	return mode;
 }
 
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 3f490d81abc2..a8996e7597d4 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -125,6 +125,9 @@ static int of_get_regulation_constraints(struct device *dev,
 	if (constraints->min_uA != constraints->max_uA)
 		constraints->valid_ops_mask |= REGULATOR_CHANGE_CURRENT;
 
+	if (!of_property_read_u32(np, "regulator-power-budget", &pval))
+		constraints->pw_budget = pval;
+
 	constraints->boot_on = of_property_read_bool(np, "regulator-boot-on");
 	constraints->always_on = of_property_read_bool(np, "regulator-always-on");
 	if (!constraints->always_on) /* status change should be possible. */
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index b9ce521910a0..8f0a0e98d7ee 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -235,6 +235,11 @@ int regulator_sync_voltage(struct regulator *regulator);
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
@@ -534,6 +539,22 @@ static inline int regulator_get_current_limit(struct regulator *regulator)
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
index f230a472ccd3..e006d0c19542 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -649,6 +649,8 @@ struct regulator_dev {
 	int cached_err;
 	bool use_cached_err;
 	spinlock_t err_lock;
+
+	int pw_available;
 };
 
 /*
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 0cd76d264727..3304cf8773b7 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -113,6 +113,7 @@ struct notification_limit {
  * @min_uA: Smallest current consumers may set.
  * @max_uA: Largest current consumers may set.
  * @ilim_uA: Maximum input current.
+ * @pw_budget: Power budget for the regulator in mW.
  * @system_load: Load that isn't captured by any consumer requests.
  *
  * @over_curr_limits:		Limits for acting on over current.
@@ -185,6 +186,7 @@ struct regulation_constraints {
 	int max_uA;
 	int ilim_uA;
 
+	int pw_budget;
 	int system_load;
 
 	/* used for coupled regulators */

-- 
2.34.1


