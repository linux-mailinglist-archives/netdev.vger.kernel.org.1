Return-Path: <netdev+bounces-155204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39369A01725
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 23:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BB11884A47
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 22:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE031D63F6;
	Sat,  4 Jan 2025 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bZGlPGoe"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266A21D5CD9;
	Sat,  4 Jan 2025 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736029733; cv=none; b=Qtl8KfYkLARhrrk3HhVGiR5R4xoMJlDVTq9YW/KuDDoLv1IxngnrsJvBgK8h8KjU83IjnLbvn2tsovZWsfaEIKoQHCUmoMQkOw+7+LR6TAgAxFIm85oJhxSzLh+lY/Ut3ZcXJM6wgUoRvbGackFY4HpGNhm/RoW4RW9SzR1BK2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736029733; c=relaxed/simple;
	bh=EGF2XBjDW8Awwg0TvF7irUc+FKwZ1gZh75vwlba8OpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kRxcx09dPv8axH5ejzaGhOYmTz8VMeVTQDvmgdK7fD2e7O19Lmn+ApLolaXUTNyPActjZpuTw1qrQoNk2YJEWZSIW4eEKHpuUr8jZjJnTRhUIIhhcVx8lu8umq+JDVtn9+4U7YifHH+yIFi6DdZgxFZSlJc47dlGCT2y0PHAlq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bZGlPGoe; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D88040005;
	Sat,  4 Jan 2025 22:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736029729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+g+gzoMaoPkSJtDI4tWVLE+Mf/2uUCxQvYzgSnTXlNQ=;
	b=bZGlPGoeeYf81LizMUm/e35qbpNwmK/yKzqp48qt90U5SdKS+6kBPHIpLx9OjJkk1D3rT7
	9NyDODCtsor8ZX9mnYSMF6cDmDOJ3deW/9z4GcpJ5MwmSKRfYYG2CEg6MvxUmnBH57fRWt
	3oLPVFq38XryRhr0v7bi5oGt3v6ndh1iZwP9rw54D7ho9sjgx1XgX/RZ+NlH0o7oUQbZoG
	EXYfYdlitEYtOelZK/QpThF7XLhdGHPR9qePVSuo+E/tdx+JI5s3LH0id7csnF4zhNQbiw
	AdJxgAttlYSFctmOMuAFPHCrP5A5pnn1Cd/AMKL5AqNUV2JiWDJ7wbmJRZEMgg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sat, 04 Jan 2025 23:27:28 +0100
Subject: [PATCH net-next 03/14] net: pse-pd: Add power limit check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-b4-feature_poe_arrange-v1-3-92f804bd74ed@bootlin.com>
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


