Return-Path: <netdev+bounces-147812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2960D9DBF89
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 07:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B0F164819
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 06:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6EB156646;
	Fri, 29 Nov 2024 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJOb8lvb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF05184F;
	Fri, 29 Nov 2024 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732862979; cv=none; b=mmykI8OolOdXAG5hfJGBhjqUa5UejZ15wjl5iV82B9YVQUpOVQaRPFFjkEwPxBuhKSkNSWjpdGTOA580Ah1e7BW0zXV7gM4bjIxlAuyvfDnv9eUPPBfHGkBbYJsXwT9w3v/UkNQa0smMUQtx1sBpNYymzFCkqjV7dIU8viDo9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732862979; c=relaxed/simple;
	bh=lg2QsnZMLh5rJrV+1kl+QRzXpDqjqBeenmEZN48ZYe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmj2dshcNlmn1xWacbUVZO+fFI9fUPJXXm2x8AjiH76nP9XLcAZd3aKwfYfdr5syLtAy+g3H7hgq1EE9DBN3rGUX7mOfxfckC0vM0UT/nQcwWv5OKDtH6BV5TpsfyPEzThKR09ExA0nJt8eo3jqtSrNoX8Q/mBGYBkNnWuwxKc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJOb8lvb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so274540366b.1;
        Thu, 28 Nov 2024 22:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732862976; x=1733467776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YANTLYNxKy/QcS+8oL0z65xGHqIVcYg2sQLCkk46wj4=;
        b=VJOb8lvbO2w869E44mMrYc5lFbN3xvaqg5a0RNjm0fJGmQ1p09VG01YFBWlyhAZiBk
         kBVMB9vRVgOZ7GvIVOOkdjlIdSzVMNimL6ug+ly2dC2D9PFiiQnS+Ht0DSJqiQy/cwFN
         rXOMPjmUEg1JQs0FkDI6kcpOTMwG+vITyxJnwe5vfjstUeq1bSPhcK3a4ibVq42hB+9z
         vKM3fRcF6ZQEy6Vyja/VPDRdVrCDOqtig0eW/MIzf2TeovBLIp9ohrmlTDwXr58L2/rb
         +eISmxrfYpe02Zf7oCCM/sFiNyLF2Ns33apJgDJBGr0Gy2KzPIrx6aZOP7omJCcbCpuL
         c6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732862976; x=1733467776;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YANTLYNxKy/QcS+8oL0z65xGHqIVcYg2sQLCkk46wj4=;
        b=h8eEm1bZZEbPpqZP963nBNhlaMr48F8X90YgqBdWYrehKxaHxRxHI+FO6fsANqA2mf
         mrb4OsnVo3kqYuXzLFCWt1AllwAi++L7piuvknMMFUkMu1Lb/5rUguTlLJJfMhBPhTve
         rZJzrtW9pj+p8a1/AsQ4UAzKjLHyihf6c4fzOVQOBaLEtGHn98n+UNrjCbV3ilwddh5e
         o+lngip5huzm29Fqs3hHWX+NqhwsVa7VTQqAV9p6z6hWCjYe29d828+k/00EBPKGgNRh
         Fm2JZ+xjb9WCAe1itLQFdYmpDyNM02cxJjpTXADc5LzREGYl6vaSFUiQKzHdKK9hMSLj
         or1A==
X-Forwarded-Encrypted: i=1; AJvYcCVNcSNVvGpN00J8U1qti/PanpeBkjuyepUAOae8bc+l49vUE70hynQcWibegsPmU6NFfrL9wCZjq3qIMEo=@vger.kernel.org, AJvYcCXL7B/YzQf9IX/yGrhv0B+c0sfS9Yxvwg6OPKT3OiZthNWQbIDAnnyJOMcWdgTbt/bioNouBXMLLDO1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4AQ4RPWDmkt+Qj05B7K1tZnWqAZlbep2vVjqDeb/YihHnypcs
	ZfBeONo7fyH9BPpRgY8qSrJCUCVvZzUhDdpdr29caITL5EsPdfik
X-Gm-Gg: ASbGncvPPSeLXx89rm1KJJLf7KocHWn5xlUY/AW6GuTlriGCuzPWZiindSPduxgMGPf
	QQdByKx/6O5cAyXl0aneNW2MUmQjVOKsinjmm3IDVT+WjkXXKDoSKSl1NdymMrqmVAc2uuOTrtK
	XQtkXPZw5sKRaQLuuFg3wU+2iOOw2dFrwt8K2zwrzm5dl1/SQ24Pt2c1758gmFho3eyhfZi7buX
	+BknbrPJknHZ+lwPYTi2luyoIxfvTAau4I7+/nPG581OBZRQsL+w7zCWxXaRuXQJ4GMqqsVXSvA
	VoAViYiaHSIMTiu1SUKb7mVrtHgKaWda+AyzAgb+gvn4l1spkPTPZrSQt6rpxEenRIaPqiuT3ri
	SwuO5/bzeRA5YdOdUUFu1Fi6zB7h48FeihBNkX30=
X-Google-Smtp-Source: AGHT+IEb/1umUk1n//+xESC6hwRvhafTGrjzgNvdtB2LQERh0SQuZeQymrVds6JU9tkvrTLg1YwTrQ==
X-Received: by 2002:a17:907:3683:b0:aa5:500f:56b3 with SMTP id a640c23a62f3a-aa5945ea088mr610038366b.18.1732862976113;
        Thu, 28 Nov 2024 22:49:36 -0800 (PST)
Received: from ?IPV6:2a02:3100:a1e5:f500:55c9:dfe3:e2b4:cf5? (dynamic-2a02-3100-a1e5-f500-55c9-dfe3-e2b4-0cf5.310.pool.telefonica.de. [2a02:3100:a1e5:f500:55c9:dfe3:e2b4:cf5])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa5996db2cdsm140177366b.46.2024.11.28.22.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 22:49:34 -0800 (PST)
Message-ID: <f870d2c7-cf0a-4e78-80d6-faa490a13820@gmail.com>
Date: Fri, 29 Nov 2024 07:49:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PHY: Fix no autoneg corner case
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
 Ming Lei <ming.lei@redhat.com>
References: <m3plmhhx6d.fsf@t19.piap.pl>
 <c57a8f12-744c-4855-bd18-2197a8caf2a2@lunn.ch> <m3wmgnhnsb.fsf@t19.piap.pl>
 <2428ec56-f2db-4769-aaca-ca09e57b8162@lunn.ch> <m3serah8ch.fsf@t19.piap.pl>
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
In-Reply-To: <m3serah8ch.fsf@t19.piap.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29.11.2024 07:17, Krzysztof Hałasa wrote:
> Andrew,
> 
> thanks for your response.
> 
> Andrew Lunn <andrew@lunn.ch> writes:
> 
>>> It seems the phy/phylink code assumes the PHY starts with autoneg
>>> enabled (if supported). This is simply an incorrect assumption.
>>
>> This is sounding like a driver bug. When phy_start() is called it
>> kicks off the PHY state machine. That should result in
>> phy_config_aneg() being called. That function is badly named, since it
>> is used both for autoneg and forced setting. The purpose of that call
>> is to configure the PHY to the configuration stored in
>> phydev->advertise, etc. So if the PHY by hardware defaults has autoneg
>> disabled, but the configuration in phydev says it should be enabled,
>> calling phy_config_aneg() should actually enabled autoneg.
> 
> But... how would the driver know if autoneg is to be enabled or not?
> 
If autoneg is supported, then phylib defaults to enable it. I don't see
anything wrong with this. BaseT modes from 1000Mbps on require autoneg.
Your original commit message seems to refer to a use case where a certain
operation mode of the PHY doesn't support autoneg. Then the PHY driver
should detect this operation mode and clear the autoneg-supported bit.

> In the USB ASIX case, the Ethernet driver could dig this info up from
> the chip EEPROM. Not sure if I like this way, though. Complicated, and
> it's not needed in this case I think.
> 
>> I would say there are two different issues here.
>>
>> 1) It seems like we are not configuring the hardware to match phydev.
>> 2) We are overwriting how the bootloader etc configured the hardware.
>>
>> 2) is always hard, because how do we know the PHY is not messed up
>> from a previous boot/crash cycle etc. In general, a driver should try
>> to put the hardware into a well known state. If we have a clear use
>> case for this, we can consider how to implement it.
> 
> Well, I think if someone set the PHY previously, and then the machine
> rebooted (without actually changing PHY config), then perhaps the
> settings are better than any defaults anyway. Though I guess it will be
> configured in the init scripts again soon.
> 
> It's not something easily messed up by a crash. But yes, there is a risk
> the config was wrong, set by mistake or something.
> 
> BTW USB adapters will almost always reconfig PHY on boot, because they
> are powered from USB bus.
> 
> In this case, with ASIX USB adapter (internal PHY ax88796b /
> ax88796b_rust), the MAC + PHY will be configured by hardware on USB
> power up. So we _know_ the settings are better than any hardcoded
> defaults.
> 
> Maybe the specific ASIX PHY code should handle this.
> 
> Nevertheless, the inconsistency between phy/phylink/etc. and the actual
> hardware PHY is there.
> I guess I will have a look at this again shortly.


