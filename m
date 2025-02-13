Return-Path: <netdev+bounces-166192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B47FA34E54
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774E63A9829
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6228C206F2A;
	Thu, 13 Feb 2025 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGxYLuEo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799516F073
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474268; cv=none; b=MVF/g34m7U58t1JQDpGRk8CoHPXdAl6qi0UcWw8YC60xUI3/mcvKeMyH1twR5+53Ogma1zFz1mUAkV4Zr8BxdGiOF/5n3XYXpI7m1RVpVy9ErCRxpjtPvYq8Amm9eM6xmjrbEgaXjDd6Dai4cj88QZaobHDNqw99Td25/ImkB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474268; c=relaxed/simple;
	bh=+nUse8LOFrqMjTAd7cBS0kvQ9pSPdEBXnj/Y4tc5PXs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fLBop+jV6BNydo1N9AeQZf/CuQfAI9a4kPuS2aMPr9IDmzP/WVkVuGeWS+GGSznnm8uiHn7YVsOd5+JA0fIAN9uXUYugTGUG5YhFNzgIgEfJ5SCnaYuuYPzyVC0/T4Fa4ZxASVUcCSo/vP72cKQ80QZX35Bg5a0bZy7i2GL9x+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGxYLuEo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5de63846e56so2264875a12.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 11:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739474265; x=1740079065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9GUu3EzRlS/ngFTHDdGEuuBCERvBzHDVB29DOiTeihs=;
        b=YGxYLuEoBcLZgI/UUceVv3NJbTvF8cMUPSVpGdzvaHTXLQiOvXCSyHZ/Sp7PeeKgzR
         p+7UKt6mqKycbK5ne6+kVOnT3x/wUBfmAuUKYtHwnnur/eHorZ8aD83dvOyixPyygy+v
         fCdzj35a6fq7L/IAHe2PVxbOuGYET0fiAg1pPm4aDeRmZRxaqes5RrAMWcsd8quGcvhy
         1qe+XKf9m1vwDnTVHG046pK1nf97QvxyLnXpGeVNolnoVT8advBaj6vzOBuDaPmAS4vY
         KH+VEFHsyypMZ6bJOopreHtg92q8DHfACerIyWAnlfDs+tpRzUiNYZc8Fs/El3mSvgv7
         Kxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739474265; x=1740079065;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GUu3EzRlS/ngFTHDdGEuuBCERvBzHDVB29DOiTeihs=;
        b=aVp6/Jnvf0ngSY0FwPe5618YERuBj3NP7VOXLvKmEeLYNt3Et2csuZf8Xn5ue+c8ds
         uU1fw8G/kDxdRiT6yIxIWT8g8x13FTIUf/Qj9T1/cwfxN1ZnHBR2sz/ENOKSm0tZ7wxH
         8XmEq2mdtnshMEyoMAAFRYtB5hCqkqqfxQXc6C+o38X8DSrb28rPRQcFNjxpCQJzKjQz
         bXnL093L7A2zbeMPdPZBtYghDPI4dJMCCwpsyrDhWpcRqSlSc6P52S2b39FuC7F61j3u
         bkp6fLb4S8to3UUfgnaYXSsN/f/GY7LWmWiKE+UbSz0MgOQCirUbN0e5WwnqvBjwpoJ+
         Tbug==
X-Gm-Message-State: AOJu0Yz5MnJoo7dJzwjw0zD2n62eLG3qnoNKc6yFsP1Q7Cb3yTT2mRan
	eRt/Q4cFASLIMVULirRSjJhtUrKcrcK+wA+QLXHBiN9UYV4dON5v
X-Gm-Gg: ASbGncsAbPL2EzxTmOYJlJzvYioD8G+ZcyfTIkWreE/wZHbrPYjCQnRNt9k2+ZqvRUj
	xzfU2a4pxfHor6gTqY5ExsVqgKz7jnYd1Rbr5ZmVYrr2Kmv/5jfpllr0MYulF3RzZI6k5a3mbuS
	7O5LTQ+OGq/P6dNHB0yCr4uyrg6DesiPe72GDnBySlsJpEKMmUfjCcMdejT/dY/qbwQo6YycEI8
	OyK5ghnn9+2TmaoqYAqfbGFdvebL1nsm+WZdg0sIhxxnI8sGVG3n4PAsHk6aVVFJ/iH8+kXB5Sa
	TmJ3klrvYh8JDERNGI9GxeKp6Y3QLPgjpmGnuGA0UNdkBeRHf9r0l4kkd9EhBaNLj47/kyaZxKi
	R/aJhMkoRzDZ38dg4ZqdG3TiTEWFwSk2IoMzVZN0PTZf68uavloeoLZJ1Q6fv0IUovi53CoULQD
	4AjmX/
X-Google-Smtp-Source: AGHT+IEUuW9bg8QlTMWLAqH69td2hTrkXFChXohr7qdzK/QeSnxfOSpCWKyzOtIY9j8ZkUYauqdddw==
X-Received: by 2002:a05:6402:34d2:b0:5d0:ed71:3ce4 with SMTP id 4fb4d7f45d1cf-5deb086a2c7mr8098949a12.6.1739474264545;
        Thu, 13 Feb 2025 11:17:44 -0800 (PST)
Received: from ?IPV6:2a02:3100:9dea:b00:8140:d035:b1a4:911d? (dynamic-2a02-3100-9dea-0b00-8140-d035-b1a4-911d.310.pool.telefonica.de. [2a02:3100:9dea:b00:8140:d035:b1a4:911d])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5ded709a92bsm695415a12.63.2025.02.13.11.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 11:17:43 -0800 (PST)
Message-ID: <a5f2333c-dda9-48ad-9801-77049766e632@gmail.com>
Date: Thu, 13 Feb 2025 20:18:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 net-next 2/3] net: phy: realtek: improve mmd register
 access for internal PHY's
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c6a969ef-fd7f-48d6-8c48-4bc548831a8d@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <c6a969ef-fd7f-48d6-8c48-4bc548831a8d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

r8169 provides the MDIO bus for the internal PHY's. It has been extended
with c45 access functions for addressing MDIO_MMD_VEND2 registers.
So we can switch from paged access to directly addressing the
MDIO_MMD_VEND2 registers.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek/realtek_main.c | 79 +++++++++++---------------
 1 file changed, 33 insertions(+), 46 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 210fefac4..2e2c5353c 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -735,29 +735,31 @@ static int rtlgen_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtlgen_read_vend2(struct phy_device *phydev, int regnum)
+{
+	return __mdiobus_c45_read(phydev->mdio.bus, 0, MDIO_MMD_VEND2, regnum);
+}
+
+static int rtlgen_write_vend2(struct phy_device *phydev, int regnum, u16 val)
+{
+	return __mdiobus_c45_write(phydev->mdio.bus, 0, MDIO_MMD_VEND2, regnum,
+				   val);
+}
+
 static int rtlgen_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
 {
 	int ret;
 
-	if (devnum == MDIO_MMD_VEND2) {
-		rtl821x_write_page(phydev, regnum >> 4);
-		ret = __phy_read(phydev, 0x10 + ((regnum & 0xf) >> 1));
-		rtl821x_write_page(phydev, 0);
-	} else if (devnum == MDIO_MMD_PCS && regnum == MDIO_PCS_EEE_ABLE) {
-		rtl821x_write_page(phydev, 0xa5c);
-		ret = __phy_read(phydev, 0x12);
-		rtl821x_write_page(phydev, 0);
-	} else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV) {
-		rtl821x_write_page(phydev, 0xa5d);
-		ret = __phy_read(phydev, 0x10);
-		rtl821x_write_page(phydev, 0);
-	} else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_LPABLE) {
-		rtl821x_write_page(phydev, 0xa5d);
-		ret = __phy_read(phydev, 0x11);
-		rtl821x_write_page(phydev, 0);
-	} else {
+	if (devnum == MDIO_MMD_VEND2)
+		ret = rtlgen_read_vend2(phydev, regnum);
+	else if (devnum == MDIO_MMD_PCS && regnum == MDIO_PCS_EEE_ABLE)
+		ret = rtlgen_read_vend2(phydev, 0xa5c4);
+	else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV)
+		ret = rtlgen_read_vend2(phydev, 0xa5d0);
+	else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_LPABLE)
+		ret = rtlgen_read_vend2(phydev, 0xa5d2);
+	else
 		ret = -EOPNOTSUPP;
-	}
 
 	return ret;
 }
@@ -767,17 +769,12 @@ static int rtlgen_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 {
 	int ret;
 
-	if (devnum == MDIO_MMD_VEND2) {
-		rtl821x_write_page(phydev, regnum >> 4);
-		ret = __phy_write(phydev, 0x10 + ((regnum & 0xf) >> 1), val);
-		rtl821x_write_page(phydev, 0);
-	} else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV) {
-		rtl821x_write_page(phydev, 0xa5d);
-		ret = __phy_write(phydev, 0x10, val);
-		rtl821x_write_page(phydev, 0);
-	} else {
+	if (devnum == MDIO_MMD_VEND2)
+		ret = rtlgen_write_vend2(phydev, regnum, val);
+	else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV)
+		ret = rtlgen_write_vend2(phydev, regnum, 0xa5d0);
+	else
 		ret = -EOPNOTSUPP;
-	}
 
 	return ret;
 }
@@ -789,19 +786,12 @@ static int rtl822x_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
 	if (ret != -EOPNOTSUPP)
 		return ret;
 
-	if (devnum == MDIO_MMD_PCS && regnum == MDIO_PCS_EEE_ABLE2) {
-		rtl821x_write_page(phydev, 0xa6e);
-		ret = __phy_read(phydev, 0x16);
-		rtl821x_write_page(phydev, 0);
-	} else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV2) {
-		rtl821x_write_page(phydev, 0xa6d);
-		ret = __phy_read(phydev, 0x12);
-		rtl821x_write_page(phydev, 0);
-	} else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_LPABLE2) {
-		rtl821x_write_page(phydev, 0xa6d);
-		ret = __phy_read(phydev, 0x10);
-		rtl821x_write_page(phydev, 0);
-	}
+	if (devnum == MDIO_MMD_PCS && regnum == MDIO_PCS_EEE_ABLE2)
+		ret = rtlgen_read_vend2(phydev, 0xa6ec);
+	else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV2)
+		ret = rtlgen_read_vend2(phydev, 0xa6d4);
+	else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_LPABLE2)
+		ret = rtlgen_read_vend2(phydev, 0xa6d0);
 
 	return ret;
 }
@@ -814,11 +804,8 @@ static int rtl822x_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 	if (ret != -EOPNOTSUPP)
 		return ret;
 
-	if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV2) {
-		rtl821x_write_page(phydev, 0xa6d);
-		ret = __phy_write(phydev, 0x12, val);
-		rtl821x_write_page(phydev, 0);
-	}
+	if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV2)
+		ret = rtlgen_write_vend2(phydev, 0xa6d4, val);
 
 	return ret;
 }
-- 
2.48.1



