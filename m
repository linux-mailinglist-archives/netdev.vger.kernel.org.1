Return-Path: <netdev+bounces-140484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444A39B69E9
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02977281FE5
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62DF228B4E;
	Wed, 30 Oct 2024 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oSx3d3p7"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C758224B41;
	Wed, 30 Oct 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307251; cv=none; b=dGGHIeMYPij0c5YICbjU3LyGepE4MwGgeDRet0sPowS7y30bfPr0pWqzqofK+X+IN0pyPJ1J8ZemzNcZr8uU1LSv2Gr7D4oCWkkCQBDumbp53qpTBiNLK7RUKDpSVVwudJzVa/VTHfjl06XON5N76Y2zJOq8HZc6dsfF3WqA2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307251; c=relaxed/simple;
	bh=8T0/wZTi0VuS54bgyvyiVvkjFPYPzL3SvPFsu7gxxHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N1vozwZp9FDn2FoXmcncHdG2XuN87t8twkdSWXxaDHLP9Fkm8pUPP1PMznF5yKGSz6CfYoCm53jn6/tL5w/zjcqBm+eqYIYW293HdNDLtxff4BEeSbIuLqarBsOUy6YlkyHFSJIjbsYw8HJ3+jLPKDeaXQM1LYdiW+AMjLFLZ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oSx3d3p7; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C14BC0012;
	Wed, 30 Oct 2024 16:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730307246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ysWxHEpRdEmHqrjbAKaK8Fqz3AhswCItaU2FNFSHMD0=;
	b=oSx3d3p7WIMtRFNBxl6hkqvHLBN3USrAXINJb7uGUJVGFZG1LVTb+5OZqRdhUoXKshavUw
	uI0StiW04bkLRUF5Z9BEX8VBH2wHQe+QmQx9yaQS0B0/VeGWZyZ69Sm/DBDH7b4jYvlSKE
	pBZtfsbaURoP/vX1mHPKzbSR5u6EsWhp9l0gYeY9/eleqEEjuxpTciaZ1YhxxFxlz/CBhE
	njIBKqVB2VJ4DThX19Z8qqUrALjYoABKl81REqv0akq72OuP6+MsXbgZS1tpUaoA5KnMBG
	JOe1oTPL2nvxw++Xh5muekLT00Qwj8iOsyGQGKpurVkN622U5H2dSoP2hZVo4g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 30 Oct 2024 17:53:13 +0100
Subject: [PATCH RFC net-next v2 11/18] regulator: Add support for power
 budget description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-feature_poe_port_prio-v2-11-9559622ee47a@bootlin.com>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
In-Reply-To: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
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

Changes in v2:
- new patch.
---
 drivers/regulator/core.c           | 11 +++++++++++
 drivers/regulator/of_regulator.c   |  3 +++
 include/linux/regulator/consumer.h |  6 ++++++
 include/linux/regulator/machine.h  |  2 ++
 4 files changed, 22 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1179766811f5..cd7b26f77a8e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4622,6 +4622,17 @@ int regulator_get_current_limit(struct regulator *regulator)
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
+	return regulator->rdev->constraints->pw_budget;
+}
+
 /**
  * regulator_set_mode - set regulator operating mode
  * @regulator: regulator source
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
index b9ce521910a0..3e75d49d361f 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -235,6 +235,7 @@ int regulator_sync_voltage(struct regulator *regulator);
 int regulator_set_current_limit(struct regulator *regulator,
 			       int min_uA, int max_uA);
 int regulator_get_current_limit(struct regulator *regulator);
+int regulator_get_power_budget(struct regulator *regulator);
 
 int regulator_set_mode(struct regulator *regulator, unsigned int mode);
 unsigned int regulator_get_mode(struct regulator *regulator);
@@ -534,6 +535,11 @@ static inline int regulator_get_current_limit(struct regulator *regulator)
 	return 0;
 }
 
+static inline int regulator_get_power_budget(struct regulator *regulator)
+{
+	return 0;
+}
+
 static inline int regulator_set_mode(struct regulator *regulator,
 	unsigned int mode)
 {
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


