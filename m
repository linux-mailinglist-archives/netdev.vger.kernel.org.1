Return-Path: <netdev+bounces-163671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE0CA2B4C6
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 356FB7A4CAB
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C2A22FF51;
	Thu,  6 Feb 2025 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1dA+n8e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5927D23C399
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879550; cv=none; b=eY1xUO3wef/ZrLESHw5hMW9RCjZWjyy/oBlZ4cYb30THvEKGBDUAccHCy9sTBDrj66tvNvK/PzcibcggcGFWIkt1cfqE4KuND2EulWign9BhxaLW1UJe5k75x4AigddhEOoX6GqBy9OMnIPkZ+qhp3RIi3NZ0AYKH7BnjZ1E7x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879550; c=relaxed/simple;
	bh=yFvLRB/1uonYJvUB3pyNx25eA6KZEsnXVeCG7KnhEYs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IdSVgyENS9Vbm+tedkdOUPi/hBYKjSn1gn00mETJn5Vml3ppIOMvl81+1IzSHcDfksJsl+jMbM/inZjSUQetbXYm+26ZXPRVpetmDhydqI1BpvbeJ9hzGSaFx5NgxeE9HmvuaGMwfpaS5AU3BS92yoi3L9wLhDSUBswytP6chhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1dA+n8e; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43626213fffso15469985e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 14:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738879546; x=1739484346; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7dqCtGhKj3MthuvB5nCkF/cPPEOW7b1Hfa03hOxjmU=;
        b=O1dA+n8esCMpcVgKi/SoZyEbDE3lO5s32EL7kkDJ+L1iigxBn/iMB88fbiWQ8dik6U
         qkeZ+oohWvvqKCE50X09yM3MvDP1d75jt/PYFUcULME37P+9n9OAUbtiPGZyY4+S/w5d
         GyoKglutrYEkIomum1a8w6o6JdidvdBq44WjGejeOXFhfrbRrSMiRPhQ3+StiHYgqOWu
         mSUT+ccI9NtANh8a/PwOqrAH+ar0njQV/GMy6WJNXhjaVK5bZYvBb41ICPL4nYnmAY0u
         qqAdXt2dzyHGqBUqDFqvyRDZUq3lazY0HVLRX1yVsjdeBrIMtZZlNg8+tqN7Hu11H1qe
         S/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738879546; x=1739484346;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7dqCtGhKj3MthuvB5nCkF/cPPEOW7b1Hfa03hOxjmU=;
        b=MBlRZBME3nAI3KW3H8JOt2WOTGbG+uRowwKY+Go31NGx3ONRMWC0w9bKvHXfMpBWhj
         v9LTKKio4Ck/dNRz9MUy+A3vvn8HSPepeyOYuM37y0/SeEK+etNlUSMeML5hcUn7DnEx
         DuxiOuCMF4iwbSC9nFuve48X8MMen+W029ekVKFCAS3FR2tsPXtCij+Lv8qiMCYgQtnW
         +EIqZIj1exZYaP5fK7BrK1q7yROx76OoXjeshgYDC2Xa8QeXEvTd4gTUWK+yjN0AptaH
         taHYNd7aGlREMvTRwjDoK8gJhsAtvTiODH2lll2B5qbRbO529mW7cbHq0Kj+ojOq+7h3
         lm2A==
X-Gm-Message-State: AOJu0YyuGsLh6AyULGO/UJGCdmwJWjvTyvAd0BSIDJSfMQ85BkgShknH
	5JCVXSI/b0GtrzZK4YFyhXfBwK58haG3rDJ6/5tg8nS6vjXWxrZ0
X-Gm-Gg: ASbGnct9E8r3ee6Qj/YgOzKjbId5958xO96iHtA5BQONVFhsyzfGK39aD8YHez2pAor
	FpBPAMjYrhgi3KLm8NXCi+KyVxkH07zGsPhW11O6AeTAYpmvZ5OqIVKall7XWU4qIQ7sxojwmBW
	Dz8YsUl49/1JlvRdBzgf4oCIVf5zOxhslD+A9RIIP5MtKGmfGDeMH76YZ01is9gSRjC6+hRfzks
	G3HzS6DQ3DaO1vRG01vXqC1KkEMvc4NGjwqFOxBdD2GLM1+thhAf16eiKEUHneyl18Iw1ybydWd
	ChV1DTxiPKS3Idp1+mb2DIK95vyfzRAhJTIO/SrN3kMC5WCLdqkSwBoMAXiZ3BGO6GbGDZTLWB+
	MLWibpOMWLsA5H1aOsxucpA3SHub0LMLKxl48zljcCLkA8MKgQsbgxQfTwmp5uoOOUK4+H9CQwV
	nkgp7S
X-Google-Smtp-Source: AGHT+IH4gkScH6vog8Eo6d8+mq9PgQqZOBWF10bLCXiT1vwOYA9VEcWv2eAd25Oac7ShDV19LL9klA==
X-Received: by 2002:a05:6000:4009:b0:38c:24f0:fc28 with SMTP id ffacd0b85a97d-38dbb20b3d7mr3424412f8f.3.1738879546367;
        Thu, 06 Feb 2025 14:05:46 -0800 (PST)
Received: from ?IPV6:2a02:3100:a4c1:b600:2cd2:4b1:d253:fccb? (dynamic-2a02-3100-a4c1-b600-2cd2-04b1-d253-fccb.310.pool.telefonica.de. [2a02:3100:a4c1:b600:2cd2:4b1:d253:fccb])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4391dcae5c7sm31504405e9.18.2025.02.06.14.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 14:05:45 -0800 (PST)
Message-ID: <b863dcf7-31e8-45a1-a284-7075da958ff0@gmail.com>
Date: Thu, 6 Feb 2025 23:06:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Claudiu Manoil <claudiu.manoil@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Simon Horman <horms@kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: gianfar: simplify init_phy()
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use phy_set_max_speed() to simplify init_phy().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 435138f46..deb35b38c 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -1647,20 +1647,11 @@ static void gfar_configure_serdes(struct net_device *dev)
  */
 static int init_phy(struct net_device *dev)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
 	struct gfar_private *priv = netdev_priv(dev);
 	phy_interface_t interface = priv->interface;
 	struct phy_device *phydev;
 	struct ethtool_keee edata;
 
-	linkmode_set_bit_array(phy_10_100_features_array,
-			       ARRAY_SIZE(phy_10_100_features_array),
-			       mask);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, mask);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_MII_BIT, mask);
-	if (priv->device_flags & FSL_GIANFAR_DEV_HAS_GIGABIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, mask);
-
 	priv->oldlink = 0;
 	priv->oldspeed = 0;
 	priv->oldduplex = -1;
@@ -1675,9 +1666,8 @@ static int init_phy(struct net_device *dev)
 	if (interface == PHY_INTERFACE_MODE_SGMII)
 		gfar_configure_serdes(dev);
 
-	/* Remove any features not supported by the controller */
-	linkmode_and(phydev->supported, phydev->supported, mask);
-	linkmode_copy(phydev->advertising, phydev->supported);
+	if (!(priv->device_flags & FSL_GIANFAR_DEV_HAS_GIGABIT))
+		phy_set_max_speed(phydev, SPEED_100);
 
 	/* Add support for flow control */
 	phy_support_asym_pause(phydev);
-- 
2.48.1


