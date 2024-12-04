Return-Path: <netdev+bounces-148900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 769059E35B6
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441A21657DD
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763F51AF0C4;
	Wed,  4 Dec 2024 08:41:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC88E19AA5A
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301718; cv=none; b=SY0JgOfzy4jMIy23S4bnL5N5v54zUPZHePI+cgAY8RCiN9lN1lvT3sgOupvasxT8Hs96S89n+nqX2nc/x6Wwb1iiAgdwcpsNg6C6DbLoBQBlfiXZQjWEcDFeIorwytQF1HSEhOYsJObm5rJDA+OlKnN1+ge+/LLaWNw7BKrXHFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301718; c=relaxed/simple;
	bh=tdkHBcEapTwKYjqUaT8sVvPrVWe64ljbQEL1ykZhKxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fnGFT/wI584TXVV/GHfwk9HOFZwRRQD0Yqg3MB1xKPXmcovDS5YAK4dTlyHTpNmCBfTqNB+2rbysyItd77EOUeDHhjNcwF4FbzaKF0Df7Dw5qm4Zi38Xf4Ok20FpZsyqcemjI4i5U3HGKzS5Y1NQYhUMd+9tTICOSwT6vH9XnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx7-0001I5-46; Wed, 04 Dec 2024 09:41:45 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx5-001cUI-0n;
	Wed, 04 Dec 2024 09:41:44 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx5-004ptf-32;
	Wed, 04 Dec 2024 09:41:43 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v2 07/10] net: usb: lan78xx: Add error handling to lan78xx_init_ltm
Date: Wed,  4 Dec 2024 09:41:39 +0100
Message-Id: <20241204084142.1152696-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204084142.1152696-1-o.rempel@pengutronix.de>
References: <20241204084142.1152696-1-o.rempel@pengutronix.de>
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

Convert `lan78xx_init_ltm` to return error codes and handle errors
properly.  Previously, errors during the LTM initialization process were
not propagated, potentially leading to undetected issues. This patch
ensures:

- Errors in `lan78xx_read_reg` and `lan78xx_write_reg` are checked and
  handled.
- Errors are logged with detailed messages using `%pe` for clarity.
- The function exits immediately on error, returning the error code.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/lan78xx.c | 50 ++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 29f6e1a36e20..33cda7f3dd12 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2807,13 +2807,16 @@ static int lan78xx_vlan_rx_kill_vid(struct net_device *netdev,
 	return 0;
 }
 
-static void lan78xx_init_ltm(struct lan78xx_net *dev)
+static int lan78xx_init_ltm(struct lan78xx_net *dev)
 {
+	u32 regs[6] = { 0 };
 	int ret;
 	u32 buf;
-	u32 regs[6] = { 0 };
 
 	ret = lan78xx_read_reg(dev, USB_CFG1, &buf);
+	if (ret < 0)
+		goto init_ltm_failed;
+
 	if (buf & USB_CFG1_LTM_ENABLE_) {
 		u8 temp[2];
 		/* Get values from EEPROM first */
@@ -2824,7 +2827,7 @@ static void lan78xx_init_ltm(struct lan78xx_net *dev)
 							      24,
 							      (u8 *)regs);
 				if (ret < 0)
-					return;
+					return ret;
 			}
 		} else if (lan78xx_read_otp(dev, 0x3F, 2, temp) == 0) {
 			if (temp[0] == 24) {
@@ -2833,17 +2836,40 @@ static void lan78xx_init_ltm(struct lan78xx_net *dev)
 							   24,
 							   (u8 *)regs);
 				if (ret < 0)
-					return;
+					return ret;
 			}
 		}
 	}
 
-	lan78xx_write_reg(dev, LTM_BELT_IDLE0, regs[0]);
-	lan78xx_write_reg(dev, LTM_BELT_IDLE1, regs[1]);
-	lan78xx_write_reg(dev, LTM_BELT_ACT0, regs[2]);
-	lan78xx_write_reg(dev, LTM_BELT_ACT1, regs[3]);
-	lan78xx_write_reg(dev, LTM_INACTIVE0, regs[4]);
-	lan78xx_write_reg(dev, LTM_INACTIVE1, regs[5]);
+	ret = lan78xx_write_reg(dev, LTM_BELT_IDLE0, regs[0]);
+	if (ret < 0)
+		goto init_ltm_failed;
+
+	ret = lan78xx_write_reg(dev, LTM_BELT_IDLE1, regs[1]);
+	if (ret < 0)
+		goto init_ltm_failed;
+
+	ret = lan78xx_write_reg(dev, LTM_BELT_ACT0, regs[2]);
+	if (ret < 0)
+		goto init_ltm_failed;
+
+	ret = lan78xx_write_reg(dev, LTM_BELT_ACT1, regs[3]);
+	if (ret < 0)
+		goto init_ltm_failed;
+
+	ret = lan78xx_write_reg(dev, LTM_INACTIVE0, regs[4]);
+	if (ret < 0)
+		goto init_ltm_failed;
+
+	ret = lan78xx_write_reg(dev, LTM_INACTIVE1, regs[5]);
+	if (ret < 0)
+		goto init_ltm_failed;
+
+	return 0;
+
+init_ltm_failed:
+	netdev_err(dev->net, "Failed to init LTM with error %pe\n", ERR_PTR(ret));
+	return ret;
 }
 
 static int lan78xx_urb_config_init(struct lan78xx_net *dev)
@@ -2939,7 +2965,9 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		return ret;
 
 	/* Init LTM */
-	lan78xx_init_ltm(dev);
+	ret = lan78xx_init_ltm(dev);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_write_reg(dev, BURST_CAP, dev->burst_cap);
 	if (ret < 0)
-- 
2.39.5


