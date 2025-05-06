Return-Path: <netdev+bounces-188294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B11CCAABFFB
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A475221C9
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681FD27816A;
	Tue,  6 May 2025 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XDATcYWj"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE87E26FDA0;
	Tue,  6 May 2025 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524354; cv=none; b=f4qgbfz1FFITZdCh6MFZIeB6lA41hD/CwhhO747p1GDfVmukjeCo6kWUYRLcidiUpONPEJOOkhQyfJxcX3rsHBpgPZCI1Ghq2rXrYLYc1lDsQFri2YVnu6Uhvzk5IJ0C1SNpG8XWTDouYWcDzx+c1knOcfcivwoNULJm/YBeoEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524354; c=relaxed/simple;
	bh=CdxaQWKSVnPSxzVb/HTQ3ljC/F235Khz9R59k9ph1xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5KydnN2h4jdRfot8C7HMJdpXjY/caZkVkB1BvWC2JywbVsRV6F7Q59SrLlhWfAE+mqgwM5zo5/hmeukS7PeiWVIUikaPvYVhu78TPx1byB0Rd+IDgsSTYehQy3dK9yOhtIgwAZkgn6YhGrdtCjpptRy9HHiGpV9WHJTTDW7JK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XDATcYWj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03B67439F3;
	Tue,  6 May 2025 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746524350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9H+HTGj24jVseNGRq4HAH0RZVhPlpyQw4mPouzOwUA=;
	b=XDATcYWjLrUUSzIT2g59bd+D5FlIbUQvIL2OL/Gs/ypTXYCZdJFVzVPZNZ5ZwTRWMoHj3b
	M2ncMBFAVpcxm/0z4evIL8IbpFUJF5yyrxnz7rIFhX3vvIDjH6SiJgRnQKiVEJlY/TVE/C
	Fe1WnJoe1AMPyXlja6NFtGXjhkrp+7VoYFiJOSXWoQN+6CwUWk2RG1E3EdXuiUfR14KvET
	dzDK9cj7JsOCpDKqvLBY0HUqXepiWpD0gOlWVLrCkUu4TyFt0It8LqHfTHrJqTo9uoQRwk
	rJOLibY/wsG8FhRQITjUOeHQG/F+6BIHEt7R2YjEIYnE8I+Sbqk7inZK5DRA2w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 06 May 2025 11:38:38 +0200
Subject: [PATCH net-next v10 06/13] net: pse-pd: Add helper to report
 hardware enable status of the PI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-feature_poe_port_prio-v10-6-55679a4895f9@bootlin.com>
References: <20250506-feature_poe_port_prio-v10-0-55679a4895f9@bootlin.com>
In-Reply-To: <20250506-feature_poe_port_prio-v10-0-55679a4895f9@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehlghhirhgufihoohgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvnhhtphhrohhjvggttheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmp
 dhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
index 776bb058d4d8..6b0dc5e44d2c 100644
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


