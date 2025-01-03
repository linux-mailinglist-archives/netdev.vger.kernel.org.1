Return-Path: <netdev+bounces-155071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F4EA00F47
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4040A1883194
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127BC1BEF62;
	Fri,  3 Jan 2025 21:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PgO98vbQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0751619E999;
	Fri,  3 Jan 2025 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938822; cv=none; b=c4W8eHe5byVjl7TzBlA6yKPvknF82pBtiO1QiIOoXUsV2k2JGPm9wP+2t+nlXnll3q35hDJp3pC182utIyeqK/qmQGAmAxDFsEBCkQy8ZGl3iav+Gb0vNiRcSHHTziz7vwO/DguDkJEnDBPnpHhMC4hxhM/duTqBDjAo/xFuLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938822; c=relaxed/simple;
	bh=UUMPOwhD/OSMLvm6RWMgb0w+SlduRacYCi60YSgcv+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBcYLVuKORf9Ninlch3JplyEmAJvVwbpgFuZTk84at3XSZLJWF8grkE9fmRdDhLgrDc4/tRFa3ie9NhZ7Pkxq94cnu0TGPj2AgoHuiro2pI9AYPX9WqcN5pu9x6Q14g2521XYMk5Wfn5fzqQHBDp2xxmY31f+nQ8uMizcxEWTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PgO98vbQ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAE21FF805;
	Fri,  3 Jan 2025 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735938818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmAwpcUiFPn1QI6KqNJX6tcqyTgaUrmROTT178sjteA=;
	b=PgO98vbQ5bQ644ZQ+3zU6ujLTjvj3UB0vJ7WCm6wZIwcmlRl4NxD/pDj4TkmLVXS5uKiDD
	UN1Ypi7tTUzFvMoRUMU9aZ7DsEAAmFlGn57l5yfJnXjzQzeM8t7RCH03U9wVQWA9UuriKz
	FwQ5ugvaSaOm1hxECNkWszG+QPU/Jc+AenL0huBFmQDP87UvzfecqXlQn69tKaUhb16t2p
	gHXcuQoSlKkC3Mg6aUJo9kLPPUyzlF4pQZzGEeKQ+unJaGA3FvFupiuRZHkyYHjxKx8WoH
	uecL0aCoUHkQxhxUzkYxGbbfQjezcX4ocC7jYuMenTdvJENWosYJnV2ofSai/Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Jan 2025 22:12:52 +0100
Subject: [PATCH net-next v4 03/27] net: pse-pd: Add power limit check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-feature_poe_port_prio-v4-3-dc91a3c0c187@bootlin.com>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
In-Reply-To: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Checking only the current limit is not sufficient. According to the
standard, voltage can reach up to 57V and current up to 1.92A, which
exceeds the power limit described in the standard (99.9W). Add a power
limit check to prevent this.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
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


