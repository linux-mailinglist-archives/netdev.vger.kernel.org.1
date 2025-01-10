Return-Path: <netdev+bounces-157053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511E1A08C79
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43671647A1
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA37220CCF7;
	Fri, 10 Jan 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fGwF+s3A"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4520C476;
	Fri, 10 Jan 2025 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502049; cv=none; b=EUkzTLF5M8RU7B5A+rLxLBjecTt1CbzqQCKC1SGf84klZwJWo5OPVap13SDF20ToxMAYu0UNfAt1QYezLU9wPCnPDiShs/xID/WtYE4pV+mRV/Ht+0C43h9W3C0Sehp9ejttLLy2JFHSJ/vZKTwzQvrBf69xRN3Evv1iZnDzsFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502049; c=relaxed/simple;
	bh=ssAatFtrCSvGNmhy/cn2ov59a1vQtKHn3xvPA+YWaIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IW2rV0CzRKU48xGB3JA0zEtuijiO2tDMAjwhJa1cCEgLS64c76CuQBZiIjViPFfxWC7vf4WxGZxKMQAx/zMzGM9pX7xLpXuSyZcg69tsum2ro55cvVQUMiXZtCXK5f4pS+aoryNLNYvmOg0azjgDtbq7F18QMxKgP1PHdWnVTGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fGwF+s3A; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E295A60009;
	Fri, 10 Jan 2025 09:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736502045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74Dx01iGSe/fzR7rOz37ZEZ7l12S8gsmql5NNsn1KUs=;
	b=fGwF+s3AM0w3nYgHJVkVd/e4OAhxkBHlsdxsmX4pnj36tGeaU6ygal450J4Un0FHPGi0Ds
	6WUWTomhM/7YGBhCX5gCB2cjX1o3rb4MxV7BCOY/cm9lZXq7adAbGEGEr8VpnRyUf3+K4U
	9YqZxtPrI6Xg7Kdq95mKTcZJJC86jfHXbM5dCG0WKlzwk3l8La71pSgHr1F5nB39v6iuvh
	PUcRKMQErQfJInZLpW2nTz/a8PkfNVBnlNEFyEJmSCXqVL2GPq2pzTmANXiF1HHenO+EUN
	U2DI3cxa9GY/U1rN4++YZ/C7DtxDM1QIwAuvUD50B5itZwX9hjyxNqyo4mkXiQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 10 Jan 2025 10:40:22 +0100
Subject: [PATCH net-next v3 03/12] net: pse-pd: Add power limit check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-feature_poe_arrange-v3-3-142279aedb94@bootlin.com>
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

Checking only the current limit is not sufficient. According to the
standard, voltage can reach up to 57V and current up to 1.92A, which
exceeds the power limit described in the standard (99.9W). Add a power
limit check to prevent this.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
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


