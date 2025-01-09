Return-Path: <netdev+bounces-156632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 212FEA072D4
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500BC188A015
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3FB218ABB;
	Thu,  9 Jan 2025 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MzIE0NHB"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6DA216E24;
	Thu,  9 Jan 2025 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417944; cv=none; b=VT7j6ZidDdNHlgGuGowPvB5HqDAIDhuEeFweCkLaXWl59gqZqGpa8HmanXQIxKVLahmm4KX/uHTzQzPEg8R2jYXDJgkk4SZUyDFCmAArjMNEokzzmDLlkNqARXL2ZC9pnaA6OZ7Yr1GWbdnyWFcsWE2UNRFrUiUkd1hBtEU2Q2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417944; c=relaxed/simple;
	bh=cfShJdS7kc+IXchIdXhpzD6r7K6d3DXo0yyTL6zMrsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=izH0DFkh88aX3BfPbhlqvSj6NFH/JpRutueSbVXLt0rvV6qCP4C4URUSIKBfeRuq4//Fhml9QONF1XKKBNqvUv6dG7K0sM4Brkj0RZvcoBtpG0yjN+E81A0zozBMSdHt89LSWMOA4R4/hEM4XnRIjTB3vOZywZ/BklZbhR/Jz/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MzIE0NHB; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4FB98E0003;
	Thu,  9 Jan 2025 10:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736417938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6QzFXwsO2JspPNUbO474J0IIaz7Yg+4NngHA7f48CA=;
	b=MzIE0NHBiwG4iiov6XgVL2rvnAVn9srdi4idMY/A+j/mkBAHwZl9E84yklJO4NzM82FyPI
	FqXAKWesoJDShsi0WcB0hfEu314mxLNn2dwh0fbfQS6poazgNStR95QL0Rcbvesl0GSZTo
	lxir/s9jfofadqS9HkEt3KLbRyRStwBqlAEbzBsIng+JSZ1t+iGsj458kxX7xyEzDmWjYz
	IVNl9g6H41mj02bO9+lDDnQwStZSQ0BFd33FYW3zaw+D488D3oO6+NAf94TcTLW94FJUa9
	NNHdhN8lk3yYGWcfhfMOR0XW/gLkd8tZQhHF58j02B0Fsa/GXrd3TFC8fDDzoQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Jan 2025 11:18:07 +0100
Subject: [PATCH net-next v2 13/15] regulator: core: Resolve supply using
 of_node from regulator_config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-b4-feature_poe_arrange-v2-13-55ded947b510@bootlin.com>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
In-Reply-To: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, 
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

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
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


