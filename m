Return-Path: <netdev+bounces-146670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE869D4F0E
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBCF1F20F54
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863981E0B90;
	Thu, 21 Nov 2024 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qk45GfvQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D131E04A7;
	Thu, 21 Nov 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200255; cv=none; b=K61MEli0Hqipcbg2fsPQuMbDjL9ljwc85Oy9nBRKGiKh3J4F3HhKgKbT+62rq2lSLaAB8gt1S9V1xPzc5KWORElPX9Bw/O6ANH8GORNnaEGsmiDPgYB1zMXnNYZfQDskjINF2abhpd5mDokDIVNItbq//Ml0I0QCfyKVv1cFFGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200255; c=relaxed/simple;
	bh=WH6zA1+MIUfZhwa/PH2qa3dZoRc301GBKoubmQQg7Uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SxSpWBJPsyzisFSgRQwrCqPWuiJsOlCwHlli1KXkJULNGfJtQLBjZgHja43teJfzXiex9QyKze4kyAbua6EvTx0ff0KSzDjWoHIcB5EjAKEnAd0Q6WvnMMxpO1JplB+h1DQH3KXgsKEObkbJMZrLbn6dhy7w0DNa2OUdj1mSpl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qk45GfvQ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2FB794000C;
	Thu, 21 Nov 2024 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yETHLHBxm1BUiuBXz4EFHD6m1F9pqw5fe/ucOLdBnZ0=;
	b=Qk45GfvQQxggahXsYwMi96xLzBOJJ34wh0tze2YJ8zWbXO2oI6Hjesp9Ao2eYQKZBbzUUg
	JrYC2g1g2oFUn4ld4OIRR4cWqiYkSkkgqPSBr0P/jE4syG0wLypFkgZp6LRCanfN95UOkY
	Hsdm0KlzCVqFNI1xcfsvWPGGkYyJvThikxUiI1vh1yb3r3ZZPM6KuFzxyVUq3Cnaidstm5
	IXC+zE4qXC/M4rHGpot9tNefNpwXZR9tR+4cwRtvMW9yYe6EQIwvA7kVFSqymNMD3XFNwa
	PvegJ9taHJixHjoguNCYLWiSjFq5DbcoCFvj5bUWhb+wJLiRa2v1NwG5jjaHTg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:44 +0100
Subject: [PATCH RFC net-next v3 18/27] net: pse-pd: Fix missing PI of_node
 description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-18-83299fa6967c@bootlin.com>
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

The PI of_node was not assigned in the regulator_config structure, leading
to failures in resolving the correct supply when different power supplies
are assigned to multiple PIs of a PSE controller. This fix ensures that the
of_node is properly set in the regulator_config, allowing accurate supply
resolution for each PI.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 drivers/net/pse-pd/pse_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 8b5a9e7fd9c5..d4cf5523194d 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -419,6 +419,7 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 	rconfig.dev = pcdev->dev;
 	rconfig.driver_data = pcdev;
 	rconfig.init_data = rinit_data;
+	rconfig.of_node = pcdev->pi[id].np;
 
 	rdev = devm_regulator_register(pcdev->dev, rdesc, &rconfig);
 	if (IS_ERR(rdev)) {

-- 
2.34.1


