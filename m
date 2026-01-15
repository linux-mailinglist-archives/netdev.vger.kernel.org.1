Return-Path: <netdev+bounces-250241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CBCD25880
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80E4130277D4
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938A43B9615;
	Thu, 15 Jan 2026 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YMfiwbXA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D383B8D59;
	Thu, 15 Jan 2026 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492648; cv=none; b=bP31cyNP65xiwIGi7K++R/vwbClndnbHLUyAo/L7NPX8OYsU/py0a/cvEFtLBfDIs0FDbzJlIB0WnGXvc0jABCJdlWxJoTJUaw+iXL8iUne6TuBsa4Or1rmmCSeeZXG5uKGzOHydhOa1NB5C7FItylQJORA/C2fGeum44MfJUIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492648; c=relaxed/simple;
	bh=OhYI2KdicGdGUg/NnQR2lrdCXn34OMEy3pxkWLWFFWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cjsl+OLbDSJpAyvy4vD6A3sg//NDOwMtGKV7k7mc9wP2kZBkD9etInm0lsFE7mWwYiEslrYG6Dsb3wlVMDYgAslmQ7UADrOsPIhdDQxINj/tmhLeHVZugTox0fRDx5yOIdVzifZsptNGgLcd1bFQDDpdQ2sqDbwcLikXrOWy5TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YMfiwbXA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 50CBC4E420FE;
	Thu, 15 Jan 2026 15:57:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 264DE606E0;
	Thu, 15 Jan 2026 15:57:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7F7210B686A5;
	Thu, 15 Jan 2026 16:57:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768492644; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4X0KcHvR9X7nPzv6dU0ffRLNZMZZ/tWN7eRurvhEQ28=;
	b=YMfiwbXAK709/B8n5vE2HkR4RBkQGHD233/ZKQGGsg8mpE2sxG/2N0tfcu69NBJZajNqwT
	S9smXg0+sszG4os2QW9Ay5qQh9m2ag5q5ZZ8ef4eLfVEnsZE9d3Sov7+S/g7RUE8tVwULD
	4lVgFB+ceKMrzLB6+aqRSQ3djI6DlLPl0jjGZcZ2Hi4XCI0f4GHuaNpqazGyYdKPWDUdAJ
	c4H8wPNWkpzP/+hZS9wgwrjGCjKpyEGG3hLVhBXgI1JViEUgFRArD5qYJAnu/5Ka9HhqHO
	zXREqIAOk7hWcB42A7TvRwkIueNnBKQOyB3c7Pl4umj1jtUFsvzRp8oc9QK1aQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 15 Jan 2026 16:57:07 +0100
Subject: [PATCH net-next 8/8] net: dsa: microchip: Add two-step PTP support
 for KSZ8463
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-ksz8463-ptp-v1-8-bcfe2830cf50@bootlin.com>
References: <20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com>
In-Reply-To: <20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The KSZ8463 switch supports PTP but it's not supported by driver.

Add L2 two-step PTP support for the KSZ8463. IPv4 and IPv6 layers aren't
supported. Neither is one-step PTP.

The pdelay_req and pdelay_resp timestamps share one interrupt bit status.
So introduce last_tx_is_pdelayresp to keep track of the last sent event
type. Use it to retrieve the relevant timestamp when the interrupt is
caught.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c        | 15 ++--------
 drivers/net/dsa/microchip/ksz8_reg.h    |  1 +
 drivers/net/dsa/microchip/ksz_common.c  |  1 +
 drivers/net/dsa/microchip/ksz_common.h  |  1 +
 drivers/net/dsa/microchip/ksz_ptp.c     | 52 ++++++++++++++++++++++++++-------
 drivers/net/dsa/microchip/ksz_ptp_reg.h |  4 +++
 6 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index a05527899b8bab6d53509ba38c58101b79e98ee5..cec76965def71320abeb77f550f37af7dcb96d63 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -143,9 +143,9 @@ int ksz8_reset_switch(struct ksz_device *dev)
 			KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, false);
 	} else if (ksz_is_ksz8463(dev)) {
 		ksz_cfg(dev, KSZ8463_REG_SW_RESET,
-			KSZ8463_GLOBAL_SOFTWARE_RESET, true);
+			KSZ8463_GLOBAL_SOFTWARE_RESET | KSZ8463_PTP_SOFTWARE_RESET, true);
 		ksz_cfg(dev, KSZ8463_REG_SW_RESET,
-			KSZ8463_GLOBAL_SOFTWARE_RESET, false);
+			KSZ8463_GLOBAL_SOFTWARE_RESET | KSZ8463_PTP_SOFTWARE_RESET, false);
 	} else {
 		/* reset switch */
 		ksz_write8(dev, REG_POWER_MANAGEMENT_1,
@@ -1762,17 +1762,6 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 					   KSZ8463_REG_DSP_CTRL_6,
 					   COPPER_RECEIVE_ADJUSTMENT, 0);
 		}
-
-		/* Turn off PTP function as the switch's proprietary way of
-		 * handling timestamp is not supported in current Linux PTP
-		 * stack implementation.
-		 */
-		regmap_update_bits(ksz_regmap_16(dev),
-				   KSZ8463_PTP_MSG_CONF1,
-				   PTP_ENABLE, 0);
-		regmap_update_bits(ksz_regmap_16(dev),
-				   KSZ8463_PTP_CLK_CTRL,
-				   PTP_CLK_ENABLE, 0);
 	}
 }
 
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 332408567b473c141c3695328a524f257f2cfc70..0558740ae57738fa7e4a8f3f429254033c54af12 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -765,6 +765,7 @@
 #define KSZ8463_REG_SW_RESET		0x126
 
 #define KSZ8463_GLOBAL_SOFTWARE_RESET	BIT(0)
+#define KSZ8463_PTP_SOFTWARE_RESET	BIT(2)
 
 #define KSZ8463_PTP_CLK_CTRL		0x600
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 5141343d2f40bbd380c0b52f6919b842fb71a8fd..55e3fa4791078cb099e236e6e5a29515727ed8ab 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1512,6 +1512,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_mii = {false, false, true},
 		.supports_rmii = {false, false, true},
 		.internal_phy = {true, true, false},
+		.ptp_capable = true,
 	},
 
 	[KSZ8563] = {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index dfbc3d13daca8d7a8b9d3ffe6a7c1ec9927863f2..1fface82086eed87749d4702b046fcab313663e9 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -150,6 +150,7 @@ struct ksz_port {
 	struct kernel_hwtstamp_config tstamp_config;
 	bool hwts_tx_en;
 	bool hwts_rx_en;
+	bool last_tx_is_pdelayresp;
 	struct ksz_irq ptpirq;
 	struct ksz_ptp_irq ptpmsg_irq[3];
 	ktime_t tstamp_msg;
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index fcc2a7d50909c4e6a8cf87a3013c3c311c1714b0..dc77c83dc049f16f76e3138708f5cbd70ad70367 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -308,15 +308,20 @@ int ksz_get_ts_info(struct dsa_switch *ds, int port, struct kernel_ethtool_ts_in
 			      SOF_TIMESTAMPING_RX_HARDWARE |
 			      SOF_TIMESTAMPING_RAW_HARDWARE;
 
-	ts->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ONESTEP_P2P);
+	ts->tx_types = BIT(HWTSTAMP_TX_OFF);
 
-	if (is_lan937x(dev))
+	if (!ksz_is_ksz8463(dev))
+		ts->tx_types |= BIT(HWTSTAMP_TX_ONESTEP_P2P);
+
+	if (is_lan937x(dev) || ksz_is_ksz8463(dev))
 		ts->tx_types |= BIT(HWTSTAMP_TX_ON);
 
 	ts->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
-			 BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
-			 BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
-			 BIT(HWTSTAMP_FILTER_PTP_V2_EVENT);
+			 BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT);
+	if (!ksz_is_ksz8463(dev)) {
+		ts->rx_filters |= BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
+				  BIT(HWTSTAMP_FILTER_PTP_V2_EVENT);
+	}
 
 	ts->phc_index = ptp_clock_index(ptp_data->clock);
 
@@ -353,6 +358,9 @@ static int ksz_set_hwtstamp_config(struct ksz_device *dev,
 		prt->hwts_tx_en = false;
 		break;
 	case HWTSTAMP_TX_ONESTEP_P2P:
+		if (ksz_is_ksz8463(dev))
+			return -ERANGE;
+
 		prt->ptpmsg_irq[KSZ_SYNC_MSG].ts_en  = false;
 		prt->ptpmsg_irq[KSZ_XDREQ_MSG].ts_en = true;
 		prt->ptpmsg_irq[KSZ_PDRES_MSG].ts_en = false;
@@ -364,14 +372,19 @@ static int ksz_set_hwtstamp_config(struct ksz_device *dev,
 
 		break;
 	case HWTSTAMP_TX_ON:
-		if (!is_lan937x(dev))
+		if (!is_lan937x(dev) && !ksz_is_ksz8463(dev))
 			return -ERANGE;
 
-		prt->ptpmsg_irq[KSZ_SYNC_MSG].ts_en  = true;
-		prt->ptpmsg_irq[KSZ_XDREQ_MSG].ts_en = true;
-		prt->ptpmsg_irq[KSZ_PDRES_MSG].ts_en = true;
-		prt->hwts_tx_en = true;
+		if (ksz_is_ksz8463(dev)) {
+			prt->ptpmsg_irq[KSZ8463_SYNC_MSG].ts_en  = true;
+			prt->ptpmsg_irq[KSZ8463_XDREQ_PDRES_MSG].ts_en = true;
+		} else {
+			prt->ptpmsg_irq[KSZ_SYNC_MSG].ts_en  = true;
+			prt->ptpmsg_irq[KSZ_XDREQ_MSG].ts_en = true;
+			prt->ptpmsg_irq[KSZ_PDRES_MSG].ts_en = true;
+		}
 
+		prt->hwts_tx_en = true;
 		ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_1STEP, 0);
 		if (ret)
 			return ret;
@@ -387,6 +400,8 @@ static int ksz_set_hwtstamp_config(struct ksz_device *dev,
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+		if (ksz_is_ksz8463(dev))
+			return -ERANGE;
 		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
 		prt->hwts_rx_en = true;
 		break;
@@ -397,6 +412,8 @@ static int ksz_set_hwtstamp_config(struct ksz_device *dev,
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+		if (ksz_is_ksz8463(dev))
+			return -ERANGE;
 		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 		prt->hwts_rx_en = true;
 		break;
@@ -518,6 +535,8 @@ void ksz_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 	if (!hdr)
 		return;
 
+	prt->last_tx_is_pdelayresp = false;
+
 	ptp_msg_type = ptp_get_msgtype(hdr, type);
 
 	switch (ptp_msg_type) {
@@ -528,6 +547,7 @@ void ksz_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 	case PTP_MSGTYPE_PDELAY_REQ:
 		break;
 	case PTP_MSGTYPE_PDELAY_RESP:
+		prt->last_tx_is_pdelayresp = true;
 		if (prt->tstamp_config.tx_type == HWTSTAMP_TX_ONESTEP_P2P) {
 			KSZ_SKB_CB(skb)->ptp_type = type;
 			KSZ_SKB_CB(skb)->update_correction = true;
@@ -972,7 +992,17 @@ void ksz_ptp_clock_unregister(struct dsa_switch *ds)
 
 static int ksz_read_ts(struct ksz_port *port, u16 reg, u32 *ts)
 {
-	return ksz_read32(port->ksz_dev, reg, ts);
+	u16 ts_reg = reg;
+
+	/**
+	 * On KSZ8463 DREQ and DRESP timestamps share one interrupt line
+	 * so we have to check the nature of the latest event sent to know
+	 * where the timestamp is located
+	 */
+	if (ksz_is_ksz8463(port->ksz_dev) && port->last_tx_is_pdelayresp)
+		ts_reg += KSZ8463_DRESP_TS_OFFSET;
+
+	return ksz_read32(port->ksz_dev, ts_reg, ts);
 }
 
 static irqreturn_t ksz_ptp_msg_thread_fn(int irq, void *dev_id)
diff --git a/drivers/net/dsa/microchip/ksz_ptp_reg.h b/drivers/net/dsa/microchip/ksz_ptp_reg.h
index e80fb4bd1a0e970ba3570374d3dc82c8e2cc15b4..ac9d0f2b348b0469abbeed0e645fe8ef441d35fb 100644
--- a/drivers/net/dsa/microchip/ksz_ptp_reg.h
+++ b/drivers/net/dsa/microchip/ksz_ptp_reg.h
@@ -125,6 +125,10 @@
 #define KSZ8463_REG_PORT_SYNC_TS	0x064C
 #define KSZ8463_REG_PORT_DRESP_TS	0x0650
 
+#define KSZ8463_DRESP_TS_OFFSET		(KSZ8463_REG_PORT_DRESP_TS - KSZ8463_REG_PORT_DREQ_TS)
+#define KSZ8463_SYNC_MSG		0
+#define KSZ8463_XDREQ_PDRES_MSG		1
+
 #define REG_PTP_PORT_TX_INT_STATUS__2	0x0C14
 #define REG_PTP_PORT_TX_INT_ENABLE__2	0x0C16
 

-- 
2.52.0


