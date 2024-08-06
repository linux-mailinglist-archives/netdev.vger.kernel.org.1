Return-Path: <netdev+bounces-116198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F28594972B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246981F22A98
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C407347C;
	Tue,  6 Aug 2024 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QF44wfjL"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B09D381C4;
	Tue,  6 Aug 2024 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967032; cv=none; b=QV4EiGJX/hokHBliVUmMn72rBo32U7+1/+aCj50iIJTFROdTOT9f14VxIHP2NpLx0XB2XCDo+FZEbt+S65Fhfdr2ZrzmBVVEsafrkoTPjmxJwlduWBWNloO5fhzmia7e8rroUNEbAl1jqlmoG6psRBfgYPBMoXZeIA0VqwUoGEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967032; c=relaxed/simple;
	bh=lB7A8e4Ovq/7ddI2/3L5U//TjfEpAgLmMbHp5KMmNzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ESInWpbiYN9/lpssD/b1VpiKetEcGaV9MTMjY8PQh5fSbCowiSj0YqoQ/i30QT0C50hwkrpPfdrHPpfyhy2KSkXXvRrT7/2jOOh8HJi4a69WL55iMrU6UPHgBxo3hApia5JSb33B8603AI+cbCo2vDoJEJ1/U4MDo3LgXWBECW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QF44wfjL; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 919AFC0000D8;
	Tue,  6 Aug 2024 10:57:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 919AFC0000D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1722967023;
	bh=lB7A8e4Ovq/7ddI2/3L5U//TjfEpAgLmMbHp5KMmNzY=;
	h=From:To:Cc:Subject:Date:From;
	b=QF44wfjLGrt1lZTxZVTcbR2IlJ1KQSjad2Z2Auz7QE+pjofsSNwC6+zR8bdcHtrS4
	 k2v5x4Dm7Oqcq0vH3PaJHpr/FWX+eKmZf4l9vEHFGKOg4NuGd+4Sjq3SRiKuNWAoQ4
	 F9rYQC/htNBuG1pE3JSFoHDfhGLgKs/voECi3SXY=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id E5F2018041CAC4;
	Tue,  6 Aug 2024 10:57:00 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net: bcmgenet: Properly overlay PHY and MAC Wake-on-LAN capabilities
Date: Tue,  6 Aug 2024 10:56:59 -0700
Message-Id: <20240806175659.3232204-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Wake-on-LAN modes such as WAKE_FILTER may only be supported by the MAC,
while others might be only supported by the PHY. Make sure that the .get_wol()
returns the union of both rather than only that of the PHY if the PHY supports
Wake-on-LAN.

Fixes: 7e400ff35cbe ("net: bcmgenet: Add support for PHY-based Wake-on-LAN")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes in v2:

- corrected email address

 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index 1248792d7fd4..0715ea5bf13e 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -42,19 +42,15 @@ void bcmgenet_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct device *kdev = &priv->pdev->dev;
 
-	if (dev->phydev) {
+	if (dev->phydev)
 		phy_ethtool_get_wol(dev->phydev, wol);
-		if (wol->supported)
-			return;
-	}
 
-	if (!device_can_wakeup(kdev)) {
-		wol->supported = 0;
-		wol->wolopts = 0;
+	/* MAC is not wake-up capable, return what the PHY does */
+	if (!device_can_wakeup(kdev))
 		return;
-	}
 
-	wol->supported = WAKE_MAGIC | WAKE_MAGICSECURE | WAKE_FILTER;
+	/* Overlay MAC capabilities with that of the PHY queried before */
+	wol->supported |= WAKE_MAGIC | WAKE_MAGICSECURE | WAKE_FILTER;
 	wol->wolopts = priv->wolopts;
 	memset(wol->sopass, 0, sizeof(wol->sopass));
 
-- 
2.34.1


