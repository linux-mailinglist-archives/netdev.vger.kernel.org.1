Return-Path: <netdev+bounces-182046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D19A877CD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF90188D2F6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 06:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D3419E971;
	Mon, 14 Apr 2025 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsV1MXFj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370781632CA;
	Mon, 14 Apr 2025 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744611609; cv=none; b=dQJWeEdM6PJwLz6jUZx+HI5t8apAxIjnV+OO9xrEMgFTzeuGn+kMoyjCPGOeIoC1BT2iTK2wPeqY32nfwhXeichmlseJ75NbOI0fO5qOQj3LwoVQ8O17xvxR2EJPI7cP6IE/T/RIFmqiQ1rbZRlhdmSnDKvDzXcdEVtHUJAz2TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744611609; c=relaxed/simple;
	bh=ErdSk6YC/591rgLDiDHwMEoYP4+lu5x+ZKuhikVe/go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1E4Jj+TbTT1Kq+t4kA5JmvYvrBcj67g/S7teCH2YxQy8BuYWin+Zc87bIkkmNke/9R1H8YaKRf6MXHH4arwISYkHvsJHhXKmEJpTc7jx6tXihXBGUfUfvtebFxSnj0Qf/s5MY+ex1qHxmxPh9cMAC3ajvPT4dX3SjSUKpybKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsV1MXFj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so7205501a12.1;
        Sun, 13 Apr 2025 23:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744611605; x=1745216405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vCSNZdL1H4wbdatyMX8TLuz+m6buGYAHaYG/FPE/agg=;
        b=XsV1MXFjlhfPnpRH5FuNuy8njIiWv4esbY0FNmM1goOLyDab1VJg/dCH7yVhelT3wx
         n1lqLem8lQK6RHKPT7ScHnIxNr7pqUKyRdKaOhx0HWJkumM+wBPfcJgafHNCyIHBTQi7
         xyEMIpGFdbUToS5jzZO7jsRrf+spaDjfn6waqMsqceC/kqzAbCp0DzVqUvNmip5iZZtC
         gwnwtv98UsNrHn2dNiJODG0u5EX9GhUiaErPzR0RR8QQP8PsSsBahg2e/AfuoyMLKP8z
         rd6qBvVteAP7XlIrVGBiJ/rz2s+SKq09Nh/LYKNqd5sUKT6L/U7tHwDUAmFQfOipPJBt
         88qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744611605; x=1745216405;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCSNZdL1H4wbdatyMX8TLuz+m6buGYAHaYG/FPE/agg=;
        b=kn/liO3eSvRX6J+ffAYT33YOECFQB2gNvwY/KpiEoPL4TLDat7H3OMww84QCImmJal
         Q29FYcuFUWpjQK/s9OJ3VCb8bf07gG/b1+dzQeOT/gkcLSQRPd5F4eUNHpNAzvO1dJLP
         ovlmAPuE9hqfd6suRn8ZoW5yqxnG5nzAs35wov6MbMNqAwzleqjrh/iEZ86VtkDFH33x
         bvdEHjtnQhRhyqBRTHrktLIG18uKYpnPnpa9exVwwTrgI/EywpSpZutQ5dABJTnRbDuR
         mlu8FxeBOVjNUOyqpvSdq0+fzBYY52ORm7snfywhVX5dEmNk7lp0c0VWowTL0859Yrik
         048Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYLISchCwq8HdIzVlWGpm1mISWS5nooazAoSAE1R63dNB2aFc5moMnYalx2BZXO5/Ztb0xAeSqBhQ=@vger.kernel.org, AJvYcCWrwvrSdCb83Q5OAc+z8ctjFCkPxvb4FB3FDSwWcPnsCXRk9f4m0Nth7pW8ySyQF+q7kkTI9HMz@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGtXxSzCuSdjwvnhECZcpXN35rW9zGh0SGo+8BMAQurBcMFij
	H+BjaZakmN/C7u5dDYJgOOVToLfbbg/0JFTRbT05g4Of77SHyqqf
X-Gm-Gg: ASbGnct79uKJfk9b6vV6wMBRiFZ4JzYzFGMy/EwiEyw4Fl1mORELAeStPX7cZkg+N8a
	W/YYw2Xkt1g1SlK3BchRmQWcsRIS3ENdYY+wYd/Y/pNV6bu/rAMxDuFZnQ3aA+f3J5tPeS0+4tK
	WHk5BcMVZhfAM3jZr1bpKkIYp4YhwjnoQel3axSNzQdSyLCiL+PnOt9/UJZTM7I+NOs0Wuu9dF8
	bYOOvUwbPtqwSGvy8WOPO1gMPTcKnlRmJa9KGAoGrJrdpJKGTAVlNg//thFDSwadWVTNKVLsIZL
	N7GRmBNwxUdfgRItvzoIH3NiMBM4IBCE9VhtUEhww+eAHr9XvJ4D7fnOwWxRnVIyViEHcf+MwDG
	jefLtUi6wHKCDLHCcKHteQ9z7HddTqVb+WpUdd6akJtaAZ2oE9ysrSi83fD0TV071y/Y4nL5MxW
	hXoAMlM0wtXraSGItRfKKOdHQJtLEyg2Xf
X-Google-Smtp-Source: AGHT+IFIQfSwGbOninUkdjWrPQ6tf8k1mTYH4ZGRAmFTAdfamFP13ZRug/I6mtxvaNEywjj/VtaZwg==
X-Received: by 2002:a05:6402:1ec9:b0:5f3:8171:a4e2 with SMTP id 4fb4d7f45d1cf-5f38171a75amr9510727a12.18.1744611604982;
        Sun, 13 Apr 2025 23:20:04 -0700 (PDT)
Received: from ?IPV6:2a02:3100:b299:f900:989b:8dd8:6c3a:fb86? (dynamic-2a02-3100-b299-f900-989b-8dd8-6c3a-fb86.310.pool.telefonica.de. [2a02:3100:b299:f900:989b:8dd8:6c3a:fb86])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f505744sm4502255a12.57.2025.04.13.23.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 23:20:04 -0700 (PDT)
Message-ID: <a45b1359-5e80-42a3-b081-acf6d1975873@gmail.com>
Date: Mon, 14 Apr 2025 08:20:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lan78xx: Failed to sync IRQ enable register: -ENODEV
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 netdev <netdev@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Stefan Wahren <wahrenst@gmx.net>, Oleksij Rempel <o.rempel@pengutronix.de>
References: <3d4bda4e-f4e8-455e-87ec-2a84d6924d76@gmx.net>
 <Z_yhVCu0UR5s6p19@pengutronix.de>
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
In-Reply-To: <Z_yhVCu0UR5s6p19@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14.04.2025 07:47, Oleksij Rempel wrote:
> Hi Stefan,
> 
> On Sun, Apr 13, 2025 at 09:49:00PM +0200, Stefan Wahren wrote:
>> Hi,
>> i noticed that recent changes to lan78xx introduced error messages to
>> the bootlog of Raspberry Pi 3 B Plus (arm/multi_v7_defconfig, 6.15.0-rc1).
>>
>> [    8.715374] lan78xx 1-1.1.1:1.0 (unnamed net_device) (uninitialized):
>> No External EEPROM. Setting MAC Speed
>> [    9.313859] usbcore: registered new interface driver lan78xx
>> [   10.132752] vchiq: module is from the staging directory, the quality
>> is unknown, you have been warned.
>> [   10.533613] usbcore: registered new device driver onboard-usb-dev
>> [   10.533861] usb 1-1.1: USB disconnect, device number 3
>> [   10.533880] usb 1-1.1.1: USB disconnect, device number 6
>> [   10.656641] lan78xx 1-1.1.1:1.0 eth0 (unregistered): Failed to sync
>> IRQ enable register: -ENODEV
>> [   10.657440] lan78xx 1-1.1.1:1.0 eth0 (unregistered): Failed to sync
>> IRQ enable register: -ENODEV
>> [   10.658819] usb 1-1.1.2: USB disconnect, device number 5
>>
>> Since this happend during only two times during boot, i added a
>> WARN_ON() in this specific case in order to see what's going on:
> ...
>> [   10.656092]  lan78xx_irq_bus_sync_unlock from  free_irq
>> [   10.656110]  free_irq from phy_disconnect
>> [   10.656131]  phy_disconnect from lan78xx_disconnect
>> [   10.656143]  lan78xx_disconnect from usb_unbind_interface
> ...
>> Maybe some has any idea, how to fix this properly.
> 
> Thanks for the detailed report and backtrace!
> 
> The warning you're seeing was introduced by this patch:
> 0da202e6a56f ("net: usb: lan78xx: Add error handling to lan78xx_irq_bus_sync_unlock")
> 
> It adds error handling to lan78xx_irq_bus_sync_unlock() to log failed
> register access.
> 
> In your case, everything in the stack is actually doing what it's
> supposed to:
> - lan78xx_disconnect() notifies the PHY subsystem.
> - PHY framework sees the attached IRQ and calls free_irq().
> - free_irq() calls irq_chip_bus_sync_unlock() ->
>   lan78xx_irq_bus_sync_unlock(), where we hit the -ENODEV because
>   the USB device is already gone.
> 
> The issue is that the IRQ subsystem doesn’t currently support
> hot-unpluggable IRQ controllers, so there's no mechanism to tell it
> "the hardware is already gone, just clean up the software state."
> Until such a mechanism exists, these benign warnings can show up in
> valid disconnect paths.
> 
> I can imagine a few possible options:
> 
> - Silently ignore -ENODEV in irq_bus_sync_unlock() and similar paths  
>   Pro: trivial to implement  
>   Contra: completely hides real issues if they happen for other reasons
> 
> - Add a global flag to suppress lan78xxx errors in .disconnect path  
>   Pro: simple and less intrusive  
>   Contra: same as above — poor diagnostics
> 
> - Introduce irq_domain_mark_hardware_removed() and check it in relevant paths  
>   Pro: makes the real hardware state explicit, allows IRQ framework to make
>        better decisions, improves diagnostics  
>   Contra: requires some non-trivial changes across IRQ and driver code
> 
> Personally, I’d prefer the last option. It's harder to implement, but it gives
> us the right model for handling hot-unpluggable IRQ controllers in the long
> term.
> 
> All of these changes are more or less cosmetic. So far, there is no real
> problem — just the fact that software is attempting to access hardware that is
> already gone.  My proposal would primarily make the disconnection path cleaner
> and less noisy.
> 
> It won’t prevent other parts of the driver or subsystem from hitting -ENODEV
> before we reach the disconnect path. So until the driver itself is aware that
> the hardware is gone and begins cleanup, we may still get register access
> errors from other paths. This is expected.
> 
> Best regards,  
> Oleksij Rempel

+Thomas for the core IRQ part

