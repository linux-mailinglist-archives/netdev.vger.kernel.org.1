Return-Path: <netdev+bounces-68936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A433A848E56
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 15:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31DC282BCF
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4B3224EE;
	Sun,  4 Feb 2024 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3eS+Z/w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A501225A9
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056334; cv=none; b=KSlk++N4CKE9XhmDtKBFKCFN7TRri3OK79AMiGNcs6Z7udMrctwC0WDEKq8i1nBmJdl7MWHluJjNG+FKsEBP5YQ5qHVG3OLU5BHdwvBFBsXfnl7XX70thdePGjdNSNm/Vs1RjmfhOsVJAgUqTs/3RI5nDQ5nHFDn/iBNJKymMLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056334; c=relaxed/simple;
	bh=doi60xI+bJ+zmbsV8UOgVRYDmDghZDJgAZWlUYqb0IQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EI77SXjmvXJJ14+6MBvqyK/3oCYQHoVQY+8jfQWKzder2yGxezdbdVGAf924CQXnmh536YiOZOpSwcuUt3ipYpkGBzmTnABTLtY3bgN0u4w7YrgnhNSpD/17d/9iJUpNkzXL9ZEqEPXX1UHMsWkh2WYrXrWudFvkyEOdDNSLxj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3eS+Z/w; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a370e63835cso240846266b.1
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 06:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707056331; x=1707661131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1kdV138DDyGe2v8ledVbXo/CGQ4rrm51zNXTKWKfduE=;
        b=E3eS+Z/wr7nr3CNVLu/IV1HFz1nrxlQWopNmExn3jRz4l1nQ9Q2j98Nju2y2XCCrzI
         eyt5WOIFxRNMZyv3633G2QfKRaCVwL02pxz6bNJbVuLaFJLvXWH79ptY6nuR7dz94jbL
         8rZCnWXX5XdAJ1qDCx6Hy7r1OOHobuz516PpgzVutCEblojec+k9LXAMz6PYVSmlA1F9
         m9G+DK8WgP/mivGWRCjx/xxCii7XCbFKhfKuUOnWoGmMoakCBsDhxIGKj/7VceYj+Qq5
         wZkwyKiKwYj/bWBCVfmaJ8P+ikKq8xBmT+igORCfih/AM/dDW7FGqvIkKPaepE/QnlMr
         OkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707056331; x=1707661131;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kdV138DDyGe2v8ledVbXo/CGQ4rrm51zNXTKWKfduE=;
        b=e8p/KI5cflwdWwuFo3FBbk2bJf+14ndOXZ2JdVs6NVq1I7LXh4gGMkAHTrRcDdUN9o
         87dJjp8GyNRzi7XSYPEGDyXM9qZV+kfD9ycCu4Qzv151qsiWo1H7jr53Gi4zCs+oh5mJ
         GjHOPoMZRRHUf/jrNKRLrR79OLQgP6GhHMDXtq2egi4pit5SM7mSheOirF5DHoGrM+UP
         xMMxFtrVaXQGVxB/LJrjLip9QePM/suqoDQp23YznTb3xMvjTfZzpVPIXYUb/sdtlKOH
         YAd/QMju/JzyW6QeA4vCvZF7yAQu+1YJHe8Lt5T0CIC7lcCpsxqayk/LIiK2AV1XlmfB
         imhg==
X-Gm-Message-State: AOJu0YzgSJhQ1pdsu9x7mJg5mFoxoRUFJ3A8VKH4ljEOj0kueaTi0KPe
	liEFfl6BwOPTtwx/TkB3GXUFXglbeBXyRFQ81aJ65ilGfs5xHWDk
X-Google-Smtp-Source: AGHT+IEaq4LjSjR5JQDFnWZDJa4c5C2tHvHHeh3Z54qeVa3SQSRNW+jyiiVDGbS4r264gyyxicjDuQ==
X-Received: by 2002:a17:906:3297:b0:a37:5020:a24b with SMTP id 23-20020a170906329700b00a375020a24bmr2395712ejw.71.1707056330603;
        Sun, 04 Feb 2024 06:18:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW3Ot6WO5jqNOwpria9CmkRk6tg8Yp5YiHhgR9ELBOHiCuAPFfs1NAx72tULMmWPiVn0oVvJNdLU9msCq/PMK0G3xOAt21Me3kd+lxrN/TnCXhbYOGMsW0zeHD7P7bSmVJnCU1454ZV4TAaHNmY4yNW1TbfF8Z4wzqutj7z6QdLFpBAzMIxe3GTbj24QYwtc1pWpWPWyBV/1PdCJL01q2YimV2B
Received: from ?IPV6:2a01:c22:732c:d400:1402:4c43:8a0e:1a33? (dynamic-2a01-0c22-732c-d400-1402-4c43-8a0e-1a33.c22.pool.telefonica.de. [2a01:c22:732c:d400:1402:4c43:8a0e:1a33])
        by smtp.googlemail.com with ESMTPSA id p4-20020a17090628c400b00a360239f006sm3169169ejd.37.2024.02.04.06.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 06:18:50 -0800 (PST)
Message-ID: <5644ab50-e3e9-477c-96db-05cd5bdc2563@gmail.com>
Date: Sun, 4 Feb 2024 15:18:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/3] net: phy: realtek: add 5Gbps support to
 rtl822x_config_aneg()
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
Content-Transfer-Encoding: 7bit

RTL8126 as an evolution of RTL8125 supports 5Gbps. rtl822x_config_aneg()
is used by the PHY driver for the integrated PHY, therefore add 5Gbps
support to it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index ffc13c495..06f6672a4 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -680,15 +680,19 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
 	int ret = 0;
 
 	if (phydev->autoneg == AUTONEG_ENABLE) {
-		u16 adv2500 = 0;
+		u16 adv = 0;
 
 		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
 				      phydev->advertising))
-			adv2500 = MDIO_AN_10GBT_CTRL_ADV2_5G;
+			adv |= MDIO_AN_10GBT_CTRL_ADV2_5G;
+		if (linkmode_test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+				      phydev->advertising))
+			adv |= MDIO_AN_10GBT_CTRL_ADV5G;
 
 		ret = phy_modify_paged_changed(phydev, 0xa5d, 0x12,
-					       MDIO_AN_10GBT_CTRL_ADV2_5G,
-					       adv2500);
+					       MDIO_AN_10GBT_CTRL_ADV2_5G |
+					       MDIO_AN_10GBT_CTRL_ADV5G,
+					       adv);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.43.0



