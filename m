Return-Path: <netdev+bounces-146655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F83E9D4ED9
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5FD0B25C2D
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DA81DDC02;
	Thu, 21 Nov 2024 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U6BdPniQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50D1D86F6;
	Thu, 21 Nov 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200224; cv=none; b=RyCuHzgz5s3KT39GAZF5Oh66RkK46wDBxChgrrM7QZ5maOWfBYw61K1ezd206zPW6nb8lKy/dsvVHWbRWDLOGiqH5HYQjS/bHA0/2xLpqSCePurF6dxfN2dpIl3gb/aqUIbvzxmsO3j9XaFWgdIx9yKI2gr7ux3/5IR1O6UbGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200224; c=relaxed/simple;
	bh=qJswWfPi8lT2mzZnIIIC4cBWZ7Nfz/y4Mv1II5hMV5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jatb+5fh6XgPHccVBhadulHTpGSFVQw5IH+7KxFWgLd1e6g0wVYVVzXcZhaPe9t5r9ZMrK7smQVVV1XxHiBkcrgL+i/nYo7NaulHsdQx6Kk76bwM2AEiwpyp8pnYaXqQK3Jsh4xr+GCK0vBxrdeZXIvQgUDLJ9rjZw2aqS/VqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U6BdPniQ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF5F040011;
	Thu, 21 Nov 2024 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tHPZeF+rLMZJ6NpsuiZNrNpDwdvxaE67fXkw7mxPhw=;
	b=U6BdPniQHZbdrJLLl8vkB42DRF9M1WxIZuFMyy1+Cf3vOAgHSm+AHO1Bhq6piq3OetuSgC
	wEVijjE0ciEDbF8zdf/ifM0jiYl6T+DPHaxw6Sv7co0fRcXiCbJErp1Ut5NN3om0IBopX/
	ntcdabmFv3y/XwWhjE5NAg/KMVO6ETtmDrUjS0ZAds2DwUS6IYDQAtR+/aYdRl+D+1zVo6
	XF2wJqY/MBTWc9tkz5uRSFUV1DUiZ6bZITFwash4/OvdMly42Zl/gg6l/fqu9Ziw1hiphC
	Jq3lbvsSHCLhaTQfva6wIIY/+F32MJy095ECCDzK4stDRSPjw+lseZ9JfIqhqA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:30 +0100
Subject: [PATCH RFC net-next v3 04/27] net: pse-pd: Add power limit check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-4-83299fa6967c@bootlin.com>
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

Checking only the current limit is not sufficient. According to the
standard, voltage can reach up to 57V and current up to 1.92A, which
exceeds the power limit described in the standard (99.9W). Add a power
limit check to prevent this.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change ni v3:
- New patch
---
 drivers/net/pse-pd/pse_core.c | 3 +++
 include/linux/pse-pd/pse.h    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 9fee4dd53515..432b6c2c04f8 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -877,6 +877,9 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
 	int uV, uA, ret;
 	s64 tmp_64;
 
+	if (pw_limit > MAX_PI_PW)
+		return -ERANGE;
+
 	ret = regulator_get_voltage(psec->ps);
 	if (!ret) {
 		NL_SET_ERR_MSG(extack,
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 85a08c349256..bc5addccbf32 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -11,6 +11,8 @@
 
 /* Maximum current in uA according to IEEE 802.3-2022 Table 145-1 */
 #define MAX_PI_CURRENT 1920000
+/* Maximum power in mW according to IEEE 802.3-2022 Table 145-16 */
+#define MAX_PI_PW 99900
 
 struct phy_device;
 struct pse_controller_dev;

-- 
2.34.1


