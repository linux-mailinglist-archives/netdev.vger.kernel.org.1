Return-Path: <netdev+bounces-197834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBA1AD9FBB
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 22:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0263174ED1
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6307114F9D6;
	Sat, 14 Jun 2025 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2D8pPkT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607A2E11D0
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749933111; cv=none; b=D96/Khrj1M8B7EDiSyYehmdOgKpfa6XBzvcRtPOBpW6XRDmF7i7zT+9RU5S75ss+z1Gz7nDcFkTwtKwnNAPVs4mnUivJWGrQ+DHHnjXh9wYLbuZaNlIWvyLAKianx6mQyoZBphohzmE9tS9QF4x8nZ1WlwNTuloUE1ttgjCtE5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749933111; c=relaxed/simple;
	bh=LdxyhvkZfc+69fjA40M/fIaz5YpzN/pg999aHjNJTK8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=i70tWFZ35O2U0W7hac29eVpUyKWpB4VDN5FfJhZfhv8LMcQsNPcLtdSTYjhbYYaTDV32a9tpC0Swkw2YFD7CU92Jy5FZfJElXhe9vp/FjmrZS3ASSQQiFcChzm/CostNEU7hz0AONGtK06v+PDkmBW1IUCKtZzfckh+109F8mLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2D8pPkT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-442fda876a6so28692275e9.0
        for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749933108; x=1750537908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5dm13L0EdNBUeA15CznzPVkVHzpi/pjjNiuKB0ssCWQ=;
        b=Y2D8pPkT0bhOsg3QofjtAPf+uWnbhKwI9+TDskmk3Fxzn9vTNI/KZg19qoCZCLfsVw
         apRv+IeeeHCw3idoQTxCv+C+sK8/D+vNfpADnJp+H/hRiTLyaggsJ+8O5v9RlU/FkUWI
         e9Q9LYW/B6yYZ1C50rSHsT/M8VaQeHt/mJRVOtRBThCqSFz+LC6c/hzf8TBdUuPlLiff
         x6exqelskK2xUS8SbAFRymYGBsPJg5RIIlt5LE9bkjfXGpnxrCl//tIFxDazXoxBCE0m
         p1aQTX4u4ZTcx40+I1vp/DOEZdLGa/WiZeSuW/KDAQ2OBw5q9rXPNQ+3mcDVG9bAcLW1
         QEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749933108; x=1750537908;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dm13L0EdNBUeA15CznzPVkVHzpi/pjjNiuKB0ssCWQ=;
        b=aebn7Sy7KcQ+U32ZcgpGy9OV1rnIJVfFKaVE/crSmz8S7FPIZZfj9eKNn3/coCcqw+
         GhK3pgu7M1da5b8ZiqrjdvAYcMTRT2s7IWdAS4zXwDorpwc2OCti3c8PXjgWoN/8NptI
         LXyE5z4aRsP6Hnu1UXFr+pzf0r+iYAiAUyS4d2tJq9JuDfbgn0oBfMKzwfpoepQjqlei
         l57HLl+3BX3Op7zLQDoqTtgNbSih9LDr/nSsbbDMUsgMJZ9ZTMxgoFKgSZThPDCAmmHA
         VtlbiQpEIKso+tmY/DsV/fkoB8Gi5srWhxbKNG9VxAAX9yZpzwu9L69V/ihI4CnOPfAm
         GtrA==
X-Gm-Message-State: AOJu0YzyIa2pdTS29T5dLvbU855T1uvcNkP4/ghAiBXgDx6RTdav8qMm
	nGUYrQ8dQV+KtGbc7Glc9w4c9AErL/1cVUuHaWPOiCa+8/ckh37yFZHb
X-Gm-Gg: ASbGncvMmCvmx2HTEzw8pPTVLRU/SsW7cA124mYx3v0UngEYDfyUUAZe+rm5WEZPZbK
	YM1dxlF0n9FYP5TV7srArCYPwv8eCIS84we74/wBIEhCuCpH4w/3Qczlwy8bQTGtvtBMJY4Spgb
	r/Sr57YHAwahhQka9o5rti9ZaFbtUWqVab2kvHjhJMMJNYpCNcP0Y2ACAVxKnGO3CJ8iI6W2Qkz
	ptrOETQ6ui+lLslFzXpwak2seKVhhQvlMyGOnFERSyQxBWd+CcSvQ7VyhD7ctld0n2Jurf2omzw
	M2rXxxDX8iQ94ex695sDsJutr/wT8C7/MY838y8OSbZL1LPfQRRuZkZmKaKdgJsVG/0fTKi9qq2
	m+ACP4GKGFo77IICq2P9i4IyIx76snKpCSIqUi43jaiX81gFLQDaqEESXHYQBDCLyfR8KUmWdbR
	isHxMPz/bjFcJRMQtu6r9gRIKNwg==
X-Google-Smtp-Source: AGHT+IEIJ680xnoGy8J5FQQn9usKAj+l86ZBsjsBXYpcu8Z+GutgLKCPC5QkR8quwv3MzvJx146DEA==
X-Received: by 2002:a05:600c:500d:b0:43d:47b7:b32d with SMTP id 5b1f17b1804b1-4533cabfffamr31724645e9.25.1749933107544;
        Sat, 14 Jun 2025 13:31:47 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f47:2b00:1164:b467:ea80:aea5? (p200300ea8f472b001164b467ea80aea5.dip0.t-ipconnect.de. [2003:ea:8f47:2b00:1164:b467:ea80:aea5])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4532de8f2e0sm90400855e9.8.2025.06.14.13.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jun 2025 13:31:46 -0700 (PDT)
Message-ID: <c9ac3a7d-262a-425d-9153-97fe3ca6280a@gmail.com>
Date: Sat, 14 Jun 2025 22:31:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 2/3] net: phy: improve phy_driver_is_genphy
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <5778e86e-dd54-4388-b824-6132729ad481@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5778e86e-dd54-4388-b824-6132729ad481@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use new flag phydev->is_genphy_driven to simplify this function.
Note that this includes a minor functional change:
Now this function returns true if ANY of the genphy drivers
is bound to the PHY device.

We have only one user in DSA driver mt7530, and there the
functional change doesn't matter.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- add return value description to kdoc
---
 drivers/net/phy/phy_device.c |  7 -------
 include/linux/phy.h          | 12 +++++++++++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index bbd8e3710..c132ae977 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1722,13 +1722,6 @@ static bool phy_driver_is_genphy_kind(struct phy_device *phydev,
 	return ret;
 }
 
-bool phy_driver_is_genphy(struct phy_device *phydev)
-{
-	return phy_driver_is_genphy_kind(phydev,
-					 &genphy_driver.mdiodrv.driver);
-}
-EXPORT_SYMBOL_GPL(phy_driver_is_genphy);
-
 bool phy_driver_is_genphy_10g(struct phy_device *phydev)
 {
 	return phy_driver_is_genphy_kind(phydev,
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5b02b4319..43852e711 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1293,6 +1293,17 @@ static inline bool phy_is_started(struct phy_device *phydev)
 	return phydev->state >= PHY_UP;
 }
 
+/**
+ * phy_driver_is_genphy - Convenience function to check whether PHY is driven
+ *                        by one of the generic PHY drivers
+ * @phydev: The phy_device struct
+ * Return: true if PHY is driven by one of the genphy drivers
+ */
+static inline bool phy_driver_is_genphy(struct phy_device *phydev)
+{
+	return phydev->is_genphy_driven;
+}
+
 /**
  * phy_disable_eee_mode - Don't advertise an EEE mode.
  * @phydev: The phy_device struct
@@ -2098,7 +2109,6 @@ module_exit(phy_module_exit)
 #define module_phy_driver(__phy_drivers)				\
 	phy_module_driver(__phy_drivers, ARRAY_SIZE(__phy_drivers))
 
-bool phy_driver_is_genphy(struct phy_device *phydev);
 bool phy_driver_is_genphy_10g(struct phy_device *phydev);
 
 #endif /* __PHY_H */
-- 
2.49.0



