Return-Path: <netdev+bounces-192176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C16ABEC60
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DB91BA6996
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B6B23C8A1;
	Wed, 21 May 2025 06:46:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E623C8D5
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 06:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747809971; cv=none; b=dz8X/wdHkoFuYOyKk8dmhk0mtJhMatUN+WDUNCiqilY1U1zc6NcA8XgDU4FC9g/uCyX1Mw+pqkGefQDb7Z8MT5q9jgpE2lFdr3uvzLEY0NZDHxub/OSdP/y2Jfjb0bCkBlpkmVs5WciHDcd2AQCyvNkS0MjTggKrQGldKVYMw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747809971; c=relaxed/simple;
	bh=5RDmSSUNcq4wJ2x/QCNylW+0yDv1oZq609VkLTns3+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldV7rlNH8eGp+W1Apde7YrQbw3BXgI5Rduk9wnKTUt2x9dh70GeGv6mIjcs0eiIMPJ7/LcLi5pwGXRmmTHmAevKsTystdGPmhnbt1i53pJzy/KWt3w+oU0b3SPHJrfHC513pwILjUd277S8zbSfkG4JRjxyk0ABR9jU0hTy9ZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz8t1747809870t595ed3f4
X-QQ-Originating-IP: zcLLZASrty3OLTgOr9EwKmtKaLXtxcerwySM2B8Ub8c=
Received: from w-MS-7E16.trustnetic.com ( [125.120.71.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 21 May 2025 14:44:28 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9757305262820426106
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 3/9] net: txgbe: Distinguish between 40G and 25G devices
Date: Wed, 21 May 2025 14:43:56 +0800
Message-ID: <592B1A6920867D0C+20250521064402.22348-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250521064402.22348-1-jiawenwu@trustnetic.com>
References: <20250521064402.22348-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MBREESna/OUi+c6p97lIkg46Umtf+4pdB7V15BwW18F0ybfKFaq9xmGh
	IetEMrgOUxEi3QM1MGmIjG762Of0qRJ9XZqPg0KeZY0FIZSe/bXZ6nOgtrOMdICyLq5VpCf
	AV4jB012sVgbL5UWtHan4ASTFA4rqeR/oGPfq4XK+ufB672gz1ATukXdn04AJTN8sBGwItt
	ok0Tu3Kj8quyqSaRulDrPfYgOZSZFsMs6K3vT4Wurxtri5JsPmnmk3FlSqgrtU/M/Kook6M
	st+4JYXa4/2tJevKbO9uuVSmM+XeVnfamFsClnBEwPxaiKhJlHFusKC8W71r2tyhdSy5pR4
	2XzwQSw4n9p4j1s709Vv3KvUemB0bH1qCf52YHZPsnAQmn1WO1CgezkDsx9IlgJ38WAGg/0
	4ub9C2gpafrRNpQCy0J1rLbEs5hhNb5RpDRx3eSof1Y+gtCqvUm6dSZ2kKjDBJYox7ZhgUg
	XUaPKskO9DD1fgvCjPzUTP3/uiwIwNqeJqtphgahl8Pwg2BoE/tWLAec2EjLecKZDvTsOcE
	4rZaR95j+8y2NYbV8cyMJoZFABfnmCn+gN0vXKXxSPCvI+yYNFdXf4oy8A4HVejY3l5raJV
	exJVKg9wCN3WhYuf8eFq0E/KLxLnWUPFDjuE9qUjXLpJcA3spDWoYGv7zQsVubpX7PbzMpw
	X4vAyutKOGWGekLcvkXaNmNwMKgYpGGiGoCCNdkZq/sv/QDZat6hpfxU/pHPGVCWkQAxfMC
	yuve5ZAxvNTW+g/53/JeDqGE3K7yugnZ4WWcibyySp+fxjKogrogn30ecxDwba8W52k1Wyt
	x9CrMBJGcJIonV/LjStKt4mLwUwuhmveM529xgVlhU299noRy39/2GKNOk7RLLPPRfRpDPa
	1EG0nQshmiDtSHcQTYENzG6RqIJqblcfpzaw5ScuFM2Vjt0B1EVZhids8YyNV7UC05v+LS4
	UjAiP+P+2JpJikX7AkiCz5L/DBrkJEKlaXHDaf952oZt+xPQqqP/RUHI9QvBU21iM+phd9d
	tSFOVPlC090WujKkNFQohNiJsoW67Gew4nGcGj5rmh3NFYAQooIm+vYk9MtSA=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

For the following patches to support PHYLINK for AML 25G devices,
separate MAC type wx_mac_aml40 to maintain the driver of 40G devices.
Because 40G devices will complete support later, not now.

And this patch makes the 25G devices use some PHYLINK interfaces, but it
is not yet create PHYLINK and cannot be used on its own. It is just
preparation for the next patches.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 12 ++++---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  2 ++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  4 +--
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 32 ++++++++++++++-----
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    | 32 +++++++++++++------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  3 +-
 8 files changed, 61 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index d58d7a8735bc..86c0159e8a2d 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -219,7 +219,7 @@ int wx_nway_reset(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (wx->mac.type == wx_mac_aml)
+	if (wx->mac.type == wx_mac_aml40)
 		return -EOPNOTSUPP;
 
 	return phylink_ethtool_nway_reset(wx->phylink);
@@ -231,7 +231,7 @@ int wx_get_link_ksettings(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (wx->mac.type == wx_mac_aml)
+	if (wx->mac.type == wx_mac_aml40)
 		return -EOPNOTSUPP;
 
 	return phylink_ethtool_ksettings_get(wx->phylink, cmd);
@@ -243,7 +243,7 @@ int wx_set_link_ksettings(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (wx->mac.type == wx_mac_aml)
+	if (wx->mac.type == wx_mac_aml40)
 		return -EOPNOTSUPP;
 
 	return phylink_ethtool_ksettings_set(wx->phylink, cmd);
@@ -255,7 +255,7 @@ void wx_get_pauseparam(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (wx->mac.type == wx_mac_aml)
+	if (wx->mac.type == wx_mac_aml40)
 		return;
 
 	phylink_ethtool_get_pauseparam(wx->phylink, pause);
@@ -267,7 +267,7 @@ int wx_set_pauseparam(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (wx->mac.type == wx_mac_aml)
+	if (wx->mac.type == wx_mac_aml40)
 		return -EOPNOTSUPP;
 
 	return phylink_ethtool_set_pauseparam(wx->phylink, pause);
@@ -345,6 +345,7 @@ int wx_set_coalesce(struct net_device *netdev,
 		max_eitr = WX_SP_MAX_EITR;
 		break;
 	case wx_mac_aml:
+	case wx_mac_aml40:
 		max_eitr = WX_AML_MAX_EITR;
 		break;
 	default:
@@ -375,6 +376,7 @@ int wx_set_coalesce(struct net_device *netdev,
 		switch (wx->mac.type) {
 		case wx_mac_sp:
 		case wx_mac_aml:
+		case wx_mac_aml40:
 			tx_itr_param = WX_12K_ITR;
 			break;
 		default:
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 1c5c14ac61bc..7a3467b41524 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -695,6 +695,7 @@ void wx_init_eeprom_params(struct wx *wx)
 	switch (wx->mac.type) {
 	case wx_mac_sp:
 	case wx_mac_aml:
+	case wx_mac_aml40:
 		if (wx_read_ee_hostif(wx, WX_SW_REGION_PTR, &data)) {
 			wx_err(wx, "NVM Read Error\n");
 			return;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index eab16c57b039..68e7cfe2f7ea 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1959,6 +1959,7 @@ static int wx_alloc_q_vector(struct wx *wx,
 	switch (wx->mac.type) {
 	case wx_mac_sp:
 	case wx_mac_aml:
+	case wx_mac_aml40:
 		default_itr = WX_12K_ITR;
 		break;
 	default:
@@ -2327,6 +2328,7 @@ void wx_write_eitr(struct wx_q_vector *q_vector)
 		itr_reg = q_vector->itr & WX_SP_MAX_EITR;
 		break;
 	case wx_mac_aml:
+	case wx_mac_aml40:
 		itr_reg = (q_vector->itr >> 3) & WX_AML_MAX_EITR;
 		break;
 	default:
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 6563d30e60c5..b4275ba622de 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -838,6 +838,7 @@ enum wx_mac_type {
 	wx_mac_sp,
 	wx_mac_em,
 	wx_mac_aml,
+	wx_mac_aml40,
 };
 
 enum wx_media_type {
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 19878f02d956..f53a5d00a41b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -176,7 +176,7 @@ static void txgbe_del_irq_domain(struct txgbe *txgbe)
 
 void txgbe_free_misc_irq(struct txgbe *txgbe)
 {
-	if (txgbe->wx->mac.type == wx_mac_aml)
+	if (txgbe->wx->mac.type == wx_mac_aml40)
 		return;
 
 	free_irq(txgbe->link_irq, txgbe);
@@ -190,7 +190,7 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 	struct wx *wx = txgbe->wx;
 	int hwirq, err;
 
-	if (wx->mac.type == wx_mac_aml)
+	if (wx->mac.type == wx_mac_aml40)
 		goto skip_sp_irq;
 
 	txgbe->misc.nirqs = TXGBE_IRQ_MAX;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 0c81d8fc2f7d..ca3dbc448646 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -91,6 +91,7 @@ static int txgbe_enumerate_functions(struct wx *wx)
 static void txgbe_up_complete(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
+	u32 reg;
 
 	wx_control_hw(wx, true);
 	wx_configure_vectors(wx);
@@ -99,17 +100,21 @@ static void txgbe_up_complete(struct wx *wx)
 	smp_mb__before_atomic();
 	wx_napi_enable_all(wx);
 
-	if (wx->mac.type == wx_mac_aml) {
-		u32 reg;
-
+	switch (wx->mac.type) {
+	case wx_mac_aml40:
 		reg = rd32(wx, TXGBE_AML_MAC_TX_CFG);
 		reg &= ~TXGBE_AML_MAC_TX_CFG_SPEED_MASK;
-		reg |= TXGBE_AML_MAC_TX_CFG_SPEED_25G;
+		reg |= TXGBE_AML_MAC_TX_CFG_SPEED_40G;
 		wr32(wx, WX_MAC_TX_CFG, reg);
 		txgbe_enable_sec_tx_path(wx);
 		netif_carrier_on(wx->netdev);
-	} else {
+		break;
+	case wx_mac_aml:
+	case wx_mac_sp:
 		phylink_start(wx->phylink);
+		break;
+	default:
+		break;
 	}
 
 	/* clear any pending interrupts, may auto mask */
@@ -207,10 +212,18 @@ void txgbe_down(struct wx *wx)
 {
 	txgbe_disable_device(wx);
 	txgbe_reset(wx);
-	if (wx->mac.type == wx_mac_aml)
+
+	switch (wx->mac.type) {
+	case wx_mac_aml40:
 		netif_carrier_off(wx->netdev);
-	else
+		break;
+	case wx_mac_aml:
+	case wx_mac_sp:
 		phylink_stop(wx->phylink);
+		break;
+	default:
+		break;
+	}
 
 	wx_clean_all_tx_rings(wx);
 	wx_clean_all_rx_rings(wx);
@@ -240,9 +253,11 @@ static void txgbe_init_type_code(struct wx *wx)
 	case TXGBE_DEV_ID_AML5110:
 	case TXGBE_DEV_ID_AML5025:
 	case TXGBE_DEV_ID_AML5125:
+		wx->mac.type = wx_mac_aml;
+		break;
 	case TXGBE_DEV_ID_AML5040:
 	case TXGBE_DEV_ID_AML5140:
-		wx->mac.type = wx_mac_aml;
+		wx->mac.type = wx_mac_aml40;
 		break;
 	default:
 		wx->mac.type = wx_mac_unknown;
@@ -341,6 +356,7 @@ static int txgbe_sw_init(struct wx *wx)
 	case wx_mac_sp:
 		break;
 	case wx_mac_aml:
+	case wx_mac_aml40:
 		set_bit(WX_FLAG_SWFW_RING, wx->flags);
 		wx->swfw_index = 0;
 		break;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index b5ae7c25ac99..ece378fa2620 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -573,11 +573,17 @@ int txgbe_init_phy(struct txgbe *txgbe)
 	struct wx *wx = txgbe->wx;
 	int ret;
 
-	if (wx->mac.type == wx_mac_aml)
+	switch (wx->mac.type) {
+	case wx_mac_aml40:
+	case wx_mac_aml:
 		return 0;
-
-	if (txgbe->wx->media_type == wx_media_copper)
-		return txgbe_ext_phy_init(txgbe);
+	case wx_mac_sp:
+		if (wx->media_type == wx_media_copper)
+			return txgbe_ext_phy_init(txgbe);
+		break;
+	default:
+		break;
+	}
 
 	ret = txgbe_swnodes_register(txgbe);
 	if (ret) {
@@ -640,13 +646,19 @@ int txgbe_init_phy(struct txgbe *txgbe)
 
 void txgbe_remove_phy(struct txgbe *txgbe)
 {
-	if (txgbe->wx->mac.type == wx_mac_aml)
-		return;
-
-	if (txgbe->wx->media_type == wx_media_copper) {
-		phylink_disconnect_phy(txgbe->wx->phylink);
-		phylink_destroy(txgbe->wx->phylink);
+	switch (txgbe->wx->mac.type) {
+	case wx_mac_aml40:
+	case wx_mac_aml:
 		return;
+	case wx_mac_sp:
+		if (txgbe->wx->media_type == wx_media_copper) {
+			phylink_disconnect_phy(txgbe->wx->phylink);
+			phylink_destroy(txgbe->wx->phylink);
+			return;
+		}
+		break;
+	default:
+		break;
 	}
 
 	platform_device_unregister(txgbe->sfp_dev);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 8376248fecda..3b4e4361462a 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -152,7 +152,8 @@
 #define TXGBE_PX_PF_BME                         0x4B8
 #define TXGBE_AML_MAC_TX_CFG                    0x11000
 #define TXGBE_AML_MAC_TX_CFG_SPEED_MASK         GENMASK(30, 27)
-#define TXGBE_AML_MAC_TX_CFG_SPEED_25G          BIT(28)
+#define TXGBE_AML_MAC_TX_CFG_SPEED_40G          FIELD_PREP(GENMASK(30, 27), 0)
+#define TXGBE_AML_MAC_TX_CFG_SPEED_25G          FIELD_PREP(GENMASK(30, 27), 2)
 #define TXGBE_RDM_RSC_CTL                       0x1200C
 #define TXGBE_RDM_RSC_CTL_FREE_CTL              BIT(7)
 
-- 
2.48.1


