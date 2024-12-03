Return-Path: <netdev+bounces-148380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3407B9E1408
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5FEFB236FC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D181E0E09;
	Tue,  3 Dec 2024 07:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B56E1DF976
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210533; cv=none; b=l30FpT2AblmJaxFmalEZrAuRQeLEgpBcv8Lj+WoY0FUNYatvIQC/yfwpM2EavzNxV38uCXcbwBa4Z2273K8iVZl+DV3ntbnHNpysuTTEB+kgWuhbhACWFiNkj+uaVmj2oB0csrMsIqc3T7HY4KSiptrFPXiNERmkLeSodBw/Pj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210533; c=relaxed/simple;
	bh=FzGdrnbxt2WjTA897Dgy/DCsuUgxXjt7QzpJZwcGPSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tIf4/b7YYcU1UI9WM74vwym6SRbl8xw3Ll/uwFlMqaY+pmScP+VlJFwyImnx0pqH/ZA+1DZX+lDw6sm9Ye/SxqZNgCrWS5OugWo93oY7J2RFFIdq4C+6js69oK2mLakBy8RxMwskhQK8abSDPaRwsuMuEnF4w6Phr1yy988JWF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEL-0004s3-6F; Tue, 03 Dec 2024 08:21:57 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-001Qyw-0N;
	Tue, 03 Dec 2024 08:21:55 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-00AEnZ-2Z;
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
Subject: [PATCH net-next v1 07/21] net: usb: lan78xx: Add error handling to lan78xx_init_ltm
Date: Tue,  3 Dec 2024 08:21:40 +0100
Message-Id: <20241203072154.2440034-8-o.rempel@pengutronix.de>
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

Convert `lan78xx_init_ltm` to return error codes and handle errors
properly.  Previously, errors during the LTM initialization process were
not propagated, potentially leading to undetected issues. This patch
ensures:

- Errors in `lan78xx_read_reg` and `lan78xx_write_reg` are checked and
  handled.
- Errors are logged with detailed messages using `%pe` for clarity.
- The function exits immediately on error, returning the error code.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
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


