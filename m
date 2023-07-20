Return-Path: <netdev+bounces-19500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC7975AFAF
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD661C21408
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C1818018;
	Thu, 20 Jul 2023 13:26:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188D61800A
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 13:26:25 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F3C2708
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 06:26:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qMTfL-0007aL-QE; Thu, 20 Jul 2023 15:25:59 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qMTfK-000qcB-AA; Thu, 20 Jul 2023 15:25:58 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1qMTfJ-000EzZ-0y;
	Thu, 20 Jul 2023 15:25:57 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v1 4/6] net: dsa: microchip: ksz9477: add Wake on PHY event support
Date: Thu, 20 Jul 2023 15:25:54 +0200
Message-Id: <20230720132556.57562-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720132556.57562-1-o.rempel@pengutronix.de>
References: <20230720132556.57562-1-o.rempel@pengutronix.de>
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
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

KSZ9477 family of switches supports multiple PHY events:
- wake on Link Up
- wake on Energy Detect.
Since current UAPI can't differentiate between this PHY events, map all of them
to WAKE_PHY.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz9477.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 56c8fb9f0379a..9a531db79f832 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -88,7 +88,7 @@ void ksz9477_get_wol(struct ksz_device *dev, int port,
 	if (!(pme_conf & PME_ENABLE))
 		return;
 
-	wol->supported = WAKE_MAGIC;
+	wol->supported = WAKE_PHY | WAKE_MAGIC;
 
 	ret = ksz_pread8(dev, port, REG_PORT_PME_CTRL, &pme_ctrl);
 	if (ret)
@@ -96,6 +96,8 @@ void ksz9477_get_wol(struct ksz_device *dev, int port,
 
 	if (pme_ctrl & PME_WOL_MAGICPKT)
 		wol->wolopts |= WAKE_MAGIC;
+	if (pme_ctrl & (PME_WOL_LINKUP | PME_WOL_ENERGY))
+		wol->wolopts |= WAKE_PHY;
 }
 
 int ksz9477_set_wol(struct ksz_device *dev, int port,
@@ -104,7 +106,7 @@ int ksz9477_set_wol(struct ksz_device *dev, int port,
 	u8 pme_conf, pme_ctrl = 0;
 	int ret;
 
-	if (wol->wolopts & ~WAKE_MAGIC)
+	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
 		return -EINVAL;
 
 	ret = ksz_read8(dev, REG_SW_PME_CTRL, &pme_conf);
@@ -120,6 +122,8 @@ int ksz9477_set_wol(struct ksz_device *dev, int port,
 
 	if (wol->wolopts & WAKE_MAGIC)
 		pme_ctrl |= PME_WOL_MAGICPKT;
+	if (wol->wolopts & WAKE_PHY)
+		pme_ctrl |= PME_WOL_LINKUP | PME_WOL_ENERGY;
 
 	return ksz_pwrite8(dev, port, REG_PORT_PME_CTRL, pme_ctrl);
 }
-- 
2.39.2


