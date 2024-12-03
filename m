Return-Path: <netdev+bounces-148371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6EF9E13FD
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A32282CA8
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859211E04A8;
	Tue,  3 Dec 2024 07:22:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCC91DDA2E
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210531; cv=none; b=VYEJEx9O3dqiK+O5wJnIZlf7kitAzwh1x3iyv8t7Bv9ESQxU64HZTRaVLkLXIcPCU3bJOOkqU9KxPwvBtWiz+Lk332n3WJ+po8fvL16ICztKk0SXO+D8AdURF9IxEZ0KT1PC37rPd8dlOIUrRB3s3PH6vmaG5Xw8hFvcM4t9eF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210531; c=relaxed/simple;
	bh=P4ge/6PEWfqnTNawhj3D9KXCyfIY5lweWQAy8PBgJl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tYqa9cSQyO9mFibUe+Hmy8xVnWUV1BxTd6JLoLlytKmFj/Uia9xOCNU/wEw7ckUujxJZtIZ5FaeQORMzF6fiAXa0X9hdKQEpfgc7Yxa4IrSFsSS/pn3kEz3FoxVyEoRTHN0L0H/wvTzAFLBCIY0wP3aV6y3djWdG7VDbsZt8tGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEL-0004rz-6E; Tue, 03 Dec 2024 08:21:57 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-001Qym-03;
	Tue, 03 Dec 2024 08:21:55 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-00AEmu-2K;
	Tue, 03 Dec 2024 08:21:55 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v1 03/21] net: usb: lan78xx: move functions to avoid forward definitions
Date: Tue,  3 Dec 2024 08:21:36 +0100
Message-Id: <20241203072154.2440034-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241203072154.2440034-1-o.rempel@pengutronix.de>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
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

Move following functions to avoid forward declarations in the code:
- lan78xx_start_hw()
- lan78xx_stop_hw()
- lan78xx_flush_fifo()
- lan78xx_start_tx_path()
- lan78xx_stop_tx_path()
- lan78xx_flush_tx_fifo()
- lan78xx_start_rx_path()
- lan78xx_stop_rx_path()
- lan78xx_flush_rx_fifo()

These functions will be used in an upcoming PHYlink migration patch.

No modifications to the functionality of the code are made.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 300 +++++++++++++++++++-------------------
 1 file changed, 150 insertions(+), 150 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 918b88bd9524..dd9b5d3abcb3 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -808,6 +808,156 @@ static void lan78xx_update_stats(struct lan78xx_net *dev)
 	usb_autopm_put_interface(dev->intf);
 }
 
+static int lan78xx_start_hw(struct lan78xx_net *dev, u32 reg, u32 hw_enable)
+{
+	return lan78xx_update_reg(dev, reg, hw_enable, hw_enable);
+}
+
+static int lan78xx_stop_hw(struct lan78xx_net *dev, u32 reg, u32 hw_enabled,
+			   u32 hw_disabled)
+{
+	unsigned long timeout;
+	bool stopped = true;
+	int ret;
+	u32 buf;
+
+	/* Stop the h/w block (if not already stopped) */
+
+	ret = lan78xx_read_reg(dev, reg, &buf);
+	if (ret < 0)
+		return ret;
+
+	if (buf & hw_enabled) {
+		buf &= ~hw_enabled;
+
+		ret = lan78xx_write_reg(dev, reg, buf);
+		if (ret < 0)
+			return ret;
+
+		stopped = false;
+		timeout = jiffies + HW_DISABLE_TIMEOUT;
+		do  {
+			ret = lan78xx_read_reg(dev, reg, &buf);
+			if (ret < 0)
+				return ret;
+
+			if (buf & hw_disabled)
+				stopped = true;
+			else
+				msleep(HW_DISABLE_DELAY_MS);
+		} while (!stopped && !time_after(jiffies, timeout));
+	}
+
+	ret = stopped ? 0 : -ETIME;
+
+	return ret;
+}
+
+static int lan78xx_flush_fifo(struct lan78xx_net *dev, u32 reg, u32 fifo_flush)
+{
+	return lan78xx_update_reg(dev, reg, fifo_flush, fifo_flush);
+}
+
+static int lan78xx_start_tx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "start tx path");
+
+	/* Start the MAC transmitter */
+
+	ret = lan78xx_start_hw(dev, MAC_TX, MAC_TX_TXEN_);
+	if (ret < 0)
+		return ret;
+
+	/* Start the Tx FIFO */
+
+	ret = lan78xx_start_hw(dev, FCT_TX_CTL, FCT_TX_CTL_EN_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int lan78xx_stop_tx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "stop tx path");
+
+	/* Stop the Tx FIFO */
+
+	ret = lan78xx_stop_hw(dev, FCT_TX_CTL, FCT_TX_CTL_EN_, FCT_TX_CTL_DIS_);
+	if (ret < 0)
+		return ret;
+
+	/* Stop the MAC transmitter */
+
+	ret = lan78xx_stop_hw(dev, MAC_TX, MAC_TX_TXEN_, MAC_TX_TXD_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/* The caller must ensure the Tx path is stopped before calling
+ * lan78xx_flush_tx_fifo().
+ */
+static int lan78xx_flush_tx_fifo(struct lan78xx_net *dev)
+{
+	return lan78xx_flush_fifo(dev, FCT_TX_CTL, FCT_TX_CTL_RST_);
+}
+
+static int lan78xx_start_rx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "start rx path");
+
+	/* Start the Rx FIFO */
+
+	ret = lan78xx_start_hw(dev, FCT_RX_CTL, FCT_RX_CTL_EN_);
+	if (ret < 0)
+		return ret;
+
+	/* Start the MAC receiver*/
+
+	ret = lan78xx_start_hw(dev, MAC_RX, MAC_RX_RXEN_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int lan78xx_stop_rx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "stop rx path");
+
+	/* Stop the MAC receiver */
+
+	ret = lan78xx_stop_hw(dev, MAC_RX, MAC_RX_RXEN_, MAC_RX_RXD_);
+	if (ret < 0)
+		return ret;
+
+	/* Stop the Rx FIFO */
+
+	ret = lan78xx_stop_hw(dev, FCT_RX_CTL, FCT_RX_CTL_EN_, FCT_RX_CTL_DIS_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/* The caller must ensure the Rx path is stopped before calling
+ * lan78xx_flush_rx_fifo().
+ */
+static int lan78xx_flush_rx_fifo(struct lan78xx_net *dev)
+{
+	return lan78xx_flush_fifo(dev, FCT_RX_CTL, FCT_RX_CTL_RST_);
+}
+
 /* Loop until the read is completed with timeout called with phy_mutex held */
 static int lan78xx_phy_wait_not_busy(struct lan78xx_net *dev)
 {
@@ -2662,156 +2812,6 @@ static int lan78xx_urb_config_init(struct lan78xx_net *dev)
 	return result;
 }
 
-static int lan78xx_start_hw(struct lan78xx_net *dev, u32 reg, u32 hw_enable)
-{
-	return lan78xx_update_reg(dev, reg, hw_enable, hw_enable);
-}
-
-static int lan78xx_stop_hw(struct lan78xx_net *dev, u32 reg, u32 hw_enabled,
-			   u32 hw_disabled)
-{
-	unsigned long timeout;
-	bool stopped = true;
-	int ret;
-	u32 buf;
-
-	/* Stop the h/w block (if not already stopped) */
-
-	ret = lan78xx_read_reg(dev, reg, &buf);
-	if (ret < 0)
-		return ret;
-
-	if (buf & hw_enabled) {
-		buf &= ~hw_enabled;
-
-		ret = lan78xx_write_reg(dev, reg, buf);
-		if (ret < 0)
-			return ret;
-
-		stopped = false;
-		timeout = jiffies + HW_DISABLE_TIMEOUT;
-		do  {
-			ret = lan78xx_read_reg(dev, reg, &buf);
-			if (ret < 0)
-				return ret;
-
-			if (buf & hw_disabled)
-				stopped = true;
-			else
-				msleep(HW_DISABLE_DELAY_MS);
-		} while (!stopped && !time_after(jiffies, timeout));
-	}
-
-	ret = stopped ? 0 : -ETIME;
-
-	return ret;
-}
-
-static int lan78xx_flush_fifo(struct lan78xx_net *dev, u32 reg, u32 fifo_flush)
-{
-	return lan78xx_update_reg(dev, reg, fifo_flush, fifo_flush);
-}
-
-static int lan78xx_start_tx_path(struct lan78xx_net *dev)
-{
-	int ret;
-
-	netif_dbg(dev, drv, dev->net, "start tx path");
-
-	/* Start the MAC transmitter */
-
-	ret = lan78xx_start_hw(dev, MAC_TX, MAC_TX_TXEN_);
-	if (ret < 0)
-		return ret;
-
-	/* Start the Tx FIFO */
-
-	ret = lan78xx_start_hw(dev, FCT_TX_CTL, FCT_TX_CTL_EN_);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static int lan78xx_stop_tx_path(struct lan78xx_net *dev)
-{
-	int ret;
-
-	netif_dbg(dev, drv, dev->net, "stop tx path");
-
-	/* Stop the Tx FIFO */
-
-	ret = lan78xx_stop_hw(dev, FCT_TX_CTL, FCT_TX_CTL_EN_, FCT_TX_CTL_DIS_);
-	if (ret < 0)
-		return ret;
-
-	/* Stop the MAC transmitter */
-
-	ret = lan78xx_stop_hw(dev, MAC_TX, MAC_TX_TXEN_, MAC_TX_TXD_);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-/* The caller must ensure the Tx path is stopped before calling
- * lan78xx_flush_tx_fifo().
- */
-static int lan78xx_flush_tx_fifo(struct lan78xx_net *dev)
-{
-	return lan78xx_flush_fifo(dev, FCT_TX_CTL, FCT_TX_CTL_RST_);
-}
-
-static int lan78xx_start_rx_path(struct lan78xx_net *dev)
-{
-	int ret;
-
-	netif_dbg(dev, drv, dev->net, "start rx path");
-
-	/* Start the Rx FIFO */
-
-	ret = lan78xx_start_hw(dev, FCT_RX_CTL, FCT_RX_CTL_EN_);
-	if (ret < 0)
-		return ret;
-
-	/* Start the MAC receiver*/
-
-	ret = lan78xx_start_hw(dev, MAC_RX, MAC_RX_RXEN_);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static int lan78xx_stop_rx_path(struct lan78xx_net *dev)
-{
-	int ret;
-
-	netif_dbg(dev, drv, dev->net, "stop rx path");
-
-	/* Stop the MAC receiver */
-
-	ret = lan78xx_stop_hw(dev, MAC_RX, MAC_RX_RXEN_, MAC_RX_RXD_);
-	if (ret < 0)
-		return ret;
-
-	/* Stop the Rx FIFO */
-
-	ret = lan78xx_stop_hw(dev, FCT_RX_CTL, FCT_RX_CTL_EN_, FCT_RX_CTL_DIS_);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-/* The caller must ensure the Rx path is stopped before calling
- * lan78xx_flush_rx_fifo().
- */
-static int lan78xx_flush_rx_fifo(struct lan78xx_net *dev)
-{
-	return lan78xx_flush_fifo(dev, FCT_RX_CTL, FCT_RX_CTL_RST_);
-}
-
 static int lan78xx_reset(struct lan78xx_net *dev)
 {
 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
-- 
2.39.5


