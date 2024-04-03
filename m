Return-Path: <netdev+bounces-84581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2527A8977B6
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5614B1C26891
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B1015099B;
	Wed,  3 Apr 2024 18:02:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C6152E15
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167364; cv=none; b=ZG86IPy8QmDTEogipiesrJ7UDOtRBgjAK5k2H8lHVnBldBAHn7tfUQxTBGKJyLx5OTkti0llfD6h+6BNYbMKgPBNoI8WDaZ0Wqslj0WhLpKhc2VgzblzXD9IU1xy2BnIENkArTZghqmiuiv1Jx/67PThSbcevWnLBAb6kF5/TFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167364; c=relaxed/simple;
	bh=ki4OM5Ry8mnfZfDN11pHYbJpj6KSQ2knegsHZMB+fZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oNt9meO3WWma6jV7zCTX5Ph1z3/aB1YBnsenTqPOXwnSzhxTNgpNqVCCiTyGoRC1GCATBxjhPU/P8eKm0PiTTbctRHTJigvg6Tv3iezdGpgCzug6irMgv3ECFDDkvlg+EtGb+K1l724ETw7IKHReBdqR8ubaM79X8LMlAwbkyYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rs4wO-0008GC-W9; Wed, 03 Apr 2024 20:02:29 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rs4wN-00AE7z-53; Wed, 03 Apr 2024 20:02:27 +0200
From: Lucas Stach <l.stach@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: [PATCH 2/3] net: dsa: microchip: lan937x: force RGMII interface into PHY mode
Date: Wed,  3 Apr 2024 20:02:25 +0200
Message-Id: <20240403180226.1641383-2-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403180226.1641383-1-l.stach@pengutronix.de>
References: <20240403180226.1641383-1-l.stach@pengutronix.de>
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

The register manual and datasheet documentation for the LAN937x series
disagree about the polarity of the MII mode strap. As a consequence
there are hardware designs that have the RGMII interface strapped into
MAC mode, which is a invalid configuration and will prevent the internal
clock from being fed into the port TX interface.

Force the MII mode to PHY for RGMII interfaces where this is the only
valid mode, to override the inproper strapping.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/net/dsa/microchip/lan937x_main.c | 11 +++++++++++
 drivers/net/dsa/microchip/lan937x_reg.h  |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 6a20cbacc513..04fa74c7dcbe 100644
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
index 7ecada924023..e36bcb155f54 100644
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


