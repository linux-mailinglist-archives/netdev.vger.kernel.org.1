Return-Path: <netdev+bounces-71827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C394C8553DA
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 21:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88EA1C21896
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 20:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D426813DBB4;
	Wed, 14 Feb 2024 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw37fiHL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C99713DBAB
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941886; cv=none; b=lfzYNj7XKHZR3vyQ5oiksNg4yVVToft0DDWEJ64LW/fKjd5N+KxsDSbk+9sq/WJqnM2MqVtDH36Ar6I2jr4CnRQEZqN5CRuNu8+aOl8a4Jughkz3XlxWesK6tMYkR2C4R/goXxEWTqORIMNvaRduFkee0sdU89w3NgWoyOB7KrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941886; c=relaxed/simple;
	bh=83jsRGAPkQS7NKt6yT3dAKVDWN3GkD/Y8s4615GR2fw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ICeHSSfboIvHhFUdOqXwceuvapox49VOPubB8+47XuZpua/HgsjkswsW3Od5jphnmSBxMwSSc+rixGoruI3E7Kh7lX7ek+P6YUooJIQTqfmDNl1WU3eMMaZdMouzTFpZUnn+kx+QoOQt7GNVyxbfhQMl8503OUbL0yUa3rIvhTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw37fiHL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56394d0ee54so176105a12.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 12:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707941883; x=1708546683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OlZjQr/9QRBPorwQuwD33vZGPEbr+eVZocaHnCgR7dI=;
        b=fw37fiHLCATTiiCFFL6i38CfkSMZatZ6A2IFhVEnm2b7X61FilNCfASgYchi0Kd/ry
         1eEEH37mgNKnWdzHf66bBosdt96C42Sw8Kc3MLKF4oxC26CX6K5CpaANWR5rRoCPs0eR
         roIX/yItCLQwRiAPjh+U7MowVxAWKyGn3ezjJ/ZKvNGTiSvlNf+PBj9eyJhLf8+4zUXF
         olGEUlOS5X0wtyJ58MasWKAf+OyW1AUxuZ1oxDlcayFe366UVmm6oaDfZFDjr9j98ku/
         umFelGd7ipjpW5vDslHxeLISkVQbHZi5A+U636YYknJA+YqO8pMeMJdCqanxn+8AghLv
         tbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707941883; x=1708546683;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OlZjQr/9QRBPorwQuwD33vZGPEbr+eVZocaHnCgR7dI=;
        b=ZRPrctkziAUG+NCrnvQKbyiHSWqXwJDvU7O92snTaM3fYdhZUgXcnDo/G32fk/p4uW
         Gy33Dy9t2GCWjN8Z1hiV7+iLuwLJp9X1evwHBq07qrEYM7HQS1k7lFS2y85kbZb1B8ZK
         phc8j6oDB4JpfQwPV2VbXQFyn46Wptxk7Zy+IzTilxC1BI88pwpm3oEFPSfbFuzIdT14
         ikZVJWGZQGDkjAfWKyH+HcKwKbbOGLNKiB1h0Z6SJVJX1A/ewHWQrjdxh7qHk5C9EKFt
         vC9RK3bu5JKW0FYUEN/OU0xSh4q2IWVPw9AVqTHinAkUE3C3Irc3/Dj8BzCK15PxJ1SA
         Up3A==
X-Gm-Message-State: AOJu0Yw9yrgq9SEmb+cqqQzWARPHZ+HZ0+22YGBQ+AfQFP6gb6O13M42
	ZD6jCRYKzSSB1akXSkoOi5ye5RpojCJnMuZ8xCAeDH52xWN6x6cN
X-Google-Smtp-Source: AGHT+IEjVEabX8Z5kMk34E7wznkM3qCfGvSjxoE2Wj9e+UWC937CyVUfzQFIp3IsJFmgitK15My1kg==
X-Received: by 2002:a50:ee87:0:b0:561:a6f1:66e3 with SMTP id f7-20020a50ee87000000b00561a6f166e3mr2999020edr.22.1707941883169;
        Wed, 14 Feb 2024 12:18:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3asY6z33ge22nPKC7juyk7MRXGFbAejW9LotbOFNSO9gsW2lpGfAWIF1Xvdtr+NPo/8ax15RL2dr/5eXhKdjJzuuefwkSL6CPiV/Uvt/PxtootiSQ6QxM8gp9QKZn8Ybrkb24RVCHcpUVqxjTaf1wOlGFrrdjjRx3IKhlttv1RasNX3IJHfJWjdKwKfO6/QqQj2o=
Received: from ?IPV6:2a01:c23:c153:4a00:f92b:249d:fae6:3a40? (dynamic-2a01-0c23-c153-4a00-f92b-249d-fae6-3a40.c23.pool.telefonica.de. [2a01:c23:c153:4a00:f92b:249d:fae6:3a40])
        by smtp.googlemail.com with ESMTPSA id en14-20020a056402528e00b0055fef53460bsm4979118edb.0.2024.02.14.12.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 12:18:02 -0800 (PST)
Message-ID: <fae70ab4-bbb7-4131-913c-aaf0a512ecef@gmail.com>
Date: Wed, 14 Feb 2024 21:18:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/5] net: phy: c45: add and use
 genphy_c45_read_eee_cap2
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <558e122f-e900-4a17-a03a-2b9ec4fed124@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <558e122f-e900-4a17-a03a-2b9ec4fed124@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add and use genphy_c45_read_eee_cap2(), complementing
genphy_c45_read_eee_cap1().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 46c87a903..5a245f0cc 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -830,6 +830,30 @@ static int genphy_c45_read_eee_cap1(struct phy_device *phydev)
 	return 0;
 }
 
+/**
+ * genphy_c45_read_eee_cap2 - read supported EEE link modes from register 3.21
+ * @phydev: target phy_device struct
+ */
+static int genphy_c45_read_eee_cap2(struct phy_device *phydev)
+{
+	int val;
+
+	/* IEEE 802.3-2022 45.2.3.11 EEE control and capability 2
+	 * (Register 3.21)
+	 */
+	val = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE2);
+	if (val < 0)
+		return val;
+
+	/* IEEE 802.3-2022 45.2.3.11 says 9 bits are reserved. */
+	if (val == 0xffff)
+		return 0;
+
+	mii_eee_cap2_mod_linkmode_sup_t(phydev->supported_eee, val);
+
+	return 0;
+}
+
 /**
  * genphy_c45_read_eee_abilities - read supported EEE link modes
  * @phydev: target phy_device struct
@@ -848,6 +872,13 @@ int genphy_c45_read_eee_abilities(struct phy_device *phydev)
 			return val;
 	}
 
+	/* Same for cap2 (3.21) */
+	if (linkmode_intersects(phydev->supported, PHY_EEE_CAP2_FEATURES)) {
+		val = genphy_c45_read_eee_cap2(phydev);
+		if (val)
+			return val;
+	}
+
 	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
 			      phydev->supported)) {
 		/* IEEE 802.3cg-2019 45.2.1.186b 10BASE-T1L PMA status register
-- 
2.43.1



