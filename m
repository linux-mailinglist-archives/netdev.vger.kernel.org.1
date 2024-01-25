Return-Path: <netdev+bounces-65923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF7B83C74A
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 16:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE893B2500A
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 15:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20537318F;
	Thu, 25 Jan 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtKQmkDG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376097318D
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197860; cv=none; b=RFqjdTUInskALLpPS1IA1Cb7ENTcbvw7v1c+uro2rsnx5EAuIHT4kTyd5rnZv6+F9d7+QpthQM19tk7I5Cp5l1PWMWJW7VCL9Uas6dC8QhKjnU+Yr9K7nER7Xspf3VHlmMC++ulg77pmlK/OYWWP59w5+frDkX9k4zUw/cxr3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197860; c=relaxed/simple;
	bh=4RxHy7YSci2h26nxzbNWXiDXHBNn30DIyoOjMx/uroU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qe89pVhzfu3fX3r0uNexsDF9T7Kpgtgig2nvLoRtT+EznC/mTpc4drESN4crl7LQY9u7U3J47jj1LhQaykLy/4s9caOr8YxyGDBGqYUP5JzkoSSKq04YhBMUgGCRcB+i6+MABg6wFAqp91wrge/bOLdn896lQFv8KQAUjLiSSDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtKQmkDG; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3627d08a4daso15833555ab.1
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 07:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706197858; x=1706802658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6Z/bz7j7CSWFMbs7+UxST9YRUHhGkrU6jBkq0mO0wg=;
        b=AtKQmkDGEhnhmwkq6cE11dVzUgmOuk7oXiVAK+qe5eqgH93NLapBtwoTqehWuWHrJo
         AhWWquB1HB5DdqksvK5fe+l2cxo+hD8tRL14v9qzGtmJ22zMiHonDkR2DDP1SzdqjavL
         Nb1bm4ZAkvQChCop4u4FMdtvVmwflxSf+Nq3CYaNHFghcngYOqKNZeXHDPiO4Ccnz50y
         9m+IvZnH42fZbV6MgMcjQdUjQUK4P1TW3psRbrN2PxmvFUOnYA6cv+XDaWcVf58mRW4E
         rYIqYJIkx2bBqURfXLaAlurIt0xAH4e5B4o2e1YEmjWTqki32W9jx4TnrQKZrfJRlro7
         pf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706197858; x=1706802658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6Z/bz7j7CSWFMbs7+UxST9YRUHhGkrU6jBkq0mO0wg=;
        b=RgKYeTA+Pa77emTB/7TtZgL56ZwikKYQpVPe5AC0zszn0ITGqCTS3mwSCDjE8WSHEM
         wsIETurdz6UPk+9ZYa0t4VIs/NuP0up9MD8o1i8BxbX7zJAz/bLPcobysHyzoGVHixbG
         C+MNQlzFTKqKKu6jpDVBvrASxBisW0ExFBkVqe4alwL70kxBrf9HCMqStXT2P/fQvr98
         tyEDF/lKJnFZMn+SV6pmXQBM7ISf6V99qTeSaFizqYfX+fiTfnrnt9/WpIPtp9CCqAmY
         cZy/tT+eBuJqf3dZ00cVPp2OUEqggg5Wr/VnVWg7tVBiDrXkMRFwJ76ita5WTLsNpH6Q
         kH2g==
X-Gm-Message-State: AOJu0YzxArwfxcATESnUKddTNe9pgsUw5vMsBivW+yP8pxAyDimdCZ/K
	RmzCSpjouLNSUsmeoDWPHYRCyFTfDS5Ypddb53qIikFrhmzXDKJ1wxm8uy7I
X-Google-Smtp-Source: AGHT+IGt8IHOcXh6dsfWbc6eZgxkot4QjFDgsmoldt61OLzTk3WrHhdv+9A2DzaCABcIFlYVPDFTPw==
X-Received: by 2002:a05:6e02:1066:b0:361:aa6d:f84e with SMTP id q6-20020a056e02106600b00361aa6df84emr1244554ilj.2.1706197858383;
        Thu, 25 Jan 2024 07:50:58 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:ddd8:edb3:1925:c8bf? ([2601:282:1e82:2350:ddd8:edb3:1925:c8bf])
        by smtp.googlemail.com with ESMTPSA id o7-20020a92dac7000000b00362a24b0f47sm470511ilq.61.2024.01.25.07.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 07:50:58 -0800 (PST)
Message-ID: <1e2ff78d-d130-46d4-b7ad-31a0f6796e1a@gmail.com>
Date: Thu, 25 Jan 2024 08:50:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] vxlan: add support for flowlab inherit
Content-Language: en-US
To: Vincent Bernat <vincent@bernat.ch>, Ido Schimmel <idosch@idosch.org>,
 Alce Lafranque <alce@lafranque.net>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org
References: <20240120124418.26117-1-alce@lafranque.net>
 <Za5eizfgzl5mwt50@shredder> <f24380fc-a346-4c81-ae78-e0828d40836e@gmail.com>
 <1793b6c1-9dba-4794-ae0d-5eda4f6db663@bernat.ch>
 <1fb36101-5a3c-4c81-8271-4002768fa0bd@gmail.com>
 <41582fa0-1330-42c5-b4eb-44f70713e77e@bernat.ch>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <41582fa0-1330-42c5-b4eb-44f70713e77e@bernat.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 3:00 PM, Vincent Bernat wrote:
> On 2024-01-23 17:19, David Ahern wrote:
> 
>>>>> My personal
>>>>> preference would be to add a new keyword for the new attribute:
>>>>>
>>>>> # ip link set dev vx0 type vxlan flowlabel_policy inherit
>>>>> # ip link set dev vx0 type vxlan flowlabel_policy fixed flowlabel 10
>>>>>
>>>>> But let's see what David thinks.
>>>>>
>>>>
>>>> A new keyword for the new attribute seems like the most robust.
>>>>
>>>> That said, inherit is already used in several ip commands for dscp, ttl
>>>> and flowlabel for example; I do not see a separate keyword - e.g.,
>>>> ip6tunnel.c.
>>>
>>> The implementation for flowlabel was modeled along ttl. We did diverge
>>> for kernel, we can diverge for iproute2 as well. However, I am unsure if
>>> you say we should go for option A (new attribute) or option B (do like
>>> for dscp/ttl).
>>
>> A divergent kernel API does not mean the command line for iproute2 needs
>> to be divergent. Consistent syntax across ip commands is best from a
>> user perspective. What are the downsides to making 'inherit' for
>> flowlabel work for vxlan like it does for ip6tunnel, ip6tnl and gre6?
>> Presumably inherit is relevant for geneve? (We really need to stop
>> making these tweaks on a single protocol basis.)
> 
> Currently, the patch implements "inherit" without a new keyword, like
> this is done for the other protocols. I don't really see a downside,
> except the kernel could one day implement a policy that may be difficult
> to express this way (inherit-during-the-day-fixed-during-the-night).

Wouldn't other uses of inherit be subject to the same kind of problem?
ie., my primary point is for consistency in behavior across commands.

