Return-Path: <netdev+bounces-107247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937B991A6B4
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5CF282A25
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D674167DAC;
	Thu, 27 Jun 2024 12:39:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0AA160797
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719491977; cv=none; b=mPuQSWmKKbRVoMJiNTz1c8AjFityaSMbatuTOnMmLqvQSvPWrQAa+wmMLNW3sIloSOalt4czScLWLeVW/UgScnrKxLf5Y7t82anloHGZRy1fVcxTGv5PAU/Yeqaa4GK/EMyYrsUWALz5aJAQFD0mISdw8TtEScG5R6XWMxme6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719491977; c=relaxed/simple;
	bh=4/slF+Rv/3/E6hodmHYTkfxGX2r20IbdIV3tNTbBCT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oCrc7mXKwcOH8dL15yVhrPc5mf9cBajTy0FLMrJlttrCVIPh2jf1e0E/F71sAH03iRMfVnzTOwwsB6ihJwkZhkHynF6XaqPNdrOUK/F8y8VNG73n9RypYx7Mfr7pW7225R92JiBsbpLuO8Vljh9qNVCNz4G6va+7BP1MdjBc2k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sMoPC-00015B-7g; Thu, 27 Jun 2024 14:39:14 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sMoPA-005Mws-OT; Thu, 27 Jun 2024 14:39:12 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sMoPA-000xBf-2F;
	Thu, 27 Jun 2024 14:39:12 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v1 1/3] net: dsa: microchip: lan9372: add 100BaseTX PHY support
Date: Thu, 27 Jun 2024 14:39:09 +0200
Message-Id: <20240627123911.227480-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240627123911.227480-1-o.rempel@pengutronix.de>
References: <20240627123911.227480-1-o.rempel@pengutronix.de>
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

From: Lucas Stach <l.stach@pengutronix.de>

On the LAN9372 the 4th internal PHY is a 100BaseTX PHY instead of a 100BaseT1
PHY. The 100BaseTX PHYs have a different base register offset.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_common.h   | 1 +
 drivers/net/dsa/microchip/lan937x_main.c | 3 +++
 drivers/net/dsa/microchip/lan937x_reg.h  | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index c784fd23a9937..f901cbe7cfdd5 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -22,6 +22,7 @@
 /* all KSZ switches count ports from 1 */
 #define KSZ_PORT_1 0
 #define KSZ_PORT_2 1
+#define KSZ_PORT_4 3
 
 struct ksz_device;
 struct ksz_port;
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index b479a628b1ae5..e907a5602035c 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -55,6 +55,9 @@ static int lan937x_vphy_ind_addr_wr(struct ksz_device *dev, int addr, int reg)
 	u16 addr_base = REG_PORT_T1_PHY_CTRL_BASE;
 	u16 temp;
 
+	if (dev->info->chip_id == LAN9372_CHIP_ID && addr == KSZ_PORT_4)
+		addr_base = REG_PORT_TX_PHY_CTRL_BASE;
+
 	/* get register address based on the logical port */
 	temp = PORT_CTRL_ADDR(addr, (addr_base + (reg << 2)));
 
diff --git a/drivers/net/dsa/microchip/lan937x_reg.h b/drivers/net/dsa/microchip/lan937x_reg.h
index 45b606b6429f6..7ecada9240233 100644
--- a/drivers/net/dsa/microchip/lan937x_reg.h
+++ b/drivers/net/dsa/microchip/lan937x_reg.h
@@ -147,6 +147,7 @@
 
 /* 1 - Phy */
 #define REG_PORT_T1_PHY_CTRL_BASE	0x0100
+#define REG_PORT_TX_PHY_CTRL_BASE	0x0280
 
 /* 3 - xMII */
 #define PORT_SGMII_SEL			BIT(7)
-- 
2.39.2


