Return-Path: <netdev+bounces-184593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39963A96500
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD3917995C
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95D820C00D;
	Tue, 22 Apr 2025 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ftL+UXJb"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0BA1F1537;
	Tue, 22 Apr 2025 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315245; cv=none; b=lADvAgY1s1ISpYdoNxMTjcWi7PCLcd5hJ9qRXMLVPnvvPEYSApQoshborTy9/WGKaOogjC4mZN/ORcYyjzXPTZL2UWpzMQVxeCJSxuT4njvglwGdDErrwOEO/MbsWD+hLnyz736Lu5LmcDYLbY0874HbJzaww2AF+zRsA+nRCko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315245; c=relaxed/simple;
	bh=0PH9p9mP8Vk336RcLMsj2+oteyeKujORQWxj6U09IBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eH6X+1f8pOG/z7k6IyFbF1uYM1twsNbIrPHMhV033p5Q8ZeHelY8/eR4Ms2GMiKzjGh7uIgIwJXwndRTvfDAiVgAUqPaBVesnJ1/yhjP0wUfn7GId20VO7G+CQ42Pde7DME4zsPUpdYkSFoIk28ngcv+sPmIb0p1HdLp5jBGmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ftL+UXJb; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 11388439F5;
	Tue, 22 Apr 2025 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745315236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HOVC4B2L2OpNZ3oHbRKcpYJoMkM0vkX1T6jgPrJEEQ=;
	b=ftL+UXJbg+THRycWyHPUoC2wbp9hQ1HeXO8Fn7B2Rg6hjnr6SBAhi33A4jt/7KLm/V8ki8
	F48khAtZTQ5O+fswSSUsoM1sTPYN6ow8TKTqay7mc6HvbRbX7sMiqMXh/xPUShN2ja++of
	B0Y7Z8TUggraqfZHPLs4F/3uu1vWS/5Bnykb+ssISX3cOzIb9GfnkKiS/lxJgmuX+LpZ/A
	pls+NXxxet4QdpcpBDETlKPkiOnIEbOnsV5Ccd3H3XfC/mbdH2c6hV/ALKtUrH4cSPsAU8
	DFU8acQHHKoJ3+ak0BIkg01EUCpnW295hZ9TDmaCh8Q3ckbmDSjzSvPENLmQVA==
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
Subject: [PATCH net 2/3] net: stmmac: socfpga: Don't check for phy to enable the SGMII adapter
Date: Tue, 22 Apr 2025 11:46:56 +0200
Message-ID: <20250422094701.49798-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422094701.49798-1-maxime.chevallier@bootlin.com>
References: <20250422094701.49798-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmegtkedufeemgeejtgeimeejudelrgemlegusghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemtgekudefmeegjegtieemjedulegrmeeluggsfhdphhgvlhhopeguvghvihgtvgdqgedtrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtp
 hhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

The SGMII adapter needs to be enabled for both Cisco SGMII and 1000BaseX
operations. It doesn't make sense to check for an attached phydev here,
as we simply might not have any, in particular if we're using the
1000BaseX interface mode.

So, check only for the presence of a SGMII adapter to re-enable it after
a link config.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 027356033e5e..cc9946b58236 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -67,9 +67,6 @@ static void socfpga_dwmac_fix_mac_speed(void *priv, int speed, unsigned int mode
 	struct socfpga_dwmac *dwmac = (struct socfpga_dwmac *)priv;
 	void __iomem *splitter_base = dwmac->splitter_base;
 	void __iomem *sgmii_adapter_base = dwmac->sgmii_adapter_base;
-	struct device *dev = dwmac->dev;
-	struct net_device *ndev = dev_get_drvdata(dev);
-	struct phy_device *phy_dev = ndev->phydev;
 	u32 val;
 
 	if (sgmii_adapter_base)
@@ -96,7 +93,7 @@ static void socfpga_dwmac_fix_mac_speed(void *priv, int speed, unsigned int mode
 		writel(val, splitter_base + EMAC_SPLITTER_CTRL_REG);
 	}
 
-	if (phy_dev && sgmii_adapter_base)
+	if (sgmii_adapter_base)
 		writew(SGMII_ADAPTER_ENABLE,
 		       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
 }
-- 
2.49.0


