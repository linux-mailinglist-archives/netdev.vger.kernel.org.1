Return-Path: <netdev+bounces-164924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5235A2FB0A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 21:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F5A163E2E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2F926462E;
	Mon, 10 Feb 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0Zpd0Mf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6187426460F
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739220586; cv=none; b=hUUWckf7oHxuGRdwDoVZEwo35N1UeG+uwBX6cFyUIvjBkCxbvUGOinpjIfOk4zRaxVgLWiO1rIEsk2TBBauHXHYzq4EKBDsZrCrw2ub8JJuxiArWjABZ9n6KyIJtSFgt3Iq9b1D6I7g/d1eBR5++SXrB4wnqwmdzW5wQQcORyCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739220586; c=relaxed/simple;
	bh=qSFiO/LkDE7piUN1cUTDHmKmaP7oFBhTIZJkaoor0Fo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FGZxh4AYlYcq+dgo4a7j9759KJvBReTu1LRVZadVYS4C1WTPmC5ZZaA7N5qwksr2hnAp6lwzE8yGU9wsSVkUW4haJy1NBaBsc0rRTifDefteAaKq6DVplcQokMab2XH35T+kd0z3pkE5xfjsY5gHa9wLMG5paGpwrIlDeRBxWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0Zpd0Mf; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5de727f7f05so2747231a12.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739220582; x=1739825382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=18UJ2rVXFkJakDPV3oU7ens0z33A2hhwh7Igmbv2Eic=;
        b=C0Zpd0MfQqpP0Lnc07hR3HclnafeTYobJSibKYm3s5ip33eBt7SM3YHxAR2JJcpLoL
         PdkRhyOxcR3f1SmVx+hizOKC05ycX7gk9kd9gbgsPLGIE8ERXrnaTmdW0cFNeCNmr45m
         R5cd4a8Bc1Kjo0fF/EZLJQgQT2I3ldu1M5F181neNyY4uwcxlzyY7t4+iskGilNJjklu
         C2QqTIiiYL661s9fm6ny7cHWMdAoYS753dTt5aOV66rlGJSqnqA6I2SE+CTyjI0DyO/w
         Uls4BSt9POa3IgilMXKOa7OvRwRetz+IGNH2d2vzx6MP7XMQ2zW2DGnRAH0Y0r35Ztoe
         zkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739220582; x=1739825382;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18UJ2rVXFkJakDPV3oU7ens0z33A2hhwh7Igmbv2Eic=;
        b=OK3I819J0ppcAGYsFuzzYRjqWNhK17J+9X5MRD+n5RTefBkoC4hr1GhAxFIBVZ+Nj+
         58gDWCVJNqZfJGPnVTphQIaOpTY0qH7ClddEdLw0ej+4F8MD9Tp6f4/nQZk0FKGTeZEH
         ThM269cJ3+dQAiutdnjz797Qr9oPHEg6p9WlgzLcqwCt6dtD7h3cMK6NFjd75joOhHDs
         e1T3HAMPqD+FumoJD4hRE++4MErvuyP68DKytKcsUoIHaJU9DSJTfFC93ZVfYCLEs0s8
         hp2lJv9Y//hMwknc0B98afUj0Erh11Ml306JfyuX0FxqftGTpMsjr0H1sME7pkpBWE09
         CVzg==
X-Gm-Message-State: AOJu0Yw1USxRHYD03ejI0glXx+Yw8XrjQRIFufTetxN4b2AAGCt8a7JL
	p0PMVp+pYQYWmLpsFnuykyOIpfL/0mCIIeGcJHESNxytzyymjSff
X-Gm-Gg: ASbGncsXEbAN+LnST6G8o1QJmM3LZRtNxLEqRz/vx8kGjsNPVC4WUjjQIYvQYEG9kHc
	zkVAUW0Kg2katdMMuT7ixCVhIDtJqiiKn+u0G6jpvrcSAgB+/zQ73cSgNId4RhkMievgA1IAw35
	RvTkerx1qZKdzxOxrhpq9qtzki2mQtVNfSIRiCUjHJV6+Ro1mCofeZ44/JNOMYCjY+x/Eaan83h
	zPBsYXMa1GQQ3Jgx4grJHYyvSE/nJ581phEcXlVugz8GegDjx9kBSXVTRjzQ4IWgr3epOYXz56K
	oODA6S+X1sC6nFb2LmAde/f4TF6bC9qhqpvds0IS2m7dLdERt9k4OAmJp2SzMXykT1cAykn7bKh
	dXm227qylpw28jILXSX/Bw+Vqn/RslYx1x8638P5rU1nzchmWHcz0Y5c7Iljaa3VoaxXB/vNnwx
	QaFty1
X-Google-Smtp-Source: AGHT+IFoaK/7msACe9a1an7H/Zy8XqiFml8arhnR0QfRcsvaqVSteq4JrnduVf574HWMzW5nzacsNA==
X-Received: by 2002:a17:907:72c5:b0:ab7:c284:7245 with SMTP id a640c23a62f3a-ab7c284dcb7mr483035266b.18.1739220582468;
        Mon, 10 Feb 2025 12:49:42 -0800 (PST)
Received: from ?IPV6:2a02:3100:af5b:5100:3572:f08a:34f2:f31? (dynamic-2a02-3100-af5b-5100-3572-f08a-34f2-0f31.310.pool.telefonica.de. [2a02:3100:af5b:5100:3572:f08a:34f2:f31])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab7d3d3c458sm99893366b.128.2025.02.10.12.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 12:49:41 -0800 (PST)
Message-ID: <30deb630-3f6b-4ffb-a1e6-a9736021f43a@gmail.com>
Date: Mon, 10 Feb 2025 21:50:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/2] net: phy: rename phy_set_eee_broken to
 phy_disable_eee_mode
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d7924d4e-49b0-4182-831f-73c558d4425e@gmail.com>
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
In-Reply-To: <d7924d4e-49b0-4182-831f-73c558d4425e@gmail.com>
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
index 7306c8e32..32eb4a448 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5252,9 +5252,9 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 
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
index dbc7e7245..29df4c602 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1347,11 +1347,11 @@ void of_set_phy_timing_role(struct phy_device *phydev);
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
2.48.1



