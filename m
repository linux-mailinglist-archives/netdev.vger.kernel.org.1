Return-Path: <netdev+bounces-71718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F139C854D4A
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE2A28B3DB
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499405D8F4;
	Wed, 14 Feb 2024 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSaKQiIu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AA95D8F2
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925746; cv=none; b=hhVxFz0rJYJ+YDSy5E2fUmm+hxftNZb7Bc0/hIMQeFq8RvABdmPkc9cX0ceroSfcov14I6jS2reaD8zygz0ngtoZWEx6xwHb1GkZN9alMdxv/pNOqcG83y9xbtNEu/SEHwiP/BescfTabpIxzCnhTDctJqdYo92TEJUof5oQyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925746; c=relaxed/simple;
	bh=g+FVC9l965045qBNcdSS9vpSWLOCiCL8r8ja18eJNFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVti3HcbnTRvNm1zcyGUz0eYpbiy+ASIxX6+oK573LiK3VkT+chE9HtPS0CutgcYbX3NAHTFDE3EJStNEgRzJaYN7FTWuWNXSJkTQEOjHhUP10xJIO0xLcXe00+PFRj/q/cCXoDbq2JtwBo3ZIMvJSwNMziXwfDaDL98aJBCo6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSaKQiIu; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c00128de31so67196139f.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 07:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707925744; x=1708530544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vzvVfLXzR1z+WMkyLTpnAWTkrkVCTU3ZFoKXj2VJi1I=;
        b=kSaKQiIugcwv3y/2+f63uN3pp2TXu7bDb4SQQtQCJolowZ6Hgq/tzJZWnxJD1Pp/N6
         uKO+Ib4flrkgau2akvs7moxo6zlBKCDUtpHRaEFSX0YYJKEsKJhvMqbB9FWYRy59B8YW
         NjEJZQICX3X0Q8vv4+FQJtfn3e3b1vJyEu+GPliu2IIN/Sovy28DSJE2KwoE7fjO0wQo
         8pHnY1N5kaxIfJc04Q10uLmlVuZPw3esVn6OepFHP7f3812IAGZkN3qIhQe38+whyjuP
         2wVnB0xWzjbXEUE6dAYz/qHrkO+PKWkgEfiF0jx7xU9kIgcl41iZ2P5ZpaB7NLkOIqj6
         QA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707925744; x=1708530544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzvVfLXzR1z+WMkyLTpnAWTkrkVCTU3ZFoKXj2VJi1I=;
        b=RJtU19HNWzBker91kUqSDDIIVaU9UqI8732TCo2q5XXMdd4OtLAh2ewCJGkQYq7dPs
         AwqsXMpjP5m89dNqbyqSQs/9WSAfZcjOFqpe7NBpdrrUT1/vwHHlCpe3R836E9dBrxOw
         sp1ryHSC8DILI7HivoWEDsjRlXva6lW+TYsIXoEK94g5a6mQtwMC4Tjb+NM+LYbAuzyC
         iKycXnhS9KeFzTgCq4L3ssNDEJbPqpcihqKAGxcXzGT926G6WW/ZC0UrQFDUeBZsMjVS
         ZSIa33WzinFq86ZiCGdU2a5+goG489i0HZEcn1oRph0uHXuhb+fZL73LJ/CHskeTzTYO
         Acrw==
X-Gm-Message-State: AOJu0YxO9InNGR288+SmIW51ZPfwrAF0R+ApliWSjjFqeS8Uz6yIGv+t
	IJ1DCIQpO79O+W9b5bw75/HPOhQf5eUKQECqtu53rVqbnel8C+ay
X-Google-Smtp-Source: AGHT+IHrvLN7mN9UczoToyKwu1CbfzRkWJ/CE8pbUduTYNTVHyxvxTDCUorhLhTOCbYzbJgHKTP8RA==
X-Received: by 2002:a6b:6b0b:0:b0:7c4:4dd8:34b7 with SMTP id g11-20020a6b6b0b000000b007c44dd834b7mr3807468ioc.10.1707925743670;
        Wed, 14 Feb 2024 07:49:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSTiwXvOAdTEaDehtjjmOJWIstLKhDrmAgH9PHSht1sSuH5TLT+4w9bgR8nE9JTfWi2QmXMIz/N/yhWgsYv+AKpdYj5PpQj/Xit4p/VQ9op9PMQTe1SiLkDJC/bVxpMA==
Received: from ?IPV6:2601:282:1e82:2350:309e:ba0d:4ee:72ff? ([2601:282:1e82:2350:309e:ba0d:4ee:72ff])
        by smtp.googlemail.com with ESMTPSA id x10-20020a6bd00a000000b007c469824bdasm1393028ioa.9.2024.02.14.07.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:49:03 -0800 (PST)
Message-ID: <d2707550-36c2-45d3-ae76-f83b4c19f88c@gmail.com>
Date: Wed, 14 Feb 2024 08:49:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iproute2: fix build failure on ppc64le
Content-Language: en-US
To: Andrea Claudi <aclaudi@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, sgallagh@redhat.com
References: <d13ef7c00b60a50a5e8ddbb7ff138399689d3483.1707474099.git.aclaudi@redhat.com>
 <20240209083533.1246ddcc@hermes.local>
 <3730d7e4-058f-421f-8ecf-a9475440ef58@gmail.com>
 <20240209164542.716b4d7a@hermes.local> <ZczcqOHwlGC1Pmzx@renaissance-vector>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <ZczcqOHwlGC1Pmzx@renaissance-vector>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/14/24 8:30 AM, Andrea Claudi wrote:
> On Fri, Feb 09, 2024 at 04:45:42PM -0800, Stephen Hemminger wrote:
>> On Fri, 9 Feb 2024 15:14:28 -0700
>> David Ahern <dsahern@gmail.com> wrote:
>>
>>> On 2/9/24 9:35 AM, Stephen Hemminger wrote:
>>>> On Fri,  9 Feb 2024 11:24:47 +0100
>>>> Andrea Claudi <aclaudi@redhat.com> wrote:
>>>>   
>>>>> ss.c:3244:34: warning: format ‘%llu’ expects argument of type ‘long long unsigned int’, but argument 2 has type ‘__u64’ {aka ‘long unsigned int’} [-Wformat=]
>>>>>  3244 |                 out(" rcv_nxt:%llu", s->mptcpi_rcv_nxt);
>>>>>       |                               ~~~^   ~~~~~~~~~~~~~~~~~
>>>>>       |                                  |    |
>>>>>       |                                  |    __u64 {aka long unsigned int}
>>>>>       |                                  long long unsigned int
>>>>>       |                               %lu
>>>>>
>>>>> This happens because __u64 is defined as long unsigned on ppc64le.  As
>>>>> pointed out by Florian Weimar, we should use -D__SANE_USERSPACE_TYPES__
>>>>> if we really want to use long long unsigned in iproute2.  
>>>>
>>>> Ok, this looks good.
>>>> Another way to fix would be to use the macros defined in inttypes.h
>>>>
>>>> 		out(" rcv_nxt:"PRIu64, s->mptcpi_rcv_nxt);
>>>>   
>>>
>>> since the uapi is __u64, I think this is the better approach.
>>
>> NVM
>> Tried it, but __u64 is not the same as uint64_t even on x86.
>> __u64 is long long unsigned int
>> uint64_t is long unsigned int
>>
> 
> Is there anything more I can do about this?
> 

where does the uint64_t come in? include/uapi/linux/mptcp.h has
mptcpi_rcv_nxt as __u64 and PRIu64 macros should be working without a
problem - this is what perf tool uses consistently.

