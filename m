Return-Path: <netdev+bounces-184348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 476FDA94E32
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 10:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA21C1891635
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF72421322B;
	Mon, 21 Apr 2025 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1uPceFW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A51459F6;
	Mon, 21 Apr 2025 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745225095; cv=none; b=JtZYGhQPeVcq42OCOyKsZR6g+K7bgnMDygmfJPC9GXmHt/a9jfQ21paqAC/CPlgaSMr7E7TXYPYEe95Pg5kxDMVo+68C7EMOTPFAv/u08K6ggsfOgRkx1WBmIjzWskPOdYXrNUUYwSLp7Gm3Y00XIqZtspy3iJURMKtSQa8R7Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745225095; c=relaxed/simple;
	bh=RLWKSI/IbhkqIVTZcDr6yxrl3y00SmBcqgLDKlhV4vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvOrtxx6FPAryLgFvsZ5DkcsJpxxBLZSACNOlxh/ztqzSILVqOOMlUvMsxng0JoMCQtjdR5UOceXsPRO27ea/fx0bRSP1k4q8O+pXwY1Ok2zGlG4n+a0xIl5XaWsD6K3F63m4mgpdkurgkAeAMBm/tZzLL7FDd+gWkOb4aDDYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1uPceFW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso3411157f8f.2;
        Mon, 21 Apr 2025 01:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745225092; x=1745829892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zzzXpCSL6fUvCy5PEKvUf8v4FdYxVFOr1t4fGun1j+c=;
        b=a1uPceFWtkAOZuSSIw4F14eZvwswcPEehReY33UsoRdC2nZegl1l7R6efZZnweeGVg
         qtvDQr7UgTKOu2WBY+JuWB+6Lw4OjAbS8aFnMwe2Fb+BhlNWbYQKmuVzeZyDrTa72Vvt
         ilhzTniFLaWHYULQjcl0UeeHa0ifi2lGH4jhDj1nAxhPojCcPEZIeRNbvFWctJjv+9np
         Qz1lqcv7zA+S62+UF56UUshtuHdKWGbpMxsvthcmQkcVp2V8+Ke/zM1DvRnI027A3nG1
         SUxuuF9FTGRy1lu35x2faeW3CV06Dfw4n6mPm67+ob8NHIGL2HoYRa8+k7tJ+bs3YoaI
         mbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745225092; x=1745829892;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzzXpCSL6fUvCy5PEKvUf8v4FdYxVFOr1t4fGun1j+c=;
        b=d1wha6iiJWUTVgeDq4ZPHt9/tB3cw+1Pvx8YghIZg4lLTIfA41kxwrtK3VolB1VVla
         iL4Ol9XeH2TNnL/OghdX5Xz0G3gNWDBkqQ/GTxg4JovT+kETaVbw9+0jLB8hLqlnF69B
         RXXiEEei9vpXo1osoQbsCayVpTIAdEm9zAiFxxsIYAF4BpuNo19hV8uuFZfbGT1A2nQS
         oCAlaAp7SkIgCrugkkuGOYdeGAifFPdu2JMIhRqoQowGMrRi6YsrjqmuC9ad/1aGlTXA
         MSl5PmmTqf6p6PDMOgmNKUbcvLcnHjCf39QrxNRr4Jp+mD2kQjCazHDxDTOHv1PSfl/b
         HVWA==
X-Forwarded-Encrypted: i=1; AJvYcCUYfcy3rHb45/FXEsoU8XFZ+NBhNU/Qs2HH/OOw6f7vZ7Hz61FU+3eCTOoXdrRIQ0k+FtnqrVDEZCIxWW8=@vger.kernel.org, AJvYcCVqasbv08wiZjQ4o0rmOLZ0mB/EjncJFPk7w6BVVpd19Z7B5BY8FdH53E5Yd4Y/X06+nlnG6zwY@vger.kernel.org
X-Gm-Message-State: AOJu0YzSFo70P2ibRCJk7pAlHddXQTSub5EpdfKbLqyRYchxvTm4xtnQ
	SHv2Jb6LhWImGHVPVPA9mI5cPB141RXBIBIVe1al3dJPQK73+aDZ
X-Gm-Gg: ASbGncv0AmV71P5QEJxVeopPlggZ6DHKposSFWswCe92wcSGD6OuM7Wx0Gde2h1tKGD
	srWHGlA8XngQtuiCcrIxGWxsXmdf6Vx3TqnyehEkVEr6XFEF8XeucCTD+F/XVLD6lR7Ql0KFep2
	gPZcNijQnKx8s9CNdohD7bP1S7jWvf5lIhtuyYHsdK5gbE7eGpsnCFG3F3X4ULIpQamCgI6DUzn
	t57mKeI8l5zzSPDN5ZyR/SeWKNoScxRZwKkm6EOc+RyHSGUXeAfvy1p/7IC9lbyCULKg94/Eyh7
	PDs/ShyJErB2vcZKDuMwbAmMYzQrbn4GpcIvCXDgLXlth3NCxKpx0gi0wHs/kC/r3kayHLtpZE7
	x6Myq9ecOfXBfJw0zwrSd+to44LPESFVGty2rC67g6BeZMeA5XxGvqhQhv+NZ4F1gpwqh/mxjbH
	vN3aWlxqSddoit4xeqVBqoijI4rI4rSg==
X-Google-Smtp-Source: AGHT+IEMXTNA1Qo//ZMJXx0d6LXmxmJG572sUnBNQ1vr/s0um6aKic6qMnpZ8KqeNT1dd109N8zBng==
X-Received: by 2002:a05:6000:2483:b0:391:13d6:c9f0 with SMTP id ffacd0b85a97d-39efbaf2647mr8266209f8f.47.1745225092313;
        Mon, 21 Apr 2025 01:44:52 -0700 (PDT)
Received: from ?IPV6:2a02:3100:adc9:f500:6d8b:3370:fae:2b2e? (dynamic-2a02-3100-adc9-f500-6d8b-3370-0fae-2b2e.310.pool.telefonica.de. [2a02:3100:adc9:f500:6d8b:3370:fae:2b2e])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4406d5cf2dfsm127603915e9.29.2025.04.21.01.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 01:44:50 -0700 (PDT)
Message-ID: <b580bd83-3c15-482e-858e-09f298c41326@gmail.com>
Date: Mon, 21 Apr 2025 10:45:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] r8169: add module parameter aspm_en_force
To: Crag Wang <crag0715@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 crag.wang@dell.com, dell.client.kernel@dell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250324125543.6723-1-crag0715@gmail.com>
 <278ceb1e-a817-4c63-9bc9-095d0b081e50@gmail.com>
 <CAP-8N0jAjeY8Wthta1yS8Hs57KKt6HyFWpYM6=q1t+jxF_sY1A@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
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
In-Reply-To: <CAP-8N0jAjeY8Wthta1yS8Hs57KKt6HyFWpYM6=q1t+jxF_sY1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.04.2025 10:17, Crag Wang wrote:
> 
>     Adding module parameters is discouraged.
>     Also note that you have the option already to re-activate ASPM, you can use the
>     standard PCI sysfs attributes under /sys/class/net/<if>/device/link for this.
> 
> 
> How about adding a quirk table for the matched DMI patterns, allowing the hardware
> makers to opt-in ASPM settings in the kernel segment as an alternative to the PCI sysfs?
> 
There is already such an option, see rtl_aspm_is_safe().

