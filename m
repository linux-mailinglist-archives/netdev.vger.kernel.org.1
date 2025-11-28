Return-Path: <netdev+bounces-242520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB107C91421
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 379594E6B4D
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 08:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F32E7658;
	Fri, 28 Nov 2025 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="G75b3cx8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C9A2E717B
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319092; cv=none; b=s9WeGNflMl3/IAws8yEpsbzaTwtMgm2Xf/0rNNJoFnJ0kiJWqYdaxrVEeVivhqJEjciHVdpTnqCNzoO1PNf2GOwZytI84a8SmHpHXutcwY97mimgbogh+QwvAMcIOzTQx9vAdTgWJfzgT1ouJ9FoSkeatW6umDGrK5WI4VH0Cs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319092; c=relaxed/simple;
	bh=haJn/3UOjunIAU6P6BQCym51EG14zWyLcsUuaxNDf8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eovkuJf/R1V2eGnooaIEG81T9EC3sKvM/tcl7ka3GuxOPdZsfnAcBumaYm7elDevS4mwKcvq2pzY8n5hW9UX84WR22XiBdG7dg2uBgSows9IhCVGXDwzOhfuWQWgxpg5YMyRE4U8i/xQ4tcfz0Bo8dKpkVO6vQTaliCePYknZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=G75b3cx8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429c844066fso140073f8f.3
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 00:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1764319089; x=1764923889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=712AyLLLFB0b3oxGfBICwKxqOrRvtEZjrinsv8wp6uA=;
        b=G75b3cx8IHobzDD5Iq7QPWOnLEn+WJDbxgYC+D8YM13m0yTIP49Hp0JaX4wpJezSka
         T5/3MuB5/QnyKKWa5T/sTQBuqsbVDICb/BiFt79P29HnIRKAVIdIrIcgHmcFaYR5ozkg
         oxnECZrF/omalATbVlp3oj6RR1KOxKde6oG22aEjbLULoWzASWS3mNNA2vB3i3onT+Lb
         zWzDV/ikVDrBfpDLgSGRx5xURL0tku71Ozqvi0sk9qhBrFEMyxEtJdKTNtw8hSwRZYmt
         FeCDneVEOQcI+aKOC/2mt9+9eRGLhGuXmiUTu32bDeoYcYq7gVQ0nByzBvHHhrucCZhI
         fBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764319089; x=1764923889;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=712AyLLLFB0b3oxGfBICwKxqOrRvtEZjrinsv8wp6uA=;
        b=Q8vU3NLkO8KQIAwE8iSFA8CbD6KS8bvcjjwFZZnB/jOkylCuMkYMW/610gMbxhdNH2
         67pTECfl6RHFTos1+hXtvJTVb2w2SsN6IRDs6HD+z4e+KxJ9dHCjpckwURS7r4gI7/j1
         PQQmz6PRs2O1UAC6aTxuoxFth+eYejQJx9GJ9gzmo4To6+d3tGY1wrYAp9RtSTpIxOs+
         /5Dz5D37uvKPrYC0NW9BT3s+sI2TF2fNKQH1ZXhpgPbFh69x+bDUlMErN4rbF0koT4Ex
         s+ekJTpemUbjQIuF9krku6X/uTQ/t5Bbf2wkmndDludOtyEH4VbInmut6WLFooVwmEeS
         2Iyg==
X-Forwarded-Encrypted: i=1; AJvYcCVGojZCDhuxBLm70DDiL7tOvbBYxqQeBcszcMbSNTTc6DfEo52fItJyLf8Pz6UU1eCmLW+ddhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza29PwXxW1I8sil8bTYdAWlt419BUI38J2fUvUQu8/r4qdyMyN
	M1oiUS4Srjps2NQlhKjXFNzyYi4MExVSltCTOCxkMLGqYJfITJwr9TFk4eoWxaRr0Z0=
X-Gm-Gg: ASbGncvNzYo1KhvjElh7R1c7E3ZgB3xOB5y/pVnOCMNE/uAGNXTA3mNIYy9rQEKf5ng
	/mbmRW4EvgtIziZNK0Ka3eA50qwMG8prAKA+OYWs5tkdyjs3+eNQ6zFpY+Taumw/bCZvkMVSQki
	BCKjO59TyyMRbEbGg/K1cn5RK6Zje8+TGW3XthA39ztgMnWXjsugTm8M4Cl7USMAar2KFf5H6p3
	/dh+QxZtJal1Ny3KFWqL8gHpvBYOzRxrFMydNKI8A4BE6jF1Wu1gycLmUybZUIwG4Fz+oxuY9xA
	yga2ZD4rvNVsGJXE7LtGjsXTguMsYlkstJTXsK8YAf43tlgMgtbFf0wOpRzbyTomaub5GCt4BE6
	34496XIXtdNkfQj0J2MfH7nZzO1FFStkYOhtp7LA8dUEPbslMxZKsVD5bcyGCD4y2CQLV6e5Zwc
	6Oqv46Iok58UI7vfGQXFfDo/RPPYVpt0KoSW3uUN4jkXEf5XAg86XWzQ6JZ82MydA=
X-Google-Smtp-Source: AGHT+IHIwe5aOZs6Nk4J/OFcq9T/e8G0iERVqqbqg2l9vqDQsMWiyEtgawO7E/I0iade+U4xJkVakw==
X-Received: by 2002:a05:6000:240c:b0:429:bde0:1da8 with SMTP id ffacd0b85a97d-42cc3fdf636mr15176816f8f.7.1764319088767;
        Fri, 28 Nov 2025 00:38:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a310sm8386127f8f.26.2025.11.28.00.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 00:38:07 -0800 (PST)
Message-ID: <1d44e105-77bd-42e7-81f5-6e235fd12554@6wind.com>
Date: Fri, 28 Nov 2025 09:38:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2] net/ipv6: allow device-only routes via the multipath
 API
To: azey <me@azey.net>
Cc: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
 <20251124190044.22959874@kernel.org>
 <19ac14b0748.af1e2f2513010.3648864297965639099@azey.net>
 <85a27a0d-de08-413d-af07-0eb3a3732602@6wind.com>
 <19ac5a2ee05.c5da832c80393.3479213523717146821@azey.net>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <19ac5a2ee05.c5da832c80393.3479213523717146821@azey.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 27/11/2025 à 15:06, azey a écrit :
> On 2025-11-27 08:58:59 +0100  Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
>> I still think that there could be regressions because this commit changes the
>> default behavior.
> 
> I don't think it should - my reasoning is that any routes created via
> ip6_route_multipath_add() would always pass rt6_qualify_for_ecmp()
> before this patch anyway:
> - RAs get added as single routes via ip6_route_add(), so RTF_ADDRCONF
>   wouldn't be set
> - f6i->nh wouldn't be set, since:
>   - ip6_route_info_create_nh() only sets nh if cfg->fc_nh_id is set,
>     otherwise sets fib6_nh
>   - rtm_to_fib6_config() prevents RTA_NH_ID and RTA_MULTIPATH from being
>     set at the same time, and only sets fc_nh_id if RTA_NH_ID is set
> - f6i->fib6_nh->fib_nh_gw_family would always be set, as dev-only routes
>   were stopped by the check in rtm_to_fib6_multipath_config()
> 
> Did I get anything wrong? I should've probably included this in the commit
> message, sorry.
With IPv6, unlike IPv4, the ECMP next hops can be added one by one. Your commit
doesn't allow this:

$ ip -6 route add 2002::/64 via fd00:125::2 dev ntfp2
$ ip -6 route append 2002::/64 dev ntfp3
$ ip -6 route
2002::/64 via fd00:125::2 dev ntfp2 metric 1024 pref medium
2002::/64 dev ntfp3 metric 1024 pref medium
...
$ ip -6 route append 2002::/64 via fd00:175::2 dev ntfp3
$ ip -6 route
2002::/64 metric 1024 pref medium
        nexthop via fd00:125::2 dev ntfp2 weight 1
        nexthop via fd00:175::2 dev ntfp3 weight 1

Note that the previous route via ntfp3 has been removed.

