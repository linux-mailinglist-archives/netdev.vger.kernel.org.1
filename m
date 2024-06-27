Return-Path: <netdev+bounces-107246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2456C91A6B3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2471F268C4
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC64B1662F4;
	Thu, 27 Jun 2024 12:39:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F64D15FD12
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719491976; cv=none; b=hHI0Au2GL9X8DaI1kLJ3uZaB8mCV2T9GSpZ3nBAMQz7XbI14yUok5Qak5u4WTCRvOZ/rqmFTQqof4lEmAh+5Loz92r1V4IW0yifXaFdXOPE6DftQd+SWhWJkuxLwiYhyFjHGmIBwfeF1Zp/5C3HmOzArkxgsv60oSkCaPK/ktpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719491976; c=relaxed/simple;
	bh=hWjrchSW3EtZiipRWjCmXn4R/h3s55wntgS1ZCXFgzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=db8UU60npgoxOLoHwsZ+0GFhsUflmW0J5YQ7N4yWD6FBn9/kmg21RHX0pTYgZ2b9eYimxjwLd3N8LOmRQwbPWh1dzVsP0GzIYtwQskxTXsTMhGEChinQRmLTaPRy47JvZQREiWs3OOWlhbGuBfx63Aa1eF+YLp7LDbMiYpB5Vtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sMoPC-00015C-7g; Thu, 27 Jun 2024 14:39:14 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sMoPA-005Mwt-P6; Thu, 27 Jun 2024 14:39:12 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sMoPA-000xBp-2J;
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
Subject: [PATCH net-next v1 2/3] net: dsa: microchip: lan937x: force RGMII interface into PHY mode
Date: Thu, 27 Jun 2024 14:39:10 +0200
Message-Id: <20240627123911.227480-3-o.rempel@pengutronix.de>
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

The register manual and datasheet documentation for the LAN937x series
disagree about the polarity of the MII mode strap. As a consequence
there are hardware designs that have the RGMII interface strapped into
MAC mode, which is a invalid configuration and will prevent the internal
clock from being fed into the port TX interface.

Force the MII mode to PHY for RGMII interfaces where this is the only
valid mode, to override the inproper strapping.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/lan937x_main.c | 11 +++++++++++
 drivers/net/dsa/microchip/lan937x_reg.h  |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index e907a5602035c..b6ef48a655735 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -217,6 +217,17 @@ void lan937x_config_cpu_port(struct dsa_switch *ds)
 		if (dev->info->cpu_ports & (1 << dp->index)) {
 			dev->cpu_port = dp->index;
 
+			/*
+			 * Force RGMII interface into PHY mode, as that's the
+			 * only valid mode, but it may be in MAC mode due to
+			 * incorrect strapping.
+			 */
+			if (phy_interface_mode_is_rgmii(dev->ports[dp->index].interface)) {
+				lan937x_port_cfg(dev, dp->index,
+						 REG_PORT_XMII_CTRL_1,
+						 PORT_MII_MODE_MAC, false);
+			}
+
 			/* enable cpu port */
 			lan937x_port_setup(dev, dp->index, true);
 		}
diff --git a/drivers/net/dsa/microchip/lan937x_reg.h b/drivers/net/dsa/microchip/lan937x_reg.h
index 7ecada9240233..e36bcb155f545 100644
--- a/drivers/net/dsa/microchip/lan937x_reg.h
+++ b/drivers/net/dsa/microchip/lan937x_reg.h
@@ -150,6 +150,9 @@
 #define REG_PORT_TX_PHY_CTRL_BASE	0x0280
 
 /* 3 - xMII */
+#define REG_PORT_XMII_CTRL_1		0x0301
+#define PORT_MII_MODE_MAC		BIT(2)
+
 #define PORT_SGMII_SEL			BIT(7)
 #define PORT_GRXC_ENABLE		BIT(0)
 
-- 
2.39.2


