Return-Path: <netdev+bounces-25567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDEC774C58
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AFD281884
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010FA171D1;
	Tue,  8 Aug 2023 21:06:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB66171CD
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 21:06:04 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC9A4C2B
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=57wyyIpPXfmwQgPiTUlHunoZk24zb+qx/BCKetFzbKc=; b=2bDvpcPXC1cwf5+cIWpgPspZm0
	PT3+OF5SSO7mSQ2ecbA+ir3xxfmOpEb1dQL+2hVL/9Sb4RCXSys+ZHv8Tu2KA18atyCXQKOLCn/I7
	72Q/3uGNqqbcOBiVwRLcfbWO5usZ+Su3yqCsndRYjzwzQk7h+mOw/dnXmhJlyfeIpraE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qTTsw-003WGX-TX; Tue, 08 Aug 2023 23:04:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Simon Horman <simon.horman@corigine.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v3 3/4] net: phy: marvell: Add support for offloading LED blinking
Date: Tue,  8 Aug 2023 23:04:35 +0200
Message-Id: <20230808210436.838995-4-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230808210436.838995-1-andrew@lunn.ch>
References: <20230808210436.838995-1-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the code needed to indicate if a given blinking pattern can be
offloaded, to offload a pattern and to try to return the current
pattern.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/marvell.c | 281 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 281 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 43b6cb725551..eba652a4c1d8 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -2893,6 +2893,272 @@ static int m88e1318_led_blink_set(struct phy_device *phydev, u8 index,
 			       MII_88E1318S_PHY_LED_FUNC, reg);
 }
 
+struct marvell_led_rules {
+	int mode;
+	unsigned long rules;
+};
+
+static const struct marvell_led_rules marvell_led0[] = {
+	{
+		.mode = 0,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+	},
+	{
+		.mode = 1,
+		.rules = (BIT(TRIGGER_NETDEV_LINK) |
+			  BIT(TRIGGER_NETDEV_RX) |
+			  BIT(TRIGGER_NETDEV_TX)),
+	},
+	{
+		.mode = 3,
+		.rules = (BIT(TRIGGER_NETDEV_RX) |
+			  BIT(TRIGGER_NETDEV_TX)),
+	},
+	{
+		.mode = 4,
+		.rules = (BIT(TRIGGER_NETDEV_RX) |
+			  BIT(TRIGGER_NETDEV_TX)),
+	},
+	{
+		.mode = 5,
+		.rules = BIT(TRIGGER_NETDEV_TX),
+	},
+	{
+		.mode = 6,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+	},
+	{
+		.mode = 7,
+		.rules = BIT(TRIGGER_NETDEV_LINK_1000),
+	},
+	{
+		.mode = 8,
+		.rules = 0,
+	},
+};
+
+static const struct marvell_led_rules marvell_led1[] = {
+	{
+		.mode = 1,
+		.rules = (BIT(TRIGGER_NETDEV_LINK) |
+			  BIT(TRIGGER_NETDEV_RX) |
+			  BIT(TRIGGER_NETDEV_TX)),
+	},
+	{
+		.mode = 2,
+		.rules = (BIT(TRIGGER_NETDEV_LINK) |
+			  BIT(TRIGGER_NETDEV_RX)),
+	},
+	{
+		.mode = 3,
+		.rules = (BIT(TRIGGER_NETDEV_RX) |
+			  BIT(TRIGGER_NETDEV_TX)),
+	},
+	{
+		.mode = 4,
+		.rules = (BIT(TRIGGER_NETDEV_RX) |
+			  BIT(TRIGGER_NETDEV_TX)),
+	},
+	{
+		.mode = 6,
+		.rules = (BIT(TRIGGER_NETDEV_LINK_100) |
+			  BIT(TRIGGER_NETDEV_LINK_1000)),
+	},
+	{
+		.mode = 7,
+		.rules = BIT(TRIGGER_NETDEV_LINK_100),
+	},
+	{
+		.mode = 8,
+		.rules = 0,
+	},
+};
+
+static const struct marvell_led_rules marvell_led2[] = {
+	{
+		.mode = 0,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+	},
+	{
+		.mode = 1,
+		.rules = (BIT(TRIGGER_NETDEV_LINK) |
+			  BIT(TRIGGER_NETDEV_RX) |
+			  BIT(TRIGGER_NETDEV_TX)),
+	},
+	{
+		.mode = 3,
+		.rules = (BIT(TRIGGER_NETDEV_RX) |
+			  BIT(TRIGGER_NETDEV_TX)),
+	},
+	{
+		.mode = 4,
+		.rules = (BIT(TRIGGER_NETDEV_RX) |
+			  BIT(TRIGGER_NETDEV_TX)),
+	},
+	{
+		.mode = 5,
+		.rules = BIT(TRIGGER_NETDEV_TX),
+	},
+	{
+		.mode = 6,
+		.rules = (BIT(TRIGGER_NETDEV_LINK_10) |
+			  BIT(TRIGGER_NETDEV_LINK_1000)),
+	},
+	{
+		.mode = 7,
+		.rules = BIT(TRIGGER_NETDEV_LINK_10),
+	},
+	{
+		.mode = 8,
+		.rules = 0,
+	},
+};
+
+static int marvell_find_led_mode(unsigned long rules,
+				 const struct marvell_led_rules *marvell_rules,
+				 int count,
+				 int *mode)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		if (marvell_rules[i].rules == rules) {
+			*mode = marvell_rules[i].mode;
+			return 0;
+		}
+	}
+	return -EOPNOTSUPP;
+}
+
+static int marvell_get_led_mode(u8 index, unsigned long rules, int *mode)
+{
+	int ret;
+
+	switch (index) {
+	case 0:
+		ret = marvell_find_led_mode(rules, marvell_led0,
+					    ARRAY_SIZE(marvell_led0), mode);
+		break;
+	case 1:
+		ret = marvell_find_led_mode(rules, marvell_led1,
+					    ARRAY_SIZE(marvell_led1), mode);
+		break;
+	case 2:
+		ret = marvell_find_led_mode(rules, marvell_led2,
+					    ARRAY_SIZE(marvell_led2), mode);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int marvell_find_led_rules(unsigned long *rules,
+				  const struct marvell_led_rules *marvell_rules,
+				  int count,
+				  int mode)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		if (marvell_rules[i].mode == mode) {
+			*rules = marvell_rules[i].rules;
+			return 0;
+		}
+	}
+	return -EOPNOTSUPP;
+}
+
+static int marvell_get_led_rules(u8 index, unsigned long *rules, int mode)
+{
+	int ret;
+
+	switch (index) {
+	case 0:
+		ret = marvell_find_led_rules(rules, marvell_led0,
+					     ARRAY_SIZE(marvell_led0), mode);
+		break;
+	case 1:
+		ret = marvell_find_led_rules(rules, marvell_led1,
+					     ARRAY_SIZE(marvell_led1), mode);
+		break;
+	case 2:
+		ret = marvell_find_led_rules(rules, marvell_led2,
+					     ARRAY_SIZE(marvell_led2), mode);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+static int m88e1318_led_hw_is_supported(struct phy_device *phydev, u8 index,
+					unsigned long rules)
+{
+	int mode, ret;
+
+	switch (index) {
+	case 0:
+	case 1:
+	case 2:
+		ret = marvell_get_led_mode(index, rules, &mode);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int m88e1318_led_hw_control_set(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	int mode, ret, reg;
+
+	switch (index) {
+	case 0:
+	case 1:
+	case 2:
+		ret = marvell_get_led_mode(index, rules, &mode);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	reg = phy_read_paged(phydev, MII_MARVELL_LED_PAGE,
+			     MII_88E1318S_PHY_LED_FUNC);
+	if (reg < 0)
+		return reg;
+
+	reg &= ~(0xf << (4 * index));
+	reg |= mode << (4 * index);
+	return phy_write_paged(phydev, MII_MARVELL_LED_PAGE,
+			       MII_88E1318S_PHY_LED_FUNC, reg);
+}
+
+static int m88e1318_led_hw_control_get(struct phy_device *phydev, u8 index,
+				       unsigned long *rules)
+{
+	int mode, reg;
+
+	if (index > 2)
+		return -EINVAL;
+
+	reg = phy_read_paged(phydev, MII_MARVELL_LED_PAGE,
+			     MII_88E1318S_PHY_LED_FUNC);
+	if (reg < 0)
+		return reg;
+
+	mode = (reg >> (4 * index)) & 0xf;
+
+	return marvell_get_led_rules(index, rules, mode);
+}
+
 static int marvell_probe(struct phy_device *phydev)
 {
 	struct marvell_priv *priv;
@@ -3144,6 +3410,9 @@ static struct phy_driver marvell_drivers[] = {
 		.get_stats = marvell_get_stats,
 		.led_brightness_set = m88e1318_led_brightness_set,
 		.led_blink_set = m88e1318_led_blink_set,
+		.led_hw_is_supported = m88e1318_led_hw_is_supported,
+		.led_hw_control_set = m88e1318_led_hw_control_set,
+		.led_hw_control_get = m88e1318_led_hw_control_get,
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1145,
@@ -3252,6 +3521,9 @@ static struct phy_driver marvell_drivers[] = {
 		.cable_test_get_status = marvell_vct7_cable_test_get_status,
 		.led_brightness_set = m88e1318_led_brightness_set,
 		.led_blink_set = m88e1318_led_blink_set,
+		.led_hw_is_supported = m88e1318_led_hw_is_supported,
+		.led_hw_control_set = m88e1318_led_hw_control_set,
+		.led_hw_control_get = m88e1318_led_hw_control_get,
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1540,
@@ -3280,6 +3552,9 @@ static struct phy_driver marvell_drivers[] = {
 		.cable_test_get_status = marvell_vct7_cable_test_get_status,
 		.led_brightness_set = m88e1318_led_brightness_set,
 		.led_blink_set = m88e1318_led_blink_set,
+		.led_hw_is_supported = m88e1318_led_hw_is_supported,
+		.led_hw_control_set = m88e1318_led_hw_control_set,
+		.led_hw_control_get = m88e1318_led_hw_control_get,
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1545,
@@ -3308,6 +3583,9 @@ static struct phy_driver marvell_drivers[] = {
 		.cable_test_get_status = marvell_vct7_cable_test_get_status,
 		.led_brightness_set = m88e1318_led_brightness_set,
 		.led_blink_set = m88e1318_led_blink_set,
+		.led_hw_is_supported = m88e1318_led_hw_is_supported,
+		.led_hw_control_set = m88e1318_led_hw_control_set,
+		.led_hw_control_get = m88e1318_led_hw_control_get,
 	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E3016,
@@ -3451,6 +3729,9 @@ static struct phy_driver marvell_drivers[] = {
 		.set_tunable = m88e1540_set_tunable,
 		.led_brightness_set = m88e1318_led_brightness_set,
 		.led_blink_set = m88e1318_led_blink_set,
+		.led_hw_is_supported = m88e1318_led_hw_is_supported,
+		.led_hw_control_set = m88e1318_led_hw_control_set,
+		.led_hw_control_get = m88e1318_led_hw_control_get,
 	},
 };
 
-- 
2.40.1


