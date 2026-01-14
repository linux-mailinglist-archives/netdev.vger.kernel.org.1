Return-Path: <netdev+bounces-249740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D897D1D08A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFBEF30D3449
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 08:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C4D37E316;
	Wed, 14 Jan 2026 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FJq06CMr"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5372437E318;
	Wed, 14 Jan 2026 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377790; cv=none; b=nq5qKq4WQZIhWZEE3LTMojan8GXNvqqD/OMTlOsHbzX1dVKzxplmtflKjuq4o5R+IKK8N7nHlHI2aPgbnplPFP0OnD/7tYdV3BiKUXZpqNgDSql2uwQdHFxYVAfebbNFmqJDjoGxzOwpKXRGPSGmxNEVVYO9M3CbFKOtvXCpq/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377790; c=relaxed/simple;
	bh=3Cy75C8SwBJveuLRIllyUR4JqbxG2bTS5ghjcJHUvV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBN0r7lHrVXc3BQKjdYLA/nkTv4zNMmsj9OnHbXLKrblpsvypJnM6L38O+hCDaQFa+Z4jNvLwVk9hmM/9A+gJ1SU3hpYZCMtNHAH2pU3O+NwPN/brh2vAAQj8x7Ant1qcGr2zaa64snxCyhlH7PdGYhAjT2rnU/Fr4tZ15TuMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FJq06CMr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DAB164E420CD;
	Wed, 14 Jan 2026 08:03:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC76E6074A;
	Wed, 14 Jan 2026 08:03:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B92AC103C82AE;
	Wed, 14 Jan 2026 09:02:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768377783; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=wccHyx90+77q+HvZP634VNgb7Z8yQVCGjbolkwO42fU=;
	b=FJq06CMrGUsDp0A7dlUoJU+xfMq5DxDxyEC6GTwjQmZzHw3askRRyKuu1uzafbDGFiC2JC
	rCnVtNMkayGQPuLM2ccJOsElIwo1a4A/HoXR60cJjMvd1sFYM01l9lTnRQDla6Bp4kPMTN
	f/9YhGRCIB0PjRjOMvr4c8X1qTR6E7DIpJmQGipvjmtR5FRbmG0ZuWbRtjdDLjQ8+J4tGJ
	tEdWoTq8MjhyRKNF3PsFvZG/Zq42qwyW3AVmPxRnmktiNIod/j4Id5Pw3t7sS3KII/f/6n
	FKaNMORzYf6o673G1wWB5+zeehxBs9l67sSNcACddVYTdP6GTd6AK2RlXYBd0Q==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net v2] net: freescale: ucc_geth: Return early when TBI PHY can't be found
Date: Wed, 14 Jan 2026 09:02:46 +0100
Message-ID: <20260114080247.366252-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

In ucc_geth's .mac_config(), we configure the TBI Serdes block represented by a
struct phy_device that we get from firmware.

While porting to phylink, a check was missed to make sure we don't try
to access the TBI PHY if we can't get it. Let's add it and return early
in case of error

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202601130843.rFGNXA5a-lkp@intel.com/
Fixes: 53036aa8d031 ("net: freescale: ucc_geth: phylink conversion")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: Fix commit title, adjust a bit the commit log. No code change.

 drivers/net/ethernet/freescale/ucc_geth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index affd5a6c44e7..131d1210dc4a 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -1602,8 +1602,10 @@ static void ugeth_mac_config(struct phylink_config *config, unsigned int mode,
 			pr_warn("TBI mode requires that the device tree specify a tbi-handle\n");
 
 		tbiphy = of_phy_find_device(ug_info->tbi_node);
-		if (!tbiphy)
+		if (!tbiphy) {
 			pr_warn("Could not get TBI device\n");
+			return;
+		}
 
 		value = phy_read(tbiphy, ENET_TBI_MII_CR);
 		value &= ~0x1000;	/* Turn off autonegotiation */
-- 
2.49.0


