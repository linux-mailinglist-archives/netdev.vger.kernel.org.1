Return-Path: <netdev+bounces-156633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AB6A072D6
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDCF316356C
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393F3218E9E;
	Thu,  9 Jan 2025 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mIhXGucZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85DD215F47;
	Thu,  9 Jan 2025 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417945; cv=none; b=UswxSyh6yWJRK59+4PvqIjYfvzGggZIMXr2hnzT/d8veZxy1tp/ZDyKnp5iAEfGQ7dfL1a+qqqfCP0JlydIbqe6mWxOBcjvzH7zuF6nIpOeBhP95jE5HN1uTpOolO4os27hU8cqVgI1XrzodMDIUf5GkchtOFpjQQ0NFO52dWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417945; c=relaxed/simple;
	bh=RZuO1r59PlVkQGPxJghut1VS50guz4rBU7rH1G5gD3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l26ffdqazxg0ZT4lr9y2EYKobU+Dr46on/LaYwQla/bC4S9ra2Pa+QZPu0kekZh7/GrQvK0Pzy2jzDYdEvfje2tGlKKxVDnO/IIWvcwTOyoAAARyAN01tsKs7plz/sLYgARZZ18DP5P7ig/8/FymCAl+MHOlSgjAqD5QW0Jo7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mIhXGucZ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 68990E000A;
	Thu,  9 Jan 2025 10:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736417939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uU/plfv/Hiqay0ydln3tGT/UUrhcCr+rBb47n8URIY=;
	b=mIhXGucZ+8+WzBSmmO8gsoF8Rd2AU9Tki46Xuvwe85YyRYEW/AZbKrZH9oRwxzbPIeofsb
	vgIVbnR/soaRWzPP/ftr+ZAxr1wTyMS5xjdMumCpEpRdBfD4uujclyxigjysyKAzzQdmrp
	upgcXlQz5u5cA5EO8Ilc+7EQ1s6X6iqNNzFzS5MTtsY/liyBG6bRkiCdKbVPo8/mVhYE9V
	c4V6YK/8ZZP4IE2o1uqvge31vZPdZAg3LoLjKf0YOYmFvVhXpJqloxLPwXCO1qbxFU/LHO
	AovKEaV68bjyX/P7Gh1gZNAS90B/qCWuHCgV6xbKBE/E+ILyEIituiysNcKhlw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Jan 2025 11:18:08 +0100
Subject: [PATCH net-next v2 14/15] net: pse-pd: Fix missing PI of_node
 description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-b4-feature_poe_arrange-v2-14-55ded947b510@bootlin.com>
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


