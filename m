Return-Path: <netdev+bounces-187687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B46FAA8E79
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 10:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 568D77AA028
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46FB1F4607;
	Mon,  5 May 2025 08:43:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D91F7910
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746434635; cv=none; b=ASARUdbWRyllMYP+IGvojD6EQo32mDHq1VXNwK8r264Z7J4WV4Ss3yPJ7Ho9vQTtoH/jYheHiNJGlMdhl78nMWctFI1yoqM+n7S3lNOTAhxqidFDEDxdoleQrahOROyCSDKnNbCwVaf4bkUMWrc5rHLUpkwNDlrCPWxlhJKj8gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746434635; c=relaxed/simple;
	bh=Ym/VO1lsf4cxLe2zwu26BSqCE0/7Tphe1tRXLpCeV9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDSM8ZXyNwZfgB06btBUmjVsTCVumBjZy1lhcPzf8Fpi+E29Ex2o9/+VcAwrlMeE/i5JB1jFm52PEdw+quYADbVHifpSf0oTKzGM9p9ZEWurOQ+tG/64fr62NhnM7n5YsvcZZtX9cGpI3Bfp/Nu/JluLMBRHZdmDJsEQA+FKVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uBrQN-0005WC-Ak; Mon, 05 May 2025 10:43:43 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uBrQM-001CSK-1d;
	Mon, 05 May 2025 10:43:42 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uBrQM-003SQk-1H;
	Mon, 05 May 2025 10:43:42 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v8 7/7] net: usb: lan78xx: Extract flow control configuration to helper
Date: Mon,  5 May 2025 10:43:41 +0200
Message-Id: <20250505084341.824165-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505084341.824165-1-o.rempel@pengutronix.de>
References: <20250505084341.824165-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Move flow control register configuration from
lan78xx_update_flowcontrol() into a new helper function
lan78xx_configure_flowcontrol(). This separates hardware-specific
programming from policy logic and simplifies the upcoming phylink
integration.

The values used in this initial version of
lan78xx_configure_flowcontrol() are taken over as-is from the original
implementation to avoid functional changes. While they may not be
optimal for all USB and link speed combinations, they are known to work
reliably. Optimization of pause time and thresholds based on runtime
conditions can be done in a separate follow-up patch.

The forward declaration of lan78xx_configure_flowcontrol() will also be
removed later during the phylink conversion.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v6:
- this patch is added in v6
---
 drivers/net/usb/lan78xx.c | 105 +++++++++++++++++++++++++++++++-------
 1 file changed, 87 insertions(+), 18 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index bff53324c70a..58e3589e3b89 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1554,10 +1554,12 @@ static void lan78xx_set_multicast(struct net_device *netdev)
 	schedule_work(&pdata->set_multicast);
 }
 
+static int lan78xx_configure_flowcontrol(struct lan78xx_net *dev,
+					 bool tx_pause, bool rx_pause);
+
 static int lan78xx_update_flowcontrol(struct lan78xx_net *dev, u8 duplex,
 				      u16 lcladv, u16 rmtadv)
 {
-	u32 flow = 0, fct_flow = 0;
 	u8 cap;
 
 	if (dev->fc_autoneg)
@@ -1565,27 +1567,13 @@ static int lan78xx_update_flowcontrol(struct lan78xx_net *dev, u8 duplex,
 	else
 		cap = dev->fc_request_control;
 
-	if (cap & FLOW_CTRL_TX)
-		flow |= (FLOW_CR_TX_FCEN_ | 0xFFFF);
-
-	if (cap & FLOW_CTRL_RX)
-		flow |= FLOW_CR_RX_FCEN_;
-
-	if (dev->udev->speed == USB_SPEED_SUPER)
-		fct_flow = FLOW_CTRL_THRESHOLD(FLOW_ON_SS, FLOW_OFF_SS);
-	else if (dev->udev->speed == USB_SPEED_HIGH)
-		fct_flow = FLOW_CTRL_THRESHOLD(FLOW_ON_HS, FLOW_OFF_HS);
-
 	netif_dbg(dev, link, dev->net, "rx pause %s, tx pause %s",
 		  (cap & FLOW_CTRL_RX ? "enabled" : "disabled"),
 		  (cap & FLOW_CTRL_TX ? "enabled" : "disabled"));
 
-	lan78xx_write_reg(dev, FCT_FLOW, fct_flow);
-
-	/* threshold value should be set before enabling flow */
-	lan78xx_write_reg(dev, FLOW, flow);
-
-	return 0;
+	return lan78xx_configure_flowcontrol(dev,
+					     cap & FLOW_CTRL_TX,
+					     cap & FLOW_CTRL_RX);
 }
 
 static void lan78xx_rx_urb_submit_all(struct lan78xx_net *dev);
@@ -2550,6 +2538,87 @@ static int lan78xx_configure_usb(struct lan78xx_net *dev, int speed)
 	}
 }
 
+/**
+ * lan78xx_configure_flowcontrol - Set MAC and FIFO flow control configuration
+ * @dev: pointer to the LAN78xx device structure
+ * @tx_pause: enable transmission of pause frames
+ * @rx_pause: enable reception of pause frames
+ *
+ * This function configures the LAN78xx flow control settings by writing
+ * to the FLOW and FCT_FLOW registers. The pause time is set to the
+ * maximum allowed value (65535 quanta). FIFO thresholds are selected
+ * based on USB speed.
+ *
+ * The Pause Time field is measured in units of 512-bit times (quanta):
+ *   - At 1 Gbps: 1 quanta = 512 ns → max ~33.6 ms pause
+ *   - At 100 Mbps: 1 quanta = 5.12 µs → max ~335 ms pause
+ *   - At 10 Mbps: 1 quanta = 51.2 µs → max ~3.3 s pause
+ *
+ * Flow control thresholds (FCT_FLOW) are used to trigger pause/resume:
+ *   - RXUSED is the number of bytes used in the RX FIFO
+ *   - Flow is turned ON when RXUSED ≥ FLOW_ON threshold
+ *   - Flow is turned OFF when RXUSED ≤ FLOW_OFF threshold
+ *   - Both thresholds are encoded in units of 512 bytes (rounded up)
+ *
+ * Thresholds differ by USB speed because available USB bandwidth
+ * affects how fast packets can be drained from the RX FIFO:
+ *   - USB 3.x (SuperSpeed):
+ *       FLOW_ON  = 9216 bytes → 18 units
+ *       FLOW_OFF = 4096 bytes →  8 units
+ *   - USB 2.0 (High-Speed):
+ *       FLOW_ON  = 8704 bytes → 17 units
+ *       FLOW_OFF = 1024 bytes →  2 units
+ *
+ * Note: The FCT_FLOW register must be configured before enabling TX pause
+ *       (i.e., before setting FLOW_CR_TX_FCEN_), as required by the hardware.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+static int lan78xx_configure_flowcontrol(struct lan78xx_net *dev,
+					 bool tx_pause, bool rx_pause)
+{
+	/* Use maximum pause time: 65535 quanta (512-bit times) */
+	const u32 pause_time_quanta = 65535;
+	u32 fct_flow = 0;
+	u32 flow = 0;
+	int ret;
+
+	/* Prepare MAC flow control bits */
+	if (tx_pause)
+		flow |= FLOW_CR_TX_FCEN_ | pause_time_quanta;
+
+	if (rx_pause)
+		flow |= FLOW_CR_RX_FCEN_;
+
+	/* Select RX FIFO thresholds based on USB speed
+	 *
+	 * FCT_FLOW layout:
+	 *   bits [6:0]   FLOW_ON threshold (RXUSED ≥ ON → assert pause)
+	 *   bits [14:8]  FLOW_OFF threshold (RXUSED ≤ OFF → deassert pause)
+	 *   thresholds are expressed in units of 512 bytes
+	 */
+	switch (dev->udev->speed) {
+	case USB_SPEED_SUPER:
+		fct_flow = FLOW_CTRL_THRESHOLD(FLOW_ON_SS, FLOW_OFF_SS);
+		break;
+	case USB_SPEED_HIGH:
+		fct_flow = FLOW_CTRL_THRESHOLD(FLOW_ON_HS, FLOW_OFF_HS);
+		break;
+	default:
+		netdev_warn(dev->net, "Unsupported USB speed: %d\n",
+			    dev->udev->speed);
+		return -EINVAL;
+	}
+
+	/* Step 1: Write FIFO thresholds before enabling pause frames */
+	ret = lan78xx_write_reg(dev, FCT_FLOW, fct_flow);
+	if (ret < 0)
+		return ret;
+
+	/* Step 2: Enable MAC pause functionality */
+	return lan78xx_write_reg(dev, FLOW, flow);
+}
+
 /**
  * lan78xx_register_fixed_phy() - Register a fallback fixed PHY
  * @dev: LAN78xx device
-- 
2.39.5


