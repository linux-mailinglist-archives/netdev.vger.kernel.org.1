Return-Path: <netdev+bounces-153263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BA19F77B3
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07731894BAF
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AE7216611;
	Thu, 19 Dec 2024 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="sH+zcIIC"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366DC147;
	Thu, 19 Dec 2024 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734598202; cv=none; b=cJMlkcwZ9K52VFqma6Jkc4nJlTkILOE3WJSdpjIqkeJwk3gMY3dG09V6boGTELXGELcbzCD/j2Hj8PuH6u+KQvfiBnXnOiLiP4NTPMyZRx648zIrEpQSHn8kIRnsV+MOpkmnF8LY306wGabZuTWgTdIfxVBtL8tu9aWkqHzanJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734598202; c=relaxed/simple;
	bh=raw9FamQR5IrWtGZw+JGjEg95ms035f7EJwRSiGd5/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AEr0VPYhjfHRMTS1JCak7/ognhAde2BZBXnKvKmG5WJ6WAYOUsntIDSNeWeV4PrXe9/1BzR4SXG090/8cjoh8hx/6UOhvsloOR8V5IH+XMmWUcgxTf3VQlEyZFW91kOlHjIuMDIE0HxbnlPdq3fbUQUgViTu29GOysXabHRzEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=sH+zcIIC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BJ8nbhrF3743817, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734598177; bh=raw9FamQR5IrWtGZw+JGjEg95ms035f7EJwRSiGd5/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=sH+zcIICQ7/pS/wZqUXSgXhyUvCK/GJbNyKG0GiVeluXHrSwQmMLGaF2NR0EYXCyG
	 olwxctUqTkcT+jfpF8sxV59ih2St6+UX6YY5nM1UGfreDKGP0acS4xdYLdFNnXKZDk
	 oe4GobdxNW/J7DuhCGaY3LIcfrMr9kYoKURg/nUTGQ4F8zjPIi7h4/DZaVbzxUpdWi
	 Qf1v2UanrxCN8ASR2WI5klavQ9yWE/J4stdUqauytxGk23y+znJF6vSStVMhEQ2k+i
	 kVC2KXAdOnhL6euYWxwych5WiAjTcYi3JD8ifoAyuCw2p/YBGMVOYVWBmB7fivSvxq
	 ECUQ4xzmcKKgA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BJ8nbhrF3743817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 16:49:37 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Dec 2024 16:49:38 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 19 Dec 2024 16:49:37 +0800
Received: from fc40.realtek.com.tw (172.22.241.7) by RTEXH36505.realtek.com.tw
 (172.21.6.25) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Dec 2024 16:49:37 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next] r8169: add support for RTL8125BP rev.b
Date: Thu, 19 Dec 2024 16:49:33 +0800
Message-ID: <20241219084933.8757-1-hayeswang@realtek.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChunHao Lin <hau@realtek.com>

Add support for RTL8125BP rev.b. Its XID is 0x689. This chip supports
DASH and its dash type is "RTL_DASH_25_BP".

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169.h          |  1 +
 drivers/net/ethernet/realtek/r8169_main.c     | 29 +++++++++++++++++++
 .../net/ethernet/realtek/r8169_phy_config.c   | 23 +++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index e0817f2a311a..7a194a8ab989 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -70,6 +70,7 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_63,
 	RTL_GIGA_MAC_VER_64,
 	RTL_GIGA_MAC_VER_65,
+	RTL_GIGA_MAC_VER_66,
 	RTL_GIGA_MAC_VER_70,
 	RTL_GIGA_MAC_VER_71,
 	RTL_GIGA_MAC_NONE
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5724f650f9c6..17ac50fcc9c8 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -58,6 +58,7 @@
 #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
 #define FIRMWARE_8125D_1	"rtl_nic/rtl8125d-1.fw"
 #define FIRMWARE_8125D_2	"rtl_nic/rtl8125d-2.fw"
+#define FIRMWARE_8125BP_2	"rtl_nic/rtl8125bp-2.fw"
 #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
 #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
 
@@ -142,6 +143,7 @@ static const struct {
 	[RTL_GIGA_MAC_VER_63] = {"RTL8125B",		FIRMWARE_8125B_2},
 	[RTL_GIGA_MAC_VER_64] = {"RTL8125D",		FIRMWARE_8125D_1},
 	[RTL_GIGA_MAC_VER_65] = {"RTL8125D",		FIRMWARE_8125D_2},
+	[RTL_GIGA_MAC_VER_66] = {"RTL8125BP",		FIRMWARE_8125BP_2},
 	[RTL_GIGA_MAC_VER_70] = {"RTL8126A",		FIRMWARE_8126A_2},
 	[RTL_GIGA_MAC_VER_71] = {"RTL8126A",		FIRMWARE_8126A_3},
 };
@@ -632,6 +634,7 @@ enum rtl_dash_type {
 	RTL_DASH_NONE,
 	RTL_DASH_DP,
 	RTL_DASH_EP,
+	RTL_DASH_25_BP,
 };
 
 struct rtl8169_private {
@@ -1361,10 +1364,19 @@ static void rtl8168ep_driver_start(struct rtl8169_private *tp)
 		rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
 }
 
+static void rtl8125bp_driver_start(struct rtl8169_private *tp)
+{
+	r8168ep_ocp_write(tp, 0x01, 0x14, OOB_CMD_DRIVER_START);
+	r8168ep_ocp_write(tp, 0x01, 0x18, 0x00);
+	r8168ep_ocp_write(tp, 0x01, 0x10, 0x01);
+}
+
 static void rtl8168_driver_start(struct rtl8169_private *tp)
 {
 	if (tp->dash_type == RTL_DASH_DP)
 		rtl8168dp_driver_start(tp);
+	else if (tp->dash_type == RTL_DASH_25_BP)
+		rtl8125bp_driver_start(tp);
 	else
 		rtl8168ep_driver_start(tp);
 }
@@ -1385,10 +1397,19 @@ static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
 		rtl_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10000, 10);
 }
 
+static void rtl8125bp_driver_stop(struct rtl8169_private *tp)
+{
+	r8168ep_ocp_write(tp, 0x01, 0x14, OOB_CMD_DRIVER_STOP);
+	r8168ep_ocp_write(tp, 0x01, 0x18, 0x00);
+	r8168ep_ocp_write(tp, 0x01, 0x10, 0x01);
+}
+
 static void rtl8168_driver_stop(struct rtl8169_private *tp)
 {
 	if (tp->dash_type == RTL_DASH_DP)
 		rtl8168dp_driver_stop(tp);
+	else if (tp->dash_type == RTL_DASH_25_BP)
+		rtl8125bp_driver_stop(tp);
 	else
 		rtl8168ep_driver_stop(tp);
 }
@@ -1411,6 +1432,7 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
 	case RTL_DASH_DP:
 		return r8168dp_check_dash(tp);
 	case RTL_DASH_EP:
+	case RTL_DASH_25_BP:
 		return r8168ep_check_dash(tp);
 	default:
 		return false;
@@ -1425,6 +1447,8 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 		return RTL_DASH_DP;
 	case RTL_GIGA_MAC_VER_51 ... RTL_GIGA_MAC_VER_53:
 		return RTL_DASH_EP;
+	case RTL_GIGA_MAC_VER_66:
+		return RTL_DASH_25_BP;
 	default:
 		return RTL_DASH_NONE;
 	}
@@ -2261,6 +2285,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 		{ 0x7cf, 0x64a,	RTL_GIGA_MAC_VER_71 },
 		{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_70 },
 
+		/* 8125BP family. */
+		{ 0x7cf, 0x681,	RTL_GIGA_MAC_VER_66 },
+
 		/* 8125D family. */
 		{ 0x7cf, 0x689,	RTL_GIGA_MAC_VER_65 },
 		{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64 },
@@ -3842,6 +3869,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
 		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8125d,
+		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_70] = rtl_hw_start_8126a,
 		[RTL_GIGA_MAC_VER_71] = rtl_hw_start_8126a,
 	};
@@ -3861,6 +3889,7 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_61:
 	case RTL_GIGA_MAC_VER_64:
 	case RTL_GIGA_MAC_VER_65:
+	case RTL_GIGA_MAC_VER_66:
 		for (i = 0xa00; i < 0xb00; i += 4)
 			RTL_W32(tp, i, 0);
 		break;
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index 968c8a2185a4..cf95e579c65d 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1102,6 +1102,28 @@ static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
 	rtl8125_config_eee_phy(phydev);
 }
 
+static void rtl8125bp_hw_phy_config(struct rtl8169_private *tp,
+				    struct phy_device *phydev)
+{
+	r8169_apply_firmware(tp);
+	rtl8168g_enable_gphy_10m(phydev);
+
+	r8168g_phy_param(phydev, 0x8010, 0x0800, 0x0000);
+
+	phy_write(phydev, 0x1f, 0x0b87);
+	phy_write(phydev, 0x16, 0x8088);
+	phy_modify(phydev, 0x17, 0xff00, 0x9000);
+	phy_write(phydev, 0x16, 0x808f);
+	phy_modify(phydev, 0x17, 0xff00, 0x9000);
+	phy_write(phydev, 0x1f, 0x0000);
+
+	r8168g_phy_param(phydev, 0x8174, 0x2000, 0x1800);
+
+	rtl8125_legacy_force_mode(phydev);
+	rtl8168g_disable_aldps(phydev);
+	rtl8125_config_eee_phy(phydev);
+}
+
 static void rtl8126a_hw_phy_config(struct rtl8169_private *tp,
 				   struct phy_device *phydev)
 {
@@ -1163,6 +1185,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
 		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
 		[RTL_GIGA_MAC_VER_65] = rtl8125d_hw_phy_config,
+		[RTL_GIGA_MAC_VER_66] = rtl8125bp_hw_phy_config,
 		[RTL_GIGA_MAC_VER_70] = rtl8126a_hw_phy_config,
 		[RTL_GIGA_MAC_VER_71] = rtl8126a_hw_phy_config,
 	};
-- 
2.43.0


