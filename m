Return-Path: <netdev+bounces-159059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC20A14413
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8572718836B6
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A961D1D90DF;
	Thu, 16 Jan 2025 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1vAXi6p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89391D63EB
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063523; cv=none; b=uajVCGRxjWwiSxJppvReZ+sXdn87AdQUKkGQ0FYxzUJR4/iZXNmgW4FowlJIMJOa1JDqAizaN+o88sBjUdipDSoLojUkGZGaUDp9Vj9eZm3H5o0yNou/yefbaa/+m3hm7mvDMueZTD9UnIoPqRglJ+Tv9yniVT4LnFQjD1a3ago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063523; c=relaxed/simple;
	bh=LUprR35Q0Os14OV+DWrjugaaw+Ay7yC1Muc//yvJ0io=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=nYP3ucSRvyti08UuM2YKoRG49Bap+ohf/G/TAp/GJ3Ntt/CkKpwpac9bvPKwgLD1xH0d3puNxMa5Ji65TQLXADj0HaXoiKAoRdQCEo3cc72B059aM1QzralmYpp7WTBp2V/4syLNlUrosNPfxWzX+9q4ZbXsc1j7m4AnJlNK6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1vAXi6p; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385eed29d17so822450f8f.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 13:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737063520; x=1737668320; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+1aU8NZXs25NHwqYAR9jk8iMXXeHcvpB3/Bg34P3Kc4=;
        b=Y1vAXi6p95hHjNZbufcFCF4NTFnnNGdGLOHsnOvzfVdDj89RdHiDhHkYZB/j4dQNYz
         G8kPU7hHT8YXZrxZggU8ejTTVm8MzypGGMhPfAGWmvKrDwNJRDa6BcidnD5/wP3mqHTs
         IZE3lvPa2wd4WhuqMp0A+9BVJQCajjXhaKW4uGJyhmFNy+Ai40bcfkb3OGrVXb0+nt8+
         BeHi8/UVLFJR2OIc9zCkR2b9ruu2WtrjND8f36CwHT2MJVY9tOTS9oG3yBQyKY60Zxps
         HJxfnlwsRiV8RBkEkuvW3ha2gj+1ZaDj/hJbX7kZL4Xp7gCModmXDx93i5qiwa8AZ0t4
         R4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737063520; x=1737668320;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1aU8NZXs25NHwqYAR9jk8iMXXeHcvpB3/Bg34P3Kc4=;
        b=ryaPCyVxhlhcNKe17Y5q3uAcRSweyYz8fR8NGeSPfGEvqqM8TrYYjMpKfOEXS6xJpV
         9my+aEeUmTFdndLXIUZDPmbwcJNHNVbnznT6tXtHMi66FBt03Z2Fk/rz182jD+qx5CQu
         SP08d6VtrXV1I0Nza4QLpWU/HLXFZHt73eAUEUjesAtJeVRB2NRkr0ajaw5BBZFLSNq6
         Iuwz3JV+ZCliLWUBtIp+o3yQg04/D6za0fHumFHaUf/Bz38A8WsUCkiba4zV8x0r7wNq
         kjPWG08cjG7vaRyWtXP1SPvyXGmwNVJ/zwfqg10DFctPd1AocM7K00qXMCd55GY3AwRS
         3A4w==
X-Gm-Message-State: AOJu0Yww9qe65IfTTgaJHDyLGPf5WtAN1A8KqHrvVjkUsXJkq115A/tc
	FHJb2RDuGP3+2byd2rY0FR9E7uJrEcVpzA3F3boDp6CaYqS6l0Th
X-Gm-Gg: ASbGncuFbEVSEfr/qhNVRS7IQoyNnTHmbw96PFy8eePkyCOD24BuaOo/quzhH5S3XMF
	6IWP3ZgyPLgFoCC+pVQOLi75vDzCnCgBOf/St1m3fmzC4F6+HC6aNv8FxtyunpS4BLrTPIAf3J5
	jAep/6gizagvdYwh8OpBKbyMQcpshTUAPrfF4oolcI9AdSHcXRbAlsPSe0wEVFTNrayTw/f7/bI
	IaZ5rzct+2znK5iutT3xsVLyzZI6v1fg4/XZoOZxjQftXu6Ex+HvwujL4qQMV7jBZXyfyuXjJWm
	7kPOUI2qD4ebwKFwSWbIu26HpdxYwoeLP+CCjD00AzEv04vlycZsGsvpIBqSXG+BNF4O2SdSMv/
	ZLYkbopbvDYecN5MiPG2ALs4Ar2GyaZhLfyg5Xg+LevKRjxTo
X-Google-Smtp-Source: AGHT+IHKjY4+g2EkiiE4r21Ic8BqX6iB3pI8czADLmgfgKlbx/87GqnleHrlsnIej88JZNJzphTFfA==
X-Received: by 2002:a05:6000:1a87:b0:385:fc32:1ec6 with SMTP id ffacd0b85a97d-38bf57bb947mr134676f8f.50.1737063519704;
        Thu, 16 Jan 2025 13:38:39 -0800 (PST)
Received: from ?IPV6:2a02:3100:b19d:2500:5581:de5f:8aae:777c? (dynamic-2a02-3100-b19d-2500-5581-de5f-8aae-777c.310.pool.telefonica.de. [2a02:3100:b19d:2500:5581:de5f:8aae:777c])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38bf3221bf0sm819018f8f.28.2025.01.16.13.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 13:38:38 -0800 (PST)
Message-ID: <5493b96e-88bb-4230-a911-322659ec5167@gmail.com>
Date: Thu, 16 Jan 2025 22:38:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: remove leftovers from switch to linkmode
 bitmaps
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

We have some leftovers from the switch to linkmode bitmaps which
- have never been used
- are not used any longer
- have no user outside phy_device.c
So remove them.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 54 ++----------------------------------
 include/linux/phy.h          | 18 ------------
 2 files changed, 2 insertions(+), 70 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 5b34d39d1..46713d274 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -60,15 +60,9 @@ EXPORT_SYMBOL_GPL(phy_gbit_features);
 __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_fibre_features) __ro_after_init;
 EXPORT_SYMBOL_GPL(phy_gbit_fibre_features);
 
-__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_all_ports_features) __ro_after_init;
-EXPORT_SYMBOL_GPL(phy_gbit_all_ports_features);
-
 __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_features) __ro_after_init;
 EXPORT_SYMBOL_GPL(phy_10gbit_features);
 
-__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_fec_features) __ro_after_init;
-EXPORT_SYMBOL_GPL(phy_10gbit_fec_features);
-
 const int phy_basic_ports_array[3] = {
 	ETHTOOL_LINK_MODE_Autoneg_BIT,
 	ETHTOOL_LINK_MODE_TP_BIT,
@@ -76,12 +70,7 @@ const int phy_basic_ports_array[3] = {
 };
 EXPORT_SYMBOL_GPL(phy_basic_ports_array);
 
-const int phy_fibre_port_array[1] = {
-	ETHTOOL_LINK_MODE_FIBRE_BIT,
-};
-EXPORT_SYMBOL_GPL(phy_fibre_port_array);
-
-const int phy_all_ports_features_array[7] = {
+static const int phy_all_ports_features_array[7] = {
 	ETHTOOL_LINK_MODE_Autoneg_BIT,
 	ETHTOOL_LINK_MODE_TP_BIT,
 	ETHTOOL_LINK_MODE_MII_BIT,
@@ -90,7 +79,6 @@ const int phy_all_ports_features_array[7] = {
 	ETHTOOL_LINK_MODE_BNC_BIT,
 	ETHTOOL_LINK_MODE_Backplane_BIT,
 };
-EXPORT_SYMBOL_GPL(phy_all_ports_features_array);
 
 const int phy_10_100_features_array[4] = {
 	ETHTOOL_LINK_MODE_10baseT_Half_BIT,
@@ -124,20 +112,6 @@ const int phy_10gbit_features_array[1] = {
 };
 EXPORT_SYMBOL_GPL(phy_10gbit_features_array);
 
-static const int phy_10gbit_fec_features_array[1] = {
-	ETHTOOL_LINK_MODE_10000baseR_FEC_BIT,
-};
-
-__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_full_features) __ro_after_init;
-EXPORT_SYMBOL_GPL(phy_10gbit_full_features);
-
-static const int phy_10gbit_full_features_array[] = {
-	ETHTOOL_LINK_MODE_10baseT_Full_BIT,
-	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
-	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
-	ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
-};
-
 static const int phy_eee_cap1_features_array[] = {
 	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
 	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
@@ -199,20 +173,7 @@ static void features_init(void)
 	linkmode_set_bit_array(phy_gbit_features_array,
 			       ARRAY_SIZE(phy_gbit_features_array),
 			       phy_gbit_fibre_features);
-	linkmode_set_bit_array(phy_fibre_port_array,
-			       ARRAY_SIZE(phy_fibre_port_array),
-			       phy_gbit_fibre_features);
-
-	/* 10/100 half/full + 1000 half/full + TP/MII/FIBRE/AUI/BNC/Backplane*/
-	linkmode_set_bit_array(phy_all_ports_features_array,
-			       ARRAY_SIZE(phy_all_ports_features_array),
-			       phy_gbit_all_ports_features);
-	linkmode_set_bit_array(phy_10_100_features_array,
-			       ARRAY_SIZE(phy_10_100_features_array),
-			       phy_gbit_all_ports_features);
-	linkmode_set_bit_array(phy_gbit_features_array,
-			       ARRAY_SIZE(phy_gbit_features_array),
-			       phy_gbit_all_ports_features);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phy_gbit_fibre_features);
 
 	/* 10/100 half/full + 1000 half/full + 10G full*/
 	linkmode_set_bit_array(phy_all_ports_features_array,
@@ -228,17 +189,6 @@ static void features_init(void)
 			       ARRAY_SIZE(phy_10gbit_features_array),
 			       phy_10gbit_features);
 
-	/* 10/100/1000/10G full */
-	linkmode_set_bit_array(phy_all_ports_features_array,
-			       ARRAY_SIZE(phy_all_ports_features_array),
-			       phy_10gbit_full_features);
-	linkmode_set_bit_array(phy_10gbit_full_features_array,
-			       ARRAY_SIZE(phy_10gbit_full_features_array),
-			       phy_10gbit_full_features);
-	/* 10G FEC only */
-	linkmode_set_bit_array(phy_10gbit_fec_features_array,
-			       ARRAY_SIZE(phy_10gbit_fec_features_array),
-			       phy_10gbit_fec_features);
 	linkmode_set_bit_array(phy_eee_cap1_features_array,
 			       ARRAY_SIZE(phy_eee_cap1_features_array),
 			       phy_eee_cap1_features);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index afaae74d0..559b267be 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -32,19 +32,6 @@
 #include <linux/atomic.h>
 #include <net/eee.h>
 
-#define PHY_DEFAULT_FEATURES	(SUPPORTED_Autoneg | \
-				 SUPPORTED_TP | \
-				 SUPPORTED_MII)
-
-#define PHY_10BT_FEATURES	(SUPPORTED_10baseT_Half | \
-				 SUPPORTED_10baseT_Full)
-
-#define PHY_100BT_FEATURES	(SUPPORTED_100baseT_Half | \
-				 SUPPORTED_100baseT_Full)
-
-#define PHY_1000BT_FEATURES	(SUPPORTED_1000baseT_Half | \
-				 SUPPORTED_1000baseT_Full)
-
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_t1_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_t1s_p2mp_features) __ro_after_init;
@@ -62,16 +49,11 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap2_features) __ro_after_init;
 #define PHY_BASIC_T1S_P2MP_FEATURES ((unsigned long *)&phy_basic_t1s_p2mp_features)
 #define PHY_GBIT_FEATURES ((unsigned long *)&phy_gbit_features)
 #define PHY_GBIT_FIBRE_FEATURES ((unsigned long *)&phy_gbit_fibre_features)
-#define PHY_GBIT_ALL_PORTS_FEATURES ((unsigned long *)&phy_gbit_all_ports_features)
 #define PHY_10GBIT_FEATURES ((unsigned long *)&phy_10gbit_features)
-#define PHY_10GBIT_FEC_FEATURES ((unsigned long *)&phy_10gbit_fec_features)
-#define PHY_10GBIT_FULL_FEATURES ((unsigned long *)&phy_10gbit_full_features)
 #define PHY_EEE_CAP1_FEATURES ((unsigned long *)&phy_eee_cap1_features)
 #define PHY_EEE_CAP2_FEATURES ((unsigned long *)&phy_eee_cap2_features)
 
 extern const int phy_basic_ports_array[3];
-extern const int phy_fibre_port_array[1];
-extern const int phy_all_ports_features_array[7];
 extern const int phy_10_100_features_array[4];
 extern const int phy_basic_t1_features_array[3];
 extern const int phy_basic_t1s_p2mp_features_array[2];
-- 
2.48.1




