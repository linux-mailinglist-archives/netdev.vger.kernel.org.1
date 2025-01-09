Return-Path: <netdev+bounces-156622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F4A072B4
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 774827A03CD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4E7215F6A;
	Thu,  9 Jan 2025 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kp95hMiC"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A042215F54;
	Thu,  9 Jan 2025 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417935; cv=none; b=cAdKwm1wYWg7gLBJydP4QA+BFUwLGPyQyMn3mPGS+k7f3vSYZ54SfGE8SG8/37uIJ+8WPF6oO2Gtisc/3+4yTc3TLHvUr637Cn3IKiHNiCYcE7u6qi+EseedU/bjmx4ZSX4QuVeXSO8W2WzkW83m2CmUn2V60bEE6qfemkupaQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417935; c=relaxed/simple;
	bh=Xqy6HlEBN2g67Mcm/lksLx1qaRNDOUivtjZA9ykw4aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RwIDlw/xSRaNJTPh3wYBMQ2JMiqre0Ds1AOjIUiCmbVHrHdWjcMfKk9lwQEdCwKJp0EvLUvEJ0D3LGTKIzkNujJe98NvtqrvSO0ZwN2FWnRrnYFGZUjRRV2N9MNnFHnpkgjRwErDWKfZg4mcwHiQVgZOI+JE0u2DHa6gI0ldZLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kp95hMiC; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D1BBE0008;
	Thu,  9 Jan 2025 10:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736417926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Olk4OigF7aLi/6DE+kXr5xzavP7KwQhC5yOFazqQf+w=;
	b=Kp95hMiC30mF+PsW95QBIq/XAqKKG5JHxjsvOClPd1Kb2k1u7d3UikxcApAA5+dybvhx0T
	QYBjsYqz5t+6KwBhSxRkcv/cK03vRrnxG+VXj6/3mqcFfdlUTz7XbAbaUkxN2S76sKlaQ7
	voSJ8m+hJRcGsMumRgjuFNW5ocpKZ+z1VMaTNaYw8aiqmBsRQfeEOkONOGxyQx0N8L8XhM
	9zZsue9FNWyS4TjrIXvk7ZJyfUIcIcsN2Ys/GgLrFOtCvh+PArCzMaVKxrv9gu0g18i8S3
	FJYFKMRF/2wAx6lR7Ator6VDtbT1qFOMJ5+0XfLTrQzi8p3ScHYgKyYVHpUUMQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Jan 2025 11:17:56 +0100
Subject: [PATCH net-next v2 02/15] net: pse-pd: Avoid setting max_uA in
 regulator constraints
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-b4-feature_poe_arrange-v2-2-55ded947b510@bootlin.com>
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

Setting the max_uA constraint in the regulator API imposes a current
limit during the regulator registration process. This behavior conflicts
with preserving the maximum PI power budget configuration across reboots.

Instead, compare the desired current limit to MAX_PI_CURRENT in the
pse_pi_set_current_limit() function to ensure proper handling of the
power budget.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
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


