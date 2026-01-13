Return-Path: <netdev+bounces-249349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A55AED170E8
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3BB83053F84
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 07:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6242B36A024;
	Tue, 13 Jan 2026 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IhV3i2/m"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BA736923C
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290229; cv=none; b=oPhwRnXwDyKjVT7JGI61Gkzu1Aij0P64efh2V6cvzmdTeC/AkLlQhgKNqqCYOOK4ey+s0lrR8D35ri18aTUh4z0MSPeJ/IStL2dP+7jpNqagAv4n0yDRF3emfNksHNu4jALKzQ2vbiWPN5pKz5+ybM/tMbmHQAM1zi2GcfAuP20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290229; c=relaxed/simple;
	bh=OQDoSB2IzjLVr1l775Y7jgqqODinC4ipSFd3uBtG/0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GrW+Dn3op2t5Jv7NkbFDgs5EyMIvSegeEsT0cDZN1XquSFCasQI8YaPegb/mkFbvNu4OCWA/lwGxBFlLH8Fr4YHj9wlXE9ozfuj+c08KfxPtYeDtZVYTF20u5R9uze09DGFCv0dXAr8/nVR/9rjhHYZQ89rR45llKT9UEwJY/Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IhV3i2/m; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 09A83C20878;
	Tue, 13 Jan 2026 07:43:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6909B60732;
	Tue, 13 Jan 2026 07:43:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4EF4A103C9297;
	Tue, 13 Jan 2026 08:43:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768290209; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=HmfawJeph5zrc/JQ3yN5fBTmU7PzUKSvNQ03fKIgN2o=;
	b=IhV3i2/mfLNUHoS9K/xk7g7E069bNzozobESkhXkwuKPnhHyjy/jqwYbzx0j3daBQPjIGA
	6QGC8dBTCvXj9I0G5YZT93WIzHOL3aYorIE+LXOc0iLbA7ws4ymwoCZvEFP3yDbD9IMLtC
	MD2HEPEof7ZIKuV9PP0YsBocy35oQPc890QxD2gueebMpFM5nOjR0siIjuIJV8pqmzBFkc
	qvwjx0u1+afdtnUtZqz9dNt7R0hc9X+jk3pZN+/Ib6UMSc5vvw6NtQVc1O2G7cwhL/wfUM
	RofTXY/40NkSj9F06BLr1wIoGGEgNWlFBzinX7nq2dadLtRQcNOzX4MJq5jnkw==
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
Subject: [PATCH net] net: freescale: ucc_geth: Return early when TBI found can't be found
Date: Tue, 13 Jan 2026 08:43:15 +0100
Message-ID: <20260113074316.145077-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

In ucc_geth's .mac_config(), we configure the TBI block represented by a
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


