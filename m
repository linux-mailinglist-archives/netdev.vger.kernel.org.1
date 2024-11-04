Return-Path: <netdev+bounces-141689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1489BC098
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944F7B21431
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F331F5849;
	Mon,  4 Nov 2024 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwZL5CM2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B61AAE27
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758046; cv=none; b=fFWj76mClfJwc/DkD0HI47gW5H9nU64ggHzXV1hS1cVRoCJozg08PP/zsa8M21lSBBad2M2BIeqd00ImmlEgaTu0ZarkIrG0x5EzzPQADCzfipBpWM2AX486YCw+d3xN3AnE81Qm7w4Y2YTIxjzI1uP1qT0CmpQvAu+tqgbOENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758046; c=relaxed/simple;
	bh=PD9Q/4gP/UuEJLO8PHf8A0M5fg/bUBS5ZRV7Eup5ltw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=kVNsF3ACRWRZ3a2shwSyngKt0hGdHgjek49Wf/wW9//tFGjoUI5IU4amyzjBI+YgG2uVrIY4ATGpTByjgGv+3cHCWCH2UC2WOT4GoTm8Gk69YncdsFUdJgNUT2lXOdceB5qN660A03xl6KEUTn5vlrengz7S0ExkYqoO1ETw/dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwZL5CM2; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f58c68c5so8625517e87.3
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 14:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730758042; x=1731362842; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PTtQS60VXWYnY4DMP52fgO42u4a7mi7+xu0tjbzOozk=;
        b=KwZL5CM2ZoMdhIGeOzSpRlC1InI7tjIgi2I4HeiydcYntWMRQ+HCKpaU1oAOYeDAyN
         G8UguTGqUyKrhifpG+EiNJ5jRxrfrc5j0vPvv+HKSkavSdGvhb0xqQ8zc80OCAg/NE/q
         0krF+4V1G6cG7JLXiVXsqBDjtLVW59yzzZUM0+83otWwjzvPp9WAPNR6pP9KeA/9IWW7
         VX2MoAeA51CG30jK+z/T6WCLXsI2KIaAJb/arLnzbloWQuFAgqIgcrKMPEmt6S35jDuZ
         CI9Kez7CKCmXg8xPitKFbMedAd4JGpKUJjPSy9Q6b/nj5GIonjHN5kJIY7PEciK6i+zK
         TeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730758042; x=1731362842;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PTtQS60VXWYnY4DMP52fgO42u4a7mi7+xu0tjbzOozk=;
        b=c6AuWvpr1VwZ9kQKvpt1mfhcs1omEp/58942W1HcHPTkyLFUIE5YbxXN/3wuc3s4Nc
         dHxz3p9m9apzlqqCAeOtYvWRVSFb0awd8N6SILXnjxxLOdkyZKl2Ns2GvTv7nAEFlxwX
         GrrqpyFWCHAwlcd33TCCoLY4Fj72zlAv2UfUzDto/wYrZd5bNaEAN6siBWq+jBuJZsRO
         94uxFnUEp6rgEJywKzKNKR0vET4xnqLFBqyH1uhymVlKjIm+vIOEslBd47TIE1Ri7Wce
         O6hmwsaK4O9vs0bQPSbF8zKIowgj06FLXOasjFFMYZjiD7yH05W5EmdpuYbCsc17DySg
         LKVw==
X-Gm-Message-State: AOJu0Ywjvk2BMgmsWp/Zh2VS3NiPjXWraMxNoiGBArTjCrEC1r+mpwz/
	GEIyc7EQRsS8uA4yFWvwV9lMy2YPbES373Y16wZ6/dpq9dmEjSeI
X-Google-Smtp-Source: AGHT+IE54L2IJyjxRMUFqhdTwRZMM59/McQQIJ+/TMDTU9LPa5l8oWD+wLKUpFlCHA6iY4SVo0Yw4g==
X-Received: by 2002:a05:6512:ba0:b0:53c:74a7:43de with SMTP id 2adb3069b0e04-53d65df2488mr9821859e87.29.1730758041895;
        Mon, 04 Nov 2024 14:07:21 -0800 (PST)
Received: from ?IPV6:2a02:3100:9c2b:eb00:5887:d6c2:d681:2735? (dynamic-2a02-3100-9c2b-eb00-5887-d6c2-d681-2735.310.pool.telefonica.de. [2a02:3100:9c2b:eb00:5887:d6c2:d681:2735])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9eb16d6620sm37079866b.54.2024.11.04.14.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 14:07:20 -0800 (PST)
Message-ID: <4677d3c4-60e2-4094-81a8-adae42ca46bb@gmail.com>
Date: Mon, 4 Nov 2024 23:07:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: copy vendor driver 2.5G/5G EEE advertisement
 constraints
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Vendor driver r8125 doesn't advertise 2.5G EEE on RTL8125A, and r8126
doesn't advertise 5G EEE. Likely there are compatibility issues,
therefore do the same in r8169.
With this change we don't have to disable 2.5G EEE advertisement in
rtl8125a_config_eee_phy() any longer.
Note: We don't remove the potentially problematic modes from the
supported modes, so users can re-enable advertisement of these modes
if they work fine in their setup.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c       |  7 +++++++
 drivers/net/ethernet/realtek/r8169_phy_config.c | 16 ++++------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index e83c4841b..4f37d25e0 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5318,6 +5318,13 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 		phy_support_eee(tp->phydev);
 	phy_support_asym_pause(tp->phydev);
 
+	/* mimic behavior of r8125/r8126 vendor drivers */
+	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				   tp->phydev->advertising_eee);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			   tp->phydev->advertising_eee);
+
 	/* PHY will be woken up in rtl_open() */
 	phy_suspend(tp->phydev);
 
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index 1d5b33f6c..5307c6ff4 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -96,15 +96,7 @@ static void rtl8125_common_config_eee_phy(struct phy_device *phydev)
 	phy_modify_paged(phydev, 0xa4a, 0x11, 0x0200, 0x0000);
 }
 
-static void rtl8125a_config_eee_phy(struct phy_device *phydev)
-{
-	rtl8168g_config_eee_phy(phydev);
-	/* disable EEE at 2.5Gbps */
-	phy_modify_paged(phydev, 0xa6d, 0x12, 0x0001, 0x0000);
-	rtl8125_common_config_eee_phy(phydev);
-}
-
-static void rtl8125b_config_eee_phy(struct phy_device *phydev)
+static void rtl8125_config_eee_phy(struct phy_device *phydev)
 {
 	rtl8168g_config_eee_phy(phydev);
 	rtl8125_common_config_eee_phy(phydev);
@@ -1066,7 +1058,7 @@ static void rtl8125a_2_hw_phy_config(struct rtl8169_private *tp,
 	rtl8168g_enable_gphy_10m(phydev);
 
 	rtl8168g_disable_aldps(phydev);
-	rtl8125a_config_eee_phy(phydev);
+	rtl8125_config_eee_phy(phydev);
 }
 
 static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
@@ -1106,7 +1098,7 @@ static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
 
 	rtl8125_legacy_force_mode(phydev);
 	rtl8168g_disable_aldps(phydev);
-	rtl8125b_config_eee_phy(phydev);
+	rtl8125_config_eee_phy(phydev);
 }
 
 static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
@@ -1116,7 +1108,7 @@ static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
 	rtl8168g_enable_gphy_10m(phydev);
 	rtl8125_legacy_force_mode(phydev);
 	rtl8168g_disable_aldps(phydev);
-	rtl8125b_config_eee_phy(phydev);
+	rtl8125_config_eee_phy(phydev);
 }
 
 static void rtl8126a_hw_phy_config(struct rtl8169_private *tp,
-- 
2.47.0


