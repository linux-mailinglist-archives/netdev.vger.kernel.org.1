Return-Path: <netdev+bounces-241099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A43C7F339
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 08:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB04E3CAC
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 07:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFC02E8B61;
	Mon, 24 Nov 2025 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clJ996sZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA42E6CAF
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969880; cv=none; b=Apve40zwmYMdk3u/7Vxv5GPvwcAmVRpiO6H6aOILdun+CHwHa/r/yq31BovSQcp3ppI6G6OxCuJilJKOpcvyKHAlnpJerAVyUxvVaSI87IsD2qe3YiGzpgu42+cfM+HRDwj0vxRE94PMy2S3dALKzUX5pTPrm+LjWOXWnlI3AcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969880; c=relaxed/simple;
	bh=L6UsiUVq4Hy1qkiJpSbXkJmsK2RIAypmdIF+zOofEaQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=a1a9VvVjaUzC1xpxNfEZyIl/I0rYeZcP8J61t14owbjUGZFz9nq4QMBRwAwfPFfiAcjMIawunHUAnbj6PI3lXdI38SPIa0ejm2OdnBczk3gxLudgqhDRcTRU+Vq02Mf5T1mBDN7CMNIn9R/lwfMxk9zZVjj2eztm5h6bKQjro7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clJ996sZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso23679955e9.1
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 23:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763969877; x=1764574677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=057LI+BddSRkiIjLPqC4kxKOlSN/GKmbmOLr53ttQV0=;
        b=clJ996sZmNw0mbss7YEXi8y6TgVzouELhDD1OlAGkff3ABpnioUA7+xBGo/lT0F1Ot
         +L7H2s8J9ZNXh4SXxeCNMQ5QVIVAQeFKnnjFzSZ4mEgecQcZdCKfMtxMg96x046twzaa
         RP6zdCTy60EsvusO1BE0gAqUDmCnlxUb459MYFw2N1Ls30d1s7XuepZGwYQzSdRwCq8A
         uWPH4fXR0Ys/TahMoQw9JJwa/ddQkFAlAR754l1WcBpjR1tnuVUQ93RUmjKeNO/F1LI+
         Itxe4yKuoJ8+iyLKQc/zEhpsdEzmBbeGbK+1NPOGamyX0xxKhvuf0Lo44SxEoVXVtTMm
         uKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763969877; x=1764574677;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=057LI+BddSRkiIjLPqC4kxKOlSN/GKmbmOLr53ttQV0=;
        b=eMstwKUvTNdG54cmh31g9xMCj+SSo9/Dlbylca078+MFgHvlXB6oT+qwC2dTQeY2Tz
         C3K8PVVzx49VShH+6HEKtDikw+sJH9WQRIgb4yw8YKvuhJ8TqiOMJAYC7D1EbQbprDEy
         2AX30GIMzPyd4lBx/Tmt0mfoNZLVs2yVY6NKgzP3WGRSosqe5ROIa/q50S656u1a1PZu
         ocPiQOV8s0/feoBmD2s+31C0b9Vo41tyDRZI2AWEu8ra937RjrWfui/Cx6DGSFlzoFWZ
         C2Cm6NRifdyX4WefGHiB4fKEdywhTP7pT3UuUK7JG/UHpEitCSQXaBQZklAGVIlVZxZr
         mkSw==
X-Gm-Message-State: AOJu0Yy1SthJ73Ub0fqvx83oGysMF+423WmIeK4yw82BGFbsF+uH6fms
	yDKgU4jNi498t9NM6SxxKGiLuUf3eRMb8sX+mEdyy+yFcvkqjsOvrDTZ
X-Gm-Gg: ASbGncsbzaX74U1MWImAXmAtDdH85B8T5ziQe3QX8iAPcJBiwuOfkP8ofXnnaWgA1Qo
	QyIWqjH0nWcHJ02fs9jnga81bia9bYnW7ZIUdwubRjFvCwXiK5DMRMBXpyaNLbWLgcd77qvhihp
	uUIzAwMsN8+FdoxHsNkFog/FPpExGGQ4j+BVh5M7WccGwWfK6ermZ93xxTglZhFFeYdbkNXpsKq
	eMeJrHzHsFVQ0hAXJuBGyDYyyOrrqf4iYN04YenkunbdFRvEola169UUfKc6PnoR5AVtvFvoB10
	Yj9WHclfb1j/vumzm0uu6YEvyMFPMsynoHtmcSOgwn3x1tgGVm1Ri8hSpwRzpT1AgolbuecbHfN
	1E6GK04+/FzhdXaWxS5VuPVtHagbwr/lgAsJZEYTV0KAdE8xg5GVRE/d2xfZzQLcEx8n6duro7n
	mwPLwqPHCdm+3WNrLmYhAkrd+1Lhai3zW5tHB+8UaUp0kb0mhH0XjBaiNCBlsxn2tI8gjkmTMbh
	iQIsnim1qmEDygrc0wwEcp1nsTnCM58IfWL/KsxEuojT/3ZAPMUDzrQkELPHVHJ
X-Google-Smtp-Source: AGHT+IHWsQVQ2WADcI76ZR42FiTxlj9AR4O5AahSjI6SVe5tlVn94DxrLxwOqTuj5ZHAz9XuqxR9zw==
X-Received: by 2002:a05:600c:1caa:b0:477:8b77:155f with SMTP id 5b1f17b1804b1-477c10d4935mr107454015e9.8.1763969875535;
        Sun, 23 Nov 2025 23:37:55 -0800 (PST)
Received: from ?IPV6:2003:ea:8f26:3000:c1bc:7440:20d8:29bc? (p200300ea8f263000c1bc744020d829bc.dip0.t-ipconnect.de. [2003:ea:8f26:3000:c1bc:7440:20d8:29bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477c0d85360sm174216005e9.15.2025.11.23.23.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 23:37:54 -0800 (PST)
Message-ID: <91bcb837-3fab-4b4e-b495-038df0932e44@gmail.com>
Date: Mon, 24 Nov 2025 08:37:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: improve MAC EEE handling
To: Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Let phydev->enable_tx_lpi control whether MAC enables TX LPI, instead of
enabling it unconditionally. This way TX LPI is disabled if e.g. link
partner doesn't support EEE. This helps to avoid potential issues like
link flaps.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 73 +++++++++++------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index cbacf1ef87a..33a83bf9035 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2425,26 +2425,6 @@ void r8169_apply_firmware(struct rtl8169_private *tp)
 	}
 }
 
-static void rtl8168_config_eee_mac(struct rtl8169_private *tp)
-{
-	/* Adjust EEE LED frequency */
-	if (tp->mac_version != RTL_GIGA_MAC_VER_38)
-		RTL_W8(tp, EEE_LED, RTL_R8(tp, EEE_LED) & ~0x07);
-
-	rtl_eri_set_bits(tp, 0x1b0, 0x0003);
-}
-
-static void rtl8125a_config_eee_mac(struct rtl8169_private *tp)
-{
-	r8168_mac_ocp_modify(tp, 0xe040, 0, BIT(1) | BIT(0));
-	r8168_mac_ocp_modify(tp, 0xeb62, 0, BIT(2) | BIT(1));
-}
-
-static void rtl8125b_config_eee_mac(struct rtl8169_private *tp)
-{
-	r8168_mac_ocp_modify(tp, 0xe040, 0, BIT(1) | BIT(0));
-}
-
 static void rtl_rar_exgmac_set(struct rtl8169_private *tp, const u8 *addr)
 {
 	rtl_eri_write(tp, 0xe0, ERIAR_MASK_1111, get_unaligned_le32(addr));
@@ -3253,8 +3233,6 @@ static void rtl_hw_start_8168e_2(struct rtl8169_private *tp)
 
 	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
 
-	rtl8168_config_eee_mac(tp);
-
 	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) | PFM_EN);
 	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | PWM_EN);
 	rtl_mod_config5(tp, Spi_en, 0);
@@ -3279,8 +3257,6 @@ static void rtl_hw_start_8168f(struct rtl8169_private *tp)
 	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) | PFM_EN);
 	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | PWM_EN);
 	rtl_mod_config5(tp, Spi_en, 0);
-
-	rtl8168_config_eee_mac(tp);
 }
 
 static void rtl_hw_start_8168f_1(struct rtl8169_private *tp)
@@ -3330,8 +3306,6 @@ static void rtl_hw_start_8168g(struct rtl8169_private *tp)
 	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000);
 	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000);
 
-	rtl8168_config_eee_mac(tp);
-
 	rtl_w0w1_eri(tp, 0x2fc, 0x01, 0x06);
 	rtl_eri_clear_bits(tp, 0x1b0, BIT(12));
 
@@ -3472,8 +3446,6 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000);
 	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000);
 
-	rtl8168_config_eee_mac(tp);
-
 	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
 	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
 
@@ -3521,8 +3493,6 @@ static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
 	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000);
 	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000);
 
-	rtl8168_config_eee_mac(tp);
-
 	rtl_w0w1_eri(tp, 0x2fc, 0x01, 0x06);
 
 	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~TX_10M_PS_EN);
@@ -3578,8 +3548,6 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000);
 	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000);
 
-	rtl8168_config_eee_mac(tp);
-
 	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
 	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
 
@@ -3820,11 +3788,6 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 
 	rtl_loop_wait_low(tp, &rtl_mac_ocp_e00e_cond, 1000, 10);
 
-	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
-		rtl8125a_config_eee_mac(tp);
-	else
-		rtl8125b_config_eee_mac(tp);
-
 	rtl_disable_rxdvgate(tp);
 }
 
@@ -4827,6 +4790,41 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+static void rtl_enable_tx_lpi(struct rtl8169_private *tp, bool enable)
+{
+	if (!rtl_supports_eee(tp))
+		return;
+
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_52:
+		/* Adjust EEE LED frequency */
+		if (tp->mac_version != RTL_GIGA_MAC_VER_38)
+			RTL_W8(tp, EEE_LED, RTL_R8(tp, EEE_LED) & ~0x07);
+		if (enable)
+			rtl_eri_set_bits(tp, 0x1b0, 0x0003);
+		else
+			rtl_eri_clear_bits(tp, 0x1b0, 0x0003);
+		break;
+	case RTL_GIGA_MAC_VER_61:
+		if (enable) {
+			r8168_mac_ocp_modify(tp, 0xe040, 0, 0x0003);
+			r8168_mac_ocp_modify(tp, 0xeb62, 0, 0x0006);
+		} else {
+			r8168_mac_ocp_modify(tp, 0xe040, 0x0003, 0);
+			r8168_mac_ocp_modify(tp, 0xeb62, 0x0006, 0);
+		}
+		break;
+	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_LAST:
+		if (enable)
+			r8168_mac_ocp_modify(tp, 0xe040, 0, 0x0003);
+		else
+			r8168_mac_ocp_modify(tp, 0xe040, 0x0003, 0);
+		break;
+	default:
+		break;
+	}
+}
+
 static void r8169_phylink_handler(struct net_device *ndev)
 {
 	struct rtl8169_private *tp = netdev_priv(ndev);
@@ -4834,6 +4832,7 @@ static void r8169_phylink_handler(struct net_device *ndev)
 
 	if (netif_carrier_ok(ndev)) {
 		rtl_link_chg_patch(tp);
+		rtl_enable_tx_lpi(tp, tp->phydev->enable_tx_lpi);
 		pm_request_resume(d);
 	} else {
 		pm_runtime_idle(d);
-- 
2.52.0


