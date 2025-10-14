Return-Path: <netdev+bounces-229053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC398BD78DA
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AE204E2246
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 06:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5B61D5174;
	Tue, 14 Oct 2025 06:19:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB2319D07E
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760422780; cv=none; b=lsTVHfWQuVVDtDMdX5/PdeNM5RuWMDT/DQHoIVzFkslxdcegmpaLU8hYD7nUvkEdkbhS5DZuI0vglII6SbQ+p26ZnvHuD8Cm+TCfdUMB3zSefrnurS42dpfu5usF9qEMguNlB8VdRyq/NcqAvPbqycyK7snvs/UxCT+zbFbqL8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760422780; c=relaxed/simple;
	bh=vYWZLVFtaTvUMdSHtPPg78i0V8pncCazs2BGZ3DUpQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=syZK3HhlFC7fcK4ucCtcAo6X5rhkzGW634ZWY0k8vJkcyrJptjmcwF5nDlKeffwAPgWTBJKecfBTyGOC8qXVaihLM5eCvL841eUeu5SL1dgHe97M/eCOKslKDtFkMidtHdkfj3+JiOTGnkwJ3CxBwaQQhXtibKD70NJqUBMr9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz16t1760422658tbdaefcfe
X-QQ-Originating-IP: l6nnBj6RmBDF9k8w/iSDF6ne3Ibvwlc62RyyklyumkM=
Received: from lap-jiawenwu.trustnetic.com ( [36.27.111.193])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Oct 2025 14:17:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11586084674247115606
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 2/3] net: txgbe: optimize the flow to setup PHY for AML devices
Date: Tue, 14 Oct 2025 14:17:25 +0800
Message-Id: <20251014061726.36660-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251014061726.36660-1-jiawenwu@trustnetic.com>
References: <20251014061726.36660-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NYlggeZuI0UGCfvxwBDeMC/G7iM9QaIgQm3wBi/RZyFyF9C6TOAu2ZCi
	HM2+HquqeZMOs1dr+RBLwoRsceRslMxjdqWBtfGMmYvWZmvqxIPaYn4qsRKE172oTOciKCM
	5qT+XjYtdk6RhuUqm4onjNRGckdLg8gh+k2RjuD0QIFu8PtA/Sbof4yajj0xxodqX70XDnF
	+ISmgXTZNUdveDcVOyVq8UPNl56UQwTEh/e/0CNs2vAbBloMczydJBHjrcdLL7x4iPpYHvH
	ikD68zYgY4JQITo0HKVOAa+CwRnCGBSi2puYndz5ykmQafNYOxd5Wv+nT+o+nRiHwUjoD4y
	HscNsovinxQ3DwkwLH/ulJLXRjROrXcnk5LAzEgfhQJ+Vu78XvF66J69SeX9Be92GmjBWXZ
	wUYz4OP9BwDFKOCJ6IU/EoFyhjFHfLaCq7cd4l9A+PX3F5Jlx2UBJfcR4v6yyYuMTWjh4i/
	4EOqPaDA7s9QRwKSl9r632kKo8AoOlzHwbwdis9AuUgluNf6C98dc1TcxJUy4ctB2TD+Vgo
	NkVJ/6XSs3iYdeGgEFxxDMjkkNdM8xPvKja81x5PKMmvtzuiiyezVzOd/yPL34YbbEgcrTq
	pE6Bk+VPvBDWRFvLOyBtAQwkJje8X0KeLHinRFyZCWQeMYddUyDEoqC6Q5koVdvhZiwYzh4
	JMmZ9zht5dTcRiyHhOMv9LZKv1oaWv23PtICTSdf6QK5fqZtN2BAgR2f/A8SQm8cke8fVP8
	rQ1ycJGGaCq7nDYvLgEUVGylB5+3XIoaKsLsLELbPUVJXKA+mR4TQEpbWmAcLv+5Or5Z4P+
	cyDdNVdB7CJPFQ20vjLIqbqR4Nos2xBy5BKoABKIdhQRtpqkJCTlLAG3+jWAy9KB57Yt7jy
	rtlf6Yb7xpZoH+nfKJ2+2AFwqYCWLMs1tLBsTpT2puL+wjT7kiZvEhc7pMdshhpLR/dJPgH
	mSsD5J9+Pg1MVTZqC2+bk3WS4cY8Vr+hVPpk4SphNyZZagM6gjHphzQGStJYQ5WTMAhePUh
	ng6FRPaoE1/qiyPo7IMrlsV01FJ+HpKW+Ph8FM2l/dxKr+BAVy
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

To adapt to new firmware for AML devices, the driver should send the
"SET_LINK_CMD" to the firmware only once when switching PHY interface
mode, and no longer needs to re-trigger PHY configuration based on the
RX signal interrupt (TXGBE_GPIOBIT_3).

In previous firmware versions, the PHY was configured only after receiving
"SET_LINK_CMD", and might remain incomplete if the RX signal was lost.
To handle this case, the driver used TXGBE_GPIOBIT_3 interrupt to resend
the command. This workaround is no longer necessary with the new firmware.

And the unknown link speed is permitted in the mailbox buffer.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  2 -
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 50 ++++++-------------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  1 +
 3 files changed, 15 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index d89b9b8a0a2c..4880268b620e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1271,8 +1271,6 @@ struct wx {
 
 	/* PHY stuff */
 	bool notify_down;
-	int adv_speed;
-	int adv_duplex;
 	unsigned int link;
 	int speed;
 	int duplex;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index dc87ccad9652..1da92431c324 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -19,8 +19,8 @@ void txgbe_gpio_init_aml(struct wx *wx)
 {
 	u32 status;
 
-	wr32(wx, WX_GPIO_INTTYPE_LEVEL, TXGBE_GPIOBIT_2 | TXGBE_GPIOBIT_3);
-	wr32(wx, WX_GPIO_INTEN, TXGBE_GPIOBIT_2 | TXGBE_GPIOBIT_3);
+	wr32(wx, WX_GPIO_INTTYPE_LEVEL, TXGBE_GPIOBIT_2);
+	wr32(wx, WX_GPIO_INTEN, TXGBE_GPIOBIT_2);
 
 	status = rd32(wx, WX_GPIO_INTSTATUS);
 	for (int i = 0; i < 6; i++) {
@@ -42,11 +42,6 @@ irqreturn_t txgbe_gpio_irq_handler_aml(int irq, void *data)
 		wr32(wx, WX_GPIO_EOI, TXGBE_GPIOBIT_2);
 		wx_service_event_schedule(wx);
 	}
-	if (status & TXGBE_GPIOBIT_3) {
-		set_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags);
-		wx_service_event_schedule(wx);
-		wr32(wx, WX_GPIO_EOI, TXGBE_GPIOBIT_3);
-	}
 
 	wr32(wx, WX_GPIO_INTMASK, 0);
 	return IRQ_HANDLED;
@@ -96,6 +91,9 @@ static int txgbe_set_phy_link_hostif(struct wx *wx, int speed, int autoneg, int
 	case SPEED_10000:
 		buffer.speed = TXGBE_LINK_SPEED_10GB_FULL;
 		break;
+	default:
+		buffer.speed = TXGBE_LINK_SPEED_UNKNOWN;
+		break;
 	}
 
 	buffer.fec_mode = TXGBE_PHY_FEC_AUTO;
@@ -106,19 +104,18 @@ static int txgbe_set_phy_link_hostif(struct wx *wx, int speed, int autoneg, int
 					 WX_HI_COMMAND_TIMEOUT, true);
 }
 
-static void txgbe_get_link_capabilities(struct wx *wx)
+static void txgbe_get_link_capabilities(struct wx *wx, int *speed, int *duplex)
 {
 	struct txgbe *txgbe = wx->priv;
 
 	if (test_bit(PHY_INTERFACE_MODE_25GBASER, txgbe->sfp_interfaces))
-		wx->adv_speed = SPEED_25000;
+		*speed = SPEED_25000;
 	else if (test_bit(PHY_INTERFACE_MODE_10GBASER, txgbe->sfp_interfaces))
-		wx->adv_speed = SPEED_10000;
+		*speed = SPEED_10000;
 	else
-		wx->adv_speed = SPEED_UNKNOWN;
+		*speed = SPEED_UNKNOWN;
 
-	wx->adv_duplex = wx->adv_speed == SPEED_UNKNOWN ?
-			 DUPLEX_HALF : DUPLEX_FULL;
+	*duplex = *speed == SPEED_UNKNOWN ? DUPLEX_HALF : DUPLEX_FULL;
 }
 
 static void txgbe_get_phy_link(struct wx *wx, int *speed)
@@ -138,23 +135,11 @@ static void txgbe_get_phy_link(struct wx *wx, int *speed)
 
 int txgbe_set_phy_link(struct wx *wx)
 {
-	int speed, err;
-	u32 gpio;
+	int speed, duplex, err;
 
-	/* Check RX signal */
-	gpio = rd32(wx, WX_GPIO_EXT);
-	if (gpio & TXGBE_GPIOBIT_3)
-		return -ENODEV;
+	txgbe_get_link_capabilities(wx, &speed, &duplex);
 
-	txgbe_get_link_capabilities(wx);
-	if (wx->adv_speed == SPEED_UNKNOWN)
-		return -ENODEV;
-
-	txgbe_get_phy_link(wx, &speed);
-	if (speed == wx->adv_speed)
-		return 0;
-
-	err = txgbe_set_phy_link_hostif(wx, wx->adv_speed, 0, wx->adv_duplex);
+	err = txgbe_set_phy_link_hostif(wx, speed, 0, duplex);
 	if (err) {
 		wx_err(wx, "Failed to setup link\n");
 		return err;
@@ -230,14 +215,7 @@ int txgbe_identify_sfp(struct wx *wx)
 		return -ENODEV;
 	}
 
-	err = txgbe_sfp_to_linkmodes(wx, id);
-	if (err)
-		return err;
-
-	if (gpio & TXGBE_GPIOBIT_3)
-		set_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags);
-
-	return 0;
+	return txgbe_sfp_to_linkmodes(wx, id);
 }
 
 void txgbe_setup_link(struct wx *wx)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 9d53c7413f7b..b9a4ba48f5b9 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -314,6 +314,7 @@ void txgbe_up(struct wx *wx);
 int txgbe_setup_tc(struct net_device *dev, u8 tc);
 void txgbe_do_reset(struct net_device *netdev);
 
+#define TXGBE_LINK_SPEED_UNKNOWN        0
 #define TXGBE_LINK_SPEED_10GB_FULL      4
 #define TXGBE_LINK_SPEED_25GB_FULL      0x10
 
-- 
2.48.1


