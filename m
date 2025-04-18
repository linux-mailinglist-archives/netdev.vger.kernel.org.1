Return-Path: <netdev+bounces-184100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE5FA93532
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD6B467D5E
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0477026FD85;
	Fri, 18 Apr 2025 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHqpsjX7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203121EE7BE
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968256; cv=none; b=A2XTknxMiUgxXCpTnECfxpPuXiNaSrH5ZfEHuAw2QNAY2KZlUkYwMtE/Sv936vFkO2irXgMjJ/SroLNAnsALyjBF1KezAVkxIsO287umby42CEJc3ceG+gzgJHh6HaQtA4HenL5lVe1bfy2TBTAHaL50KD4vVi3/+QA1JuyHgsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968256; c=relaxed/simple;
	bh=8foQ8OWk/+K7qsz41aVSPVdBiYYVA9WMPMTe1kwlxoQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CmFFCRPze2264wVlzOfUrsZTmbKmbwGUXrT47vE4l1kXYll/n2nUsm/q+2KjAwEg+piaU+AjZqUoaQkCwS43/0VFee6oSsgWGxTBLg5dujQo9Kf/Gf+u9Khctc9sSzhcIiEvK2NEbh++4C6olaI4Edgm7p0v/6K7fm/UmkneNKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHqpsjX7; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39149bccb69so1699925f8f.2
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744968253; x=1745573053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OkPtgSaJTQD70hhuZjxlBvKdm8G2yoZJpNZ5MjyroRo=;
        b=YHqpsjX7HnlwjzfhZWAZxZyHGJKorMgTbHa4RfgS66JFFUNLW4xgP3Y1K8iv/4U9b8
         EWpICvv4OFWr4eXZYteLy3HDSt80Gfw33pGRwWwNi3VR78gUuKvEI0cuD5v2R0m+PU0t
         5CCRasEEeVJOHL5l95ca1DRPQFw9Pnnq0jEowKML2NkrcqLebZy3lAu9fH4QvuiRItK5
         1+xHSQPqC0RSaRWOvcLgQJxCTIempvG1ag3kYbpegN64z9KoXsjrUbrWf3AWEbmRy9JF
         KjauK0jHSaxo1qxw7vHx05fTqMvwwSkH+kCp7IO3lgPi50/qfCbyDAt9puC3iK8MNOmm
         DDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744968253; x=1745573053;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkPtgSaJTQD70hhuZjxlBvKdm8G2yoZJpNZ5MjyroRo=;
        b=PlA4eIbBrh6P9eajcq2B4IGbmPbSvvLsJpxxwBltBv+LgDpOTmPPIzOhqL16UDAKCN
         F1nNPUytZJjKVbQrHIhimcjK9E3E/7dn31Rqg61sxiNaxyJpVK2F+KbO5kp6gR8Spx5c
         JiZXUoY8L58+qMv6HZ7kCeTSORsHFfyB2hBWLP8UdZE4DwMKr3NUH56frQ9j3QJCLi96
         ndVk7BV4cNSJvMAIRyL/HdWFTqHDW3kcMGqfxa223FAbgh7IuB6EuVQeqUEVdtB2Qxmb
         hy4W0jGxXKuYp/yYsMgQW6MrlFkAiIhTPb3mwsG0HHaYTeh6/qweB4vWsaqTMyiMzbIE
         CTew==
X-Gm-Message-State: AOJu0YzKEg35IrBNcjxZ3GoBYKZvvcENgjV2IpYuo4DeiJ4n9co9n03y
	SPnlnrs/ty3kwK1gRk8sX1QyfstXP1GSJWbzmfBF6VkDfW7dTJss
X-Gm-Gg: ASbGnctLZiiIkW7bfv51EM1Ycf33D+fO8vKPbMcAJWb3kEu4BbSOea60K2ZCmhmm7PB
	6NIqq9tPUEMmhIgX8v3bHhJf3lVs5eW2J9mtv1Ar75fkIEV+dJ5uXcrpDkYNK5lb33qJEjaRBKG
	fwYSa9SWjJBf5WaDDEdL2WVFKA3to3cH1nvldIsBZSMoy3t6Ix00MtDcq77MFvIQ6ptAkAME2qW
	/qfX0hxYiyGZhCo8HtGbsuWN2wPATA9qMVxS/TNeD1U7QR98m4F/dRaFM7xd9McKn+ddd2Dh/87
	wmqixRaGXEJRyMTWXVoE5qt24bl3RehAiGAlyndjl8U2deTXAWCJDfS8vwWpBA5Sfsqkq3U9eLP
	fWtqvRrtGRIr/+uOGyyoRJtBpCEeJxQtru1cg93lS9lq1SLiM+bEQWH5f9t1eDc25wKQo/Ih5vb
	rbiqdb+MUOb069K52Dbt2tsDlpHAzuX5oD
X-Google-Smtp-Source: AGHT+IE7ExTj+smPesjkCZH+ihS+Xslw9hGmjg0VVL0rQzCkzVO0D9z5nJcTT5CBUDnxqWjl4adyHw==
X-Received: by 2002:a05:6000:4027:b0:391:3207:2e75 with SMTP id ffacd0b85a97d-39efba3c8bamr1398305f8f.18.1744968253342;
        Fri, 18 Apr 2025 02:24:13 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a14c:6800:64c1:f857:3ca4:c5c8? (dynamic-2a02-3100-a14c-6800-64c1-f857-3ca4-c5c8.310.pool.telefonica.de. [2a02:3100:a14c:6800:64c1:f857:3ca4:c5c8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39efa4a4be2sm2137874f8f.83.2025.04.18.02.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 02:24:12 -0700 (PDT)
Message-ID: <ae866b71-c904-434e-befb-848c831e33ff@gmail.com>
Date: Fri, 18 Apr 2025 11:25:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/3] r8169: merge chip versions 52 and 53 (RTL8117)
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <5e1e14ea-d60f-4608-88eb-3104b6bbace8@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5e1e14ea-d60f-4608-88eb-3104b6bbace8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Handling of both chip versions is the same, only difference is
the firmware. So we can merge handling of both chip versions.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.h            |  1 -
 drivers/net/ethernet/realtek/r8169_main.c       | 17 +++++++----------
 drivers/net/ethernet/realtek/r8169_phy_config.c |  1 -
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 1878c44ec..f05231030 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -64,7 +64,6 @@ enum mac_version {
 	/* support for RTL_GIGA_MAC_VER_50 has been removed */
 	RTL_GIGA_MAC_VER_51,
 	RTL_GIGA_MAC_VER_52,
-	RTL_GIGA_MAC_VER_53,
 	/* support for RTL_GIGA_MAC_VER_60 has been removed */
 	RTL_GIGA_MAC_VER_61,
 	RTL_GIGA_MAC_VER_63,
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index cba5bf8c2..b2c48d013 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -116,7 +116,7 @@ static const struct rtl_chip_info {
 	{ 0x7cf, 0x609,	RTL_GIGA_MAC_VER_61, "RTL8125A", FIRMWARE_8125A_3 },
 
 	/* RTL8117 */
-	{ 0x7cf, 0x54b,	RTL_GIGA_MAC_VER_53, "RTL8168fp/RTL8117" },
+	{ 0x7cf, 0x54b,	RTL_GIGA_MAC_VER_52, "RTL8168fp/RTL8117" },
 	{ 0x7cf, 0x54a,	RTL_GIGA_MAC_VER_52, "RTL8168fp/RTL8117",
 	  FIRMWARE_8168FP_3 },
 
@@ -831,7 +831,7 @@ static bool rtl_is_8168evl_up(struct rtl8169_private *tp)
 {
 	return tp->mac_version >= RTL_GIGA_MAC_VER_34 &&
 	       tp->mac_version != RTL_GIGA_MAC_VER_39 &&
-	       tp->mac_version <= RTL_GIGA_MAC_VER_53;
+	       tp->mac_version <= RTL_GIGA_MAC_VER_52;
 }
 
 static bool rtl_supports_eee(struct rtl8169_private *tp)
@@ -999,9 +999,7 @@ void r8169_get_led_name(struct rtl8169_private *tp, int idx,
 static void r8168fp_adjust_ocp_cmd(struct rtl8169_private *tp, u32 *cmd, int type)
 {
 	/* based on RTL8168FP_OOBMAC_BASE in vendor driver */
-	if (type == ERIAR_OOB &&
-	    (tp->mac_version == RTL_GIGA_MAC_VER_52 ||
-	     tp->mac_version == RTL_GIGA_MAC_VER_53))
+	if (type == ERIAR_OOB && tp->mac_version == RTL_GIGA_MAC_VER_52)
 		*cmd |= 0xf70 << 18;
 }
 
@@ -1501,7 +1499,7 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_28:
 	case RTL_GIGA_MAC_VER_31:
 		return RTL_DASH_DP;
-	case RTL_GIGA_MAC_VER_51 ... RTL_GIGA_MAC_VER_53:
+	case RTL_GIGA_MAC_VER_51 ... RTL_GIGA_MAC_VER_52:
 		return RTL_DASH_EP;
 	case RTL_GIGA_MAC_VER_66:
 		return RTL_DASH_25_BP;
@@ -2486,7 +2484,7 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_38:
 		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_53:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_52:
 		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST | RX_EARLY_OFF);
 		break;
 	case RTL_GIGA_MAC_VER_61:
@@ -2617,7 +2615,7 @@ DECLARE_RTL_COND(rtl_rxtx_empty_cond_2)
 static void rtl_wait_txrx_fifo_empty(struct rtl8169_private *tp)
 {
 	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_53:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_52:
 		rtl_loop_wait_high(tp, &rtl_txcfg_empty_cond, 100, 42);
 		rtl_loop_wait_high(tp, &rtl_rxtx_empty_cond, 100, 42);
 		break;
@@ -3827,7 +3825,6 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_48] = rtl_hw_start_8168h_1,
 		[RTL_GIGA_MAC_VER_51] = rtl_hw_start_8168ep_3,
 		[RTL_GIGA_MAC_VER_52] = rtl_hw_start_8117,
-		[RTL_GIGA_MAC_VER_53] = rtl_hw_start_8117,
 		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
 		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
 		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
@@ -5288,7 +5285,7 @@ static void rtl_hw_init_8125(struct rtl8169_private *tp)
 static void rtl_hw_initialize(struct rtl8169_private *tp)
 {
 	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_51 ... RTL_GIGA_MAC_VER_53:
+	case RTL_GIGA_MAC_VER_51 ... RTL_GIGA_MAC_VER_52:
 		rtl8168ep_stop_cmac(tp);
 		fallthrough;
 	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_48:
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index e3adfafa2..5403f8202 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1176,7 +1176,6 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_48] = rtl8168h_2_hw_phy_config,
 		[RTL_GIGA_MAC_VER_51] = rtl8168ep_2_hw_phy_config,
 		[RTL_GIGA_MAC_VER_52] = rtl8117_hw_phy_config,
-		[RTL_GIGA_MAC_VER_53] = rtl8117_hw_phy_config,
 		[RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
 		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
 		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
-- 
2.49.0



