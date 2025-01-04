Return-Path: <netdev+bounces-155203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B920EA01723
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 23:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355F1188468B
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 22:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48D51D63D4;
	Sat,  4 Jan 2025 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MCPB+Ubo"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D19217108A;
	Sat,  4 Jan 2025 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736029732; cv=none; b=lo5/cHxfK5Af6FiBGnlWnaNOS5haTNJLfiNOnST41FL5FwVDoXDqxy+NJ6H24IiI92g20jEzeOUcnxJvcRsZi0fsORNP5M5wnEfETe3aq8Gq/svh7QISgQnczW4GtvVyErZq+yldRng2vvLyMbEMHjSQR2B4/uy+GtD1oMAZ7Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736029732; c=relaxed/simple;
	bh=qGKPCHioDvLHPUjL/zHqUrz1EMkwJ08EwHPVFoKw+xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bTVGv28NmnW+JpS3ij1AUdfbc7BVs+VZRS/MiaS0HWzK5XD0IT3BknCa5xNM0YYoGdAd8G6qAWv0miUliYQF0hhOaNwzG67cDvJUnIMH6sG3W8EH6qX2FiUWW77Wo0lKdk2DUZo3yGjeAbanWSrAsqK70ZUhb7s9HF8mFyuObp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MCPB+Ubo; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A98EE40004;
	Sat,  4 Jan 2025 22:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736029728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Le+YyCmBg3uz++l7dEhGwDiEuYWQBPGztF5A5qpeEqw=;
	b=MCPB+Ubo8qygZULGh3Z1DjflMhHupXbJEG6Un7SBYR4qkTHFU2/y+tirm226rJCQL4Selc
	9VHEIiZGkWqynCiucDlgZACi1+ThqoxkMX2a5PZImlPTurNnskcwSKB9SNI76M9vvRszv7
	huEeVU3sVOhzmtXrp5b+kib47tEbwGPVR8bxOWS+iOfCYn2+/+xrl45l/rXa8cVX/WBQxp
	wsQWhkkB2dvezNnKDeS5l/ka52NCNIrz0pAQ1J97gmJh8CLc6lYIX7OM/iCnqsnE3afAV4
	GK3ip0a037llkd4mJtcpNplvH/07Q/b6raDUludux5s7UTpgPN1nQ8JKWWJqdg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sat, 04 Jan 2025 23:27:27 +0100
Subject: [PATCH net-next 02/14] net: pse-pd: Avoid setting max_uA in
 regulator constraints
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-b4-feature_poe_arrange-v1-2-92f804bd74ed@bootlin.com>
References: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
In-Reply-To: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
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

Setting the max_uA constraint in the regulator API imposes a current
limit during the regulator registration process. This behavior conflicts
with preserving the maximum PI power budget configuration across reboots.

Instead, compare the desired current limit to MAX_PI_CURRENT in the
pse_pi_set_current_limit() function to ensure proper handling of the
power budget.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
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


