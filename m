Return-Path: <netdev+bounces-157402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64561A0A2AC
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 11:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB4F7A3EDB
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8135E19004D;
	Sat, 11 Jan 2025 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxlH34z9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF018E743;
	Sat, 11 Jan 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736590587; cv=none; b=aojRBNZ3AcTy3CFT+mYUUewHo9Au+zEovWu0sxF8l8yOylcOpCYwqbKhc1VuKvWHxw70jb1MbN2ENUpnfOXKx8mPC9AhbEWUbG6MrXt50NsiTGYaty40Rro0D6nSy7J2x+j/44oYgLK1BnRgSojn8yG8y6uK95VkQFLsrK6zs1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736590587; c=relaxed/simple;
	bh=99+K7hENN8oDqL47Aopq/2yREwwKelyxFzRh/b69KsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQxvJBegVho5JcUKPxebOWXiQk3dQ1IW+e7GLoW/FdlrfeHshSH/7zXcH9Mp7wpdu/O5CZHJKwLuE6MAxHYDXIp3QAwHVoaHJXJRnlx6WHHwQqIw+98KXTnyM7pSFfDMzmf7r+sEptoerJ23wa+5mcdj8ez3wk9mTo8nHrfIuKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxlH34z9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso20117815e9.3;
        Sat, 11 Jan 2025 02:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736590584; x=1737195384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UgIFLz3q1G73yW+f9urA2QxiesrkrY5yzKecHTpdiho=;
        b=MxlH34z93LgpJzqzJ76rKIWKgECBBQNeci4cNJm4GE8yK4KOHyXuJtHgjilJiJAQtH
         WPv+p5vxv38QIXzvpRAPAqubXOnYlJbYph4B3LRxdGnBBWDJUWlFiRcS/2tAk4FyyXtc
         4WFyJEHSUfrnIbFeTvWquHKYaGmFXNXNi24RVATdfLzorG924P4GovMi9arj7HtZJ+8G
         Sb4s4RXAxvlOqtmJgbt3BSfXlQheGrE3wn7+ef80xc9kJeDiWcTY8ne35VId3hldGmnA
         rbexWvzhmquwnmPJ5ZB7iCJHg4uTW4lP+25Y+wMhKTqhL+lElth/IdFlb/sn/y6+H8zy
         jT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736590584; x=1737195384;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgIFLz3q1G73yW+f9urA2QxiesrkrY5yzKecHTpdiho=;
        b=sw2AL11vhMlXmvooOa2KLb4/0z1xGnz4SVm5heHEXyoBXRW1MfNsPY3ZXFL/Lhq7Va
         P6+s2m5nW7xrBOPdDrUtmomKuDgx22viS8PTaXJtVupxxSvD5p8fdOgDtpLSAs5s8zi6
         vPGWBJm157pF6xHYRS14YsID0KZu98ZSsXKki3/etnPOwjTTqAbnzTSiSxSROhQ4RftW
         AfVsiwzzjmbPkzV8cDnXDarFX4/bF9ho9XmKGWspZZT8aBQJqfAtLC+ZGLPqaXnAnB1U
         QSsGriWR6OT/h9sodKuXnORzmdfxgsFCn2aJl1JZKdYFQ68kYKpAhSQc79xSWH/XAq2Y
         wfBw==
X-Forwarded-Encrypted: i=1; AJvYcCV6h5MDB0Rd++H19Q2W4Fv2GIQ5yOxUlsb8c0i+73/5l5JFWKAPeFdnmfzhs+v4Fh7q3tuJgRPj@vger.kernel.org, AJvYcCVyjYz+MFR+PFBsqdlTHw4atR+EPFajaO+t33bEESKeJ5cHN9UMvlQlKjKtCps8DRAFmrutoLQx6S9b7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWuElHP8q+6riROMTxWSNUxSVNPF/PZedv5XHGrb4TqAngZ61+
	dvQWYAPdk+hiA2c1vD0q1Sy3U0jnDKT0aQABFSGf4xMgkT4miusG
X-Gm-Gg: ASbGncuSMdCFcCxVmcFlukHUsE6pizS2tOM5Hr3ze9njoAkcv2awtZiQg+jVeJaPMoy
	OTqDfFZuW9jk2fxvx7HvTN8MmpYBHYNF4VJ13bgQJLZz161sxu535Cz2o24Dr415mXzOwJ14X7O
	GuKUOctI/uRk69wwG35ixGFiUOIMy3FBHFrJkAvuNbzJqd69EbuMcNoWANzuIYAPYQPdgzZYHB/
	MxxEHJqVAiNSrRkoYpljMDBOuPmhkPhx/5nDzcDXV2Z/z1iQL//4+VDdFXhfh972+3FYqKy3v1s
	11cXaEPXrDhGHYy94CyxwkrDEYV3wONe1bvIR1HWHl3IB/VFtpm9aYja9va/5tq7fXMdyL0SgL6
	/+MviFtl45/NabtlD/yLMPNvRIQ4BGqEtm3bU2qdSSVodmF9d
X-Google-Smtp-Source: AGHT+IGY6PRYDGGlQLCeYCP2y78RXnRzNXrgOXFuF6NpzJoa9RIH9xEp2ftnX6js1Ub3v0ShChhFXQ==
X-Received: by 2002:a05:600c:3c9e:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-436e26a6727mr126555115e9.8.1736590583733;
        Sat, 11 Jan 2025 02:16:23 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fc81sm79517695e9.5.2025.01.11.02.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 02:16:23 -0800 (PST)
Message-ID: <a0ddf522-e4d0-47c9-b4c0-9fc127c74f11@gmail.com>
Date: Sat, 11 Jan 2025 11:16:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: phy: realtek: add hwmon support for
 temp sensor on RTL822x
To: Andrew Lunn <andrew@lunn.ch>, Guenter Roeck <linux@roeck-us.net>
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
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <8d052f8f-d539-45ba-ba21-0a459057f313@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.01.2025 22:10, Andrew Lunn wrote:
>> - over-temp alarm remains set, even if temperature drops below threshold
> 
>> +int rtl822x_hwmon_init(struct phy_device *phydev)
>> +{
>> +	struct device *hwdev, *dev = &phydev->mdio.dev;
>> +	const char *name;
>> +
>> +	/* Ensure over-temp alarm is reset. */
>> +	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSALRM, 3);
> 
> So it is possible to clear the alarm.
> 
> I know you wanted to experiment with this some more....
> 
> If the alarm is still set, does that prevent the PHY renegotiating the
> higher link speed? If you clear the alarm, does that allow it to
> renegotiate the higher link speed? Or is a down/up still required?
> Does an down/up clear the alarm if the temperature is below the
> threshold?
> 
> Also, does HWMON support clearing alarms? Writing a 0 to the file? Or
> are they supported to self clear on read?
> 
> I'm wondering if we are heading towards ABI issues? You have defined:
> 
> - over-temp alarm remains set, even if temperature drops below threshold
> 
> so that kind of eliminates the possibility of implementing self
> clearing any time in the future. Explicit clearing via a write is
> probably O.K, because the user needs to take an explicit action.  Are
> there other ABI issues i have not thought about.
> 

According to Guenters feedback the alarm attribute must not be written
and is expected to be self-clearing on read.
If we would clear the alarm in the chip on alarm attribute read, then
we can have the following ugly scenario:

1. Temperature threshold is exceeded and chip reduces speed to 1Gbps
2. Temperature is falling below alarm threshold
3. User uses "sensors" to check the current temperature
4. The implicit alarm attribute read causes the chip to clear the
   alarm and re-enable 2.5Gbps speed, resulting in the temperature
   alarm threshold being exceeded very soon again.

What isn't nice here is that it's not transparent to the user that
a read-only command from his perspective causes the protective measure
of the chip to be cancelled.

There's no existing hwmon attribute meant to be used by the user
to clear a hw alarm once he took measures to protect the chip
from overheating.

> 	Andrew

Heiner

