Return-Path: <netdev+bounces-143216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F7C9C16CB
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 08:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466011F25225
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 07:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA981D1744;
	Fri,  8 Nov 2024 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEDd6PhA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88071D0E2F
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731049709; cv=none; b=fOPsNRyH4LFVOLqP/1OQFEScs3yQd2pRjp2hT9ERdGyzWVYXc2rpnZF8wyjuS13g/o5sHWQlOk61fFgVdTtfFfn+oKh00jUlbw6b+dhjLmglK7H9in+fR6XDhCkrp+1BReLZQSmif87iSqPuLH6PtgLjiWDPXtzX3oXEJJU8kGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731049709; c=relaxed/simple;
	bh=lE7uKf6pWZJDFSv2uv3JCkgPGmzz9Bjds0fHuhU7mzM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kjYlhZs4Gh5VRrzviPVEvwfF5qBwu93HCfVvoJpMrRshPxY9kvQTNCZhHnt+7qVI6Rel9PJLrhhsKhVEdn5dPG93hiVItpi1x6YQH6N7POX+daAHAFtOusEM+H4Nt0x2evd8d/b5HlKUmU1Ucv3YAGyC2CvJ5PPIEmt+FOdUn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEDd6PhA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so1181484f8f.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 23:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731049706; x=1731654506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+9YKObD9/7toe60kq5PcQq2Xt0NwClGXHikL8XNFMHg=;
        b=EEDd6PhAAUAdJ5Nn31FTxvRMWsH8b821qRfsqyNfTy41sWAkrH0Z/RXjMaCyNpZh9r
         RmydHqd3trjG8OScV31xSf8YjuQiR64vTbQC3HG9/AbxKsQ6Sdigi+JZA+JkwY2K7WDp
         EYeNxwDxXwwA0ZJB4h7GY67vKVA2hDSUDionwtk4Lv+GIBhIlEJGxObRH2TPimUtp+V3
         Wi5qJbD+j5Fy2nsrw8K7lcsnF1zJ4CA6TseA1cpXMAIN4KEk1T4kI6sUsuANgJDe8Guf
         gSAF2FjRjW4ZjbUOjo81LNw76iYQpliH3kCZr55+hd6UJQ05ADNCCGoBBWw/U9gOU2Tg
         MEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731049706; x=1731654506;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9YKObD9/7toe60kq5PcQq2Xt0NwClGXHikL8XNFMHg=;
        b=DeezEnBlRZLS1/Niey+GHYK8OBSwvS/gOzRvXGX76r7Sx+A1IGap+Glxl2rEEypicm
         KaGWJhWhkz8iILwJXF9GqCoM+gzwBsGpsdw80OcI+18nmvc+HxJWqivOJB2wkoO/Mvl6
         pa/uenvQtlIoK2i8qDvHzlf2R0UObKUH4kYfLzdjIxDSoL0acOijRcxoJSHWTQsOT/d6
         3Jm4ssvEJWRCwuQPd6MiTlKlkJa/JqYUasexrzTJtMhhe3jdZW9rfyE2nqa2QmYGdHfM
         0smth9w+HmFeowtuXPAI4PS+/1fhl30/xPZcU6cHQ7zOtOAQKv0M77cu6l/dqfRdgf2R
         0eKg==
X-Gm-Message-State: AOJu0Ywel7EBi6HW80YeHP5b+zW1oalK0+tQVY64jGGl5bZJnSBWoTRP
	rMCMTVoY6NSxTfAioOHFuSJt6jxxyGrabf3bJUpvCRfHLrZ5X8sv
X-Google-Smtp-Source: AGHT+IE0So6olj+24OjOdDz0kgsxNQDKt9r+NLEtbKXMFB0yLKBM0csemcndU1CXiUSClR3iALqzMA==
X-Received: by 2002:a05:6000:78a:b0:37d:4956:b0be with SMTP id ffacd0b85a97d-381f172a911mr1512106f8f.18.1731049705790;
        Thu, 07 Nov 2024 23:08:25 -0800 (PST)
Received: from ?IPV6:2a02:3100:a8c7:1100:21c3:489d:8064:fe8b? (dynamic-2a02-3100-a8c7-1100-21c3-489d-8064-fe8b.310.pool.telefonica.de. [2a02:3100:a8c7:1100:21c3:489d:8064:fe8b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed9ea5d9sm3746315f8f.75.2024.11.07.23.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 23:08:24 -0800 (PST)
Message-ID: <ce185e10-8a2f-4cf8-a49b-fd8fb3c3c8a1@gmail.com>
Date: Fri, 8 Nov 2024 08:08:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/3] r8169: copy vendor driver 2.5G/5G EEE
 advertisement constraints
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <405734c5-0ed4-40e4-9ac9-91084b9536d6@gmail.com>
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
In-Reply-To: <405734c5-0ed4-40e4-9ac9-91084b9536d6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Vendor driver r8125 doesn't advertise 2.5G EEE on RTL8125A, and r8126
doesn't advertise 5G EEE. Likely there are compatibility issues,
therefore do the same in r8169.
With this change we don't have to disable 2.5G EEE advertisement in
rtl8125a_config_eee_phy() any longer.
We use new phylib accessor phy_set_eee_broken() to mark the respective
EEE modes as broken.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c       |  6 ++++++
 drivers/net/ethernet/realtek/r8169_phy_config.c | 16 ++++------------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index c7dc8b539..ddf127644 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5295,6 +5295,12 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 		phy_support_eee(tp->phydev);
 	phy_support_asym_pause(tp->phydev);
 
+	/* mimic behavior of r8125/r8126 vendor drivers */
+	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
+		phy_set_eee_broken(tp->phydev,
+				   ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
+	phy_set_eee_broken(tp->phydev, ETHTOOL_LINK_MODE_5000baseT_Full_BIT);
+
 	/* PHY will be woken up in rtl_open() */
 	phy_suspend(tp->phydev);
 
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index 1d5b33f6c..5307c6ff4 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -96,15 +96,7 @@ static void rtl8125_common_config_eee_phy(struct phy_device *phydev)
 	phy_modify_paged(phydev, 0xa4a, 0x11, 0x0200, 0x0000);
 }
 
-static void rtl8125a_config_eee_phy(struct phy_device *phydev)
-{
-	rtl8168g_config_eee_phy(phydev);
-	/* disable EEE at 2.5Gbps */
-	phy_modify_paged(phydev, 0xa6d, 0x12, 0x0001, 0x0000);
-	rtl8125_common_config_eee_phy(phydev);
-}
-
-static void rtl8125b_config_eee_phy(struct phy_device *phydev)
+static void rtl8125_config_eee_phy(struct phy_device *phydev)
 {
 	rtl8168g_config_eee_phy(phydev);
 	rtl8125_common_config_eee_phy(phydev);
@@ -1066,7 +1058,7 @@ static void rtl8125a_2_hw_phy_config(struct rtl8169_private *tp,
 	rtl8168g_enable_gphy_10m(phydev);
 
 	rtl8168g_disable_aldps(phydev);
-	rtl8125a_config_eee_phy(phydev);
+	rtl8125_config_eee_phy(phydev);
 }
 
 static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
@@ -1106,7 +1098,7 @@ static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
 
 	rtl8125_legacy_force_mode(phydev);
 	rtl8168g_disable_aldps(phydev);
-	rtl8125b_config_eee_phy(phydev);
+	rtl8125_config_eee_phy(phydev);
 }
 
 static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
@@ -1116,7 +1108,7 @@ static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
 	rtl8168g_enable_gphy_10m(phydev);
 	rtl8125_legacy_force_mode(phydev);
 	rtl8168g_disable_aldps(phydev);
-	rtl8125b_config_eee_phy(phydev);
+	rtl8125_config_eee_phy(phydev);
 }
 
 static void rtl8126a_hw_phy_config(struct rtl8169_private *tp,
-- 
2.47.0



