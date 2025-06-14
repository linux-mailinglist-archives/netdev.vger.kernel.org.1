Return-Path: <netdev+bounces-197835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DB3AD9FBC
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 22:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFA01897285
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2429917A30A;
	Sat, 14 Jun 2025 20:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bt1oqFyl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B72E11D0
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749933161; cv=none; b=qwZ6fv12WkrVsa+wJCoGS5JNgP3jK9xC4PArkox6MQw6ghdrc+rPCHWWlRa6gmwEjDwmcaHG4DCclKuBaxlOHXLyZJrRBVUGQ83cfku9BpvFcMzO3HsUJwdfT2K6kf95TXr9wIQ3/Y2ht/GFfmmUKA1szwWJ+rBA7sRzFtMROK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749933161; c=relaxed/simple;
	bh=DVAe6tJtZfkCjz4trtE7SxEpeR53oBbPI281IOw92fU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oSvtQdH3y0fHFGb2EoqBNk+RyleHDoyuBwpGrhiTiXa6sdCyvrjhc0esJfKtlVgl6tT9nP4bxjNAHGRSGdDWC7Hytup6et/Yzgr50WvBvzmHYu0W+5+BgrVOinuRAry4BUkME6YbhDxP5X/Dv5GCtedn6MhXhCUYy3I/sf9QN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bt1oqFyl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a3798794d3so2945612f8f.1
        for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 13:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749933156; x=1750537956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BT4XrnlytNx9PDqKICpwiL6u/rQrDL5lKnPDvfz5924=;
        b=Bt1oqFylkRwpE33V6VFR9K20x17Uw+BzYMbvsbMzU+htihgopwG59EmSs2mTUwGHAn
         ZJ25JY+DeZvSK219DinoPq+mtD0RsaXzD6VkXrb16RltjpIfcyA4z9JyXAuJMWrsXU0B
         Z/lM18YDg9h4MDQlkL36rbdnIotdS49oHJQzPCysV1DoG8VWaq4UfK77KUMl25NZVlkh
         rCKB64QEml8QIEOTXHATNrKpaudieJ4kCZSigdLmIv6CqBFS3S+zYroB8/ZWmo3EHOYC
         pgSwa+JyR1SCliCCxKzeheP6ug/pnAsajV5fC6LiKjOH3d3C/9vAokUDvpShM6nGjD6v
         668A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749933156; x=1750537956;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BT4XrnlytNx9PDqKICpwiL6u/rQrDL5lKnPDvfz5924=;
        b=PNm2oTeQxdIhaUhtwx9mgxA14VgpkSJ8dP3FEdKHZ8Akplu+Enf1glsffqTtwMtA07
         dnWkjJIs/2P0czePu9qtpfmQmB0JsjSAWGvKRTCnFJx4ckxp0ru8vu1KibuyqNRHNb0C
         O7NdKYiVIk9RXm5WKUcsEgPASWTHhFOrSiyo7oaeKlNDVB8rC8DEWEzMlUO1Xp3SVrcp
         oMpGXDsb7giQp84PragjOHNMOP5Rkgd5EB46pAVIv+9gbsHqkNJAdqp4Gg9E/5hGVZzk
         JVWPfXRCR7zhLQDBmBM0oyCgRVCp1vwdBvxyvNwyd43d3tyDCttiriNN/G3tLtxAORl9
         WMRw==
X-Gm-Message-State: AOJu0YwibOC4swpljq2nwEo9l/CsJpTwhZVkm+CFLwZSPHpD48c4Gagg
	RhuWEHkayqTjAnbVrTmsJVo/cU9ahSEA7gNr7mZPn4GNgWQRPA0xOvcp
X-Gm-Gg: ASbGncs8bcv7yjFr6GYOa2N3dkRDt1744ZwVIObA4VxVGg7s1EYU4LNDTbwDKjZwj70
	MX+nXgbBOt8OHldXOIKFXy9sSgBwBXFZMkGCTfIhJevN9gDjDv9N//T8PQAgVAvSf4Mg20IWJzC
	AnyJOOqwr4pa5X2CSwcqmHSx/aLMWKa+EwoLioSNX0B1yYqHGf2SGI2WsFAfKZUDuI9ev6BnTPV
	IoKW31srIEzFEYSbReL6tji87WK2lvuXz/AiToJqqy6u1Ct4v8A/t1gk4YzumZpA8wKVXMalHHq
	K1S05Wl5jSpOOmvDZl6HTZfjixS2snkO/4KGQQxCaCjzQDHsoh3A3iuxk6TYBPvRpacVxWtrTZM
	qQi+HKZMdcTNJqa8pV+gFExKhiReYQX79mMEgOGDxiDN9sDOeOukwrWwkKYFXabn0//csHBcvZj
	KFkhk8Iz3nCgm/xj7TPCqux62qZQ==
X-Google-Smtp-Source: AGHT+IHFMtMbnPLCoKGxitfGRDiFinIw6qIPfZeljv941FJVzKGbLFduZZ1x/Kxufe43QYis20dk8w==
X-Received: by 2002:a05:6000:188b:b0:3a4:f379:65bc with SMTP id ffacd0b85a97d-3a572e79551mr3566319f8f.40.1749933156441;
        Sat, 14 Jun 2025 13:32:36 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f47:2b00:1164:b467:ea80:aea5? (p200300ea8f472b001164b467ea80aea5.dip0.t-ipconnect.de. [2003:ea:8f47:2b00:1164:b467:ea80:aea5])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4532e244392sm91187405e9.22.2025.06.14.13.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jun 2025 13:32:36 -0700 (PDT)
Message-ID: <49b0589a-9604-4ee9-add5-28fbbbe2c2f3@gmail.com>
Date: Sat, 14 Jun 2025 22:32:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 3/3] net: phy: remove phy_driver_is_genphy_10g
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

Remove now unused function phy_driver_is_genphy_10g().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 23 -----------------------
 include/linux/phy.h          |  2 --
 2 files changed, 25 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c132ae977..e2b5d9016 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1706,29 +1706,6 @@ struct phy_device *phy_attach(struct net_device *dev, const char *bus_id,
 }
 EXPORT_SYMBOL(phy_attach);
 
-static bool phy_driver_is_genphy_kind(struct phy_device *phydev,
-				      struct device_driver *driver)
-{
-	struct device *d = &phydev->mdio.dev;
-	bool ret = false;
-
-	if (!phydev->drv)
-		return ret;
-
-	get_device(d);
-	ret = d->driver == driver;
-	put_device(d);
-
-	return ret;
-}
-
-bool phy_driver_is_genphy_10g(struct phy_device *phydev)
-{
-	return phy_driver_is_genphy_kind(phydev,
-					 &genphy_c45_driver.mdiodrv.driver);
-}
-EXPORT_SYMBOL_GPL(phy_driver_is_genphy_10g);
-
 /**
  * phy_detach - detach a PHY device from its network device
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 43852e711..2347e5ecc 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2109,6 +2109,4 @@ module_exit(phy_module_exit)
 #define module_phy_driver(__phy_drivers)				\
 	phy_module_driver(__phy_drivers, ARRAY_SIZE(__phy_drivers))
 
-bool phy_driver_is_genphy_10g(struct phy_device *phydev);
-
 #endif /* __PHY_H */
-- 
2.49.0



