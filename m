Return-Path: <netdev+bounces-166551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E09A366E2
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987F618932E5
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 20:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8836C1D89F0;
	Fri, 14 Feb 2025 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doi31V2U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09D21D5159
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739565044; cv=none; b=ZFBhDgirORn34GCVl37mRHz1ax76Pd44eC6iQnATtTyIa5wuTS7F23KOcyzTvzifs3DIUUqhrv/rcalEh+VKoXffoY7vToEGORwE2iBe7jOyO7IOpnKaqq6v3pZXnOF5WspPI0j9yizEejvn19FINwwqjaR/yvtkRQ7Vm4tFfGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739565044; c=relaxed/simple;
	bh=1TwSXz0o8b3m+uWwT95bUXOVBvOPuusRv0WjMQWZkws=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=L4UG58igIevq34/8i/abD9X0HvJLeGCIvC8vjcnXzpBwtbu1SaBDIYQkYn7rMsl/e/AR1DYiXTX11dMTPVYpbGZKjclt/6KCrOVrTjKzJoDwLNoFL9wtxENWd1m/eHohzXp+kT9FOkqVbvnCA4luecwtWSk19Eg/vT7/mM9okmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doi31V2U; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaeec07b705so411642966b.2
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 12:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739565041; x=1740169841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1tM9es24kkA3jWcbm3aqRq5jHoXJ+samI3aGMeNkak=;
        b=doi31V2UJu7k+4+VyWL+2AsXT6bw65qO7tHS2X+y/yA9DRps5wqIW8TYXyIkhQsup0
         FqLzIvMiPe78cbzppkbzp4z5Zj9CyZ1PWP66zsrSTt1j5pKT3goy3gUnon+AqR8JOsyu
         0WON+vFpdaeuJ8T2F7WIluG7O15TxG4nQFCkDcKgH//u2NOkCuZkQnTpuHNw+Hd53M2B
         GqBj1pSkYxiCHgPUf0Yw+xwWlRrazL+vXuyEoHF7AwEBfLA6xMFT5DFmpV50r4TEkR2C
         sLrcPb7nndD0bMm2H77SUtYzy2PMx4HDsehkaah1cye4FO+VPKp73XT2W7HSn9bxzNbR
         q1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739565041; x=1740169841;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1tM9es24kkA3jWcbm3aqRq5jHoXJ+samI3aGMeNkak=;
        b=XmmeOpK1EPweNBNATYna7ShctG1HyAQ+Yx2MPyGGTc3dZPncJhoBPy+E73yp3uD581
         3/KC3SJAiDO78ArzsVZYSWAInXohtvRagHdhnnHat8dXziur5qw/uegJGAJyR3kv2x95
         IZtxLZoTogXF4azfa4dzXXZhY2lRc2u9wbJ9wleLNu0RLejBtHVBuVKNIyQqtz+Orh0Y
         e+4w+Ix1DXgQUDq75/QdYKkHdmwNn5yGi0Dy7pRIT8k52Fdsmrwj6Gvys7KRSh/WrLmj
         HELvxJ5r9QhaoTGokoEGe8zN9l8Eh5j38j/alpRSabkCYbFmO/UCXHPvolpbVHUTdQ63
         Ogug==
X-Gm-Message-State: AOJu0Yzk3vLQ92t6KrfUlyo7W4XG17HlGXhI7GBCAGSlA8yJteMUp0SV
	VTlnWrSb4vqaOWe+BvOkmNzB6nzbmxByHJXxfmPNkhC0+Yak62yOYIxEop9r
X-Gm-Gg: ASbGncv8G+Z6ijmRfJ6/q2iJ8d9cDpU4jvn+VpklDXOcg/8AwSdt0kmG1gNqrvz0y5Z
	PJ8wAnSx1EdLOOYTSizIZLMbsTA6kgWnEu7g7K2kTd3ExXaXEKIiH039HTg1ox0L6Xterb+H7eM
	hbyrPgnhCb1G0FgCkFjWIEPE0tTShMYhfnKEjut59i13Gm6Y/TzD42N5+Q/mI+Ofp680eN0J5LE
	rASN1xV1QiKvKo/2/c65Xd77bYB+ZwIkWCwKxp2mkWOhYsz0NC245tLOvAn6oE9tdO0VHIEIuYM
	3ZC6X5eO+qKlbwC2kisu++Davco0IG4HHoYa5Y9vYeA/Wy/dnIENfuvbD4e+ObUnhA32wQ6t426
	JyFW7ycSurIfE9jMWAdrCylsYAsvixN9PdY2H3jzbmvz7yRPuzOuBpbu6kL4G4GZN/yIVU/+8ww
	a5PbUnjQE=
X-Google-Smtp-Source: AGHT+IHzn/AAjHZ903X1R3c/8ZniPfyFuW9ygBAbfnKj/Jw+2H6OgtxbXfntLmGLsqhnSK/2wHelsA==
X-Received: by 2002:a17:907:7247:b0:aba:598b:dbde with SMTP id a640c23a62f3a-abb7091d9ecmr44948066b.8.1739565040521;
        Fri, 14 Feb 2025 12:30:40 -0800 (PST)
Received: from ?IPV6:2a02:3100:afb0:6800:f0cd:edaf:35fa:656a? (dynamic-2a02-3100-afb0-6800-f0cd-edaf-35fa-656a.310.pool.telefonica.de. [2a02:3100:afb0:6800:f0cd:edaf:35fa:656a])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aba5325890fsm407823466b.63.2025.02.14.12.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 12:30:39 -0800 (PST)
Message-ID: <6344277b-c5c7-449b-ac89-d5425306ca76@gmail.com>
Date: Fri, 14 Feb 2025 21:31:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: realtek: add helper RTL822X_VND2_C22_REG
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

C22 register space is mapped to 0xa400 in MMD VEND2 register space.
Add a helper to access mapped C22 registers.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek/realtek_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index e137e9942..566261f42 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -79,9 +79,7 @@
 /* RTL822X_VND2_XXXXX registers are only accessible when phydev->is_c45
  * is set, they cannot be accessed by C45-over-C22.
  */
-#define RTL822X_VND2_GBCR				0xa412
-
-#define RTL822X_VND2_GANLPAR				0xa414
+#define	RTL822X_VND2_C22_REG(reg)		(0xa400 + 2 * (reg))
 
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
@@ -1026,7 +1024,8 @@ static int rtl822x_c45_config_aneg(struct phy_device *phydev)
 	val = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
 
 	/* Vendor register as C45 has no standardized support for 1000BaseT */
-	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2, RTL822X_VND2_GBCR,
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2,
+				     RTL822X_VND2_C22_REG(MII_CTRL1000),
 				     ADVERTISE_1000FULL, val);
 	if (ret < 0)
 		return ret;
@@ -1043,7 +1042,7 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
 	/* Vendor register as C45 has no standardized support for 1000BaseT */
 	if (phydev->autoneg == AUTONEG_ENABLE && genphy_c45_aneg_done(phydev)) {
 		val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
-				   RTL822X_VND2_GANLPAR);
+				   RTL822X_VND2_C22_REG(MII_STAT1000));
 		if (val < 0)
 			return val;
 	} else {
-- 
2.48.1


