Return-Path: <netdev+bounces-198347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41056ADBDE7
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 02:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A303A7BB8
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E24632;
	Tue, 17 Jun 2025 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="153HOoY/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0EF79CF
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 00:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750118652; cv=none; b=ocLboi/73/83/NSZfBsf4b31MqnAuJXaRNvCM7uabn/qpoSxdGHrq7DNaBgAoa0mm4fmGE0/5dL30P7aaFBev7SU9J174c+O3y8ZTlU93bwN3eH4yv2u2ohGq06ALYmotzqpUKmc0VR+d6JCBRdpNzcinEk40/XXTE931qjDpS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750118652; c=relaxed/simple;
	bh=ccdMpkqAval9n45jsuFPwY2WkKbfYhhmbBpZ22NK7qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PICsDCFYwCIDve+Ik5QF1ESwoY7SnmCsPM2X+aejj0QRhLg4LEfwwtfDuzVcVaAUF77aCgjRP18jKWzeA/I1RwA+bdzEPWMeTvBphXirsH9IsmGYR9MnzQNN+lUma6Li+W7YfKRcNCOaA6RbzpC1dGUQmYxAxrewsZjPUhmUZgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=153HOoY/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3138b2f0249so4624905a91.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 17:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1750118651; x=1750723451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QMNMaDPY5K/cUz5hya2mqFo6hDt7QU0l04o0wcznj7I=;
        b=153HOoY/Gk1UpfFsb/ANbwyzh9toPeao/AM8JHEx2ZR6M2ndTLjUEzQPGCw147J/AU
         1BLpjBUIfavhSHmg25NNVIU1+SAh8wgLbFrmQyP4WdMyBf1cnuGEztIW2hos8MB64JGH
         dkbB2SM1ZT4ZuIkckINeoBujfeZu139P51N8KfBT7FLuMESVsqNSHqI4U9FXV2IIrVKB
         Lq/aGVwBEAaSvZt4tthoyxyStRq92cjVnpRar1M6oF43J9A3s4qMmzNEEaA7PeiB5e++
         0iQRsEkspjfjlQzZEYzZYFD4rlvMFXMO78OUG/1tTSjfEsZrZTVKnRinStBtjhfQj9oo
         JoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750118651; x=1750723451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMNMaDPY5K/cUz5hya2mqFo6hDt7QU0l04o0wcznj7I=;
        b=bTTxi+Id9VNKZC6xrNriN0nUnpJVKIPiB/wqu2oTZNS9ouDm0z9cx4PhR8ncBsj1Tn
         YHfwRl0zylP72R1Y2gIsS+G12jQ+Bk/PoXYpt2qqwu+zF0AFMTpH3iYfeacjSqVgosLP
         w09lsQEbl0jHDs0gE5l8u0+DifcfNH/UheQov7KV26es6dnT1jMFWvaby1QhmNRFx8t7
         upao2VSfGLhMzwi1+BOiQ4ON6nO8FRv0nC6XRvS9ior4glts0ibyBnAChi3bU863LO22
         kt4KM3aVu8ADBUm44MgJhXEBBTNuPV2yQI90y5LYqUFC/4Eyx1NKoprmIOH+n0GR0Oyi
         A8QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSQTAeZWf2chcWl3zy3wc33bU5A+dqmsfbJpabDLTAZXUDaQdHX/wTmmpztci5X9shNMEecxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Wu3vGmAex4AwjGzNSnfjFAlnLhA9dC0Il+kcpjEny8SKvjV8
	M6ody2apd9CKvwsqqwNY0H+W4ZZr/kO3ur8wzk0Tou5xrdcm7A9aaeDell0gZq0G/H4=
X-Gm-Gg: ASbGnctDekoc6lLEnfkTLMdVuqiCsHR00jb8xEyO75eXEY+X90jLhy0NK8sUGVp7HX/
	xjxLVNtuPxbfP6qPjbfjyMJcR18D0/FxbRkBQ5eJgUsKpJwD3jZqU7SRB/Ce08OQaojR6lSM3YU
	0jqN7gXLtVz2GWhaS9eIpSsCOTPBavKCF7iWGpBr7cTdbAQE7STDNrY3k7mmLqlYy5tcM6vEr+M
	OcRrvnYj+TZbXFVpLiv8jmyW3ryHL6lPcDoE73/LndasooCx2GxueZJAKsLEoH6DjRUK7272RDH
	ViHFrwYXDHYasVAt4Y3B4SO23tK57Y7ScHZ7Vb50A3/WXs4APNybWfb1Ld5Gq++wVIVTpaCVe4X
	zNXyZqIjWjAIGl6najUGH4Gpq
X-Google-Smtp-Source: AGHT+IFBFgKjP2cUoF4+mLoILT6N3OWyXb1yIhH35VhLNHjpGKjrKFgr/r4fKQ5PXpdzREnOWg35EQ==
X-Received: by 2002:a17:90b:350a:b0:2ee:6d08:7936 with SMTP id 98e67ed59e1d1-313f1d58ba9mr16254996a91.20.1750118650747;
        Mon, 16 Jun 2025 17:04:10 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:14f8:5a41:7998:a806? ([2620:10d:c090:500::7:e85f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c6aa1bsm9337271a91.45.2025.06.16.17.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 17:04:10 -0700 (PDT)
Message-ID: <72fdc777-eb43-4d15-a6d2-6f652e019cb3@davidwei.uk>
Date: Mon, 16 Jun 2025 17:04:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 4/4] tcp: fix passive TFO socket having invalid
 NAPI ID
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, horms@kernel.org, kuba@kernel.org, kuniyu@google.com,
 ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org
References: <e725afd8-610b-457a-b30e-963cbf8930af@davidwei.uk>
 <20250616230612.1139387-1-kuni1840@gmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250616230612.1139387-1-kuni1840@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-16 16:05, Kuniyuki Iwashima wrote:
> From: David Wei <dw@davidwei.uk>
> Date: Mon, 16 Jun 2025 15:37:40 -0700
>> On 2025-06-16 12:44, Kuniyuki Iwashima wrote:
>>> From: David Wei <dw@davidwei.uk>
>>> Date: Mon, 16 Jun 2025 11:54:56 -0700
>>>> There is a bug with passive TFO sockets returning an invalid NAPI ID 0
>>>> from SO_INCOMING_NAPI_ID. Normally this is not an issue, but zero copy
>>>> receive relies on a correct NAPI ID to process sockets on the right
>>>> queue.
>>>>
>>>> Fix by adding a skb_mark_napi_id().
>>>>
>>>
>>> Please add Fixes: tag.
>>
>> Not sure which commit to tag as Fixes. 5b7ed089 originally created
>> tcp_fastopen_create_child() in tcp_fastopen.c by copying from
>> tcp_v4_conn_req_fastopen(). The bug has been around since either when
>> TFO was added in 168a8f58 or when SO_INCOMING_NAPI_ID was added in
>> 6d433902. What's your preference?
> 
> 6d4339028b35 makes sense to me as SO_INCOMING_NAPI_ID (2017) was
> not available as of the TFO commits (2012, 2014).

Makes sense, I'll use 6d433902. Thanks.

> 
> 
>>
>>>
>>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>>> ---
>>>>    net/ipv4/tcp_fastopen.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
>>>> index 9b83d639b5ac..d0ed1779861b 100644
>>>> --- a/net/ipv4/tcp_fastopen.c
>>>> +++ b/net/ipv4/tcp_fastopen.c
>>>> @@ -3,6 +3,7 @@
>>>>    #include <linux/tcp.h>
>>>>    #include <linux/rcupdate.h>
>>>>    #include <net/tcp.h>
>>>> +#include <net/busy_poll.h>
>>>>    
>>>>    void tcp_fastopen_init_key_once(struct net *net)
>>>>    {
>>>> @@ -279,6 +280,8 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
>>>>    
>>>>    	refcount_set(&req->rsk_refcnt, 2);
>>>>    
>>>> +	sk_mark_napi_id(child, skb);
>>>
>>> I think sk_mark_napi_id_set() is better here.
>>
>> Sure, I can switch to sk_mark_napi_id_set().
>>
>>>
>>>
>>>> +
>>>>    	/* Now finish processing the fastopen child socket. */
>>>>    	tcp_init_transfer(child, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, skb);
>>>>    
>>>> -- 
>>>> 2.47.1
>>>>

