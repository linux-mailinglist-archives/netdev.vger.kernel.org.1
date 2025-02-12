Return-Path: <netdev+bounces-165430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794D0A31F98
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 08:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F87169136
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79E01E9B04;
	Wed, 12 Feb 2025 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdF90AwT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245FAAD27
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739343810; cv=none; b=p7sJPfkePvAhYs9Jle9MKSEusHG8dAtUy3uuZtXHLQxd1E73ixjedHXa89LvSRS8GB07P2IH85s8QpmMLy5u0nYslQ5DB7uq6sjpWbZfHKYaEUguqajqe2NWKifi+A+kl8C9kPI8wuo5BOy1GzffP/xAWtG+IqqZwF+qbfYu/xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739343810; c=relaxed/simple;
	bh=0UoMqLBhm57rSyaFeItPBKDXFCN1cdPC1YzjWTK7oMo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=UavfFUkBxjcUpMXs8AxGfvhVjjpmTxu7V3sXihsnHS9mbsHsP5srtCRTsjk9J/pAqWfF8UbixSEID6qPv1V8PMaZsduncBFBjD9F939XzhHX3cpWSURJBaq7lX0dQXgxn2HjwiJDZlSNTjQJ0Zskp/crqFGE3C2qn2o6PpP/K+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdF90AwT; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5deb0ea1129so537223a12.3
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 23:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739343807; x=1739948607; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=njRQkmh0vSASEno1VKbSUrUt+aElMN8rdVrooUR1rh4=;
        b=HdF90AwThrpJ08yoKfW2M6OzfLBmSBMa8WjMUOTB31XbPce/cPvdRr1fDhJn3WeBSC
         NvHMk8oM6g0KlQHv6B3Ra/9XY2KLSGtjYELDZ4qgys0dCs2Vz66BMF+YGRb41YyJ9vrS
         6xgE8Y3xkZ4Phk38IH7exF98DMEvxezwj8mYISRT0bmhoJixV6ZLVZxf3HskRSt8zEyq
         ZqHEszZGeuUtbJEjIvQeXfeJ+2VXbLMS8eMTXXm8zAHTpdw807ulCcGUeMAIrT0Jk+Yp
         itQpGtid7O6kuLum79PJrUDs4Ss4bp5zDfxSE7GOwG1bkUFWKUyG2O2+3KJpSa2Jmz/D
         OzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739343807; x=1739948607;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=njRQkmh0vSASEno1VKbSUrUt+aElMN8rdVrooUR1rh4=;
        b=QC61siKA6NVQZHIV32tROV1XSlf508E1857vaPeaUQkr570nY2vamiOmSFwV88Te7n
         TEXeBFs7Nc2m3mGsB6uB4tdCDi54VclqW2Jw5RIikkFUregDHYuDoxTSSn9b9DWEG7vc
         /SpflTXI2Bd7BfxLlBN+ZR5Yx0bAXLugvVUI1KPy33u4C1Kbhk7oGo3iF9gonIr4caxd
         zAnhyi/lLa1X05V2zv9BpdkJ1du14FRzUN789sURG+qgI03JYrGteyIOjCIv0MFzuxnC
         QYlDTXgmzHwq1gBV9I25DAXuWoA9aXE89Mqpzy/VW+e9P8o8JMifNQWf6H+Dp8NrIo6A
         XfUw==
X-Gm-Message-State: AOJu0YxkQToZ3orho8Fofl8+ToARVgQAivIatyQFdtmTYd8xgaLDNJgM
	geT4vnVM+zuQF9cGKzQvFdPxSK+ElSa5rp04sujOp0Cz5cAH6Fh+
X-Gm-Gg: ASbGncunMkYOAV0oCagHRaMh9mtokAleZ2xR+ILgvej56jyoYZIlWX2GIwolLZ7tua5
	35cFCie41frfSHshdwLxXgEkUU5lTzscPskTBARlSF8JYwemmO3toXSQj7uNWB182FMSnOgInZw
	1i3M/yR82J5WaGPyw2U5hNmat853IbGW2DtwcCTcZs4r5AqoBOP1rI5tmZvXVvwUvd01ivSKfwV
	J18CJhSY2SauTikrDbCoo9zlVLNZaymOCh9L81cbr7+HwwF4WpsuGms9DHwVsxguVX/KmjyAQ19
	V2Al+gnfPHEr3Rq4f3yKR7sxNm1iNzevX+3Gx3c9Pjjn71gGCxfGNSfUIah2JCd8nLKPJbV03tG
	EQc39/MzYb3bGOLM1nK8OLm/ZZVBg7H55tePwoPp2b9fWA9i78FKJQOfIUazf8U+Kz3bI6yBTXu
	A9petoXM0=
X-Google-Smtp-Source: AGHT+IGZFH9/AtXuoT2WQ9bXhGOi/fXnumLN1R6NRX08IUZt+awVju0ZBTEfsAcJZHJAvlH5cL3zig==
X-Received: by 2002:a05:6402:3549:b0:5de:515d:814f with SMTP id 4fb4d7f45d1cf-5deaddc11ebmr1677630a12.19.1739343807174;
        Tue, 11 Feb 2025 23:03:27 -0800 (PST)
Received: from ?IPV6:2a02:3100:a541:5e00:c559:b395:f808:a611? (dynamic-2a02-3100-a541-5e00-c559-b395-f808-a611.310.pool.telefonica.de. [2a02:3100:a541:5e00:c559:b395:f808:a611])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5de4ad2c205sm9256689a12.33.2025.02.11.23.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 23:03:26 -0800 (PST)
Message-ID: <9db73e9b-e2e8-45de-97a5-041c5f71d774@gmail.com>
Date: Wed, 12 Feb 2025 08:03:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: add support for Intel Killer E5000
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
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

This adds support for the Intel Killer E5000 which seems to be a
rebranded RTL8126. Copied from r8126 vendor driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 32eb4a448..9fe53322d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -169,6 +169,7 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
 	{ PCI_VDEVICE(REALTEK,	0x8125) },
 	{ PCI_VDEVICE(REALTEK,	0x8126) },
 	{ PCI_VDEVICE(REALTEK,	0x3000) },
+	{ PCI_VDEVICE(REALTEK,	0x5000) },
 	{}
 };
 
-- 
2.48.1




