Return-Path: <netdev+bounces-179385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800CEA7C4D1
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 22:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F55E16A094
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 20:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1183321C176;
	Fri,  4 Apr 2025 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="XPesGFd1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C28220E6E0
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743797725; cv=none; b=lYEhXuz1fVFUBkYhiXetbGXUYC2WufozwcTU9tlZAQ4W0KTKPJgS7LkZmUEirgSKtHaplqrvMbivf6bym6ZYSM1hmbtVKNJXZgUIupaX51SQu8fd7kh/M6/N/OsNBs8Kg9Od3ka4GQuLGmiQxIYN6/sYBdsy65WOK6OHBCxchBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743797725; c=relaxed/simple;
	bh=FNMLVPOYURQjDIbEqTZeHZjf8H6jXyblhUfeS+qvi4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SrHpi63Snh0PIfOjdmKxEfnm9i/veo716AZetn6xDHAHEEYhvCyzDAccblhjAW8G1xaogWjObQJxhA6IRLB0ydRVWG+Kjav7VtLpfSgl8FifMA4lAsa5yyUi60QkiXj3rWszm6TWPJ7AyK89E3Hk6+cTFJh4xKc/GRRYIf0LNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=XPesGFd1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so19106705e9.2
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743797721; x=1744402521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDPtzrDQm7D2KJ6r1jIrDZFX1ist1md5kdhYkAXF22A=;
        b=XPesGFd11XG/G9/8I0Orw8ceBOcaqCOKXfhjKp66c+6JCzZPMreK5fAa4hhTvTwBCX
         w8jo1RyhEPAePdo/VnMyruwPcFOtSUHnyfjpPqqvbSCi/0EvzUNkU7uXNa8g7NVJyAZr
         YNvJtZpWZjNXmdzLM7OON1iMX3DYcIPDJdguFOzABYweqQ4sGoKVdQUzs01Iy+wGxN76
         a9aQdvuNA2kgbJiv0OO0nJW2TmobnWwi+yLSKhOVSC/OGBXCuX9Y2/G1tNdZxeybbWzu
         5dy+l9eSNMq8I1rzFM/I8RnQqjT/uvZECeAwwCYhCbLqiSXl4maB3G4o6dKN1JCNDAje
         zc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743797721; x=1744402521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDPtzrDQm7D2KJ6r1jIrDZFX1ist1md5kdhYkAXF22A=;
        b=lnAWE+rwykD9lOUzc2N7w7Nzb/Mg4xwnYy0p2A9VR3GnwnoBXEvJRJV7+XHGXGKZVZ
         bc51oa/eOrizrPNnGrnvLLiwF9m/oErQkANcyUGkcdOAuu2etejE/PEVqkwn3EzQBZ+T
         oEpOzGj55BzgSpp0KHdiKI88mbp5/KF8ckAE0iwgGaa6jYWg/ZrbdddDdttZnSCCwkMI
         LRo4cABuVxpEhDkWnc9LXXBerr+j9IE+Z+21CAfqWhoOp7bfkq5g8XuTI/NuPE/jJGoR
         o4vCuGOr5W64ceFRAhezD0qcF4pPUwSpgrTboLXF8huiFfMxhCbX29DqAsAg+GAWNB7K
         4OdA==
X-Forwarded-Encrypted: i=1; AJvYcCX7uT6zejUGCe2BotKIUwwxquoXtLBwsHhv/zOdeV7IdZetRIYJtrOaaZ1DwZUbXPK1rk2vcRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC7WonnE0OyRGXpR9sI1nEa8sPBUwpwcwD1PW79PzJSD60MWdE
	kKM7OOy3/orItrJ3mDuGC2sV4bCkOL9brb5YpBRiB/aymYiMf/Pqb/yralW+vFE=
X-Gm-Gg: ASbGncuE4cz+59Gcw2T7AmoSr/vgyqlA+2tBtihXkvt+pk+u8YheBQ/fUjMY9ZBQvZ4
	bJqRjrxIXjljByOZVK/FBsNx7yuZpHfZuEhn6vAZOHMed4enpjuX4w1k23IzikKR54r/aa2aYmW
	7wHHXxNmCStqnvqaNXDwrRpXKeEgmll/S42edHQuQNGnNGbSWiQwGPETihBtxc5EKifHf7w9m81
	XDP6uQpIAjaQ4A30e/oaQ7UPM3cYmjvwbWMTvuFJiHb3+k/G4hvKGf/t05YQOMovPbdNNOteLT6
	t8GJF+nL+kYt9SchfZ+LuVK2C6QUYebsg+FgJTDcx9BnvoaFaEx6Nvj5BpgO4OfZBJt7+cH0Qef
	9
X-Google-Smtp-Source: AGHT+IGVOzLfgvsBZseM5TV3JdkQLxAe0MfgoooeouE9pQaId+9aWIcjjMv6iTb0EZIAoYH8aCKyuQ==
X-Received: by 2002:a05:6000:4305:b0:391:4914:3c6a with SMTP id ffacd0b85a97d-39d0de27eeamr3277151f8f.29.1743797720808;
        Fri, 04 Apr 2025 13:15:20 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7064sm5279408f8f.34.2025.04.04.13.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 13:15:20 -0700 (PDT)
Message-ID: <96bda215-bee1-4ff7-9d88-b97922ca7b1a@blackwall.org>
Date: Fri, 4 Apr 2025 23:15:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 net-next 3/3] net: bridge: mcast: Notify on mdb offload
 failure
To: Joseph Huang <joseph.huang.2024@gmail.com>,
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
 <9e7f6c4c-cabe-46e9-b59f-6638b4ae25e3@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <9e7f6c4c-cabe-46e9-b59f-6638b4ae25e3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/4/25 23:11, Joseph Huang wrote:
> On 4/4/2025 4:04 PM, Nikolay Aleksandrov wrote:
>> On 4/4/25 18:25, Joseph Huang wrote:
>>> On 4/4/2025 6:29 AM, Nikolay Aleksandrov wrote:
>>>> On 4/4/25 02:44, Joseph Huang wrote:
>>>>> Notify user space on mdb offload failure if mdb_offload_fail_notification
>>>>> is set.
>>>>>
>>>>> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
>>>>> ---
>>>>>    net/bridge/br_mdb.c       | 26 +++++++++++++++++++++-----
>>>>>    net/bridge/br_private.h   |  9 +++++++++
>>>>>    net/bridge/br_switchdev.c |  4 ++++
>>>>>    3 files changed, 34 insertions(+), 5 deletions(-)
>>>>>
>>>>
>>>> The patch looks good, but one question - it seems we'll mark mdb entries with
>>>> "offload failed" when we get -EOPNOTSUPP as an error as well. Is that intended?
>>>>
>>>> That is, if the option is enabled and we have mixed bridge ports, we'll mark mdbs
>>>> to the non-switch ports as offload failed, but it is not due to a switch offload
>>>> error.
>>>
>>> Good catch. No, that was not intended.
>>>
>>> What if we short-circuit and just return like you'd suggested initially if err == -EOPNOTSUPP?
>>>
>>>>> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
>>>>> index 40f0b16e4df8..9b5005d0742a 100644
>>>>> --- a/net/bridge/br_switchdev.c
>>>>> +++ b/net/bridge/br_switchdev.c
>>>>> @@ -504,6 +504,7 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>>>>        struct net_bridge_mdb_entry *mp;
>>>>>        struct net_bridge_port *port = data->port;
>>>>>        struct net_bridge *br = port->br;
>>>>> +    u8 old_flags;
>>>>>    
>>>
>>> +    if (err == -EOPNOTSUPP)
>>> +        goto notsupp;
>>>
>>>>>        spin_lock_bh(&br->multicast_lock);
>>>>>        mp = br_mdb_ip_get(br, &data->ip);
>>>>> @@ -514,7 +515,10 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>>>>            if (p->key.port != port)
>>>>>                continue;
>>>>>    +        old_flags = p->flags;
>>>>>            br_multicast_set_pg_offload_flags(p, !err);
>>>>> +        if (br_mdb_should_notify(br, old_flags ^ p->flags))
>>>>> +            br_mdb_flag_change_notify(br->dev, mp, p);
>>>>>        }
>>>>>    out:
>>>>>        spin_unlock_bh(&br->multicast_lock);
>>>>
>>>
>>> + notsupp:
>>>      kfree(priv);
>>
>> Looks good to me. Thanks!
> 
> Thanks for the review!
> 
> And a logistic question. Now that part 1 and part 2 are ack'd (thanks again for the review), when I send out v3, should I resend those (unmodified part 1 and part 2) with my v3 patch series, or should I break this one off and only send part 3 v3 as a separate patch?
> 
> Thanks,
> Joseph

You should send the whole set again as v3, but you should keep the acked-by tags in those patches.

Cheers,
 Nik


