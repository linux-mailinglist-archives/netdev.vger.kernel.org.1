Return-Path: <netdev+bounces-155087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCB3A00F83
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA213A2AB7
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F221FECCC;
	Fri,  3 Jan 2025 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oltuhDjI"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804A1FECA7;
	Fri,  3 Jan 2025 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938870; cv=none; b=Ycp9oAjv8q9hdByCTKiyxPypNEuofzrLZOI+3DMFsYAEHLL8ezwktZ+ca7PCcPKRl4pEN/BozCuPoiYi4RvVuaFE8xj5NA1RRnuIdvqvfweEyDs6tGK/ez8HJQEoo+C5DMHvAMPStS9egFKj9vUxj6xrjRRhZQ/5BFFaGt7TqDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938870; c=relaxed/simple;
	bh=Y0A0BD1nebtMLitwevXYFn9vIWD+njjtU4m4cl4yRHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phIlTY50hwb/epk+OVkkw2oYbalOr7C9WS0m/eEBD3QGyH7V9FpS3ubTJ+5Cxk155x1QTINY6L3rw9GWI5Ll206IWeD6z9aXXdY/ASYY5psLNFAdQicR3FOGyQKp2O7SvtEjdRGBI/QubZzM3vxqWxrowsq/DwKMkJfqj21eXJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oltuhDjI; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4452EFF804;
	Fri,  3 Jan 2025 21:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735938866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVmilnr1gEKHOj9g/MYIDOBa4tut/m2ldXtXZWGl/EM=;
	b=oltuhDjIIdFhySkELJKp6aaScerFVocOFf3vPY74HsPmxJALjf567NLV/KTotpM14IXDcw
	XORb3pOGQGpYITRezT7wX/d8qJd2bFzbx3hmSDkiuetKPIRbM1lVkoHsPJfYktTfnZJ7Lv
	2vsfrTKwki02cjx1oAljgKqW8tEMPXDtprIXaQyf8VGT5f5A/9Ajtkit54hN8eDLYlB64+
	XDbML/XL6HRGj+yi9B7Prtu+kEy8V8h9z0adtfI6WproKPIuPZ5jKPJHEC9a+1mHIShl8b
	PhJvNgTOXFTEE1Tm2JGS/m8hfNp7YIAQbWOSN9/sHFtO90tuccgjZXQOTp+MDg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Jan 2025 22:13:08 +0100
Subject: [PATCH net-next v4 19/27] net: pse-pd: Fix missing PI of_node
 description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-feature_poe_port_prio-v4-19-dc91a3c0c187@bootlin.com>
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

The PI of_node was not assigned in the regulator_config structure, leading
to failures in resolving the correct supply when different power supplies
are assigned to multiple PIs of a PSE controller. This fix ensures that the
of_node is properly set in the regulator_config, allowing accurate supply
resolution for each PI.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 drivers/net/pse-pd/pse_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 83689de4a5ab..1da974fb83a2 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -426,6 +426,7 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 	rconfig.dev = pcdev->dev;
 	rconfig.driver_data = pcdev;
 	rconfig.init_data = rinit_data;
+	rconfig.of_node = pcdev->pi[id].np;
 
 	rdev = devm_regulator_register(pcdev->dev, rdesc, &rconfig);
 	if (IS_ERR(rdev)) {

-- 
2.34.1


