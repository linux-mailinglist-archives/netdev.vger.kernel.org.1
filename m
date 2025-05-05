Return-Path: <netdev+bounces-187685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420E4AA8E76
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 10:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991C33B7C89
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 08:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FF41FBE8B;
	Mon,  5 May 2025 08:43:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B001F5830
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746434634; cv=none; b=puGyWiWFW74Q3Xngpunc5WdJeBLc/jcCs+nflsER3W1p3i6hrosicKfY0eaw+U5maQwBFCsZpkhjlludVMCO7UremykW9MwinWGuDxB5NAeu6RNomdrO5uCnRiMnnBECR/DT7C6i23XQBv1TJp1M0MfhG6FYJB+vQX9LYuLiHKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746434634; c=relaxed/simple;
	bh=czQrwqSOCU4ro8+9cqoU25PAcGWoBynUwIf9q024yyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hsCqG6Dqhsh5+O2/0UDr6bENyl9L9vQHMnYdVPEELUPabe7Qq2t4amQxL2BJxFTafS/epVYfidPjRCBd72B/IMge16hzOvU/4txkNbTYWCtdtVHdesvOKZ/mlXtC4ovm/Gnp84z6oRoUuLMyAdIjifiReOQ05FhNHoCWODFI1as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uBrQN-0005WB-Am; Mon, 05 May 2025 10:43:43 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uBrQM-001CSG-1X;
	Mon, 05 May 2025 10:43:42 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uBrQM-003SQP-19;
	Mon, 05 May 2025 10:43:42 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v8 5/7] net: usb: lan78xx: Extract PHY interrupt acknowledgment to helper
Date: Mon,  5 May 2025 10:43:39 +0200
Message-Id: <20250505084341.824165-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505084341.824165-1-o.rempel@pengutronix.de>
References: <20250505084341.824165-1-o.rempel@pengutronix.de>
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

Move the PHY interrupt acknowledgment logic from lan78xx_link_reset()
to a new helper function lan78xx_phy_int_ack(). This simplifies the
code and prepares for reusing the acknowledgment logic independently
from the full link reset process, such as when using phylink.

No functional change intended.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v6:
- this patch is added in v6
---
 drivers/net/usb/lan78xx.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 07530eef82cb..de2b429e906e 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1636,6 +1636,20 @@ static int lan78xx_mac_reset(struct lan78xx_net *dev)
 	return ret;
 }
 
+/**
+ * lan78xx_phy_int_ack - Acknowledge PHY interrupt
+ * @dev: pointer to the LAN78xx device structure
+ *
+ * This function acknowledges the PHY interrupt by setting the
+ * INT_STS_PHY_INT_ bit in the interrupt status register (INT_STS).
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+static int lan78xx_phy_int_ack(struct lan78xx_net *dev)
+{
+	return lan78xx_write_reg(dev, INT_STS, INT_STS_PHY_INT_);
+}
+
 static int lan78xx_link_reset(struct lan78xx_net *dev)
 {
 	struct phy_device *phydev = dev->net->phydev;
@@ -1644,7 +1658,7 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 	u32 buf;
 
 	/* clear LAN78xx interrupt status */
-	ret = lan78xx_write_reg(dev, INT_STS, INT_STS_PHY_INT_);
+	ret = lan78xx_phy_int_ack(dev);
 	if (unlikely(ret < 0))
 		return ret;
 
-- 
2.39.5


