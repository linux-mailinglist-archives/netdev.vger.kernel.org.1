Return-Path: <netdev+bounces-222226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72E2B539C4
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5253C5A491F
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2B535E4FA;
	Thu, 11 Sep 2025 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khQKod6g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB11DD525
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609891; cv=none; b=U+7bGD3uppNIN5HUMYmOlJgNLN/Shy6hK32XS8W5mBvSRcDTaGwA5pLGM7R3Dvz23VUCT46EMv0J4lnGfkmdrHc9EgKEeB8qvUAf6wwBUCt2olv8bvaK0004yuiJ5rwaRlDmBJnJTHx8693O81Wj0I9alk69LLFSXHT22rPQE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609891; c=relaxed/simple;
	bh=6ovyea3O7NGltnxmNhtflLNF08x0hn2fzo6Glcf2CmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLO/C3ZmR6ORLh/Hp7y+h/32oiik7xLyY2csxMy3nQgwpj/ahHesLhFyK38Vtkr0N2teLiXZBhmdjXPr51Gbe07TNBiJXEKvyHm/nRyyqzEM8jxt16fhqzWNoNt+sDu4PtAKXjlecqIuNgUS10HneAMuCpJJ0FoApepIKHY3aCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khQKod6g; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso9044925e9.3
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 09:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757609887; x=1758214687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xypTmgMoHDS9YtVHnj3HrqchlP5fgQakI4lgkJ5GvgQ=;
        b=khQKod6gKeelbnF8XtNq5WozF7t0/+t1TdBuzhxurwEACDY5zn/LINmmsdAtsIB5UG
         bWSzFw6/Ds8nEVXttNGGvV2hS25RX6btCltIvH6GchoFoDjpeQeV50LsUtsGQ9Wdj5c7
         LS/hm+hK5h3PFf3w6+/w+BQ7KQ6ZjlniRk03tOsHoi1olGzRRyG8/Moj8Irei39saeQC
         GEx/QeytjgQ65bcy6VEq6g6HzmkSKKPuVYngCa5Mcql8DmWD9Zux5d+gviY8bUu1Qz07
         t5PlFbYOkbAgGiXJSsCvx7vosE9XYrVSG2vqxpYRUH6N27EAsEf2AfOnju0gyNpTU3Is
         KENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757609887; x=1758214687;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xypTmgMoHDS9YtVHnj3HrqchlP5fgQakI4lgkJ5GvgQ=;
        b=LtEW+n6soi1MNH80GXh1+HswblCLSShMYy/qM6UL46URCuCusaUWTkDUtzpF481ft7
         oHNxEy5f7lru8947speCYrwKM4xQtt2lSk9NS75JPnjNLKmwllnLjVcZkU4SdixUw6j+
         74Z9R21umr27KZ2YAeFJD2MXVj/fA6RL2/kSwulML+Eg8grXMYwmSTyKjZUNojhiyyYA
         679bjOK1MLLhk0Us4S/+bMleTF8L+rJkeMtJ5SlUnY5lOX1/cX3xUJIIdgb2sJeqSbz4
         F9C1xtjbxrsAc1fBL+52PNC+XMqN2tx/coLbAq3paGVOg9fWb1aZIjEhI5dAmxkwX1BW
         dBqw==
X-Forwarded-Encrypted: i=1; AJvYcCXD5MJLlHeNShYXYOHUFPK9fO9YRO2UJpi1nvAiOP2a06rMFddzqzwmU674PwXyzTgosAAm3Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyLQFvVpotg0YDcDkz/HgntO6d4z/IK1Y/KDKAiEEo0ZnXusT0
	jjCprbS8MkRhj4K92z7YpU4b2EhkL7vs9aPBG6wKwq6BQ+eKs/EA/fFY
X-Gm-Gg: ASbGncuNHeUah6QErRyKZVGAZ68DLBW+Vapvu7dI+6nQhoaiSWtB7qj4y2k/hsFEOEu
	vN1pIYrp++6gtfOy5ol7X4KB8W1c22eIVEujkld4ziGJAaKO3YzRW1w/cnx6Jvzyc+QCD1/1tUp
	IV+6JSv+bemeS57P4oMOspksZ5/ZDJ/COkMMbymlHdGz3lKd/H5nMU1hUs+9+9bUaf3sr9PyvQv
	dpd5VDC9r1Ksx9uuDledg9aI0jXxbeRk8SPTgMHmBrgyHPBkywE1h/pYTggZKkMxiladqjHppfd
	S8Vzh2OCt/FMp8dS8F6nIN3Jnr85xwn5bpsg2A2ROTB6QcM2d99dRIerAVaVvhgBs+kCliug84X
	jfBaeqzTkpQ8QYxDtBMsrvVR8JUXfuyxoRIP3jHcV2myiZVnpzjAAGaN4NdYvgchl71nAyNKybj
	0t2c4Cjuo/P6jeTT2pA8ZpTRoBr7zXGmY4+6gMtKmiQJ+xx8m9Z5wiK1R4GaJX21pwxDnb2l1C
X-Google-Smtp-Source: AGHT+IGY8zetsgSIvFutufImFMthrxFxJXIM7MWBx6SuGYqQZd+pEnMc6jAj4Rx6sV/Kolyhj2PsDw==
X-Received: by 2002:a05:600c:b53:b0:45b:6b57:5308 with SMTP id 5b1f17b1804b1-45f211ccea1mr1468035e9.7.1757609887140;
        Thu, 11 Sep 2025 09:58:07 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4f:5300:1cfa:4708:5a23:4727? (p200300ea8f4f53001cfa47085a234727.dip0.t-ipconnect.de. [2003:ea:8f4f:5300:1cfa:4708:5a23:4727])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e015313aesm19163175e9.1.2025.09.11.09.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 09:58:06 -0700 (PDT)
Message-ID: <233db109-6666-4696-9199-2da040974714@gmail.com>
Date: Thu, 11 Sep 2025 18:58:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: phylink: warn if deprecated array-style
 fixed-link binding is used
To: Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <964df2db-082b-4977-b4c9-fbdcfc902f9e@gmail.com>
 <bca6866a-4840-4da0-a735-1a394baadbd8@gmail.com>
 <51e11917-e9c7-4708-a80f-f369874d2ed3@kernel.org>
 <bb41943c-991a-46bc-a0de-e2f3f1295dc4@gmail.com>
 <815dcbff-ab08-4b92-acf4-6e28a230e1bf@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <815dcbff-ab08-4b92-acf4-6e28a230e1bf@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/2025 6:44 PM, Andrew Lunn wrote:
> On Thu, Sep 11, 2025 at 06:28:03PM +0200, Heiner Kallweit wrote:
>> On 9/11/2025 8:34 AM, Krzysztof Kozlowski wrote:
>>> On 09/09/2025 21:16, Heiner Kallweit wrote:
>>>> The array-style fixed-link binding has been marked deprecated for more
>>>> than 10 yrs, but still there's a number of users. Print a warning when
>>>> usage of the deprecated binding is detected.
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>>  drivers/net/phy/phylink.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
>>>> index c7f867b36..d3cb52717 100644
>>>> --- a/drivers/net/phy/phylink.c
>>>> +++ b/drivers/net/phy/phylink.c
>>>> @@ -700,6 +700,9 @@ static int phylink_parse_fixedlink(struct phylink *pl,
>>>>  			return -EINVAL;
>>>>  		}
>>>>  
>>>> +		phylink_warn(pl, "%s uses deprecated array-style fixed-link binding!",
>>>> +			     fwnode_get_name(fwnode));
>>> Similar comment as for patch #1 - this seems to be going to printk, so
>>> use proper % format for fwnodes (I think there is as well such).
>>>
>> At least here no format for fwnodes is mentioned.
>> https://www.kernel.org/doc/Documentation/printk-formats.txt
> 
> I could be reading it wrong, but:
> 
> https://elixir.bootlin.com/linux/v6.16.6/source/lib/vsprintf.c#L2432
> https://elixir.bootlin.com/linux/v6.16.6/source/lib/vsprintf.c#L2522
> 
Ah, good. fwnode support was added more than 5 yrs ago, so documentation
seems to be very outdated.

> 	Andrew

Heiner


