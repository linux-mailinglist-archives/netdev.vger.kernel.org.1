Return-Path: <netdev+bounces-227012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5ECBA6E02
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 11:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520821898D9C
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 09:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7362D8383;
	Sun, 28 Sep 2025 09:41:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27997298CA4
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759052480; cv=none; b=BVj/fbTlD4982uBYFY1JDGOyZ/rPlcw7BB+R7gpDi1nNXuTMp1jMv8XpZkEKBtkquMgt6dkHBUSOcd37XcUHC571WTVsDu9hgI1ahSwzJOQnw/WTZPslEbeRNBj4NcuAnjFd+Uk1bxCmL7XkWtmvjR0CxNIX0+spp8cbaFjLHKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759052480; c=relaxed/simple;
	bh=F757+4oZetXObBRm+rOjXJW873ZbZU8DI21Mx/4vTDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dWKsA3U5OWwHSm5x79mqL01Kk2b0v2I4J1gvBMlQFSh7WX1sBxWp/ySAkEzin//PyrZZSBITdmKTkH4YMAgyJt+zpljt9VfdNCJ7x/P24EvFvjEPyVUxbzXEmfnV542dEg9dtl6Um2HMVL00px5vXOw18WwEcrvLD2Rx/cBBPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1759052375t81f4bace
X-QQ-Originating-IP: 0Afv/VXnDj9dXCef1Wl2mMU4GLrsc3b9/df8lOdmd2o=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 28 Sep 2025 17:39:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 922774199149405414
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
Subject: [PATCH net-next 2/3] net: txgbe: optimize the flow to setup PHY for AML devices
Date: Sun, 28 Sep 2025 17:39:22 +0800
Message-Id: <20250928093923.30456-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250928093923.30456-1-jiawenwu@trustnetic.com>
References: <20250928093923.30456-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nw9C1WBu09hPrsWKhf+6FARvU+13FG4Wnt4GKXEx0qMPmZlMz6jU9AUQ
	XUuj1uD6r2aRI3mG+wzFH2GmyjVx/Yis4ioLK/DrzURQ35H6U+BtAsd5L3U+5lynmV0oGMT
	R/51JKwuyj0u35MSKeiN4DCsD+jQr5+S5mmABsrY2Bo5uu+nvB0uOlL4wCHlzBsQLAscG6f
	Xh/SdgpB3rJc2iZm7QIAtPeIra10eC1Ng3w4Yu5aHxdJbtkxghsh3z9yWLNXA5e3+NWrFru
	Ucsqh2lD8BF8a0+/uj8exb+oYu5MveNAqT2Q4YmmPyMDsws6BSdul6tY7Rjkhk1ER4a1WXe
	AXVeF/AKqio5VYPQq08KCkSYyYbolsCsVq+QqiLkcSULQI8K7LyLdR9lpaT8/D8kHRC6Mlg
	5aMxMeyifKxEInXsO90hKGVdDObQxSmnNg0wXiB1EfksstUb43JFRecxpHmK1W0cxeSTz1h
	311pWt6dyajWo7eiqSJEBi1ZegrYEp7Knb7UNGdYRwysUF7w6yz8z5PX3rEa6ZRCQozCAoD
	YOMOO/6v7AJ2skz9HJOx+zHwU35ePBEBCcRhYLpGYg+eTLvKRUZhM3iK/9wwxmCxaphGH3+
	Bl4yLkZQeZ51vZ/nsmLU39kx4Q5IZbBbs3XxFx2WnB1mAi/93iMIyESfK1Stx361yZcoTt0
	MSwMnawXVeBEnWR/cjOqW90m3E0pdvH4v9/XEAPRpMbEDZhEHVHWuF8ppetrX5tEl3GPVPr
	GLULBBSYSQoBezuqc2qnGT4iXmimLCQqBvlRL0iJhgg5u/OsvcNWyhFK1RcVmqzW++TxyoO
	waqh+D+wGGETnZ+UfygmZRoCoV9sr8eHTCOQdVu416OX/6AQ1XqFF9pcvA+PI/U683ZboOp
	osdBILp0A9z6e86RGb0oslx5P5eePdRncpBajfdjrQks5UEdoj3+/zVjDASoMaywwpO7vJx
	nmkm5inCqQkk6CdsH5WHMEtPHkFV/x/H6M9MPWs3stiNBeRKwE8Rt3rYGX1Jqvrz8F+bdSf
	rCBQlHik1jDnUtkovrDIcHgUudEvt+S57pbJCLOwoo68dgG6B1
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

To adapt to new firmware for AML devices, the driver should send the
"SET_LINK_CMD" to the firmware only once when switching PHY interface
mode. And the unknown link speed is permitted in the mailbox buffer. The
firmware will configure the PHY completely when the conditions are met.

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


