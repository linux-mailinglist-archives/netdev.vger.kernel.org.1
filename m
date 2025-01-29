Return-Path: <netdev+bounces-161569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F62A226E1
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 00:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146451887BBE
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 23:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0091D6DC5;
	Wed, 29 Jan 2025 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K5KcHlLe"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B11BC07B;
	Wed, 29 Jan 2025 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192894; cv=none; b=nKA9Hdr7trNmiz9kxvr+qzxeClmXE0/4kNHdlRm1wV6CcrNZ4wK4uMmyGrmtGF+/svGoLJdsHKWWWC/FBQEMumVNNZ48xXu4JCVdFAHgZIk0HzBWhabKF5gwtT012q1I0GKkXZmqCd752b+9D/BIwnvR5eRhSRLnOjYePicXeCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192894; c=relaxed/simple;
	bh=4FeOkGZBh/0yuCr003fig1VlcrHaZw3JD4/R63A9Isk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHUPeQGOgy4/PvWXPQgp9niytxwBU4fdz1iSnskXDYj+7ZIvNHP1Gs//6qfmI82Db7KQKG8e0AxW0l5EW/BXdjXLUoNjQaQCB0psOEbeBS6vZUh3yBJqHe7f/ViUvRh7fflF/zz6y1khsqyDuHnhbaht7dpohujmgf+OychvYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K5KcHlLe; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 971CFC0005F5;
	Wed, 29 Jan 2025 15:13:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 971CFC0005F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1738192428;
	bh=4FeOkGZBh/0yuCr003fig1VlcrHaZw3JD4/R63A9Isk=;
	h=From:To:Cc:Subject:Date:From;
	b=K5KcHlLeZsIl4A2GQbl1pRpXZb7ceayKKN51nfXTdYyUkojMpj8XFcj2HNuTaxVSf
	 iflVZWZ06wYRmT/Obc+8ba0eUOuFQf0y6gLMYAwe3hn/KWeU47LUOttrQpbOneVOuw
	 lNYabOyZhC5CXuxw5N8t2zJe2Nfg1wheIGC+wud4=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 386F318041CAC6;
	Wed, 29 Jan 2025 15:13:48 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: bcmgenet: Correct overlaying of PHY and MAC Wake-on-LAN
Date: Wed, 29 Jan 2025 15:13:42 -0800
Message-ID: <20250129231342.35013-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
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

When disabling Wake-on-LAN, make sure that this is done at both the PHY
and MAC level, rather than doing an early return from the PHY driver.

Fixes: 7e400ff35cbe ("net: bcmgenet: Add support for PHY-based Wake-on-LAN")
Fixes: 9ee09edc05f2 ("net: bcmgenet: Properly overlay PHY and MAC Wake-on-LAN capabilities")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet_wol.c   | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index 0715ea5bf13e..3b082114f2e5 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -41,9 +41,12 @@ void bcmgenet_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct device *kdev = &priv->pdev->dev;
+	u32 phy_wolopts = 0;
 
-	if (dev->phydev)
+	if (dev->phydev) {
 		phy_ethtool_get_wol(dev->phydev, wol);
+		phy_wolopts = wol->wolopts;
+	}
 
 	/* MAC is not wake-up capable, return what the PHY does */
 	if (!device_can_wakeup(kdev))
@@ -51,9 +54,14 @@ void bcmgenet_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 
 	/* Overlay MAC capabilities with that of the PHY queried before */
 	wol->supported |= WAKE_MAGIC | WAKE_MAGICSECURE | WAKE_FILTER;
-	wol->wolopts = priv->wolopts;
-	memset(wol->sopass, 0, sizeof(wol->sopass));
+	wol->wolopts |= priv->wolopts;
 
+	/* Return the PHY configured magic password */
+	if (phy_wolopts & WAKE_MAGICSECURE)
+		return;
+
+	/* Otherwise the MAC one */
+	memset(wol->sopass, 0, sizeof(wol->sopass));
 	if (wol->wolopts & WAKE_MAGICSECURE)
 		memcpy(wol->sopass, priv->sopass, sizeof(priv->sopass));
 }
@@ -70,7 +78,7 @@ int bcmgenet_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 	/* Try Wake-on-LAN from the PHY first */
 	if (dev->phydev) {
 		ret = phy_ethtool_set_wol(dev->phydev, wol);
-		if (ret != -EOPNOTSUPP)
+		if (ret != -EOPNOTSUPP && wol->wolopts)
 			return ret;
 	}
 
-- 
2.43.0


