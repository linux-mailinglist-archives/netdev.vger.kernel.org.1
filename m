Return-Path: <netdev+bounces-157385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2907BA0A209
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F29816B574
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7125A17BB35;
	Sat, 11 Jan 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ+6xkfM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8926F16B3B7;
	Sat, 11 Jan 2025 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736585548; cv=none; b=Ttu6P8r2gcM3hSqozhBJk9WmdJfcyLNy1+JtC/SeqQ2iSOfHR/N+tSBZKdTeae89ly64SgYCwReViD09aDhH56+VTN/LaBBpQv0yv1YxeyPmnGDa+08ALOL1WkFATnR4gxzNW2taiGxqvAfxIOWfYPVT+Iy0qhRrEleRaWl4/qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736585548; c=relaxed/simple;
	bh=24BG19mvghY4M8upLZCYRHe8J40vHEvFiFc28osfeTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SY9a/rYPQZW+LdNQJRJqgTSfHR2I2lOTSH8Irts5FMd/qC8lCAKFhIrjf9nKvh4AqHQCTi0beBLxlIosGMxlve1GjBL2duQZcgrF6oVIsDCjIHJbIGpmQCyL3KNAbcak6WX/OAsjJ9nhBRH8q18XDvxqrpTJKj+sr5G9pmFCq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ+6xkfM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so504731166b.2;
        Sat, 11 Jan 2025 00:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736585545; x=1737190345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SA+nWGPnmc3ZsCyHH34PDUVDQxcYcbcA6hP9px0rFXc=;
        b=eQ+6xkfMZ7rarmHR4zeyjeSRMMgTW20gAk2qyznY3MMmn/tKM6Orb8aA6fZ7apGA/Z
         hFmExBRmk/h9MT/a9OO4n6Mk8D5yxQC4K731SW7pziQ8W4mraKeaZJpU3NS/b5cUUyhR
         xU1Ydd+ejGLW7RQVV9Kj11TugJpVQeWkZQd3qObnvTxBPbJD/2BfnGvJoaTOFKfvenYn
         8PBMLtq3UaR7bEKO6OtrJJghd9dr9J3dMvKFcr0Gj+b8E1M5A7upNuOx9h0CKk30gKOH
         dniIAjI6KPTaDX8ZqTQZBBoxPXD/hVMxcNgwoJl6/VKIg2NyRIEo5W08VW+H5WCIlnNA
         ew5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736585545; x=1737190345;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SA+nWGPnmc3ZsCyHH34PDUVDQxcYcbcA6hP9px0rFXc=;
        b=YTVfWFvmEB6jB3qeBkb0vNeZLs+Q/XgAiz5pL1aAHr/kqNtpDub+ruJmx5okmUqgad
         lO6TjkM7chKutXlOc4bnDFgZTFE7k+94eGZX2ulP9QJcxlWrSq35lrilE+8nRXOvD0nX
         vEVPlW92CAIpMr9RtfX3VnkIeuhworqFFFFFthR0hqYSkllXUNwZLOIz5L9WtGVsXrcR
         UborDeqetVkRfofXLKZcYaNw34QBxAZoJ0OUg0GnXMf3OeUzVj+PxRy9ij0lxS7QCdqo
         q5lbb+UY8Lz70wcJcsCZKTWukzsYI1+hxyOQ/a0Xd4+ihtmAQHjS23eDuQ+rL2F1AIDK
         EO+g==
X-Forwarded-Encrypted: i=1; AJvYcCUHcicM4m2xj/Fn4JC86DMPYMoDYXSuHqXtoEXQcP7sFYkM2S4CkZCswjffiJUKtnb8THioqoQEbAusNA==@vger.kernel.org, AJvYcCXf0GkNFshK8xZtYl7RwUJ1a57F0yCwiMX1zLL7ISUmzjMaJ4MN3wDQSbikm9ldTvTdUfwgG045@vger.kernel.org
X-Gm-Message-State: AOJu0YyM0RiBBl/WBi5yMISHC2GWc8B1xl4Vs18kr1PQS5RNaWuY9hQ6
	hCcMs6RdGPUJ0xVG5QsCY5CnyQGwzElD1f/oYpJLYTC0QVf75dAk
X-Gm-Gg: ASbGncuLX+z8xTRQbm68KVBziDsCYi4hYP2nXDSQdnCr97zY+fjiSmgZXhLDmbFWx5n
	IPEfB4NVV8nd/YknxJo5mSohnvDdi1r4/394NbspYaFEzJV79l/8r6+i3qXRQEMTwdiz6T7mI3y
	Cla6dlB3nakbRjUZhoLILyYdeu+wu4pTPC/NbmafpsawRkRoSvzux7VNoWpNUXDRsMz+Lvulq85
	f1P2lxPYoer6O3G31cwzsgL2JcDfLBQeYoESIxvGA4EzbJr8AU0JHHeTH8Hw9oG/b6HMgDqno6Q
	H4obu/GyKVh8LGtg5QZjIF/W5yvGBNXy6M/wZL8tjLdO/8vSkk13nvMHNJa4Em7huZF2l5lMZv9
	Sui38v+u/83v5hIUlrnCbdIyO1zY1FMoPnqEFTDLs0OEjPKxV
X-Google-Smtp-Source: AGHT+IHnuZrRBIvyzeOBg+q1DKNtU9c2osjRPduNU2d/DlcqFHGhF7goxEuyroXwjSuuWkEUJAEn3g==
X-Received: by 2002:a17:907:7d94:b0:aab:8a9d:6d81 with SMTP id a640c23a62f3a-ab2abc6e270mr1099136766b.44.1736585544436;
        Sat, 11 Jan 2025 00:52:24 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c9564a08sm247982766b.121.2025.01.11.00.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 00:52:22 -0800 (PST)
Message-ID: <b944200a-adc0-426b-92c7-5970054e23c2@gmail.com>
Date: Sat, 11 Jan 2025 09:52:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: phy: realtek: add hwmon support for
 temp sensor on RTL822x
To: Guenter Roeck <linux@roeck-us.net>, Andrew Lunn <andrew@lunn.ch>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 Jean Delvare <jdelvare@suse.com>
References: <3e2784e3-4670-4d54-932f-b25440747b65@gmail.com>
 <dbfeb139-808f-4345-afe8-830b7f4da26a@gmail.com>
 <8d052f8f-d539-45ba-ba21-0a459057f313@lunn.ch>
 <dca1302a-82d2-482c-acf7-d6af76241a6b@gmail.com>
 <5deec54e-b88e-4579-b110-6b897f7cebd0@roeck-us.net>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5deec54e-b88e-4579-b110-6b897f7cebd0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11.01.2025 01:20, Guenter Roeck wrote:
> On 1/10/25 13:41, Heiner Kallweit wrote:
>> On 10.01.2025 22:10, Andrew Lunn wrote:
>>>> - over-temp alarm remains set, even if temperature drops below threshold
>>>
>>>> +int rtl822x_hwmon_init(struct phy_device *phydev)
>>>> +{
>>>> +    struct device *hwdev, *dev = &phydev->mdio.dev;
>>>> +    const char *name;
>>>> +
>>>> +    /* Ensure over-temp alarm is reset. */
>>>> +    phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSALRM, 3);
>>>
>>> So it is possible to clear the alarm.
>>>
>>> I know you wanted to experiment with this some more....
>>>
>>> If the alarm is still set, does that prevent the PHY renegotiating the
>>> higher link speed? If you clear the alarm, does that allow it to
>>> renegotiate the higher link speed? Or is a down/up still required?
>>> Does an down/up clear the alarm if the temperature is below the
>>> threshold?
>>>
>> I tested wrt one of your previous questions, when exceeding the
>> temperature threshold the chip actually removes 2.5Gbps from the
>> advertisement register.
>>
>> If the alarm is set, the chip won't switch back automatically to
>> 2.5Gbps even if the temperature drops below the alarm threshold.
>>
>> When clearing the alarm the chip adds 2.5Gbps back to the advertisement
>> register. Worth to be mentioned:
>> The temperature is checked only if the link speed is 2.5Gbps.
>> Therefore the chip thinks it's safe to add back the 2.5Gbps mode
>> when the alarm is cleared.
>>
>> What I didn't test is whether it's possible to manually add 2.5Gbps
>> to the advertisement register whilst the alarm is set.
>> But I assume that's the case.
>>
>>> Also, does HWMON support clearing alarms? Writing a 0 to the file? Or
>>> are they supported to self clear on read?
>>>
>> Documentation/hwmon/sysfs-interface.rst states that the alarm
>> is a read-only attribute:
>>
>> +-------------------------------+-----------------------+
>> | **`in[0-*]_alarm`,        | Channel alarm        |
>> | `curr[1-*]_alarm`,        |            |
>> | `power[1-*]_alarm`,        |   - 0: no alarm    |
>> | `fan[1-*]_alarm`,        |   - 1: alarm        |
>> | `temp[1-*]_alarm`**        |            |
>> |                |   RO            |
>> +-------------------------------+-----------------------+
>>
>> Self-clearing is neither mentioned in the documentation nor
>> implemented in hwmon core.
> 
> I would argue that self clearing is implied in "RO". This isn't a hwmon
> core problem, it needs to be implemented in drivers. Many chips auto-clear
> alarm attributes on read. For those this is automatic. Others need
> to explicitly implement clearing alarms.
> 
Thanks a lot for the clarifications. Wrt RO and self-clearing see following
snippet from a PHY datasheet. These namings are quite common IMO. 
I think using RC in the alarm attribute description would be clearer.

Type Description
LH Latch high. If the status is high, this field is set to ‘1’ and remains set.
RC Read-cleared. The register field is cleared after read.
RO Read only.
WO Write only.
RW Read and Write.
SC Self-cleared. Writing a ‘1’ to this register field causes the function to be activated immediately, and then
the field will be automatically cleared to ‘0’.


>>
>> @Guenter:
>> If alarm would just mean "current value > alarm threshold", then we
>> wouldn't need an extra alarm attribute, as this is something which
>> can be checked in user space.
> 
> Alarm attributes, if implemented properly and if a chip supports interrupts,
> should generate sysfs and udev events to inform userspace. An alarm
> doesn't just mean "current value > alarm threshold", it can also mean that
> the current value was above the threshold at some point since the attribute
> was read the last time. For that to work, the attribute must be sticky
> until read.
> 
> FWIW, I am sure you'll find lots of drivers not implementing this properly,
> so there is no need to search for those and use them as precedent.
> 
> If you want to support alarm attributes or not is obviously your call,
> but they should be self clearing if implemented. I don't want to get complaints
> along the line of "the alarm attribute is set but doesn't clear even though
> the temperature (or voltage, or whatever) is below the threshold".
> 
>> Has it ever been considered that a user may have to explicitly ack
>> an alarm to clear it? Would you consider it an ABI violation if
>> alarm is configured as R/W for being able to clear the alarm?
>>
> 
> Yes.
> 
> Guenter
> 
>>> I'm wondering if we are heading towards ABI issues? You have defined:
>>>
>>> - over-temp alarm remains set, even if temperature drops below threshold
>>>
>>> so that kind of eliminates the possibility of implementing self
>>> clearing any time in the future. Explicit clearing via a write is
>>> probably O.K, because the user needs to take an explicit action.  Are
>>> there other ABI issues i have not thought about.
>>>
>>>     Andrew
>>
>> Heiner
> 


