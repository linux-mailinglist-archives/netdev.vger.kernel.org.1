Return-Path: <netdev+bounces-155215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC48CA01746
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 23:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878EB163156
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 22:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5CC1DC07D;
	Sat,  4 Jan 2025 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ntI4SQGE"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260571DAC95;
	Sat,  4 Jan 2025 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736029744; cv=none; b=bCHM7/92uLMOY/1cJP/fNEvusrAZNYoRoww9DPM5TEEREwBW6LKLrJCrB4B10bS+57qxdfjwag7tL5OwMzkPHwwXiyfishU7lslBdwj4Ozdw61xSjqq0xqYJfpru8AMSD3vVMfo+NuYudR12FEoI9dUJpryGXikbQAs+fJiXvdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736029744; c=relaxed/simple;
	bh=RZuO1r59PlVkQGPxJghut1VS50guz4rBU7rH1G5gD3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oofCGGdG8ibdR3yDRGWjqnvr3BnrXxotPsP6Ho3H2ZhvB56Setr+uVIt5X+a+btSOricE0BXbJ0REKVg6YmYqIpr0NAhA2rqnxHnL6r+hz3W880cOZ4F67aNSASvtTHaA4lV3UwwqUtHCoohREJgVaEoQJ6mjs5Fx1dn5m3MovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ntI4SQGE; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC6AE40004;
	Sat,  4 Jan 2025 22:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736029740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uU/plfv/Hiqay0ydln3tGT/UUrhcCr+rBb47n8URIY=;
	b=ntI4SQGE1+dFIpdZBkaWD//vvYt0+yLqNzT7sI3FaQ19q5/gn0RDGTvwX3EYwFNS3Cxcpj
	HZ8dtY0Z1TCVZnsx4XUaZBmuydBUhvsDLNF5XyIZCTFgZINc+cbyZqbj86Ff/tqKysVxTM
	VOTDLTnqafi4RvkwzxKTs4/iPovowXOypm6gUp7BvYdFRHQ4Aztpgxii9hjnEyOhVBfdFE
	q00UY2cseV5oqMVtw8xABwMhZar6dHLKDmfmJHKSbd7STztEuqcizscbzufFQbf6VRliSn
	CCxFj+JzbJ56d0wqCMivUCPvPKVEcy4rSa/mpIvdchwTrTK14y4v31ujw8WAjg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sat, 04 Jan 2025 23:27:39 +0100
Subject: [PATCH net-next 14/14] net: pse-pd: Fix missing PI of_node
 description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-b4-feature_poe_arrange-v1-14-92f804bd74ed@bootlin.com>
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

The PI of_node was not assigned in the regulator_config structure, leading
to failures in resolving the correct supply when different power supplies
are assigned to multiple PIs of a PSE controller. This fix ensures that the
of_node is properly set in the regulator_config, allowing accurate supply
resolution for each PI.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 830e8d567d4d..be56b3f5425c 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -423,6 +423,7 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 	rconfig.dev = pcdev->dev;
 	rconfig.driver_data = pcdev;
 	rconfig.init_data = rinit_data;
+	rconfig.of_node = pcdev->pi[id].np;
 
 	rdev = devm_regulator_register(pcdev->dev, rdesc, &rconfig);
 	if (IS_ERR(rdev)) {

-- 
2.34.1


