Return-Path: <netdev+bounces-215281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396D7B2DDF3
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2E75E2442
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50F7320CD0;
	Wed, 20 Aug 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yPojbQbw"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D46320CB2
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696815; cv=none; b=jAtfG1tkW4M6DSmdROFIvB5Iw0/dx8qlvLYr5C5NraKoWk1iZvLX7FIUH2LZTgNfO2wKLaiiYgHE4B62ZSWoYiljuzBbug+JRjQNMZCcIfKmrs3PaOH3yiF7n6nF4GYA0j6enc6iON7iLjw0vBsD9VZvyVfXR/srdMvITJPOLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696815; c=relaxed/simple;
	bh=s5nq5zhQ1y3HYWSGGKoVP69NbrF8fp/t313EOBKu9Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/b1lK0kH3SPdrnyNJNQ5M74cE3xKHL58340EIj+++Kt7AtuIJTusa0i2SzcoMNMWzZcwD/9PS/GEBowXeVZm/2R7l8FQdWVyFunvnCeWGM75uWJn2epmLIj3pwIasZS6Ov9BNfK4SOOHXX6TOFjCx/h7IBUn/r5IXw+Dlb8ArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yPojbQbw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 18A96C6B3A5
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 13:33:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A47C8606A0;
	Wed, 20 Aug 2025 13:33:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17D291C22D8CE;
	Wed, 20 Aug 2025 15:33:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755696810; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=1exOsN2tUfvocnLM2bOw6co3KUlzDpgtNbjqhHK9TTc=;
	b=yPojbQbwJyVy2nNadP5X8pNRptPTv47RllAZPCpvUUZe5YVYDfPTyIuxVn4pQ3ZkanVCwa
	qcarx/gh8edE5vmXw+oQU5I828eGX0Fcoos0A+szBkWjBM/n0ZMSFRPy6yO7BFRY9WKOUY
	IALWXvcn3GwCG7SLTsmfYdckAqGORVxkfef3Dj3R+9OF1jfechoUzFma9hni00JM+qVApP
	j9IzEFn3DeeX/gVTwZx/lc8w7ly+/Ts3BKGNqDwPF1IiGwKnQo4qc5/3NP8yFVwBpGmD2K
	2eyjZwrQXs/b4oSClmTAhw0AEnpnll46wbe/I5NioFczn7Xfw7wPsLJtgkNVNA==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: pse-pd: pd692x0: Skip power budget configuration when undefined
Date: Wed, 20 Aug 2025 15:33:21 +0200
Message-ID: <20250820133321.841054-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

If the power supply's power budget is not defined in the device tree,
the current code still requests power and configures the PSE manager
with a 0W power limit, which is undesirable behavior.

Skip power budget configuration entirely when the budget is zero,
avoiding unnecessary power requests and preventing invalid 0W limits
from being set on the PSE manager.

Fixes: 359754013e6a ("net: pse-pd: pd692x0: Add support for PSE PI priority feature")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pd692x0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 395f6c662175..f4e91ba64a66 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -1041,6 +1041,10 @@ pd692x0_configure_managers(struct pd692x0_priv *priv, int nmanagers)
 		int pw_budget;
 
 		pw_budget = regulator_get_unclaimed_power_budget(supply);
+		if (!pw_budget)
+			/* Do nothing if no power budget */
+			continue;
+
 		/* Max power budget per manager */
 		if (pw_budget > 6000000)
 			pw_budget = 6000000;
-- 
2.43.0


