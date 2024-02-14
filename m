Return-Path: <netdev+bounces-71829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1F88553E0
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 21:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C0128AF39
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 20:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C06E13DBB1;
	Wed, 14 Feb 2024 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKzhlUn9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6C13DBAE
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941991; cv=none; b=KdCgTUBEygkrQ7+BMNCb08Ui+ZtOqFUujTXdqz97yNlhV8Tu6bU0ZnceJ5JpY/PRgYVJQi5AbdvH/ZGfvYJKFp9c0ahhVjhKaK6X47RCAxCtrIBdZ7aMbiLbBo67b/sLlrhfqDhWJV0Nd7c/O84fK1R9O4fZABUwNeil2bZHjho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941991; c=relaxed/simple;
	bh=aaEA+Y0+d62OavoN6qyoLAFKeoxRp0aJT3Bd2MkMMkM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MQ9STz7cbhwJDNdt5E8dB+OxpwWIP0pciWHxFB7ryUlBaC8P2scHV5BKqw5I8sJLptlN12aO01j+7o7Nt2NLqDEu20xyJIpO6LwJCSrJ6yMDuz1gFPWkOTc8TZbosaHxSUoP+ZL1KSMxJbMz7Xd3vWztzVh/LA8r3/czbgJUy1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKzhlUn9; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d204e102a9so1047851fa.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 12:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707941988; x=1708546788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eoylJVRlHfwKZ8uOgqaOb7AqNfzsRxbEeUtEBxkVKsI=;
        b=WKzhlUn9wpMK+Vpx58iHzdYdklLAxf395djyz4VqLFaZvaSr1dy3CEPrk/4TzwhPji
         QfmCzDI1B3/FAabNYSamJr7T8Sr8VMG66LbQR6lI7GSJvo4TO5avqZnHifd/DYVPYayC
         czfrasdTyxZAieCEHiUix9tSvxOWB+3eNgSwAM3CyZC7xjdK69/H9LCcxq3T4nqh6S+T
         c00sWKuTiUCARQTEzVjVgzKl3snhvLLdPAOywB7Pr44049jsTkAXN+2jE3b+FgGE/74f
         tC+1jP2qaiVWiP1eiJI4jRgyOoteKrFl+qwWMHD43uAObygVVxQDZrT637BoXAJhrw8F
         pIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707941988; x=1708546788;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoylJVRlHfwKZ8uOgqaOb7AqNfzsRxbEeUtEBxkVKsI=;
        b=mlB1XPC3CECTrcrBBh7ZLtCsavMf7B+/9KKNFCuoEAlhFQOb/pTnKNzd2MyfJdIgqQ
         FtKmMi6EVm+6OfJCwqkWAoxvKgTUeDs0o6qQAQsmLmzG7m0LENwRlH+y3ABGawgsFQyl
         VJ6LFb/4Ec67zLsMCgJWHJ9MVEroZN4xhBtQkS+vJppDOGDjZUTEEKNaLOAyS5k+kaxP
         cT80kCp3KSA1N1RW1/oayeysyECp76e/lAvgI7TgMrTvlsnkDqTpd7U1d5eZdn9AzbsT
         PGWVqFszzz5Ox3DFjrGGNt17olio5XuXT5GQtvOulWzvvp2NRIgAP/OsySGJsieByFCS
         qfcA==
X-Gm-Message-State: AOJu0YzaucVpFgk108XUF45qmx90KO4wEnWij1yLJMYb7Yr9TJKzbfsg
	S3TAgIc+H3+B3f8nhk3rgRiQEEEUC9037pyhp4h08t5D0fWGwf6s
X-Google-Smtp-Source: AGHT+IF+fMSaC/eYJ7pMYS7lqMjrEkBiOzpHBGVBJFXvZn0OVy7A5Lt5cvJsnZKqni3L1xVyZBAmPQ==
X-Received: by 2002:a05:651c:b2b:b0:2d0:fd0b:2cde with SMTP id b43-20020a05651c0b2b00b002d0fd0b2cdemr3177632ljr.25.1707941988335;
        Wed, 14 Feb 2024 12:19:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLvQMjFRb68+MoY69jkCJ2NaRExEB1oB7GsSeXUs9H3IkcXRePWnvRtx0BqXoFdXM2z4H9f+F0sd6O5+1hYrdGjEo0O6+eg9LOy8RUnkNF/6zFILJagS2MKpzqACypylQdoaHESwYhqJ1t0kyzUOtYbL4X+DKbrrw5EfWOnK5g/ugvbH5ifDdC5JRVQ7b679xpZaI=
Received: from ?IPV6:2a01:c23:c153:4a00:f92b:249d:fae6:3a40? (dynamic-2a01-0c23-c153-4a00-f92b-249d-fae6-3a40.c23.pool.telefonica.de. [2a01:c23:c153:4a00:f92b:249d:fae6:3a40])
        by smtp.googlemail.com with ESMTPSA id en14-20020a056402528e00b0055fef53460bsm4979118edb.0.2024.02.14.12.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 12:19:47 -0800 (PST)
Message-ID: <e04d38d9-cb0d-41c2-84b2-2ddfd9a4c5ef@gmail.com>
Date: Wed, 14 Feb 2024 21:19:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 5/5] net: phy: c45: add support for MDIO_AN_EEE_ADV2
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

Add support for handling the EEE advertisement 2 register.
For now only 2500baseT and 5000baseT modes are supported.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index b09c6baf0..c69568e76 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -706,6 +706,22 @@ int genphy_c45_write_eee_adv(struct phy_device *phydev, unsigned long *adv)
 			changed = 1;
 	}
 
+	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP2_FEATURES)) {
+		val = linkmode_to_mii_eee_cap2_t(adv);
+
+		/* IEEE 802.3-2022 45.2.7.16 EEE advertisement 2
+		 * (Register 7.62)
+		 */
+		val = phy_modify_mmd_changed(phydev, MDIO_MMD_AN,
+					     MDIO_AN_EEE_ADV2,
+					     MDIO_EEE_2_5GT | MDIO_EEE_5GT,
+					     val);
+		if (val < 0)
+			return val;
+		if (val > 0)
+			changed = 1;
+	}
+
 	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
 			      phydev->supported_eee)) {
 		val = linkmode_adv_to_mii_10base_t1_t(adv);
@@ -745,6 +761,17 @@ int genphy_c45_read_eee_adv(struct phy_device *phydev, unsigned long *adv)
 		mii_eee_cap1_mod_linkmode_t(adv, val);
 	}
 
+	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP2_FEATURES)) {
+		/* IEEE 802.3-2022 45.2.7.16 EEE advertisement 2
+		 * (Register 7.62)
+		 */
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV2);
+		if (val < 0)
+			return val;
+
+		mii_eee_cap2_mod_linkmode_adv_t(adv, val);
+	}
+
 	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
 			      phydev->supported_eee)) {
 		/* IEEE 802.3cg-2019 45.2.7.25 10BASE-T1 AN control register
-- 
2.43.1



