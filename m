Return-Path: <netdev+bounces-191324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B839ABAC7E
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 22:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D866B7A2E22
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 20:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E321F8744;
	Sat, 17 May 2025 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntYztzau"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E71553AA
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747514223; cv=none; b=psSGZRSb4NnmPV0By82qhomNAf9Dw0Y9bVeT0blRmUbECeT1rcATlYmCoE1lw2HcCYYebAW1ZcYhF+3iS4sflHRSC3FFQiVQAfF9P5fVT7OQiA4xmyO6mURM6HN6PQszNoBil9c9hLrhkj26Utgas7P0EWPN998iJBIgJazXelM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747514223; c=relaxed/simple;
	bh=eQbOYZxBCz4SSkpjOkNJrtQ+xkrfNg91cvG9mwUp2QY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IdLePgzbn7sW1PnU+xk2YW0PH8PKq6228O074MD/7efw4DMlL8kXX6IOud/g0M8m3cKjyFL/2PKMyGrR1+JUpqWFZH8bPEkCzJzmAfHjxIlssStcSyYHiu79RMTBDXcYhasL38gWnckAc4OrZd9ZChGslLuqmX2Da4pof4+QUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntYztzau; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a363d15c64so853102f8f.3
        for <netdev@vger.kernel.org>; Sat, 17 May 2025 13:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747514220; x=1748119020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ylo8Ni49E3+LL/PQOIj7lUh5zR8njba67TL61Z3yp2c=;
        b=ntYztzauZum6fQxhUGsPrY7GrZr/IIdkmJkgn/o39Ie6FWtiHrELR8M+JAlzrnpGwX
         erQiaS7XLd1++jLwSvyBvZ6Mn4/L46FE2Uadmx/2Wb6lFsApro1seMo2tnFBwEhznJ5g
         5jXK72c5Nt3k0zjgNIEqYptPGXRWtD+jkyJdGBqAQBfoXuRtrmQAZQi+DNGf9BeFVWQr
         KmIe9KZ83ixcn9/n50YWft1A8CGZX8gldwo3UA89WTAdClWysvftwFeQx3qbbPJ5qUN6
         FWWjdnAAs4DVQF6rqaYgDcvTfl30z7EX5qZsjtnQVakWuDwOJ2YpcbNG5vRPOyiB+XuH
         TcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747514220; x=1748119020;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ylo8Ni49E3+LL/PQOIj7lUh5zR8njba67TL61Z3yp2c=;
        b=cI01WvXH2ksO6jdyvX++4Q5F1IoJUFCxfzhJ6tMP5YpC7igZhBVboPo+zJOyZChKgA
         m6RiT81VvDpvIVC2KT+x3EhpQNMsUCaw/ICL57LXxgQDBhDNKOpAhyROpDn5mpWR2fNR
         UxH2LoUii4Ts9LvaMW8hYxjeSV032F96f4s39ryzXpstJN3Gaj2ojUj5oCl91akFLbdh
         Id4GXLyOBND2lBLO/T4s5WRLuZMZ9bK0YhQRPgilnsH91zslx3XPLLmTLK2wamyBWNTl
         TZZATg7bWmbT3TNPNGG/wh1Bx901MG8qgfFGsk4oKOWOO51kcrkSaXrbZIfoHuYg08c3
         omjQ==
X-Gm-Message-State: AOJu0YxPuZUNIEhqJnbnHBOSBwxTNw2GeOaOB+gDBf9Ew2EVbL/OyxDR
	wKsaYNWiELf12wTcxrsq35Y9nME903tMqSOFwS4WeV54ymnFGqZJgddF
X-Gm-Gg: ASbGncvVb4jvO98wT1uEgFHRKOs876Z0yxp1ckOQdEdC5JHuIEsvvL04bfWpvGAzJwp
	uQc4HepUTozyyyl1YD+uENqAmlt8a/OWtNwFxfHWP84IonhQr25+Sv5i9R7C5A/QwPn3c/6gF20
	q+5wS/b15F6TMWKstqpjRz0io/dHNAEIB+K8E2NSJb2utRZ91HuTuZmgwRt0bw0EXDYA/3zDIUT
	l3QsWx6aIIgCB3XXXpQXFsZj7J5yKX2Hm0OqQqgOmfkn7lIMuxk+kysaTkCYK1F4IZHX75/3mOq
	3sqC8da8qbu59SzDrQYk/d2GecPmEGJxRJjVo6E1AGP1BZENUHvPlbAHOtJ0Zcod9LTXCBVLFh2
	Y8cGm6J2YF325PqwKecEYS22RmbkTq6TB2dcEyAhuMsKRi6j3ILd6Mjhc8L+/v4aRXNqSLktquO
	wZ8z0luGI6sYNMV9nbzI2zvlffaw==
X-Google-Smtp-Source: AGHT+IEC/Cwt0qqa9a8H/l4poRkVe785AlC4PZRaxrinjYIJBG8Gu/yyei/a+bjsMPzGi5yNZjuTcg==
X-Received: by 2002:a5d:64ee:0:b0:397:5de8:6937 with SMTP id ffacd0b85a97d-3a35c840cfcmr6621076f8f.41.1747514220159;
        Sat, 17 May 2025 13:37:00 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f37:2700:a4c5:88ff:c972:1238? (p200300ea8f372700a4c588ffc9721238.dip0.t-ipconnect.de. [2003:ea:8f37:2700:a4c5:88ff:c972:1238])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a362b4e2e1sm5857154f8f.96.2025.05.17.13.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 May 2025 13:36:59 -0700 (PDT)
Message-ID: <d1764b62-8538-408b-a4e3-b63715481a38@gmail.com>
Date: Sat, 17 May 2025 22:37:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/3] net: phy: fixed_phy: constify status argument
 where possible
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <4d4c468e-300d-42c7-92a1-eabbdb6be748@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <4d4c468e-300d-42c7-92a1-eabbdb6be748@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Constify the passed struct fixed_phy_status *status where possible.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 6 +++---
 include/linux/phy_fixed.h   | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index ea002a137..033656d57 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -131,7 +131,7 @@ int fixed_phy_set_link_update(struct phy_device *phydev,
 EXPORT_SYMBOL_GPL(fixed_phy_set_link_update);
 
 static int fixed_phy_add_gpiod(unsigned int irq, int phy_addr,
-			       struct fixed_phy_status *status,
+			       const struct fixed_phy_status *status,
 			       struct gpio_desc *gpiod)
 {
 	int ret;
@@ -160,7 +160,7 @@ static int fixed_phy_add_gpiod(unsigned int irq, int phy_addr,
 	return 0;
 }
 
-int fixed_phy_add(int phy_addr, struct fixed_phy_status *status)
+int fixed_phy_add(int phy_addr, const struct fixed_phy_status *status)
 {
 	return fixed_phy_add_gpiod(PHY_POLL, phy_addr, status, NULL);
 }
@@ -222,7 +222,7 @@ static struct gpio_desc *fixed_phy_get_gpiod(struct device_node *np)
 }
 #endif
 
-struct phy_device *fixed_phy_register(struct fixed_phy_status *status,
+struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 				      struct device_node *np)
 {
 	struct fixed_mdio_bus *fmb = &platform_fmb;
diff --git a/include/linux/phy_fixed.h b/include/linux/phy_fixed.h
index 634149a73..5399b9e41 100644
--- a/include/linux/phy_fixed.h
+++ b/include/linux/phy_fixed.h
@@ -17,8 +17,8 @@ struct net_device;
 
 #if IS_ENABLED(CONFIG_FIXED_PHY)
 extern int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier);
-int fixed_phy_add(int phy_id, struct fixed_phy_status *status);
-struct phy_device *fixed_phy_register(struct fixed_phy_status *status,
+int fixed_phy_add(int phy_id, const struct fixed_phy_status *status);
+struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 				      struct device_node *np);
 
 extern void fixed_phy_unregister(struct phy_device *phydev);
@@ -27,12 +27,12 @@ extern int fixed_phy_set_link_update(struct phy_device *phydev,
 					   struct fixed_phy_status *));
 #else
 static inline int fixed_phy_add(int phy_id,
-				struct fixed_phy_status *status)
+				const struct fixed_phy_status *status)
 {
 	return -ENODEV;
 }
 static inline struct phy_device *
-fixed_phy_register(struct fixed_phy_status *status,
+fixed_phy_register(const struct fixed_phy_status *status,
 		   struct device_node *np)
 {
 	return ERR_PTR(-ENODEV);
-- 
2.49.0


