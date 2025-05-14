Return-Path: <netdev+bounces-190523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFB4AB74D2
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 20:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB821896208
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 18:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3817C289E06;
	Wed, 14 May 2025 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHih4/pC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F627CCE7
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248850; cv=none; b=NvAsFnX7WreDOxBhXVLXQMzi9+YU6VEGraVVVBrAZgQwIf6ZsWVFk9/C94pOllAocgIic256BCHsZUmsHNPi3ZnCqZeHV2sXFwqriN+ujtkuNpWb8lS0Xg6vXuIURh6yvzhc95LSyMuyfVgWE2I5bzJSV8EpBoKxpZQM9+fQFRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248850; c=relaxed/simple;
	bh=Cu2Dinh1RpFrfKofn98dPOWt4yRkfr69KIoxOhMwGCY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ofyycJKyEIUXQFGuXyEVdt8gvNfKqbvHh42ZVwRMm0feCdSetqXlIhmuCtfXyMpXZDayLb/Gr6cladX7BqFpBYUE0I+usKDkD8UP+ep7ZhCmTTnPhyhud2kNql0CAo4vSjRaG74E0HpEByqHKwNf4GcZ7zwhhxsbUVhnQ/kAZ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHih4/pC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-440685d6afcso1738755e9.0
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747248846; x=1747853646; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJqmIONr9/cQxaLt/hlj/67b5cB5S66OWh9LIeD1Tnw=;
        b=WHih4/pCICGVLPrSZCyY5BDKs9rtfyQWikMwlUyrCODIQqWrwjqGBtqZixd6TauOy0
         Vsjsl4BhH3vQGAFPj5vw0ATqG/W3hu0PiK/4XghT9ho74DPgyemue8sUGmrBUqKv+ZqX
         cI6NdGah+3tO1bSb1YVKhjUH5JJG4le/bx1WpKHIL0wt8lmms6q3mpM50irhox5ZUzhr
         zrNe2Ek1KJjHMh6X77wXG3TO5pJod4liORoS7a5SA8qw/bjOtLtje/WLZuOceF8noyiT
         y60H2Vlpjgu67Vks/VR5zuOVJK+K8mXJeR+jK2D1pdeAvd80A4lxX15FXK2IWMeBohCH
         N3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747248846; x=1747853646;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJqmIONr9/cQxaLt/hlj/67b5cB5S66OWh9LIeD1Tnw=;
        b=jkHmlis9S/G1AovV1NDYgyNoAvCPfc3LWTr2koUdM+UMXyJv6LvlpZzYJyNdNwKRUL
         SGgy/BXN3QRXTV13Y/4FMkqjnnW9rsmNKa56EAypOFD/c74OuA+DDs9yg+ZlWy/6DSqP
         b6ed/vFzoQFSPU5KV3UO5hIEjgEQJHzqwQUk3rno41iMMfeGd1sIa+nO+dStkwh09VU1
         3BwO9XdFykCLttZnPLsNtBCHOAVcK26JmoLJ7TLeJ1xGcgTcnzx774dol31X9ZjvIKU1
         pMA6YMV2W/Yr8n+0HvNN+rprmsjs7IoQ/SmdOGO95/xaYcHg/DHzbKEDmI/eWsMqrNpL
         kxNA==
X-Gm-Message-State: AOJu0YwVRTjG9IYVSvDMnD7MnVcGEDabaN+Px+g+rG0v8UiNcoc/bH5R
	U523q2dNeU6eDEAwWXWimC5+/Unl1QTPiJ56yY3XkFjFB+ZMXBrg
X-Gm-Gg: ASbGncsuiSBl+DkNGlYrIdi2o7/nSpeAeJR3C3xK+LL6RnqfAsHmcuS23hMPXSLWj4D
	hV7MC86NmT4MvPDOnw/D/mLJkOploiMHyNJS+NSAwgeClhnRlZhHDImyTunDmKCToPgv/LPIoOJ
	gssOrbzHH0LkBa1pQx5jUc0adZk8Of1dV3TPOjpt7jfGyODHbFhVj66Flk9hrX7vToTCXbSJ+Ys
	vIaC5BG7HF7Yc1V1kh+/OVE+lZpsmlEWBdRiN2s7YdIBXOYbAjmllzX98qu/KiLlsO5z6xhY9Kv
	4L+S3D0WMJBAcLjjdctLBrj+1NOjflhHNpJH7j89scs+Et6J0kVGWmYYAgdY40OPqrhkOHxayNV
	BJDY20ojKcJQfFx8qJHmLh9FBlHO39Q+CxH27Rp4uUEbzK1La/BrdUnRk1B10ll2kvqhjz3VELh
	dcm/4WrRrC3exiRS8=
X-Google-Smtp-Source: AGHT+IGilU7HiEENh+jjo+NMofedSUHnQVoNvRzyUqxCvvGNh+7Zyn74j8LLuIHmSAa52mse5py5eQ==
X-Received: by 2002:a05:600c:1385:b0:442:cd03:3e2 with SMTP id 5b1f17b1804b1-442f20b9acamr37548015e9.2.1747248846222;
        Wed, 14 May 2025 11:54:06 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f20:7d00:ad50:3d0d:83ac:8586? (p200300ea8f207d00ad503d0d83ac8586.dip0.t-ipconnect.de. [2003:ea:8f20:7d00:ad50:3d0d:83ac:8586])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f3951adcsm41348835e9.19.2025.05.14.11.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 11:54:05 -0700 (PDT)
Message-ID: <ccbeef28-65ae-4e28-b1db-816c44338dee@gmail.com>
Date: Wed, 14 May 2025 20:54:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: fixed_phy: remove
 fixed_phy_register_with_gpiod
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since its introduction 6 yrs ago this functions has never had a user.
So remove it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 32 +++++++-------------------------
 include/linux/phy_fixed.h   | 14 --------------
 2 files changed, 7 insertions(+), 39 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index ee7831a98..c91adf246 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -223,12 +223,12 @@ static struct gpio_desc *fixed_phy_get_gpiod(struct device_node *np)
 }
 #endif
 
-static struct phy_device *__fixed_phy_register(unsigned int irq,
-					       struct fixed_phy_status *status,
-					       struct device_node *np,
-					       struct gpio_desc *gpiod)
+struct phy_device *fixed_phy_register(unsigned int irq,
+				      struct fixed_phy_status *status,
+				      struct device_node *np)
 {
 	struct fixed_mdio_bus *fmb = &platform_fmb;
+	struct gpio_desc *gpiod;
 	struct phy_device *phy;
 	int phy_addr;
 	int ret;
@@ -237,11 +237,9 @@ static struct phy_device *__fixed_phy_register(unsigned int irq,
 		return ERR_PTR(-EPROBE_DEFER);
 
 	/* Check if we have a GPIO associated with this fixed phy */
-	if (!gpiod) {
-		gpiod = fixed_phy_get_gpiod(np);
-		if (IS_ERR(gpiod))
-			return ERR_CAST(gpiod);
-	}
+	gpiod = fixed_phy_get_gpiod(np);
+	if (IS_ERR(gpiod))
+		return ERR_CAST(gpiod);
 
 	/* Get the next available PHY address, up to PHY_MAX_ADDR */
 	phy_addr = ida_alloc_max(&phy_fixed_ida, PHY_MAX_ADDR - 1, GFP_KERNEL);
@@ -306,24 +304,8 @@ static struct phy_device *__fixed_phy_register(unsigned int irq,
 
 	return phy;
 }
-
-struct phy_device *fixed_phy_register(unsigned int irq,
-				      struct fixed_phy_status *status,
-				      struct device_node *np)
-{
-	return __fixed_phy_register(irq, status, np, NULL);
-}
 EXPORT_SYMBOL_GPL(fixed_phy_register);
 
-struct phy_device *
-fixed_phy_register_with_gpiod(unsigned int irq,
-			      struct fixed_phy_status *status,
-			      struct gpio_desc *gpiod)
-{
-	return __fixed_phy_register(irq, status, NULL, gpiod);
-}
-EXPORT_SYMBOL_GPL(fixed_phy_register_with_gpiod);
-
 void fixed_phy_unregister(struct phy_device *phy)
 {
 	phy_device_remove(phy);
diff --git a/include/linux/phy_fixed.h b/include/linux/phy_fixed.h
index 1acafd86a..3392c09b5 100644
--- a/include/linux/phy_fixed.h
+++ b/include/linux/phy_fixed.h
@@ -13,7 +13,6 @@ struct fixed_phy_status {
 };
 
 struct device_node;
-struct gpio_desc;
 struct net_device;
 
 #if IS_ENABLED(CONFIG_FIXED_PHY)
@@ -24,11 +23,6 @@ extern struct phy_device *fixed_phy_register(unsigned int irq,
 					     struct fixed_phy_status *status,
 					     struct device_node *np);
 
-extern struct phy_device *
-fixed_phy_register_with_gpiod(unsigned int irq,
-			      struct fixed_phy_status *status,
-			      struct gpio_desc *gpiod);
-
 extern void fixed_phy_unregister(struct phy_device *phydev);
 extern int fixed_phy_set_link_update(struct phy_device *phydev,
 			int (*link_update)(struct net_device *,
@@ -46,14 +40,6 @@ static inline struct phy_device *fixed_phy_register(unsigned int irq,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct phy_device *
-fixed_phy_register_with_gpiod(unsigned int irq,
-			      struct fixed_phy_status *status,
-			      struct gpio_desc *gpiod)
-{
-	return ERR_PTR(-ENODEV);
-}
-
 static inline void fixed_phy_unregister(struct phy_device *phydev)
 {
 }
-- 
2.49.0


