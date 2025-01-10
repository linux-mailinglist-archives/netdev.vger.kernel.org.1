Return-Path: <netdev+bounces-157052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE11A08C77
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206F81881275
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CE720CCCD;
	Fri, 10 Jan 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eH9hfjDb"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07FE20C039;
	Fri, 10 Jan 2025 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502048; cv=none; b=aEa7BI6gkQteDS8jctFQp7HVsNGatpuTPD7yZNGX7MACOvPvzdawizEJ5CGZqMzgu+MN3n8yHGfyeQP0qzV52LoOvytHfB3bq/rU6ijTmkwypz9kBvQOKYkDCMebtBuOQy1k5bsg6rcRdxkmhRHArO3JIYU110mL8/oyBSGIfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502048; c=relaxed/simple;
	bh=Nam9s5eFAZigeFtHz86Y0kHPAoy0IkSgoYLYKPzqTNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UPAGbE0Y/YTnw7tjDPg4r3YNdr8jItKdDlIU6LmgRi1pLbFjClBBGj7f1MKnBqwL5QP3gVz57KextEq9OtW54HqXvFjdzpiek4Cd4YV+1ZGQs/2aAzCFKU+W5FGpH3qURQxlXQmTKunzKVLAXL8UrImmeq5ERa/LmCYHfugADw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eH9hfjDb; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE3A86000D;
	Fri, 10 Jan 2025 09:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736502044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c30YOKTp70seCDjOM0vnmXeUZQVYquMrphb4BtWeQLg=;
	b=eH9hfjDbQ4aqu84ExxfLbW+IWcrt3zHZ4jmi7QIN4837srR83kMYHE8CI1mxsj1Iieoo9p
	IC6tVOHBy/G9tD0dX38Ey5ElJV2LdWTq1I299U9qWmcb+ZfoJgqL8T+h6xD+8FEoUpHLcV
	/R6oymEsBhfHJL8NQXqQjdSvgKALz9VPyqgBgxd3i5JzVqnF8gM7X5LOckzRk8uMwL/qbL
	RHWZ0S1XyhSrn1vGeMWngAJOvkpHC94Ixz/ueZ1HWRKgQhKvmb2baYCEcVK1UQaxf2iM+n
	sMXfC1STNs5WOG6X5SzPtCObxVzzf38IZDvdgXVz0jL7kNYOgh5L8es0jgbI/Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 10 Jan 2025 10:40:21 +0100
Subject: [PATCH net-next v3 02/12] net: pse-pd: Avoid setting max_uA in
 regulator constraints
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-feature_poe_arrange-v3-2-142279aedb94@bootlin.com>
References: <20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com>
In-Reply-To: <20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: kory.maincent@bootlin.com

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


