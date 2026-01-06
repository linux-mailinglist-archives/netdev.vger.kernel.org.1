Return-Path: <netdev+bounces-247322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94802CF7522
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 09:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEB7130EECF1
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 08:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C889130AD1D;
	Tue,  6 Jan 2026 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="lHtjVPyj"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A61FF1B5;
	Tue,  6 Jan 2026 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767688270; cv=none; b=kkFZ+Ohl+VS2hptsxwkeStcIzAnZtOUnR5U8owJqj908UGTHvQxaU6GkJiJ46rxsZGPK6NjNgk8AI6X+hsQaYr00GVdzee8pJiIlMkeNmt7At5kfoLJoAhigQoetWaJGb2uf3Z1MISO8vfE33x42322co73iV41c06tqMFUMCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767688270; c=relaxed/simple;
	bh=5O68Oo60UA1CdvhZ/kryCFZIBnlmEuOIkazao4wamUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLVAUrsopF+aWYAKu56c7/Vr/hVfsGTlS68GmtXs+IF1v/Y3N8EotUISe/TT8z+1UBYniYZsEo0eK+d2sIsTwubdfvJwzL2Hr2OSsFLgsSB4idyn+TmvpF/Sze6haxEHD9eeWjEXcOBtddKQ0Mq6uiPWQbrmh1TWNQP7AQBkpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=lHtjVPyj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6068UVjsC438984, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1767688232;
	bh=IpSLYzfXywRiobl7Hj9ZodIibNeE4SLgduvAv+unPJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=lHtjVPyjO6NPfGE6vVSIr66zP/vlGCxQmkd84rFgeKy0l0zLNJRRWY/ALlVofHHS0
	 spHkOggDiXR1FvNJqDC3kjmSm7wzDnivwNu6ltruFeo6g+MwY8ag0dZjbMpFOpWxCk
	 OT7WpFG/R+3hdvfuDieSY0hd9mWeZGXBkAywrGuZGr7hJ5wJ785JeXgIyRjsfuM7fo
	 oZUMWLBBRNtlsv14m2IBq0OJvrq3M+3FL8F1mJYRLowBG9B/OzXw9C87RCp+YaGXlU
	 77ysEOAvpmJ2Iw71yohdh9s8EFfI/TRU/rMjtEoTTjBDVGrajVBORHhGJgJIqAGmiA
	 3rwfUadMqtCMw==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6068UVjsC438984
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Jan 2026 16:30:32 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 6 Jan 2026 16:30:31 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 6 Jan 2026 16:30:31 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next 2/2] r8169: enable LTR support
Date: Tue, 6 Jan 2026 16:30:12 +0800
Message-ID: <20260106083012.164-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260106083012.164-1-javen_xu@realsil.com.cn>
References: <20260106083012.164-1-javen_xu@realsil.com.cn>
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
index f9df6aadacce..97abf95502dc 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2919,6 +2919,101 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl_enable_ltr(struct rtl8169_private *tp)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_80:
+		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
+		r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);
+		r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));
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
+		r8168_mac_ocp_modify(tp, 0xe032, 0x0000, BIT(14));
+		break;
+	case RTL_GIGA_MAC_VER_70:
+		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
+		r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);
+		r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));
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
+		r8168_mac_ocp_modify(tp, 0xe032, 0x0000, BIT(14));
+		break;
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
+		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
+		r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);
+		r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));
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
+		r8168_mac_ocp_modify(tp, 0xe032, 0x0000, BIT(14));
+		break;
+	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_52:
+		r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);
+		r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));
+		r8168_mac_ocp_write(tp, 0xe02c, 0x1880);
+		r8168_mac_ocp_write(tp, 0xe02e, 0x4880);
+		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd2, 0x883c);
+		r8168_mac_ocp_write(tp, 0xcdd4, 0x8c12);
+		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
+		RTL_W8(tp, 0xb6, RTL_R8(tp, 0xb6) | BIT(0));
+		break;
+	default:
+		return;
+	}
+	/* chip can trigger LTR */
+	r8168_mac_ocp_modify(tp, 0xe032, 0x0003, BIT(0));
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
 static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 {
 	u8 val8;
@@ -2947,6 +3042,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 			break;
 		}
 
+		rtl_enable_ltr(tp);
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
 		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
@@ -2968,6 +3064,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 			break;
 		}
 
+		rtl_disable_ltr(tp);
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_70:
 		case RTL_GIGA_MAC_VER_80:
@@ -4811,6 +4908,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
 
 	rtl8169_cleanup(tp);
 	rtl_disable_exit_l1(tp);
+	rtl_disable_ltr(tp);
 	rtl_prepare_power_down(tp);
 
 	if (tp->dash_type != RTL_DASH_NONE && !tp->saved_wolopts)
-- 
2.43.0


