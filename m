Return-Path: <netdev+bounces-152183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 434B29F3022
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAF8188369E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21F2204C3C;
	Mon, 16 Dec 2024 12:09:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC120012C
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350997; cv=none; b=CFAbjzR+aYXzsORWTyNxUCClq0kEum9rB+pXRPSp7oHZ68Sbn2EABgiyJeGw6y+r3tNPETylUzSZi56rVso3I0H9OQnWQqsJ54b3dsRAYagzG8rmZmtEQAB202fwTGSU5Iv5FTYr4FhIlZ6N2Cj2AKgIJTbMTsNjUAPH6J4Dmhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350997; c=relaxed/simple;
	bh=K8ZLnhui7MxNWTpLIfd7FUINitbEMDvMaUXPUagB+UY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m44dJOysZIoaTPSWEPi1hQAheTJz7qwuPxFCHhjoGZ2ZFt4IBYdaSS+XI5Z9yIFH1sw091WA3Cv+2px6kUTqTFt7G58bJAJF4jNtPuNQ1rp+J6fecyQ4vGweJEmu7bRXwk2Zsj/7ymC/IOckSzVmVAbbGtWjs8kncP506W/KPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9v1-0001C2-9H; Mon, 16 Dec 2024 13:09:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9uw-003h1h-27;
	Mon, 16 Dec 2024 13:09:43 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9ux-0075tf-1B;
	Mon, 16 Dec 2024 13:09:43 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v1 1/6] net: usb: lan78xx: Add error handling to lan78xx_get_regs
Date: Mon, 16 Dec 2024 13:09:36 +0100
Message-Id: <20241216120941.1690908-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216120941.1690908-1-o.rempel@pengutronix.de>
References: <20241216120941.1690908-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Update `lan78xx_get_regs` to handle errors during register and PHY
reads. Log warnings for failed reads and exit the function early if an
error occurs. Drop all previously logged registers to signal
inconsistent readings to the user space. This ensures that invalid data
is not returned to users.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 4661d131b190..270345fcad65 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2108,20 +2108,44 @@ static void
 lan78xx_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 		 void *buf)
 {
-	u32 *data = buf;
-	int i, j;
 	struct lan78xx_net *dev = netdev_priv(netdev);
+	unsigned int data_count = 0;
+	u32 *data = buf;
+	int i, j, ret;
 
 	/* Read Device/MAC registers */
-	for (i = 0; i < ARRAY_SIZE(lan78xx_regs); i++)
-		lan78xx_read_reg(dev, lan78xx_regs[i], &data[i]);
+	for (i = 0; i < ARRAY_SIZE(lan78xx_regs); i++) {
+		ret = lan78xx_read_reg(dev, lan78xx_regs[i], &data[i]);
+		if (ret < 0) {
+			netdev_warn(dev->net,
+				    "failed to read register 0x%08x\n",
+				    lan78xx_regs[i]);
+			goto clean_data;
+		}
+
+		data_count++;
+	}
 
 	if (!netdev->phydev)
 		return;
 
 	/* Read PHY registers */
-	for (j = 0; j < 32; i++, j++)
-		data[i] = phy_read(netdev->phydev, j);
+	for (j = 0; j < 32; i++, j++) {
+		ret = phy_read(netdev->phydev, j);
+		if (ret < 0) {
+			netdev_warn(dev->net,
+				    "failed to read PHY register 0x%02x\n", j);
+			goto clean_data;
+		}
+
+		data[i] = ret;
+		data_count++;
+	}
+
+	return;
+
+clean_data:
+	memset(data, 0, data_count * sizeof(u32));
 }
 
 static const struct ethtool_ops lan78xx_ethtool_ops = {
-- 
2.39.5


