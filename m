Return-Path: <netdev+bounces-210649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBBFB1422E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 20:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB113BEB19
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFE6276047;
	Mon, 28 Jul 2025 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9zcZqwt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A85275AFF;
	Mon, 28 Jul 2025 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728335; cv=none; b=c7pLV2LPpTZL6+gb5apR3OvSd/qW1M4S0NJEhaIbec+Z0VXZC4axzTggXqqlmjgFPa8QxVSUm5gIfG5AliOijA/1br4vlMApi2RO7oYpCJ0eyeSHjfd6VCseIxB6V3RtIzCJOaPK4LugoyajI/8kqmPnZbaZpNRvmmmVSL1Xdzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728335; c=relaxed/simple;
	bh=L4Db1pxATdG7IIRr3s0/lh4/z+/zlqttjBtBrg1PhNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWMjFskSAisxKGqIfXNhj0BbWt3Iq4d7mhvcVidxDNjGyfdob6bTgiJpguwige3gb5y9vb2nmhLFKbmXwJ79kI4Vjokxb+f4n30C9LnIF3z+wPTFHJfnSmYNUcbqex3oqui5eMn8rsvrIqBF059tbVvCeoR6YUMp4EuVNIGB9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9zcZqwt; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso8796372a12.2;
        Mon, 28 Jul 2025 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753728332; x=1754333132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10fItAIR6ttHobr65zBVx1M/rxx8UYDMCkQP8A5nIyU=;
        b=R9zcZqwtiq97wpQmcpM5bVL0TkJaoNflxNTa3YcYf7CtmGVpJNRcXvF5myuYfnv2Nb
         ZLvRukCnHbdLlKjFFgHjFUfRQt4BOHhKo095X7O9iCuwu+VD/N3crd58tXdD7aJVxUx+
         yYEdD1wtJz/Lov2oSWfAdj9gKcYwRv8nDzRKWz3fGh8NOxp7//MSu2rQyXxmTnLErZTd
         H3ha7XrPPi2+npP6Dkrxttcak8pniXxPKXgTgm3lq43ZdqiA9PLsppvu1Jo/ard4dIgm
         eNC974ndyUibhCSr3avOd2xiusx7Y6Ps13orsihJfmvuoQK/VKCujH1iMcau58CAiVo3
         YoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753728332; x=1754333132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10fItAIR6ttHobr65zBVx1M/rxx8UYDMCkQP8A5nIyU=;
        b=jciOe18GjvSwCSNhKEV4JUw6G3F20yhWuc/LUZ5GUMTtr5t7GwK2Giyvpz+ivU7n/K
         YTvHtDMX/76Ff7+3Qee6DoOMd0uvWIeTSeND5ZByatnH4nOSZBaU+9D91XWM/Vc/MfLT
         WPykxlyNf4yXtAU/6wFkb1GaImCtFSKBHLKUXNW17SY2ekEAofNnh4i3oez71yrD1IrE
         lb5LJ2B5ES5CnsFk6VtOyFaMTetZKNGhq02XVc3tXeESaIMS1cy+L0zM6FL+b7+NMgJw
         KRAaBoYqCxjaqWGOIdutu3tAt4ZDOQOgByhii8Hy586lhxM5Y4dz/pD67xyatDY/FgKK
         ttBw==
X-Forwarded-Encrypted: i=1; AJvYcCWBefpLuSmL/Wwf+m/+F/agnWCcEipk6gstKV9FVdDhhlf8v53M8rhjLNpTgJhn/Hsy5BftAfVxTgaWay0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyxmKHSHWjUdS6EVQFylDYNzofvLKyCsUMvnuRHpUdilFVOPEK
	HQYQxLq9BFu8CQMV+C1XEcPDiMOoh3x/zyXJlCc+r/M7tKCBTrPZiym0
X-Gm-Gg: ASbGnctLmtkNWj1Q5YfiMHlffLuiek59fs50fft2tmKqTKwo8HK4d/95mulgPWYwrSf
	8Lzo3vPfO5UF0PpKLRvCMYjR17oS1idK173D26ecjU8QjpttgDP2fXaMagwMGMsduzPBwir+kI9
	vsrF5cuNMOozrvQDD41HqO8yxNBFZ2dvvuEsH0nZ8gs1E1LqS8ab/iZzUfID3zikmGOxhk8EjiL
	flLatfDpOrTwnZnX5xXFZNS8Fad3HaMCwcVDrOth8l/iZvE2t9xBQvEkSeuc2QLczWQZ4yUk4Pp
	tJ+nXWrH2juT89ihSeXM4aH8Si67xSzqZH/FC7UdXr8IYqhR41l60p6/hGp6TN3jOZRyFmOwIJ5
	ubFeOJtm9DoWL1KGFje3RZoCFxDbCpnDjfnLcK6uiXQ==
X-Google-Smtp-Source: AGHT+IE56ECd+QSgN1GaXs38Y/P1yj3runQl3Tr4BGJC5u/T7oPyqZAeaTGSBLeQk4rdNqenUniC7w==
X-Received: by 2002:a17:907:971f:b0:ae3:6651:58ba with SMTP id a640c23a62f3a-af618ae3b2fmr1147325466b.35.1753728331391;
        Mon, 28 Jul 2025 11:45:31 -0700 (PDT)
Received: from [192.168.8.100] ([185.69.144.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358a1858sm464465766b.45.2025.07.28.11.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 11:45:30 -0700 (PDT)
Message-ID: <b239b40b-0abe-43a5-af41-346283a634f6@gmail.com>
Date: Mon, 28 Jul 2025 19:46:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next] netmem: replace __netmem_clear_lsb() with
 netmem_to_nmdesc()
To: Mina Almasry <almasrymina@google.com>, Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, toke@redhat.com
References: <20250728042050.24228-1-byungchul@sk.com>
 <CAHS8izPv8zmPaxzCSPAnybiCc0KrqjEZA+x5wpFOE8u=_nM1WA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izPv8zmPaxzCSPAnybiCc0KrqjEZA+x5wpFOE8u=_nM1WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/28/25 18:44, Mina Almasry wrote:
> On Sun, Jul 27, 2025 at 9:21 PM Byungchul Park <byungchul@sk.com> wrote:
>>

...>> - * Return: the netmem_ref cast to net_iov* regardless of its underlying type.
>> + * Return: the pointer to struct netmem_desc * regardless of its
>> + * underlying type.
>>    */
>> -static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
>> +static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
>>   {
>> -       return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
>> +       if (netmem_is_net_iov(netmem))
>> +               return &((struct net_iov *)((__force unsigned long)netmem &
>> +                                           ~NET_IOV))->desc;
>> +
>> +       return __netmem_to_nmdesc(netmem);
> 
> The if statement generates overhead. I'd rather avoid it. We can
> implement netmem_to_nmdesc like this, no?
> 
> netmem_to_nmdesc(netmem_ref netmem)
> {
>    return (struct netmem_desc)((__force unsigned long)netmem & ~NET_IOV);
> }
> 
> Because netmem_desc is the first element in both net_iov and page for
> the moment. (yes I know that will change eventually, but we don't have
> to incur overhead of an extra if statement until netmem_desc is
> removed from page, right?)

Same concern, but I think the goal here should be to make enough
info to the compiler to optimise it out without assumptions on
the layouts nor NET_IOV_ASSERT_OFFSET. Currently it's not so bad,
but we should be able to remove this test+cmove.

	movq	%rdi, %rax	# netmem, tmp105
	andq	$-2, %rax	#, tmp105
	testb	$1, %dil	#, netmem
	cmove	%rdi, %rax	# tmp105,, netmem, <retval>
	jmp	__x86_return_thunk


-- 
Pavel Begunkov


