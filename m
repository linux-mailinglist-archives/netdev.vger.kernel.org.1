Return-Path: <netdev+bounces-238137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 401AEC548A8
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 22:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30AD64E04F3
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727E628031D;
	Wed, 12 Nov 2025 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsWmcfv9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8954F21CFF7
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981577; cv=none; b=IFtl5YQEnNZW3GHqd5wwR/gm2/DhStVURk+pZHhN+8rj15kpZcdUM/giDUmSv0Vkti6XZnGYMaAP9pe1bUnYaWxxowwAkkEoTXeKwSQW5hDXmXInLKUIP2ZiaCVygy6tcNRLlaLK48A9/sqDuBiQWn/hOI5K81PCkI4vp6cqEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981577; c=relaxed/simple;
	bh=0NUZzNJ831SOSmKTwYtBymzpUuiMmfMLsWGUVbC8qK8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=K+x9Y2fHCQJV17kzN7OHTOtwXJlRZns2VSC1oGVrFk6kgz5C7UFD/E3y+IMr+doPlnCKStU3VBTideQ7/S3RSSWqln98Y0aY2myfsKKAVnR5Tg/pr96AfOxgRJ7hBGVUdRuT7v3mkXggrHtsG9ecMZhV5uvDLhIhgYeZGPYqC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsWmcfv9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47721743fd0so816215e9.2
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 13:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762981572; x=1763586372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CExdMeFTXeQXWVMXk35yOhT2Ezt8HRdUhVu0ILjAnY=;
        b=JsWmcfv9mO+HbwpFTstANBPJMDKvnjIx9vp1sSJUUQktPyVHXGUa4vybbWpiQrT59v
         lkS1TZHnw4LJ7xAieNv33fqFY6BQxnjm1XrlulD4sEEYPCfo+UbYs+EMRWBP6EU4a7Lb
         yzRI5DfcEDCY9XZ5bZwed4Zc5up6mcTfI3IxfjRZulS3Rsi3o9WHCJDab2B7nYdoZ0pk
         3BB4ZVL3jnIAFztsIwhG1OBh6GKduf4IoyI3qqTSYCj/6xUrd0Sfc2w8Yr8AL1XkZXGM
         QoIIJt+Ri2FVgM1zxh9/bYUooN3nBXUdv8aPit/NuXflWuQ4lVUO4JcBWhLsG3D9ZfGS
         Whbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981572; x=1763586372;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CExdMeFTXeQXWVMXk35yOhT2Ezt8HRdUhVu0ILjAnY=;
        b=BBaOGcI340gT4TbaWW+tqctkaSGbmL1c3rCPh41C7+b6ZgVRifnnlZdnHEnincrale
         UsdgMLamjFUVoF3tTSUN1k4A4CWZRBFyUk9KupHDmS6/UmoELB8WTy+B16oIKV/ZiErJ
         KN7GUNWssYSIs6irJ16G4fzw35CIOtyETVNPOP+Y8YuG25yfd2cqxYkeB8FigXckhm+f
         lJ5aoOuXAV1RHtGWbNNe0oQ4ZHZBG1HVS1aP8RUhnVDkVdfrSpTb/7tuZSI8V07cirZi
         k8f5bRuNu6RrG2vdM0dY4LzDHuIloeXennpnXwzM8ivjh5boHffjWsX1knhN2PgTGUfG
         4fnw==
X-Gm-Message-State: AOJu0Yz44Y5fj0MFpObv4o/nm7dh97/gB4NGjiGFmd87remarAqnXeg8
	S7bC6TJb5oDhUZtflmQpGPTfMX7pT19C+5ZWsOat3H1kyJmFT/+rF7X4
X-Gm-Gg: ASbGncuycvY0cEIVUa5+siGQJqhGv1IVQ23wyLFZk4Y8ZAu6ImmvHpZQB7beT2/AvN8
	gZUJZlir19+8YdNVh86QANZnR029q3shefQAhf8gBjIKKTYmeXnhDiaX2FWQPh4H5igWB6H/WEY
	poYNCivVkyphSnPfJzXqbOilDPk5DAtPATWjuDEZO4//V/bar+21Du9lmKXom14OeYLak+WfGNi
	wHmp0bRThjlU6ueQd8tw3K8Qi51+7Ubi0tiZM2Lyb1i6oCLwkM80jD8xhmBCmWGKrCYANbD5E1/
	z1ZbukeEz4COwarRVZqQBHFO5FM3AObNDErZOHzdIBkBHXZvmuRXWA23fKbLeD3MKac8SF0i/jd
	+Vu55mnSDdt2UTP2X5WCEqrbsaSvFvqXQTCJGgclnZxUOLiYCKYr/aERnBZDTlx8yGeobxTrJZV
	bOehzVvb+oG409Er7t/KpI5nKnxqvlWKgMGcHKrWyV/XAqkGUm2XE3k+ZmIslFXUtNvbY/0aFI2
	GJThjiOsLD3m54T7s8dNjJqxn7MdMDVO4YQhXKbjwE=
X-Google-Smtp-Source: AGHT+IEBAb6KLEu4dZTKlIdVkKZXOQ6clzSYSKmogg7ZnW7ECOMmDOHdHHo5cuDbY88fNQTruczWag==
X-Received: by 2002:a05:6000:609:b0:42b:40b5:e665 with SMTP id ffacd0b85a97d-42b4bdb080fmr4169565f8f.31.1762981571736;
        Wed, 12 Nov 2025 13:06:11 -0800 (PST)
Received: from ?IPV6:2003:ea:8f26:f700:b18b:e3d1:83c0:fb24? (p200300ea8f26f700b18be3d183c0fb24.dip0.t-ipconnect.de. [2003:ea:8f26:f700:b18b:e3d1:83c0:fb24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b32ecf522sm24811675f8f.45.2025.11.12.13.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 13:06:11 -0800 (PST)
Message-ID: <3abaa3c5-fbb9-4052-9346-6cb096a25878@gmail.com>
Date: Wed, 12 Nov 2025 22:06:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: fixed_phy: remove setting
 supported/advertised modes from fixed_phy_register
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This code was added with 34b31da486a5 ("phy: fixed_phy: Set supported
speed in phydev") 10 yrs ago. The commit message of this change
mentions a use case involving callback adjust_link of struct
dsa_switch_driver. This struct doesn't exist any longer, and in general
usage of the legacy fixed PHY has been removed from DSA with the switch
to phylink.

Note: Supported and advertised modes are now set by phy_probe() when
the fixed PHY is attached to the netdev and bound to the genphy driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 715f0356f..1ad77f542 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -19,7 +19,6 @@
 #include <linux/of.h>
 #include <linux/idr.h>
 #include <linux/netdevice.h>
-#include <linux/linkmode.h>
 
 #include "swphy.h"
 
@@ -184,29 +183,6 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 	phy->mdio.dev.of_node = np;
 	phy->is_pseudo_fixed_link = true;
 
-	switch (status->speed) {
-	case SPEED_1000:
-		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
-				 phy->supported);
-		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
-				 phy->supported);
-		fallthrough;
-	case SPEED_100:
-		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
-				 phy->supported);
-		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
-				 phy->supported);
-		fallthrough;
-	case SPEED_10:
-	default:
-		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
-				 phy->supported);
-		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
-				 phy->supported);
-	}
-
-	phy_advertise_supported(phy);
-
 	ret = phy_device_register(phy);
 	if (ret) {
 		phy_device_free(phy);
-- 
2.51.2


