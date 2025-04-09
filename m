Return-Path: <netdev+bounces-180927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D3DA83028
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 21:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD911B644FB
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 19:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4197A278171;
	Wed,  9 Apr 2025 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URXS0ZIr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69877277030
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226045; cv=none; b=kJq0PyLoZfqaKGVlnSeCwMvX2lr7QD3dimWuAtqLTKQL7C4vvy6WU6gCOQLeoM5wYCBRnot7e4EopdQNEcDjkJOHchiPu3vrsKAK7qPljL/4WE4T6TFR3HAYI5TrpnoCT/MjRzjzh3FcK8Og+ijEV8IBPbJw03UZpntJRa2WWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226045; c=relaxed/simple;
	bh=eG1StsHue3tIhDRcS6zsgs2j1rethZ77VLlGM2qY54I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=NBatseswX31zntwFUjCDXNWkE7zsfrPGpeLOhw5srWHDJ6z5AM4cQwMGe/Ew5eqUX+vhxR9CDI2ao7XbCF9VRkAnSaThymzGHwq3Gm0CU5V+xW37BozPjR0fzzz+gS+Rq81cA+Qz/t7dwChvymzjI0L2v1sPj6mOMfLUawk/KhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URXS0ZIr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfe574976so480675e9.1
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744226041; x=1744830841; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ivQ+hIhrdCswlwgMehZOoS7QxuUmjoXxy0hZgiwuP6A=;
        b=URXS0ZIrQYMX2X3MG1LYsnh2TuOl68jwTGv6DZf2HsNwDpyyDNbttBW8FYw6pLOOCN
         l/a+ha2cKSrWfu0YclaCNYbYK6JAkvgycxpW81YcwWtusPwQW1DJlcjmY0sDOjXzg2yl
         CLb8VPm+/E+PLj+zn/FMACsUMMMjyHh/UIEzU1qd0kKQssQ4uWiNGvW5DGRGb+Gf6y1j
         avGccn6q/e9gecOdPR7byuBwKqO4QrhYvVnzmrHAc9MYHykrFosqcTxVY8B5YE8r9dVH
         WJ/ilXMZ8gcDN+0OwgoQlbxczGXLjC6klZfy9HhG38nPpLnvsSGz3ZSOmPBajVd/1vJM
         RtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744226041; x=1744830841;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivQ+hIhrdCswlwgMehZOoS7QxuUmjoXxy0hZgiwuP6A=;
        b=L/2seMsTzCnT+G+ItaqwBeIAIz7jAAggLpYdpxWd9Jh93YaltIdcvbV1GBTGG0q/e6
         LkNCvwiOkC0u81TfQPvDlkwd293VyZTzE2yzZSQNS3ZBTLiCHLuRXhPFA5+VaE+EHYlA
         brnl+qsoX46miMjt7PoIYayStgQ9FeT0TqRG640bbfcof49J0P4+5BRCAxcTpROQVzwM
         k6wjZAXIKa6x5QICs5PtqPJZZ5WanoC9N9OvgMjs0WndE7hXhJZQzmpCJ4D7Wwp1bq8M
         7qlO83JG4OD7e/RhlEYtrIkvPUqqw81i2KOh8yKx1R6TR7dHQ6Vsas5dQM9nDCSk46nz
         rBWg==
X-Gm-Message-State: AOJu0YzJvjIusgBONbYmeemUryLKUzHWX+dvsOyIi6CfCY43LbB6Qkzh
	1P5MlsyRp+jCdfRQisLsX63EbhsXfN7yMWLvmcTjIWodwlXEvNro
X-Gm-Gg: ASbGnctPXDqgVv3J8gPkQOKq1NGZiX0sBgJ1rGJMiqRpbDuDnE5FD2/i6k/S27fsWqe
	ADF5fspOAX2sWyG8fLPdvTFZmijx3DwObwoaWeDXHlJyQ9kx/oTGtbBw7OqGReWUQtNGjwO2Hia
	jTD3YwJQ6SoonNMwpJCJ+t2WsuGgH1ZcEnlyGM4th/xyx62kqWBc+5ZeKMe6q9HzMeY9AsCMahk
	kY5cV3Nzt2soWs+6s0dicqlYsJ1DvWk1q/AAXHAR9wQwUvCfdm9PScegg0hJbUdnJe71DAxPv3u
	hPAEQhBrtCZJ9DR9EmD4uSP0Wc5056RkXr5hq/VeY4LK+3YhAF5J8pxn7V3VqyY5i9rU7YwBkp8
	94vCIxpB32h78Mvtq4eD8O0jfBQKSc6ZJsCHOuyOGwm9xtcBud9lcn/9rVTPA/G/NZGXMw0AY9m
	UzWV+BTFl0KMWvGM0/iJnRYUos4CXam4+V
X-Google-Smtp-Source: AGHT+IF7xirumE3PB74GKEutaOiLu6n3Gz7z9ZV8sj9Z4Gc+zC/iQ+UK41YRaLLyRZcDf2RnLdRQCA==
X-Received: by 2002:a05:6000:1a8a:b0:391:454:5eb8 with SMTP id ffacd0b85a97d-39d87ce26acmr3998496f8f.48.1744226041366;
        Wed, 09 Apr 2025 12:14:01 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9c75:6000:2d50:87f4:9992:caad? (dynamic-2a02-3100-9c75-6000-2d50-87f4-9992-caad.310.pool.telefonica.de. [2a02:3100:9c75:6000:2d50:87f4:9992:caad])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f233c7a75sm25264145e9.18.2025.04.09.12.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 12:14:00 -0700 (PDT)
Message-ID: <847b7356-12d6-441b-ade9-4b6e1539b84a@gmail.com>
Date: Wed, 9 Apr 2025 21:14:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: add helper rtl8125_phy_param
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The integrated PHY's of RTL8125/8126 have an own mechanism to access
PHY parameters, similar to what r8168g_phy_param does on earlier PHY
versions. Add helper rtl8125_phy_param to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 .../net/ethernet/realtek/r8169_phy_config.c   | 36 +++++++++----------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index cf95e579c..685610d7b 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -50,6 +50,15 @@ static void r8168g_phy_param(struct phy_device *phydev, u16 parm,
 	phy_restore_page(phydev, oldpage, 0);
 }
 
+static void rtl8125_phy_param(struct phy_device *phydev, u16 parm,
+			      u16 mask, u16 val)
+{
+	phy_lock_mdio_bus(phydev);
+	__phy_write_mmd(phydev, MDIO_MMD_VEND2, 0xb87c, parm);
+	__phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0xb87e, mask, val);
+	phy_unlock_mdio_bus(phydev);
+}
+
 struct phy_reg {
 	u16 reg;
 	u16 val;
@@ -1004,12 +1013,8 @@ static void rtl8125a_2_hw_phy_config(struct rtl8169_private *tp,
 	phy_write_paged(phydev, 0xac5, 0x16, 0x01ff);
 	phy_modify_paged(phydev, 0xac8, 0x15, 0x00f0, 0x0030);
 
-	phy_write(phydev, 0x1f, 0x0b87);
-	phy_write(phydev, 0x16, 0x80a2);
-	phy_write(phydev, 0x17, 0x0153);
-	phy_write(phydev, 0x16, 0x809c);
-	phy_write(phydev, 0x17, 0x0153);
-	phy_write(phydev, 0x1f, 0x0000);
+	rtl8125_phy_param(phydev, 0x80a2, 0xffff, 0x0153);
+	rtl8125_phy_param(phydev, 0x809c, 0xffff, 0x0153);
 
 	phy_write(phydev, 0x1f, 0x0a43);
 	phy_write(phydev, 0x13, 0x81B3);
@@ -1061,14 +1066,9 @@ static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
 	phy_modify_paged(phydev, 0xac4, 0x13, 0x00f0, 0x0090);
 	phy_modify_paged(phydev, 0xad3, 0x10, 0x0003, 0x0001);
 
-	phy_write(phydev, 0x1f, 0x0b87);
-	phy_write(phydev, 0x16, 0x80f5);
-	phy_write(phydev, 0x17, 0x760e);
-	phy_write(phydev, 0x16, 0x8107);
-	phy_write(phydev, 0x17, 0x360e);
-	phy_write(phydev, 0x16, 0x8551);
-	phy_modify(phydev, 0x17, 0xff00, 0x0800);
-	phy_write(phydev, 0x1f, 0x0000);
+	rtl8125_phy_param(phydev, 0x80f5, 0xffff, 0x760e);
+	rtl8125_phy_param(phydev, 0x8107, 0xffff, 0x360e);
+	rtl8125_phy_param(phydev, 0x8551, 0xff00, 0x0800);
 
 	phy_modify_paged(phydev, 0xbf0, 0x10, 0xe000, 0xa000);
 	phy_modify_paged(phydev, 0xbf4, 0x13, 0x0f00, 0x0300);
@@ -1110,12 +1110,8 @@ static void rtl8125bp_hw_phy_config(struct rtl8169_private *tp,
 
 	r8168g_phy_param(phydev, 0x8010, 0x0800, 0x0000);
 
-	phy_write(phydev, 0x1f, 0x0b87);
-	phy_write(phydev, 0x16, 0x8088);
-	phy_modify(phydev, 0x17, 0xff00, 0x9000);
-	phy_write(phydev, 0x16, 0x808f);
-	phy_modify(phydev, 0x17, 0xff00, 0x9000);
-	phy_write(phydev, 0x1f, 0x0000);
+	rtl8125_phy_param(phydev, 0x8088, 0xff00, 0x9000);
+	rtl8125_phy_param(phydev, 0x808f, 0xff00, 0x9000);
 
 	r8168g_phy_param(phydev, 0x8174, 0x2000, 0x1800);
 
-- 
2.49.0


