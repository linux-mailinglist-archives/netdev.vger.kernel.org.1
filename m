Return-Path: <netdev+bounces-167240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85E9A39617
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 09:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356CA167AF2
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D297022E419;
	Tue, 18 Feb 2025 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="UAFcJyJn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9F922E40A
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868224; cv=none; b=Ug66rKbVGwvLPW9s4yzQijBl6ffIox45VzxLdlmksQt9bXJtRvaSYqXcWdBb/zxPI3sRKaRArOiavpbO1MO6buDv8CtPT95pmYRsI1oIormL9ekdk4b9DPcuNaZOZR/U+swEV33INUBvk8HE8uTAYkuc4ByTM7PIW3BHAwIZ1KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868224; c=relaxed/simple;
	bh=9H1gm5nERYEERWwiINCgkzxyRF5+Q6HYw6CVCLqtI1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wh4DPs5owsOa92nokZ55a0AnfU5JnEGNrTRwcAG4l1STgbYEFMTQtaq+W5LKIE6hHf3PpwX4bKc47F6sIKRHC01cqe3SOCDeXiCFyT+XapM/W2OyZ58W1aM1eJUsN2CF1mVcUP2aXOPtsQfpqjYei9XJQU00FSd8u0Vaski9CaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=UAFcJyJn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-439702d77f6so1995315e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 00:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1739868221; x=1740473021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=07OEdF7j7fGOpaK4PIAFdjn9U5fUFtm+0uA4oE0Ha88=;
        b=UAFcJyJnHolJxKIbWRSlkzODN5JYMpQ9z+bzpI90oR7iIeqzDCXqtEAZZbuUqXB8oe
         EcM7XZ0rdYMqYnqDjikDFU3LCj/joKn0iiAh0qVHJBK4ZP391F2Qo/ekhBA2E8v1UJp1
         KsUmu0QPJEU+wQfa2+wqvxlIU42NLYzIpkwkzujbbVFJJ7uVWUltTSW9wkE+EQxg0Gsz
         oSs3VbCheyh7InY5MMeaZ7PyeDNu/wF1UpZUfenTSjuAL7ddgjGHRyAXpgLWl2KsNc/m
         kz2EootgjyQBi244R5r2lbjvC5ozWDoJv5oTWKH6rxSf6agaQQ7XbSGN6dyv8H0lrfbx
         JbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868221; x=1740473021;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07OEdF7j7fGOpaK4PIAFdjn9U5fUFtm+0uA4oE0Ha88=;
        b=Ad6gFPgMzc9LuyMVn+eVp6qy/jbrJzCBfmQz7h65etFob9Zj2RCR7rSY6Pj64wZbPW
         ryGPwunaAUiDSBi5NYIPNNFClSgHrAR7iETqpbBeOpmJihr4a6pN2nqJ4fyRVPUzCl/g
         8ohdhDmrm3ZU9npPF/d7hGK6zvmn+ZvlTcjXKBIH6/IpTrctk+pVBT6td7BOJgtIbqNy
         SlfJT4flrb595VP8Nt9/oacpV5Mo0iUgJLK+x0svyIzEphgKyM3/P01prG5eRifyXHjr
         4THM9n2nTXY8mBzF/k3TINuuK8R1DiB5NGWteU7qmCpK4+b0mAEEXINKuoRv6MTF4PDS
         OYxw==
X-Gm-Message-State: AOJu0YwrpiO3Tp7WakgoBxaE9ch8+lfo1IUjImEMWK0osd7p2L1yVpO9
	JE6R/6FapUvwF5l1KZq0aXBHMNxV6opgCFKxXiHflRsxG5kBE4nNkbaHy40fp/oJ2+yZxmx3CM6
	Z
X-Gm-Gg: ASbGncsj2QDEnQEeuWIgzT9GIHrBtxfFwV3jjzAur5Zdfsugmknlh4awJQwdzcMhVIZ
	/yh8uwAbnFwHda+tpw0KKuLK+XwznUCC1lezeK/T/Gz4vaXzmfJv/+0TeZblYzNTgiKYw2TeL4j
	tAmuB7klO0TYL82WIZrZn9pjJHpkHcQYoHXIUU9LJBIhFbRNoyNef7L3emM8qLeSaTc2w9K1XoU
	H74R8Z9MDUcOw7u91cj5kiCx1B1dWRbP3u4vPwT8QchZnByEvDQUlZDh8vAo5UwmFmxw4LCS/1/
	kZpHZc/c9p7znoFApQdnNTe5JttXItZcD38LhB4v7L0KhTW2rhkXLkn67ZC8jLZ6Cdk5
X-Google-Smtp-Source: AGHT+IG603ij4o5hHa/WfJSqksRX5ZtCb3bIAsuiKI3S/5FgkptWZhf9avKNURVcVpcp0depLahbeQ==
X-Received: by 2002:a05:600c:1c84:b0:439:8c80:6aee with SMTP id 5b1f17b1804b1-4398c806c54mr14486605e9.4.1739868221188;
        Tue, 18 Feb 2025 00:43:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:8e5f:76fd:491b:501e? ([2a01:e0a:b41:c160:8e5f:76fd:491b:501e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43982a2f92esm56410535e9.17.2025.02.18.00.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:43:40 -0800 (PST)
Message-ID: <1e99ece5-3ee6-4446-886a-ddc708aa8e0d@6wind.com>
Date: Tue, 18 Feb 2025 09:43:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 2/2] ipv6: fix blackhole routes
To: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Paul Ripke <stix@google.com>,
 Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
References: <20250212164323.2183023-1-edumazet@google.com>
 <20250212164323.2183023-3-edumazet@google.com>
 <9f4ba585-7319-4fba-87e0-1993c5ae64d3@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <9f4ba585-7319-4fba-87e0-1993c5ae64d3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/02/2025 à 19:00, David Ahern a écrit :
> On 2/12/25 9:43 AM, Eric Dumazet wrote:
>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>> index 78362822b9070df138a0724dc76003b63026f9e2..335cdbfe621e2fc4a71badf4ff834870638d5e13 100644
>> --- a/net/ipv6/route.c
>> +++ b/net/ipv6/route.c
>> @@ -1048,7 +1048,7 @@ static const int fib6_prop[RTN_MAX + 1] = {
>>  	[RTN_BROADCAST]	= 0,
>>  	[RTN_ANYCAST]	= 0,
>>  	[RTN_MULTICAST]	= 0,
>> -	[RTN_BLACKHOLE]	= -EINVAL,
>> +	[RTN_BLACKHOLE]	= 0,
>>  	[RTN_UNREACHABLE] = -EHOSTUNREACH,
>>  	[RTN_PROHIBIT]	= -EACCES,
>>  	[RTN_THROW]	= -EAGAIN,
> 
> EINVAL goes back to ef2c7d7b59708 in 2012, so this is a change in user
> visible behavior. Also this will make ipv6 deviate from ipv4:
> 
>         [RTN_BLACKHOLE] = {
>                 .error  = -EINVAL,
>                 .scope  = RT_SCOPE_UNIVERSE,
>         },
Yes, if I remember well, to be consistent I mimicked what existed in IPv4. I
never found a good answer to why 'EINVAL' :)

Nicolas

