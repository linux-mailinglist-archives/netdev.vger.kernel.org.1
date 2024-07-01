Return-Path: <netdev+bounces-108047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC59D91DA9E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7899CB23FC5
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BAE14EC73;
	Mon,  1 Jul 2024 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kNlE+jEi"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F80129A74;
	Mon,  1 Jul 2024 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823851; cv=none; b=oipWS89sAhpv2Ftb688Vy6MSVncGR3aRpfBjOY56QFuY0ADQhlQ5D+oBwYyxNURSj+Tx40IrA7GnVd+QgXfNmiYl69vDuQGXdSxTQTZ5uc2WowyRrHO36eBgTxhjc7gMLs14wTqMLkuOUYarw6sbsmO5Ja3cMqOifie+QCvX/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823851; c=relaxed/simple;
	bh=n2/xgzsl+qJoK6f43YJ0iruAwF8Tx6e40mU2gJPkrkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C7shQrboYfFbJT2FmONsWc6XPMFQO0TM/UHXzRQq1MV6XzNcAM3R1F3mvFymmK7izf7Zjz3A+76etxsxldbUACees8pWZpQOv7VDBWr8URj9uieE9xNVa/Q8IEn8MtOmUTjIyboLJDe/Em3lEPuBzXTtP8QMtJ4g99Df66Mawjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kNlE+jEi; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A0611C0008;
	Mon,  1 Jul 2024 08:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719823848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwNu9+nW/Ko4RFh/lSyDmVJiYeuN5ritog+3eRgk5Q4=;
	b=kNlE+jEiG+UJrQPUSg21WD+M/se5DBN4BNCINxSHuXl5x8LGZGjOxEV7QIlQTSdND8RQO1
	3EF7M5/aZykTuqHc7+1beyOk+jDVVrJ5ra/I7VkSp3SP1ZDCKce5i/0ITGslFDbjVmnvp6
	RXLTWRU2X+zLL3obVg02uV65ic1WaERrQTx99LKPGt5fnMR52i6CSQOd6UNejzFGNiwSO2
	JV1yYNknbpoNCWHPlsWac3lFEpZOYOx0vCZVjTGLT5l/dWo/x7TpSPq8WdVvJCo2+V8ROi
	alN1bPsapjQTE5rCsaU28tGzSSmLHo1baJEYGwNPET7kNS/5uHXpBrAteEAcIA==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 01 Jul 2024 10:51:08 +0200
Subject: [PATCH net-next 6/6] net: phy: dp83869: Fix link up reporting in
 SGMII bridge mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-b4-dp83869-sfp-v1-6-a71d6d0ad5f8@bootlin.com>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
In-Reply-To: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: romain.gantois@bootlin.com

In RGMII-SGMII bridge mode, the DP83869HM PHY can perform an SGMII
autonegotiation with a downstream link partner. In this operational mode,
the standard link and autonegotiation status bits do not report correct
values, the extended fiber status register must be checked.

Link parameters should theoretically be obtainable from the DP83869
registers after SGMII autonegotiation has completed. However, for unknown
reasons, this is not the case, and the link partner fiber capabilities
register will incorrectly report a remote fault even if the SGMII
autonegotiation was successful.

Modify the read_status() callback of the DP83869 driver to check the fiber
status register in RGMII-SGMII bridge mode. On link up, obtain the link
parameters from the downstream SFP PHY driver if possible. If not, set
speed and duplex to "unknown".

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/dp83869.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index a07ec1be84baf..843af90667d41 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -43,6 +43,7 @@
 #define DP83869_IO_MUX_CFG	0x0170
 #define DP83869_OP_MODE		0x01df
 #define DP83869_FX_CTRL		0x0c00
+#define DP83869_FX_STS		0x0c01
 
 #define DP83869_SW_RESET	BIT(15)
 #define DP83869_SW_RESTART	BIT(14)
@@ -72,6 +73,10 @@
 /* This is the same bit mask as the BMCR so re-use the BMCR default */
 #define DP83869_FX_CTRL_DEFAULT	MII_DP83869_BMCR_DEFAULT
 
+/* FX_STS bits */
+#define DP83869_FX_LSTATUS         BIT(2)
+#define DP83869_FX_ANEGCOMPLETE    BIT(5)
+
 /* CFG1 bits */
 #define DP83869_CFG1_DEFAULT	(ADVERTISE_1000HALF | \
 				 ADVERTISE_1000FULL | \
@@ -160,7 +165,8 @@ struct dp83869_private {
 static int dp83869_read_status(struct phy_device *phydev)
 {
 	struct dp83869_private *dp83869 = phydev->priv;
-	int ret;
+	int ret, old_link = phydev->link;
+	u32 status;
 
 	ret = genphy_read_status(phydev);
 	if (ret)
@@ -176,6 +182,38 @@ static int dp83869_read_status(struct phy_device *phydev)
 		}
 	}
 
+	if (dp83869->mode == DP83869_RGMII_SGMII_BRIDGE) {
+		/* check if SGMII link is up */
+		status = phy_read_mmd(phydev, DP83869_DEVADDR, DP83869_FX_STS);
+
+		phydev->link = status & DP83869_FX_LSTATUS ? 1 : 0;
+		phydev->autoneg_complete = status & DP83869_FX_ANEGCOMPLETE ? 1 : 0;
+
+		if (!phydev->autoneg_complete) {
+			phydev->link = 0;
+		} else if (phydev->link && !old_link) {
+			/* It seems like link status and duplex resolved from
+			 * SGMII autonegotiation are incorrectly reported in
+			 * the fiber link partner capabilities register and in
+			 * the PHY status register. If there is a handle to the
+			 * downstream PHY, read link parameters from it. If
+			 * not, fallback to unknown.
+			 */
+
+			if (dp83869->mod_phy) {
+				ret = phy_read_status(dp83869->mod_phy);
+				if (ret)
+					return ret;
+
+				phydev->speed = dp83869->mod_phy->speed;
+				phydev->duplex = dp83869->mod_phy->duplex;
+			} else {
+				phydev->speed = SPEED_UNKNOWN;
+				phydev->duplex = DUPLEX_UNKNOWN;
+			}
+		}
+	}
+
 	return 0;
 }
 

-- 
2.45.2


