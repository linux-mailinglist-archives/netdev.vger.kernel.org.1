Return-Path: <netdev+bounces-180309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C333EA80E87
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AE888731C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F7D22DF8A;
	Tue,  8 Apr 2025 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WdDR6EAI"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA422A4D6;
	Tue,  8 Apr 2025 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122769; cv=none; b=RwTITLozKjtQEYKBPQ0AMBu7gTkiYc34kPEWT/Xy0M+Sd0y2RQDEU5pBawA5w36IFIO0rk2Rz1gAPLBcGGG2QMwKj5gyOH9sRFOqZyJRfrL96FS3e3NaL1t2DKCoHX2vbl5qOtzoJzY3hAteI4CdLvqOj8dBbJ0hadsraf/1r+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122769; c=relaxed/simple;
	bh=fN68wFW+Q66Yde3T7GiPb70QZM/v05mEijLD8XUj75I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PMwGZ2TPfGiEO1VbPiisdgyZeyt3/wIYlqExh/vvVqJQk7rk8QsF7Te/EIsUHxOF8uGtk6SttzGtSvSxXEtZusDMubCeoiS6LmrYZb6LKQhCQFYe+2RUPPe1kOItdHsyGuvg1NRanUrs+3uVIYste25djH6q/0VmHQvDiOTznDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WdDR6EAI; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72B41441AA;
	Tue,  8 Apr 2025 14:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744122765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=77Jjs/0bsmhIoinBMTM0h0vyZLJuM1IvY0/zaBIcGbM=;
	b=WdDR6EAI78R0TcbEdUL/Vf9E7AMUJY/+ajh1602T+k13umQ2SoJPPGnampDiO5NLsT2dHR
	dAAzP0XGKO7qLINeqHBneP4ZUCVPGTgizpQy6Xl/5x7O8Crg7Lx1w4Cu4hvwdmBWmWVj9k
	Z1cnBCJVEDaH3cqyn2Pmi6UZ8RGuBAnbfrSdSQQcGpYAnb9RqTmIn22PqYB4kK//OwL8Qo
	KmbRznT9JmS7rNgZjakgMlEjhVzmC6EGcH3D9Xt+W0HuWSd+d3Bg+uSSLi8/fAW5YBEDMB
	A4OdipNfEGqfMjsyKNf0wm8v+zI/KQ4W2IgdytC+VfR8PkRDIsib8ojBWQwU3A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 08 Apr 2025 16:32:19 +0200
Subject: [PATCH net-next v7 10/13] net: pse-pd: pd692x0: Add support for
 controller and manager power supplies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-feature_poe_port_prio-v7-10-9f5fc9e329cd@bootlin.com>
References: <20250408-feature_poe_port_prio-v7-0-9f5fc9e329cd@bootlin.com>
In-Reply-To: <20250408-feature_poe_port_prio-v7-0-9f5fc9e329cd@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeffeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhihlvgdrshifvghnshhonhesvghsthdrthgvtghhpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhig
 idruggvpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add support for managing the VDD and VDDA power supplies for the PD692x0
PSE controller, as well as the VAUX5 and VAUX3P3 power supplies for the
PD6920x PSE managers.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
---

Changes in v5:
- New patch
---
 drivers/net/pse-pd/pd692x0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index a4766c18f333..4de004813560 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -976,8 +976,10 @@ pd692x0_register_managers_regulator(struct pd692x0_priv *priv,
 	reg_name_len = strlen(dev_name(dev)) + 23;
 
 	for (i = 0; i < nmanagers; i++) {
+		static const char * const regulators[] = { "vaux5", "vaux3p3" };
 		struct regulator_dev *rdev;
 		char *reg_name;
+		int ret;
 
 		reg_name = devm_kzalloc(dev, reg_name_len, GFP_KERNEL);
 		if (!reg_name)
@@ -988,6 +990,17 @@ pd692x0_register_managers_regulator(struct pd692x0_priv *priv,
 		if (IS_ERR(rdev))
 			return PTR_ERR(rdev);
 
+		/* VMAIN is described as main supply for the manager.
+		 * Add other VAUX power supplies and link them to the
+		 * virtual device rdev->dev.
+		 */
+		ret = devm_regulator_bulk_get_enable(&rdev->dev,
+						     ARRAY_SIZE(regulators),
+						     regulators);
+		if (ret)
+			return dev_err_probe(&rdev->dev, ret,
+					     "Failed to enable regulators\n");
+
 		priv->manager_reg[i] = rdev;
 	}
 
@@ -1640,6 +1653,7 @@ static const struct fw_upload_ops pd692x0_fw_ops = {
 
 static int pd692x0_i2c_probe(struct i2c_client *client)
 {
+	static const char * const regulators[] = { "vdd", "vdda" };
 	struct pd692x0_msg msg, buf = {0}, zero = {0};
 	struct device *dev = &client->dev;
 	struct pd692x0_msg_ver ver;
@@ -1647,6 +1661,12 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
 	struct fw_upload *fwl;
 	int ret;
 
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
+					     regulators);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable regulators\n");
+
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_err(dev, "i2c check functionality failed\n");
 		return -ENXIO;

-- 
2.34.1


