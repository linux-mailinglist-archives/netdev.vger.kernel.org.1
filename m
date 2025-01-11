Return-Path: <netdev+bounces-157323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267ECA09F2E
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 01:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA0E7A4540
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F6EB67A;
	Sat, 11 Jan 2025 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jB94odCA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2132114;
	Sat, 11 Jan 2025 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736554828; cv=none; b=mT6OpqWuuMAk9+19AE+H9UqZFyuBckvpyQibW+J8f/89FZTPH64Mgt+8CN26/bywcSvviGE8lJTrbYPTiNntbUQV+TPOVWG2NmWrLt9hDQ0tNyVCiQqUa3G22dF8mOJhWucP1m3jbuH4uzYCb3h+r6GMkFf704xqmL6RUL61Bj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736554828; c=relaxed/simple;
	bh=U7YBK2iUeYaBZ96ScNRrhv/FwRwEW1DaSZsVNkGIkoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0qAZ4V0XhgH/60MJ7ab097LFhgOZRMlyJK95jb+Q+G/HXuPn+99jD57vmuLGOuOLQhwRgN7FjXeBvnfxchziQ64SdJs4LsnU5KB06cGm9hrqxq8fEuiBsxARD+AftRkAAlJMxQ5KQn+avN3Gfmi5IyXvuxHA4KElLGpXF2H8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jB94odCA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21619108a6bso44792755ad.3;
        Fri, 10 Jan 2025 16:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736554826; x=1737159626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dGgbQCdCUZzJPxvcxOcN4Yhv4gHsi+XWn6suzUM0YEc=;
        b=jB94odCAjwj82ObaiU0ujx0Jg354AooOooIJi6vcArd3Au2XCpcvdwvNNLVycYsv2J
         KVT2PdNUn9IqrY9cGBlkn1JNrVfbNlewb54iT52x71Tm8zoo6XWZRkmNwZU5zUztb3Vr
         Au1Frbo6Sh2pxgZM0oPvD3DFXF0mjxxOdEOyIuAJPuoUwARHFMMK9E+YI+Lfb81VSbod
         LPCU7Zfbl17nl0a0XbtL8poFei2CFkQmQ6VrWnxUmQUqijN/SstVPFdlispAfteddeAz
         Aq3OE88J3Bl00yBzSCm/7y6g1V8gIPtPuZ2wJ6fHAM3UKBcu7DmNY1u4K0ZE2oeBI2Q5
         cRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736554826; x=1737159626;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGgbQCdCUZzJPxvcxOcN4Yhv4gHsi+XWn6suzUM0YEc=;
        b=qrAn8SFor3rzb9+ip8IndLXLNwqfF9Da+nhvAim1Uo1bXV2hmVce00eoSh3Msb17C7
         8rKgWX/or3a8otCXYZT98o5NOzjdV3P+poGzqidtrGfR8+jZH8zKuosIDaaBVQo8aha/
         9Y34fOul0S6YnmBSiDY1Lh25sQ5Z64D7c7RqpvIU1G6bvL/ErYY3R/sk2K+6o6X+qnqm
         at0ZDFmFC6hPsEMPJWZ6cJowNVoBntD0ioCdLd3cMfQ0NncEjIm2yJcnrIiXRkSlYVn2
         owEV4znitK+GCtD3QHRR2WnMNpMRN6yO+9EwiAJVLaGkTh/0GgiysSFptf4vZJ9cIqqm
         fx8A==
X-Forwarded-Encrypted: i=1; AJvYcCWmOs5oom12aKk5abVqmalBWZ+huuosGE91Ghy7Vrl/Ryt3sOvYkALtIn/kxwa8rrLjDahVuYHQ@vger.kernel.org, AJvYcCXFLIJYAjuWZF6IvRJ4r51eOpBPNO7uw8eDWBHPf69rd4OY/mF5ILsIl4Jv4fGbpnylvBEv99ZaOYvTsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZBDLnSQbWGDQZqi6Kqz6MpvtruRYoJw5WtD00nWxe/Tuxmwn0
	mPm84bAVJxNBFGl9MChqGjsXBdmsvaWw/nMiil8VjwC2svSArerU
X-Gm-Gg: ASbGncun6rjp7uMgQv9g8YDg2hX8fPvhBslYLW1Vyyn4S8TaddSxfMvd+xrgulPhdLt
	MdSzpSwB1vv532EXb3SqK2Kny2UvJR7gAM5KXdpOHZ1pov6i0ns71CGWtif+TJHVHtGNd9pwFuA
	MLXogcr7RwpPVbYobTtOZ7Tqb0kDUkhKWmoywNxWSrK+f4i6fD46vXA69ZAG+AILg+p1dN3HRtJ
	9JiiV2/xs/aW85snaURgxjtObIhxC7ZH0jUfRzENRoAdDScctrpVeLUfSj2q3tEoHp6SaMjTe8e
	XFOC2FIVW7qMeB6JEga4iZ7u7KMMOw==
X-Google-Smtp-Source: AGHT+IFM1JbZkAFhBMc7eh4B4KAbkNtYxTL8m8MoD31Tqf64+y/hrkHXeFs0K+ONcAMMTXF58qQz9Q==
X-Received: by 2002:a17:902:ec90:b0:215:e98c:c5bb with SMTP id d9443c01a7336-21a83f6464emr188208805ad.28.1736554826182;
        Fri, 10 Jan 2025 16:20:26 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f12f8dcsm18492775ad.66.2025.01.10.16.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 16:20:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5deec54e-b88e-4579-b110-6b897f7cebd0@roeck-us.net>
Date: Fri, 10 Jan 2025 16:20:23 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: phy: realtek: add hwmon support for
 temp sensor on RTL822x
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <dca1302a-82d2-482c-acf7-d6af76241a6b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/10/25 13:41, Heiner Kallweit wrote:
> On 10.01.2025 22:10, Andrew Lunn wrote:
>>> - over-temp alarm remains set, even if temperature drops below threshold
>>
>>> +int rtl822x_hwmon_init(struct phy_device *phydev)
>>> +{
>>> +	struct device *hwdev, *dev = &phydev->mdio.dev;
>>> +	const char *name;
>>> +
>>> +	/* Ensure over-temp alarm is reset. */
>>> +	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSALRM, 3);
>>
>> So it is possible to clear the alarm.
>>
>> I know you wanted to experiment with this some more....
>>
>> If the alarm is still set, does that prevent the PHY renegotiating the
>> higher link speed? If you clear the alarm, does that allow it to
>> renegotiate the higher link speed? Or is a down/up still required?
>> Does an down/up clear the alarm if the temperature is below the
>> threshold?
>>
> I tested wrt one of your previous questions, when exceeding the
> temperature threshold the chip actually removes 2.5Gbps from the
> advertisement register.
> 
> If the alarm is set, the chip won't switch back automatically to
> 2.5Gbps even if the temperature drops below the alarm threshold.
> 
> When clearing the alarm the chip adds 2.5Gbps back to the advertisement
> register. Worth to be mentioned:
> The temperature is checked only if the link speed is 2.5Gbps.
> Therefore the chip thinks it's safe to add back the 2.5Gbps mode
> when the alarm is cleared.
> 
> What I didn't test is whether it's possible to manually add 2.5Gbps
> to the advertisement register whilst the alarm is set.
> But I assume that's the case.
> 
>> Also, does HWMON support clearing alarms? Writing a 0 to the file? Or
>> are they supported to self clear on read?
>>
> Documentation/hwmon/sysfs-interface.rst states that the alarm
> is a read-only attribute:
> 
> +-------------------------------+-----------------------+
> | **`in[0-*]_alarm`,		| Channel alarm		|
> | `curr[1-*]_alarm`,		|			|
> | `power[1-*]_alarm`,		|   - 0: no alarm	|
> | `fan[1-*]_alarm`,		|   - 1: alarm		|
> | `temp[1-*]_alarm`**		|			|
> |				|   RO			|
> +-------------------------------+-----------------------+
> 
> Self-clearing is neither mentioned in the documentation nor
> implemented in hwmon core.

I would argue that self clearing is implied in "RO". This isn't a hwmon
core problem, it needs to be implemented in drivers. Many chips auto-clear
alarm attributes on read. For those this is automatic. Others need
to explicitly implement clearing alarms.

> 
> @Guenter:
> If alarm would just mean "current value > alarm threshold", then we
> wouldn't need an extra alarm attribute, as this is something which
> can be checked in user space.

Alarm attributes, if implemented properly and if a chip supports interrupts,
should generate sysfs and udev events to inform userspace. An alarm
doesn't just mean "current value > alarm threshold", it can also mean that
the current value was above the threshold at some point since the attribute
was read the last time. For that to work, the attribute must be sticky
until read.

FWIW, I am sure you'll find lots of drivers not implementing this properly,
so there is no need to search for those and use them as precedent.

If you want to support alarm attributes or not is obviously your call,
but they should be self clearing if implemented. I don't want to get complaints
along the line of "the alarm attribute is set but doesn't clear even though
the temperature (or voltage, or whatever) is below the threshold".

> Has it ever been considered that a user may have to explicitly ack
> an alarm to clear it? Would you consider it an ABI violation if
> alarm is configured as R/W for being able to clear the alarm?
> 

Yes.

Guenter

>> I'm wondering if we are heading towards ABI issues? You have defined:
>>
>> - over-temp alarm remains set, even if temperature drops below threshold
>>
>> so that kind of eliminates the possibility of implementing self
>> clearing any time in the future. Explicit clearing via a write is
>> probably O.K, because the user needs to take an explicit action.  Are
>> there other ABI issues i have not thought about.
>>
>> 	Andrew
> 
> Heiner


