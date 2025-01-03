Return-Path: <netdev+bounces-155084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E218A00F74
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E581884943
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1D71FDE08;
	Fri,  3 Jan 2025 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="an1TztFx"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC32C1BDA91;
	Fri,  3 Jan 2025 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938861; cv=none; b=f1VpLj2STguYs720jw3F+5BGVwlrvCzcaTE/O/x0i6m/ypJBQ9lepjyRdFHhWPZ3xI6zXrj0rnsA5FWuhjyNbeynwMw1eHpO8a1FXrOuY+Tok1vi05x+kNpgVAjRx8VIDxTGpxK1ljYBKBB17sFtXZE5RaVP2AlENstQFsoyTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938861; c=relaxed/simple;
	bh=PC4FJ1L2BSzbjvbggFgME9yTsHVyK93CyP/SQ26vnK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRCo2gYLws2el+HTmPg21Wi/EX30EsHm6F5/M5LFhHpRW0DeKneXgRgrNtfcS7Z1hGKe9CpW01jxeh+JET96DjsQFdo/3J2Jrl6ebpi7dx53FXYDLZY+hNdPophFaKReu0wTBSf/lww+CRNqiKsCgAGBBEZ/qRtQd5xII15BWUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=an1TztFx; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E76F8FF806;
	Fri,  3 Jan 2025 21:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735938857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBikdrLrEW5eXXG7XnWc4AqnVNGcoitDQANYv+yb5E4=;
	b=an1TztFxFzVrX+0cibpPxRMPwY/kWwR3YjhZD4nuYR5MIfveaWlNCnN6RBoiitppPOtEWD
	5kc1fT2fYf4TKdGMTo8rPkWNNfMUxbfIzlG+Q34KuY7rmG2WilTSvNOZ7BBWn+kX+WvA1J
	oMu1wDKgDf++Rq5G6dXtrBNetJdYBvoT4tntwXlyaWOqIDlU3KgZtvy6dKJ1WPITeflk6K
	D96plz5FUVPXcz1yFB6MMdpFyg5TKTVQr7djetZrRowSKDEVE1cqfgCbfxwTALvzzlTvf2
	fT+aisv5lQmo9EnNwv8FG7BdcSOg2MfEixzANx8P7AvTgurJoMmLe41N7XQy1w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Jan 2025 22:13:05 +0100
Subject: [PATCH net-next v4 16/27] regulator: core: Resolve supply using
 of_node from regulator_config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-feature_poe_port_prio-v4-16-dc91a3c0c187@bootlin.com>
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

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
It is weird that it wasn't seen before, maybe there was not any case
were it can't find the supply_name from the parent device.

Changes in v4:
- Remove dev.of_node double check.

Changes in v3:
- New patch
---
 drivers/regulator/core.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 8cb948a91e60..c092b78c5f12 100644
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
+	if (dev_of_node(dev)) {
+		r = of_regulator_dev_lookup(dev, dev_of_node(dev), supply);
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
-	if (dev_of_node(dev)) {
-		r = of_regulator_dev_lookup(dev, dev_of_node(dev), supply);
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
@@ -2015,7 +2022,17 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	if (rdev->supply)
 		return 0;
 
-	r = regulator_dev_lookup(dev, rdev->supply_name);
+	/* first do a dt based lookup on the node described in the virtual
+	 * device.
+	 */
+	r = regulator_dt_lookup(&rdev->dev, rdev->supply_name);
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


