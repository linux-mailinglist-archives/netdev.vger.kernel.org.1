Return-Path: <netdev+bounces-195416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D98A7AD014F
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64113189C621
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 11:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128222882B7;
	Fri,  6 Jun 2025 11:42:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF8F20330;
	Fri,  6 Jun 2025 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210139; cv=none; b=CLBH+iip1i8L6IbrywS0x/XYVbjq9BUXy4iXPylWrF6cSddWG5GNjsV5G4jehi+DC0NyBR6tqnT73YY9gfnyC8oXIekjZ0AB8GcZG6IDXlDoozasb46mjpx/Pw/0nzzAOLpINzbEcvNKAOioeJgRHn0nnNFb1+nJt4ULKqTax/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210139; c=relaxed/simple;
	bh=8PsZDoTyvn/Y6iWD1ngXKZWPsOgm5ADCIiIzcV+/LDc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YFdFE0T5gAEjOZ2kuUTQlk/G5OWsKwZ6E95pDd5kXiantwpX6DKCKFQvuqxUEQma6ME/2qo186vRfWoTPfswyWBQvQLBWq7497dDbDaroFXHNG8R2BXhtBO+kVbivs3qoejNitmLZBAPLfRu93M/qQgJBbzLHarxUxYypqOTDRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: o7kRqhfWR66MAqt/vaJ5Qg==
X-CSE-MsgGUID: b0V1uM+gR6GKt69zGmHXsg==
X-IronPort-AV: E=Sophos;i="6.16,215,1744041600"; 
   d="scan'208";a="142379736"
From: Xandy.Xiong <xiongliang@xiaomi.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Furong Xu
	<0x1207@gmail.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xiongliang@xiaomi.com>
Subject: [PATCH] net: stmmac: add support for platform specific config.
Date: Fri, 6 Jun 2025 19:41:55 +0800
Message-ID: <20250606114155.3517-1-xiongliang@xiaomi.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX03.mioffice.cn (10.237.8.123) To bj-mbx09.mioffice.cn
 (10.237.8.129)

This patch adds support for platform-specific init config in the
stmmac driver. As SMMU remap, must after dma descriptor setup,
and same mac link caps must init before phy init. To support these feature,
a new function pointer 'fix_mac_config' is added to the
plat_stmmacenet_data structure.
And call the function pointer 'fix_mac_config' in the __stmmac_open().

Signed-off-by: Xandy.Xiong <xiongliang@xiaomi.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
 include/linux/stmmac.h                            | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 085c09039af4..8d629a3c2237 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4041,6 +4041,10 @@ static int __stmmac_open(struct net_device *dev,
 	if (ret < 0)
 		return ret;
 
+	/* Same mac config must before phy init and after stmmac_setup_dma_desc */
+	if (priv->plat->fix_mac_config)
+		priv->plat->fix_mac_config(dev, priv->plat->bsp_priv);
+
 	if ((!priv->hw->xpcs ||
 	     xpcs_get_an_mode(priv->hw->xpcs, mode) != DW_AN_C73)) {
 		ret = stmmac_init_phy(dev);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 26ddf95d23f9..0a6021e5b932 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -239,6 +239,7 @@ struct plat_stmmacenet_data {
 			       phy_interface_t interface, int speed);
 	void (*fix_mac_speed)(void *priv, int speed, unsigned int mode);
 	int (*fix_soc_reset)(void *priv, void __iomem *ioaddr);
+	int (*fix_mac_config)(struct net_device *ndev, void *priv);
 	int (*serdes_powerup)(struct net_device *ndev, void *priv);
 	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
 	int (*mac_finish)(struct net_device *ndev,
-- 
2.25.1


