Return-Path: <netdev+bounces-193146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D007AC2A7E
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 21:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8EE3AB1A5
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E832BCF4A;
	Fri, 23 May 2025 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiIWQR1O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB63029DB92
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748029150; cv=none; b=ZjfcqM6SLtrX3UCiZKzl2ET7h9Ccx+nOm5rcCu1L9z9SA7MndkuftTxGRTYlYtMhGQ31LNfKXGMZDJyGK44JFM5fG9sRFElbdd/cEX7HsrEy4IHOMI6PW2IErDUOOuNdlws9KVl0J/sOP98x0TJ0fW2R0b9QOnyr5cQZ8v1/QHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748029150; c=relaxed/simple;
	bh=gWz5jt3ZMg0gMVWNLiJwBgZED8XDrwtNUZxKscPKDWo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=SCMTm0rZx/MHCevd5kFweSFF8H5HBJ5y1VsLY1fP1/1ta4QBGa1zvjXYMATZ42fQomcs1odE5Fld2QggFC+gf0lE3RYTKcCUBd96HEcSJvooMsk5hwh9AnuokV2rUISVVar32rmF09xoK6W46ZmQ8qGML48nZ4J9lb/esPwePug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiIWQR1O; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-442ea341570so1008845e9.1
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748029147; x=1748633947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjk36lSrR/BZsXAJXIuyctl0mrPRQFWWW71s5CXfOJY=;
        b=fiIWQR1OULSArLkWqx0C0Nx7pBnA3wEnOl4VPOqd1fJro3b49d5pd9YxlF+YqHrMC9
         JzJSTUbkpY+/OcLByRXep/eK64OqPyr94AeeiPsDkiT/A2RjgVsY8Zr5+uowYYw48vFf
         byH7pICyiIQdiC4tnalwQSSyMOob+C1rdt5EqVchhc8lU07gqwtQU0vScvl3HmgT87IB
         4eqL3Q7JTitpL6vgmLc9C5wv2sXRbHMRy1EDHymkTkAVFobnAMrfSvCrw+js2QYF+vAU
         H6r4miuATKyCdNX3vWPKO2iiKLnTD246jyZoJVlKR7/IkPh4WbqJ+ZTAyKEQdPPFt0QY
         3dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748029147; x=1748633947;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjk36lSrR/BZsXAJXIuyctl0mrPRQFWWW71s5CXfOJY=;
        b=Bs2m5iwO3M3un735KMtQLupmTym8ho95H2bI7makU2f1jKGKgehkmyCweI3CIOUe4L
         Bn6glBMbriLXfMeTbTssYQHpB9iyp3B/P/r9IKs6R05rxrf9mnhZl1oSGC/b+5HU8ENI
         jPDbfJk4Hlodgf0zK8OJ06RtMLAqieBO9HmEVHSUZaMZhiY92rKnU4B3DsPFUBqjCtP8
         DlyJVOQtfn8HlkBPF91EvhtjIRTonKzxJVXC7JlAkPQhpd6t/iq93DZOrrYXWoy06C2l
         baPNrPVw8dUwEgn3E04SKkbxw+NMr9poDJ0XteC4F/AtlvWQaijn86kEXPefg+sWkszN
         VsIA==
X-Gm-Message-State: AOJu0Yy8oi8UZYunUJK/ETHHnRPCs/22TyA39Yelyqvz7r69tuNvfjkI
	sCkXGNG70tSTKFp9y7Osa6nGzVSjFWJgtJM9ImqeV8sSgkggaukPJYBs
X-Gm-Gg: ASbGncuLPSgN6iEIM2yvwrNRTLrNMEbPkTPXa2s4oKI5racU8VnLVL9mIdaJ2uVsSh9
	ch7WQJycQZpRdVeq7D09oSOH41cm+z6I20FG1YSQzhGvIOe1rXXwbISErBuVeDmQ35gmnCbxCn0
	EFHCdN0r+IhaSd5yFUptBgDbE1l4OVCASpWwXo7plBs36Tg/7UraaBpbriryRCJwT8PeG5B4Ccq
	Idp1psqe7LsV/8Td5Q5zZq8fxcYNj+i7eJaPRgXbstpHRBRjHMCstprxEFb5LREclYU4QkDLUFh
	ts8m0yzNZ3OdqXxS75WAl4bYxn9KZXyVmuoSo3UJmgZ7jzrtFIMUZWRZ8gnu54JKb5uzXfkRzK6
	BCGD6NloYxMkMP605nHxaKEsE6rPyWDwO1pmmO9OVZ85cOCg8jIla1Ox6WZVD+qHK/mdooNxzIi
	EH5yDfNf52QWt/3yYLpxZmEhA=
X-Google-Smtp-Source: AGHT+IHtDyDzo3kbk2e7lNAe7xvwqAiaaK9u0YiNKfzQvti0WCGVCknri0uRnurRtDzBvOby+VcSBQ==
X-Received: by 2002:a05:6000:2083:b0:399:71d4:a2 with SMTP id ffacd0b85a97d-3a4cb431fc3mr472091f8f.14.1748029146609;
        Fri, 23 May 2025 12:39:06 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f47:3100:348b:fd2d:79a:9019? (p200300ea8f473100348bfd2d079a9019.dip0.t-ipconnect.de. [2003:ea:8f47:3100:348b:fd2d:79a:9019])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35e49262fsm26797485f8f.44.2025.05.23.12.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 12:39:06 -0700 (PDT)
Message-ID: <87b2628b-c87b-4fef-9a29-41a4331d38f8@gmail.com>
Date: Fri, 23 May 2025 21:39:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: assign default match function for non-PHY
 MDIO devices
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
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


