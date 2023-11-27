Return-Path: <netdev+bounces-51337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFC17FA333
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 15:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6BD1C20D89
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 14:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1E818B1D;
	Mon, 27 Nov 2023 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="CBJREwQv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D3ED6
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 06:42:37 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b2fa4ec5eso32071685e9.2
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 06:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701096156; x=1701700956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxfzDc/FOlQJPW+eMBIMnqmN4E4YBo99inVtzp0qQYU=;
        b=CBJREwQvlpTYtm0oC9GJAe2XPhaVpmIq4EgbbZR/DimAkvLzKhdmYOBP+dnuFjbzAt
         o214ENzW3f9pQ6OeAqJM+Cw2Hrqw5UgoJrEk6WH9zCUNlFwIFCB+tY5OuzVG67LzawSO
         qOzVk1TUa3gRbQ+jURIOnBmyaxQwDxntChAdaljIuJ9eQQf9iFxlmc2uLN27uWI28Ts5
         GPH2GbRLsKVu0SAY4G6oSlnJoYJKYc1bvtDFzFntJIhPhiVPxAb4qy1PqaWjP6yb3cDS
         YwR3B3cy5X8LfaTzmA7JfAdJXI9W8QB/dWwTuW8zF0iLDHY8hIS+VQHOOFW1SaZ3HcSP
         irPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701096156; x=1701700956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxfzDc/FOlQJPW+eMBIMnqmN4E4YBo99inVtzp0qQYU=;
        b=hGVBCmDnuUpmFKPxEGv6DUmiB3pFFsuma7G7reCvw4Q7kVPbvfA5EsBHog9svyDMLB
         ik3pu/rmp2sGsZs8CVYVb0TXGd/7V5YRNRFoRf6AlRv6y4fA9WZ6vR8PnFzObNEEbBHl
         WDXo6lQKi8hryUOJaBLnvwTcxMiKh1T+lHFfMNuTiRWsDhE/y9wIaV3uQMBIMcpFriuz
         6gp5rmVnMloDhZdwuyg/RR6urKbK5VLRlOQmUrlQJnAvKhE8bRkWxBKd8nIzDy4b+hRl
         ykLin+EJx311hqUNykya8J4uBSjWrqylgb/GkH6E+2DHfXIX+Czl/aUXn8i/RowJ4NS+
         e6pw==
X-Gm-Message-State: AOJu0Yyr1tN9tMsEiMD6JNdYWeUFV/odxf1QLaLcLZjcQ36f1tb5b2J4
	k9FYLxOIzdoUlROQm4aZf4LHMg==
X-Google-Smtp-Source: AGHT+IEZEaiZdNVOcsnqhzfse9tv8bugsQZEwEYD5l2LSBcbYvAslZmo1pKLJ9451CzB7ZyxhzNXSQ==
X-Received: by 2002:a05:600c:4ecf:b0:40b:47dc:9bb3 with SMTP id g15-20020a05600c4ecf00b0040b47dc9bb3mr1419154wmq.14.1701096155885;
        Mon, 27 Nov 2023 06:42:35 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b004042dbb8925sm14810305wms.38.2023.11.27.06.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 06:42:35 -0800 (PST)
Message-ID: <90de4882-7683-4c7b-95bc-a5eb363912a2@arista.com>
Date: Mon, 27 Nov 2023 14:42:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] net/tcp: Add sne_lock to access SNEs
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
 Francesco Ruggeri <fruggeri05@gmail.com>,
 Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
References: <20231124002720.102537-1-dima@arista.com>
 <20231124002720.102537-7-dima@arista.com>
 <1c769b1a72c5a7f6e19010dfccc78b2502484cf3.camel@redhat.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <1c769b1a72c5a7f6e19010dfccc78b2502484cf3.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/23 11:41, Paolo Abeni wrote:
> On Fri, 2023-11-24 at 00:27 +0000, Dmitry Safonov wrote:
>> RFC 5925 (6.2):
>>> TCP-AO emulates a 64-bit sequence number space by inferring when to
>>> increment the high-order 32-bit portion (the SNE) based on
>>> transitions in the low-order portion (the TCP sequence number).
>>
>> snd_sne and rcv_sne are the upper 4 bytes of extended SEQ number.
>> Unfortunately, reading two 4-bytes pointers can't be performed
>> atomically (without synchronization).
>>
>> Let's keep it KISS and add an rwlock - that shouldn't create much
>> contention as SNE are updated every 4Gb of traffic and the atomic region
>> is quite small.
>>
>> Fixes: 64382c71a557 ("net/tcp: Add TCP-AO SNE support")
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  include/net/tcp_ao.h |  2 +-
>>  net/ipv4/tcp_ao.c    | 34 +++++++++++++++++++++-------------
>>  net/ipv4/tcp_input.c | 16 ++++++++++++++--
>>  3 files changed, 36 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
>> index 647781080613..beea3e6b39e2 100644
>> --- a/include/net/tcp_ao.h
>> +++ b/include/net/tcp_ao.h
>> @@ -123,6 +123,7 @@ struct tcp_ao_info {
>>  	 */
>>  	u32			snd_sne;
>>  	u32			rcv_sne;
>> +	rwlock_t		sne_lock;
> 
> RW lock are problematic in the networking code, see commit
> dbca1596bbb08318f5e3b3b99f8ca0a0d3830a65.

Thanks, was not aware of this pitfall.

> I think you can use a plain spinlock here, as both read and write
> appears to be in the fastpath (?!?)

Yeah, I wanted to avoid to RX concurrency here as writing happens only
once in 4Gb. I'll take another attempt to prevent that in v3.

>> @@ -781,8 +780,10 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
>>  		*traffic_key = snd_other_key(*key);
>>  		rnext_key = READ_ONCE(ao_info->rnext_key);
>>  		*keyid = rnext_key->rcvid;
>> -		*sne = tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sne),
>> -					  snd_basis, seq);
>> +		read_lock_irqsave(&ao_info->sne_lock, flags);
>> +		*sne = tcp_ao_compute_sne(ao_info->snd_sne,
>> +					  READ_ONCE(*snd_basis), seq);
>> +		read_unlock_irqrestore(&ao_info->sne_lock, flags);
> 
> Why are you using the irqsave variant? bh should suffice.

It should, yes :)

> 
> Cheers,
> 
> Paolo
> 

Thanks,
             Dmitry


