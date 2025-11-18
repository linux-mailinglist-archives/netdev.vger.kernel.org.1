Return-Path: <netdev+bounces-239444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EB6C686D3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 763C43420AB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043A2FB0B1;
	Tue, 18 Nov 2025 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="HbPg9acu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B781207A3A
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456760; cv=none; b=pXAjWyzFXc4jqr+j2u4KPtRC1JLPi4M6mEPrFUy/f0yJlrJrnvxUO9WJgkyKzv1tj9Yh1gluDyUrs43CmfQiFznESg9VK6+AaNKFDX/GDgSY5b8MuYY6WeSFBskGWNDVy5J2PtsABk5q/eE1iIYnzhtAZX26Va2CxF6M58EmfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456760; c=relaxed/simple;
	bh=l5hU9L5Yj7VZJj97kMh6UZz+7GJNWFi2weoykB0U5Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dCnkHa9JVM52AgQFmxIUPkd25eKtLJJTMrva6oFo5BylnCCaqr+ckgJsRl5CyWffUtGNwXWhKFD7oIT0ut67K742y94XHSlQGrQN9cu50MmobD+2iITDHae7hNisgAxUvleXWBXITrVjzSGaGXqW46IyFxCPO0f1HSjgBwNSq2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=HbPg9acu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779fd615a3so1624595e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 01:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1763456757; x=1764061557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Vv8b30UPdNYBhUDR5IJHjoXKKpsIjJNO+tgtc+hFsc=;
        b=HbPg9acuGWFCf6hatvVN0fq8aR/3tMekJ8vSeK+n2YzTB0NneGOiAyRYwKifSpFBjN
         VD0K3rwfBp6I9wOypDhiKaVcu3RoWxAq+NroIBD45zsoOoZSWMVpC3Um9lxRlbLuMVvR
         go1gaStJrgHCe/b55OpVSZKya6+BQR6CMNwGvSGeIinJgW5084tBi4ZNZfRSqaPBn/8l
         FFfWsrN4suEvSZnAghR7otQcOkVRc2MIKomWgl09zmeO9+DrrJAITprh4XECo87c5Lfn
         KAMw0MeUpaxkv5X0N8cDEgcRrw6BEnxVf60G3UbitVUpFQO4sk82Ul3GyMFneq5jboFH
         meCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763456757; x=1764061557;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Vv8b30UPdNYBhUDR5IJHjoXKKpsIjJNO+tgtc+hFsc=;
        b=VEHHdtZuBvXHwnzj2S96hikCWHpRDIfMyyCB49ft4dDkltDcVxpH8rPVIupiAL7nbD
         SrVsckXJ64dBMJ5Z4tCEv5bv9Um7wyK/WXaAoVCM4Cvq4YTCTRx0ptVEKWoq5NH/dKfK
         RDiaYtVNtOIiNKAFhrkuLJy18gCgmT3to0IhAa9XZj1YFED2HO/VdhrjgHeZymp/jMGK
         1mw+C07nx3kG4aOnarp+eLdFhEiu6lJUOLXMY87mEeOiS00m/9TQ4kXgsOYXuq0T99cZ
         aM7kjhr/0/nmMx5W1YX8iYJOKVvN1bJUQ7qh9yCbUg4P8GFXM3Ot1zciwPD7ywnA34TZ
         JNBA==
X-Forwarded-Encrypted: i=1; AJvYcCVorb5i91ePGa/16rPC3guWX6WQ7utdXwHu//Lr++0W8tv4gWuOQVWec6wOhZmRk0u88S5yqjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrBKhVrE+UsnKseas3FnmXJXY6YZD8pPPByADKoLCHAIdBh24E
	nhJagpZHRmP37HWx5DU5aBLvlX90B9sG8WdDu1xQAod9nED3QmQ9b1HsTRd0Pd1bOEQ=
X-Gm-Gg: ASbGnctTcpeYffCtIwJIf5to9GqWl8UmMCsVyuYe/NiXvlasaTHMRIXvAcLYzDyVQKe
	vwSf5FWcZIPC0lp/fLldOAkxs3RDV9jPYNEMAXiMVSzWMY7bJPvga9JS6HvPViQvf6byeTQXKTb
	B6hzdjdOPIAi+bs2j2EWzSuRrXtJ4+HX+WHIfsxDwWvjDQncUhkkMw3Z8HPxUQa1EAC93FqoMuD
	y/asqg3Dkq5rxTqWCCHA1qRrYuPOjcjpHCdfKTC+7mT+zIyryOHeYXiGy/bOZK3VEkkwMrkZXm3
	WAHT9aaEP71BZ/vNoZPe/PGH7mqXGRajBwrjxbWzjcN3/5sYZnGPT0am3ZNw2s4Tf+0rRwDp0q9
	Umm2OG0wH9HLS93KW61BbbivIX6K+cHzP3qLPISHDpe481fkJjwVKDfQtniE5vvvE+6vkxGFBL3
	PnwNyn9YE88+cGjOAX164BXbj8QEhKx4AtdvMlCo0OodGW3Do4t+/kRKK/PO8Rdz8=
X-Google-Smtp-Source: AGHT+IE+bZDiXeOa0QOmpZlV9zGUl0nc6P6rVY9AZ9mOcMwPfj9WJ7rj7K8GQtY6HIyEMxOUWFMBcQ==
X-Received: by 2002:a05:600c:19cd:b0:46e:43f0:6181 with SMTP id 5b1f17b1804b1-4778feb5ae7mr80092035e9.7.1763456756632;
        Tue, 18 Nov 2025 01:05:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a97412e3sm12877915e9.5.2025.11.18.01.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 01:05:56 -0800 (PST)
Message-ID: <a4be64fb-d30e-43e3-b326-71efa7817683@6wind.com>
Date: Tue, 18 Nov 2025 10:05:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] net/ipv6: allow device-only routes via the multipath API
To: David Ahern <dsahern@kernel.org>, azey <me@azey.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <a6vmtv3ylu224fnj5awi6xrgnjoib5r2jm3kny672hemsk5ifi@ychcxqnmy5us>
 <7a4ebf5d-1815-44b6-bf77-bc7b32f39984@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <7a4ebf5d-1815-44b6-bf77-bc7b32f39984@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 17/11/2025 à 02:57, David Ahern a écrit :
> On 11/16/25 11:31 AM, azey wrote:
>> At some point after b5d2d75e079a ("net/ipv6: Do not allow device only
>> routes via the multipath API"), the IPv6 stack was updated such that
>> device-only multipath routes can be installed and work correctly, but
>> still weren't allowed in the code.
>>
>> This change removes the has_gateway check from rtm_to_fib6_multipath_config()
>> and the fib_nh_gw_family check from rt6_qualify_for_ecmp(), allowing
>> device-only multipath routes to be installed again.
>>
> 
> My recollection is that device only legs of an ECMP route is only valid
> with the separate nexthop code. Added Nicholas (author of the original
> IPv4 multipath code) to keep me honest.
If I remember well, it was to avoid merging connected routes to ECMP routes.
For example, fe80:: but also if two interfaces have an address in the same
prefix. With the current code, the last route will always be used. With this
patch, packets will be distributed across the two interfaces, right?
If yes, it may cause regression on some setups.

Regards,
Nicolas

