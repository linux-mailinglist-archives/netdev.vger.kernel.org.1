Return-Path: <netdev+bounces-68935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D747D848E55
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 15:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2CB1F2148E
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C888224D8;
	Sun,  4 Feb 2024 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEnLShm6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58C225A9
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056277; cv=none; b=YWCZue5SOuZtQVkKezC7/J7fTdzY+RRUyp/NgQ3gB/+9bRyiU+KQxG480YIO4ech6KXN3myVeVgk2+4ugh/2mk+yspSIS0I8gneAVZ+dGC4G0QvznmmYvjk1h0V8/yD/NqaTZzCa7BNOzfDGXZEii/Sn1XFwEpWxyn4V74FYwIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056277; c=relaxed/simple;
	bh=uSRBbBXgw2g/zLiWbN9UcCnN/Wn/wMObshUfQPJbpIM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=plDmiQD0S+H2bKQWSylO1ZRsdzCX3K8BZWdjdtWQFWQa5NL3AEJKTyQRByVfUf+wpDXqn9q78uz1z4lZKInVKHUD/xPvNfflQXD6tqgvjiHFXS5+HgwCwYiN7rI3yNjPs+SaueRlNhbJ85kT6ZK8LmXAwxT5LhGzkk5GVmTMB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEnLShm6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5605c7b1f32so216290a12.0
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 06:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707056274; x=1707661074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PbvwLYhjrdI0yvXPtb15yz2MZ08RSPCqysFhUlV81HQ=;
        b=kEnLShm6/H7s7UmQ3V9ksefeF1BeM0EVC56iUqWwzGjy+QiqqXz/c/zNGViYwfbDOu
         UMcPsRG/hsbrTrZh0t3cCn3Ap43uWI7V2lS7xUUcHZ9ZwT/2oNNNBqQHppm9iOyORTli
         efrJnMHv8dY21dwg5ZjkBNttZzh7j5yzgGtOSreBtY8gH5N89UU3n0Esdo7wEcsvWfuU
         NVBFu3GLT4aexCmVGVr3BXEw0xE4EPMX5Zu8ZeQrBiDM7HiTDnu9g7td6Ci3npgKA5QV
         M5B49BzZJUzY3jv0fQKtXFAI9WqNxP8TOR3v2L0+7a7ap4MmC/me0hz7HHTf6KlnKyRF
         nBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707056274; x=1707661074;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbvwLYhjrdI0yvXPtb15yz2MZ08RSPCqysFhUlV81HQ=;
        b=DSS7n1ajGFERB0jfgo+5v9eJZaDWP5aJjBjPuwl39jrn6MwWqNcMbrwAM4kE4BbH35
         QGAnmHI7r5IKeWT365l8U35ZKD78JC5ZcqvgbtJOpkGWCvCDoxBLa7lms+/hx6+EhTyS
         txgLp8k7rOv7uKY2mSVqs98gwCtFq+0Od37JbcK4MRWq89/kEf2NYbbwDbkJ55DSsAAV
         OFtQV5INZp4J1jJhB3x2XEHIPPlI/vcsJqWIUbhQojh8u+CPVSnmp9muvckvEq7EHzzy
         3HCvpRMTqVQor2Q4DrhR8I6sxXmjqBWjPXgU6tHdLiwxSjgZfWk9FOhNjyjOz9Y2or7J
         lC+w==
X-Gm-Message-State: AOJu0Yym4ROev3hMT7ps738MBRqVN2CWRp3CqDLrc8KV81zQuWqqXU47
	0RTLTpjaLjSoVy1GFFAicbAKyjzTykwK9ULAogWG0mb9v1WpsCOz
X-Google-Smtp-Source: AGHT+IHypukptWcewSHybaKC7TMmWcEguTTSvhzkyaX71c8TyiPBLLI952l6BlxrxDUKwCaIYOR0Zw==
X-Received: by 2002:a17:906:2798:b0:a37:aa3b:f58 with SMTP id j24-20020a170906279800b00a37aa3b0f58mr615882ejc.59.1707056274207;
        Sun, 04 Feb 2024 06:17:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU67ppftMs2F1cF0bG+18YSsUi+Q1K7qBxdtl3ssy6tMBJmSLcrCalP1utMMyaetvljlrxJlnVotEW6JCS9IGrOAfY5NiJMzNdwrLo6yThpAA0Uuj2UZXQRHgvWozMvz54KIGyQFNYnA7MNhNTk/oXYAwc0xHQy+HQcmLUf9XuEeDXjrvwRzjUZs3qBJDOk2cSJLxfQPVyMi6Ztkp00mon1f2U+
Received: from ?IPV6:2a01:c22:732c:d400:1402:4c43:8a0e:1a33? (dynamic-2a01-0c22-732c-d400-1402-4c43-8a0e-1a33.c22.pool.telefonica.de. [2a01:c22:732c:d400:1402:4c43:8a0e:1a33])
        by smtp.googlemail.com with ESMTPSA id p4-20020a17090628c400b00a360239f006sm3169169ejd.37.2024.02.04.06.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 06:17:53 -0800 (PST)
Message-ID: <732a70d6-4191-4aae-8862-3716b062aa9e@gmail.com>
Date: Sun, 4 Feb 2024 15:17:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/3] net: phy: realtek: use generic MDIO constants
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <31a83fd9-90ce-402a-84c7-d5c20540b730@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <31a83fd9-90ce-402a-84c7-d5c20540b730@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marek Behún <kabel@kernel.org>

Drop the ad-hoc MDIO constants used in the driver and use generic
constants instead.

Signed-off-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 894172a3e..ffc13c495 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -57,14 +57,6 @@
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
-#define RTL_SUPPORTS_5000FULL			BIT(14)
-#define RTL_SUPPORTS_2500FULL			BIT(13)
-#define RTL_SUPPORTS_10000FULL			BIT(0)
-#define RTL_ADV_2500FULL			BIT(7)
-#define RTL_LPADV_10000FULL			BIT(11)
-#define RTL_LPADV_5000FULL			BIT(6)
-#define RTL_LPADV_2500FULL			BIT(5)
-
 #define RTL9000A_GINMR				0x14
 #define RTL9000A_GINMR_LINK_STATUS		BIT(4)
 
@@ -674,11 +666,11 @@ static int rtl822x_get_features(struct phy_device *phydev)
 		return val;
 
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-			 phydev->supported, val & RTL_SUPPORTS_2500FULL);
+			 phydev->supported, val & MDIO_PMA_SPEED_2_5G);
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
-			 phydev->supported, val & RTL_SUPPORTS_5000FULL);
+			 phydev->supported, val & MDIO_PMA_SPEED_5G);
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
-			 phydev->supported, val & RTL_SUPPORTS_10000FULL);
+			 phydev->supported, val & MDIO_SPEED_10G);
 
 	return genphy_read_abilities(phydev);
 }
@@ -692,10 +684,11 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
 
 		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
 				      phydev->advertising))
-			adv2500 = RTL_ADV_2500FULL;
+			adv2500 = MDIO_AN_10GBT_CTRL_ADV2_5G;
 
 		ret = phy_modify_paged_changed(phydev, 0xa5d, 0x12,
-					       RTL_ADV_2500FULL, adv2500);
+					       MDIO_AN_10GBT_CTRL_ADV2_5G,
+					       adv2500);
 		if (ret < 0)
 			return ret;
 	}
@@ -714,11 +707,14 @@ static int rtl822x_read_status(struct phy_device *phydev)
 			return lpadv;
 
 		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
-			phydev->lp_advertising, lpadv & RTL_LPADV_10000FULL);
+				 phydev->lp_advertising,
+				 lpadv & MDIO_AN_10GBT_STAT_LP10G);
 		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
-			phydev->lp_advertising, lpadv & RTL_LPADV_5000FULL);
+				 phydev->lp_advertising,
+				 lpadv & MDIO_AN_10GBT_STAT_LP5G);
 		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-			phydev->lp_advertising, lpadv & RTL_LPADV_2500FULL);
+				 phydev->lp_advertising,
+				 lpadv & MDIO_AN_10GBT_STAT_LP2_5G);
 	}
 
 	ret = genphy_read_status(phydev);
@@ -736,7 +732,7 @@ static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 	val = phy_read(phydev, 0x13);
 	phy_write(phydev, RTL821x_PAGE_SELECT, 0);
 
-	return val >= 0 && val & RTL_SUPPORTS_2500FULL;
+	return val >= 0 && val & MDIO_PMA_SPEED_2_5G;
 }
 
 static int rtlgen_match_phy_device(struct phy_device *phydev)
-- 
2.43.0



