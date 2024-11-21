Return-Path: <netdev+bounces-146652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1279D4ECF
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE75B23D80
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B23E1D934B;
	Thu, 21 Nov 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e8jJdSO5"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705101386D7;
	Thu, 21 Nov 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200222; cv=none; b=H/nmJec87jlOTMiTow0b8nYrGigjTVItK1qHV46UlwtSziTjUDKGPzM0BvlIGh0WVCbCNpUaufpVlmo/v7425BWcj/1dfJGJ+ha34joaGk5ytxDCycP0dikcY6YaAHDGMyY4SVuZT0gu861zhyfwMq9e6T5QwdFS5N3X2i6DE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200222; c=relaxed/simple;
	bh=Z9ZNL3rh1rUDWm5Q3HrHpjTA0Zx0JXMguecu4dqyCSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCpYkGsqV4tVDUUPjMdfhWBCLs3KsP9+G7vTJnhOwb83qFaGsQzSaCfHs2SGI5ik8iRtOraWxJ+okAwY8hp2StXIa0V/U5LD6l6DX6gWoofodQ8XJ9pXiORc9DN7Pl7rHuDueTDfC5ErqgKZsaiM5F1TIogBU52OIEtyLRJciWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e8jJdSO5; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB7ED4000C;
	Thu, 21 Nov 2024 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmHAa5lzTlUKP9x1tLfYUr5FJHSMHYYBy7nd5w51Avs=;
	b=e8jJdSO5ViEhXGf3Ny2QOlNBN0n5eeXTbNv5GuHUTacuHbdaUyQ0Jl7p7A4bYxQKIvtxHo
	IEOeMbWgmMA3IlJmMUwFA+dY2LaMQQcJh4pNk05ICaoWJueV/B4uni6UHYxWuqLRP0d1X0
	K2Dlc2+A7UoEs5NTNN7T6wIWJoFB6zhw940tiX4+tj2LEop+fFA1jTQYiSekrNIrZoEa7B
	eF6UxLzbsTeDv+pANeS2GJFAT+MGp2uy74dRICOF6G5hk6UV/uukMdgoKykGyGpZSVU3tn
	4OFMKpB2tqoybQSK7nDB+XWS9cXcBHskFM09JbtpjNTp8YzUClUnDr/OPyg4jw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:29 +0100
Subject: [PATCH RFC net-next v3 03/27] net: pse-pd: Avoid setting max_uA in
 regulator constraints
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-3-83299fa6967c@bootlin.com>
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

Setting the max_uA constraint in the regulator API imposes a current
limit during the regulator registration process. This behavior conflicts
with preserving the maximum PI power budget configuration across reboots.

Instead, compare the desired current limit to MAX_PI_CURRENT in the
pse_pi_set_current_limit() function to ensure proper handling of the
power budget.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change ni v3:
- New patch
---
 drivers/net/pse-pd/pse_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 2906ce173f66..9fee4dd53515 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -357,6 +357,9 @@ static int pse_pi_set_current_limit(struct regulator_dev *rdev, int min_uA,
 	if (!ops->pi_set_current_limit)
 		return -EOPNOTSUPP;
 
+	if (max_uA > MAX_PI_CURRENT)
+		return -ERANGE;
+
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
 	ret = ops->pi_set_current_limit(pcdev, id, max_uA);
@@ -403,11 +406,9 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 
 	rinit_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
 
-	if (pcdev->ops->pi_set_current_limit) {
+	if (pcdev->ops->pi_set_current_limit)
 		rinit_data->constraints.valid_ops_mask |=
 			REGULATOR_CHANGE_CURRENT;
-		rinit_data->constraints.max_uA = MAX_PI_CURRENT;
-	}
 
 	rinit_data->supply_regulator = "vpwr";
 

-- 
2.34.1


