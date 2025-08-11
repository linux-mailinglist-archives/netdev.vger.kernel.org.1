Return-Path: <netdev+bounces-212592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB46B215D4
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 21:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DA11A213A9
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0A21EBFE0;
	Mon, 11 Aug 2025 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nyzcmnit"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F8198E91
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941538; cv=none; b=Qi9z09upd8zKoX8BSf+0KSTp6mSNERkPnXSWvZMcluetxUcSEOhUJjOCSVV3yOtH1M6XxmF25kxWi0OueflghxSJNKUyY/HAUX8IXOPyg/CMMO5dkQGI1bZsbgjOaifYMGsW2RM3R9AySmSUhUcUUzH47lA0uJFj2KEvo/j0XjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941538; c=relaxed/simple;
	bh=pn5HsOVMyRe6SRl7gheQKs8wQG2YcOY3z9YEOMZA+aU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PFxdcrYHhRnakW0C2z0WwbUEMtAOG0DqB9IJbhcKfW22cUdvMcBsVEHdJAfGuTr94Z8kT4vQfRkjkRTCAijvRtKPPpL1zMgqtzBYqZlRw2Zud19gNunCVvWFuW8+sBka79zkTMrA+Ql/6F1QZnC+UDfFU18l6mSZXFBr26HqQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nyzcmnit; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-458bc3ce3beso28927525e9.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754941535; x=1755546335; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+FwVCWVcCfSJUmJvdrvCeI+WnKz8y3AGPAnnf0Gnwc=;
        b=Nyzcmnitkvo5FAgzJq2uAPoFKwn+Zuh6jH89kjYwIrfuc4lzWhi2D+GA9V68PKDKh5
         gNhfSH9+N2OboEQbUoHuTDqi3+L4z18lRGR9Ss5yWy1ez3XJHCa74Siu+41GG32W4QPA
         FFTZbiKVy33AImUEmNsBZN2H7HCOFg+LIHIuuf+7BfgO+wKlS5k+EIgSlR1DkmUqzW16
         17iZ7tgQymeao07AueTOYah483kTn4JZJi1weqSia4ySayzZHAIFB7nYrL7ipS16d2hj
         0NJ+R/Df4N5lQogWJXF+CHhx39RHTlPKaS4dp/Ub022SEcULEyF3x0/jj2eG+XjA5Yyg
         vOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754941535; x=1755546335;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+FwVCWVcCfSJUmJvdrvCeI+WnKz8y3AGPAnnf0Gnwc=;
        b=d9GNJIZb4k7O6Lm4MmKOQmTH2Rwi9PvTZQCq5HJTWoCUWyfPNnyx+DP4f9mEnRnbnf
         1sHazNisggVqgRunJv3rNAmRF7aL8iJvetUovSmCaZbXKX318bSXE1X+lNblSc3rMt6d
         c5SRJoOpPDYK5tTvuJ1STme7fUUpDC6MMzjPtIbl8moBnkTRL9kWxgTLZEJufEUTfKz7
         Hzp3KUBVxJ8vGAM7eNIr3lDy5Itwcuok+VyxCf/0SEyxfB9vVCs9G2TB09LLdwwBk8Uv
         JAIZFVi7mE6LolhOjm91Lzja/RkqYCoFLZ7Kl6xqR48Yv/SqlvGRQT9yxDhy4f493M7r
         u57Q==
X-Gm-Message-State: AOJu0YyHGmdAppvOLKVIMWcyeYDVIrVYl/+nt0jBgzGThXnVPzrRzvV2
	FU34QIxbDSOJ9MxRxIZ/8cVT4qRWYHMTVWxVWSNU8xj5O9875XU6jfZ+
X-Gm-Gg: ASbGncuV9YX5LgOLGV6Z42nXKzCAhWj9YN4wyhDmxnFCzm+nW03XL7cIMngPv+emHJv
	7zfwqrORtEDn4f5xaShJfEgbMs/+pOWEW7bPpDRuRz4MnC+1XZ5sEy0lbeFQZ3onAXxTM/7M5fm
	fx6lOB+09zbjJICwZzdBTysjfRDSHmYYQdb1tNhd6kpRgjN1Mt7m9sFIiPpiCmAti1vPbw65e/4
	+tdUTs7VW/MiZikOBMCPVAXjExfrAqrxz5sK6O3JO0rgSIY4CQRrhLea2dakLFcpQDg9kGOuNok
	y+gFpGD4OZ2dTAxC1kHIF8TCzTA2/IFgpU4C5pOaenUp7CECXf6Ky599Z1kBe0Pl5D5d9gH9auL
	bBBjOEMSRQtSeQ7/gRvYUbU2LuQ3CI611wk0srXcXZaZ2pluL5NE2F9rcbWZs17P6OBwT4cmVoQ
	CyPvaB/FZhJoBGl+/ba7kSSOd4CC8syl0t5Fj8+stnZukNvNWUZ1DDfhJutVgI3Nto9BrI0A==
X-Google-Smtp-Source: AGHT+IEuyH8yH9fbz0+FWFDrKQ1JIjoINFBk0qrAGUrz8m2tY55CMlah6zKnlJXkDjqYZdXbGuoYTA==
X-Received: by 2002:a05:600c:1908:b0:456:1e5a:885e with SMTP id 5b1f17b1804b1-459f4eaa7a9mr129774525e9.3.1754941534766;
        Mon, 11 Aug 2025 12:45:34 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f34:800:c8f1:8bb2:f114:3327? (p200300ea8f340800c8f18bb2f1143327.dip0.t-ipconnect.de. [2003:ea:8f34:800:c8f1:8bb2:f114:3327])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-459e586eef8sm263466555e9.21.2025.08.11.12.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 12:45:34 -0700 (PDT)
Message-ID: <fad5776c-2af2-4511-90c0-6d7c6e955526@gmail.com>
Date: Mon, 11 Aug 2025 21:45:49 +0200
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
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: fixed: remove usage of a faux device
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A struct mii_bus doesn't need a parent, so we can simplify the code and
remove using a faux device. Only difference is the following in sysfs
under /sys/class/mdio_bus:

old: fixed-0 -> '../../devices/faux/Fixed MDIO bus/mdio_bus/fixed-0'
new: fixed-0 -> ../../devices/virtual/mdio_bus/fixed-0

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 033656d57..7f4fc4df6 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -10,7 +10,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/device/faux.h>
 #include <linux/list.h>
 #include <linux/mii.h>
 #include <linux/phy.h>
@@ -40,7 +39,6 @@ struct fixed_phy {
 	struct gpio_desc *link_gpiod;
 };
 
-static struct faux_device *fdev;
 static struct fixed_mdio_bus platform_fmb = {
 	.phys = LIST_HEAD_INIT(platform_fmb.phys),
 };
@@ -317,34 +315,21 @@ static int __init fixed_mdio_bus_init(void)
 	struct fixed_mdio_bus *fmb = &platform_fmb;
 	int ret;
 
-	fdev = faux_device_create("Fixed MDIO bus", NULL, NULL);
-	if (!fdev)
-		return -ENODEV;
-
 	fmb->mii_bus = mdiobus_alloc();
-	if (fmb->mii_bus == NULL) {
-		ret = -ENOMEM;
-		goto err_mdiobus_reg;
-	}
+	if (!fmb->mii_bus)
+		return -ENOMEM;
 
 	snprintf(fmb->mii_bus->id, MII_BUS_ID_SIZE, "fixed-0");
 	fmb->mii_bus->name = "Fixed MDIO Bus";
 	fmb->mii_bus->priv = fmb;
-	fmb->mii_bus->parent = &fdev->dev;
 	fmb->mii_bus->read = &fixed_mdio_read;
 	fmb->mii_bus->write = &fixed_mdio_write;
 	fmb->mii_bus->phy_mask = ~0;
 
 	ret = mdiobus_register(fmb->mii_bus);
 	if (ret)
-		goto err_mdiobus_alloc;
+		mdiobus_free(fmb->mii_bus);
 
-	return 0;
-
-err_mdiobus_alloc:
-	mdiobus_free(fmb->mii_bus);
-err_mdiobus_reg:
-	faux_device_destroy(fdev);
 	return ret;
 }
 module_init(fixed_mdio_bus_init);
@@ -356,7 +341,6 @@ static void __exit fixed_mdio_bus_exit(void)
 
 	mdiobus_unregister(fmb->mii_bus);
 	mdiobus_free(fmb->mii_bus);
-	faux_device_destroy(fdev);
 
 	list_for_each_entry_safe(fp, tmp, &fmb->phys, node) {
 		list_del(&fp->node);
-- 
2.50.1


