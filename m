Return-Path: <netdev+bounces-248869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3BED1060A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37E1E301D0FA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 02:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3015B304BBF;
	Mon, 12 Jan 2026 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="VOa4B7R9"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE851AA1D2;
	Mon, 12 Jan 2026 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768185991; cv=none; b=U5NPVhpbCSquZdc7fEul1NsMbrfqBQEmqqAm/TSj6h+pKWsySejwTO+QQWG+TPcPSzJJfyx3fCtidEq9GX8KkATQOKiJwQZVfdkdn2NR69U2NX6ll0Wk8sT9DPmNHwaOAmvZv0bABTJGDaKqk2+45//YYbqSCraXT0+HeEOkkqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768185991; c=relaxed/simple;
	bh=Cl8b4dYgQ4jfUxmMGhnfGw8Tw85hrvPxl2s4ztrBWzc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdZtvzv4QvAiDKklT3oiVxuEkgNh8Ji5E67I8GSiQEL9H1JQ7ly330aZutOhraD6DUfDRL3uiD+bMvjH3sfeM90az81G28wK8CGrowqfLhkkGmHpQ1Q6CDCxHcYBSKyszA7l22TDEXF/jMhZ3Lu0+ODFdcbhSb/NkL0DQ74X/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=VOa4B7R9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60C2jiCX34128682, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1768185944;
	bh=TzsVV9MZzRXo9Za2VUWgZgZZ8I+2hL82DPYp6joG1a4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=VOa4B7R9HD7wc16o4r0DX9T+5O0uXN1wdM/kuy1+jRoE2at1/vEGGBV7GsHJBILRq
	 9N2bBP3H2bFi6Fcm7VAf3GgNam8bYcvPzSTXt5V+Y+iMX8NKpfhww+J/uKeU1ojOKG
	 3wLx6LaeEaZSO9J30As3qi79DkTH4ARBca5I2uWpd8P+X1h3b8JmzcrhKXTW+RDsw0
	 ZsH0Coba2snEyQscmAvOz42AZLZKfKmaHT7YZ3JT3+Z9DV+sYu0K8XzBPPwWg531S8
	 cDzFSzNPH1KI0sxrdpkpdThyZfxqOwWasB66ygRcYgM1ApXyMLzI9ZPMAkMOkdPDdc
	 dNZZZIidqFC1A==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60C2jiCX34128682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Jan 2026 10:45:44 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 12 Jan 2026 10:45:44 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 12 Jan 2026 10:45:44 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 2/3] r8169: enable LTR support
Date: Mon, 12 Jan 2026 10:45:40 +0800
Message-ID: <20260112024541.1847-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260112024541.1847-1-javen_xu@realsil.com.cn>
References: <20260112024541.1847-1-javen_xu@realsil.com.cn>
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
 drivers/net/ethernet/realtek/r8169_main.c | 98 +++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index f9df6aadacce..9b89bbf67198 100644
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
+	COMBO_LTR_EXTEND	= 0xb6,
+#define COMBO_LTR_EXTEND_EN	BIT(0)
 };
 
 enum rtl8125_registers {
@@ -2919,6 +2930,92 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
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
 static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 {
 	u8 val8;
@@ -2947,6 +3044,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 			break;
 		}
 
+		rtl_enable_ltr(tp);
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
 		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
-- 
2.43.0


