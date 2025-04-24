Return-Path: <netdev+bounces-185557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6BAA9AE39
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167EE1B65F2E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F427C141;
	Thu, 24 Apr 2025 13:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5138DEC
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499762; cv=none; b=PDWm9JMPzoh7HSiLVGXZjwbG244tCfsfPMpaAVgc6fO0G62zo1MrD71to1h/uhdbjwwe4YejKiR5MXj9EOoHZPELPnbKodbp1W0/ooG6YdSSKe0EM+m6lY2XZnZz1QmJc51r6HWUXFBMx/5RBEhRg5ccidHutd07h809B7kmY8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499762; c=relaxed/simple;
	bh=Jn3Ztb7pyp9z98OVAPvWb6Sa7v7xVBuTtm9M+cuLT5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=McE2VlBx8jCr9+lSg5uvc5b11s8dzGpzxk4iXqK29sNtBq6w1SoE9SIkLiUGhmiWOtFOWa9AdgNA3+neMGoeYwH84xYeG+U1YvdzDXCuBDq3WqC5Sa/SV4kBUpk78w78hGLGtDztcOQUboScwbwuD+InSvUJkxWgCOlg46ZLlOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u7wDh-0002ZX-3v; Thu, 24 Apr 2025 15:02:25 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u7wDf-001swH-23;
	Thu, 24 Apr 2025 15:02:23 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u7wDf-00Gc4u-1f;
	Thu, 24 Apr 2025 15:02:23 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v1 2/4] net: dsa: microchip: Remove set_mac_eee() callback from KSZ driver
Date: Thu, 24 Apr 2025 15:02:20 +0200
Message-Id: <20250424130222.3959457-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424130222.3959457-1-o.rempel@pengutronix.de>
References: <20250424130222.3959457-1-o.rempel@pengutronix.de>
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

KSZ switches manage EEE internally without any documented MAC-specific
configuration. The existing set_mac_eee() handler only rejected attempts
to disable LPI while keeping EEE on, or to change the Tx LPI timer, offering
no real control.

This now prevents users from disabling EEE when desired. Even if it worked
in the initial implementation, it has since bitrotted and no longer functions
as expected. Since support_eee() is implemented and EEE is handled via
PHY negotiation, drop the set_mac_eee() callback entirely.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_common.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b45052497f8a..e5924ad65658 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3489,24 +3489,6 @@ static bool ksz_support_eee(struct dsa_switch *ds, int port)
 	return false;
 }
 
-static int ksz_set_mac_eee(struct dsa_switch *ds, int port,
-			   struct ethtool_keee *e)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (!e->tx_lpi_enabled) {
-		dev_err(dev->dev, "Disabling EEE Tx LPI is not supported\n");
-		return -EINVAL;
-	}
-
-	if (e->tx_lpi_timer) {
-		dev_err(dev->dev, "Setting EEE Tx LPI timer is not supported\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static void ksz_set_xmii(struct ksz_device *dev, int port,
 			 phy_interface_t interface)
 {
@@ -4749,7 +4731,6 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.cls_flower_del		= ksz_cls_flower_del,
 	.port_setup_tc		= ksz_setup_tc,
 	.support_eee		= ksz_support_eee,
-	.set_mac_eee		= ksz_set_mac_eee,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
 	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
-- 
2.39.5


