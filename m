Return-Path: <netdev+bounces-232590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCDEC06D49
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D603ACFF4
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AEC2C21EF;
	Fri, 24 Oct 2025 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="d9U1m62S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367EE303A17
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317972; cv=none; b=ITuwWNb2qfdeeU2a+rH31+8RXKOg7UKze1qnGplA+ZHfXSO238DphvbbWijT7RPRPd3Hu50ytLuk45fxXNt35x9z5k2eaFZNpR3mtgAoWk+v+VP9ksbMrkjfz+pV71AR24sgsLEY4EqgEqkugJicYFvixQwMcv19UdmmS4CPiXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317972; c=relaxed/simple;
	bh=Xo23AlrJFpeHh6DJkPO6dpHgBIWv33gQ18h2Hfun2vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLdvIWtFCuteDt8y9L/lCdgDDPHFYNeFLDyimd8SYEzB1hjb+gwl+WYt+FHbwh8MybRZRFbdZ/lEYbMkp4TCVIgo1Wb2aFfajRyn6R/+/cHi0d/hrfJb7UVBLYGpO7WV4lr+XvMDpjthEhSMhETffSxITA7YoMOHuVXf3i7ifYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=d9U1m62S; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42855f80f01so346964f8f.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1761317968; x=1761922768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S03wUtYmG3kE6LJin33WuT98F+yQ/qV5EGqRiSgb7bs=;
        b=d9U1m62StamCGV+DqYkMa9TXwcbTBYNlmkbxfz0xTD99jl7fAgldCQhTeK/Piz7LI8
         PXqUxwER/AIGWlwqLigy7wNjp7g7+RRt/d+uNt6V4RXMHVXIReyS07dx1OlQct3OWRHO
         ZR/si1UvwtRGtvLfvSNlOUhpAzO4N9OcyEIUG6B58DPOfB0xoVLIVan0YS5PHydGMJIC
         IMym+uD1n/oTzWbmRZMNM3Cp9+gPHYCZ/6dr2UM9Apoh4s772oT6IU5kf8VTY8OEH5f0
         kKB1Fm0fUYfM51TTHeIsACvvPNdsOlAy4FZhwZ7mpwPj6Q7mvAWIE1ViSzqr/XRRpSZv
         eTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317968; x=1761922768;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S03wUtYmG3kE6LJin33WuT98F+yQ/qV5EGqRiSgb7bs=;
        b=G9Z7J7BCMMEZ+CYB+42rSTG4FaYa43sC01f5fA2TeErMjNeH/LOYmA4bXNNsDC02M/
         Q1e7woVkDkT9PZ7QD2UYRZy3a5tfRDEbyzoE6ev4yy/NSkAM8ZoPxBqB5Kn1Bf3roAKe
         O2l4SgbtngU5tQybhA+iGU0oNYw9wzgKyOVNrT1LSrf50Qvyu34bEG+/kGwWdSixk3xS
         6rOd9pVKqXnl/PZJZEKnVdwTdfzIad0ugdvwrB61WCRgoEs85xlyjunyvE+i3zSeCIV9
         ICSNNGlf3kbw/77C6IhcdREjNY8o9GfGONvLKJhi1sNLmnKNVbXdw4NPVTlhtRHApKXG
         16pg==
X-Forwarded-Encrypted: i=1; AJvYcCUZiMNMwcSgo/Iqq5Rv3HWmIIzzkSJq/ih3R468z2eJBjKCwv+5zBJ+XmQBktj9wJrVbFyMius=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8+OPNnxq+4QdZY61xZuzVnvcFn/IYfXNH1Ub7KJ0sZZA4ERLC
	0c4lykIHKoqk4IquvtUVgNU9PyKda0vEeKsBRD/mLUD03vqUbLZYp+nEMlzWAJcXJWQ=
X-Gm-Gg: ASbGncvfICiah0XrZ39oD9PEdggw3xZinUQQbEEn/NHoMhC9zdpTFWyH9GAgYHS8Mue
	d5VGxdFeBjMQ+f5L2xF6O4izg7X6KLOjkFK0zwu+XFl100zePCS/pw7vlWK12uOf4flPJa0MnEb
	T/jX+d1nlMlUyJpWq332jTfg9/TdcVVJFlvX5Qb2+a7DlwaL/FrPpZVkY30oJkvVMxrSa+ePTbA
	EyyxUmJEbzbqCmlGAfOYDUCrW1kt36NZaUULSmjXl+yBztnb+D5a0n1HIhmygXdBbRVdgcrjF/z
	1OtP1icIFFxpqBwvEJ+oBXVLNnLnW5fdpoZdlVjMJfgHRq66b9HzPTs2dJ6iDvY+ZyPgk8Heeoc
	DON5XbJWMa+Gc5rtpOc+NUaeC6H095ieO1j1lAH6NEfrrjZ97ZfW9Gbm8qIx4IDhx4zNcSZ/Rpv
	pGMwqQ+zUn8PVGcxzsrv3xUYnKQuCeOebLhjwv6mSp7ONSTUcVQbPWrht7QrqaKLA=
X-Google-Smtp-Source: AGHT+IHVh4znL8o504Bn84IxG9lVJmICafAHUtQizwzd9EwC2Na0fIoNIB6qTB3l08lWzAyyfX7XAQ==
X-Received: by 2002:a5d:5f56:0:b0:427:401:1986 with SMTP id ffacd0b85a97d-4284e576585mr5566114f8f.9.1761317968159;
        Fri, 24 Oct 2025 07:59:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898adf99sm10260322f8f.28.2025.10.24.07.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 07:59:27 -0700 (PDT)
Message-ID: <43916b1a-e6bb-407d-852c-eaa3c4652d03@6wind.com>
Date: Fri, 24 Oct 2025 16:59:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
To: Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Xiao Liang <shaw.leon@gmail.com>, Cong Wang <cong.wang@bytedance.com>,
 linux-kernel@vger.kernel.org
References: <20251023083450.1215111-1-amorenoz@redhat.com>
 <874irofkjv.fsf@toke.dk>
 <CANn89iL+=shdsPdkdQb=Sb1=FDn+uGsu_JXD+449=KHMabV1cQ@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CANn89iL+=shdsPdkdQb=Sb1=FDn+uGsu_JXD+449=KHMabV1cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Le 24/10/2025 à 16:35, Eric Dumazet a écrit :
> On Fri, Oct 24, 2025 at 7:20 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> Adrian Moreno <amorenoz@redhat.com> writes:
>>
>>> Gathering interface statistics can be a relatively expensive operation
>>> on certain systems as it requires iterating over all the cpus.
>>>
>>> RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
>>> statistics from interface dumps and it was then extended [2] to
>>> also exclude IFLA_VF_INFO.
>>>
>>> The semantics of the flag does not seem to be limited to AF_INET
>>> or VF statistics and having a way to query the interface status
>>> (e.g: carrier, address) without retrieving its statistics seems
>>> reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
>>> to also affect IFLA_STATS.
>>>
>>> [1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
>>> [2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/
>>>
>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>>> ---
>>>  net/core/rtnetlink.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>>> index 8040ff7c356e..88d52157ef1c 100644
>>> --- a/net/core/rtnetlink.c
>>> +++ b/net/core/rtnetlink.c
>>> @@ -2123,7 +2123,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>>>       if (rtnl_phys_switch_id_fill(skb, dev))
>>>               goto nla_put_failure;
>>>
>>> -     if (rtnl_fill_stats(skb, dev))
>>> +     if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS &&
>>> +         rtnl_fill_stats(skb, dev))
>>
>> Nit: I find this:
>>
>>         if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS) &&
>>             rtnl_fill_stats(skb, dev))
>>
>> more readable. It's a logical operation, so the bitwise negation is less
>> clear IMO.
>>
> 
> Same for me. I guess it is copy/pasted from line 1162 (in rtnl_vfinfo_size())
I agree. I didn't point it out because there are several occurrences in this
file (line 1599 / rtnl_fill_vfinfo()).

