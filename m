Return-Path: <netdev+bounces-184099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FFDA93531
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE94466827
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC3426FA54;
	Fri, 18 Apr 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQQrn9bE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26392686AA
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968210; cv=none; b=JBNFXjaIGD5gIirv6mi4Hy0snirLwwU1e8s3yTJd0XW4fby68M19D/xJPtDXp2vCcx4r3sxYz2MBJFB+Sr2SANgrafNI5h/oCcEFUOd1fl33ILxQKyCS3+3Ps9HQ3aXHRrx7odCcPIgDGg74HR2JH81hah//oq7GQO/lNCpJKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968210; c=relaxed/simple;
	bh=VmOQNmGrdYtF18kIa7Q5RW7YD6PCWKi21KVsL9hiF9g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EA+mqzpOEn3yxRtV4KPVU1jAddrVg1q8vy42DlCI15HXYaCj3HSNdaxZs8f63LPX242yCosQoA5qlXXiLgrxt9rwIE+DMv0NCkGlKqwg6OABIIb8x0x8am+LP+v+BT2VgBJGMhuZnxb307hG8WtsGAcu6XVBzTViNBrr9lqutWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQQrn9bE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39bf44be22fso1148501f8f.0
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744968207; x=1745573007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tjxLOlUMS4EJFDCJezhjNO7oBp3V5mnE5lt4hUMgHms=;
        b=iQQrn9bEUqgYkZrLIwOEA7K74FA7lLmBLK4VuNwi86QKHBEzzIqbVz+3kenslcJfn1
         WuZ8HCiLzS/rS0jg7FtBrf0lL0+yL8o4E8r4yxvodN4VgNeu05Gjrz1hqZHuekhCB+j0
         n9GaGC8SbCnDSPCjJ0NU8pRn/AcEUc+mqPOwTl/a1PmhdZoTWAfEhBM8pmvLo4AZcMew
         ueFSK/vRzZa/C/8LJRMIKa0vShNbJiRH1fqWPodsS7djwXGzMVsNl4UFENTUvqnW8Kay
         74dkPZryHnLS9nJxWwh8+dS3M/2MLPnuKnSd2TyKQWy7epVF4yBam5PwN4IZr868x6WN
         Dw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744968207; x=1745573007;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjxLOlUMS4EJFDCJezhjNO7oBp3V5mnE5lt4hUMgHms=;
        b=PXPiDO391O73jQDD/Eq4GIKMTzs7IQGUxci8duuw2A+wg87/TsjmwpcippJ3zjROKI
         9y4vAKISeeitmN8ulwsrgK4/ebdSHQ1W2oMKZ4BxRaKtvR/KjGV1GgyUA7VoZh8F761q
         X8qE69hfC93I6fHf8EVNJ25AAeb0I/zVpygM0kzt5zJU3usbye2iuaIzHgcjS8dvk5Mp
         iPTLMexOjhxGLr2R3dDZ0JMyff2s/oWfbqkqdSGLabEQKi2R37MdaqiuPa0JsINFc6hN
         O3VHTHvqIeaQVOLwWSk3LxodlWEKMZvJQC2CygBGYwcGahDtGJGBCzGD2cu1xgrCeWO+
         ly+Q==
X-Gm-Message-State: AOJu0YwfoJj9WoUP9Ponqu5YjyPfaUYi/nx00qPfpA6KUSuLryKXQBeQ
	yVe0JoHjI7KGIZwkdIc3EgimKhCOZkHYGwTIjV72V748a8am1Pb1
X-Gm-Gg: ASbGncvX+uPvpBxe05qSLCzSiQIBsbfF79TTjhru3tcc6umNU3dDjVHTVvmTKH/dRBw
	6g0Je9er/ZDA8O+y8tdgXjKesnnhr1rLbX+brhWUMF4g/km1xJkrTS5Z/3WnN3ylt4IxpW9YWdx
	9Ru/9ngTZ/NPRrugGbHlQLbCmuq6346Xabp5Cg95jFte6OClGXbk548D6p3g0V6fie+rAxtFWor
	bLHSIsvWujb/XEymCArUoM2sFtvec7M+NU5Zii1aESIKhvPv2/yc/5EdojpG2zNrXsKxMxnBD3u
	wGvUvFjtoyeomJI71KOOGSuiN4ZV05il3HzJxqIVjuTmDBy/CJcLSYqCgw/ZKO2rhabyLQFIFdA
	vBdZjj0LZiRea7dTgiH1n6wk3HS2wYaFlDB0jZcE4/GRLaOuSmnstVZTu3R9xP80uaAZkvTz3S+
	mD9a5QYLpcYZFu7CMEswvyGeYkpd7qEQRP9+FWiwQYN+o=
X-Google-Smtp-Source: AGHT+IE+2tWTZZwUmf56Moj57bNW26hZRIkiHQTNm+mOFqjf3w2AkcK/h6yVfaZUWsI2RedRTsm+Fw==
X-Received: by 2002:a5d:5f49:0:b0:39e:cbe3:881 with SMTP id ffacd0b85a97d-39efba246e0mr1487693f8f.12.1744968206742;
        Fri, 18 Apr 2025 02:23:26 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a14c:6800:64c1:f857:3ca4:c5c8? (dynamic-2a02-3100-a14c-6800-64c1-f857-3ca4-c5c8.310.pool.telefonica.de. [2a02:3100:a14c:6800:64c1:f857:3ca4:c5c8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39efa4235a9sm2222240f8f.13.2025.04.18.02.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 02:23:26 -0700 (PDT)
Message-ID: <0baad123-c679-4154-923f-fdc12783e900@gmail.com>
Date: Fri, 18 Apr 2025 11:24:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/3] r8169: merge chip versions 64 and 65 (RTL8125D)
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
 drivers/net/ethernet/realtek/r8169.h            | 1 -
 drivers/net/ethernet/realtek/r8169_main.c       | 4 +---
 drivers/net/ethernet/realtek/r8169_phy_config.c | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 3f7182dc8..1878c44ec 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -69,7 +69,6 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_61,
 	RTL_GIGA_MAC_VER_63,
 	RTL_GIGA_MAC_VER_64,
-	RTL_GIGA_MAC_VER_65,
 	RTL_GIGA_MAC_VER_66,
 	RTL_GIGA_MAC_VER_70,
 	RTL_GIGA_MAC_NONE,
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 58d3acf2b..cba5bf8c2 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -106,7 +106,7 @@ static const struct rtl_chip_info {
 	{ 0x7cf, 0x681,	RTL_GIGA_MAC_VER_66, "RTL8125BP", FIRMWARE_8125BP_2 },
 
 	/* 8125D family. */
-	{ 0x7cf, 0x689,	RTL_GIGA_MAC_VER_65, "RTL8125D", FIRMWARE_8125D_2 },
+	{ 0x7cf, 0x689,	RTL_GIGA_MAC_VER_64, "RTL8125D", FIRMWARE_8125D_2 },
 	{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64, "RTL8125D", FIRMWARE_8125D_1 },
 
 	/* 8125B family. */
@@ -3831,7 +3831,6 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
 		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
 		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
-		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_70] = rtl_hw_start_8126a,
 	};
@@ -3850,7 +3849,6 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_61:
 	case RTL_GIGA_MAC_VER_64:
-	case RTL_GIGA_MAC_VER_65:
 	case RTL_GIGA_MAC_VER_66:
 		for (i = 0xa00; i < 0xb00; i += 4)
 			RTL_W32(tp, i, 0);
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index 7f513086b..e3adfafa2 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1180,7 +1180,6 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
 		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
 		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
-		[RTL_GIGA_MAC_VER_65] = rtl8125d_hw_phy_config,
 		[RTL_GIGA_MAC_VER_66] = rtl8125bp_hw_phy_config,
 		[RTL_GIGA_MAC_VER_70] = rtl8126a_hw_phy_config,
 	};
-- 
2.49.0



