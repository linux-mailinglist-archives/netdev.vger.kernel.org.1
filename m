Return-Path: <netdev+bounces-248736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98876D0DD6D
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 486BD30161AF
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 20:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9837C1DF25F;
	Sat, 10 Jan 2026 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icN58/h9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22712500966
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768077608; cv=none; b=A2qV0/FWEzIgRJqfrADN7mRN/rUVa5rHSgo58cZKL6WYDk30vLMOANZWkfItYpUz/XkBmMMDrxz3+959OABmiAgW3UWwQ86SACjLDgKCfk+ya01isL85xINKD3nkZL7b+u1W6g5DIz6wAuQ59tPg2TIu2qfbsBJJDutbfUcjWJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768077608; c=relaxed/simple;
	bh=DzINUMiYE3qIW0sC8NX9E1jxc3z5bNpowmPgKQgJv3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeG6QLBydMs/H1dtOxj7cXDfccJvFWU5Lkq9bY9KtwIEBzaZ7+AQqUAu660ztegiP5+UAFy6/ztQgf3hLEhlvFV8iw162RSkUXg7/Ni23vYOh0CnD+KeMFtR0CQixCqKLGKcdDhvuN2mxwGf9BAeNh+S92cuTPKeEf2Ww5+YIII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icN58/h9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so57908945e9.2
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 12:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768077605; x=1768682405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=56/tEBNogSWLSQPrFFl8skKl1ibOcwubXMFCHZrFQDc=;
        b=icN58/h9VgTsuLTJAlHOXe7DRIF202sj8cxdkh9WupNUIeLBlIUjNP5qdIJIIRPCP5
         kNqBRSeM4/p1NB0Khr1z032eEsOXV6+TV4IxtsI7W9JzHMSWbYt5eOotMlp0w+HjpSuh
         DMyxTeYv+Cgfp4E8lbSt9VLiUrt9Zuy/QEmABd6TmuMcGwpGiqsZpT7LEY66ifomkjia
         lQJVx7HYwT56DYtSk0QUekqeu3kB1ZQjeB5wdkuukfr6aIHzjJkRNX2HqYZHeTWgWxuk
         S8sN6loBsxwrVprUpnyvFQImpTsIizBsPu8bUVjds0t6tfLkl4r9qirM/zZuysD8+DAV
         WLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768077605; x=1768682405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56/tEBNogSWLSQPrFFl8skKl1ibOcwubXMFCHZrFQDc=;
        b=EGme23Q0J3WUkEwo41SNUi04MHk79c4ssezpnMcchyJBooivweCahp/QUTH1BiNe+H
         h1D3LFHj26UbLLYMOAdUQDnLvyUxkx1aviWU98up+WltpJLwh3ChgCxpKQxQDx+roAOs
         oX+sDTcSOLt/bvuE3Q6aPIfHb13hSwWqR15SaLzryNVdG+TJV0NAomYwD4/nLssHCoud
         ZDMH/7TYBMba/fKVNwGuKTJV3nyQdwZLuQm86MFR0/CoEVBrYQ4tz3I9dAbcQBbJUrHe
         YThO+WSVnEAf2VDiZ8kBG2roe0YqaAPQ/DsGJmFi0uXJi8C9/ik8ozXdKrg1Pj0umj6O
         SHsg==
X-Forwarded-Encrypted: i=1; AJvYcCUkECpV4b8jmWx7Zx6OA4vNqWEBhT74a6UGBnxigFj0ZB6WYNyNqRQhrsku6ewjAQY3B6ETySA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfSmwC1RMaZbE5XpvXQX7IYhI1Kzs/a1ogjLC10OhTMT/JzVz6
	5oVS8Zzhgd1YoVEaaKSgrvY57x5UOOugOhcup44HEg4bh3BKQq85nY0c
X-Gm-Gg: AY/fxX4Q6aFGQj146NB3TUxIvJIWHockVZOO5MDuKSlAU9oP23olccCYNawpz3ZyRF1
	kLF9esmMfAsPcx7L3dvPhPmjoXZBv9/HsS+KeNaBrMT3EjIa/bNPkIVohw2bcze5nIK99pIRsyB
	9hcR0/yGDHEVd++haPVDvtOqT1vWkP7A9kr6sKboC6mb2QjAA1gajwfMkzJ+NalVQ1uaiaocS4E
	kF+yeATdM9yrCn59R12h1p9q+3244pe4pxocfMZiaLRLUFRjsh7zFxewnVVJGwUHXWa5QKDcGAV
	zjS+nUncyAkBxpv7ofTIesh3TsUmKVYSgiFH9qOKpKrYHSLD1ow/tq183UHrK7lA2P6NTbrkJBA
	MHvProv7dhKj6Pyy8LiQF42qwLUP16gWSNlAY408oIG/glFffBogPzKfFLQhfa3EZob6F1kr3rh
	REOXgxvTUMiSQcLuPJzemTIStTlBZSJCBvLgpK71Es3N2Dep1Bk/RRaBzq/5aHmXNTUjiY9YPcy
	YCtytZwN5dtcNzMtvm6OJXVK+rmsWRset5Q3uVT2EOaJXLLkfdkgg==
X-Google-Smtp-Source: AGHT+IHEYM+VfgpGFoMRxYTgz9DPD9vxG4M2JnxL1vTypWEivxzslm/KP4wMr9wjnzV8MCs33QiTCQ==
X-Received: by 2002:a05:600c:1392:b0:46e:4a30:2b0f with SMTP id 5b1f17b1804b1-47d84b3863fmr154331985e9.29.1768077605417;
        Sat, 10 Jan 2026 12:40:05 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1c:1800:8cc6:804e:b81b:aa56? (p200300ea8f1c18008cc6804eb81baa56.dip0.t-ipconnect.de. [2003:ea:8f1c:1800:8cc6:804e:b81b:aa56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8717d9e7sm89831495e9.8.2026.01.10.12.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 12:40:04 -0800 (PST)
Message-ID: <2fa7fd1c-6f4c-4988-ac15-e576c6326542@gmail.com>
Date: Sat, 10 Jan 2026 21:40:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: realtek: add PHY driver for
 RTL8127ATF
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Michael Klein <michael@fossekall.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Aleksander Jan Bajkowski <olek2@wp.pl>,
 Fabio Baltieri <fabio.baltieri@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
 <492763d9-9ece-41a1-a542-d09d9b77ab4a@gmail.com>
 <20260108172814.5d98954f@kernel.org>
 <6b1377b6-9664-4ba7-8297-6c0d4ce3d521@gmail.com>
 <20260110105740.53bca2cb@kernel.org> <20260110110052.5d986893@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260110110052.5d986893@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/2026 8:00 PM, Jakub Kicinski wrote:
> On Sat, 10 Jan 2026 10:57:40 -0800 Jakub Kicinski wrote:
>> On Sat, 10 Jan 2026 18:23:06 +0100 Heiner Kallweit wrote:
>>> On 1/9/2026 2:28 AM, Jakub Kicinski wrote:  
>>>> How would you feel about putting this in include/net ?
>>>> Easy to miss things in linux/, harder to grep, not to
>>>> mention that some of our automation (patchwork etc) has
>>>> its own delegation rules, not using MAINTAINERS.    
>>>
>>> Just sent a v2 with the new header moved to new include/net/phy/.
>>> patchwork is showing a warning rgd a missing new MAINTAINERS entry.
>>> However this new entry is added with the patch:
>>>
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -9416,6 +9416,7 @@ F:	include/linux/phy_link_topology.h
>>>  F:	include/linux/phylib_stubs.h
>>>  F:	include/linux/platform_data/mdio-bcm-unimac.h
>>>  F:	include/linux/platform_data/mdio-gpio.h
>>> +F:	include/net/phy/
>>>  F:	include/trace/events/mdio.h
>>>  F:	include/uapi/linux/mdio.h
>>>  F:	include/uapi/linux/mii.h
>>>
>>> Bug in the check?  
>>
>> My reading of it was basically that it's upset that realtek PHYs don't
>> have a dedicated maintainer. The check considers the PHY subsystem as
>> too large for the same people to cover core and all the drivers.
>> If that's the case then the check is working as expected.
>> It's just flagging the sub-optimal situation to the maintainers.
>>
>> I wasn't sure if you'd be willing to create a dedicated MAINTAINERS
>> entry for Realtek PHYs. The check itself is safe to ignore in this case.
> 
> PS FWIW the check is our replacement for the utterly useless checkpatch
> check that asks for a MAINTAINERS entry every time a new file is added.
> I wanted to mute that without feeling guilty for ignoring a potentially
> useful suggestion so I coded up a more intelligent check which asks for
> MAINTAINERS entry only if the file doesn't fall under any reasonably
> sized entry already.

I see, thanks for the explanation. At the moment realtek_phy.h holds just
a single PHY ID, so it's fine to give it a home with the phylib maintainers.
You're right, it would be good to have dedicated maintainer(s) for the
Realtek PHY drivers. Ideally persons with access to Realtek datasheets.
Maybe based on this discussion somebody volunteers ..


