Return-Path: <netdev+bounces-198566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8461ADCAD3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0521F1895041
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E6B2EBDFA;
	Tue, 17 Jun 2025 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="izssl98R"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1743D2E6D36;
	Tue, 17 Jun 2025 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162352; cv=none; b=DLMTRiHgnSDi5uMlOzUyNdf4wsyr9JQNrnSeJ5Z7ZFscxDpUByUTj47NtwdGAhnvqu9acZC/nVZEVa7fyewnpcTLsDAeFCW3YbRecfkhFlK2WWP36Su7kXCxxEUvPodXUwp05lff7SwJUeBVbExG/7okhUzDXnhsF/cIrGU/Ly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162352; c=relaxed/simple;
	bh=yTyIxq9mKjlrFc3/p7HrIkIUOCUfQSJj+tX74RBxYNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EjQy57kUuWG4r1eeVgxKo1X6krfXXcmdNvTrGjJksHWRMA9Bfi9BuEVfbUWMl3RAfqIsT1QIte8VYsjghPd9lFOMvhVk7QvtDS/IfAH6ahDs0L9sjbEHIDSQHjN2OJIWwoBGLk9vbdZdW9ZnGFRwxfMWfcvwLxYIvgF6LihQPMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=izssl98R; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3CEA543305;
	Tue, 17 Jun 2025 12:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750162347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5P5SQRp0aYM5+GAfF0EKQ/JsT3eA7lVFRyPCmOvEtGc=;
	b=izssl98RwX8VpOTVmuNrmjNc+/2Z7ftwqhc6hL60ApuxbBNoZKuu7OJsjfEdAMTZnNHl5h
	FdipdrhYyPW08ar0vAMxw7WX03zaxnqWdGfe1WUmU6NzDFXSpKD+PzF/JYXmBqbb9pOh/z
	//7MopTvC5cPEvIhlum4rKBGnF1PCYNDrapJY0s/C1U7Whgcnh5j3Zj3oCb2u5ankjB1fk
	joboPlTIykZZFXnJk9QFZ/yMB7Xltcd3rfyc/8tc9Y4CD2BLmLbOydLEsJF4C1v12uV7gm
	uTQSyOCZLz+AOI5UKcDliT9OHG+knB4/23FliyuzVIFliZv9qyiLNlCdWzYzBA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 17 Jun 2025 14:12:09 +0200
Subject: [PATCH net-next v14 10/13] net: pse-pd: pd692x0: Add support for
 controller and manager power supplies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-feature_poe_port_prio-v14-10-78a1a645e2ee@bootlin.com>
References: <20250617-feature_poe_port_prio-v14-0-78a1a645e2ee@bootlin.com>
In-Reply-To: <20250617-feature_poe_port_prio-v14-0-78a1a645e2ee@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhihlvgdrshifvghnshhonhesvghsthdrthgvtghh
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add support for managing the VDD and VDDA power supplies for the PD692x0
PSE controller, as well as the VAUX5 and VAUX3P3 power supplies for the
PD6920x PSE managers.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
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
2.43.0


