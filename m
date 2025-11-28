Return-Path: <netdev+bounces-242596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFBFC92747
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 16:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68B0934E832
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4AE283FF9;
	Fri, 28 Nov 2025 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="IaL41xY5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5701263F4E
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764343743; cv=none; b=EAt1Ex8XTi+PAHp8xsNtJYqqtUgdnW3nM5fLLjOC3ogeXkRnFbUHI7C5+Wu9l1P80i33m8E/7dmpV8EWn59BQUpC6C+CaJwOfe9pv0wRjAhvKTePSVbQnojyQ+kAmRFoeGmuT6aQn1snG3+IWZr3Gdn6MeKdAYDxGi/U5s+xUdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764343743; c=relaxed/simple;
	bh=tzK1e/crrIyk6HS0tE6PqlgLpCq6usNtvqsajFi6sMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAm3+YKKjGPbbLXQZtqPy2+p7M997fmjYiF6JHVyusGZzTzPUUVpyScyZRpieDIjPKxInBwPFRM8ptr0gg7LX4OPJ/NSPS62HMvzwawKANOhFBvZEanSZCC4SUZ46+tHUSiF7p5EmmzvymUgkRYc/jdfcUnaLVMVcpygDksBhVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=IaL41xY5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b305881a1so80903f8f.0
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 07:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1764343739; x=1764948539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NAPgXXchXQHPvwVorfhvAIFztiTEQO3A7lNYNmsblO4=;
        b=IaL41xY5dqvYgiyuYTzxtLYalJUswWvtfnLU/66NO2Yo4cGiq4+gqIpIH8aSx8cbUH
         s4KlP48dzdVCVWOpu0ZYm22MhwiVTzr7XEMzhLFx/EJpW2Ck6YH5/+hiVJU8jgdupYv2
         EaytZ337FnVgqtdyvoxKq3gzA9Lv/9VHUui5GUibyp0uvYGqBz92/qyDKaJCC8/rSC7g
         4cODCv9oh32yFWi0joloSwQGHcgZ+jeg2rPQkdfU54kPOYxAEWEBdpgXp9M0B2rzM2LD
         AgnNoQb7nJcN8gzvCmypRAtd3354vnM9BBxY7NEgnf3SEoK0TrVo3LXY6SmUv7ALVnGR
         ZIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764343739; x=1764948539;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAPgXXchXQHPvwVorfhvAIFztiTEQO3A7lNYNmsblO4=;
        b=dChWirJdDDsfx1y+zTgiH30qAQCMW8ozxlfXDjyWiPvOQV3Cu9IANMFQ2h2eIYbwXI
         V5AN9oZkGPcLz0CkLFQ/R4nVbN8zVC3QzO38VLjfnl2A89Xv99fwPdgCcdrQH8Cn2ETV
         vjUBhkO2doYDfZzOhQytBRnJY51ALjh4rdq+2mDqO1MmDtZWwIKpQ3Flvgl+M7679gdq
         6U3YD7+V2CQajWCOEoYe5RG2mIgkS20Ulr8NkZN87taxdLME4O74O/QdSave7gxZWPJa
         etsSAtR1e7xqKo5nq5vHB77n3ui34O8aLcl/hPvME3rkIDnC7B2drRPxoLkERSsKAI/g
         hvXw==
X-Forwarded-Encrypted: i=1; AJvYcCXlZpV9KjZZMCnmwcbeMVTf/MAO5wjlO/woCnfd5T9yZF24PSUQK7UTA4HknIbCcOV6fLmR4+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIjdiv0txTcQG/nXPHa51iUsBQrs3XaPFNsGKlfoz7/xFg00YZ
	uGoDNAgG3cQMtroj2/uwqPQGYH+YhTF9msLG3ZgXsDgvuHBLt7WPPF25BHAaIF5+nAA=
X-Gm-Gg: ASbGncvIwb0m/vSXi/WvjlnpAnIoa+qo2ggAordQPhQqadjmCGRrrfv4Ovf6eV9X68m
	bUzZvOKHHdy/cgqDGMjkL2d6wmBHlfEhtbxI3K6Mk4sMGgGnw+Y88Oppa0T4vt7Z/+qaKix2sj8
	2TCXirHgw+fCnpCeFNWh4UOAsuKLWXdbDOXnLk0y5vuF35WPuEihhvmtyWBrfHFOouUQelyM/+P
	S7GT90eUrZbpR/PUW187048B7qnKBizZq2N8WJ6dcpo6F+vB1okwfXoYlnELXbVvkXra9Be4Nuo
	XSr8KfkGg4f7DXGqB+Grb6FGVfPvJ71rYZaCUOy9LlSQv8pbIlZt2ygV3no4MBnwqJ/VHSQHfLK
	7rF0Zx6S8tL88SA6zIMRB3eGgRZqMtGCRSD5e6DHa3GQ2PtY3jL1g9W7qF0TZY4oiS/2BsLQbbO
	Zf68Z+gb1Y+gjpjlf4URM73Xwd3ckfMijCFwAXLHVtiB+AJE7hmJW9pv4Wa7PvzNk=
X-Google-Smtp-Source: AGHT+IFT8j1VU3XxSr0n64qOgz88JdtoD+z+f0TMDct1OT4UqOclTIHzeKuHbUGO2UvCGjfzJ7rmwg==
X-Received: by 2002:a05:6000:1863:b0:429:d725:40f0 with SMTP id ffacd0b85a97d-42cc1d13128mr15005877f8f.5.1764343739067;
        Fri, 28 Nov 2025 07:28:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d613esm10591284f8f.11.2025.11.28.07.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 07:28:58 -0800 (PST)
Message-ID: <da447d68-8461-4ca5-87ae-dcfdec1308db@6wind.com>
Date: Fri, 28 Nov 2025 16:28:57 +0100
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
 <1d44e105-77bd-42e7-81f5-6e235fd12554@6wind.com>
 <19aca794ddd.105d1f97f173752.5540866508598154532@azey.net>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <19aca794ddd.105d1f97f173752.5540866508598154532@azey.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Le 28/11/2025 à 13:38, azey a écrit :
> On 2025-11-28 09:38:07 +0100  Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
>> With IPv6, unlike IPv4, the ECMP next hops can be added one by one. Your commit
>> doesn't allow this:
>>
>> $ ip -6 route add 2002::/64 via fd00:125::2 dev ntfp2
>> $ ip -6 route append 2002::/64 dev ntfp3
>> $ ip -6 route
>> 2002::/64 via fd00:125::2 dev ntfp2 metric 1024 pref medium
>> 2002::/64 dev ntfp3 metric 1024 pref medium
>> ...
>> $ ip -6 route append 2002::/64 via fd00:175::2 dev ntfp3
>> $ ip -6 route
>> 2002::/64 metric 1024 pref medium
>>         nexthop via fd00:125::2 dev ntfp2 weight 1
>>         nexthop via fd00:175::2 dev ntfp3 weight 1
>>
>> Note that the previous route via ntfp3 has been removed.
> 
> I just tested your example in a VM with my patch, and everything works
> as you described. This is due to fib6_explicit_ecmp not overriding
I tested your patch ;-)

'ip -6 route append 2002::/64 dev ntfp3' failed to add the next hop, a second
route was created.

