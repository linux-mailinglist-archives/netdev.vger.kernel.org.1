Return-Path: <netdev+bounces-157394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE76A0A225
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A793A4F3E
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66838186E52;
	Sat, 11 Jan 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjbGUkAr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3E524B22C
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586596; cv=none; b=lSDHM3+reCAkizvAvAGzbBMOgazyGbciy52p+S8wI9K7w/FMI2CQiwWb4l/vAdh7GWRSL8TCbYq6RH4ZmLFMchmgrgajeZshSOyChO3p2F8YpwhFqmRpdfrxp5fv6hoV3cBoULP86WglD2rNpBMR9FgMpnJVYTYz1wfEuleVv3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586596; c=relaxed/simple;
	bh=vK1higLia5enz8xZAXpcNXIqqLM0PZ0d0Ghcb7N54wo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s6jTqs6D79bTXXdgrFLceqDQ8HwTsQGSTELc5PVEkTl8oCn9GIo/U3WduvVoORSkdCFK0Y7lT58TwSBppkZ65DkVWRGqKw0d5R540paK9Tsu+5u6bpBceCLiglhxiUGn7QELPCX3019Oh0i8FTBl9nhztOA+jmShBiGlQ7j9saw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjbGUkAr; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so426570966b.1
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 01:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736586593; x=1737191393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v9m4J2VJ0FoMBNQpozaSbll1oWWctyBJQ3mpG3ZPzU8=;
        b=KjbGUkArNtA33B7KGzPchOjxQHh5IctdNrqxpLq8VrVP9Dzm3V1IM8XIeCjr3Gix6o
         6QVX/UZuToe83K5Eur0tiuQyW3GYYlDlFfgficOoFZqCE8mvDnBUw1hyYoRGSGQVYlt+
         pHVqtJOXGHKO12VzSEQlXtzxYGEK5rw+0fYXzn8JuG7FfDpgLAmuAgrlL8qdJmZIi4pf
         Eb1ngWwnSRgcXtPLuAQ7YqvzRkmKP/uk7IgJymzAzf5tCR/+6GNmDNr2Cme2Llx50uUO
         P4E06oEPRBMlROmiEKI13gdRpdUUGXaeh0x9kNjplYquIlTpGJCeuKc2LnFWb4fW6ZSI
         sn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736586593; x=1737191393;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9m4J2VJ0FoMBNQpozaSbll1oWWctyBJQ3mpG3ZPzU8=;
        b=OGXWF423UoQysaK9GlyYlYul4NVqqHdN6yP7amJtmXshqzecgmHfRrNicTllKgiq7M
         Z4IbTxI6vTOilEeVogJXJD8VpcGQu+PhNro+p0TIbfFuc2K/h5+cDE1DGEHANNQv5EZH
         ksimu7OMWvJbecbHfHZMS8/uWkNtC+OyqntPFtQppSR9Il4K15w4UroEZqraD1OiXmOk
         8qb0f8oUx3pzVY28hGNbjy9/aZevPru5teVRv/JygBK3YezaPjEu49ftc4QiY/8rWw7F
         b3baUjX4CYfrSScDla0qC6/egLqMOI0b4HMmZTNHWXmXFvbkdAshmpQsR/QClss6mBIt
         ndww==
X-Gm-Message-State: AOJu0YyEjB4fkbkSNnAudt16lVigSaKqhdg2iPq+HeqpHyUIev4x45CQ
	YvcEf90+Oi+j46GwoW54DILqGeNcY3AooErQcAy4nMl2H0skIsSC
X-Gm-Gg: ASbGncsBnvRPnBDEFC3v+7La8eUMoj5i9D1NyMMrzzlraK0NJfw8ibtyeZCoW4HGOmZ
	0PQk2f3r5mLIhwIjC7OYjmkQu5YQsafyb7Ct3BheSEyaKph9sziPJXLxjMLjuDXqlAuNzpBDc+c
	buiB+aql018qYxbF4vOQSMF8smc1YH01QqfkIZ8/dodjDMavIkmGZ3eHTcbguJSV9EwKGsP6Pyj
	4YAIw+Y3JySusEPd0gniz1MwJ+PGYWtAPAAv/ffQ3dxmDkb62lQcV2eApxu+twj5SU4lAfxZB8j
	adoOBehfaC4ERfwHHe/oCwC9paHbYr5QIwUJGB2g0cvJTYMqryn9e66F1nGHNGEH0mmWgEmDGUK
	RQH2oY4wO81h8uHQ3Rmv4ycMO/P5yfkKlCr5JiH7JRqdjM1Gd
X-Google-Smtp-Source: AGHT+IH0WK49gLMCEHrXj7cXpWZbGYzfeSjS2vdXii0j5QxgnevQzgcehZaKPIAnXz2/k2/ES8oPLg==
X-Received: by 2002:a17:907:3a96:b0:ab2:b5f1:568c with SMTP id a640c23a62f3a-ab2b5f15bf1mr790297866b.28.1736586592720;
        Sat, 11 Jan 2025 01:09:52 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c9562e9bsm254220966b.106.2025.01.11.01.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 01:09:51 -0800 (PST)
Message-ID: <88ddca91-5318-4916-a87f-e8cf8c15eaca@gmail.com>
Date: Sat, 11 Jan 2025 10:09:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 7/9] net: phy: c45: Don't silently remove disabled
 EEE modes any longer when writing advertisement register
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

advertising_eee is adjusted now whenever an EEE mode gets disabled.
Therefore we can remove the silent removal of disabled EEE modes here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index b566faba9..ef58d3b23 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -683,13 +683,10 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_mdix);
 static int genphy_c45_write_eee_adv(struct phy_device *phydev,
 				    unsigned long *adv)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp);
 	int val, changed = 0;
 
-	linkmode_andnot(tmp, adv, phydev->eee_disabled_modes);
-
 	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP1_FEATURES)) {
-		val = linkmode_to_mii_eee_cap1_t(tmp);
+		val = linkmode_to_mii_eee_cap1_t(adv);
 
 		/* IEEE 802.3-2018 45.2.7.13 EEE advertisement 1
 		 * (Register 7.60)
@@ -707,7 +704,7 @@ static int genphy_c45_write_eee_adv(struct phy_device *phydev,
 	}
 
 	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP2_FEATURES)) {
-		val = linkmode_to_mii_eee_cap2_t(tmp);
+		val = linkmode_to_mii_eee_cap2_t(adv);
 
 		/* IEEE 802.3-2022 45.2.7.16 EEE advertisement 2
 		 * (Register 7.62)
-- 
2.47.1



