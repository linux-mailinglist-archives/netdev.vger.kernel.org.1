Return-Path: <netdev+bounces-107248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E42491A6B5
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1098B21920
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AC91684AF;
	Thu, 27 Jun 2024 12:39:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A90C160795
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719491977; cv=none; b=RBZBgIHCslXh3DEL2HJLKwqtjjqTyJUyKkV6pttoA4gCFoQ8xz1RCz7WcizyXJm1S7bLpNbgZEIccGHQRw6qZ+o8cw7LgTih0uUrbH8D0n8sjWYMFpWO2X6FgBL5PWZEnaQSna+8W9A0PRDPcgYh6mlzteOjOFuLkRcGw4w3c9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719491977; c=relaxed/simple;
	bh=EqB6SmNdeXubFO++XFjnHXgMkng6+TrWjBXTPnVGYUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTgrkdTPoy5Myr2dr8ZhkQqvvu52Tjuyh4JqJmQB5MLP4msZj8pGb8FnnpvDYq/gq5dSi2chAkgW/ntkidtDvM11MC7T04rUHjttCfWHU1nYF6pcGRnkOMDQYUhRgiuSZ9AhjSqHe2Rmbc9T7e3fkycJ5XnJrFBIA+RtkOC3pp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sMoPC-00015D-7f; Thu, 27 Jun 2024 14:39:14 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sMoPA-005Mwu-QG; Thu, 27 Jun 2024 14:39:12 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sMoPA-000xBz-2M;
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
Subject: [PATCH net-next v1 3/3] net: dsa: microchip: lan937x: disable VPHY output
Date: Thu, 27 Jun 2024 14:39:11 +0200
Message-Id: <20240627123911.227480-4-o.rempel@pengutronix.de>
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

While the documented VPHY out-of-reset configuration should autonegotiate
the maximum supported link speed on the CPU interface, that doesn't work
on RGMII links, where the VPHY negotiates 100MBit speed. This causes the
RGMII TX interface to run with a wrong clock rate.

Disable the VPHY output altogether, so it doesn't interfere with the
CPU interface configuration set via fixed-link. The VPHY is a compatibility
functionality to be able to attach network drivers without fixed-link
support to the switch, which generally should not be needed with linux
network drivers.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/lan937x_main.c | 3 +++
 drivers/net/dsa/microchip/lan937x_reg.h  | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index b6ef48a655735..9cd3ff38ed66b 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -400,6 +400,9 @@ int lan937x_setup(struct dsa_switch *ds)
 	lan937x_cfg(dev, REG_SW_GLOBAL_OUTPUT_CTRL__1,
 		    (SW_CLK125_ENB | SW_CLK25_ENB), true);
 
+	/* disable VPHY output*/
+	ksz_rmw32(dev, REG_SW_CFG_STRAP_OVR, SW_VPHY_DISABLE, SW_VPHY_DISABLE);
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/microchip/lan937x_reg.h b/drivers/net/dsa/microchip/lan937x_reg.h
index e36bcb155f545..be553e23a964e 100644
--- a/drivers/net/dsa/microchip/lan937x_reg.h
+++ b/drivers/net/dsa/microchip/lan937x_reg.h
@@ -37,6 +37,10 @@
 #define SW_CLK125_ENB			BIT(1)
 #define SW_CLK25_ENB			BIT(0)
 
+/* 2 - PHY Control */
+#define REG_SW_CFG_STRAP_OVR		0x214
+#define SW_VPHY_DISABLE			BIT(31)
+
 /* 3 - Operation Control */
 #define REG_SW_OPERATION		0x0300
 
-- 
2.39.2


