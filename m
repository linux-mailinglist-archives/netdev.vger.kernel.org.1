Return-Path: <netdev+bounces-283147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id F21UBj599GlDBwIAu9opvQ
	(envelope-from <netdev+bounces-283147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 12:15:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 213894AB863
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 12:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E4F300821C
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 10:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E21837EFFE;
	Fri,  1 May 2026 10:15:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D081DE2D8;
	Fri,  1 May 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777630523; cv=none; b=osRTJ+UmjZfOF601JqFarHsW1Kveyh1nfrClcCSqQwrdmU/cEGssbrWo9F1ELATrkIlz86sKGyZbNO9zS9JbhqDQH773l1K4QqFVqwW+DBzp7Za0YLqLZ3ma7oXQkDRdg2AwwWrDfSfp0SdoPRczAWO7CjAPxEtoYNT0WhOCCNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777630523; c=relaxed/simple;
	bh=dl+25Eus40M68Ieerpnxepbae0fwQlJmCdnGm4sytp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vt1CvxdxXAa2Doy2FFO6SL9/qIHYNC/F2PqwV96eM2u7vT8BQi9Es/NcibajsruQqzfj2JNO1WF+x1cmV16tTFUlY79Pe8uT3RrDz6sHK20Cgl3Al6RswJa2W0pPpsJm74zAmyaJXmQMhIqmQO962argvcQrDKPycmz5g1v/a50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from Vostro-3710.. (unknown [119.122.215.211])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3cdf2484d;
	Fri, 1 May 2026 18:10:02 +0800 (GMT+08:00)
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
Subject: [PATCH v3 1/1] net: phy: realtek: Add support for PHY LEDs on RTL8221B
Date: Fri,  1 May 2026 18:00:02 +0800
Message-Id: <20260501100002.755672-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9de3044b0303a2kunm9d72a4a436bf6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQxlCVkJNSUNITBhLSUIaSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVJSkpZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pOTE5VSktLVUpCS0tZBg++
X-Rspamd-Queue-Id: 213894AB863
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.94 / 15.00];
	SEM_URIBL(3.50)[jmu.edu.cn:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[jmu.edu.cn : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,redhat.com,kernel.org,google.com,armlinux.org.uk,makrotopia.org,gmail.com,vger.kernel.org,jmu.edu.cn];
	TAGGED_FROM(0.00)[bounces-283147-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amadeus@jmu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jmu.edu.cn:mid,jmu.edu.cn:email]

Realtek RTL8221B Ethernet PHY supports three LED pins which are used to
indicate link status and activity. Add netdev trigger support for them.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
Changes in v3:
- In led_hw_control_set, reset the LED polarity to default.
- Link to v2: https://lore.kernel.org/all/20260420100800.2435204-1-amadeus@jmu.edu.cn/
Changes in v2:
- Invert the LED polarity in led_brightness_set to achieve LED_ON.
- Link to v1: https://lore.kernel.org/all/20260401100010.3079700-1-amadeus@jmu.edu.cn/
---
 drivers/net/phy/realtek/realtek_main.c | 165 +++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 79c867ef64da..e0b37e8d3410 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -165,6 +165,18 @@
 
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
+#define RTL822X_VND2_LCR7			0xd044
+#define RTL822X_VND2_LED_POLAR(x)		BIT(x)
+
 #define RTL8224_MII_RTCT			0x11
 #define RTL8224_MII_RTCT_ENABLE			BIT(0)
 #define RTL8224_MII_RTCT_PAIR_A			BIT(4)
@@ -1797,6 +1809,151 @@ static int rtl822xb_c45_read_status(struct phy_device *phydev)
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
+	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LCR6,
+				 RTL822X_VND2_LED_ACT(index));
+	if (ret < 0)
+		return ret;
+
+	if (value != LED_OFF)
+		return phy_set_bits_mmd(phydev, MDIO_MMD_VEND2,
+					RTL822X_VND2_LCR7,
+					RTL822X_VND2_LED_POLAR(index));
+	else
+		return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
+					  RTL822X_VND2_LCR7,
+					  RTL822X_VND2_LED_POLAR(index));
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
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LCR6,
+			     RTL822X_VND2_LED_ACT(index), act ?
+			     RTL822X_VND2_LED_ACT(index) : 0);
+	if (ret < 0)
+		return ret;
+
+	/* Reset polarity to default */
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_LCR7,
+				  RTL822X_VND2_LED_POLAR(index));
+}
+
 static int rtl8224_cable_test_start(struct phy_device *phydev)
 {
 	u32 val;
@@ -2565,6 +2722,10 @@ static struct phy_driver realtek_drvs[] = {
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
@@ -2584,6 +2745,10 @@ static struct phy_driver realtek_drvs[] = {
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


