Return-Path: <netdev+bounces-31674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1047D78F7B2
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 06:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E467281756
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 04:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E6C1C3E;
	Fri,  1 Sep 2023 04:53:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81F31386
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 04:53:46 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEA9E7E
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 21:53:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qbw9w-0006Kk-Pq; Fri, 01 Sep 2023 06:53:28 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qbw9t-0034i8-Hc; Fri, 01 Sep 2023 06:53:25 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1qbw9t-00GOeB-0W;
	Fri, 01 Sep 2023 06:53:25 +0200
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
Subject: [PATCH net v2 1/1] net: phy: micrel: Correct bit assignments for phy_device flags
Date: Fri,  1 Sep 2023 06:53:23 +0200
Message-Id: <20230901045323.3907976-1-o.rempel@pengutronix.de>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Previously, the defines for phy_device flags in the Micrel driver were
ambiguous in their representation. They were intended to be bit masks
but were mistakenly defined as bit positions. This led to the following
issues:

- MICREL_KSZ8_P1_ERRATA, designated for KSZ88xx switches, overlapped
  with MICREL_PHY_FXEN and MICREL_PHY_50MHZ_CLK.
- Due to this overlap, the code path for MICREL_PHY_FXEN, tailored for
  the KSZ8041 PHY, was not executed for KSZ88xx PHYs.
- Similarly, the code associated with MICREL_PHY_50MHZ_CLK wasn't
  triggered for KSZ88xx.

To rectify this, all three flags have now been explicitly converted to
use the `BIT()` macro, ensuring they are defined as bit masks and
preventing potential overlaps in the future.

Fixes: 49011e0c1555 ("net: phy: micrel: ksz886x/ksz8081: add cabletest support")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/micrel_phy.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index 8bef1ab62bba3..322d872559847 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -41,9 +41,9 @@
 #define	PHY_ID_KSZ9477		0x00221631
 
 /* struct phy_device dev_flags definitions */
-#define MICREL_PHY_50MHZ_CLK	0x00000001
-#define MICREL_PHY_FXEN		0x00000002
-#define MICREL_KSZ8_P1_ERRATA	0x00000003
+#define MICREL_PHY_50MHZ_CLK	BIT(0)
+#define MICREL_PHY_FXEN		BIT(1)
+#define MICREL_KSZ8_P1_ERRATA	BIT(2)
 
 #define MICREL_KSZ9021_EXTREG_CTRL	0xB
 #define MICREL_KSZ9021_EXTREG_DATA_WRITE	0xC
-- 
2.39.2


