Return-Path: <netdev+bounces-19830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEBE75C88D
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0C428203C
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980601E52E;
	Fri, 21 Jul 2023 13:55:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE551E511
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:55:52 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C960B30DF
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:55:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qMqb3-0005Rt-W0; Fri, 21 Jul 2023 15:55:06 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qMqb1-00150e-Ii; Fri, 21 Jul 2023 15:55:03 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1qMqb0-0068zi-29;
	Fri, 21 Jul 2023 15:55:02 +0200
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
Subject: [PATCH net-next v2 6/6] net: dsa: microchip: ksz9477: make switch MAC address configurable
Date: Fri, 21 Jul 2023 15:55:01 +0200
Message-Id: <20230721135501.1464455-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721135501.1464455-1-o.rempel@pengutronix.de>
References: <20230721135501.1464455-1-o.rempel@pengutronix.de>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The switch MAC address is used for sending pause frames and for Wake on Magic
Packet. So, make use of local-mac-address property in the switch node
root and configure it in the HW.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz9477.c    | 8 ++++++++
 drivers/net/dsa/microchip/ksz_common.c | 7 +++++++
 drivers/net/dsa/microchip/ksz_common.h | 2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 69909241b1f44..427176c1441f7 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1211,6 +1211,14 @@ int ksz9477_setup(struct dsa_switch *ds)
 	if (dev->wakeup_source)
 		ksz_write8(dev, REG_SW_PME_CTRL, PME_ENABLE);
 
+	if (is_valid_ether_addr(dev->mac_addr)) {
+		int i;
+
+		for (i = 0; i < ETH_ALEN; i++)
+			ksz_write8(dev, REG_SW_MAC_ADDR_0 + i,
+				   dev->mac_addr[i]);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index a7b298838932c..4de2456b5a349 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3684,6 +3684,8 @@ int ksz_switch_register(struct ksz_device *dev)
 	for (port_num = 0; port_num < dev->info->port_cnt; ++port_num)
 		dev->ports[port_num].interface = PHY_INTERFACE_MODE_NA;
 	if (dev->dev->of_node) {
+		const u8 *mac;
+
 		ret = of_get_phy_mode(dev->dev->of_node, &interface);
 		if (ret == 0)
 			dev->compat_interface = interface;
@@ -3718,6 +3720,11 @@ int ksz_switch_register(struct ksz_device *dev)
 
 		dev->wakeup_source = of_property_read_bool(dev->dev->of_node,
 							   "wakeup-source");
+
+		mac = of_get_property(dev->dev->of_node, "local-mac-address",
+				      NULL);
+		if (mac)
+			memcpy(dev->mac_addr, mac, ETH_ALEN);
 	}
 
 	ret = dsa_register_switch(dev->ds);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 589f8b582a415..bdfcd1dc02ee9 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -171,6 +171,8 @@ struct ksz_device {
 	struct mutex lock_irq;		/* IRQ Access */
 	struct ksz_irq girq;
 	struct ksz_ptp_data ptp_data;
+
+	u8 mac_addr[ETH_ALEN];
 };
 
 /* List of supported models */
-- 
2.39.2


