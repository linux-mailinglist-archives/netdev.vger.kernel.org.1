Return-Path: <netdev+bounces-31547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF1578EB54
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBA728100B
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535648F61;
	Thu, 31 Aug 2023 11:04:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657463CC
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 11:04:43 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1C7CF3
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 04:04:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qbfTS-00068H-Qw; Thu, 31 Aug 2023 13:04:30 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qbfTR-002tpE-3Y; Thu, 31 Aug 2023 13:04:29 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1qbfTQ-00EtyY-11;
	Thu, 31 Aug 2023 13:04:28 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH net v1] net: phy: micrel: Correct bit assignment for MICREL_KSZ8_P1_ERRATA flag
Date: Thu, 31 Aug 2023 13:04:27 +0200
Message-Id: <20230831110427.3551432-1-o.rempel@pengutronix.de>
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
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The previous assignment of the phy_device quirk for the
MICREL_KSZ8_P1_ERRATA flag was incorrect, working only due to
coincidental conditions. Specifically:

- The flag MICREL_KSZ8_P1_ERRATA, intended for KSZ88xx switches, was
  mistakenly overlapping with the MICREL_PHY_FXEN and
  MICREL_PHY_50MHZ_CLK flags.
- MICREL_PHY_FXEN is used by the KSZ8041 PHY, and its related code path
  wasn't executed for KSZ88xx PHYs and other way around.
- Additionally, the code path associated with the MICREL_PHY_50MHZ_CLK
  flag wasn't executed for KSZ88xx either.

Fixes: 49011e0c1555d ("net: phy: micrel: ksz886x/ksz8081: add cabletest support")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/micrel_phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index 8bef1ab62bba3..0cedbeb9167c3 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -43,7 +43,7 @@
 /* struct phy_device dev_flags definitions */
 #define MICREL_PHY_50MHZ_CLK	0x00000001
 #define MICREL_PHY_FXEN		0x00000002
-#define MICREL_KSZ8_P1_ERRATA	0x00000003
+#define MICREL_KSZ8_P1_ERRATA	BIT(3)
 
 #define MICREL_KSZ9021_EXTREG_CTRL	0xB
 #define MICREL_KSZ9021_EXTREG_DATA_WRITE	0xC
-- 
2.39.2


