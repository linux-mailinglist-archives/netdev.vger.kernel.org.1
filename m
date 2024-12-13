Return-Path: <netdev+bounces-151855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F729F1576
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C09416807B
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D8B13EFE3;
	Fri, 13 Dec 2024 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4wUiqm6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8F1EBFE1
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116927; cv=none; b=rd/18CYmi7WKHFtHL8iv2ISjyv76VKGBfyjKrCPZ+RM1gbThboj/MPX7l8+G4TF1GYv1alD51QRmQjKlqcVINjwXAx6W1PmlYN31l1LP6kVE6tVkzdDmICrEr+j/IA1AbVlEqJw7suCWhbUoiznU4NttxzUFxUCzA6/jRQqVYiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116927; c=relaxed/simple;
	bh=mDGA6dOvVemXunoAUl1Mu9Uqyx5Kt63Q7lL6Di+u2E0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hcHBNgFvVPlPYKGbCqWf89RlQpu8dCz/e9bjEozCfiB+Qx+hEDfyZZ2EdMNyOC16KleM9RoqMzKrFhFtSp/BtAPTN7xjXE8Y3RbjuU02Y9tqbQHU7su30EjdGQKAHSU5mRRBRz+B1u6IC5pMMlWpgz3XXl+eRttzS8ZEzR5dF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4wUiqm6; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30227c56b11so19193361fa.3
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734116922; x=1734721722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uJx5Ram6M7qDQ8vw53chCTiYXpAsG5qpk7s82ViO9zM=;
        b=F4wUiqm6/IeHGRt+MisxNrwhiS77PFH7zjoONvwXhNBdncyVEQlfkWO3TkYMuuOgH/
         K3rLIbqYBbJRf0u9tMsRGxhp9l4Sayje+n2SOQcdHSKKG953SEdW8e2JfphfW8Z0hosK
         LcAD5K8+A+hJYTukHRzAJuUhj7UbpO6cHBeSG1N+citJURedd5hlsKEq9Steyha9AMe/
         JM+EC2MvbjDInqhEfgImfhWYPPSgbqFGZc2cmFyxDHkdwh2rCAy6nKP3bBeq9DUljjZJ
         AlrXPkRmQQZtLgIvF+FkO+3QMTtWPZYs9518qbMkEAJEeuibDVXZzi/UmCVEg7PMrgsi
         uzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734116922; x=1734721722;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJx5Ram6M7qDQ8vw53chCTiYXpAsG5qpk7s82ViO9zM=;
        b=rbs/QFp++zHDNRzzyhh4ILoLnMwfvz7TYsFipyqo0Yxy1PSFFnKKLS2Kq0D8YJNlth
         51Ulh2edZ0cU96iz0RGSV3feTviSIlKPo1csf+DRhF8fxE9Hubo+D3SHWMqVv9hJy8q+
         oL0NuMDVW0xvRvkMxP2heYtg3vHQIymrUGKxYB9s8uVWbHm5haZGOxpTErBsRnh8yvHW
         TQl2LwPfG8KzlaHoMUJssSuMWAZ/jeldwyQTuhTK+bJO0aD0Yh7rebW/psh6V1KbA3RG
         X7vc8F+S7I0Iiz6tHZLwFkW2zYNM63t9c4ytdmdTFLdQ/tKfKir75op3fhMgV3DzUbpX
         b1pg==
X-Gm-Message-State: AOJu0Yxjfuyv+Qykk79qyROW6hb8t797SwaeFbN3MIB7x0nScFXtCBJA
	YbePbO7HrCNlgljTR1YfB5Dc+RGRV9t+RAAvWvslUgY72r4vNDpNl37D9w==
X-Gm-Gg: ASbGncvu+coCYOH5yMDRycsgCXKCVa5eS6+7+G/nKfH6Pxsq5GAspDvE+hUK4qKjfEW
	hT/BA4opK6UKOWj1pDeSvntQVzjQz3NU2vQyMjwTuiBCp3hEE4jMPyaYQGEBcD8xzCrCHlEu6OM
	Chyr7WCEh2bPbKmLwJg+p22BylviynoXhS94HfZ0WXfrZsrkcvmNzW0B2WBDY2pvDERfX0bMly7
	A0x1XQf/rzdypHAfwW8HeZGwRmYwZ5TwkkNZXRuMFIl1nL0IPhX1A5tnFv0tHztiOtFkJ4bTa+P
	ZW2D92fCIyJB8Mhe23w/5OMCkGPWlcvsqwRAW9jbyfuZZ+8/tJXPbE7WgrRlJ/6EfBFonJc5knr
	rPuxSxyQApSny9TdJH2hg8PIltvjPm1P8ZJD+kH8TcL5clg==
X-Google-Smtp-Source: AGHT+IEbp3IOp5Wev6coB8RF7lboMKwFTtbCijcruAaD5C5sG6DMfs/7FYt8lTiUAYZaQ4uHuUMmiA==
X-Received: by 2002:a17:906:c106:b0:aa6:ab70:4a78 with SMTP id a640c23a62f3a-aab77e8ab51mr330619366b.37.1734116503402;
        Fri, 13 Dec 2024 11:01:43 -0800 (PST)
Received: from ?IPV6:2a02:3100:adc3:fd00:9eb:6163:d514:e25d? (dynamic-2a02-3100-adc3-fd00-09eb-6163-d514-e25d.310.pool.telefonica.de. [2a02:3100:adc3:fd00:9eb:6163:d514:e25d])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab96068af9sm4374066b.69.2024.12.13.11.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 11:01:42 -0800 (PST)
Message-ID: <6a354364-20e9-48ad-a198-468264288757@gmail.com>
Date: Fri, 13 Dec 2024 20:01:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/2] r8169: adjust version numbering for RTL8126
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Chun-Hao Lin <hau@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <15c4a9fd-a653-4b09-825d-751964832a7a@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <15c4a9fd-a653-4b09-825d-751964832a7a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adjust version numbering for RTL8126, so that it doesn't overlap with
new RTL8125 versions.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.h          |  4 +-
 drivers/net/ethernet/realtek/r8169_main.c     | 62 +++++++++----------
 .../net/ethernet/realtek/r8169_phy_config.c   |  4 +-
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 8904aae41..00d74e76c 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -69,8 +69,8 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_61,
 	RTL_GIGA_MAC_VER_63,
 	RTL_GIGA_MAC_VER_64,
-	RTL_GIGA_MAC_VER_65,
-	RTL_GIGA_MAC_VER_66,
+	RTL_GIGA_MAC_VER_70,
+	RTL_GIGA_MAC_VER_71,
 	RTL_GIGA_MAC_NONE
 };
 
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6934bdee2..d153fa559 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -140,8 +140,8 @@ static const struct {
 	/* reserve 62 for CFG_METHOD_4 in the vendor driver */
 	[RTL_GIGA_MAC_VER_63] = {"RTL8125B",		FIRMWARE_8125B_2},
 	[RTL_GIGA_MAC_VER_64] = {"RTL8125D",		FIRMWARE_8125D_1},
-	[RTL_GIGA_MAC_VER_65] = {"RTL8126A",		FIRMWARE_8126A_2},
-	[RTL_GIGA_MAC_VER_66] = {"RTL8126A",		FIRMWARE_8126A_3},
+	[RTL_GIGA_MAC_VER_70] = {"RTL8126A",		FIRMWARE_8126A_2},
+	[RTL_GIGA_MAC_VER_71] = {"RTL8126A",		FIRMWARE_8126A_3},
 };
 
 static const struct pci_device_id rtl8169_pci_tbl[] = {
@@ -1228,7 +1228,7 @@ static void rtl_writephy(struct rtl8169_private *tp, int location, int val)
 	case RTL_GIGA_MAC_VER_31:
 		r8168dp_2_mdio_write(tp, location, val);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_71:
 		r8168g_mdio_write(tp, location, val);
 		break;
 	default:
@@ -1243,7 +1243,7 @@ static int rtl_readphy(struct rtl8169_private *tp, int location)
 	case RTL_GIGA_MAC_VER_28:
 	case RTL_GIGA_MAC_VER_31:
 		return r8168dp_2_mdio_read(tp, location);
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_71:
 		return r8168g_mdio_read(tp, location);
 	default:
 		return r8169_mdio_read(tp, location);
@@ -1574,7 +1574,7 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 		break;
 	case RTL_GIGA_MAC_VER_34:
 	case RTL_GIGA_MAC_VER_37:
-	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_71:
 		r8169_mod_reg8_cond(tp, Config2, PME_SIGNAL, wolopts);
 		break;
 	default:
@@ -2047,7 +2047,7 @@ static void rtl_set_eee_txidle_timer(struct rtl8169_private *tp)
 		tp->tx_lpi_timer = timer_val;
 		r8168_mac_ocp_write(tp, 0xe048, timer_val);
 		break;
-	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
 		tp->tx_lpi_timer = timer_val;
 		RTL_W16(tp, EEE_TXIDLE_TIMER_8125, timer_val);
 		break;
@@ -2255,8 +2255,8 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 		enum mac_version ver;
 	} mac_info[] = {
 		/* 8126A family. */
-		{ 0x7cf, 0x64a,	RTL_GIGA_MAC_VER_66 },
-		{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_65 },
+		{ 0x7cf, 0x64a,	RTL_GIGA_MAC_VER_71 },
+		{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_70 },
 
 		/* 8125D family. */
 		{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64 },
@@ -2526,7 +2526,7 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_61:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
 		break;
-	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_71:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
 			RX_PAUSE_SLOT_ON);
 		break;
@@ -2658,7 +2658,7 @@ static void rtl_wait_txrx_fifo_empty(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_61:
 		rtl_loop_wait_high(tp, &rtl_rxtx_empty_cond, 100, 42);
 		break;
-	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_71:
 		RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) | StopReq);
 		rtl_loop_wait_high(tp, &rtl_rxtx_empty_cond, 100, 42);
 		rtl_loop_wait_high(tp, &rtl_rxtx_empty_cond_2, 100, 42);
@@ -2901,7 +2901,7 @@ static void rtl_enable_exit_l1(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_37 ... RTL_GIGA_MAC_VER_38:
 		rtl_eri_set_bits(tp, 0xd4, 0x0c00);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_71:
 		r8168_mac_ocp_modify(tp, 0xc0ac, 0, 0x1f80);
 		break;
 	default:
@@ -2915,7 +2915,7 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_38:
 		rtl_eri_clear_bits(tp, 0xd4, 0x1f00);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_71:
 		r8168_mac_ocp_modify(tp, 0xc0ac, 0x1f80, 0);
 		break;
 	default:
@@ -2941,8 +2941,8 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 
 		rtl_mod_config5(tp, 0, ASPM_en);
 		switch (tp->mac_version) {
-		case RTL_GIGA_MAC_VER_65:
-		case RTL_GIGA_MAC_VER_66:
+		case RTL_GIGA_MAC_VER_70:
+		case RTL_GIGA_MAC_VER_71:
 			val8 = RTL_R8(tp, INT_CFG0_8125) | INT_CFG0_CLKREQEN;
 			RTL_W8(tp, INT_CFG0_8125, val8);
 			break;
@@ -2953,7 +2953,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
-		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
+		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
 			/* reset ephy tx/rx disable timer */
 			r8168_mac_ocp_modify(tp, 0xe094, 0xff00, 0);
 			/* chip can trigger L1.2 */
@@ -2965,7 +2965,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 	} else {
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
-		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
+		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
 			r8168_mac_ocp_modify(tp, 0xe092, 0x00ff, 0);
 			break;
 		default:
@@ -2973,8 +2973,8 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 		}
 
 		switch (tp->mac_version) {
-		case RTL_GIGA_MAC_VER_65:
-		case RTL_GIGA_MAC_VER_66:
+		case RTL_GIGA_MAC_VER_70:
+		case RTL_GIGA_MAC_VER_71:
 			val8 = RTL_R8(tp, INT_CFG0_8125) & ~INT_CFG0_CLKREQEN;
 			RTL_W8(tp, INT_CFG0_8125, val8);
 			break;
@@ -3694,12 +3694,12 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	/* disable new tx descriptor format */
 	r8168_mac_ocp_modify(tp, 0xeb58, 0x0001, 0x0000);
 
-	if (tp->mac_version == RTL_GIGA_MAC_VER_65 ||
-	    tp->mac_version == RTL_GIGA_MAC_VER_66)
+	if (tp->mac_version == RTL_GIGA_MAC_VER_70 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_71)
 		RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
 
-	if (tp->mac_version == RTL_GIGA_MAC_VER_65 ||
-	    tp->mac_version == RTL_GIGA_MAC_VER_66)
+	if (tp->mac_version == RTL_GIGA_MAC_VER_70 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_71)
 		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0400);
 	else if (tp->mac_version == RTL_GIGA_MAC_VER_63)
 		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0200);
@@ -3717,8 +3717,8 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
 	r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
 	r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
-	if (tp->mac_version == RTL_GIGA_MAC_VER_65 ||
-	    tp->mac_version == RTL_GIGA_MAC_VER_66)
+	if (tp->mac_version == RTL_GIGA_MAC_VER_70 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_71)
 		r8168_mac_ocp_modify(tp, 0xea1c, 0x0300, 0x0000);
 	else
 		r8168_mac_ocp_modify(tp, 0xea1c, 0x0004, 0x0000);
@@ -3837,8 +3837,8 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
 		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
 		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
-		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8126a,
-		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8126a,
+		[RTL_GIGA_MAC_VER_70] = rtl_hw_start_8126a,
+		[RTL_GIGA_MAC_VER_71] = rtl_hw_start_8126a,
 	};
 
 	if (hw_configs[tp->mac_version])
@@ -3859,8 +3859,8 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 			RTL_W32(tp, i, 0);
 		break;
 	case RTL_GIGA_MAC_VER_63:
-	case RTL_GIGA_MAC_VER_65:
-	case RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_70:
+	case RTL_GIGA_MAC_VER_71:
 		for (i = 0xa00; i < 0xa80; i += 4)
 			RTL_W32(tp, i, 0);
 		RTL_W16(tp, INT_CFG1_8125, 0x0000);
@@ -4092,7 +4092,7 @@ static void rtl8169_cleanup(struct rtl8169_private *tp)
 		RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) | StopReq);
 		rtl_loop_wait_high(tp, &rtl_txcfg_empty_cond, 100, 666);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_71:
 		rtl_enable_rxdvgate(tp);
 		fsleep(2000);
 		break;
@@ -4249,7 +4249,7 @@ static unsigned int rtl_quirk_packet_padto(struct rtl8169_private *tp,
 
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_34:
-	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
 		padto = max_t(unsigned int, padto, ETH_ZLEN);
 		break;
 	default:
@@ -5267,7 +5267,7 @@ static void rtl_hw_initialize(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_48:
 		rtl_hw_init_8168g(tp);
 		break;
-	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
 		rtl_hw_init_8125(tp);
 		break;
 	default:
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index b28b30390..bc498ea78 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1162,8 +1162,8 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
 		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
 		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
-		[RTL_GIGA_MAC_VER_65] = rtl8126a_hw_phy_config,
-		[RTL_GIGA_MAC_VER_66] = rtl8126a_hw_phy_config,
+		[RTL_GIGA_MAC_VER_70] = rtl8126a_hw_phy_config,
+		[RTL_GIGA_MAC_VER_71] = rtl8126a_hw_phy_config,
 	};
 
 	if (phy_configs[ver])
-- 
2.47.1



