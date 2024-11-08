Return-Path: <netdev+bounces-143212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FD39C169B
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 07:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E1A1F237C0
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 06:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15C21CF5DA;
	Fri,  8 Nov 2024 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnQLJgPP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4496B1BD9D8
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731048800; cv=none; b=YhC72v0bH9VwEJL1/peQBWCFNEFK9sNbm1COhowSPMOENM8JsxupjHkUXZK5H4CktYk9pymoXGPP1NFHkvFO0KjdprLKsuqR8gFEhLLocImOMQd3czwjkhW4hsBoHesr+axvM4XibTtEH8vZIk3zIX0imoHgwHYqnVRSIvinclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731048800; c=relaxed/simple;
	bh=dugL9BjxBcmB9i3VBCXKK6sv/HJRXLwsDnVUbAU1rzw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=PnKbuGOLVquF680CWWI2A4kkT9GqDjyLUm5ZLnwK7ItoNaaVlvw8JwCX/L9jo1Rx82ob7w3BYNo7lhOJ9/NGJSM7JHTHXbVQvoO2yRC4pZNLzB/C0bNHO+gW8bqVN43mJH149GVZTJyJhVDOCBS49k1gw/Bv3sB1ZqKMUMsCky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnQLJgPP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315eac969aso10330435e9.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 22:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731048797; x=1731653597; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=97IOB/ddpgxUcmySpa4k1e9/OvHtLmsKFQGJIHU6mEU=;
        b=FnQLJgPPMOJEF25jPx5KChBskJfveMVWKeQDgkk4Fowm9u3ODQ75sVyBAieHyPzL9Y
         VKAuGRSJ3R5wF8fiDK0MD4NxezGRkepiE0pFPX+O5W9TIUW29RvAA+6S4nrTx+MVLewP
         M6E3aIwJVXR+JN6LZAErh1mV/Y+rm0hXGLyFQC8RUAfFlSNrRFKEEHe6b36uJPVHa54f
         e2UmUHj+SQUa/0zcLA8+UbGbLjOHuFDH5SisKe1WbL6Lvu8GhseRAla9s3Z/CrgOTT9z
         0xw/5+xS6V+OWJJxa2ACStp2cV08QCt2otXV12lic9fVvIVrZt/bRVC+NhG6ESF2bvXw
         bzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731048797; x=1731653597;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97IOB/ddpgxUcmySpa4k1e9/OvHtLmsKFQGJIHU6mEU=;
        b=syezORI0vKiR7rrSl8tDTdW71xI212MEQ8vwYSoneCFzlfHeiJ4ABj0tuy7/Rchc/7
         QHJlmZ4xaWSaLBrnnZRLBToGSgRfavr4+RXJHNlgMxqEdYLMhCsWdU8sS3EUxrL57M8E
         /sfkxwl6BGKxAZpQwAfxqlrdezhYsUpOmqBl8edeLGne4kf7tmtL47lju7HtuhCRzclX
         cp8CjjpK0Mlv0HaYTFLGUjt5u/5vVrQ8icpGK1eQwA4mZOjxGCy4iHTkjV4GQaCn5j14
         HQEG3Gen+qLl3o0b3c9j8AubXIQx2U2ELzOrGw2fS80PNdCSF3nh1cW40qKQwNHFBpYF
         sZgQ==
X-Gm-Message-State: AOJu0YwvbR7Yh/ScDNmdb2FjskZTVL4gu/LMxC0XX2A3HSaVAIRfRJaC
	nfr84XwNVUePFfDUYNXH+/VCvwkyI4Ui82ob2q9qAZhKyoheuILz
X-Google-Smtp-Source: AGHT+IHfee8Yj7zy2oxaz1aBtCmW1/sioVuELG0JDOYNx1pivUMBVzQ8w81OLmqwg+nDNhbkcJZtqg==
X-Received: by 2002:a05:600c:1e1e:b0:42c:ae4e:a96c with SMTP id 5b1f17b1804b1-432b74d873amr9958285e9.16.1731048797234;
        Thu, 07 Nov 2024 22:53:17 -0800 (PST)
Received: from ?IPV6:2a02:3100:a8c7:1100:21c3:489d:8064:fe8b? (dynamic-2a02-3100-a8c7-1100-21c3-489d-8064-fe8b.310.pool.telefonica.de. [2a02:3100:a8c7:1100:21c3:489d:8064:fe8b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381eda04b52sm3632780f8f.101.2024.11.07.22.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 22:53:16 -0800 (PST)
Message-ID: <405734c5-0ed4-40e4-9ac9-91084b9536d6@gmail.com>
Date: Fri, 8 Nov 2024 07:53:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/3] net: phy: switch eee_broken_modes to linkmode
 bitmap and add accessor
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
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

eee_broken_modes has a eee_cap1 register layout currently. This doen't
allow to flag e.g. 2.5Gbps or 5Gbps BaseT EEE as broken. To overcome
this limitation switch eee_broken_modes to a linkmode bitmap.
Add an accessor for the bitmap and use it in r8169.

Heiner Kallweit (3):
  net: phy: convert eee_broken_modes to a linkmode bitmap
  net: phy: add phy_set_eee_broken
  r8169: copy vendor driver 2.5G/5G EEE advertisement constraints

 drivers/net/ethernet/realtek/r8169_main.c     |  6 ++++
 .../net/ethernet/realtek/r8169_phy_config.c   | 16 +++------
 drivers/net/phy/micrel.c                      |  2 +-
 drivers/net/phy/phy-c45.c                     | 12 +++----
 drivers/net/phy/phy-core.c                    | 34 +++++++++++++------
 include/linux/phy.h                           | 10 +++---
 6 files changed, 44 insertions(+), 36 deletions(-)

-- 
2.47.0

