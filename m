Return-Path: <netdev+bounces-68863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9398488E8
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 22:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8531C21400
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B3711721;
	Sat,  3 Feb 2024 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caMEHxW3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEA412B70
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706995187; cv=none; b=ujNE5oQmPahIgMNU7IlLxVwnzQnJ4TnzIBxsAg41JvDw6WxLTiCpJ+x3geD9VSWGEWIMaJ230rsLis8p7YCWBeA0I9i/WKnqRTi2Hqce+cFVNY8LYC77auPEvA+ZSr4lGPKX+RNSxRw9NHwOqj4TpK6Lk8Rwg6lqZWj/tL/Rdsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706995187; c=relaxed/simple;
	bh=BEBQFGhjHZAnhdyRYZlhkSNS4BU5nJT07grdtAGpMTg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BfQdAkHUxNbsMtfktNqrRticxSWXFQG0KpNutMClrq3WzpNqK5fsbl6QO/GiAIyDcwaaJiJ0Yewdexh8QeifkJJfsLPVmxbaDO+mo9/OoDbU6dt69Mh1Ja1Rgh8rE6J1vbksJHaZ/Y01CH7h7Pi2Pls4yzJsgwWBayAR8UO6EzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caMEHxW3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a36126ee41eso416952666b.2
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 13:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706995184; x=1707599984; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRKb5zZk5oGGoUTR5eRB3kiqRaezEe+xIWjS/l4voL0=;
        b=caMEHxW3iRrUSL3dOvTZ6I/+puH6a7XuLfJHpSrqquVf3qz1D6FqApAX2kF5Iyzy/N
         TE6MfUkPNBmm683nXEBXOr63cTl6xAv/uWuQAraUvjpKhueVbT5CA3xeNS7PgUYAfxLN
         gcHyDX8DQAa6i6UGLDyE/7CEvhF3czv0XDUHNn5NPXsX0aJqD/kjKd/rlR91975Y8A5T
         Z2ksqSH623j7oDBWROwCkkGSjSVzGhBOAUtioH17s9finJC45a3Jt8dOOy32ckFRenSO
         +fYsHsJA4Qw2mbMD0iSF5XTTNEOVkFlC8V7cTgyZwitbxWraFpBPBhri7Q/YDbWoBIqJ
         izdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706995184; x=1707599984;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRKb5zZk5oGGoUTR5eRB3kiqRaezEe+xIWjS/l4voL0=;
        b=gflg9tL5U7/v618wwoAu9+eJpvT6cuxOTGo8hK0ecmtNkvp+qOsSMXnRRIql7eculc
         VnPuZEoy885kJXNfDioiS7RNbK5TKaO6XP3FawYlLBE+t075zbXy6NPtDuUfxzfuzzlx
         uZXPu/Eu11BXnsowpvr4GfZWldEOrZHiqFqpGhLI2l3sCmIBkVKLBjU5/BjNyCLXSzMY
         hfQQBAZBnatcNg66gcw4SSD8My9s5uvhFOFyCSsACOq12cYNlra7bdFvQcmBq+ZRIOB7
         QAetlFRGr0dXcNymShwmY0/pevCtQ9f2B8Y0vWxr+AWEIBouHKdUnfJbMITR08nAILGN
         6OzA==
X-Gm-Message-State: AOJu0YzPGdSrfggA47KFw8JtO/tQ2XJLWgm6N5SS1DIQ5GezkWlhsOWC
	cDvzDTsAB9ZjEa7Zoe074SSczL1Ll7S/JTU336HTVaGPX4b+hSL7
X-Google-Smtp-Source: AGHT+IHspR0hhwKsZZ8HWhvChyOjZwI5okt36ile7t5v21XP51sBM8TTXBLO6vimdnPzjnAH4YaFUg==
X-Received: by 2002:a17:906:e48:b0:a35:7b14:dc50 with SMTP id q8-20020a1709060e4800b00a357b14dc50mr7790143eji.17.1706995183890;
        Sat, 03 Feb 2024 13:19:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW7TguANuBo95vyEDuj4uut8uhLyytw0ytS7knfmMla+bADYbQd7SwN2I+RDsszF0EF4mxWiQPa7znxzC7CvTaPXAoe3phgj83y51+9Q29K1xoS2W7rA5XybZ5u8cqRzZn7Z9KQ+VAAXibNfvWeKVXa9fQyk40MXhmjvXuvMK8FAZsgj+Mn7aKM/9Tm5w0T2k52xzfm0aPDeSLzXVSetTVvL0e6gFEj8CfV7S663amncH8YiI6eV62dwusTO+hHgMjDHVNsmWU+y6EKam5W9LXYzQ==
Received: from ?IPV6:2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac? (dynamic-2a01-0c23-bde4-a000-48dd-a4bf-88d3-e6ac.c23.pool.telefonica.de. [2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac])
        by smtp.googlemail.com with ESMTPSA id l18-20020a170906079200b00a36f1470668sm2367102ejc.151.2024.02.03.13.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 13:19:43 -0800 (PST)
Message-ID: <ca984f60-b08a-42d8-a127-13572190d155@gmail.com>
Date: Sat, 3 Feb 2024 22:19:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ariel Elior <aelior@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] bnx2x: convert EEE handling to use linkmode bitmaps
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert EEE handling to use linkmode bitmaps. This prepares for
removing the legacy bitmaps from struct ethtool_keee.
No functional change intended.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   | 45 +++++++++----------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index 5f0e1759d..0672188bc 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -2081,28 +2081,26 @@ static const char bnx2x_private_arr[BNX2X_PRI_FLAG_LEN][ETH_GSTRING_LEN] = {
 	"Storage only interface"
 };
 
-static u32 bnx2x_eee_to_adv(u32 eee_adv)
+static void bnx2x_eee_to_linkmode(unsigned long *mode, u32 eee_adv)
 {
-	u32 modes = 0;
-
+	linkmode_zero(mode);
 	if (eee_adv & SHMEM_EEE_100M_ADV)
-		modes |= ADVERTISED_100baseT_Full;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, mode);
 	if (eee_adv & SHMEM_EEE_1G_ADV)
-		modes |= ADVERTISED_1000baseT_Full;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, mode);
 	if (eee_adv & SHMEM_EEE_10G_ADV)
-		modes |= ADVERTISED_10000baseT_Full;
-
-	return modes;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, mode);
 }
 
-static u32 bnx2x_adv_to_eee(u32 modes, u32 shift)
+static u32 bnx2x_linkmode_to_eee(const unsigned long *mode, u32 shift)
 {
 	u32 eee_adv = 0;
-	if (modes & ADVERTISED_100baseT_Full)
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, mode))
 		eee_adv |= SHMEM_EEE_100M_ADV;
-	if (modes & ADVERTISED_1000baseT_Full)
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, mode))
 		eee_adv |= SHMEM_EEE_1G_ADV;
-	if (modes & ADVERTISED_10000baseT_Full)
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, mode))
 		eee_adv |= SHMEM_EEE_10G_ADV;
 
 	return eee_adv << shift;
@@ -2120,16 +2118,17 @@ static int bnx2x_get_eee(struct net_device *dev, struct ethtool_keee *edata)
 
 	eee_cfg = bp->link_vars.eee_status;
 
-	edata->supported_u32 =
-		bnx2x_eee_to_adv((eee_cfg & SHMEM_EEE_SUPPORTED_MASK) >>
-				 SHMEM_EEE_SUPPORTED_SHIFT);
+	bnx2x_eee_to_linkmode(edata->supported,
+			      (eee_cfg & SHMEM_EEE_SUPPORTED_MASK) >>
+			      SHMEM_EEE_SUPPORTED_SHIFT);
+
+	bnx2x_eee_to_linkmode(edata->advertised,
+			      (eee_cfg & SHMEM_EEE_ADV_STATUS_MASK) >>
+			      SHMEM_EEE_ADV_STATUS_SHIFT);
 
-	edata->advertised_u32 =
-		bnx2x_eee_to_adv((eee_cfg & SHMEM_EEE_ADV_STATUS_MASK) >>
-				 SHMEM_EEE_ADV_STATUS_SHIFT);
-	edata->lp_advertised_u32 =
-		bnx2x_eee_to_adv((eee_cfg & SHMEM_EEE_LP_ADV_STATUS_MASK) >>
-				 SHMEM_EEE_LP_ADV_STATUS_SHIFT);
+	bnx2x_eee_to_linkmode(edata->lp_advertised,
+			      (eee_cfg & SHMEM_EEE_LP_ADV_STATUS_MASK) >>
+			      SHMEM_EEE_LP_ADV_STATUS_SHIFT);
 
 	/* SHMEM value is in 16u units --> Convert to 1u units. */
 	edata->tx_lpi_timer = (eee_cfg & SHMEM_EEE_TIMER_MASK) << 4;
@@ -2162,8 +2161,8 @@ static int bnx2x_set_eee(struct net_device *dev, struct ethtool_keee *edata)
 		return -EOPNOTSUPP;
 	}
 
-	advertised = bnx2x_adv_to_eee(edata->advertised_u32,
-				      SHMEM_EEE_ADV_STATUS_SHIFT);
+	advertised = bnx2x_linkmode_to_eee(edata->advertised,
+					   SHMEM_EEE_ADV_STATUS_SHIFT);
 	if ((advertised != (eee_cfg & SHMEM_EEE_ADV_STATUS_MASK))) {
 		DP(BNX2X_MSG_ETHTOOL,
 		   "Direct manipulation of EEE advertisement is not supported\n");
-- 
2.43.0


