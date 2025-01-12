Return-Path: <netdev+bounces-157555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BD1A0AC0E
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 23:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6643A6B76
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 22:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C27C1C07ED;
	Sun, 12 Jan 2025 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0ZjJfi5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC41A8F9B
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736719203; cv=none; b=BeGIhopaFkeb6HHCk5AKOafzKIl2hBZnKGephlMiIOLSB0zSjQ3RaPFVfJMEg8uYBTk8IJ7xfm7TDXfT2u5j+o9zntkARH2U+IRFe8MOvRHurpf2nvbPx/8VPdUO+xrVEwXSAbG4LBg1McbDa6sQioEs3w3QD4+xHhlYCs/fSaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736719203; c=relaxed/simple;
	bh=L8SmoKE8jFrrrZPTwLvd1In9ogAjYPIhsf3Il7rLU7M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OjV9vy9mTknjJIFs0KKZ1HSv2IP6kfmzZRoNhmYclB4QxAS5E0+IGIMvgyp4VqIhSg074v+onq9NbfVgA49pP4h+4z4MgNq4JRqXe03Qv/I1CclFt73m1HvaU/o+nXZx3rHTR7VVzfZWXqqszgoHb9R9dWiKSTPEh/p0mwGUtPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0ZjJfi5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43618283dedso35741195e9.3
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 14:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736719200; x=1737324000; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDXKDAq5LZVmXOpIZxUTpMwfWx2Ymw21JsHd+xI+HXQ=;
        b=N0ZjJfi5hUxERmMFLsshzbJnglnODUifylExNVEopX/3UqMNYBYvSI3SpP/LCKNZqb
         djUVxPNU4t0VDGM9/jtgfYxfPsM20uyZqUqJNHdFAa7tR+G2LHXKZFcR/BgVqPzBHiD+
         K2tt094zqHrjby1kJtRLT3xEd/1MkesAd9iVvpvJxKN5xwg/tO2+73OZdYJm1ltO9pnr
         GQ/3qMH40+KrpzXqcxPZ3AAmgAmgSZINX+jBMNa6caVChBl9zq66KsjiGEbT0B5wbctm
         YYcmygaitDLQ+irdNGTr1y7j6IV9v4owt7aE6QFvlpzld6120olHPpkE4YtH2ePPxyVX
         O7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736719200; x=1737324000;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDXKDAq5LZVmXOpIZxUTpMwfWx2Ymw21JsHd+xI+HXQ=;
        b=uxrkNNAtQKqovfQ4qF8VuXmASrIEmWIk1Fo/VJrBzH/M3mIeiTcqmHpQg3AanCUg49
         gMjUYJDT8eEgcpORXQxfDkjT4CsXVoMo2s3gUw0hFNi0Ta9YBoXmEc9kvTlzsNJToD0c
         QlyjqaUoM8Inpyb/HgsQhHBaSUBNtZqY9qyryoqHNa0nam7TiyBrhYoo5mlnGWaZ20Pq
         H4O522m89BR2SB2SzMWrCQBfq4+wgsvNeNa3aPKYkoeA21+/TSytNfu3An1ZWzoPY7ZY
         6605DBoC8G9z18MzeJDdme3l/jaCQtw3CaQ8dNbTXZ5ZvE44xSn+/HJJWUsKnL6MF9rU
         JM3A==
X-Forwarded-Encrypted: i=1; AJvYcCXTglO+2TgHLtnn+NV0L2+F6cAIxuSveQ+09AWA10eMmlXfXXE2o9s1DfLsjfX/OwWpT4Yt9so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydxh87kvu0GdUi2gHhAzCc6Cyqhn3faUHaJbU2RwooP1U250bp
	VrWHd4rUx9kaVndIvqFRkuMpbZRrHsPkpnPgidwMqNzMgKVJzX6j
X-Gm-Gg: ASbGncuB6/grtkjnvyJjILPdgS/otZfn2soFda/TKKLIo6TOpl1p0xn5rXSbzxJWWW1
	lSPiVoLLl9tvZNA3DOkk8dLVrqbkaoEIzXFxymXsmTuso8unm8x6W5kOg1G2PHl0rvvUU9T7goZ
	Y/KkXa+4kwUMg8TB+QpSz3c+p7lnr0UC8lqITMWWdPkS/5gnhuOTRC9kZ8WFcxSmWPr1W7C4eX3
	VJ0ao+S8jehaK0op/GRsiKmMBS+fRAfwQuNI6VHJCI6blghwNBmb+h2OAdiP2EV3bbJ81qS2Ln+
	5yvb2LdNIiFeQdTCVNxT53O/ggZ4pAPbuKRqzV1tP6DmJMXBqnk1XQ3eB41S98qVIXCQeulmSKK
	ZICzw227BFjuMdZ2pEdvw3lceT2wm8fK9EfgRHsldRsH7S/df
X-Google-Smtp-Source: AGHT+IEI7VwQYoWM43JfTJmk3/zfvtpTlSOmfi8yEoxWfkbJvMj/HdkAgyCU7sQrPzoPZFwpGxaLYg==
X-Received: by 2002:a05:6000:154a:b0:385:eeb9:a5bb with SMTP id ffacd0b85a97d-38a872de3femr15443254f8f.17.1736719200031;
        Sun, 12 Jan 2025 14:00:00 -0800 (PST)
Received: from ?IPV6:2a02:3100:b0d5:ab00:44ab:526d:76d3:604a? (dynamic-2a02-3100-b0d5-ab00-44ab-526d-76d3-604a.310.pool.telefonica.de. [2a02:3100:b0d5:ab00:44ab:526d:76d3:604a])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8209sm10681607f8f.70.2025.01.12.13.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 13:59:58 -0800 (PST)
Message-ID: <46521973-7738-4157-9f5e-0bb6f694acba@gmail.com>
Date: Sun, 12 Jan 2025 22:59:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net] net: ethernet: xgbe: re-add aneg to supported features in
 PHY quirks
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In 4.19, before the switch to linkmode bitmaps, PHY_GBIT_FEATURES
included feature bits for aneg and TP/MII ports.

				 SUPPORTED_TP | \
				 SUPPORTED_MII)

				 SUPPORTED_10baseT_Full)

				 SUPPORTED_100baseT_Full)

				 SUPPORTED_1000baseT_Full)

				 PHY_100BT_FEATURES | \
				 PHY_DEFAULT_FEATURES)

				 PHY_1000BT_FEATURES)

Referenced commit expanded PHY_GBIT_FEATURES, silently removing
PHY_DEFAULT_FEATURES. The removed part can be re-added by using
the new PHY_GBIT_FEATURES definition.
Not clear to me is why nobody seems to have noticed this issue.

I stumbled across this when checking what it takes to make
phy_10_100_features_array et al private to phylib.

Fixes: d0939c26c53a ("net: ethernet: xgbe: expand PHY_GBIT_FEAUTRES")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 6a716337f..268399dfc 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -923,7 +923,6 @@ static void xgbe_phy_free_phy_device(struct xgbe_prv_data *pdata)
 
 static bool xgbe_phy_finisar_phy_quirks(struct xgbe_prv_data *pdata)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
 	unsigned int phy_id = phy_data->phydev->phy_id;
 
@@ -945,14 +944,7 @@ static bool xgbe_phy_finisar_phy_quirks(struct xgbe_prv_data *pdata)
 	phy_write(phy_data->phydev, 0x04, 0x0d01);
 	phy_write(phy_data->phydev, 0x00, 0x9140);
 
-	linkmode_set_bit_array(phy_10_100_features_array,
-			       ARRAY_SIZE(phy_10_100_features_array),
-			       supported);
-	linkmode_set_bit_array(phy_gbit_features_array,
-			       ARRAY_SIZE(phy_gbit_features_array),
-			       supported);
-
-	linkmode_copy(phy_data->phydev->supported, supported);
+	linkmode_copy(phy_data->phydev->supported, PHY_GBIT_FEATURES);
 
 	phy_support_asym_pause(phy_data->phydev);
 
@@ -964,7 +956,6 @@ static bool xgbe_phy_finisar_phy_quirks(struct xgbe_prv_data *pdata)
 
 static bool xgbe_phy_belfuse_phy_quirks(struct xgbe_prv_data *pdata)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
 	struct xgbe_sfp_eeprom *sfp_eeprom = &phy_data->sfp_eeprom;
 	unsigned int phy_id = phy_data->phydev->phy_id;
@@ -1028,13 +1019,7 @@ static bool xgbe_phy_belfuse_phy_quirks(struct xgbe_prv_data *pdata)
 	reg = phy_read(phy_data->phydev, 0x00);
 	phy_write(phy_data->phydev, 0x00, reg & ~0x00800);
 
-	linkmode_set_bit_array(phy_10_100_features_array,
-			       ARRAY_SIZE(phy_10_100_features_array),
-			       supported);
-	linkmode_set_bit_array(phy_gbit_features_array,
-			       ARRAY_SIZE(phy_gbit_features_array),
-			       supported);
-	linkmode_copy(phy_data->phydev->supported, supported);
+	linkmode_copy(phy_data->phydev->supported, PHY_GBIT_FEATURES);
 	phy_support_asym_pause(phy_data->phydev);
 
 	netif_dbg(pdata, drv, pdata->netdev,
-- 
2.47.1


