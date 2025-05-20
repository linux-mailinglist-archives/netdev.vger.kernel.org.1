Return-Path: <netdev+bounces-191944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4789ABE036
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1FB1887740
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138EA280CE5;
	Tue, 20 May 2025 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d0gxMb/s"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D027CCE4;
	Tue, 20 May 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757491; cv=none; b=JzTz1f0hvFxKVRHQZ/elYW7PBcelEXiHn1D/c1jhI11oyd9l6huSS9+V1rVCcMbhqjetLyeQRa6PbIRuuhLBglcVtfNAOrB6XxVxEIgHquhv9DacDck5GcofCyVBejnBcDCNYL2KDwkOy17GoCcCh605K3q9c44riO1kpYJcXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757491; c=relaxed/simple;
	bh=BnvxSP/+eQdc1he7wbOU6WTThFt9Ng/S4VftLP83ePo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FsAWSyJicuAYDfdYmimgEd1YfglAKFnCsqiW1Xp7FOdAa736Msz60Q+FuREnu23SmhZQEKJx8JdKhyA2iTk733zGZLoNNsxPYQ7cODgzrbDlr63k1XQKV++dbstA7LtbBfoM7zWfWDGJro352QTczGG4gNTUXM4UF7qPGNoM2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d0gxMb/s; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A8D3343970;
	Tue, 20 May 2025 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747757486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oRQyNr6fNcycEZ3FI0IRn2TGz9FK3DxlMvlu/uveDGM=;
	b=d0gxMb/sz6GSgOKLIAp6kCIsnza5ja615FnnV8PIQI8ZWgwlTHvSfHT0XpQxZPyySIufEt
	oNCo+/vmmMgIEdzywV8JZKP6dNpGsR9Z1dM3wsRAAYx08G3svSuoERE91QUolTKJJ/pOrd
	O/QaQOOJepQp6dqUeoXSK5oceD4+TjwC3fsGniaKfgdtpeOtzVG46f5EtE5arCNS/Xgk0w
	fGUxVVIlMY0vPKHqxQHKBGQUkj4+9kmvwP31fBTTEuu+MC7BFVKn1aq+g/s4EimIPC339K
	fsxXncmwS7oSY3cPUsG6uOXtCEkGMVTJ2Wo4W8SrbLv5Qr2p0m9LqBAv9fZlxQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 20 May 2025 18:11:08 +0200
Subject: [PATCH net-next v11 06/13] net: pse-pd: Add helper to report
 hardware enable status of the PI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-feature_poe_port_prio-v11-6-bbaf447e1b28@bootlin.com>
References: <20250520-feature_poe_port_prio-v11-0-bbaf447e1b28@bootlin.com>
In-Reply-To: <20250520-feature_poe_port_prio-v11-0-bbaf447e1b28@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeiheculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgp
 dhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
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
index debd9a721867..dd6775b9816a 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -276,10 +276,34 @@ pse_control_find_net_by_id(struct pse_controller_dev *pcdev, int id,
 	return NULL;
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
 
@@ -289,15 +313,7 @@ static int pse_pi_is_enabled(struct regulator_dev *rdev)
 
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


