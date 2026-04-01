Return-Path: <netdev+bounces-274019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PCRDAHwzGknYAYAu9opvQ
	(envelope-from <netdev+bounces-274019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:14:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A6A3784F4
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 903C13143895
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 10:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155153E0226;
	Wed,  1 Apr 2026 10:05:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345EB3E0C62;
	Wed,  1 Apr 2026 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775037932; cv=none; b=Hx1+PNMwDTkAqOitunr7HDg89TkQxmSEnYmCBCLacrqqfLMyfnh1scBUz5hTe3g0wugRdTuUmHd8e9TIZA1NyexMQWTZsXPm9MhDMa65GFDI73hzKZAlCW9ro7XVI/y3E2v2kcP7JxRVC2EBNN2iiVzL4hCNvL0ZXi9TsU5RH4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775037932; c=relaxed/simple;
	bh=YZII44Pk2rd1g/3LXFFbfOjGq5Ch+DkEZlId3X+L1jA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=an4vE/nO/qvysxeFTHVVg7LnSCYeID93O9IEgaPz9g0UtxSDqPwaSdEMaX0BI/6dlZKSvN0Jg/j337m3bYoIj/M38iNMG5urXIsI2AL+bjDg6UsGQbVgnv0pE2LHIY4pkTbYaydOBUCisw+A6z0jlwgrBnPUXg0XtkFhAU0i5mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [116.25.95.185])
	by smtp.qiye.163.com (Hmail) with ESMTP id 39254490f;
	Wed, 1 Apr 2026 18:00:17 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: "David S . Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] net: phy: realtek: Add support for PHY LEDs on RTL8221B
Date: Wed,  1 Apr 2026 18:00:10 +0800
Message-Id: <20260401100010.3079700-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d487c957703a2kunm0e662280517586
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQxgZVh1OGBpKSh9JSksaHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSk1VSU5VQk5VSkNOWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[jmu.edu.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274019-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,redhat.com,kernel.org,google.com,armlinux.org.uk,makrotopia.org,gmail.com,vger.kernel.org,jmu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[amadeus@jmu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jmu.edu.cn:email,jmu.edu.cn:mid]
X-Rspamd-Queue-Id: C9A6A3784F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Realtek RTL8221B Ethernet PHY supports three LED pins which are used to
indicate link status and activity. Add netdev trigger support for them.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 drivers/net/phy/realtek/realtek_main.c | 146 +++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 023e47ad605b..8a22e18e5c56 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -150,6 +150,15 @@
 
 #define RTL8221B_VND2_INSR			0xa4d4
 
+#define RTL822X_VND2_LED(x)			(0xd032 + ((x) * 2))
+#define RTL822X_VND2_LCR_LINK_10		BIT(0)
+#define RTL822X_VND2_LCR_LINK_100		BIT(1)
+#define RTL822X_VND2_LCR_LINK_1000		BIT(2)
+#define RTL822X_VND2_LCR_LINK_2500		BIT(5)
+
+#define RTL822X_VND2_LCR6			0xd040
+#define RTL822X_VND2_LED_ACT(x)			BIT(x)
+
 #define RTL8224_MII_RTCT			0x11
 #define RTL8224_MII_RTCT_ENABLE			BIT(0)
 #define RTL8224_MII_RTCT_PAIR_A			BIT(4)
@@ -1661,6 +1670,135 @@ static int rtl822xb_c45_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl822xb_led_brightness_set(struct phy_device *phydev, u8 index,
+				       enum led_brightness value)
+{
+	int ret;
+
+	if (index >= RTL8211x_LED_COUNT)
+		return -EINVAL;
+
+	/* clear HW LED setup */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+			    RTL822X_VND2_LED(index), 0);
+	if (ret < 0)
+		return ret;
+
+	/* clear HW LED blink */
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
+				  RTL822X_VND2_LCR6,
+				  RTL822X_VND2_LED_ACT(index));
+}
+
+static int rtl822xb_led_hw_is_supported(struct phy_device *phydev, u8 index,
+					unsigned long rules)
+{
+	const unsigned long  act_mask = BIT(TRIGGER_NETDEV_RX) |
+					BIT(TRIGGER_NETDEV_TX);
+
+	const unsigned long link_mask = BIT(TRIGGER_NETDEV_LINK) |
+					BIT(TRIGGER_NETDEV_LINK_10) |
+					BIT(TRIGGER_NETDEV_LINK_100) |
+					BIT(TRIGGER_NETDEV_LINK_1000) |
+					BIT(TRIGGER_NETDEV_LINK_2500);
+
+	if (index >= RTL8211x_LED_COUNT)
+		return -EINVAL;
+
+	/* Filter out any other unsupported triggers. */
+	if (rules & ~(link_mask | act_mask))
+		return -EOPNOTSUPP;
+
+	/* RX and TX are not differentiated, they are not possible
+	 * without combination with a link trigger.
+	 */
+	if ((rules & act_mask) && !(rules & link_mask))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int rtl822xb_led_hw_control_get(struct phy_device *phydev, u8 index,
+				       unsigned long *rules)
+{
+	int val;
+
+	if (index >= RTL8211x_LED_COUNT)
+		return -EINVAL;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LED(index));
+	if (val < 0)
+		return val;
+
+	if (val & RTL822X_VND2_LCR_LINK_10)
+		__set_bit(TRIGGER_NETDEV_LINK_10, rules);
+
+	if (val & RTL822X_VND2_LCR_LINK_100)
+		__set_bit(TRIGGER_NETDEV_LINK_100, rules);
+
+	if (val & RTL822X_VND2_LCR_LINK_1000)
+		__set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+
+	if (val & RTL822X_VND2_LCR_LINK_2500)
+		__set_bit(TRIGGER_NETDEV_LINK_2500, rules);
+
+	if ((val & RTL822X_VND2_LCR_LINK_10) &&
+	    (val & RTL822X_VND2_LCR_LINK_100) &&
+	    (val & RTL822X_VND2_LCR_LINK_1000) &&
+	    (val & RTL822X_VND2_LCR_LINK_2500))
+		__set_bit(TRIGGER_NETDEV_LINK, rules);
+
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LCR6);
+	if (val < 0)
+		return val;
+
+	if (val & RTL822X_VND2_LED_ACT(index)) {
+		__set_bit(TRIGGER_NETDEV_RX, rules);
+		__set_bit(TRIGGER_NETDEV_TX, rules);
+	}
+
+	return 0;
+}
+
+static int rtl822xb_led_hw_control_set(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	u16 val = 0;
+	bool act;
+	int ret;
+
+	if (index >= RTL8211x_LED_COUNT)
+		return -EINVAL;
+
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_10, &rules))
+		val |= RTL822X_VND2_LCR_LINK_10;
+
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_100, &rules))
+		val |= RTL822X_VND2_LCR_LINK_100;
+
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
+		val |= RTL822X_VND2_LCR_LINK_1000;
+
+	if (test_bit(TRIGGER_NETDEV_LINK, &rules) ||
+	    test_bit(TRIGGER_NETDEV_LINK_2500, &rules))
+		val |= RTL822X_VND2_LCR_LINK_2500;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+			    RTL822X_VND2_LED(index), val);
+	if (ret < 0)
+		return ret;
+
+	act = test_bit(TRIGGER_NETDEV_RX, &rules) ||
+	      test_bit(TRIGGER_NETDEV_TX, &rules);
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LCR6,
+			      RTL822X_VND2_LED_ACT(index), act ?
+			      RTL822X_VND2_LED_ACT(index) : 0);
+}
+
 static int rtl8224_cable_test_start(struct phy_device *phydev)
 {
 	u32 val;
@@ -2427,6 +2565,10 @@ static struct phy_driver realtek_drvs[] = {
 		.write_page	= rtl821x_write_page,
 		.read_mmd	= rtl822xb_read_mmd,
 		.write_mmd	= rtl822xb_write_mmd,
+		.led_brightness_set = rtl822xb_led_brightness_set,
+		.led_hw_is_supported = rtl822xb_led_hw_is_supported,
+		.led_hw_control_get = rtl822xb_led_hw_control_get,
+		.led_hw_control_set = rtl822xb_led_hw_control_set,
 	}, {
 		.match_phy_device = rtl8221b_vm_cg_match_phy_device,
 		.name		= "RTL8221B-VM-CG 2.5Gbps PHY",
@@ -2446,6 +2588,10 @@ static struct phy_driver realtek_drvs[] = {
 		.write_page	= rtl821x_write_page,
 		.read_mmd	= rtl822xb_read_mmd,
 		.write_mmd	= rtl822xb_write_mmd,
+		.led_brightness_set = rtl822xb_led_brightness_set,
+		.led_hw_is_supported = rtl822xb_led_hw_is_supported,
+		.led_hw_control_get = rtl822xb_led_hw_control_get,
+		.led_hw_control_set = rtl822xb_led_hw_control_set,
 	}, {
 		.match_phy_device = rtl8251b_c45_match_phy_device,
 		.name		= "RTL8251B 5Gbps PHY",
-- 
2.34.1


