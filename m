Return-Path: <netdev+bounces-197832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49F6AD9FB9
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 22:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B74A1758D1
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F672E62D6;
	Sat, 14 Jun 2025 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAPYWCzi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB641F3FC8
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 20:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749932980; cv=none; b=fOkLX4ZuB1ROF07sfKtUUu7OHyliB6Vt8hImnnB0VGrVwrYXi1r1ZhOyFTrK8/qvZApTdgU7VppWFYwm65XUtV75k8BUMJnfBNWIMt0Dh8xqAysut9sQsadYmXtIj2zxbMw74ifpGMAPNHBH3KegB79jDpdr8ATdUL022+fodkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749932980; c=relaxed/simple;
	bh=Z9PMFGZyXayiJbyKJeWCPAPhgj2eWmGVnL4ASeTcJVs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=UQ9uCOUanG1up8oYXCe3bQyyWjoW48gP0EnQGnpdzRkmvPZNW2RqOdgIB5S3LRud0HZPS31khIZFzRSDSyjfeakaZntpka22GsidytnaLeyWfhvC9YgRKQXzdMQvviR7pGwTim84ZepziCfiswXngAvM9kuXJ1IZscCWx7t1qxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAPYWCzi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso3132552f8f.1
        for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 13:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749932968; x=1750537768; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b6d43hvIkLj4iK10YGCIpuboUYupRMeisq1IKASB0w4=;
        b=SAPYWCziay1uNFum3fOqPcFZmgdm76JOJeN7O6tANADKmvpyq/zdVv75rlinsJvaIP
         BEv4mi+7X9MePAyzT6F44bXUZ5gYz9WaUKcsOU+RsItNM+zezhFYzaHd9tHCbfkAYRAX
         UgM+nNA58VY55pUFPt8reXStjIC0+ozx2vCI4/ZTZn3RPfGqViaM1ZsBiEHPczZMnG1H
         7x0CbO8THmHvNoD07oWyV03gMFJQRYykRJd3rWhP/isGVjJ7rY7m//LKmdH/FA4twX1q
         vWxVzsBIGcBgAFKgD/TY45aQ1UrZpR+mZrcHlZgbzLicBlpxSzoYbegY+Zp11wtrDKa/
         0nJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749932968; x=1750537768;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6d43hvIkLj4iK10YGCIpuboUYupRMeisq1IKASB0w4=;
        b=oP2wVt8SIewDThYBH7Hui9QWLeg+mO/Yrws8bl6kZzeGZwAsezXnBfzr6g5QX5EQdm
         M66Cmgln5Z6dHTAWmlfS6qgmFFmLbB1YVqTZrZaVVYGcBi8pWOLIU5JxM0Mu4Zxhe0ua
         tEUeeHHWn3jNGvV2zDqobQb+jA+wmjMXa/luElXFbJeJ/T4eFckcRl/vzl+Mm/dCzkoY
         SLgGrJHn/Bo0f+SYIKfY0ncDPOgl7uapnTxBrvhMvGCP6weiCcK2+6bvJC0EA1aFOalL
         V0DILRlQueSayC/kI7DtHO46osBpUbJRDj6JnZA2Ik84UFG1qR4N7p8GssMSCqmDwllv
         /1hw==
X-Gm-Message-State: AOJu0YwXyFEJd2XPMIBPjeH+TZXN+95l9KgXNzTh42MeuCOGtdUf94k5
	8RkIueAEJUyTXT6xN5fp08Vo6mtL0dMxJ2uPcPCONVuAk1Puk5Kv90L9
X-Gm-Gg: ASbGncs/tNRZw7QxBBYbH29JSOvxCYWSYcKutDMmakHCD/87l0C3MlQ+3pVN6ndil20
	MiZ0Q1K+LLa13QIn7hyw80bgQbIZhXNocZiJu1dTypLbdRCiGg6BdIsKY+3I8wLaKUJVvCTegjH
	8kibfBMN8h0x3a9fRE28iT+aJe8GJ7siu7Hk2qXOmPhc1IETAW3MQKHhmR++CB+/5By8aiwsNwD
	kk8w8+P1K886gWLwmJPjc8pvI7otxvCVgVZrdoBrwLriYgHc2xZodXKFQkItq86E8a3c8pLWFIS
	H+Tibgxs0WomdV7Qj7ZS9n5AsVfdiUpcI2l4K99ye/osHNr7oCIAEkW1w1h4xKYToZDRa0/bveJ
	oT6qetJh+K86Rs/FloHh3/COJDLZnBGzVIQ1+UhNXfjnMOvCTWeq4N2bIo4sS0zOceXhHlDZVc9
	Ta5DqjrDZJliu1A6vVIqW7iRu/vw==
X-Google-Smtp-Source: AGHT+IGvGVLoLF5MWv2luhWwDAnNHnICVJzUGp+2svVR4wKj3m/cPgYoQ3aqtENTW8cCzg7/ejXXRA==
X-Received: by 2002:a05:6000:240e:b0:3a4:eed7:15f2 with SMTP id ffacd0b85a97d-3a5723af0b5mr3957516f8f.43.1749932968021;
        Sat, 14 Jun 2025 13:29:28 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f47:2b00:1164:b467:ea80:aea5? (p200300ea8f472b001164b467ea80aea5.dip0.t-ipconnect.de. [2003:ea:8f47:2b00:1164:b467:ea80:aea5])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a568a612d8sm5914638f8f.24.2025.06.14.13.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jun 2025 13:29:27 -0700 (PDT)
Message-ID: <5778e86e-dd54-4388-b824-6132729ad481@gmail.com>
Date: Sat, 14 Jun 2025 22:29:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v2 0/3] net: phy: remove phy_driver_is_genphy and
 phy_driver_is_genphy_10g
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Replace phy_driver_is_genphy() and phy_driver_is_genphy_10g()
with a new flag in struct phy_device.

v2:
- fix a kdoc issue in patch 2

Heiner Kallweit (3):
  net: phy: add flag is_genphy_driven to struct phy_device
  net: phy: improve phy_driver_is_genphy
  net: phy: remove phy_driver_is_genphy_10g

 drivers/net/phy/phy_device.c | 43 ++++++------------------------------
 include/linux/phy.h          | 16 +++++++++++---
 2 files changed, 20 insertions(+), 39 deletions(-)

-- 
2.49.0




