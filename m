Return-Path: <netdev+bounces-197639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC7DAD96B3
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 22:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0914C3B0D88
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450BD24BD1F;
	Fri, 13 Jun 2025 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvA1iFRT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8275A2397A4
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749848228; cv=none; b=pLfqidmpPJkz4ln0B89x7QjdGkBDFDtGepDi1k6sVyCm4Eh2sE4wGt+WWN8qrrg/l5PzjNjigpx3GQnPMn9qbCPSgj31XAJ8OckuYYagsFFm5iD9I6CwrDvnHXCZM7hj0cUWJTfTP5ki1qL7uhdECS1qfX1oc9LLuZzy+XKe53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749848228; c=relaxed/simple;
	bh=XAE7d/8nPl3zmGyaps5cm8X7/4uCTIDiGo1Mhm+a0lA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=U8WDSuz5iGt5/nhQhUuMFt7ElWEEM9PRkoX28jf7I+bncIdeKtPxuyYx3LxEoMSzEfb4HYiRd6KjXAY2Piqils4pYstGQtRZlYjFANL0JoA1iquzAtHKgk5PKYYTgpr2dUt8S6o5AErdmcZMO+DgJJsOp1ToKQdAFTIc3pEKEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvA1iFRT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a3798794d3so2358572f8f.1
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 13:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749848225; x=1750453025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUJEZhlsD8LdoJMMWMDckTyTxlFwpMwiOd0RVNvWzrg=;
        b=kvA1iFRTCRF3gYjEZosPwOqYQCfqTjvLrMQtq6b6VX1stOVnptEKHvfgGJnXXGHyqp
         QvbdqUgxs6W18pI/UXNNC47az1163Kbger9at69hfDClKrPR5NDlrdbtmhNrKbYcpc2w
         oTT6JM9KOxGcB8RHbDd9wn0Nk0HpvX+ei1ul3MJxgfA0iLtXg4ufWN23/HOrHtWLSaNq
         PBIbN+bXriHCl+aZMbBsTj26+WI7HLTWp+PKqClhtY0z6oKv966X0sHXw+7DbuXZMjdX
         4t0OnJhUWQYP2wPStgUcsTcs7Pq6JHO6bnqFmDH9ruCmnqlYlV/ICwB+G/DAEuMoDUXn
         Kv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749848225; x=1750453025;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUJEZhlsD8LdoJMMWMDckTyTxlFwpMwiOd0RVNvWzrg=;
        b=pmgDjpdfjw+1r1r1grK9+ULYY+zXYxKoZi8nix/K27sly4HKd7iP7lrAZt/8qIRVCo
         lLZoX9Fhuk6X+Y7V+Rr06aeyBUNhQnj5/tvk/SvxcnPXTgsqp25NMf+Rir3t+ieeQfCr
         guezfU67ND/bRMbmUOxegsfFKYbIZ5IrdZDDIv81mrJHqArC5PUsSr6xwVbbyM+3uOpt
         vO3kao81By01VfxNN2K6OToUPOyfdXhHEPoTzsB7LTMaNVZm/CVjcjxI9CdtlptvC/Qs
         +VGZ7B3I4bR82+xflWMRXW8MQmT+mT46B79thZtp7Q/yQCAzxe1T5G0qINzd1x906MWU
         2tTw==
X-Gm-Message-State: AOJu0YyKUEK6WxGd9bmZiXDonqawjgJ+c0ACKU9wdCkNB5JzsajGiO3L
	VPoaKdKqzh+GTJ1im0TpYAIQfuLrikJrGf7NjEIQj7nMym5s1M1NSEGg
X-Gm-Gg: ASbGncuhZoSo2UJO80boHbsV9bw+rUAtkA6tb9EiDyO6KLvzgb16X27dQufwwc3qMFZ
	DW9mihHC//m18XYypJl2lUotNciQgnJBWGq1DGIeHv0a7bbvsG79smwsi9IXOJRscG2rxIuHkbh
	pZiogHHDTNEK96pT2Tn0B3u6/UvkjCz6m7HbSgkDs+9HBBDJ325/NaUZCk+Y/+HGR3Wmhk5873m
	2ugEoj2Md/00kXY1nYg7kZMBnAXiYV4XuJtRns2AR9n0fBX2YI3YqdJZtaJqVN8vSCmB1gArLkF
	sNpx9BkAJnfF5zQvPiyPHCXnlOPC7hJfT4OWSqTAg5liOtbIG64v71GQ+PuAkaLF2ogU9nWB8R0
	k0F5vnRk2+uNOCdxkic5QqKF1gJYqzOSITB6S/qIezj2wWfG4YrIV69vX6+l2gSJui9KTTE35JH
	5bKEFjNq9eO+ESxtd4D6LxINI1PQ==
X-Google-Smtp-Source: AGHT+IFQepgeY8kBD0/DctJUwPh87+RnkqocRbkhDbZLU7wYZLgoG52nKcv9kIlsKVeG5VNwg6960g==
X-Received: by 2002:a5d:5888:0:b0:3a5:2e9c:ef0 with SMTP id ffacd0b85a97d-3a572e7973emr1269742f8f.46.1749848224717;
        Fri, 13 Jun 2025 13:57:04 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1c:2700:11ba:d147:51f7:99fa? (p200300ea8f1c270011bad14751f799fa.dip0.t-ipconnect.de. [2003:ea:8f1c:2700:11ba:d147:51f7:99fa])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a568a5405asm3481863f8f.13.2025.06.13.13.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 13:57:04 -0700 (PDT)
Message-ID: <e43a6ede-3654-4e6a-821b-d300948f48a3@gmail.com>
Date: Fri, 13 Jun 2025 22:57:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/3] net: phy: remove phy_driver_is_genphy_10g
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <8bcd626f-a219-43e8-a0c2-aa04148d046d@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <8bcd626f-a219-43e8-a0c2-aa04148d046d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove now unused function phy_driver_is_genphy_10g().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 23 -----------------------
 include/linux/phy.h          |  2 --
 2 files changed, 25 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c132ae977..e2b5d9016 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1706,29 +1706,6 @@ struct phy_device *phy_attach(struct net_device *dev, const char *bus_id,
 }
 EXPORT_SYMBOL(phy_attach);
 
-static bool phy_driver_is_genphy_kind(struct phy_device *phydev,
-				      struct device_driver *driver)
-{
-	struct device *d = &phydev->mdio.dev;
-	bool ret = false;
-
-	if (!phydev->drv)
-		return ret;
-
-	get_device(d);
-	ret = d->driver == driver;
-	put_device(d);
-
-	return ret;
-}
-
-bool phy_driver_is_genphy_10g(struct phy_device *phydev)
-{
-	return phy_driver_is_genphy_kind(phydev,
-					 &genphy_c45_driver.mdiodrv.driver);
-}
-EXPORT_SYMBOL_GPL(phy_driver_is_genphy_10g);
-
 /**
  * phy_detach - detach a PHY device from its network device
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 4daf6d69f..42ef1aae0 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2108,6 +2108,4 @@ module_exit(phy_module_exit)
 #define module_phy_driver(__phy_drivers)				\
 	phy_module_driver(__phy_drivers, ARRAY_SIZE(__phy_drivers))
 
-bool phy_driver_is_genphy_10g(struct phy_device *phydev);
-
 #endif /* __PHY_H */
-- 
2.49.0



