Return-Path: <netdev+bounces-193212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79838AC2F15
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 12:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 495E67AB4C4
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 10:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD901EA7C1;
	Sat, 24 May 2025 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q4k3+LKh"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764E1E633C;
	Sat, 24 May 2025 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748084226; cv=none; b=CpdDw3AB7XdMnnBZyjgOU3PMOzSwl5r6ZfgD377HcotCuPXtR0OCnfiCBKAnYqXr+XoMs/UjvZKsF8JqCh0oHKXAYowNSIuLW0quC32LkvLEJN6i6p35Bk4/rm4LO5n4dI2oGs6pdZ5S7itwjp8B11Gx6slBV+cuNRu0OgSPd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748084226; c=relaxed/simple;
	bh=kztBcCKP++nS2yia/PSAQqzvVVtGSqwmKkwez2U9lps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gr2Hoy2nSRfwT9tSdbMjywv/nYJNYf2Jjg5MzI9q1940LueRrOVAs7SQYD0JiOl/4+PnafKGm+1FRJ9w1O5Tme3ZcqmOrlmcYr2shqVImLqTBWCOIdpKaP1ftv5v7CAHKzSZR892LPDxuL5Eoes94oa7CN/g4/nZKqZESrntEng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q4k3+LKh; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7CB334397F;
	Sat, 24 May 2025 10:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748084222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bw04+GiVJhAeIUIY2gUKiUUnf9gGdpiBlBKtP6ID3I8=;
	b=Q4k3+LKhEhXTnedCwS4jCmmfPWzRoOYpnDEeL2nM0VtEm1/lADaocFK69CZM9gh0a0ZRhb
	f9tyZJhDy6RrIcSWXpg9BmnmT/MixSjzy5joqeFTC1JKR7Bz5K2f62lHW7dXv97Bk6YPBi
	6VfrbjAMb7RlGWQUXDGq6C5z/XkBknOdmSmNssVcXh8dBd9QDi1YNrBzCQrKn9qZq2ro2U
	Wcc/1ojn2EVBTSBzRsS7sNrUP1m3aaIKX02P6ynEaikQiSuB1ivvh2EJPeCMaiLt4jwzq6
	LADYTsvyoQhIcobdn2MVJI5pp/HsEQlOrkRfjJYJeXHUHjOTIKwSAL9rWw5s1g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sat, 24 May 2025 12:56:08 +0200
Subject: [PATCH net-next v12 06/13] net: pse-pd: Add helper to report
 hardware enable status of the PI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250524-feature_poe_port_prio-v12-6-d65fd61df7a7@bootlin.com>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
In-Reply-To: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduudehgeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmegvieegsgemtgekrggsmegvvgekmeejvgeikeenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekheekjeemjedutddtmegvieegsgemtgekrggsmegvvgekmeejvgeikedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepkhihlhgvrdhsfigvnhhsohhnsegvshhtrdhtvggthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtp
 hhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
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
2.43.0


