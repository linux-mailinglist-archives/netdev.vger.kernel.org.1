Return-Path: <netdev+bounces-150994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5219F9EC4C7
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84D8168A3E
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 06:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA6A1C4A36;
	Wed, 11 Dec 2024 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZEecOv7O"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636CF1B85F8;
	Wed, 11 Dec 2024 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898618; cv=none; b=Ke8xg7RVVlXZ8zLvyk6cxZ1LgHWY6VtHjX6+YsXL+zVSbbSoHL5oq/a54VO0AKD+NhCRxcs0qkPona1gBQeMioBkXZNcw/ZhHRzYwTE/dJ/51VirQoA1HrhNj2/A9pKKn7LQ1fa2xtmsFxyTPT5lDajF4hpwjJVqB7FQLiSCdo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898618; c=relaxed/simple;
	bh=k1BxJHbleykfubxbLq3WM1bUxZIXi+Nircdv7l1clW4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZWyyGiM6Nz81F48/UtGI/1zflZhyPHdKCSAr9KFGAiY2gN66kG7IWIZs913FDi/+Edxaph9GtP8qUxp0tqJRsg/4+LX6vco5tZ8qg3Papg57fFlHSw49rTlsHCBsLT0jG97A1ieSvyjITqSLkX6NWfomede+XA4e9mP0WtEHrao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZEecOv7O; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BB6TmbqE3341241, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733898589; bh=k1BxJHbleykfubxbLq3WM1bUxZIXi+Nircdv7l1clW4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ZEecOv7OvWYb/gof0sCamLmUnxAkJ9V91nhZpqu/DAm6I6CVrLy4WN46cpWEMXti8
	 r5+mlpwrETW316o7zShI0HE1aCOMpfJ50GwT1Gzvxdp3vg/9odr7LuSxCU5ppj48Mq
	 QvKLULQ2vw+KvYJzTklokfZxTpH2LrCr55I8mIK4Wnteu14WpIrvHRiWyoDmFRC6dJ
	 UjKu84fbe55GC0rKrhOk7Y57xZrILqlHo9GmnRjgRTLGpcXY7MrXJqF/kxiW6tb0CV
	 yajiSnevNeVUXpCpVggNNvvLYEEgCECxCHpAXIIZrcH8OZz0idY0+E6ewiX+5ez4/5
	 RP2+z8Z9t6ZKw==
Received: from RSEXH36502.realsil.com.cn (msx.realsil.com.cn[172.29.17.3])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BB6TmbqE3341241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
	Wed, 11 Dec 2024 14:29:49 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RSEXH36502.realsil.com.cn (172.29.17.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Dec 2024 14:29:48 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Dec 2024 14:29:48 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 11 Dec 2024 14:29:48 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next] r8169: add support for RTL8125D rev.b
Date: Wed, 11 Dec 2024 14:29:46 +0800
Message-ID: <20241211062946.3716-1-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for RTL8125D rev.b. Its XID is 0x689. It is basically
based on the one with XID 0x688, but with different firmware file.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169.h          |  1 +
 drivers/net/ethernet/realtek/r8169_main.c     | 32 +++++++++++--------
 .../net/ethernet/realtek/r8169_phy_config.c   |  1 +
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 8904aae41aca..5b87c89363b3 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -71,6 +71,7 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_64,
 	RTL_GIGA_MAC_VER_65,
 	RTL_GIGA_MAC_VER_66,
+	RTL_GIGA_MAC_VER_67,
 	RTL_GIGA_MAC_NONE
 };
 
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6934bdee2a91..c97cfbf876af 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -57,6 +57,7 @@
 #define FIRMWARE_8125A_3	"rtl_nic/rtl8125a-3.fw"
 #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
 #define FIRMWARE_8125D_1	"rtl_nic/rtl8125d-1.fw"
+#define FIRMWARE_8125D_2	"rtl_nic/rtl8125d-2.fw"
 #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
 #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
 
@@ -142,6 +143,7 @@ static const struct {
 	[RTL_GIGA_MAC_VER_64] = {"RTL8125D",		FIRMWARE_8125D_1},
 	[RTL_GIGA_MAC_VER_65] = {"RTL8126A",		FIRMWARE_8126A_2},
 	[RTL_GIGA_MAC_VER_66] = {"RTL8126A",		FIRMWARE_8126A_3},
+	[RTL_GIGA_MAC_VER_67] = {"RTL8125D",		FIRMWARE_8125D_2},
 };
 
 static const struct pci_device_id rtl8169_pci_tbl[] = {
@@ -706,6 +708,7 @@ MODULE_FIRMWARE(FIRMWARE_8107E_2);
 MODULE_FIRMWARE(FIRMWARE_8125A_3);
 MODULE_FIRMWARE(FIRMWARE_8125B_2);
 MODULE_FIRMWARE(FIRMWARE_8125D_1);
+MODULE_FIRMWARE(FIRMWARE_8125D_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_3);
 
@@ -1228,7 +1231,7 @@ static void rtl_writephy(struct rtl8169_private *tp, int location, int val)
 	case RTL_GIGA_MAC_VER_31:
 		r8168dp_2_mdio_write(tp, location, val);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_67:
 		r8168g_mdio_write(tp, location, val);
 		break;
 	default:
@@ -1243,7 +1246,7 @@ static int rtl_readphy(struct rtl8169_private *tp, int location)
 	case RTL_GIGA_MAC_VER_28:
 	case RTL_GIGA_MAC_VER_31:
 		return r8168dp_2_mdio_read(tp, location);
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_67:
 		return r8168g_mdio_read(tp, location);
 	default:
 		return r8169_mdio_read(tp, location);
@@ -1574,7 +1577,7 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 		break;
 	case RTL_GIGA_MAC_VER_34:
 	case RTL_GIGA_MAC_VER_37:
-	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_67:
 		r8169_mod_reg8_cond(tp, Config2, PME_SIGNAL, wolopts);
 		break;
 	default:
@@ -2047,7 +2050,7 @@ static void rtl_set_eee_txidle_timer(struct rtl8169_private *tp)
 		tp->tx_lpi_timer = timer_val;
 		r8168_mac_ocp_write(tp, 0xe048, timer_val);
 		break;
-	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_67:
 		tp->tx_lpi_timer = timer_val;
 		RTL_W16(tp, EEE_TXIDLE_TIMER_8125, timer_val);
 		break;
@@ -2259,6 +2262,7 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 		{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_65 },
 
 		/* 8125D family. */
+		{ 0x7cf, 0x689,	RTL_GIGA_MAC_VER_67 },
 		{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64 },
 
 		/* 8125B family. */
@@ -2526,7 +2530,7 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_61:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
 		break;
-	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_67:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
 			RX_PAUSE_SLOT_ON);
 		break;
@@ -2658,7 +2662,7 @@ static void rtl_wait_txrx_fifo_empty(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_61:
 		rtl_loop_wait_high(tp, &rtl_rxtx_empty_cond, 100, 42);
 		break;
-	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_67:
 		RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) | StopReq);
 		rtl_loop_wait_high(tp, &rtl_rxtx_empty_cond, 100, 42);
 		rtl_loop_wait_high(tp, &rtl_rxtx_empty_cond_2, 100, 42);
@@ -2901,7 +2905,7 @@ static void rtl_enable_exit_l1(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_37 ... RTL_GIGA_MAC_VER_38:
 		rtl_eri_set_bits(tp, 0xd4, 0x0c00);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_67:
 		r8168_mac_ocp_modify(tp, 0xc0ac, 0, 0x1f80);
 		break;
 	default:
@@ -2915,7 +2919,7 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_38:
 		rtl_eri_clear_bits(tp, 0xd4, 0x1f00);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_67:
 		r8168_mac_ocp_modify(tp, 0xc0ac, 0x1f80, 0);
 		break;
 	default:
@@ -2953,7 +2957,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
-		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
+		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_67:
 			/* reset ephy tx/rx disable timer */
 			r8168_mac_ocp_modify(tp, 0xe094, 0xff00, 0);
 			/* chip can trigger L1.2 */
@@ -2965,7 +2969,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 	} else {
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
-		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
+		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_67:
 			r8168_mac_ocp_modify(tp, 0xe092, 0x00ff, 0);
 			break;
 		default:
@@ -3839,6 +3843,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8126a,
 		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8126a,
+		[RTL_GIGA_MAC_VER_67] = rtl_hw_start_8125d,
 	};
 
 	if (hw_configs[tp->mac_version])
@@ -3855,6 +3860,7 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_61:
 	case RTL_GIGA_MAC_VER_64:
+	case RTL_GIGA_MAC_VER_67:
 		for (i = 0xa00; i < 0xb00; i += 4)
 			RTL_W32(tp, i, 0);
 		break;
@@ -4092,7 +4098,7 @@ static void rtl8169_cleanup(struct rtl8169_private *tp)
 		RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) | StopReq);
 		rtl_loop_wait_high(tp, &rtl_txcfg_empty_cond, 100, 666);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_67:
 		rtl_enable_rxdvgate(tp);
 		fsleep(2000);
 		break;
@@ -4249,7 +4255,7 @@ static unsigned int rtl_quirk_packet_padto(struct rtl8169_private *tp,
 
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_34:
-	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_67:
 		padto = max_t(unsigned int, padto, ETH_ZLEN);
 		break;
 	default:
@@ -5267,7 +5273,7 @@ static void rtl_hw_initialize(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_48:
 		rtl_hw_init_8168g(tp);
 		break;
-	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_67:
 		rtl_hw_init_8125(tp);
 		break;
 	default:
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index b28b30390e84..bfdcadebe486 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1164,6 +1164,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
 		[RTL_GIGA_MAC_VER_65] = rtl8126a_hw_phy_config,
 		[RTL_GIGA_MAC_VER_66] = rtl8126a_hw_phy_config,
+		[RTL_GIGA_MAC_VER_67] = rtl8125d_hw_phy_config,
 	};
 
 	if (phy_configs[ver])
-- 
2.43.0


