Return-Path: <netdev+bounces-146667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004789D4EFF
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CEF1F21AAF
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F671DFE30;
	Thu, 21 Nov 2024 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MuOmbRms"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780381DFDBF;
	Thu, 21 Nov 2024 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200247; cv=none; b=WPUBSPxJfyuXBagjGqKZuEWFZ0j5w+cYnWklxLAnM6wxPgFGCWIDfIo3D3qfsl/kaJHxR3qqV7uA0g9ydPcSimv5uDdS1Y0ntKiY8u8ir4fVoLQU7jGwmvGFbaAq3cSuvKNAbDOP8NSNShvg8jPylwE8I/thYXfbeuzpmcRbLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200247; c=relaxed/simple;
	bh=yCdz15S5n9bwP+eHaxIWj26ftD8GPdXVftvaKhrORvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EKqAfJSW2UbRN09lSNBRdhOqKRd3oTswFL3+eP2DPFcL/VI7YegcON72acbPaBKZvF1xTygGhImnYBhJzqEkAi6D+2ljUv9xMSu/5ruiahqsJRPOk8kQdZ8wRFl3MRcayE86/frak8bATc0dAJWRD4wtOeytmArfiEqTFweD1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MuOmbRms; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A0C340003;
	Thu, 21 Nov 2024 14:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u04a+OXero5sCODR6WNJl3zCEzppF8sFRXUhrvCAEFA=;
	b=MuOmbRmsOjc4Ak4mjQG71ptircy1YwGmFjL+4izltDHAczySCSRRb44DGGapgcBlg1tkWo
	BlmiGzQK8lQrfiNG64vczgNWpVWK1Qba2x2Dsh4j0QbfU/iF3CdVFcXh1+0t+noPKAsRQJ
	HfCWA3aKyxfpjqzywprzrGN1ubt/GSxEaz5BCby5cNenkhGPyO/b8sPg7PO8EYYZnXDnlM
	ujet5rfH9zCFgRi7oOBnbRC07ddZbQ/hTB8daGGjadvhgwcqpkjlvRMQ01yo4NMYGpkhdY
	9jHcsqztnF6aqp0pqJl2tk21TAc8+DQzsZEqnBnQaLhZ62YAqI1u+lydR3BLew==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:41 +0100
Subject: [PATCH RFC net-next v3 15/27] regulator: core: Resolve supply
 using of_node from regulator_config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-15-83299fa6967c@bootlin.com>
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

Previously, the regulator core resolved its supply only from the parent
device or its children, ignoring the of_node specified in the
regulator_config structure.
This behavior causes issues in scenarios where multiple regulator devices
are registered for components described as children of a controller, each
with their own specific regulator supply.

For instance, in a PSE controller with multiple PIs (Power Interfaces),
each PI may have a distinct regulator supply. However, the regulator core
would incorrectly use the PSE controller node or its first child to look up
the regulator supply, rather than the node specified by the
regulator_config->of_node for the PI.

This update modifies the behavior to prioritize the of_node in
regulator_config for resolving the supply. This ensures correct resolution
of the power supply for each device. If no supply is found in the provided
of_node, the core falls back to searching within the parent device as
before.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
It is weird that it wasn't seen before, maybe there was not any case
were it can't find the supply_name from the parent device.

Changes in v3:
- New patch
---
 drivers/regulator/core.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2948a7eca734..b49f751893b9 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1936,6 +1936,20 @@ static struct regulator_dev *regulator_lookup_by_name(const char *name)
 	return dev ? dev_to_rdev(dev) : NULL;
 }
 
+static struct regulator_dev *regulator_dt_lookup(struct device *dev,
+						 const char *supply)
+{
+	struct regulator_dev *r = NULL;
+
+	if (dev && dev->of_node) {
+		r = of_regulator_dev_lookup(dev, supply);
+		if (PTR_ERR(r) == -ENODEV)
+			r = NULL;
+	}
+
+	return r;
+}
+
 /**
  * regulator_dev_lookup - lookup a regulator device.
  * @dev: device for regulator "consumer".
@@ -1960,16 +1974,9 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	regulator_supply_alias(&dev, &supply);
 
 	/* first do a dt based lookup */
-	if (dev && dev->of_node) {
-		r = of_regulator_dev_lookup(dev, supply);
-		if (!IS_ERR(r))
-			return r;
-		if (PTR_ERR(r) == -EPROBE_DEFER)
-			return r;
-
-		if (PTR_ERR(r) == -ENODEV)
-			r = NULL;
-	}
+	r = regulator_dt_lookup(dev, supply);
+	if (r)
+		return r;
 
 	/* if not found, try doing it non-dt way */
 	if (dev)
@@ -2002,8 +2009,8 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 
 static int regulator_resolve_supply(struct regulator_dev *rdev)
 {
-	struct regulator_dev *r;
 	struct device *dev = rdev->dev.parent;
+	struct regulator_dev *r = NULL;
 	struct ww_acquire_ctx ww_ctx;
 	int ret = 0;
 
@@ -2015,7 +2022,18 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	if (rdev->supply)
 		return 0;
 
-	r = regulator_dev_lookup(dev, rdev->supply_name);
+	/* first do a dt based lookup on the node described in the virtual
+	 * device.
+	 */
+	if (rdev->dev.of_node)
+		r = regulator_dt_lookup(&rdev->dev, rdev->supply_name);
+
+	/* If regulator not found use usual search path in the parent
+	 * device.
+	 */
+	if (!r)
+		r = regulator_dev_lookup(dev, rdev->supply_name);
+
 	if (IS_ERR(r)) {
 		ret = PTR_ERR(r);
 

-- 
2.34.1


