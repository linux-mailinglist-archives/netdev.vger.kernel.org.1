Return-Path: <netdev+bounces-136753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363FE9A2E79
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 22:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD6D1C220BA
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6B622739A;
	Thu, 17 Oct 2024 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/BO19bb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213522194BF
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196869; cv=none; b=CwWdLe88BI6siOtZua68keL5FpH+ajQjSvNiYs72r8OzP1uqWhSErKMo2SjidUcIw38bn/GlkZ8LZKsXfeQQ9UYFPjaOTyWfa3YR56wBO4F0vGzEigPvgRmIYtegwT9+J7zeIR/ExGmyUoO6N9oM9DioFpVv1S4+0HqwoGiRCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196869; c=relaxed/simple;
	bh=h+mEbdIxWNPOE5C/gvdKJoACRR53P939lqrjCpA9X1A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=IxppmpiELsnUQPT8VBhOzA0tkVauPKhxKwNiiFFoYwV4PkhNRGfiite2myt9CplCja9Dhz+y/qBUZASeMPJx6uUhF6EV0MmSeGy8jkg8CQEeTKQ6hs/YnOpqu5jeVAr7TaOP6XZ9Nryz2aujD84Uo8N8P+8GKN9hdfRzCKQmAgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/BO19bb; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a4031f69fso188322566b.0
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 13:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729196866; x=1729801666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yGIyAJqSSzyPaWg3xMiwAnX3UIWDz1sLK04n7fF2dI=;
        b=N/BO19bb3Te3rRhKWdN99kXIvIiAKshpdTN0/jFBlQ/5lYu9F4i+6mGMvEXyzU9o4v
         /juEKmYcCIZ0Ti3sS5LZ3rCz7ttVhlgm+HUjRRu8L5mIB87OU3CuQkqPy9mCMXpME6sD
         QQfn3beysYJ/klvn1mMeXZwbyBSrLZia+J12g5VM12LpiKUwXeH/DpLyhOdWHu7hbQTe
         ZvShDk2hbNB9OJSy9RXAd8Twq3HpAdBMN+UY0nJWJH2rUUEdxknm2h/wdpT30tqRHVL3
         1ZJhhtaN+7jCNoBgrK1XKdXqAgmCIOqROf1cjlM6ZSbKiFdLkmQUdFVntPNbbX6HmIyp
         4hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729196866; x=1729801666;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yGIyAJqSSzyPaWg3xMiwAnX3UIWDz1sLK04n7fF2dI=;
        b=m622gxc0wfovZOtTxJLnTL7XsPRioiH/tR/K4wmGyenqqTk5m0VwUBi0J0uR3DeAxt
         Go9MkPHCkiDspYPC4ZcZkrlcJJRKG/hx9M4lQL1rrZhbT1/2YQJoBYO4wWZ+NOVXIknK
         V6tdxJLjp7M9wrLS6VKrxljp+rz4f2D+dDrOSRcEvaXuI3c5bQmH0GPis/irL+t7gZd0
         Xx01/UxAT5G2LztX2QudYOXBbbq102T91qkMvqq65aGnZsOCho1NrY32arvZ2JML8Tuj
         6x5gp8wxgFT6XvP5HKqlMgQa82BMMnRFSCexVN5RKyU6SLvNEv83bPb3KDUrrkkaEASj
         zjwA==
X-Gm-Message-State: AOJu0YydNYLtI/xfOdLYUcFlLM6/Qz3IMtxLoedEXxgwf87A82aoHYQO
	I0Vg9hjMJ5IUv4Qv7V8oqLiYcY4POI+X6acb9RSDI+B9WlsA4fso
X-Google-Smtp-Source: AGHT+IHHrLK+5NTLntjxzvx1KUvCryM5btTSgeQpvesAu8kls/URbKJtCM6TTjmQDxSfgweMPS6xmg==
X-Received: by 2002:a17:907:2d9e:b0:a99:ffef:aec5 with SMTP id a640c23a62f3a-a9a69a80a24mr4131966b.23.1729196865938;
        Thu, 17 Oct 2024 13:27:45 -0700 (PDT)
Received: from ?IPV6:2a02:3100:b38a:4000:88d:c0e7:13bb:6384? (dynamic-2a02-3100-b38a-4000-088d-c0e7-13bb-6384.310.pool.telefonica.de. [2a02:3100:b38a:4000:88d:c0e7:13bb:6384])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9a68ae545esm9901566b.67.2024.10.17.13.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 13:27:45 -0700 (PDT)
Message-ID: <95dd5a0c-09ea-4847-94d9-b7aa3063e8ff@gmail.com>
Date: Thu, 17 Oct 2024 22:27:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: enable EEE at 2.5G per default on RTL8125B
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Register a6d/12 is shadowing register MDIO_AN_EEE_ADV2. So this line
disables advertisement of EEE at 2.5G. Latest vendor driver r8125
doesn't do this (any longer?), so this mode seems to be safe.
EEE saves quite some energy, therefore enable this mode per default.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_phy_config.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index cf29b1208..d504abba7 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -99,7 +99,6 @@ static void rtl8125a_config_eee_phy(struct phy_device *phydev)
 
 static void rtl8125b_config_eee_phy(struct phy_device *phydev)
 {
-	phy_modify_paged(phydev, 0xa6d, 0x12, 0x0001, 0x0000);
 	phy_modify_paged(phydev, 0xa6d, 0x14, 0x0010, 0x0000);
 	phy_modify_paged(phydev, 0xa42, 0x14, 0x0080, 0x0000);
 	phy_modify_paged(phydev, 0xa4a, 0x11, 0x0200, 0x0000);
-- 
2.47.0


