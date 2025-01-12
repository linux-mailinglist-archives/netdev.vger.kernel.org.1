Return-Path: <netdev+bounces-157536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B22DA0A98F
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEC01886E70
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FE1B425A;
	Sun, 12 Jan 2025 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czMYrtdm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5406199223
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688768; cv=none; b=a2sj83B7/lHnlr+muUPkakcxd2/C9rHogycRTsLvt1azjvCvnQo/C61rEaEYdshMLMAOK9UJwJB4oPhd88pmN9Vkg4mOYiueV5XyLF5AZUcmTpzJABOAYmUjJFRjLpIEsTXFXAyMrnKw/qUdKPmSgmDlYe9WI87SqSz/OUAhuA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688768; c=relaxed/simple;
	bh=r7z8eqtCmyI8Zx0zERC05KLHEfA81ZdzkX32UZtxx1o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hbk40tj8DsAGwFsxDX76OgBW1j6mNPfjSAdQ8hMqYSHviW8CGs0JbhzUH8AYR7H435ATxylRvBd6ZNjJNmI8VegTY5FEabAccNoJxtCIxa00eyTCaW5wAFfHE0Vrgo58BIbz5W6PXC8xlV00HaXu5GYflIImWeA1RyGQdjOtvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czMYrtdm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43675b1155bso39931755e9.2
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736688765; x=1737293565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cYmcB215+jwaUbaNV7Oq5DO/Gb7KhJLZS/KcDfNJSGY=;
        b=czMYrtdmSmaPmrs1uRy15jxuN3VDBL8T67kY6rcPQrYz0rYbX3Cf+UJbRzqB4YcSDG
         nYJax3b/9KTcFKeyUKq0HJpHSbn7cv74oCFfluwWgRJE1QLpsTRLxG7OYEEqIKrUbzra
         DaFQcEpt8YcDmgF/x7tdAg1D/NAzlbbB9Pyq/0+AeUWcYsDMyrh+eFc9PMpzC9KwWl5L
         u0oSN7e+nP7kCPrSfUAcfaZ7K0142N2hM3FlHT7Xe/JqxCtsXgYytxV+9M+fowLdnd3u
         MG5NRDRYo0vF2K2oTP0uroXdoSLSnvRPurX/3ryPZJMIqd3tLne5UCL1GPg3t1BknSwi
         WMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688765; x=1737293565;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYmcB215+jwaUbaNV7Oq5DO/Gb7KhJLZS/KcDfNJSGY=;
        b=K2YLz5QOzvO7YaW9YajxdRD+ZPO2Ks1QqVP2jq8s9aa6uqj/S8TJv/d10pnsBZkUSd
         lZ5Ul2vG+LLwgnK/2DbnJLsHUsRSIQoL7h+xLCZXp5nkstwK+fEESHw7LrWSsv9fkr/y
         vq13c2GPSPGogWRYe4ji5rqobLcBqx/0kV0YTF0R6mO1nB1zcR3gtM48mVTllhMkSEpq
         ttPjtIk8wRu2GzbeYP+u0rTiw336hzjujLe9JvipkwwrfuslcqIU0Gjze0xhR6bmYLEX
         dIQD9WqbjcSo4Q8xdan08cwuYUwjcfONAygH8KzAHMSiYqzLPLOrhmNlKQKzlfOR87VU
         yufw==
X-Gm-Message-State: AOJu0YwtKS3nqaKTf+lrvLyOqHSp+tU1VnTVtSGxW9LnNamcBA4IN4bZ
	zADUKHGLEBmYyWei7VL7oorzccySXGaHbTli4fnVE+CuO1cQy8Rw
X-Gm-Gg: ASbGncswa1r5A4C7FpH8hgWXBuJzuOseMTLj10d/BAnHKwz50HgcDp3uit2zjlIXEaP
	nbUaGj2wf1oAzT94y2tiBYIPqqyBvbYqm1EkPGRhEOquKke+O1HyXZl9QRXLI12DgonDfNc8GZP
	vOZipk02P7OnEpH45/NWoM4dosm+ac9gx98Q5p+ynZQOxZlkjEgeE2gljRVttuFr6GxZKE/ZLam
	ZgD8G3eTxH8kgk+8dSJ3qbKBzYcsLhw6QisMqSO7AiAMwVWT1FDndfut4RzB+pn9pwJva0PFInx
	FivyvB6auZxli/KZwRNUZd+rGiC+NfFl7orcnh/1v9N0COA8qx7ZFQz7PAywL9qygV6SZJ8vEJE
	KJgHvaCKEGEER2icdnPcf327vQBjrwJbXeBT4QG8Bctpsp6XW
X-Google-Smtp-Source: AGHT+IG2rFhiT9oIwlz4RjWhu6CrQA18Je90c8mOAldJVDX9/StJqYqVolhjM+Gttg6ILor50osTnw==
X-Received: by 2002:a5d:5886:0:b0:386:4312:53ec with SMTP id ffacd0b85a97d-38a873049c2mr14957778f8f.17.1736688765322;
        Sun, 12 Jan 2025 05:32:45 -0800 (PST)
Received: from ?IPV6:2a02:3100:b0d5:ab00:44ab:526d:76d3:604a? (dynamic-2a02-3100-b0d5-ab00-44ab-526d-76d3-604a.310.pool.telefonica.de. [2a02:3100:b0d5:ab00:44ab:526d:76d3:604a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e9e62126sm110995075e9.34.2025.01.12.05.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 05:32:44 -0800 (PST)
Message-ID: <6cea2ecc-d2a8-4df1-ba4a-b54855090acd@gmail.com>
Date: Sun, 12 Jan 2025 14:32:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 08/10] net: phy: c45: Don't silently remove
 disabled EEE modes any longer when writing advertisement register
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
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
In-Reply-To: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

advertising_eee is adjusted now whenever an EEE mode gets disabled.
Therefore we can remove the silent removal of disabled EEE modes here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 2335f4ad1..904a10c02 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -683,13 +683,10 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_mdix);
 static int genphy_c45_write_eee_adv(struct phy_device *phydev,
 				    unsigned long *adv)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp);
 	int val, changed = 0;
 
-	linkmode_andnot(tmp, adv, phydev->eee_disabled_modes);
-
 	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP1_FEATURES)) {
-		val = linkmode_to_mii_eee_cap1_t(tmp);
+		val = linkmode_to_mii_eee_cap1_t(adv);
 
 		/* IEEE 802.3-2018 45.2.7.13 EEE advertisement 1
 		 * (Register 7.60)
@@ -707,7 +704,7 @@ static int genphy_c45_write_eee_adv(struct phy_device *phydev,
 	}
 
 	if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP2_FEATURES)) {
-		val = linkmode_to_mii_eee_cap2_t(tmp);
+		val = linkmode_to_mii_eee_cap2_t(adv);
 
 		/* IEEE 802.3-2022 45.2.7.16 EEE advertisement 2
 		 * (Register 7.62)
-- 
2.47.1



