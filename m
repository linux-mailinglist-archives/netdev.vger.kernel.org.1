Return-Path: <netdev+bounces-174742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B5CA6018A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 20:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0464519C3A80
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044551F193D;
	Thu, 13 Mar 2025 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYnkZ2OE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD66EADA;
	Thu, 13 Mar 2025 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895177; cv=none; b=M/db6q0YJY0jgZu96/8FLPtiFhgfzeUR9kFjbhW5yH4mMGYtO5vGeJNeRbhMsr4TfTrsOpP7RlLvI3685p7408eASDqiGu4ooCowcvemQFS/Gs+qVVMc2/JZmkT0Pl4ubSX5IpouCykakp4KYER5IH2dYR9GFCSNP5HuR6P/Mwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895177; c=relaxed/simple;
	bh=d81sZjKpdQdX3+0Obj14zQVLEr07kOuasEZc5asWtfc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=X/E35NYCwCB+3ceEla9lSa5bIkVU+vcTk6hZdzcVYARcI76GTf9az6rIFVXZuKGeXelVFLvB2fsGb+eTwc0fUGYLKUlf7uBusTzldYY8/sFt4WaYQNZv8BUY/VGNO2fE/0PBgLDIN3wEc1SqYaAxFXVL0uGgz9Qb+KASe7W7daM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYnkZ2OE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso9370215e9.3;
        Thu, 13 Mar 2025 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741895174; x=1742499974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BcTVwWg+V3Eb6tHuchr1PfHMDU7/s5HDZzSMaZn0nOA=;
        b=fYnkZ2OErj5ER/LxMApQKaUq27Gc+hh9mfFWUrsK1Pp425CbyKhKRlV+qqjg+tpgsP
         lz/ql3uiWD2/ofXXJG2nWCnMn4YTlJ6WV5f2qQUvRWluoqoWX8bIeyQV72uAIP5u0cx+
         tANyyDSHCnNyurCZGIP79tpkrLAFmqJ9sKll6aEE5E/doTG1gcNP7crTULKHOaijxRkM
         f5OYHI2BR1XSia2EZbOqEL8EjwJKHkQlZ3tO9pKJojd94J34CzmObAM+nWb1fGR4Rosb
         x7KBSoWxuqhr0fYiSkc+RO4jPq+SYltIokAQPyvS2HbF0cwc4dxLNECDiiTOAxbygJsr
         B8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741895174; x=1742499974;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcTVwWg+V3Eb6tHuchr1PfHMDU7/s5HDZzSMaZn0nOA=;
        b=thI8j3Syw4s+qKH5jVApjP+0Omgyp9pJ28nuNmTWmr+41GUNzd+aG7tcQB6m7ifZuK
         Wbw/oQPrLfbqELqB5v7pg8cGgcIv+h2Po1BchOML4ZMK0bM6xZvbVr0HYCHtfv3ZSQfT
         EC3RTOa19o0/vJZYdVsYLukv7SIvcVUWvYsTwwy5/SfFh+ARio26GPxNK69s50AxkrQw
         /My0FyksFnleKgqt327+tEL42C7KfUKMgNfv85IC5upmSVFrPeqS/lUIr5CjvWpS4oRx
         i/qWnl/f/O/sCfeoKjwBF1+C1F3kvBVYENVpQ9KSaZZz+I0wHAov/uwzwHmQWwalIWQQ
         qs1A==
X-Forwarded-Encrypted: i=1; AJvYcCWknrlPNOOTStHgb7cx5Q42t6jndpTK2IhhXauAGK1Iyp9mfwmpGTk1LNJmxftTM+TRTcuGAk3aFgGO/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy5JF1vi4zi0C2k9/FRlAmmNjewh2EHlQ7nOzERW0lofPlH6tv
	FfedCEvFq+jHfLFFXcgTWKd0+MuVhsSwbjxN4StLZZVJJk57/B68
X-Gm-Gg: ASbGncukDA43UcNn6FDi+UnzSTZISL9aLLs0xDcMLNwIbsM2QS7L1v/8fnJqAsxQtW/
	XBFIONCj1Q3e+bpGGqzmJWtnv+0LqdOJQCLvLcKTUeBRaWHyOHtpT9jEFFtNBiYW2i7Kk0tBj7Y
	qEbGnAP08Yv2olABQ4gLII4MaGLGUHX7C2QINIgiUtYxtTBIUKJJxVojHXXUCgHTn7C4+92Necj
	3M9NprI7ZvKGIBjeCxepa0Sy+rxUjOL6Shjdp6ya/2F9nF2ukbN8rB6pWtGNE3/cxpvzxSPSnKQ
	RrfEn9m0vCJkajnG35yiPafasuOhQRRzo7zRwRKt1ca+kP+8oYVPScC/3xScKVvj9QrGIi5xuZi
	iVHxX9bljb8gPYCv9WSrbfBYRuk6HAHSyaAEPq69A62wc4UmRWpbCBhizPWWeHbIi9jbxm93Glo
	FAHXizhyMiUjlSmfGJcoy6LPfLXftswMeuXf7m
X-Google-Smtp-Source: AGHT+IHBsmRoLXxfJLPRFwmErh8I8ktN9jCrFMWwW2cwVy7XT/GuPkJHfv0gkJEzsVBHps/J1fFbgQ==
X-Received: by 2002:a5d:6da3:0:b0:38f:451b:653c with SMTP id ffacd0b85a97d-396c1753553mr885295f8f.7.1741895174490;
        Thu, 13 Mar 2025 12:46:14 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9d92:6200:9d62:fd9a:43ed:7e78? (dynamic-2a02-3100-9d92-6200-9d62-fd9a-43ed-7e78.310.pool.telefonica.de. [2a02:3100:9d92:6200:9d62:fd9a:43ed:7e78])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d0a759326sm63962925e9.18.2025.03.13.12.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 12:46:14 -0700 (PDT)
Message-ID: <59c485e4-983c-42f6-9114-916703a62e3f@gmail.com>
Date: Thu, 13 Mar 2025 20:46:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 4/4] net: phy: marvell-88q2xxx: remove call to
 devm_hwmon_sanitize_name
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Xu Liang <lxu@maxlinear.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
References: <198f3cd0-6c39-4783-afe7-95576a4b8539@gmail.com>
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
In-Reply-To: <198f3cd0-6c39-4783-afe7-95576a4b8539@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since c909e68f8127 ("hwmon: (core) Use device name as a fallback in
devm_hwmon_device_register_with_info") we can simply provide NULL
as name argument.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 15c0f8adc..23e1f0521 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -765,16 +765,10 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 	struct mv88q2xxx_priv *priv = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
 	struct device *hwmon;
-	char *hwmon_name;
 
 	priv->enable_temp = true;
-	hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));
-	if (IS_ERR(hwmon_name))
-		return PTR_ERR(hwmon_name);
 
-	hwmon = devm_hwmon_device_register_with_info(dev,
-						     hwmon_name,
-						     phydev,
+	hwmon = devm_hwmon_device_register_with_info(dev, NULL, phydev,
 						     &mv88q2xxx_hwmon_chip_info,
 						     NULL);
 
-- 
2.48.1



