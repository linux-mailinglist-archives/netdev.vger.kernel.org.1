Return-Path: <netdev+bounces-69896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEA884CEF5
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C131F28B29
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ED281AC5;
	Wed,  7 Feb 2024 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2IT9Sjc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB697F7D9
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323733; cv=none; b=ZfpBjqUU0vdbWR59+2geUAmFxUhnzwSwbELYvigpNKhhe1OBVwuCNJ25B70DCO+zVNDjEnckJ3w9aE/TRuMHyYO/k+rb435+D7aHxw7pHqE2zb5xjt2t9PUF9oo1pvkBgYpSyqBODBvZ3yN+pNFWVw8BsnIoJq7+oSiV1CjOGgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323733; c=relaxed/simple;
	bh=PrJbA3oO8MbbMOQUXtxgM/at7x5srnGdzXibJWz/14A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KCjJQ+bO33oArNeaA4ByM0/7+iw3dfnyfci3iGcoKegBS+56mXlYFvC82khoD8EmxwRU0UGutBKXhizkpBvlJfLZEXNBKHHedwogyniMax+O5Op/2GNzQwBNTwyFDa6F5Nc7SbpfgzNlOjUQOR3PI0N2r/0xoK5LDql5g4T0GuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2IT9Sjc; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so1016926e87.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707323729; x=1707928529; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEZdx+FAwLZsAl1nB8tclGQp9BGvRUkPQCvl63LN9zc=;
        b=h2IT9Sjcl+eqx8JL/T2pkZ/ZmeAQLOS17LwtehW4TSu0U9FjuWX5YBOxc54LGr0juK
         tQLAeyC5PyTs6CqvpDjID5+80VeLKzTd9oZmXIalhrIhZxDKdb6JM+bsMpPbxpykuOoh
         6fRuWn5HWvxtaZwfNI/501XIyBZCbcFbfs2tH6kOKLPu9hsG4wpZCYGnxmSiCRUxSt83
         5Roo4HQ66BaNZTjsZH9esvB+XYGnBtGjmZP0yjHxC3JBIdadhytpyn4ZaiHCVdSJ2YIO
         JTcrlfc2utEvqvxspa6zS7pRj9yt1oa6uT3M5nc531IqRx5M14eFulePufxeAsHJfB+U
         6k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707323729; x=1707928529;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEZdx+FAwLZsAl1nB8tclGQp9BGvRUkPQCvl63LN9zc=;
        b=OYPEDMO3rEgzI44syEW0LESpFp5ZsLqY3pls2e/w9SaCsxglFqjg7rPDvlK2zaKZYg
         5FdvhV1kTEgBloOqGlVdSW/jXoegjaUr+H4uEu6Nk8X1mDzzHcCJoq0ZcqJdb6HRz0P9
         2hrD+G7TdK/9J99bY52Qy3YiC0j1gs8eblZd74wohFFBAH+yhgxzToQXKtW621ClPlCT
         vmItZbPkdNjQPCJSnSb0Zh/ZrcBfYIctH0V9ShhszC7tlQ7VFELdcqLRcgcHrO/SfTZs
         2N28Zo1W4MbTCtiXJL9lLpTBX/7qmShOyKWAA0+KqAAFE76taH6kzaWav7JixVSp19yZ
         ezRQ==
X-Gm-Message-State: AOJu0Yxwng9mJ9/UX0vCLB2weGJ6eY7siXP/xxbYA8hiMq9S2O7xfExL
	LeMr5VUtrDJnQ/9U+XZhzlCsK8TyNurTSGyC+2Am/2oa8/Y3z3zPZhpeXPCa
X-Google-Smtp-Source: AGHT+IEqFOkrGXs8AGqvUmc7QRKWWdW6i7G5B7TLdVoJOnmTMPr+jB9nWCuPjVzN7znD/G2JPnTYuA==
X-Received: by 2002:ac2:5199:0:b0:511:628b:e892 with SMTP id u25-20020ac25199000000b00511628be892mr2882125lfi.18.1707323729218;
        Wed, 07 Feb 2024 08:35:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNWvDdbG7jQbgtDCIpzBO6Fg22XFNUWtZGPx96KdioeRxgoKYfLrSd7pmobGD5jMeX2xg4q4430oTJL3/ZDdrWgpDRPqgaVMyVQB9NrMw2qTroilPhpmuBcafjOUHRbRnW7vlwQ6Q2t+GSpo7qYUrU1eDaOD0yicJLlgX5oQQ7REwuJQpz2mCn2wO8G8qtyViFy4IdRpeLG09sTVN9+cXr3HLaUxhRI1lMlyOwTcWQUr7yhie0KJlZax6xDCJHPDNZVnuyvU4SMQaOUFinGLzcwg==
Received: from ?IPV6:2a01:c22:76b1:9500:5d1b:fc9d:6dc2:24a? (dynamic-2a01-0c22-76b1-9500-5d1b-fc9d-6dc2-024a.c22.pool.telefonica.de. [2a01:c22:76b1:9500:5d1b:fc9d:6dc2:24a])
        by smtp.googlemail.com with ESMTPSA id m8-20020a1709066d0800b00a3785efe1c4sm922759ejr.85.2024.02.07.08.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 08:35:28 -0800 (PST)
Message-ID: <948562fb-c5d8-4912-8b88-bec56238732a@gmail.com>
Date: Wed, 7 Feb 2024 17:35:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ariel Elior <aelior@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] bnx2x: convert EEE handling to use linkmode
 bitmaps
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert EEE handling to use linkmode bitmaps. This prepares for
removing the legacy bitmaps from struct ethtool_keee.
No functional change intended.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- remove not needed linkmode_zero in bnx2x_eee_to_linkmode()
---
 .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   | 44 +++++++++----------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index 5f0e1759d..58956ed8f 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -2081,28 +2081,25 @@ static const char bnx2x_private_arr[BNX2X_PRI_FLAG_LEN][ETH_GSTRING_LEN] = {
 	"Storage only interface"
 };
 
-static u32 bnx2x_eee_to_adv(u32 eee_adv)
+static void bnx2x_eee_to_linkmode(unsigned long *mode, u32 eee_adv)
 {
-	u32 modes = 0;
-
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
@@ -2120,16 +2117,17 @@ static int bnx2x_get_eee(struct net_device *dev, struct ethtool_keee *edata)
 
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
@@ -2162,8 +2160,8 @@ static int bnx2x_set_eee(struct net_device *dev, struct ethtool_keee *edata)
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


