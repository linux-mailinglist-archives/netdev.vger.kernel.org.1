Return-Path: <netdev+bounces-247944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E91D00AFC
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 03:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 387E73035CF4
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 02:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104DF239E80;
	Thu,  8 Jan 2026 02:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="E0Q2zs5R"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC49720311;
	Thu,  8 Jan 2026 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839754; cv=none; b=PX0nh8olCon2wwptsbsGNj9hqkXtNtguk3lEse2EimKkDYH/x4JPN7sjjQUW3ke/r1Zg7zMl8jfYQWOXJytKMAxHC1mZfQrneLzcWixXY0MKrYY0j6Saycfg0ehgf1DvSNSQevCHVA5OmKv7kPEXSllFI+7NZeLPD0PFJTeL5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839754; c=relaxed/simple;
	bh=iuQTleN1pvYWkChm6B4I+n65t2S77ZOTWdUKqlFJlm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGQnWLSYaiqkldiegI6c6c2KxB2LznOIScnkL5qErkaiJFOsgV+tKSzoLML8jNNPHBcwAJGX2XX+mougfd2UURTKfVqjE7FDM5c7bcVizLpkdyyD3sci/EtKK98xNXvdWEM23H7XMhkcc1zW/k+CjEoCYBKUV836iHcuAYfosLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=E0Q2zs5R; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6082ZSzmC109084, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1767839728;
	bh=FZb0rVAZ51h6mOmshTQUcIJsY1q3nMc9WdN5UzVFKR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=E0Q2zs5Ri9A+RFmT4avEps+iVgj7ifsYfQG0kJaoZF1o+oPyMSNGOq5jDUmwB4tcX
	 6HKBBPDML8INKjK6ackkDHDtp+TFzC11WYfVaVikrS+t+OB7FdZ+W+dw+bPGIx5RvO
	 K5ojN8+qizjn1rMgVq9NnQRLus8frozWDMrkpkS/VlbToL6uttdvlh9HKN9ue6MSJ5
	 Sins9l5rv4ZYAe5yrmzIEf8nW5f2gUCGaNe5W3QKhG55AkS4n7nsVpcMGjyuiLmf7L
	 As3LsIIAmxqcrRIdmuPEFkpVAQ+NoudieeI6OIoVasz1THZms63UuPW9n2tNgo9iWX
	 BFgniG3KcZ13g==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6082ZSzmC109084
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Jan 2026 10:35:28 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 8 Jan 2026 10:35:28 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 8 Jan 2026 10:35:28 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2 2/2] r8169: enable LTR support
Date: Thu, 8 Jan 2026 10:35:23 +0800
Message-ID: <20260108023523.1019-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260108023523.1019-1-javen_xu@realsil.com.cn>
References: <20260108023523.1019-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This patch will enable
RTL8168FP/RTL8168EP/RTL8168H/RTL8125/RTL8126/RTL8127 LTR support.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

---
v2: Replace some register numbers with names according to datasheet.
---
 drivers/net/ethernet/realtek/r8169_main.c | 112 ++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index f9df6aadacce..1ee5a0b5a6a0 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -312,6 +312,15 @@ enum rtl_registers {
 	IBIMR0          = 0xfa,
 	IBISR0          = 0xfb,
 	FuncForceEvent	= 0xfc,
+
+	ALDPS_LTR	= 0xe0a2,
+	LTR_OBFF_LOCK	= 0xe032,
+	LTR_SNOOP	= 0xe034,
+
+#define ALDPS_LTR_EN			BIT(0)
+#define LTR_OBFF_LOCK_EN		BIT(0)
+#define LINK_SPEED_CHANGE_EN		BIT(14)
+#define LTR_SNOOP_EN			GENMASK(15, 14)
 };
 
 enum rtl8168_8101_registers {
@@ -397,6 +406,8 @@ enum rtl8168_registers {
 #define PWM_EN				(1 << 22)
 #define RXDV_GATED_EN			(1 << 19)
 #define EARLY_TALLY_EN			(1 << 16)
+	COMBO_LTR_EXTEND = 0xb6,
+#define COMBO_LTR_EXTEND_EN 	BIT(0)
 };
 
 enum rtl8125_registers {
@@ -2919,6 +2930,104 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl_enable_ltr(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_80:
+		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
+		r8168_mac_ocp_modify(tp, LTR_SNOOP, 0x0000, LTR_SNOOP_EN);
+		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
+		r8168_mac_ocp_write(tp, 0xcdd2, 0x8c09);
+		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd4, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcde8, 0x887a);
+		r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdec, 0x8c09);
+		r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdf0, 0x8a62);
+		r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdf4, 0x883e);
+		r8168_mac_ocp_write(tp, 0xcdf6, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdf8, 0x8849);
+		r8168_mac_ocp_write(tp, 0xcdfa, 0x9003);
+		r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0000, LINK_SPEED_CHANGE_EN);
+		break;
+	case RTL_GIGA_MAC_VER_70:
+		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
+		r8168_mac_ocp_modify(tp, LTR_SNOOP, 0x0000, LTR_SNOOP_EN);
+		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
+		r8168_mac_ocp_write(tp, 0xcdd2, 0x8c09);
+		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd4, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcde8, 0x887a);
+		r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdec, 0x8c09);
+		r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdf0, 0x8a62);
+		r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdf4, 0x883e);
+		r8168_mac_ocp_write(tp, 0xcdf6, 0x9003);
+		r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0000, LINK_SPEED_CHANGE_EN);
+		break;
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
+		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
+		r8168_mac_ocp_modify(tp, LTR_SNOOP, 0x0000, LTR_SNOOP_EN);
+		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
+		r8168_mac_ocp_write(tp, 0xcdd2, 0x889c);
+		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd4, 0x8c30);
+		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcde8, 0x883e);
+		r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdec, 0x889c);
+		r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdf0, 0x8C09);
+		r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
+		r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0000, LINK_SPEED_CHANGE_EN);
+		break;
+	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
+	case RTL_GIGA_MAC_VER_52:
+		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
+		RTL_W8(tp, COMBO_LTR_EXTEND, RTL_R8(tp, COMBO_LTR_EXTEND) | COMBO_LTR_EXTEND_EN);
+		fallthrough;
+	case RTL_GIGA_MAC_VER_51:
+		r8168_mac_ocp_modify(tp, LTR_SNOOP, 0x0000, LTR_SNOOP_EN);
+		r8168_mac_ocp_write(tp, 0xe02c, 0x1880);
+		r8168_mac_ocp_write(tp, 0xe02e, 0x4880);
+		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd2, 0x883c);
+		r8168_mac_ocp_write(tp, 0xcdd4, 0x8c12);
+		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
+		break;
+	default:
+		return;
+	}
+	/* chip can trigger LTR */
+	r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0003, LTR_OBFF_LOCK_EN);
+}
+
+static void rtl_disable_ltr(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_80:
+		r8168_mac_ocp_modify(tp, 0xe032, 0x0003, 0);
+		break;
+	default:
+		break;
+	}
+}
+
+
 static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 {
 	u8 val8;
@@ -2947,6 +3056,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 			break;
 		}
 
+		rtl_enable_ltr(tp);
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
 		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
@@ -2968,6 +3078,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 			break;
 		}
 
+		rtl_disable_ltr(tp);
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_70:
 		case RTL_GIGA_MAC_VER_80:
@@ -4811,6 +4922,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
 
 	rtl8169_cleanup(tp);
 	rtl_disable_exit_l1(tp);
+	rtl_disable_ltr(tp);
 	rtl_prepare_power_down(tp);
 
 	if (tp->dash_type != RTL_DASH_NONE && !tp->saved_wolopts)
-- 
2.43.0


