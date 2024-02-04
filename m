Return-Path: <netdev+bounces-68932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB1E848E4E
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 15:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DB91F21C42
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 14:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02557224D6;
	Sun,  4 Feb 2024 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOFTRyvs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4587B2261D
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056105; cv=none; b=CzkDJMCU8bILlaghNYy0C25Ep1CZ6KhnI9KiqgCF39N68arTHPFZzhbADbKSBcDxU7my30FPXx3zLjCAQLo2yt+wVuoMNcnb+MNCdpk0UfyJfXPud2o3c4MaT8laURdEOqDarv18HajgW70wF3qHtRgzuSc/HekC5lEft10VKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056105; c=relaxed/simple;
	bh=6hu2GkIL+IeyPnCvsAK9mCy9Q9Fzt1Now4HOtPXKes4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YUdAlNSaOwFHhj9R/FK70mgvU8V1xwgfCdVutXbEG0ZpPrdn/dCnwiS3oUJmxao4eqjej/AVRO9g6bmhGjIit9zCAMNPszmP29XxOcMZutFBOml4TUWbygwlHLZw7tfMCZWyNRojXXFvEXkqDCUqmumxB9MNjfHMeNHpNH97UBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOFTRyvs; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so4719220a12.2
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 06:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707056102; x=1707660902; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=occwLy5QF2WXqT/7xEMrkAv8HEqQAaWavE9vyJPU2XE=;
        b=eOFTRyvsdTX9bfy/deHpFTTqeok61fP3X5LzRS4usxrEYPWmMkshKgXVgdTcIfujGB
         /JsCRS0m58g/rrEiC1D6UqUKACJPPLBZn+hs5aSCaOUWEgB9Ept9yK/3UD9StgZ/vuZI
         lP/xpvmiqxJ8NVALwoyJo/iV4sKG2ImMu5qUNgwbsAbjEn6Mx03HE6o3Ej6RfHQDvUrH
         gkjyIKj/WV8MVPEzuzBhRrziEKntAKWwE5sJLTd8g1DG/L7Fa5fHow7vaNi3PO1zeTgM
         a5qE0/FXvX6Ge4My6AcFC5pWQNz39GcCA3XDsTUlGxl7ITUSJUPNSziaTTzScvUiEfdZ
         xpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707056102; x=1707660902;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=occwLy5QF2WXqT/7xEMrkAv8HEqQAaWavE9vyJPU2XE=;
        b=Fh5yxcMEX0asUsIf/JC4Qsm6NVM2siDujgSHWsIlT+RLtezIhWdAR1Y1NmLzTMH6QP
         gfbVO9o0DTpFIpmqFgdzyhq/X5zhfv+mh5HXD7QCYlyY4rg9+6ZdQToUcLQIOFu8whuc
         xVScPzQwCkNcAn1kqVrZtyalU+sdVcIv8uv826Qw74BiXofoHr8A/f/U3KWt8TMye2Am
         vkxesgOrCNjTK/nxfA3zUpse9FzFItNKIZrJRL/mTdoNtherdinsL9WAT+7yNruHxDWN
         Ds+TsNxRw3eXghEqS+TsguCB/m1GV3GY1ravMEwc0suiNmqIGrl+0ZvEIU7wLHLCzG+m
         nlBQ==
X-Gm-Message-State: AOJu0YxpeoAlaCVe+cP3YV8s49XAuYAPLO6uDARu+xUj7ntuXrRaDcMN
	tmW6y6fMktbV6U33hZLOBgsqD0y/yZCWvFpKHABO46kjqrgutWQC
X-Google-Smtp-Source: AGHT+IFdXHMF48mxhY7r1KAhr5jvpWc6XOmgnT9msknSQZtCuEHCzlXrILRBrf8AK8wJ7ueY8Qz4PA==
X-Received: by 2002:a17:906:f1d5:b0:a37:97bb:e94f with SMTP id gx21-20020a170906f1d500b00a3797bbe94fmr949955ejb.39.1707056101999;
        Sun, 04 Feb 2024 06:15:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWCOUlDo1k6HvwCTSS09hKJSRAFlzW1gaC38kfH25OXubZtjQb2KPR8Fo0WjSWWbYUxPrG8gwAqQK2m1OSy1Z9XpiTYy1NhyzEFwwO6BIiqLBJZiBSWyHhmNN0arptM8najWygUg7uV3USAQU2Vj/IRrmtxQOIH0CkE8XPDippUvlBIXJcSxTdqMxliWi+KUw5b4m7HULlJPIJkioYS5CFgW3gE
Received: from ?IPV6:2a01:c22:732c:d400:1402:4c43:8a0e:1a33? (dynamic-2a01-0c22-732c-d400-1402-4c43-8a0e-1a33.c22.pool.telefonica.de. [2a01:c22:732c:d400:1402:4c43:8a0e:1a33])
        by smtp.googlemail.com with ESMTPSA id dr4-20020a170907720400b00a317ca8b422sm3189847ejc.92.2024.02.04.06.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 06:15:01 -0800 (PST)
Message-ID: <31a83fd9-90ce-402a-84c7-d5c20540b730@gmail.com>
Date: Sun, 4 Feb 2024 15:15:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/3] net: phy: realtek: complete 5Gbps support and
 replace private constants
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
Content-Transfer-Encoding: 8bit

Realtek maps standard C45 registers to vendor-specific registers which
can be accessed via C22 w/o MMD. For an unknown reason C22 MMD access
to C45 registers isn't supported for integrated PHY's.
However the vendor-specific registers preserve the format of the C45
registers, so we can use standard constants. First two patches are
cherry-picked from a series posted by Marek some time ago.

RTL8126 supports 5Gbps, therefore add the missing 5Gbps support to
rtl822x_config_aneg().

Heiner Kallweit (1):
  net: phy: realtek: add 5Gbps support to rtl822x_config_aneg()

Marek Behún (2):
  net: mdio: add 2.5g and 5g related PMA speed constants
  net: phy: realtek: use generic MDIO constants

 drivers/net/phy/realtek.c | 36 ++++++++++++++++++------------------
 include/uapi/linux/mdio.h |  2 ++
 2 files changed, 20 insertions(+), 18 deletions(-)

-- 
2.43.0


