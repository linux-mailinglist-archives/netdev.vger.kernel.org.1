Return-Path: <netdev+bounces-108772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AA4925589
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8023C1F222C9
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25E713BAD5;
	Wed,  3 Jul 2024 08:38:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE7B13B29D
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995916; cv=none; b=M7uei+aa9tX8mNMyD/sTIj5lYnJZxy1bIKes6da1EuCbdMA+QEJTUZfXIxk6DeMPRgMqli9Av08+niHm6w1pDmRx//e7GVrC7YQBRXf+18NOWSq+tK4ng+ORF64Ih7HCUtonJqPRikpmlwnsMPRYqHV2ROxuJYiG4n8R5hTaecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995916; c=relaxed/simple;
	bh=4niLNORaUtdS1dketsmiqg/K/6iBR51KHyuu0zlNR9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jMGNuggYqt31oN1CgKUiBcDTTa+Z+FC/AaJqg7hzTuZ8UTAt6fKTiJt40cY3R1k90NtG6p4CuiDjr5VerPEDoGQ+En+SS/faDfhydwDUuGw13azg5MvZ33k5Tjx2htvkt35Bti0/xnND0Ko5NIg7k7Ydb7HPr/qWlbbGXknezdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sOvVO-0006sk-QT; Wed, 03 Jul 2024 10:38:22 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sOvVN-006oCm-6M; Wed, 03 Jul 2024 10:38:21 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sOvVN-00DE0d-0P;
	Wed, 03 Jul 2024 10:38:21 +0200
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
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v1 1/1] net: dsa: microchip: lan937x: Add error handling in lan937x_setup
Date: Wed,  3 Jul 2024 10:38:20 +0200
Message-Id: <20240703083820.3152100-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

Introduce error handling for lan937x_cfg function calls in lan937x_setup.
This change ensures that if any lan937x_cfg or ksz_rmw32 calls fails, the
function will return the appropriate error code.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/lan937x_main.c | 27 +++++++++++++++---------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 0606796b14856..83ac33fede3f5 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -374,26 +374,33 @@ int lan937x_setup(struct dsa_switch *ds)
 	ds->vlan_filtering_is_global = true;
 
 	/* Enable aggressive back off for half duplex & UNH mode */
-	lan937x_cfg(dev, REG_SW_MAC_CTRL_0,
-		    (SW_PAUSE_UNH_MODE | SW_NEW_BACKOFF | SW_AGGR_BACKOFF),
-		    true);
+	ret = lan937x_cfg(dev, REG_SW_MAC_CTRL_0, (SW_PAUSE_UNH_MODE |
+						   SW_NEW_BACKOFF |
+						   SW_AGGR_BACKOFF), true);
+	if (ret < 0)
+		return ret;
 
 	/* If NO_EXC_COLLISION_DROP bit is set, the switch will not drop
 	 * packets when 16 or more collisions occur
 	 */
-	lan937x_cfg(dev, REG_SW_MAC_CTRL_1, NO_EXC_COLLISION_DROP, true);
+	ret = lan937x_cfg(dev, REG_SW_MAC_CTRL_1, NO_EXC_COLLISION_DROP, true);
+	if (ret < 0)
+		return ret;
 
 	/* enable global MIB counter freeze function */
-	lan937x_cfg(dev, REG_SW_MAC_CTRL_6, SW_MIB_COUNTER_FREEZE, true);
+	ret = lan937x_cfg(dev, REG_SW_MAC_CTRL_6, SW_MIB_COUNTER_FREEZE, true);
+	if (ret < 0)
+		return ret;
 
 	/* disable CLK125 & CLK25, 1: disable, 0: enable */
-	lan937x_cfg(dev, REG_SW_GLOBAL_OUTPUT_CTRL__1,
-		    (SW_CLK125_ENB | SW_CLK25_ENB), true);
+	ret = lan937x_cfg(dev, REG_SW_GLOBAL_OUTPUT_CTRL__1,
+			  (SW_CLK125_ENB | SW_CLK25_ENB), true);
+	if (ret < 0)
+		return ret;
 
 	/* Disable global VPHY support. Related to CPU interface only? */
-	ksz_rmw32(dev, REG_SW_CFG_STRAP_OVR, SW_VPHY_DISABLE, SW_VPHY_DISABLE);
-
-	return 0;
+	return ksz_rmw32(dev, REG_SW_CFG_STRAP_OVR, SW_VPHY_DISABLE,
+			 SW_VPHY_DISABLE);
 }
 
 void lan937x_teardown(struct dsa_switch *ds)
-- 
2.39.2


