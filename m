Return-Path: <netdev+bounces-166193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30D1A34E56
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35892188352B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA8E206F2A;
	Thu, 13 Feb 2025 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8Gy5+H5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41D0194AD5
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474325; cv=none; b=XHx/oViEf89WMWUTp3H3eMRq8RZfyESMsEsOwesvJNN8rsrH2WEvaTwKv7vnletfgjxXIyaAowDWQpkQTaOtw5JaEMKazN0HUUGYP00z1nz26R5B+e9Aa7r2UYLkClNg2dVo1uy6f3RYPtLUgjf9JiTOrtR13J9ynuNSBhRaWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474325; c=relaxed/simple;
	bh=AhzIdeUNW+hCq2NsK0teMbmcDd0av7JWUfWU+f4ZMRk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OpPC14Q/rDXuGaUIooGN07PKv89YNhR85hf0rApUBYklfWqWQftXTcsEkAMbf1hvJl6Jo0cvWmh+NL8+m4Y80AqRQMcz5gDAntBr6ygVgWCESFS4SN2OWqywydK/2FMX3FnVIRVrlaPXweCXkLz/5ceybid2jsEAhdawZ39Z/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8Gy5+H5; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7cb1154abso171507766b.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 11:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739474322; x=1740079122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aqwR/OohvPeKiJLulmHUEaUwhhaHWF7qcqQ9CtgceOQ=;
        b=D8Gy5+H5BVnAF/soSmVixgIf2EoQl7vtifTnXBk6YsUqPyg9QFeL/9z2NRFNubyZsz
         0R2DutA0xvTD6IeCfq7Au1zhfhsrcrHSNU7RKcOsDFsEHEiKWkM3qGTTOoNHLVPS6ggn
         FBWmfLam57hRcsahujdRapvXjTzJg5hC3DQgFRXG+/BuWqhOB1KN7pXbBn1hyKPE0q3B
         R7JPfDOfdhTgacYQ/h4dN1Olx2vsDcB4+iQVTZcKAbRHMR7sbcUHAtboEcTlthpcRWqI
         dD4i4WM6eKfylHr1FhBm0shaoOMRSI2z5sOQ/7vJNkS7UGpfg0ABgayCAuAhihEvaaUi
         fIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739474322; x=1740079122;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqwR/OohvPeKiJLulmHUEaUwhhaHWF7qcqQ9CtgceOQ=;
        b=gnbS5c7942+5YhBqYE5xcuIuMw2EIeiRiT0nOl60pNTUiis2jUnj4iIeaHX16PBNP0
         JSteKholWyDGL/C/bzBnLT1ksx7vKhcCW0GNyMoE7pLXvBJ5/Jfrs9mq3brv4zwCgjWC
         h7W8ongB+nDrsDRb8gJdccvnP69dVNBsmZrOiqc4AZBjsQHmt+oh9MDf4tHstebmPibe
         Zn+Ebs9pgPfWIw4pXT2OPhil3R+oK6FihkSvxUNWRQ1/0HaBxKpk0V8FE7y/FzWDD55l
         cvCBjSya83SBqN934uHXbWERBS4CWqXWsvf/3eDtWX57NdCrVYg+tAwkIQNDy11lBXgC
         2kHQ==
X-Gm-Message-State: AOJu0YyFYIyC4aAvdnDsl3L9Fgumoix9Bm6wXhjtYcTgP2F9UHQBzjRa
	JvUi5Lna7ha9mDx4t0Cdurqm+Yqzc5pnjyORklp/g8Q2E8UaNOQt
X-Gm-Gg: ASbGncvamQ1iLKuN+wSeZyefb2yEMdo4clE+QwHT+YQtomMMNI+BDeKt5BgxCMwWeWU
	7J90tJqf6gVtDpZhhbTl0Z8GoKq09BfYM0/tlkJDSGbyXhIixvGpJIeauRoAC04bjTMYhIaP1qV
	udBpBAEFzXDBy5w+CB0zqIbZZBy2Gu0q3Ab0SYtUeOzPL6HXPs2VHreQcajG024+ikjGtSF3slO
	G9IFR//t8+EKZ5M1VdJXYkvRkC+rbAfceJMY1LLqg0/OXzXyBHRBkMIu4X1NoMq7A75wPGCywc5
	L+2pK4AFvjwcoY24m+89qInt+3A2gC8H2izXnZw/wCdGGM3bV+/zwk5AC02muO5jUJYTdb46eUr
	cH7Ts5C8bfjstzJm8H/lHTfySdu5HPW2Wt52MFbCxX+DmYC3bfGoz97RW/TQ5n8OYg2X4axuPNf
	sR7RmW
X-Google-Smtp-Source: AGHT+IFX+gnlqMhT+5vTpsx9C2/2X2JyeJYFH55i/MH5TDxc/8cuoHn9ll+N+POfRn3SLRo7GG90pQ==
X-Received: by 2002:a05:6402:2553:b0:5de:3d2d:46ce with SMTP id 4fb4d7f45d1cf-5dec9e9a0e9mr9440109a12.25.1739474322087;
        Thu, 13 Feb 2025 11:18:42 -0800 (PST)
Received: from ?IPV6:2a02:3100:9dea:b00:8140:d035:b1a4:911d? (dynamic-2a02-3100-9dea-0b00-8140-d035-b1a4-911d.310.pool.telefonica.de. [2a02:3100:9dea:b00:8140:d035:b1a4:911d])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aba533bf5casm183857866b.182.2025.02.13.11.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 11:18:41 -0800 (PST)
Message-ID: <81416f95-0fac-4225-87b4-828e3738b8ed@gmail.com>
Date: Thu, 13 Feb 2025 20:19:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 net-next 3/3] net: phy: realtek: switch from paged to MMD
 ops in rtl822x functions
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c6a969ef-fd7f-48d6-8c48-4bc548831a8d@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <c6a969ef-fd7f-48d6-8c48-4bc548831a8d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The MDIO bus provided by r8169 for the internal PHY's now supports
c45 ops for the MDIO_MMD_VEND2 device. So we can switch to standard
MMD ops here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek/realtek_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 2e2c5353c..34be1d752 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -901,7 +901,7 @@ static int rtl822x_get_features(struct phy_device *phydev)
 {
 	int val;
 
-	val = phy_read_paged(phydev, 0xa61, 0x13);
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xa616);
 	if (val < 0)
 		return val;
 
@@ -922,10 +922,9 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
 	if (phydev->autoneg == AUTONEG_ENABLE) {
 		u16 adv = linkmode_adv_to_mii_10gbt_adv_t(phydev->advertising);
 
-		ret = phy_modify_paged_changed(phydev, 0xa5d, 0x12,
-					       MDIO_AN_10GBT_CTRL_ADV2_5G |
-					       MDIO_AN_10GBT_CTRL_ADV5G,
-					       adv);
+		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2, 0xa5d4,
+					     MDIO_AN_10GBT_CTRL_ADV2_5G |
+					     MDIO_AN_10GBT_CTRL_ADV5G, adv);
 		if (ret < 0)
 			return ret;
 	}
@@ -969,7 +968,7 @@ static int rtl822x_read_status(struct phy_device *phydev)
 	    !phydev->autoneg_complete)
 		return 0;
 
-	lpadv = phy_read_paged(phydev, 0xa5d, 0x13);
+	lpadv = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xa5d6);
 	if (lpadv < 0)
 		return lpadv;
 
-- 
2.48.1



