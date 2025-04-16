Return-Path: <netdev+bounces-183307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EECA904DE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC198A4B46
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2242214235;
	Wed, 16 Apr 2025 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i0+Kdj0p"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D250211A07;
	Wed, 16 Apr 2025 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811097; cv=none; b=sVpkBNs6EC36xLNj1AtoGXULCKre5jG3LT2Udik/kU9fWdfEuGNQ4hSmP3SbXkvdD9HLyyGPGFRJH7iKP//AQBRHY8l0n3YEpXjwNM02oeapxoDDQ/CB9EHNcaVn+H1xV0F4lYs2d2JLzRKD6erGBVGKxknOHouDm2rw8DSjkEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811097; c=relaxed/simple;
	bh=t/riqLaAjOTLqeQSL35nly0YR/KyFtuEQfe5F3EEdNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xmgpn0sox5PhNvmWkhfz78Hbnnv6OAVgappk1N035otZKLm7vjOn9olrHTjNpDdWlPcmpoxotmYXjRruYpiTnbBnc/wlIHTeSo3PHm13F6t/zCA0xvGjva66o9w2KzTwC64/QCragstXiWRyWu7NMMDWYNl4B8y9+1/DUOrrF7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i0+Kdj0p; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B0AA43926;
	Wed, 16 Apr 2025 13:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744811093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wj+mjixOIfB1EtFAPF2rLSUo0TbXb+SbBG2QHerAbVg=;
	b=i0+Kdj0pkVLRrxALhWN8zZev+6+Hu+5QrUrsa07yDFjN8kfWksaJodO13ZFzRli8mD5hbA
	I8PPtK50D/QBgcU2vpUbQU2IQOKu4FkP52gh7dXWMpQBKCRau+Ah2PihdhLw1GMobeNKUB
	fgxl4iz47OCTOvdd7wlVn7VgMshNT9FntH2BtAiUCin6XVivdpBLsMsOnM+edxSc4P0XwN
	NvzdKsHkHq0F2y6tc4Zl8SPmx2GxZRp/W7n6D9gbh99cDrNv+SOhTHQGcJ2z0Z1/6Ijdko
	lFDboBvVcIQBJQvMVrLSAg+aYbPnTjG2nHPvuZVqsvHDOIlmz7khySrDtCef4A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 16 Apr 2025 15:44:21 +0200
Subject: [PATCH net-next v8 06/13] net: pse-pd: Add helper to report
 hardware enable status of the PI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-feature_poe_port_prio-v8-6-446c39dc3738@bootlin.com>
References: <20250416-feature_poe_port_prio-v8-0-446c39dc3738@bootlin.com>
In-Reply-To: <20250416-feature_poe_port_prio-v8-0-446c39dc3738@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehhohhrmhhssehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Refactor code by introducing a helper function to retrieve the hardware
enabled state of the PI, avoiding redundant implementations in the
future.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---

Change in v7:
- New patch.
---
 drivers/net/pse-pd/pse_core.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index e6b3c47d9892..f4830fa55cb3 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -227,10 +227,34 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
 	return ret;
 }
 
+/**
+ * pse_pi_is_hw_enabled - Is PI enabled at the hardware level
+ * @pcdev: a pointer to the PSE controller device
+ * @id: Index of the PI
+ *
+ * Return: 1 if the PI is enabled at the hardware level, 0 if not, and
+ *	   a failure value on error
+ */
+static int pse_pi_is_hw_enabled(struct pse_controller_dev *pcdev, int id)
+{
+	struct pse_admin_state admin_state = {0};
+	int ret;
+
+	ret = pcdev->ops->pi_get_admin_state(pcdev, id, &admin_state);
+	if (ret < 0)
+		return ret;
+
+	/* PI is well enabled at the hardware level */
+	if (admin_state.podl_admin_state == ETHTOOL_PODL_PSE_ADMIN_STATE_ENABLED ||
+	    admin_state.c33_admin_state == ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED)
+		return 1;
+
+	return 0;
+}
+
 static int pse_pi_is_enabled(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
-	struct pse_admin_state admin_state = {0};
 	const struct pse_controller_ops *ops;
 	int id, ret;
 
@@ -240,15 +264,7 @@ static int pse_pi_is_enabled(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
-	ret = ops->pi_get_admin_state(pcdev, id, &admin_state);
-	if (ret)
-		goto out;
-
-	if (admin_state.podl_admin_state == ETHTOOL_PODL_PSE_ADMIN_STATE_ENABLED ||
-	    admin_state.c33_admin_state == ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED)
-		ret = 1;
-
-out:
+	ret = pse_pi_is_hw_enabled(pcdev, id);
 	mutex_unlock(&pcdev->lock);
 
 	return ret;

-- 
2.34.1


