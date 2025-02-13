Return-Path: <netdev+bounces-166220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4723A350B7
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 22:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDD33AE0D1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 21:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A59826981B;
	Thu, 13 Feb 2025 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8ya4rUB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5141E245AF6
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483483; cv=none; b=gWu8eBSZRfDj8s9piybMxYL50g6w1odMb61Tb7ImjoK9bth0nCdX8kc1SQWTS/e3JQOj5AP+2pbGfF99kvu3IDnTdE5qyZDSo/n88QJ/nEwXv+cHgLu/nQJBCTIWinf+eNaFEsZA8B1o0XYFnWszMi+OZs/lvUFkrRPXixaDPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483483; c=relaxed/simple;
	bh=+vlRvOZdRRJ1sH8RUL5QSUlub92836ZrUVgFrM5Ak9s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZXnxHPPwXnC5nPCCaFimGJSD3I9JMot1iVMuiJSSCJIldHLF04uDO3nbj4ip7dHKpuZOxu7aVGOVKsjxo0qqx9+QrztKU4y5k/D9mR/AIED8UtzEiyaBWi4hK9A+a3X3nT7tlXjNQkZnQK6x4D0a68x5kYm8P8lrvEKpzW8tqJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8ya4rUB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7e80c4b55so286414166b.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739483479; x=1740088279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=16kLc939+TPQhGWtU56YbQZOiLpD6r+a3D8dt/D5Rag=;
        b=Z8ya4rUB5he+AmYmVbOjkfvEH+P8s1uzwvbrgrhC6li+WKywEMtHGuuwqbsx652UAq
         clK/lslP3cbE5f4Qtnfqp42cK4RwFnw1fWH/cFX1tm8S0M3SI2R9LMWk/WgVhY3z/JRR
         /MDfMa3x2z0P/P6gekbe/8okiWuv7T68DxgNm0O9rdtkLmlc6TE5xr0s68KzWXRCtTG5
         mtYZRbNCqOd/mZlFcxOS6+aeB9EG/svchu9mVb5soG4NvcfBIzVTooshQOhC8aYVpf7M
         gNIwtILkWREtLXM2JGf4eTF3lCEdLCTwgd7sHsRzaJtBGkNIwRXr91h81M9nigqaZV8/
         qiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739483479; x=1740088279;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16kLc939+TPQhGWtU56YbQZOiLpD6r+a3D8dt/D5Rag=;
        b=wDVy/lXnL4XVlkNk9oQuAMRPyVNH5bXqS4MY/KHVSt+YOOtMVjjrZEIx4oMTqgt+cM
         QV3xMy4bRmN4Cv8OlPqaoPtnbNvbIp2ia4zYUL2n1tQrsqgLEx1qmTavtyWZGYZyV4Ks
         W1XI/H4UpudGPFJhWjlij7B095ZEjOHesjqzM8rG4vFlFKJdjN/P2RJuyhLJvRzfWpvD
         WovgwVuFeZzwmnH/dV0ErquYtZSYpxC573GUBFeNcQOWlSC1wfYMoWYlXrk6Pq40d+OQ
         Gd4qe2cdJDIfh/wqzkxcIBznTvDlk7Lowm9eNcXy0vPYYPXva3LpolRBEp7LwrCsA/+1
         PtYg==
X-Gm-Message-State: AOJu0Yw3u6O/TKr24/LxyDdABGQ8sEew7Lqis39rKXrlPNIBax4VvyVi
	D/uoFTXaAyXeuXmlvRME1JYxuCZ1/3g3D2EX4XjVzGKEt+z1J987
X-Gm-Gg: ASbGncuRGScanmwpS5k1yzJkgoGCVQis3TbdiBXk6fRMdV9IJtsgSJlwscbvdgaX7Hn
	8PxZUsIOh9kaA0byXt6z1VKBqCvc0jl67Co1uxUmQ9UWay+1oy/Dc6zx8C3tMqPU7E+IIGg2tpO
	iAqDuFqacH6Sg7uWP2lP9ObbhVqntTVRiPjdZhTFfZeLBnbwQWTCmdHnSy5w+9vXFQoGK8kmDZu
	32moSbq/9aH2Yua+FRo2bmcPHZDSReKNw0KU/jRSy8Vv/f4SfGh4BXA02+h+H+7Jk0kwC1plYRg
	KiMXl45L482Ehq8h1Po5ikKH5Z27cIa9Af7oEWK8wQCQ6HeNnKCVIuA7+ek1Pkz/qh0JOXDBRx6
	DV2HALw+/8+nBM3U+/RqKsc5MM8zKYhFX0NsnwW3dBmtZXtbnFo18IZZiMqFJIdbukcr9O4ItM3
	IWx6oP
X-Google-Smtp-Source: AGHT+IGKXqB4YFJPO1uq3mDWXlg2H2f5Xu9slQTYuHrYMMc3yu7Lw3fuqWJZzAPIfPvYdxerHwmk2Q==
X-Received: by 2002:a17:907:c10:b0:ab6:9534:98fc with SMTP id a640c23a62f3a-aba4ebcebb0mr486833466b.32.1739483479380;
        Thu, 13 Feb 2025 13:51:19 -0800 (PST)
Received: from ?IPV6:2a02:3100:9dea:b00:8140:d035:b1a4:911d? (dynamic-2a02-3100-9dea-0b00-8140-d035-b1a4-911d.310.pool.telefonica.de. [2a02:3100:9dea:b00:8140:d035:b1a4:911d])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aba53258196sm210439666b.60.2025.02.13.13.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 13:51:18 -0800 (PST)
Message-ID: <f3f35265-80a9-4ed7-ad78-ae22c21e288b@gmail.com>
Date: Thu, 13 Feb 2025 22:51:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 4/4] net: phy: remove helper phy_is_internal
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
Content-Language: en-US
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
In-Reply-To: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Helper phy_is_internal() is just used in two places phylib-internally.
So let's remove it from the API.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy.c        | 2 +-
 drivers/net/phy/phy_device.c | 2 +-
 include/linux/phy.h          | 9 ---------
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 8738ffb4c..77b3fb843 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -302,7 +302,7 @@ void phy_ethtool_ksettings_get(struct phy_device *phydev,
 		cmd->base.port = PORT_BNC;
 	else
 		cmd->base.port = phydev->port;
-	cmd->base.transceiver = phy_is_internal(phydev) ?
+	cmd->base.transceiver = phydev->is_internal ?
 				XCVR_INTERNAL : XCVR_EXTERNAL;
 	cmd->base.phy_address = phydev->mdio.addr;
 	cmd->base.autoneg = phydev->autoneg;
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 1c10c774b..35ec99b4d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -544,7 +544,7 @@ phy_interface_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct phy_device *phydev = to_phy_device(dev);
 	const char *mode = NULL;
 
-	if (phy_is_internal(phydev))
+	if (phydev->is_internal)
 		mode = "internal";
 	else
 		mode = phy_modes(phydev->interface);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index bb7454364..8efbf62d8 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1729,15 +1729,6 @@ static inline bool phy_is_default_hwtstamp(struct phy_device *phydev)
 	return phy_has_hwtstamp(phydev) && phydev->default_timestamp;
 }
 
-/**
- * phy_is_internal - Convenience function for testing if a PHY is internal
- * @phydev: the phy_device struct
- */
-static inline bool phy_is_internal(struct phy_device *phydev)
-{
-	return phydev->is_internal;
-}
-
 /**
  * phy_on_sfp - Convenience function for testing if a PHY is on an SFP module
  * @phydev: the phy_device struct
-- 
2.48.1



