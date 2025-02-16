Return-Path: <netdev+bounces-166827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC82A377B9
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 22:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F5F7A3117
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 21:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BB41442F4;
	Sun, 16 Feb 2025 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIFRJUR9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302B33C5
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739740559; cv=none; b=ly0YtUmlrsD1k0e/SNbGmnbIO2OU/ZRPs7fAA7utSWebh8WKIO5WH+w3LnuGDBVPXXBruY1v6GIsxrPlsuYrbzTB0cdbUSwJrMmJR3tgxycXh3iYiR6iXDfAqztZeRm8CFdxP59P8JQO69wUdGQvf9hj1ACfGN6kSqFJ7Sy5kWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739740559; c=relaxed/simple;
	bh=9gvKrbZXQwFBPOGhFVgUUyhI8BDi+ISDz11ozYSHawU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BTRtV2f11DbD9PRpttplGQ2hmLJDD8XZjMka3beBtmcuiuCUold7X+yAGccdYyM4XMceQS9yi58Cal+C3xIpZtevr7u5/8QwXs/COZ69e1+4a3si0qMgIZFRH2zjBkrfSKngTU5aiPFQcupLSw9iZxWS0RDz8yKy3WNNeDTCWZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIFRJUR9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso40498655e9.1
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 13:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739740556; x=1740345356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iNdXx/CQWYqGszy7gJ5vj0iptM40OqYFC/OFRp8Nf6A=;
        b=QIFRJUR9m/BAIuQ7YQDGQ2jgXuskn7swjokoxM0x/rP4lZ5F9aaxabaKSzl6pWYCdS
         quvR6UncnheV1JHaJhjLovYmR+sYF/faWyk1AJ5PLloX2xyINPDr/MjOpbdUT1S2PPAD
         CM/+lcPja9jxmg9qaZTvRWdimuOQE9FjM2F+g9uBLH6X8K2t7KHtm1QCcqRbumGPZwfF
         Sun4nCyw0+NgeUG+oTZ/oqMe2SPi3H78CxW4jpbFt9rYJ5dESvvpWKLE3ux4jRXrk1Wq
         aZPUynfEF7k6RlE+pp+bPl0vM6j3vr/mAv4hTKJJIsA2XUVmx4QsDo2aZyRo2GKEQYyi
         5V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739740556; x=1740345356;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNdXx/CQWYqGszy7gJ5vj0iptM40OqYFC/OFRp8Nf6A=;
        b=o/Ay4e69UpR5jFLeWHNO6kh74ZL2O6UMpjE0RAIITBgRDVQTKaGZb9DV5qva2r97D0
         2LgfKerwN5+Q34ucYbwUNlRZYWdp9lf55P/N74Q+CtS9w1/zEPsexiqbGzxks8z1B8yy
         N9TQsyTNO7FD0jlSu6Obh6cahPCq3TGuTJHwlbtoaEa1V2uZqP9jBJVSDHCfxlLz1krw
         pfRrzi7q0A/0q0TlaqLMV45ybdadKabN3v3gPu6PTs3qxLKUgk6Cue5v4sy74QklwLHc
         5DExe8xA0QBMq7Ru7GcdfBs7T8UcRnD5M9n3J2KMinXYxy7laf6R+bMbaHD+Vkj5J5lO
         ASRA==
X-Gm-Message-State: AOJu0YzdyvWKbhVLy3jXAucmMYUJr9GjlKsRNvC30/1QQg1gWNgitLZ8
	eZbqNJ/smyXk+9HRZoykfDuUWsEdgunGUV1kYTuRx4yko28LQ9CWuc9WhX2j
X-Gm-Gg: ASbGncsxkkBKHX+5Io2k3SlnR/TVQmBZwUxTBAGfjzEKhX0jjZm4RJkWbV+8WzR5CCu
	bu22yLEfzFNxnK1l+R6h1p62TxNFNdIzV03lUFhQmjAxrBO+OwlMXJ6C2TtgMAz/VPM7ty4K8AV
	fqMakd9a8TSCIlkWaP+BtKzLFTlqDDeKkgCBpEO7eEmkhys4IBJu7tb7NlnoCocq4YgSilw6hS0
	gpHqdq5cMPZao6k2nJW8Tu3qFlJXQpqB3rVGcMcEHLKbcRvyrMkPgtDc6uhrq6zyY81jgamDJDB
	VwshL86WTo/3G/x6LjubqRLYPGHI1JlIfWIJH4vXW0pmVj+70alto/mgZAYXlHEcHTcs7AGj6X0
	eBO2LW4CmMF0PkN05sjca+npDVnrVO94zs/+5uo0eARmEk2WLzB87CVmobUlcwquHhrCS0ZQ21g
	yCl+kVOxM=
X-Google-Smtp-Source: AGHT+IGcVC3z+4nB77cP+/cyujIC0eCOtezU/l/5Ud+fXZsnf1R+9vtbUDw7UWRCS0dnmD2SQgQEDA==
X-Received: by 2002:adf:e3c4:0:b0:38d:e3d4:4468 with SMTP id ffacd0b85a97d-38f33f565ccmr5329776f8f.51.1739740555427;
        Sun, 16 Feb 2025 13:15:55 -0800 (PST)
Received: from ?IPV6:2a02:3100:a14d:c000:1d06:77f1:27f3:ba49? (dynamic-2a02-3100-a14d-c000-1d06-77f1-27f3-ba49.310.pool.telefonica.de. [2a02:3100:a14d:c000:1d06:77f1:27f3:ba49])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f258dab74sm10606706f8f.32.2025.02.16.13.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 13:15:54 -0800 (PST)
Message-ID: <92164896-38ff-4474-b98b-e83fc05b9509@gmail.com>
Date: Sun, 16 Feb 2025 22:16:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/6] net: phy: improve phy_disable_eee_mode
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
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
In-Reply-To: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

If a mode is to be disabled, remove it from advertising_eee.
Disabling EEE modes shall be done before calling phy_start(),
warn if that's not the case.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/phy.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 481f8e21f..26a11a0c7 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1345,7 +1345,10 @@ static inline bool phy_is_started(struct phy_device *phydev)
  */
 static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode)
 {
+	WARN_ON(phy_is_started(phydev));
+
 	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
+	linkmode_clear_bit(link_mode, phydev->advertising_eee);
 }
 
 void phy_resolve_aneg_pause(struct phy_device *phydev);
-- 
2.48.1



