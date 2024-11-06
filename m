Return-Path: <netdev+bounces-142313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40269BE341
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A976528433A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF9E1D54D1;
	Wed,  6 Nov 2024 09:56:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF34C1DB534
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886966; cv=none; b=V4egHQz3aDit5pBAS4EF5VlzfNxrEOd8+gt6/u5E5SoV7ZtECy5jY62Xh1jpk8VU4QBZE3IOuSiqfWqkCD4avgVvkoDUDnQgIij58P6Wg60hk/4yKEK44dWCw4Xf8v0THK5W0DJhIdM+3wvl/hpMC8exL6N7xHZzgBA7FSqqm0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886966; c=relaxed/simple;
	bh=9dwQDhVzhLwWtbWg1gHR+oxrxdmUqKJz2JlkUlMcS6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ffwu6fPI8UAHK9keFNwO/fj1eDUTrpnpx4st5yrND1zRsW1XyUIQOUc2q8UmCAnnH7YBTzCzz56LbBVrlNWXoOAAlRvTiOFUy0njuGjqg36rDfC8Z+pf7SHcUvnY+HxMHqX9P+XR4pe/xzjW9HVNLPstNBLwskj067ZDekXP8TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz2t1730886853tmx0uz0
X-QQ-Originating-IP: PVHHeg6ySFW9GMXm0ZVtjeL5F3taVW64Ez9qO2k7ZPc=
Received: from wxdbg.localdomain.com ( [60.186.23.108])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 06 Nov 2024 17:54:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2965427873250228838
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: txgbe: fix lost GPIO interrupt
Date: Wed,  6 Nov 2024 18:17:17 +0800
Message-Id: <20241106101717.981850-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M+0YV038q5N1AbEcloW9ueVHc9OFxNsCCw30+EW6id2Kl5eq/MBN+u6/
	8uEZrpHYuqDN5pAZe+knJYpoyCCiyIKynHMdDJiLb4i8sOsPVX0qMedsLVJwjBWLNrjfKww
	JvpTC2zaNAefK3c8xoCtuZEEkkWYqrxyqmNtl7jMUpluP1vJVWYxWQ9Igz5CxDr/Hddx3E+
	Oicwb0WoNamY040khv3QSkpaG6l2xMrcPQQrZPG1Cds6cJvCYWLDmvrnN0pUVWLzRUP/PY2
	IJWQxtM3lXnIx71czc5nx73t1IU2bb6Mu762ZvwcEsKW+UM7XR/sSr2c7tv6wpIsSlMFdTn
	AVV3vRxI+UOiAMPjwONirmnmElFDLjR78FfKi5zYAJlDWzw5ReiJ32jfmA0bRKt+xHX7gZX
	ZG7Nri2Sg4guBQ81VhWplzizjpY2RfUQgdgF+wGb4Y5/qJT/hFayI3X9biayDrdaoedRLJz
	dUzpCZFT3zATfEDKEjbJeqSf2v0R6sp1LKJ8ZITJR9/oND3zQMfvFcqgw3IM1FO9x4pSG69
	1rRURPojy0ndKLX4QKVA+uN055oZP0jUSfmFsoMkWJGEU7D9daQqBWwWPd1jWFjW7u35yuQ
	VvIJJkXb2x5M7UwpfBaMy4w2Xzc85/Kx3QYpitbi0EYRdBZbK9rXCuhHpT87WrIYyUDyuDk
	w77JwlEkvMlZMVHJIT+BH4hKAvHM+GbY+3mFxThrcOK5ffyZu87b5XrZ3GRFabnbELmzCDi
	VTat1ww2aOlh+tPDUfcoTDWw1BPpv9JSPK1NJF9NueJWVA9R6W4IeWui7L/pxoFi495ZcRy
	p2CSxHErHV2psh31nraKqKneLN5/zNHoeT20i16NhG9xA9gMtT0bPkTvPH92AHAUJ2dTxKB
	SFlgOtn3No+NY5pvnkbb0Sqywo2YNoCf0thMOVOXhPmKya+26nlW0cTgxZISjfVXguIbWFY
	HhIEZd0yX2Fel0LaAFcS3gnW5AkwVgpgOQwH5ReZ9+wC/TBXLLdTHFIooEqCeUJmQ7lk=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Sometimes when clearing interrupts for workaround in txgbe_up_complete(),
the GPIO interrupt is lost once due to the interrupt polarity is
consistent with the GPIO state. It causes the SFP state cannot be updated
immediately. That is, SFP driver can only get into the correct state if
the GPIO state changes again.

So mannually trigger the GPIO interrupt while clearing it in
txgbe_reinit_gpio_intr(), causing SFP driver to update to the correct
state. And also clear GPIO interrupts in txgbe_down() to ensure that the
interrupt polarity is consistent with the GPIO state.

Fixes: b4a2496c17ed ("net: txgbe: fix GPIO interrupt blocking")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_type.h    |  1 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c |  5 ++++-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c  | 15 ++++++++++-----
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index b54bffda027b..bf4285db605e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1078,6 +1078,7 @@ struct wx {
 	bool wol_hw_supported;
 	bool ncsi_enabled;
 	bool gpio_ctrl;
+	bool gpio_trigger;
 	raw_spinlock_t gpio_lock;
 
 	/* Tx fast path data */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 93180225a6f1..0e6129dcff8f 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -82,7 +82,6 @@ static void txgbe_up_complete(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
-	txgbe_reinit_gpio_intr(wx);
 	wx_control_hw(wx, true);
 	wx_configure_vectors(wx);
 
@@ -97,6 +96,9 @@ static void txgbe_up_complete(struct wx *wx)
 	rd32(wx, WX_PX_IC(1));
 	rd32(wx, WX_PX_MISC_IC);
 	txgbe_irq_enable(wx, true);
+	wx->gpio_trigger = true;
+	txgbe_reinit_gpio_intr(wx);
+	wx->gpio_trigger = false;
 
 	/* enable transmits */
 	netif_tx_start_all_queues(netdev);
@@ -169,6 +171,7 @@ void txgbe_down(struct wx *wx)
 	txgbe_disable_device(wx);
 	txgbe_reset(wx);
 	phylink_stop(wx->phylink);
+	txgbe_reinit_gpio_intr(wx);
 
 	wx_clean_all_tx_rings(wx);
 	wx_clean_all_rx_rings(wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 67b61afdde96..361dcb362d42 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -401,17 +401,21 @@ static void txgbe_gpio_irq_unmask(struct irq_data *d)
 static void txgbe_toggle_trigger(struct gpio_chip *gc, unsigned int offset)
 {
 	struct wx *wx = gpiochip_get_data(gc);
-	u32 pol, val;
+	u32 pol_r, pol_w, val;
 
-	pol = rd32(wx, WX_GPIO_POLARITY);
+	pol_r = rd32(wx, WX_GPIO_POLARITY);
 	val = rd32(wx, WX_GPIO_EXT);
 
 	if (val & BIT(offset))
-		pol &= ~BIT(offset);
+		pol_w = pol_r & ~BIT(offset);
 	else
-		pol |= BIT(offset);
+		pol_w = pol_r | BIT(offset);
 
-	wr32(wx, WX_GPIO_POLARITY, pol);
+	wr32(wx, WX_GPIO_POLARITY, pol_w);
+
+	/* manually trigger the lost inpterrupt */
+	if (wx->gpio_trigger)
+		wr32(wx, WX_GPIO_POLARITY, pol_r);
 }
 
 static int txgbe_gpio_set_type(struct irq_data *d, unsigned int type)
@@ -560,6 +564,7 @@ static int txgbe_gpio_init(struct txgbe *txgbe)
 		return ret;
 
 	txgbe->gpio = gc;
+	wx->gpio_trigger = false;
 
 	return 0;
 }
-- 
2.27.0


