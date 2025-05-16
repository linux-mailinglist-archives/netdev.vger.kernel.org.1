Return-Path: <netdev+bounces-190970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61786AB98EE
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93DE17752D
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D066230BD0;
	Fri, 16 May 2025 09:34:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B4B214205
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388054; cv=none; b=YfB0n5hBnfLJd9q3kYecVxl/4svGamoZU1J+2XXx8gG8q1yD5pgk8voVWTGRy9pvTkVvSUwGtw3TB9/QpPVFEik0dWR1IeTc8ZcaoYLDFBv7ZWiI3u4XXM3b9LXEPS5wgRSnF6WPITW6n0P08sWNhv6uvyY8nZuUCczUv7A3ttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388054; c=relaxed/simple;
	bh=HYxIZNdGL1LtZCG57Ix+30ePFB7pW9QjAVsG3SrCaN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzdKkLMkDCZXegtsACzHDot397Boxa0TQ57hJT7v7ZG1nVUzqxl3yRnRLCDAqJdulrK7QiVCqdXb+T1SxRtq14GfsfLF7qGQhm0IjiVHy224OenlUj1tMgf5qk1AcgiCMmkKDYSxo6X7cvEUK3T1H9o1v7sCIxRfIkVlUxNuDp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1747387965t57fb6954
X-QQ-Originating-IP: koxt4chPBdDhqIbJowd+7EYLoLhhD2FvtCUg6yp0pzE=
Received: from w-MS-7E16.trustnetic.com ( [122.233.195.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 May 2025 17:32:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 105240690335119094
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 3/9] net: txgbe: Distinguish between 40G and 25G devices
Date: Fri, 16 May 2025 17:32:14 +0800
Message-ID: <2A092B0D4355A4AC+20250516093220.6044-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516093220.6044-1-jiawenwu@trustnetic.com>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ONuta04l/Gln/4C2hec5sNTY8cQsJlIgWYIyQw9QiUzS05Coy35oYj0c
	qyJ6i639Ed8sUk023J2NFlebXLwZsvJvYnupjTRSls1HbPdl9wM4MepC/PbhTKLhjhSa55X
	qUncLZOHo9d+bTCjepoJCkNGc9Gzuy48PJBD96N/sa1jE87ZOpMe2FJtoE8W7t05ljmdX5R
	N2vTaSlARBUKwFbGiJiRl+bZAwuLGPin3HbsQVNl3/yNYio33UQOhdQlXW4TZnq85qG2Hwq
	nadXkCM4O8OhdSZkYh++dZXwjwfhDQulHMx/HNn5849vAfXHzDohuVBeAlk+ptTxguz4SpD
	k+6RHjCz0Bdljg3YS1uSEgnPOM1v2vFFHAl6ui6hmWvpgY1x0oarc9ROaAlhjKnDp3kiCq7
	Q9ptjGnqQF5rz+JjTonEvQgBBk+/FKSHFHLtqH4VFLIuptZG2BTuZgEE1EhZwR0SxKs7rU/
	5IBL1ijq5cJWZKzsRnHgRXLCoPPxQhf62MwiQVyqd4nLsJ+WzqWD5FGPYGTU+XlXJfMoHHn
	vd2pTaO68YVKpqJomuZYUpJHx0oxAq7qbnNRZqu9Qwpn3XsD5l1lOlmFpOftrR1TjPZeaoy
	mRkUaftCS3iCZT6vfOd3wSnbqFIpwt4XtkX9AA5d6Q+7Lx4/WrORPs0VAT7WO1RXJ9t7ZuL
	Z13ZhB93H34SqP6NmlyP+Nzf5VRcgQMVlxeBIzl1NwHiPCFPN5TWkmGJ4lSKrR/LUF7qqC6
	qQ9oLfbdzp6SPAOj2JdvesoxTCK4ONUVB9xXzdgKaMa1Gn1ppU5H1YkeysW/kvTYaSb5za9
	c9VpODBT2RH5nRO0SVc14exWXs1n+DfSv/bep2wHPYpZPlAbovfxJPSLQqGDXJDiY4R4fKY
	Gk3MYRY5hNwiEVkJw8ZXJWIjujRad7q33E5oJd3iSWFv383CV+g8xOBG2+cbaihj55Da/Nx
	W3nZ0H37awWVnTh3YZTyAtWLk/Y07MWY5xBzvQ5zafo0MA+p9KTgA0nOyhUtPYptmjSgEkE
	R2Q8aPH3XbnmlSQD2fHwDZAET4g5y1Q3l+w7//5J7xWkwVGQikMH2B6BhbabMtK6cErgwl8
	0KEQ748SDWe
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

For the following patches to support PHYLINK for AML 25G devices,
separate MAC type wx_mac_aml40 to maintain the driver of 40G devices.
Because 40G devices will complete support later, not now.

And this patch makes the 25G devices use some PHYLINK interfaces, but it
is not yet create PHYLINK and cannot be used on its own. It is just
preparation for the next patches.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
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


