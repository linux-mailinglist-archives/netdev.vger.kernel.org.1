Return-Path: <netdev+bounces-115846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3F8948037
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 19:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8365E1F232D9
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFAF15E5CB;
	Mon,  5 Aug 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="n5zHDR3W"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913C15ECC2;
	Mon,  5 Aug 2024 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722878736; cv=none; b=CV73n1yRDT4Asw49SE8B05OBRIlZ36eT1nz+hR2Qpx9dTjyLUGOvVbR+uRE0TP5QbxbCjW+LuuBURySdA/2qWQVSw+clyHGKhE9iqb1IXpKJHRwCgGp4RLEdxYv1LHikqrDR4xgVy3r9FhIl42xXaAX+j8yxTJY+NFYt8HuqIfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722878736; c=relaxed/simple;
	bh=DQVPx+SOwk2yMJ3OToQWa+B7sNes5WowJhkrFAOuTEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HfaQ60NEsXzijTwAZv1hLT95GU1Qu88F9u9OidISL29310HrfgI6MkcxnZ2+ASmciH2tYlaZEgMm5UtnQd+NmhkumZu5ogFVt6+UCBwTKIcMN5zhut99yLnOkV2s33tL85iuExW5UHUK11qZtSCbZqGYwGOHoZY/bo6DGxLZaM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=n5zHDR3W; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 84C68C0000F1;
	Mon,  5 Aug 2024 10:25:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 84C68C0000F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1722878727;
	bh=DQVPx+SOwk2yMJ3OToQWa+B7sNes5WowJhkrFAOuTEQ=;
	h=From:To:Cc:Subject:Date:From;
	b=n5zHDR3WO2A3THxtXyHEn/C+604uyLR6W90U3OfBbVRS1xNdv8g+M5sRd3OAykYq3
	 dQSEH89EVpAkULgqq6ZNh+y/OPzHXaj0j404l1WG3IkySYWlq8VUq56tZoU4E6toqR
	 wfJU3tdvBfdzFVAYCOqtJCm+payyzylr2zVmte1Q=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id DADBF18041CAC4;
	Mon,  5 Aug 2024 10:25:24 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: bcmgenet: Properly overlay PHY and MAC Wake-on-LAN capabilities
Date: Mon,  5 Aug 2024 10:25:22 -0700
Message-Id: <20240805172522.3114032-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

Some Wake-on-LAN modes such as WAKE_FILTER may only be supported by the MAC,
while others might be only supported by the PHY. Make sure that the .get_wol()
returns the union of both rather than only that of the PHY if the PHY supports
Wake-on-LAN.

Fixes: 7e400ff35cbe ("net: bcmgenet: Add support for PHY-based Wake-on-LAN")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
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


