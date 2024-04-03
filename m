Return-Path: <netdev+bounces-84582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE118977B7
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B161F27747
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 18:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B875152E18;
	Wed,  3 Apr 2024 18:02:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0688152E11
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167365; cv=none; b=KDanCH5B+o2YCfaPRjKlTdGDcrmaWsS9bwfEO/BrW+BDRXYVvWxFXVwqaMSISXo53v2o/1b8FnDIcZAC1Vb8gY/cKYccDbh5oMtd1Oo2mUydmMOGhnR/OAuVQ1Ekij00gs83/2y7MyuwjJ0Tqti9EiyZUdRzjdgJj8XmY21x7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167365; c=relaxed/simple;
	bh=JdjwYqPhDf6w2ahYMzJ2MHjxXKvZXil2sc27dpJ3Ni8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p14iGhtAPtfMKHWKTBKf9Mg5EFc9nQZI6O6xW04TMJNuB2S7fEUd1E2kWW0TfDVBwpsq5mJ9G0qMDhBcVP86NAMYklZ8V7uNVQy3WWaEfNRmjWR0QNvtDP9MsTubVZfTbhc2liDjNT/4SlOKFDDjW9fCNkCZ4k1cvN5LGGaEnIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rs4wO-0008GA-WA; Wed, 03 Apr 2024 20:02:29 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rs4wN-00AE7z-2M; Wed, 03 Apr 2024 20:02:27 +0200
From: Lucas Stach <l.stach@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: [PATCH 1/3] net: dsa: microchip: lan9372: fix TX PHY access
Date: Wed,  3 Apr 2024 20:02:24 +0200
Message-Id: <20240403180226.1641383-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On the LAN9372 the 4th internal PHY is a TX PHY instead of a T1 PHY.
TX PHYs have a different base register offset.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/net/dsa/microchip/lan937x_main.c | 3 +++
 drivers/net/dsa/microchip/lan937x_reg.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index b479a628b1ae..6a20cbacc513 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -55,6 +55,9 @@ static int lan937x_vphy_ind_addr_wr(struct ksz_device *dev, int addr, int reg)
 	u16 addr_base = REG_PORT_T1_PHY_CTRL_BASE;
 	u16 temp;
 
+	if (dev->info->chip_id == LAN9372_CHIP_ID && addr == 3)
+		addr_base = REG_PORT_TX_PHY_CTRL_BASE;
+
 	/* get register address based on the logical port */
 	temp = PORT_CTRL_ADDR(addr, (addr_base + (reg << 2)));
 
diff --git a/drivers/net/dsa/microchip/lan937x_reg.h b/drivers/net/dsa/microchip/lan937x_reg.h
index 45b606b6429f..7ecada924023 100644
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


