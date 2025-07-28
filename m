Return-Path: <netdev+bounces-210652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 876ECB14243
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 20:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FFD018C307B
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4CE275AFF;
	Mon, 28 Jul 2025 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmMVPCb0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B97A27603B;
	Mon, 28 Jul 2025 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729015; cv=none; b=OXKL4/5FZtu8YAcMBqGD8YGd6gsFzgFA4eUou70gCnJjDjMFzoYIsB4DieV2vAQjvA0IUwFUVLbgTJ60Idp6SVsOvf+te09UvBy8f5lqeEa4f4nWHtHIkujREbE+nHSI0IMGejGJjQqMnTmIot+6cVoDkmsB7Sw5LcoWC0JiwtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729015; c=relaxed/simple;
	bh=NWjQWb/sUMDGlkOFoon5e9KOzha0g80Kp/0CUie15iI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=C57fPHxOsbQztOf9eOoOUzI+Q21BroQ32coAX/Sq2Q5HTY83jBmtUM+qPxCqDBef3RDmExCBbtMMj+uJo8H6qvN+wgm+vEv1LQP6fKTFazadpN5pHdW5xyfiA0uplZCUXiMBJCrYu1Ca3eoC9agS0kjMyy/9+hnEcR2imPgCuvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmMVPCb0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61553a028dfso1235888a12.0;
        Mon, 28 Jul 2025 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753729013; x=1754333813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dd29/9oaIlOim+XmHnfQLMMoh7cvgqnpmNKjInWozRA=;
        b=GmMVPCb0JxmpYDLoYCEGXkohDE9D7AkNq9M0OUwH4eglzMVXMERjP7nqU3gxt4ivRS
         Dmz8yonAJ2I0dBPfq//aHKOk1MMk+2SCoVgLTjAJWhcH26LyN9X7l4rMI1uR3GkagA5/
         jw1kI+1iSrz75ypigp8PFTd5tyxA2heN8nBs4EYYH82V99gU+ABu9iChR+jIKpWPBc3R
         4wiqllqTTIybOY46Ro0B2HYGIT6PMEq8cCL+wNFVUYDQe6JYbb/jaMeAFOh/PTBm9xrU
         71WcmrETK0ztuGd9uBbL+5Pf9jPfykUemlkDeaAUN+ncrsTG/mRPwyWbk2tRMUjOt2ma
         Fvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753729013; x=1754333813;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd29/9oaIlOim+XmHnfQLMMoh7cvgqnpmNKjInWozRA=;
        b=M54axIuwfHZwFfAmx5vgzENZNhW0Pwi4vPIec/rkVCg1cHAaJsw0Mwn5l7nLTxNiZj
         dvtNZzLt6tPDfEI6jshOvWsDQj95lW5ZYRGHmS7x+tvoIUVdEauOQs8bTFsEhwerAIJs
         TC355Xb+BhPmcUP+zNhPzH35u7Yj+UsRLsJ+cPCqPgtl5DraTjhbv6qXMnA6MxMgoIwi
         6A+zAJVcFbYbwjymOsY0tADeNvVP+sweTdupo8x1aMJBq6zCo35jt66PPm4aXyJ2msiY
         yMtQOtJu9qGaIymCb7pjF0fzooTYFi2QQ4uKoGUnOImbkJ+FFOT9E/weVlbf0mQRDePo
         TY4g==
X-Forwarded-Encrypted: i=1; AJvYcCWB5kGsbETX37QNRT3HxlvLa1mE5w6jk9k/ll9wwUK2El3PcF5NINoxOXiVABy85MXWu0WhMkPBSBLiYyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFmHJXEoU9wmpSjO2Gi901QafSLzTI73U9p3tNtzQ6M1N+37ZI
	nniC1MfSsBw6JdHAKCZsfB/wQ/K/5vwMpjvs4Jj6DBJH25ibChOrlKEg
X-Gm-Gg: ASbGnctd7wPFYY4uTq81FO2Cnw0qeOmieNUCNwlPFk9yy1nWz++9GjvH1QM/kjCH8RE
	aQjAAe2vwac+RP85OhusALVR3W7ijEfERjnwz2zeWpwA/m9U9+P1RIFe6uZW0IAuC5eIJieH5GU
	FpWhK7S+yLPWqQ07bRTPCFWGOk+AeesDG3kAZVcutZmar0fWC7TowT1C43PzF4qTwyxb96ax1Uj
	fAf7Ens25n5mNpBKl3YM/aOJadsWAAdVVE/17lCVPwv6ABQdVJaFKGLJbNNvsogE7n4yoLEWkWq
	N8PWzQIhMjvxR6ajdNacrYVZ79BzPf9mFch6E91kYE6LaMvu8PBru0bqF1bmolopHTF9+OqZqbO
	OeDY/uK70SHuPe7yJFsV2V8bgdnw6cTY=
X-Google-Smtp-Source: AGHT+IGbuc0B8XaZdqvloFh4fHwWVfwzstSr7U8PZMRy5AUad6XCuv4cBXuTVuLpLKWnWwpeIkVtBQ==
X-Received: by 2002:a05:6402:4602:20b0:612:a8a1:d038 with SMTP id 4fb4d7f45d1cf-614f1d60a85mr9030501a12.20.1753729012421;
        Mon, 28 Jul 2025 11:56:52 -0700 (PDT)
Received: from [192.168.8.100] ([185.69.144.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61548e6e705sm1193339a12.42.2025.07.28.11.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 11:56:51 -0700 (PDT)
Message-ID: <087ca43a-49b7-40c9-915d-558075181fd1@gmail.com>
Date: Mon, 28 Jul 2025 19:58:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next] netmem: replace __netmem_clear_lsb() with
 netmem_to_nmdesc()
From: Pavel Begunkov <asml.silence@gmail.com>
To: Mina Almasry <almasrymina@google.com>, Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, toke@redhat.com
References: <20250728042050.24228-1-byungchul@sk.com>
 <CAHS8izPv8zmPaxzCSPAnybiCc0KrqjEZA+x5wpFOE8u=_nM1WA@mail.gmail.com>
 <b239b40b-0abe-43a5-af41-346283a634f6@gmail.com>
Content-Language: en-US
In-Reply-To: <b239b40b-0abe-43a5-af41-346283a634f6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/28/25 19:46, Pavel Begunkov wrote:
> On 7/28/25 18:44, Mina Almasry wrote:
>> On Sun, Jul 27, 2025 at 9:21 PM Byungchul Park <byungchul@sk.com> wrote:
>>>
> 
> ...>> - * Return: the netmem_ref cast to net_iov* regardless of its underlying type.
>>> + * Return: the pointer to struct netmem_desc * regardless of its
>>> + * underlying type.
>>>    */
>>> -static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
>>> +static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
>>>   {
>>> -       return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
>>> +       if (netmem_is_net_iov(netmem))
>>> +               return &((struct net_iov *)((__force unsigned long)netmem &
>>> +                                           ~NET_IOV))->desc;
>>> +
>>> +       return __netmem_to_nmdesc(netmem);
>>
>> The if statement generates overhead. I'd rather avoid it. We can
>> implement netmem_to_nmdesc like this, no?
>>
>> netmem_to_nmdesc(netmem_ref netmem)
>> {
>>    return (struct netmem_desc)((__force unsigned long)netmem & ~NET_IOV);
>> }
>>
>> Because netmem_desc is the first element in both net_iov and page for
>> the moment. (yes I know that will change eventually, but we don't have
>> to incur overhead of an extra if statement until netmem_desc is
>> removed from page, right?)
> 
> Same concern, but I think the goal here should be to make enough

s/make/give/


> info to the compiler to optimise it out without assumptions on
> the layouts nor NET_IOV_ASSERT_OFFSET. Currently it's not so bad,
> but we should be able to remove this test+cmove.
> 
>      movq    %rdi, %rax    # netmem, tmp105
>      andq    $-2, %rax    #, tmp105
>      testb    $1, %dil    #, netmem
>      cmove    %rdi, %rax    # tmp105,, netmem, <retval>
>      jmp    __x86_return_thunk

struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
{
	void *p = (void *)((__force unsigned long)netmem & ~NET_IOV);

	if (netmem_is_net_iov(netmem))
		return &((struct net_iov *)p)->desc;
	return __pp_page_to_nmdesc((struct page *)p);
}

movq	%rdi, %rax	# netmem, netmem
andq	$-2, %rax	#, netmem
jmp	__x86_return_thunk


This should do it, and if the layouts change, it'd still
remain correct.

-- 
Pavel Begunkov


