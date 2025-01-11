Return-Path: <netdev+bounces-157389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E596DA0A220
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C423A6DBE
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1E482899;
	Sat, 11 Jan 2025 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB++ZduB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3494924B22C
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586312; cv=none; b=sIkBslVpOILV3SX/bmKRhjG22KNoYBi3x0q7qAOESA0CWa+5MlYIETrkc2738nFcZwXbP00sZe8tXmie5OgaECuaDfYAB8WBYkQNXXrl1SnOIXKqlprxiUfYY0cOfLuQEA1EOq8VZ8VIhm7KLOOgGzshTPdjzTt+5+MDf0wA5II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586312; c=relaxed/simple;
	bh=EWAYERHtUNysaHjwIGobdCdTOhWtkr0aHok8S4aBOnM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=okI+4xgyjWow5Zfwq5N1yKOWfkLsGL3Rqo7usBGZJ1mj0O7h2X7uqKZrCZKu5KubPAeTOcAutHb0Sn9mt+AN1zizL9izMq/Qu4ov4y3aigtI0QI5Ad/A29c5FaPqhFJkgnDaKktm4tLisIcTePsIsypXoH8mo2s4tcvRVEfoLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eB++ZduB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so505796366b.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 01:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736586309; x=1737191109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1vMWGZGJB0wSpyvnBU07N6sSx7cJJIas5pZC5dMSmqM=;
        b=eB++ZduBI7G1TnhRQabEh+9zj5hWCo2zvtGGXmBFRgbxjIWb0BPsDNBP73oMQh+h/R
         qhX33w7zvEO2wrJhIuecvRHL0KXv93t0QFNznewrXAVcfeEtenYqOsMoNUR+FGpZeSpL
         b7pbgxaNgB1KWH/Q59DuUkJulAg3X0SMWdnNDBV9Z3nToQ7MXSdd0vgaQp6azZ+rZoW0
         cAxaIWJvTKeeZQLJEWJvLw4Mp2P/nEo2OXr1dwtG5hCiPaef64434Dwa7k68nA46+blu
         3ehlONmglBcZNjW12h4HDlz/IlrEUV67p1xMQyW69wFDArrD9kiuY7ek8S1P/WQ/qVD+
         I4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736586309; x=1737191109;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vMWGZGJB0wSpyvnBU07N6sSx7cJJIas5pZC5dMSmqM=;
        b=e21tMRbbladJGnQ8n2bCU7T+3oBhGwUwq+9QTWaLVzAhc/cqWqGbgbRO31GHxtD6yC
         1XmDndhf/MvJNXriOIaLqKU2HqS5D1Fj9twY5+dGJKSpT5BMAVtgA9MgalfyK+BbSqzd
         JpvfaNLICcaAX2NfcN907incSt3B1P950RaF8Rla6eVhgf2lVEsm2GxKlQEvSzU0tG4R
         7e5I38XwnrUThQYa4ICjAGaX28xWWbItAmRmQuy1eawMcBQYm9X8P9E/zxyF5BEt8SR7
         aRjJJAg/qoBpAUTzMO7reElQ2NaP5sF36QLywIp3E+1EyssQMyo4nLMO2sH+cHmNz/rq
         rYbg==
X-Gm-Message-State: AOJu0Yy2+XsNBGcL6bymipNdn0Ll+euzDgezgfS0+1PBbhU0BhC70gVN
	72TIIt5+c4fJvdOLiw6BD7EigwLkPH1FoBGvHQ7+NOJ0lv3dzI8j
X-Gm-Gg: ASbGncuPh7GfcI5ckOzmd5tEscypBIjIRpIGZW0dpdzZEhpEZrnbCf/Y0Q/0XzLhwND
	U0KGRuIoKBsgIYSIOhbtUms9MVXwOsa8RCs9oCwBt3GKjXaL8XJuOXqLbi3JpDG6Hhgxii/zmZd
	OKfbgrVrFu8RF0NAaBlYjJiHXxQNgkOtl3O2NcaV6652OzU1GQC4v5snf6iyopxL9sBCL6MXrnH
	pbyJb7HDcaa2YPObyK/fGZlR0FEW2saOSBS6p//3A5tQe30P3efBMPqXaoqEYfysPDvB3rZGS5z
	4TGnES+HH3B/7dlmtIq+SepAPQ4R782phn8nmgMupaEPx29XZa87+Pe+8td6wlkX6akJtdZq4z7
	HLzVNBwYk1I6kOon/QVD2Yv/mv23+267DqHEnMqibliSKVhde
X-Google-Smtp-Source: AGHT+IEqEGfxtaEgDNegpvhX7QSA4uPnwWLZhEkG1VgGqFUlEkrB24y8O6JBE4mtInJaOvnAZtdVzA==
X-Received: by 2002:a17:907:6ea4:b0:aa6:90a8:f5ff with SMTP id a640c23a62f3a-ab2abc8f08cmr1037008466b.50.1736586309343;
        Sat, 11 Jan 2025 01:05:09 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c90d6838sm256129866b.55.2025.01.11.01.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 01:04:31 -0800 (PST)
Message-ID: <bc6bbf68-ed9a-463c-8e31-120d1fa233e4@gmail.com>
Date: Sat, 11 Jan 2025 10:04:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/9] net: phy: rename phy_set_eee_broken to
 phy_disable_eee_mode
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
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
In-Reply-To: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Consider that an EEE mode may not be broken but simply not supported
by the MAC, and rename function phy_set_eee_broken().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 6 +++---
 include/linux/phy.h                       | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5724f650f..bf368b32c 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5222,9 +5222,9 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 
 	/* mimic behavior of r8125/r8126 vendor drivers */
 	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
-		phy_set_eee_broken(tp->phydev,
-				   ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
-	phy_set_eee_broken(tp->phydev, ETHTOOL_LINK_MODE_5000baseT_Full_BIT);
+		phy_disable_eee_mode(tp->phydev,
+				     ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
+	phy_disable_eee_mode(tp->phydev, ETHTOOL_LINK_MODE_5000baseT_Full_BIT);
 
 	/* PHY will be woken up in rtl_open() */
 	phy_suspend(tp->phydev);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index c5dc2dbf0..7138bb074 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1318,11 +1318,11 @@ void of_set_phy_timing_role(struct phy_device *phydev);
 int phy_speed_down_core(struct phy_device *phydev);
 
 /**
- * phy_set_eee_broken - Mark an EEE mode as broken so that it isn't advertised.
+ * phy_disable_eee_mode - Don't advertise an EEE mode.
  * @phydev: The phy_device struct
- * @link_mode: The broken EEE mode
+ * @link_mode: The EEE mode to be disabled
  */
-static inline void phy_set_eee_broken(struct phy_device *phydev, u32 link_mode)
+static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode)
 {
 	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
 }
-- 
2.47.1



