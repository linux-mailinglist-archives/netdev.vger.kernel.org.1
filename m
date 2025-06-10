Return-Path: <netdev+bounces-195946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4CDAD2DAC
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E2C87A7E7E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 06:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4702620FA;
	Tue, 10 Jun 2025 06:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiSexN4I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA925F988
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 06:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749535425; cv=none; b=dzPvnEFAUiNDOwZhoW6e3LILlecYZfiIIW2iikUtUfIAMrzIA4DD8qmjXieVvrrPU9MjUrTIjprVcdzTxqVcOD/bO6VjLIqaoZrw9en59BPZVqLG8JwnrRV9it68J67Ah1e4gJyejOcdpGfO2eX2BFAUXt5EY9iEEsJvWQ060Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749535425; c=relaxed/simple;
	bh=gWz5jt3ZMg0gMVWNLiJwBgZED8XDrwtNUZxKscPKDWo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uUhCzeGNGhtlCnuEOK97oGxMJYbcjkE+oEjVMBcWB/DBjQsU+JQNm5TnqrC/eE3Ww3IP0ClQQJC6gz+8NeDuUYrSRDR7JABaCkK+dQBiljELFjofQhwwAw9D4D+iJVVor/2rwfgwhpuchs6WAbZpVgDFHGBCfss26EHzBTfH1f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiSexN4I; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a5257748e1so3352187f8f.2
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 23:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749535422; x=1750140222; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjk36lSrR/BZsXAJXIuyctl0mrPRQFWWW71s5CXfOJY=;
        b=hiSexN4ITcCAqWJ5NL88b8efRr/ByGGlGUrZEfHohx2MEjXaLg9aUvk1DSsNqHTkZ6
         aLv7ZzEVCg2SeYD4mtNOy+Dh2UtJIFfka6OplOPRjHzdhTqxewGTy3ZXXRov8z22ftkM
         cU/2jceE3la4RFhRnGevHAkKdFWEaMtZEwBfWBYuVueMDVH3OTUwGwsh7MMcUG9/I/2/
         stu3m1tLiFJebVScg1ZU9+FfxQdJgLH+1eGGaGqTQglV8Ku/BjQxWsyKGpdiwy/weOle
         ykyUxzQBMXnSuOMwsrggWSMG/wlpCEYI5Qw4FrtCO9gGpBnob9BhXBNzX35QLPqE35KR
         0RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749535422; x=1750140222;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjk36lSrR/BZsXAJXIuyctl0mrPRQFWWW71s5CXfOJY=;
        b=UZ9ZvbzdOAsBM6yitmMoSj2vPkbTZ3WE+EkrVS0u//60VOfkU1K0/ylPQSBGrdomGE
         oSIuKShyzLm5d9jCK8E16k2Pqr+sfWS+Umf7ANKoedEt1LiirBD4knLnApOYOM0hy/dj
         2U9/hxItxio7qXrOELGXgXLp8GZmqIA0isxUvgVH4g33Mcofy43NKlViHy63oFMdrnbK
         qPVA2lWHy6Htm/NmKpWHdMbCtmz1fV1FblWHw6ZvyNJHT0rUBzWnxTbJxFmuWG7IVawa
         QtQbxtZCYtVwlLSnbGv+LxW5xKJBbvCkywd0R1gPILSB/xeZhNpDXhpIcecxKBv4+fTr
         no3Q==
X-Gm-Message-State: AOJu0YyQOo6UdYoPXlf0wUQfbRN4ecqgmAeEdZmpJyaizFJ647iwoYni
	rzEsMVlgbUJyxLfwjrQqXcbozTnm71ML/DN8mOsJ2B4l5/qL3gKCzzWi
X-Gm-Gg: ASbGncuMWhglSiYEOldHi09ZmDmjUWm7UHZtYc5te9ya5uprH6Ncc0WK5grq4tP/5/6
	kVb9HAOCs/M8l94wdiq5FyZ35YBA7vFf/u873pXh2/mF4uwTHD3BZX4j7+OjBoNRk60NCnB5nIs
	cIPyPA6iYYI9SXjBpw4jUBWEmsPD13msRnXKY8oKK5NiTfdsr7ieqCCssbA4R13GsTx4k5p1yWN
	nSI4rQUqhMxPEF+zBbgOqyrT4U7gqvZ98BeqquyNajaizxH77W7PGGyUExhbOKKiMW7Yh0Be7nq
	AHe+e8+iAcv8tTBzOhcJc/7MK7WlZDynv7k6xodBQpDZrzquiQb34itveGMn37tuC2kiAY1QpfM
	0lgmG3YXYs5h5akJxZ5FkVWybfys0cSJKMnxcC91znDXsLnCnaOrW8ubyjtyB8PRdfJDHBUBNni
	Ob+21eyFh8vIYmoIkWd4yECUajVw==
X-Google-Smtp-Source: AGHT+IEwft00xtvH07W+bQe8ePkV60VqR+1pGWKVjABMZkslQ7LX468olbOpVgnFUtpaKnmnKrBmHQ==
X-Received: by 2002:a05:6000:2010:b0:3a4:dc93:1e87 with SMTP id ffacd0b85a97d-3a531684002mr13043881f8f.1.1749535421853;
        Mon, 09 Jun 2025 23:03:41 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1a:8200:19e3:25e6:afd9:6d60? (p200300ea8f1a820019e325e6afd96d60.dip0.t-ipconnect.de. [2003:ea:8f1a:8200:19e3:25e6:afd9:6d60])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4521370936esm130249315e9.20.2025.06.09.23.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 23:03:41 -0700 (PDT)
Message-ID: <6c94e3d3-bfb0-4ddc-a518-6fddbc64e1d0@gmail.com>
Date: Tue, 10 Jun 2025 08:03:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RESUBMIT net-next] net: phy: assign default match function for
 non-PHY MDIO devices
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make mdio_device_bus_match() the default match function for non-PHY
MDIO devices. Benefit is that we don't have to export this function
any longer. As long as mdiodev->modalias isn't set, there's no change
in behavior. mdiobus_create_device() is the only place where
mdiodev->modalias gets set, but this function sets
mdio_device_bus_match() as match function anyway.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus_provider.c | 1 -
 drivers/net/phy/mdio_device.c       | 5 +++--
 include/linux/mdio.h                | 1 -
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus_provider.c
index 65850e362..48dc4bf85 100644
--- a/drivers/net/phy/mdio_bus_provider.c
+++ b/drivers/net/phy/mdio_bus_provider.c
@@ -152,7 +152,6 @@ static int mdiobus_create_device(struct mii_bus *bus,
 
 	strscpy(mdiodev->modalias, bi->modalias,
 		sizeof(mdiodev->modalias));
-	mdiodev->bus_match = mdio_device_bus_match;
 	mdiodev->dev.platform_data = (void *)bi->platform_data;
 
 	ret = mdio_device_register(mdiodev);
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index cce3f405d..f64176e0e 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -35,7 +35,8 @@ static void mdio_device_release(struct device *dev)
 	kfree(to_mdio_device(dev));
 }
 
-int mdio_device_bus_match(struct device *dev, const struct device_driver *drv)
+static int mdio_device_bus_match(struct device *dev,
+				 const struct device_driver *drv)
 {
 	struct mdio_device *mdiodev = to_mdio_device(dev);
 	const struct mdio_driver *mdiodrv = to_mdio_driver(drv);
@@ -45,7 +46,6 @@ int mdio_device_bus_match(struct device *dev, const struct device_driver *drv)
 
 	return strcmp(mdiodev->modalias, drv->name) == 0;
 }
-EXPORT_SYMBOL_GPL(mdio_device_bus_match);
 
 struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
 {
@@ -59,6 +59,7 @@ struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
 	mdiodev->dev.release = mdio_device_release;
 	mdiodev->dev.parent = &bus->dev;
 	mdiodev->dev.bus = &mdio_bus_type;
+	mdiodev->bus_match = mdio_device_bus_match;
 	mdiodev->device_free = mdio_device_free;
 	mdiodev->device_remove = mdio_device_remove;
 	mdiodev->bus = bus;
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 3c3deac57..317381c2d 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -98,7 +98,6 @@ void mdio_device_remove(struct mdio_device *mdiodev);
 void mdio_device_reset(struct mdio_device *mdiodev, int value);
 int mdio_driver_register(struct mdio_driver *drv);
 void mdio_driver_unregister(struct mdio_driver *drv);
-int mdio_device_bus_match(struct device *dev, const struct device_driver *drv);
 
 static inline void mdio_device_get(struct mdio_device *mdiodev)
 {
-- 
2.49.0


