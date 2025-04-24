Return-Path: <netdev+bounces-185405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D05A9A2FD
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9897F1945C66
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 07:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E651E0E0C;
	Thu, 24 Apr 2025 07:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FH64OYzN"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7CC199396;
	Thu, 24 Apr 2025 07:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478761; cv=none; b=sx/HAmkk9XqHHC+E43gR8waEO9MKspZ+SXy0B4ajdqxl1Y/dqteceLs9DZ1cjFTUgOVLwW9i3lDNJgHVFDUXL9ilOAZoHKEr3UJ4Hv+os89okXM2h7aZGm9mLogFrTyRYJQVgfYqP3d8TQiUr0DT7c2ihx5cHNBeYVZWmDir5Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478761; c=relaxed/simple;
	bh=t/pWsp/zfbzUo9GXCLAE30G9UHFVepGNcZmmwItA5p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fep8bh19IiFfMvzM37y4CoVYL48yLOtfSSm9+euzY7ed4CmmeuKBKtSZNoFIQ9dNdxWWVNY70RAjP+r4CR9kKYMGprQsGpp+DZpE1pdjdVJWdbbM/Wh6TK2/nJ1Fsa/cxccX6npUH79/8Do54+4t5aKO0HZkzd8V3fgvSRsl2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FH64OYzN; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C216243A39;
	Thu, 24 Apr 2025 07:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745478752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GcCvskkAvrE3dpzstivzwhhvcSYs52ScThWYLV//VMw=;
	b=FH64OYzN4ny6D8XvWJGI1+JqPMBtzoiw0J5FosX91MoJQ77obJ9tlfJacevOlh2LwkDCdW
	mdzeLjuoAjddgSIm4zn9NNwj3GHnYK1T471kttz1fPQFjmYIGkUJaODH+86Pn/sNWw2IJ1
	B24reWtN+2yu625G1qI6G+L98W8fQ653NwLnMe+xz04OFcEeGzivoPFLeCNkLe1oKS5gmn
	xGtxyBFT8U5a+63nzv6Zi9hr4vSKSKAs6V6NjJh09GIA59r4odws4C7IWxaHod71fQqFYA
	cJ3AneYbCufIv3qa4ZHVo23GzUPrL/RsTiha6Jp2w148fXxCN5LaCpG8gWvTbQ==
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
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v3 2/3] net: stmmac: socfpga: Don't check for phy to enable the SGMII adapter
Date: Thu, 24 Apr 2025 09:12:21 +0200
Message-ID: <20250424071223.221239-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424071223.221239-1-maxime.chevallier@bootlin.com>
References: <20250424071223.221239-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeekkeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhto
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


