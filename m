Return-Path: <netdev+bounces-220926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD69CB497CE
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 20:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B184E101E
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48EB312838;
	Mon,  8 Sep 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfTaRY1k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4AD145B16;
	Mon,  8 Sep 2025 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757354530; cv=none; b=cCOvvuriPkRvw87ce02xezzAuOjmRIZ5TH+sl/ZU3C4nMb2Kgrn+SumMVbDZKfuJz/z36SBZRkk8wc3e+lZtcO9ccExqAq94UHnVlJJSuaeA3qZPASTnNQndmkrUUMjVSdHCgMhxxOXvm0fqUApLQf8fp2c7phFXGsA9xA2bJRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757354530; c=relaxed/simple;
	bh=W6Ecx1Pxm6pVnypIcRy7pTj31dzrtQMTFRBCwzDYq4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqhO5UFPjCqJc6ifXQ9fNBTOPWIlRfWAVHAOwaDZ5tYxCZieG/IgM9UWFPu9ktJyE1R0p+Ss0BSWELqOte4hJ7QKlV4L6A+DIOcPLF7U2hEFC2Vzr54yGknFmmPw4Dgpp21+KYkF/kEUEVMEr/iQVQX/2na/NZ+Q6R1g7XNU4us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfTaRY1k; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b52196e8464so1923458a12.3;
        Mon, 08 Sep 2025 11:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757354528; x=1757959328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Oeapqvce2e/YgpDoR/iLFBVYj0LNwbuiMP+6kJLqgg4=;
        b=FfTaRY1knl1CQIngTI8IMbnHgzrLcmGltZmThPwoxXpxW5prHoOvlLQjCJS80H7EDU
         pdJYkqkPiq6d5LW3TgYc+SDl1EpdNcPihZoPmxECvrbf5BZMRHU2dPzjlUHpTOnodpfi
         Oz6b0gMvesyIc5mDXWiMz5srRLhNg79JdRAxcm+N1shgAJ8ujd64lHQGjFBruciALuLS
         SyxUcYdXqqNi8AyVvG9HgeAacwUOAiZvOMlEykGaYAbujwsT1RUVSyrtH5mpLgfui2IM
         Ehe3T+Oa9CxcAbD4Pt2k//vldt/7rlxhS6b4m9UTb9gQu68JcaonpYLah7rH8daTrQgI
         m7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757354528; x=1757959328;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oeapqvce2e/YgpDoR/iLFBVYj0LNwbuiMP+6kJLqgg4=;
        b=Yxd5LdBZPb4hkCLlRIL09MWCVjwGMjvXmxyRUPtdOuIpVn/rEFivWw01nqaLPjT23V
         qop1IkRJUQ3yCMM5VYa+ZRY0ZfEZuFR8pRWP0Elqn+S4S1PZc8bQiR0muLVTu3wVhZRq
         w3XRKAFBBLE16uYPxyYyqVOSfwe0wIHy6EnMvsouRp260IiFAj1rojtGlyu4+tEvcOWZ
         UraZjWh8vGoXEQ3aUM/VJPDMs5UpmAgNwWOrD1mgwS6aZK6Iic3o80sQowvPybXRKtQh
         LbwbBRtqDewLTQFgdO7HhP07MKd0eKZGCod/FpvUz7U9vJAxt03Mw5+5FQwxcjKbrmM7
         OntA==
X-Forwarded-Encrypted: i=1; AJvYcCVIXUJK95YrVEcGoTckvGR/6A9KPYek2e4dLvjG1MsaLf90MWBGhl4lGLMekGqWc2Z0+kfgUt3c/mVH@vger.kernel.org, AJvYcCVmRBJwPwQS/j+y7tHY6qNVBLcKUshC9D7AkLCuuGeRUA++BxsU+5dOb4WDHbITG4B2Of6Fd3KOoPR0n5Q=@vger.kernel.org, AJvYcCW3itdqOrM6H3q/PjiZGbIUeIb6sANQjsnyX1lzndBd+l+U/l4NW+iJ0/KoIPFPmAke7MEGPxb4@vger.kernel.org, AJvYcCWMa+rLCM9j2X9lH/nhQoIJeb4eMIiQwa8e15SNNz2BSWZdODF0W/FL8ovxcmyG5etokjkJb6KTT/Fj1jFM@vger.kernel.org, AJvYcCXgV1pYSaIdKubKpTy//0g8CWYzjoB5CYA6+Uk7nEmVXbLls91Hq/34w2h0tJzawzvJF9u1cg1hUxk9@vger.kernel.org
X-Gm-Message-State: AOJu0YzLLVm5hM4xwgOkdD+FSDSbdtgw/m7tJasfOQ8stMr8e7Kc9NA9
	7Mmr2xLxR80e7FUygbQg+MFDJrm5ExtxPXzJj0khzIpzANrGVP98LzO4
X-Gm-Gg: ASbGnctNKS8TrmYC0tGvz6CY0EydtjigaKGYkIOQ0dKe2d0W9XHun4F4kOb2c6CTpfP
	NJx2TgCb0EtIat2KwJ5P8GxmjKhwsxdjP8CXlnwgcp4yBkJ37MBYI4GlkprIL88tiyh6AZ2LFFi
	J5F4/DF0mX4UJOQC4jq9+4RlQpvT5jHTdvFIBwiXuwA97ilJhoNpEpTVGlNW2BoZ9L79RTFIx0d
	yyfWiKtTeqRzpDBCfLT5555R9LUxAT7Z26RrnxUHpkcJhXmtvhXA/dFuygWkveTII+bP6K+81Wz
	QqV0UD/afFU7vsG6BoXHJk0AERmaNEKa7MZdnclm97AfGc2Lc7A4vKhI6PPO4pHXKEpC6MIVp46
	JkxYRqJk5NBHJeAd1XYCVHcupxc7PgRIufVQkdXQxsFla3ik5yffjBgx4jylYBnipHO6YgTrNbQ
	GElsk3C2n+DdWYensw
X-Google-Smtp-Source: AGHT+IEeU/DB0HOb4fPagqRudZuMsg2x4PoB+G/k1VfzfmYv6JE/beBzNlrrOjMK54ZO08DaRL8UPA==
X-Received: by 2002:a17:902:ce89:b0:24d:64bc:1495 with SMTP id d9443c01a7336-25172e32f31mr123848925ad.41.1757354527849;
        Mon, 08 Sep 2025 11:02:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28c3110sm133495925ad.120.2025.09.08.11.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 11:02:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9e4db8d7-c99f-46f3-9ddb-00b0a9261d86@roeck-us.net>
Date: Mon, 8 Sep 2025 11:02:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] hwmon: (tps23861) add class restrictions and
 semi-auto mode support
To: Gregory Fuchedgi <gfuchedgi@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>,
 Network Development <netdev@vger.kernel.org>
References: <20250904-hwmon-tps23861-add-class-restrictions-v3-0-b4e33e6d066c@gmail.com>
 <4e7a2570-41ec-4179-96b2-f8550181afd9@roeck-us.net>
 <aL5g2JtIpupAeoDz@pengutronix.de>
 <CAAcybuvqqKBniV+OtgfCLHJdmZ836FJ3p7ujp3is2B8bxQh4Kw@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAAcybuvqqKBniV+OtgfCLHJdmZ836FJ3p7ujp3is2B8bxQh4Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/8/25 09:39, Gregory Fuchedgi wrote:
> On Sun, Sep 7, 2025 at 9:51 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>>
>> On Sun, Sep 07, 2025 at 09:06:25AM -0700, Guenter Roeck wrote:
>>> +Cc: pse-pd maintainers and netdev mailing list
>>>
>>> On 9/4/25 10:33, Gregory Fuchedgi via B4 Relay wrote:
>>>> This patch series introduces per-port device tree configuration with poe
>>>> class restrictions. Also adds optional reset/shutdown gpios.
>>>>
>>>> Tested with hw poe tester:
>>>>    - Auto mode tested with no per-port DT settings as well as explicit port
>>>>      DT ti,class=4. Tested that no IRQ is required in this case.
>>>>    - Semi-Auto mode with class restricted to 0, 1, 2 or 3. IRQ required.
>>>>    - Tested current cut-offs in Semi-Auto mode.
>>>>    - On/off by default setting tested for both Auto and Semi-Auto modes.
>>>>    - Tested fully disabling the ports in DT.
>>>>    - Tested with both reset and ti,ports-shutdown gpios defined, as well as
>>>>      with reset only, as well as with neither reset nor shutdown.
>>>>
>>>> Signed-off-by: Gregory Fuchedgi <gfuchedgi@gmail.com>
>>>
>>> This entire series makes me more and more unhappy. It is not the responsibility
>>> of the hardware monitoring subsystem to control power. The hardware monitoring
>>> subsystem is for monitoring, not for control.
>>>
>>> Please consider adding a driver for this chip to the pse-pd subsystem
>>> (drivers/net/pse-pd). As it turns out, that subsystem already supports
>>> tps23881. This is a similar chip which even has a similar register set.
>>>
>>> This driver could then be modified to be an auxiliary driver of that driver.
>>> Alternatively, we could drop this driver entirely since the pse-pd subsystem
>>> registers the chips it supports as regulator which has its own means to handle
>>> telemetry.
>> Yes, Guenter is right. This driver belongs to the pse-pd framework.
> No disagreement here in principle. However, the current hwmon driver
> already implements power control and exposes it via in*_enable sysfs
> files. I found this a bit odd, but I don't write drivers often.
> My understanding of Guenter's suggestion is that it would require breaking
> this userspace API?
> 

If the enable attributes enable power to the ports, that code and functionality
is simply wrong. It should only enable (or have enabled) power _monitoring_.
As such, changing that would from my perspective be a bug fix.

And, yes, that slipped my attention when reviewing the original code.
Sorry to have to say that, but I am not perfect.

>  From a quick look at the tps23881 datasheet I can see that it is
> similar, however, it is quite different in the context of this patch.
> tps23881 (unlike tps23861) has Port Power Allocation register that can
> limit poe power class. This register can be set prior to
> detection/classification. So the extra complexity of an interrupt
> handler that decides whether to enable the power may not be required.
> 
> Perhaps it still makes sense to merge these drivers, but I don't have
> time or hardware to do it at the moment.

I didn't suggest to merge the tps23881 and tps23861 drivers; I just pointed out
that they have a similar register set.

The point here is that a hardware monitoring driver should limit itself
to hardware monitoring. Actual control should, for example, be implemented
through the regulator or thermal subsystems.

Guenter


