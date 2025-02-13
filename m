Return-Path: <netdev+bounces-166215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF53A350A9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 22:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075541890AB2
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 21:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB25266B6F;
	Thu, 13 Feb 2025 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhT1pb35"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF637266B56
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483261; cv=none; b=RVKwRy2S7Fl/VwIjLdTxL7nyrF50Dye28zkvzDik0yqOAFfOwijV9tdiU0qEENrWgAPY1L40DuH5j/Zd39rRJpRTpsUIj7PLmhS4KpJSmLFoTO7iYK1trkDyIUfBzbrxnDtGbW08VVpZ20te8ptdAqSRo+uhslQgugquLXa/fOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483261; c=relaxed/simple;
	bh=qCy/zeVK+Vn2rYCsJAmHxHwRS8c1cPaQhAdIq3bc9GM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Uxy2eZTSgExY30YB5oF+qPQI7EhaDnpGDDZtoZsHGLZrxLyJqpSPY3GXLxRwNN56HC7CWPicdYW5lI5pWtEJ8264+n0crC6fhoAUVyJhOXldGGm5hz0zH5Q+yxtonBO1l3GNbTvwwfF0V9cM/Opi3uUsq3Ess47k+Y8LcVsLgpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhT1pb35; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7430e27b2so268017266b.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739483258; x=1740088058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nsRUNpZelBUeNKSkVVeXwIAud8NRa7C1JYATsJZ3bO8=;
        b=XhT1pb35CiQUL+rjt0nBh3aSCg1wVC4YtEyRapATDBzhSE/GYmZ4DNEv10ybvfVGwh
         WDittPKr56QU1rU89REz9gpskjZYEKYbJRGwoa3BfzR9FiebEq7PyDAfU9NmxNzzSL+J
         vmZBv0gnpUdFTUKv4Qp2oVqi9PeyYWMMSllU/KNGFNYm+1wi3EpIieCDwLbWBdURyrp1
         +qldzyNQ4u4rGLZ+1zlRmKMNy4QiFSjkBiTu9Nn04RzEYhTcjJIF9M0Jif7bStSMsXem
         VIe4u/evQ4rdYJLIdHYw3lZPI5nljdtEwN1qLTAXh+w5Std2iYFfM3AZfMYMWx50l5rB
         X9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739483258; x=1740088058;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsRUNpZelBUeNKSkVVeXwIAud8NRa7C1JYATsJZ3bO8=;
        b=wwi4WxSGv4g63qT2xXmOXbm8n+mYQ5YijQovuI8aHNlDOoWmiTnGNq1iLhIL3BV36D
         mDRAiP4P7l/68Ba3WHKw061psrKDaHdndaXVbrPYZ5r3YR9XGxpq99oKDrDBdC5UIJMA
         GOWt+I8dEqMKL8ezUZCXWREU/eHnWArDpFf+9HNrsYGWFEDGLY5dTfoVLestm+9LahIh
         3t/MFoI/nCW8M/wB/8NjeNUdtb/f83a3MXGpgoQR7TPflU0nAOc3ngaMOFMsYQXwmvhs
         hVh33mZg9/a4RooY68KrSGcQiuRmofeFp3+77gb/pPyoGrTZjt/QYTgyFkMs5C/OW1VR
         mtNQ==
X-Gm-Message-State: AOJu0YzSvezI39oX6I56oJRHlgXwzPU8a3zviW4vKtyp2SVTLhEl5GOs
	DgWn8LaUxHHLxtR9AGd3xhp5uht+eX+GwUcs2FZR6MlBz/ltzB43
X-Gm-Gg: ASbGncvpnXWWZxoVi5dEnbLgeB2qVBoyrL4u+2yJbM12T/Kg0JYw5dlRUJ4od0MgebY
	iYwVMs5DZ8b7WVMRA1qh53/kIsby7070km1jJ8/zQpf76A618uyjdqkdQusapLqVjO6jI0rcnfj
	L69tkHD97Hb40wrlFTcP0UXdtIYQZU3KYjJyDFdsntYFrMLptuvVdPA7FqaNZYnLjQQyIK96aeS
	j5s/+orH65p4n8RZjlzsGcDS1MJR3pkZFq8zeJMqujJqcW/NqWjCYGU3h3wYTV9lnw3gmuSrav9
	mkwnp+u326oT96Bw6DSHOsNdqxFHoZU3PUe8//wZJPBxcna3Wn1IeMjrPPQIvA2Y3dlfosjsBYZ
	5cmdWVJwUJk1xlJfRdqT5+Gcvh86lcS46rT2/56srmi9OC1T9i9dZv5BdT0f6L7lu8HU5BI0V8Z
	17mmHt
X-Google-Smtp-Source: AGHT+IG0KsIPpkDJPAMdMtuheNKfKPfm8yLU59gDTTh3zQeGlcWV7g50PQeEj7vmBeiydd+sQ/0w9A==
X-Received: by 2002:a17:907:1909:b0:ab3:85f2:ff67 with SMTP id a640c23a62f3a-ab7f339c7f8mr1026388566b.16.1739483257800;
        Thu, 13 Feb 2025 13:47:37 -0800 (PST)
Received: from ?IPV6:2a02:3100:9dea:b00:8140:d035:b1a4:911d? (dynamic-2a02-3100-9dea-0b00-8140-d035-b1a4-911d.310.pool.telefonica.de. [2a02:3100:9dea:b00:8140:d035:b1a4:911d])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aba53231fe0sm205160466b.4.2025.02.13.13.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 13:47:37 -0800 (PST)
Message-ID: <ea6fde13-9183-4c7c-8434-6c0eb64fc72c@gmail.com>
Date: Thu, 13 Feb 2025 22:48:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/4] net: phy: remove fixup-related definitions from
 phy.h which are not used outside phylib
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Certain fixup-related definitions aren't used outside phy_device.c.
So make them private and remove them from phy.h.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 16 +++++++++++++---
 include/linux/phy.h          | 14 --------------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 9b06ba92f..14c312ad2 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -45,6 +45,17 @@ MODULE_DESCRIPTION("PHY library");
 MODULE_AUTHOR("Andy Fleming");
 MODULE_LICENSE("GPL");
 
+#define	PHY_ANY_ID	"MATCH ANY PHY"
+#define	PHY_ANY_UID	0xffffffff
+
+struct phy_fixup {
+	struct list_head list;
+	char bus_id[MII_BUS_ID_SIZE + 3];
+	u32 phy_uid;
+	u32 phy_uid_mask;
+	int (*run)(struct phy_device *phydev);
+};
+
 __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_features) __ro_after_init;
 EXPORT_SYMBOL_GPL(phy_basic_features);
 
@@ -378,8 +389,8 @@ static SIMPLE_DEV_PM_OPS(mdio_bus_phy_pm_ops, mdio_bus_phy_suspend,
  *	comparison
  * @run: The actual code to be run when a matching PHY is found
  */
-int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
-		       int (*run)(struct phy_device *))
+static int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
+			      int (*run)(struct phy_device *))
 {
 	struct phy_fixup *fixup = kzalloc(sizeof(*fixup), GFP_KERNEL);
 
@@ -397,7 +408,6 @@ int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
 
 	return 0;
 }
-EXPORT_SYMBOL(phy_register_fixup);
 
 /* Registers a fixup to be run on any PHY with the UID in phy_uid */
 int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 29df4c602..96e427c2c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1277,9 +1277,6 @@ struct phy_driver {
 #define to_phy_driver(d) container_of_const(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
 
-#define PHY_ANY_ID "MATCH ANY PHY"
-#define PHY_ANY_UID 0xffffffff
-
 #define PHY_ID_MATCH_EXACT(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 0)
 #define PHY_ID_MATCH_MODEL(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 4)
 #define PHY_ID_MATCH_VENDOR(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 10)
@@ -1312,15 +1309,6 @@ static inline bool phydev_id_compare(struct phy_device *phydev, u32 id)
 	return phy_id_compare(id, phydev->phy_id, phydev->drv->phy_id_mask);
 }
 
-/* A Structure for boards to register fixups with the PHY Lib */
-struct phy_fixup {
-	struct list_head list;
-	char bus_id[MII_BUS_ID_SIZE + 3];
-	u32 phy_uid;
-	u32 phy_uid_mask;
-	int (*run)(struct phy_device *phydev);
-};
-
 const char *phy_speed_to_str(int speed);
 const char *phy_duplex_to_str(unsigned int duplex);
 const char *phy_rate_matching_to_str(int rate_matching);
@@ -2117,8 +2105,6 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 void phy_resolve_pause(unsigned long *local_adv, unsigned long *partner_adv,
 		       bool *tx_pause, bool *rx_pause);
 
-int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
-		       int (*run)(struct phy_device *));
 int phy_register_fixup_for_id(const char *bus_id,
 			      int (*run)(struct phy_device *));
 int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
-- 
2.48.1



