Return-Path: <netdev+bounces-222258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CA0B53C28
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA8E1C81FC1
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E1F258CC1;
	Thu, 11 Sep 2025 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ur5PahW8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04723D28C
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757618267; cv=none; b=d1FtzrAGv5hWTTG2/cmB4V0IDbx+xJ35CbUCt1aM/9iMy+Yf6/KAGERSSIHNSV3epEq8mGz6UCFrXUWVkgPfiOsUxBImJE++aMUqCZN99+vTBZw2V5XE4Q0TGMRkBsbOkX+/V5EhOtHR5sP1c3NLLOfZZ6fpIOsFmhjaIbO9hCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757618267; c=relaxed/simple;
	bh=0Nne50ataUdVCl/LIBo9Hysnnp0gIMyAbKlGZ9SaZ+w=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cIkS7HgMpraF20Agp6BNIXsioum6Jp5kla9LXkXRBWlqoyKMAa4la6JBHH/hlTO4BwkZioZquf9E8hUxBWMU7vgAEKtJ42FbSm9brxqaNIjcRlLTd+LOXepyMvC1xmkRy12vR5DQn0BHnmxHwJRtyYgbT4/1DpibC+keUtm/eVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ur5PahW8; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso860075f8f.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757618264; x=1758223064; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyJSNPMvRgVn4iADR/GPj3p7xOdKpnK8BhvgNFEAfrw=;
        b=Ur5PahW8ftuCxRV46Lp072JkWZEjKKpBtkGqwEOhmul8Z9+KG7eX/K/gzwf/5+pFlY
         ae81LgQgA6xTr8L9FDPfK95jIWYbFE4YPfynIZmPsL6DWYkZ19FFB2gPD+jSlK4Sz9im
         Fu95/Yrk1c89Dc6Pzi4p0KEoI7E1IVpFZfw96idSiuO8fqqODFpxer70pnhgReXeaL3H
         qMGyhUPdbceL6r7ImmM13Afwu1VEYmDff6PfqQ6iKYav5BegKGJu0bnveq+7KEulyjOX
         b4RDU7BXT7zo0Vq3iPTqOUjPR+PkKzSNc9pCB3KFPVrCqQfMe/aJ1glT93DBBmgJFaYr
         Lf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757618264; x=1758223064;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyJSNPMvRgVn4iADR/GPj3p7xOdKpnK8BhvgNFEAfrw=;
        b=jmYO4H6A0tJgr0sDVMbgFQjlzlCD5dWW2XhGSj7bHj5MJXSM3HJ2BK5H0Kp/UGO0t1
         XkPFYxFU54L/ofttJTvVPmFuE7SZ79D0VF/bB0uGMsjYkvm7+xPb4LZBZDaRSVXvq1Sl
         3oXvpfteGPXvz38WAAPkzTl2c+5EF4cL+uB+h3dIWjFtCP/jYiNyDIXVyTPGx6m3KbpF
         N0Ni80UtsZTVc89S61OT4kkK1NHuZdXzgTW2l7xRPG3HknTPqjeROYBVkdAIiKRgThbQ
         Y5hG3fwBINcRMbsgo3cXUybNX4byt1HN9yBUnyJ61/xN78h/49zXPny5DzJh8+lq1YeU
         zkWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+RCTFW7nJY9DrtyA9qhkO4srdHU2bwWR0IkD7ZG6+xp2T2USA6H3IUETI3ftCmw21lEjGG9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyRjl7cLoByO+uZNovHfwbzpdT3rbPOv+Hr4vox/TPP/iE1/AT
	DUWr+oM7fvaB747onB1HtEPykeKu1ag3ArgEuaKpMopR58xW1ujTAw80
X-Gm-Gg: ASbGnctUsF+V/KmsahARNIZZSNnjV0IaYaNaofjEIazJT466iN/LSMEyaWvUTpLeqUb
	bH7cND4fDrygjn9FesjF7bJ8AqqXGUkad2FzWz8FRRgWdRCdcA/T8aDiQwkhtp2iByzEwEIT4lz
	62QcMvvyAIzjAX9ss8vPTnfkhxM9WHJt2U0TIDEbQctarogopG9UY2nzs50JaNU0ze5Rq+8jImH
	fjIuTcx4eZlyciUz3G7O20WLMY/vX1Qo741lqtGRuWHf9sWPZ+Me6OM13rKJ2g7ZBew3y3lasFW
	wEW/vqkQB7hteAHXLp6zT5cx0OfSJ/fx+6iWyhQzqrkZ7zvpg4guDnLMlwaj4T4/zJDZQVOkJi5
	DQfhtkZLffCmawOGafjXwOcpw+AU/WtWkUswPB/juS0rtJd6Mv9MdYd3Iokmu6ET9/1pI4ygB6A
	QjkPJ2/D36lEVJssdRxolfqsJO5nfHMoSLNPqv5rHoeFqG0KC2ndjGpPtfjpDZF1oG4uzU+tcW
X-Google-Smtp-Source: AGHT+IFSRIdlD53Rz1pcjod+/kqnvpG0gSjJqxaiwkx7kUmeF5Bt5vJtq8Qbs2fnuAXKGH4nQNqVmg==
X-Received: by 2002:a05:6000:2f87:b0:3e5:25c2:963e with SMTP id ffacd0b85a97d-3e765a2d992mr433823f8f.33.1757618264269;
        Thu, 11 Sep 2025 12:17:44 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4f:5300:1cfa:4708:5a23:4727? (p200300ea8f4f53001cfa47085a234727.dip0.t-ipconnect.de. [2003:ea:8f4f:5300:1cfa:4708:5a23:4727])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e01832af1sm19737085e9.3.2025.09.11.12.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:17:43 -0700 (PDT)
Message-ID: <f45308fd-635a-458b-97f6-41e0dc276bfb@gmail.com>
Date: Thu, 11 Sep 2025 21:18:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v2 0/2] net: phy: print warning if usage of
 deprecated array-style fixed-link binding is detected
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

The array-style fixed-link binding has been marked deprecated for more
than 10 yrs, but still there's a number of users. Print a warning when
usage of the deprecated binding is detected.

v2:
- use dedicated printk specifiers

Heiner Kallweit (2):
  of: mdio: warn if deprecated fixed-link binding is used
  net: phylink: warn if deprecated array-style fixed-link binding is
    used

 drivers/net/mdio/of_mdio.c | 2 ++
 drivers/net/phy/phylink.c  | 3 +++
 2 files changed, 5 insertions(+)

-- 
2.51.0


