Return-Path: <netdev+bounces-179384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FDAA7C4B6
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 22:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5AB7A4841
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 20:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26DE21507F;
	Fri,  4 Apr 2025 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsLBkQ73"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8C20ADC9;
	Fri,  4 Apr 2025 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743797513; cv=none; b=NfZOFV/oHXCdrPVSIc2VT0NMlwAmhjj8wELZJJJuaNhWCKlAbrlSOPR4nhR5hj1CjfGGqNDoJd09UYtw3+7Lk32+ihWD1/OyNr+vn1OXg9vCvL3YSnIalB4EYDchVeJYfpDwqPkWUm4oi1CnUz3lUHzLepvp0LqtWqdRb974clY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743797513; c=relaxed/simple;
	bh=xo+k1XqCAFwqSiZtxzM/KgtkdyDu6qBF00YwywXhJwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0joO1Y2B1uNO8LH6Kn3OFTqmaDGRZNAXq6MabeZ6r/ntuKwjQQkL6Lq+AUGOiUVKD+6ggQXHWVjDpOnDGBtwgbTku/8gHpPu7N5sZWvzfnwVTA4QG10dYYRCRCzBX3heOpRzBfcTycoZZaqrP9fXs7BR5rpCUjdNTpD857Pd0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsLBkQ73; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6ef60e500d7so21383877b3.0;
        Fri, 04 Apr 2025 13:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743797511; x=1744402311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSA5uRsE0C5NOHjWvbYKWt80GNLBtJr0B40wF/Z6HSU=;
        b=bsLBkQ73OUb1MCQ1IIAzJJU/Pyzs3Q5lauOKYmhK/U8+B9GU3NkyDNYiH8NvZjgmDk
         nTsJCKE9tC2X5GXo/SLzZSYdo4fWbRdrjgxGqTKh8ZoeiUacAS6qUnSzwqHBVIX8Gn8v
         KSBFYRqTiqhUK14x3M0OGCzdaCS0b5xophbo+Fih3pUmY4144QBVM1v4KtfzERpvpyLz
         Bq6Obuwzi0yN5ThE800ZW524sooelM1uqP3FeRhCVKAY2H/Go66stdPofp1NTRTWvypQ
         BjjZ0Zzhh7IXPWkd6gsMykbKQauLix/sdFbH/K1LS+4rMGiAr0O4wgGuqhYsHxlSICyq
         HY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743797511; x=1744402311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSA5uRsE0C5NOHjWvbYKWt80GNLBtJr0B40wF/Z6HSU=;
        b=DEMGMM/8KlAXUA5CpHq3IE5SwmNwfBVdnjh69bsrY9IU57Q8NvAXHWHA93OXAwoW/U
         cVC0M3VqYx+H33KfUJW59kwMrijWqXty7Y6Hzdd200Zul5WXboEHN5LU7Bc/zZyXL3gR
         r5FUI00grePvKuJmCjicMkak60xRXCSzzoE6qOy7W2l6V0y8Os0mFAgObwG4TmvgZzQq
         78fTP4rkxJ2ZQTJ8ko/ID9tzOaajiF/wdKsn+Xx1SHuTqoQqo8UghGIqXIXFSq9XS4FC
         MWJIEFekUiEDDMWEMZQYLaH8TnT2x34zkQ+dz7Z1jVQJLNKPBmmAzeVeGND+HQSeJTeI
         PU4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnw1zCv5P07aRr8drkpu/ZMHZ/qU3xbYvX9ETYZFLqDKcZRdQBS6cbie0l1pPTxk3poGl1PjO4@vger.kernel.org, AJvYcCXuShIPvrA0S5Qpe6walVoQTNZGhYyS1QBdvsOMrT+jwVwaoDpy9YrbOVFmIAA8oq1bE4VgprWkVr6VdAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbouFXailFOimKzJKVYUU604p5zFVNxK76AVGTganXRgElCt5d
	IoKLl9gKUaXJeas10+k3jjZw8FvSezz6nGK/xKQe9zQ9YcguKpWD
X-Gm-Gg: ASbGnctL9TcmIVNQb2fmq8dTEJngsbKBgPMx1ZgokK1sbBeSCpopMI1ueX1C9Yz4Fn6
	URdboDzjCiRpi64Ykk3uC++W17v08vFPLuxiemIDwfc/ytx1qRPtIAvvIH3aZDFcy4VUXLfWlmM
	BYM48CqBkX0IrKaO6l+UEqhwulRwk3upD05st5h4ARHiGbr5xyouq2Klx/fTs3K4DHwa/rneU3/
	XZaL8VTBnle5As+1j2upjlAZ2yis+rPW5S520AdGDdKwbXqcaF0IkQMRFrImFxOnCWfsx0gvB6/
	o2zP3OdXbZaaRIT3/1MljzFpiPzvX0XM6XcAq9HPwen46ketPn2HAyXoMzIedPWwBYs=
X-Google-Smtp-Source: AGHT+IFvu+fFNrQn76ol4gsVEODHZphUpWaMek5ObX18b+ke75B35G87/TomGwuHzuRE8BuuBtBPuA==
X-Received: by 2002:a05:690c:18:b0:703:afd6:42b0 with SMTP id 00721157ae682-703f3fa8362mr11933207b3.0.1743797511009;
        Fri, 04 Apr 2025 13:11:51 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1e2ed05sm10597317b3.18.2025.04.04.13.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 13:11:50 -0700 (PDT)
Message-ID: <9e7f6c4c-cabe-46e9-b59f-6638b4ae25e3@gmail.com>
Date: Fri, 4 Apr 2025 16:11:50 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 net-next 3/3] net: bridge: mcast: Notify on mdb offload
 failure
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250403234412.1531714-1-Joseph.Huang@garmin.com>
 <20250403234412.1531714-4-Joseph.Huang@garmin.com>
 <36c7286d-b410-4695-b069-f79605feade4@blackwall.org>
 <917d4124-c389-4623-836d-357150b45240@gmail.com>
 <abb9e2c1-c4b5-4ffa-b2e3-8b204da5efca@blackwall.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <abb9e2c1-c4b5-4ffa-b2e3-8b204da5efca@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/4/2025 4:04 PM, Nikolay Aleksandrov wrote:
> On 4/4/25 18:25, Joseph Huang wrote:
>> On 4/4/2025 6:29 AM, Nikolay Aleksandrov wrote:
>>> On 4/4/25 02:44, Joseph Huang wrote:
>>>> Notify user space on mdb offload failure if mdb_offload_fail_notification
>>>> is set.
>>>>
>>>> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
>>>> ---
>>>>    net/bridge/br_mdb.c       | 26 +++++++++++++++++++++-----
>>>>    net/bridge/br_private.h   |  9 +++++++++
>>>>    net/bridge/br_switchdev.c |  4 ++++
>>>>    3 files changed, 34 insertions(+), 5 deletions(-)
>>>>
>>>
>>> The patch looks good, but one question - it seems we'll mark mdb entries with
>>> "offload failed" when we get -EOPNOTSUPP as an error as well. Is that intended?
>>>
>>> That is, if the option is enabled and we have mixed bridge ports, we'll mark mdbs
>>> to the non-switch ports as offload failed, but it is not due to a switch offload
>>> error.
>>
>> Good catch. No, that was not intended.
>>
>> What if we short-circuit and just return like you'd suggested initially if err == -EOPNOTSUPP?
>>
>>>> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
>>>> index 40f0b16e4df8..9b5005d0742a 100644
>>>> --- a/net/bridge/br_switchdev.c
>>>> +++ b/net/bridge/br_switchdev.c
>>>> @@ -504,6 +504,7 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>>>        struct net_bridge_mdb_entry *mp;
>>>>        struct net_bridge_port *port = data->port;
>>>>        struct net_bridge *br = port->br;
>>>> +    u8 old_flags;
>>>>    
>>
>> +    if (err == -EOPNOTSUPP)
>> +        goto notsupp;
>>
>>>>        spin_lock_bh(&br->multicast_lock);
>>>>        mp = br_mdb_ip_get(br, &data->ip);
>>>> @@ -514,7 +515,10 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>>>            if (p->key.port != port)
>>>>                continue;
>>>>    +        old_flags = p->flags;
>>>>            br_multicast_set_pg_offload_flags(p, !err);
>>>> +        if (br_mdb_should_notify(br, old_flags ^ p->flags))
>>>> +            br_mdb_flag_change_notify(br->dev, mp, p);
>>>>        }
>>>>    out:
>>>>        spin_unlock_bh(&br->multicast_lock);
>>>
>>
>> + notsupp:
>>      kfree(priv);
> 
> Looks good to me. Thanks!

Thanks for the review!

And a logistic question. Now that part 1 and part 2 are ack'd (thanks 
again for the review), when I send out v3, should I resend those 
(unmodified part 1 and part 2) with my v3 patch series, or should I 
break this one off and only send part 3 v3 as a separate patch?

Thanks,
Joseph

