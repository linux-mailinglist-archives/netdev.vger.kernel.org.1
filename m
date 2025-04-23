Return-Path: <netdev+bounces-185030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1E8A98458
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 10:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CDC16D6D4
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 08:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4D81EEA4E;
	Wed, 23 Apr 2025 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AJlCFN0M"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CE1A0BC9;
	Wed, 23 Apr 2025 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745398530; cv=none; b=J7lBtasdNsriBtg65+QMi3vq7feHc4gmO/Q+r+hGpZ7LYtgWEIDi7qsKgmzIAf3+apuLYkuiRnnmxYc+hT1PSozOFJuYfaOu3xr6rrFD2upVzqnxogohPB0e4nImGDjTupHbYWBG0V4yPA4e3IcNWvJpHh3fyNHbNqFTUEGfKGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745398530; c=relaxed/simple;
	bh=iK5JKL9hlq7qXNojzecBpcwTbzYKFg8YAyL8kj9enus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4068gejPeB69GlY7TBGQf3+pgxR65l/C96svwfp8V6RygaxOY/ldKVmI7BCUcP+eNCd0lcYvKZ+j4vcbgv4jbpi3SZ/Gi4lDyAPAQhmO7v0aYabCJC7GJ7Xp23uI/5K+WnhgvRXoRpBBDR3C/dRjmsn/5JocIL1pptbPOfnxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AJlCFN0M; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 91FA743215;
	Wed, 23 Apr 2025 08:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745398527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4x+uEvsnGyYb6WfnJIlhhjPDMnXiisRE6ULshWkLTY=;
	b=AJlCFN0MyhXNQ5Lv3em0yF67jzY/+WScxeZE8IB/Qb1Avp/n9KUZW7ubwrsWqIYtAC8Jbm
	1yI0TLYHsM/awbmD03ElpASSAiIZ5FKMyAXAnSG7qwQc300epVwpIqC/Ys0frvoH+Ph3tN
	FoFApe/MtYUukArTFX3fEBzRzkdyDNta66XOtKCwhLcQzW+opnB91mGVJDTg65EVrNxTKq
	oGhs6jVopC/9R6p6AJT0FZOYRqMiitmEHMhoWKuA55b0eL46bkv6UcRPQ4Wqgjtev/Zkxd
	hHBMM+jm7NJEZKndQkndz0eWf1sbP8nYj+opDCPjDtcWLiSCuKPmyVxt8vrlkQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH net v2 2/3] net: stmmac: socfpga: Don't check for phy to enable the SGMII adapter
Date: Wed, 23 Apr 2025 12:46:44 +0200
Message-ID: <20250423104646.189648-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423104646.189648-1-maxime.chevallier@bootlin.com>
References: <20250423104646.189648-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeiudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhto
 hepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

The SGMII adapter needs to be enabled for both Cisco SGMII and 1000BaseX
operations. It doesn't make sense to check for an attached phydev here,
as we simply might not have any, in particular if we're using the
1000BaseX interface mode.

Make so that we only re-enable the SGMII adapter when it's present, and
when we use a phy_mode that is handled by said adapter.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: - Following Russell's review, added a check for the phy_interface.
    - Had to rename some variables around, following the naming
      conventions for that driver

 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 027356033e5e..c832a41c1747 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -62,14 +62,13 @@ struct socfpga_dwmac {
 	struct mdio_device *pcs_mdiodev;
 };
 
-static void socfpga_dwmac_fix_mac_speed(void *priv, int speed, unsigned int mode)
+static void socfpga_dwmac_fix_mac_speed(void *bsp_priv, int speed,
+					unsigned int mode)
 {
-	struct socfpga_dwmac *dwmac = (struct socfpga_dwmac *)priv;
+	struct socfpga_dwmac *dwmac = (struct socfpga_dwmac *)bsp_priv;
+	struct stmmac_priv *priv = netdev_priv(dev_get_drvdata(dwmac->dev));
 	void __iomem *splitter_base = dwmac->splitter_base;
 	void __iomem *sgmii_adapter_base = dwmac->sgmii_adapter_base;
-	struct device *dev = dwmac->dev;
-	struct net_device *ndev = dev_get_drvdata(dev);
-	struct phy_device *phy_dev = ndev->phydev;
 	u32 val;
 
 	if (sgmii_adapter_base)
@@ -96,7 +95,9 @@ static void socfpga_dwmac_fix_mac_speed(void *priv, int speed, unsigned int mode
 		writel(val, splitter_base + EMAC_SPLITTER_CTRL_REG);
 	}
 
-	if (phy_dev && sgmii_adapter_base)
+	if ((priv->plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
+	     priv->plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) &&
+	     sgmii_adapter_base)
 		writew(SGMII_ADAPTER_ENABLE,
 		       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
 }
-- 
2.49.0


