Return-Path: <netdev+bounces-218872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C02CAB3EE7D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CBA188698C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 19:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389FA320A3F;
	Mon,  1 Sep 2025 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL4axDNT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB530649B;
	Mon,  1 Sep 2025 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755585; cv=none; b=ME2v0HUG8VA/ebanFuTk33mKKVcN3x1i9pECFv82aRAqaCYKpx6bX+Pp9IcAOs226bysDtzvVduOzaW8N9DwdyCJMrH4cTf+FMknHZemdl+8G7YKbNSHyblkSEWtGpKhxdctvieCUDSZ/Sddht6cc3jWrINhi084ccI3lDT8LBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755585; c=relaxed/simple;
	bh=FTzCzjBGAU2zAILYt8Knw8sq1x901Xv+8Ef4qzFjAA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5caGSO2L7WZ1hu2YYLEzja0RAGG2/ImiOqtKIz9zp1TaYc/4MhQ1eS4DD1UTnqcnq19tUHHhZdrTJ/dntaLGuFLaDuPfPBNwgn0c8I11/RiqlCssEvR7HvDi07039m6+xD/B1CtbFyxZL7/YCDh/KNayLgYO5sCkGs9Qz8AHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL4axDNT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b8b1a104cso14539325e9.2;
        Mon, 01 Sep 2025 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756755582; x=1757360382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6X9nbNsT+7iMStoNetBnrQA9tNd6eAxAU3Fq1XXKe/8=;
        b=fL4axDNT580KMA7L6VmPoGAYYuSGStvc7Yf00SCD8SF94kGyaXdzEzYne0RU3xTB8C
         kmCp244ucmlo1/e2meCceN6q47fO2DMteqD888B5sL3YgANOm2fEg5zNJvAi90mbaLzF
         KFLvkOPDaUgoOrKa6Zpuwbk9HYCOjRKohsLtDFQH8c1mIiV5UAfQRsLLUfCr1QaxVsZG
         C5KP7xJVsl/N7ZjbCbW7ASCv416UaiWP196UJpfWuW69U8gOXPejX4k+j8IP6QxveQ6S
         g7aVMiEmD9B51vyeL22zQyWiqbRZiIKDf+spd/LACN8d/IPojhsWNuqIaa1cPWmqD5nI
         xIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756755582; x=1757360382;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6X9nbNsT+7iMStoNetBnrQA9tNd6eAxAU3Fq1XXKe/8=;
        b=IBqpCh5qmEqMSQR0IaXZbUccRAkE154FzU3S/ZGEAIpjl0fhoJUOnT04c6MLI5Lpm6
         JrBHxmJOUXST9UhILpnjfNQ0B2YCrVlwxva3U2iletZnjjai+WmXaB8hYChRNit4sTGb
         dcPfuMbEEyGo7HN9zuNGvbCkzHdgJqffp4p/+GiwHCpEIAJNJlKpO9GU4Vbt0FZ1d0t/
         cMGlQZqig7qpOC7ynpShfHvfOhmxJeEZePY4Ht3j+I/i1rIzgjkNd3+5P3r3S0vfYV6j
         YysB/EPNhNdEkbGvN9IAPOExZOHyhvyoaJRPDDdptq96nkV4oRQbjxwwon4mHwsrqjgz
         TVLg==
X-Forwarded-Encrypted: i=1; AJvYcCX2FEVYrVS9SslAdtg6MBPasnSrKaoKjDPns57Mm8OtYZfsaZqdqn/qLoy/WAYoeWKkDnIQ3fe3@vger.kernel.org, AJvYcCXSQqEgbLZfaSToQ0lH3OU2Es+NbupwJvzT0gFy9i7B7ZWC6JgPre/7LKhsCm5Jkh45KisqZMLJug7i@vger.kernel.org
X-Gm-Message-State: AOJu0YxOu9Q36NUvhiUV31vnrrlqCzIXXMboHhQpR0njPGS9GUzq5EXu
	uUXj8MrZ/DMOZ+w5uh25hKb5cdFddoFJvUb1PwFUcKiZ+S5ai/HRrc4l
X-Gm-Gg: ASbGncuBpp155imTTCHMDL3I1f7PeGEthTNbXPPXU5yvufKmC6E3QjU2/26oq/MNyq4
	XI1eabpvzW6ZoJ/SARdYxtvVwAjFHCWVs90tXkuC6SeiT0ioAItebjfrXSrRo1fVHXkYJ+z8L3V
	9P69V8nQFlR9NmR+pz1BTnWSw+8W1pZ3/z4fz9shuPhMAZveBMv02U1C8BkQ6csnQwzg82awRdD
	vPR8rbeU4ZoKCGNmALW+0VjssDo/0OzUtW9m4W0q4EWjlN5S94jp1O1UFbogYmGMthssvnjA0G4
	FTaGwc0sYjWJhPalHgu52EBtnNvVcRuG9DaOwrmMUO1zQx1NWsp5JrB2g2XAexCMK7sPr21FpNF
	5iWllEJ6/Rk1XvNZsI1FAkvIY92xH44pS/Nzr3L85LSHq6aafiNiOdxW/r/cw3N6nVKHbA7Wkoo
	ZPmjb6pZTCLJBiMdubrSXVIXSaccqxBFLC13bRyycPoXftK+wh5fHOePuYbqfLfRHeRt5f6kL4S
	9al8YYo
X-Google-Smtp-Source: AGHT+IEWv4ofu5GOeP6vg+xN0NWGIpi5fyqMqNzrzpvalEPnH1srOBCGFXpz/ezELB/XIzilfqMKiQ==
X-Received: by 2002:a05:600c:3b16:b0:459:d709:e5d4 with SMTP id 5b1f17b1804b1-45b8549c493mr71879185e9.0.1756755581598;
        Mon, 01 Sep 2025 12:39:41 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f36:d00:7965:aa82:4012:7ac0? (p200300ea8f360d007965aa8240127ac0.dip0.t-ipconnect.de. [2003:ea:8f36:d00:7965:aa82:4012:7ac0])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3d6376546c6sm6863169f8f.60.2025.09.01.12.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 12:39:40 -0700 (PDT)
Message-ID: <a5411ede-5312-4510-a559-e3b09e7e763b@gmail.com>
Date: Mon, 1 Sep 2025 21:39:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] arm64: dts: ls1043a-qds: switch to new
 fixed-link binding
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a3c2f8d3-36e6-4411-9526-78abbc60e1da@gmail.com>
 <fe4c021d-c188-4fc2-8b2f-9c3c269056eb@gmail.com>
 <aLNst1V_OSlvpC3t@shell.armlinux.org.uk>
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
In-Reply-To: <aLNst1V_OSlvpC3t@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/30/2025 11:27 PM, Russell King (Oracle) wrote:
> On Sat, Aug 30, 2025 at 12:27:23PM +0200, Heiner Kallweit wrote:
>> The old array-type fixed-link binding has been deprecated
>> for more than 10 yrs. Switch to the new binding.
> 
> ... and the fact we have device trees that use it today means that we
> can't remove support for it from the kernel.
> 
> I think it would make sense to update the dts files, and add a noisy
> warning when we detect that it's being used to prevent future usage.
> 
Usage of the deprecated binding was added to this dt file with ab9d8032dbd0
("arm64: dts: ls1043a-qds: add mmio based mdio-mux support") in 2022.
At that time the binding had been marked deprecated for years already.
I think it would be good if dtc would warn already if a deprecated
binding is detected, so that CI can complain.


