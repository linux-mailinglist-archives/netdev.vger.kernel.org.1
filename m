Return-Path: <netdev+bounces-248376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86299D07803
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 08:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DA81304D0B4
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 07:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1649A2EB856;
	Fri,  9 Jan 2026 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="Kv6tPJKJ"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6491E2C1594;
	Fri,  9 Jan 2026 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767942283; cv=none; b=r7yRWgz3WGhl0o5oEqSqKNqVqUgof/AVqUkiypXUuVs6lvxSxlEKABb9GZW+aXEV7VX5bQj6fzqUN4tlSkxTdhWUCN95H7wOsOfGJvjuEHYUraNNwEWXpS3RQzyHVRLFcKD54ml2uYN5PMdr+rgo0ac1mTEkfUNqbzBrNCKtHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767942283; c=relaxed/simple;
	bh=xsUIgGPYctyYYBeNoav+u6CjXuj1ddPAIQ/12OoTWMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDMm/RUns8m5nlm9pdxwZcLBv9SpDLKv4pWtTZKrwtohfbcc4H0pJRt+GN+ycwRsaLxJcB7Q6gPZwn/G75ShnmywKsB+etAUuYLhWC69J0p1xOmAJ5ySrE1vwGjh4MdVUCHblpJPOqIYaQEq4THhbkPDEX1qC9fRzG4TndLH8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=Kv6tPJKJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60974IdA42723814, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1767942259;
	bh=d6ewmXhY0O8IwUEfQRgoBN9PR+yztRuvgS6L//F9zLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Kv6tPJKJi0A+JwOW3s6mdFwjMVZD/QEgZyXNqE8PJrOR2WVGS8ALy3Pjzm+eDJ9n0
	 dbAJuwuq2kmWnLUp7P77V0TzUhEn5dyls4USSp/LrhbxRrjW8ukthYF5i2M74iFCLh
	 gRFy/3W1BB6yULc3hISUtDloF3xapzWN4oQlxEoU8qwEfsQdOJPnqWz120cdX7FFJ6
	 FJ3/2HEa79P3dmhRolEN1ZCPwjx3q6CudqPqSxScDtQudmim6/tncYYcQ46scMgbW8
	 i1Aq80EHuWKaqlMFhtdG66NXuinciL7GXtMxYgjrnecxSYId5longkw+P77XWJ7dzz
	 Md5DFdojAocVQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60974IdA42723814
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Jan 2026 15:04:19 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 9 Jan 2026 15:04:18 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 9 Jan 2026 15:04:18 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v4 2/2] r8169: enable LTR support
Date: Fri, 9 Jan 2026 15:04:15 +0800
Message-ID: <20260109070415.1115-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260109070415.1115-1-javen_xu@realsil.com.cn>
References: <20260109070415.1115-1-javen_xu@realsil.com.cn>
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
v3: Address some checkpatch warnings and remove rtl_ltr_disable().
v4: Fix some formatting changes.
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


