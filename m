Return-Path: <netdev+bounces-215977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B174B31302
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DA01C26FD2
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468002EDD62;
	Fri, 22 Aug 2025 09:26:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13A2EC561
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854768; cv=none; b=XhdUYCGWhROnvoFeI8bu306S6pTDtZ0FY7i3tA5wqhvPQq4WppxdaOMTAmaao9aiSKpMGYrNu7e/MKoxT7QfUyHzeaT7YiM68KuKf2h0N4/kGlKqANFhgtSjp+ii2oqi9fNF8aKxU92CFwgVgaVVtN9M4iSTfxvntOhd4VfEatw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854768; c=relaxed/simple;
	bh=YaGZ8UzxreJ2bwW0ZV2jA1hQAGuHkwObCV6di1gkDww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ET+XX4KrMvmpm3UTiWT/KwaPiPqY+5pnzMwwhp4qUDFtCkDLxztAMsBBzLerhyb2R0pkTWJ1jcOEeQA7Z7ulD8sfj0/SvhmqVPdmw0kKtHYHdQv4Ba1/EgsVf811tUr3X0bGxRX2uCwLKPrsi+yG/TyCWOwszZJquvfdZA4Xh4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1upO21-00058x-1r; Fri, 22 Aug 2025 11:25:57 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1upO20-001YQ9-1H;
	Fri, 22 Aug 2025 11:25:56 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1upO20-00C7Wz-12;
	Fri, 22 Aug 2025 11:25:56 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v1 1/1] net: usb: lan78xx: add support for generic net selftests via ethtool
Date: Fri, 22 Aug 2025 11:25:55 +0200
Message-Id: <20250822092555.2888870-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

Integrate generic net_selftest framework by wiring up
.get_strings, .get_sset_count, and .self_test ethtool ops.

This enables execution of standard self-tests using
`ethtool -t <dev>` on LAN78xx devices.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/Kconfig   | 1 +
 drivers/net/usb/lan78xx.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 0a678e31cfaa..856e648d804e 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -116,6 +116,7 @@ config USB_LAN78XX
 	select PHYLINK
 	select MICROCHIP_PHY
 	select CRC32
+	imply NET_SELFTESTS
 	help
 	  This option adds support for Microchip LAN78XX based USB 2
 	  & USB 3 10/100/1000 Ethernet adapters.
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 1ff25f57329a..b56e2459ee3c 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -20,6 +20,7 @@
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <net/ip6_checksum.h>
+#include <net/selftests.h>
 #include <net/vxlan.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
@@ -1702,12 +1703,16 @@ static void lan78xx_get_strings(struct net_device *netdev, u32 stringset,
 {
 	if (stringset == ETH_SS_STATS)
 		memcpy(data, lan78xx_gstrings, sizeof(lan78xx_gstrings));
+	else if (stringset == ETH_SS_TEST)
+		net_selftest_get_strings(data);
 }
 
 static int lan78xx_get_sset_count(struct net_device *netdev, int sset)
 {
 	if (sset == ETH_SS_STATS)
 		return ARRAY_SIZE(lan78xx_gstrings);
+	else if (sset == ETH_SS_TEST)
+		return net_selftest_get_count();
 	else
 		return -EOPNOTSUPP;
 }
@@ -1894,6 +1899,7 @@ static const struct ethtool_ops lan78xx_ethtool_ops = {
 	.set_eeprom	= lan78xx_ethtool_set_eeprom,
 	.get_ethtool_stats = lan78xx_get_stats,
 	.get_sset_count = lan78xx_get_sset_count,
+	.self_test	= net_selftest,
 	.get_strings	= lan78xx_get_strings,
 	.get_wol	= lan78xx_get_wol,
 	.set_wol	= lan78xx_set_wol,
-- 
2.39.5


