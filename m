Return-Path: <netdev+bounces-70106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 230EE84DA71
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 07:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF487B20B0D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 06:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F1E67C74;
	Thu,  8 Feb 2024 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWVEsHzh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67E7692EE
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375563; cv=none; b=f9aVwcd7U5YJx8gzJebtV3/AOOtv7kGCDUGYxJra/3Ru//LVu3i4diCsv8IOUbzvUw/sLYCDCJp1mxOcWoVzI5ul+34ZclimQo7img7ggcd3zbr8LNLuxrd2oPmhKsTqakMDpfmxhg9KscFngn8o2dD9DJhrgAtI9xfPOSLZDL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375563; c=relaxed/simple;
	bh=bYVSnF3HUvu8qCIbHwzG2vFbFM/mPsERdZJa87djPjU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=o+/XXWEye70QqzxkhzWzYpCKC1wqshAAa8F2uLbuRzIqUEEjBrlcRB6EvRuIpSZ95CU5t3XCTXS74F0ALZv4Vqi1W6C4VizIh3OVlDJzZsJx3WPukSFzwK08qenj17W1DkQ3pSZoFZFs3Lhnj67Ucq1UUHCplg+btl5NO0fLDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWVEsHzh; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so1874860a12.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 22:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707375560; x=1707980360; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbw2X1JlDQCupQ72FGf/9tcs421RKXSDXMCdpGVEXl4=;
        b=YWVEsHzhWn0Q4UFt2cA+9nLGIlERIEHLqv8gpW58BiHqoVO4MIoPt4xqYuJi/OlXVO
         F/hKVZu4HbTbm0GXawFUnKbu8DOXd7a5P4DvZR9RRZ+yF+qM/t/E6QeqVLXPWQW26/lk
         SQ/xwa1Y3vVdVqV0PlnNvXW8TilbNQNEIX13JfIlATgsUoPkAWrTFNrejllupkgUdRLf
         fLLGOVlPd21U+fjFgGp4woQCzvEjsGdT4Jv0yKeVAu0jBS1LFX8WrmdIP4vVqwauHbl3
         8wJiT+gvQ29hqxy5FLbJl334EouKPXwpfUvR+Brd/hWS7IDY5Ol0Np/YqldxrVQpV9ge
         olGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707375560; x=1707980360;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbw2X1JlDQCupQ72FGf/9tcs421RKXSDXMCdpGVEXl4=;
        b=NUX0Z/9ejhygbsopuhJ5GiEGzg6eo8bN37fsnh66cxliHYvFiEiQKrmr548wLXCjT7
         0T7uqg8Ta+Jpw2jJ9qmIjOGgswIm68STyoCljdVj16llPZQjlxoLYop5+iVkTGuK5nry
         q8BOpMPPFC97pd6I8N1CDTPPOlRt3o3esd+kXkXYYKP/UKdtrlQyklM9IfLNT9/phDZz
         08/rZ1V/+ThBYbqxL6TZs1m3VL7INYcimyI8lZEhAeIxzLH5mU7JiQN2cVHIq8g/YeXM
         c7UaH9ZuSH8MM3x8Qu6n2h25di6kiWdYjw57Sng3KoMG82fenf5Hc9e2R4TCxfUxUM/P
         s/ng==
X-Gm-Message-State: AOJu0YymABbTPCK/ssuyy/2ArCL5ooI0Sjr85bgevKSFtHBr7Ma1nUen
	qnVq25O3M6dqJvvjNbP7/xt+BOhsyktDuiC/CsIxA0D5TGmJg62h1ScDLIX2
X-Google-Smtp-Source: AGHT+IHZASLh2ST9sIfZ+UQi6yHyLhObXBYTzByF09LJ4/JJI32vh0mNFF/i85sZXGmurjwbeHFVZw==
X-Received: by 2002:aa7:cccf:0:b0:55f:ef66:4739 with SMTP id y15-20020aa7cccf000000b0055fef664739mr6700694edt.2.1707375559711;
        Wed, 07 Feb 2024 22:59:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXlzKYW85LedDxtRA0Mzr/zR08FZKqz0ZfHz2eJ5j+04iunQ2WJKDHvPM2BdbWLpz97Bcqgvr5P9QuOwHwgBS2wry3cUFWeex5m0zz7RZOjMGES0RyasSvzjhIBPBJ0FinQKKhUIb/o/4C124eXRpYumRvueJyKTRHd9UngUVlnHcdqChO0L6qUF8CCWeyB58WtilA=
Received: from ?IPV6:2a01:c23:c599:8500:b13d:dd8f:30c:f16d? (dynamic-2a01-0c23-c599-8500-b13d-dd8f-030c-f16d.c23.pool.telefonica.de. [2a01:c23:c599:8500:b13d:dd8f:30c:f16d])
        by smtp.googlemail.com with ESMTPSA id fi7-20020a056402550700b0056098a293cdsm495928edb.69.2024.02.07.22.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 22:59:18 -0800 (PST)
Message-ID: <422ae70f-7305-45fd-ab3e-0dd604b9fd6c@gmail.com>
Date: Thu, 8 Feb 2024 07:59:18 +0100
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
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: realtek: use generic MDIO helpers to
 simplify the code
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use generic MDIO helpers to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 962df2b83..481c79fbd 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -680,14 +680,7 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
 	int ret = 0;
 
 	if (phydev->autoneg == AUTONEG_ENABLE) {
-		u16 adv = 0;
-
-		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-				      phydev->advertising))
-			adv |= MDIO_AN_10GBT_CTRL_ADV2_5G;
-		if (linkmode_test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
-				      phydev->advertising))
-			adv |= MDIO_AN_10GBT_CTRL_ADV5G;
+		u16 adv = linkmode_adv_to_mii_10gbt_adv_t(phydev->advertising);
 
 		ret = phy_modify_paged_changed(phydev, 0xa5d, 0x12,
 					       MDIO_AN_10GBT_CTRL_ADV2_5G |
@@ -710,15 +703,8 @@ static int rtl822x_read_status(struct phy_device *phydev)
 		if (lpadv < 0)
 			return lpadv;
 
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
-				 phydev->lp_advertising,
-				 lpadv & MDIO_AN_10GBT_STAT_LP10G);
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
-				 phydev->lp_advertising,
-				 lpadv & MDIO_AN_10GBT_STAT_LP5G);
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-				 phydev->lp_advertising,
-				 lpadv & MDIO_AN_10GBT_STAT_LP2_5G);
+		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising,
+						  lpadv);
 	}
 
 	ret = genphy_read_status(phydev);
-- 
2.43.0


