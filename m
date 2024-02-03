Return-Path: <netdev+bounces-68849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B8848897
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 20:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509B91F22965
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 19:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F545D46B;
	Sat,  3 Feb 2024 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWnYG+e7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FED5FBA0
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706989678; cv=none; b=OYm+aYAZpZDRhbJEMuXT6Ux6SISsdLWa6ruqofpjw2cyWk6VElWnl9/1VRGh+7nNKvB24Jy4sfgI3PJg7DoD+MgbqffKb0qUMQpQ6IN17kicQPcmaHClQ4u9RiHqkioxKve3XIpXXv0H6W7PzxjmQ9W9OJwiOc8zATsL0mVnGSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706989678; c=relaxed/simple;
	bh=tYXc9H9LzagnoRpWpcgWCq2NserCuKD0NUbYoXWNsgc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=j7pNmXEv4PZdoqjwoqu233APVzy8FcV3Cx/OOrxxucfW41NJMJoXWV02e1uTZSJw1VA33gw0rAi1fnE+9dbIg3OJCtGEuxe8TOBfyHK920PLHRNS6LAb5KaNXz5LVeXw8liaYQwFK3u+G9pS42wZquKyimpIbSx5e5i7qWt/GSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWnYG+e7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a37721e42feso26834066b.2
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 11:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706989675; x=1707594475; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iPe2J4LUYwzD1T15o480eJUYfFEz51j6TcOhW8rpiE=;
        b=LWnYG+e7iMDhBl7ZlJIsGIO20VwpGjZ7hdZyNjp2Z4qqOmmLsYaVgBzaVWdQQOukWn
         ZjZZQKYFWEXASRaFoocz6wwrh3LqC/gTU5ZfW+bw9HEJLqdPnTtzuwZmy9vIw3429fhh
         re0Oay0IvJw59RTzEge/NsUDxwEW3yFjk4FTODBsCfTR1uMmlTxF9dSd3VhJjVoAB8Pm
         Xwg95jgmkoAufAKSSctUIdWUBtnyJ0Z0pE8HsQ8VDTWnv4HwjoUVkHqBeXBlKd9abBl4
         Kjcs7AGXmZTap4axB+Ou6v9ChFoiSKLKrY4g3YWPddFl6bWT7TAcGNAbmQlZfGQMa2Ix
         jWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706989675; x=1707594475;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/iPe2J4LUYwzD1T15o480eJUYfFEz51j6TcOhW8rpiE=;
        b=EOjgMXARRNUmT9ByQndeid6x4iH6ectD/pN0A8h10PxGGpxYSWOxQ7DLIjlqKb83KL
         Io4axU2VsbDwZdZSNd3M2vKxYM/506yw50mjrSb2nE5b/2dZtzXbp1R5kjQKjEreTeCL
         BcJfwuewF98MmsJ9HIy37iVJo5E2hzYDvVQnCrgYGhmQxO3S9fyBgFbmae11zED5U1yh
         gqhZC+Dyi5skwuS2TKW+EkCuG7S+4KaLQjOUxjv1bcq1hBnKakWi2rafLL3k/MNnpuab
         OuawvAcxGEGFxw+7NlISnM97oXnQfq6KwIFdaSOHixjH5Izux4G+tkxEUpNRmhaAdOYX
         hGoQ==
X-Gm-Message-State: AOJu0YzvglWw4gdH8iwNNhRnz0+hDrpvu7a8UTQq7Z+qzKIeudg8sWHg
	c/gYsgRqEg2GUXPe2gImVL6IIKhPPEdfrocbEqJCA25oLp7bfnZQ
X-Google-Smtp-Source: AGHT+IGV+ttbgKdxtoerKUaWYQIrXNSJXGNakN4AzI+TA5dj4NGgTu8BYeEewo4EbgjOqi+41i+Ikw==
X-Received: by 2002:a17:906:ae93:b0:a36:3f34:9476 with SMTP id md19-20020a170906ae9300b00a363f349476mr3481672ejb.44.1706989674495;
        Sat, 03 Feb 2024 11:47:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVnWPyzVxZCYA1MNpn0gFGqUZQ4Dcgw5SDS/uati1yBaqABXUjwLPwuTOfkIMToDj960VSF1iOlkJ53/VaSRxBF84w3WdLJbw6Iasam7WFwSjznkF2kL6LgmxZ5gSvSuaE9xr3CoDVf7eZJmYEomTYvdlohuxubGkEoM8JfNWqo6zaz/bgsMRBvCRcRd8I6iXkPLwUWKI5bSL6lMD2ip4wLKm3nEmVdsiWk
Received: from ?IPV6:2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac? (dynamic-2a01-0c23-bde4-a000-48dd-a4bf-88d3-e6ac.c23.pool.telefonica.de. [2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac])
        by smtp.googlemail.com with ESMTPSA id i15-20020a1709063c4f00b00a376329d829sm648143ejg.172.2024.02.03.11.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 11:47:54 -0800 (PST)
Message-ID: <0d886510-b2b7-43f2-b8a6-fb770d97266d@gmail.com>
Date: Sat, 3 Feb 2024 20:47:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v2 0/2] net: phy: add and use helper
 phy_advertise_eee_all
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

Per default phylib preserves the EEE advertising at the time of
phy probing. The EEE advertising can be changed from user space,
in addition this helper allows to set the EEE advertising to all
supported modes from drivers in kernel space.

v2:
- extend kernel doc description of new function

Heiner Kallweit (2):
  net: phy: add helper phy_advertise_eee_all
  r8169: use new helper phy_advertise_eee_all

 drivers/net/ethernet/realtek/r8169_main.c | 3 +--
 drivers/net/phy/phy_device.c              | 6 +++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.43.0


