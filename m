Return-Path: <netdev+bounces-164926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB585A2FB20
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 21:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E26C1669BC
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1D41B4148;
	Mon, 10 Feb 2025 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKimG2Ow"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA32264609
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739220888; cv=none; b=bWJQ9JQl4cGUSKqJtCQK9YSw3lvsNr/hZpG2VNmyOmHUWQc+Bk/+9KWTJCkMHurLmJUob8kiGwz7HJ/G05kMGoxL00vz3SPn+esLCrsCrkz55KPEMn/Hv4KueKYEWtCp0/uD6N0W1AF9kaGnJDPDGdQHKHeK6VnT6MCMV9tpt4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739220888; c=relaxed/simple;
	bh=wRIktLVq+YdRJowlsMZLWHOC6g8CV3RYo/Slb89jV7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9q4mwfgSUKL81PzUiEdy9p0yyRBVzLLiB7WSKihMSRzLw60OGIuBH8LddxmGPJhxg6I4MBwJOHTkmIVINN+vQG3b5y9eq0IuJHrKeMncZaa1Xjd2gH07fyYFa4isNKx0z5qpTXIAmLZOJOQci+U9rwtcciQSxmNx3zXbpLmcik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKimG2Ow; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739220885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUL3tjdAHMcyzN4zBhxzlbXW7WE/Kkr0fWW8kSoJ3M0=;
	b=aKimG2OwMMHgk+Nsl4wLQiNUwK9IccZIN02BFRnjw36NuKdasSp9+EWIBhRLajdr5+DGvh
	zzHQPXwG6DQDN8BZO1JHtIrGybdDt28xr+/BRwxv4VEmpUGvSyZM8dmZ+puWWGqw++hlqH
	WnsrlfJpmhAShxWgbNzR6M5zCdJq3zs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-nKE9gmEsNXqmaLjA4VllGw-1; Mon, 10 Feb 2025 15:54:43 -0500
X-MC-Unique: nKE9gmEsNXqmaLjA4VllGw-1
X-Mimecast-MFC-AGG-ID: nKE9gmEsNXqmaLjA4VllGw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dafe1699cso3201287f8f.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739220882; x=1739825682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUL3tjdAHMcyzN4zBhxzlbXW7WE/Kkr0fWW8kSoJ3M0=;
        b=U1GbeIMCgs6I8O984CNZ3izkVl+AqcLmVVSeJjhHFGR55vkz4L0KtDFCu3DcTYsgfI
         sN0l2pThQkOiC773Ary4qIyuMx7D1d21RgtY2MOGaA7SKNalmuNPT7Wv3HUbMFMNwALs
         3xlQ6Aq0S8hq0m0rT9qlBioFm9vTmEwV7dafj4gkNgwzSQYI+QIWF9kw/D3yvUjlQ5o7
         XFuwqxmA7DtqoBWfuVnHZRQAH79PVVcGvG194yyCBV4ViqejdNG83mmBz2F+FXWUM2oV
         ZI3v1voT4mMb1eZXyJoyHPPY24iWIJCJz5g5rkucjJ5eAIxkRGtZN79ZseNRL1fJiwUj
         CHKg==
X-Gm-Message-State: AOJu0YwcjEBNlGOXIhJo56mcJ3kxU/fNb+16JNs0LTRBdS8Xhcw8K+/S
	s6IynMs8tuWEX8EjuDDxv0YZb1vvFXmJZYAyM6JudDnk/SF8IDADFUgjxxcvn2SdVBVACfmvBIZ
	/rE1STbQqsqRuTzqsZp1B6aTKeDn81DCpiV8AL5P9rcQagCP9FdKBDA==
X-Gm-Gg: ASbGnctiKT0W6VkCIVzxzPEe0zBhzdNvV8G7RyK3APRuDp7DBwFnBGcM+KEI+kbQeLp
	8dKM/ramIem0nX+45XUbxPVUg7gNSO5C1Olv3f+PgnJD7V1octp2nisOGW7M/nvmoVjBcbCeQaG
	3QLKjvgFh7m4PMP5RIq60xgKwhigOQJ9OXLcVbo9KgDFxgJJsmvYmFfk0HjM1PzdQVyB3Vn/SQz
	6ZzSVVzaup49zqBZAjdQwA2Sd/uMT0xeKqFpMK4EZolZHUw8tc8HO9tFNZ+yDSQTLlOI4TLLQqL
	9AfL/Ym/rzmnUsPAbmAqkIVGkgfdAr3yb8g=
X-Received: by 2002:a05:6000:1889:b0:38d:cab2:921a with SMTP id ffacd0b85a97d-38dcab294b5mr11445005f8f.1.1739220882669;
        Mon, 10 Feb 2025 12:54:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7ymYeJaWDwWKlTSihvo41rIjuNYQ2OW1UEHPV8PRQaG9zgiJ3QMfNF2O7lriDdGRImB/lGQ==
X-Received: by 2002:a05:6000:1889:b0:38d:cab2:921a with SMTP id ffacd0b85a97d-38dcab294b5mr11444992f8f.1.1739220882326;
        Mon, 10 Feb 2025 12:54:42 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd0d3120fsm8735485f8f.70.2025.02.10.12.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 12:54:41 -0800 (PST)
Message-ID: <1cc7d4f5-8004-43d4-b401-fdaebcf87b45@redhat.com>
Date: Mon, 10 Feb 2025 21:54:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] udp: avoid false sharing on sk_tsflags
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>
References: <cover.1738940816.git.pabeni@redhat.com>
 <67a979c156cbe_14761294f6@willemb.c.googlers.com.notmuch>
 <CANn89i+G_Zeqhjp24DMNXj32Z4_vCt8dTRiZ12ChNjFaYKvGDA@mail.gmail.com>
 <1d8801d4-73a9-4822-adf9-20e6c5a6a25c@redhat.com>
 <CANn89iLaDEjuDAE-Bupi4iDjt4wa90NA8bRjH8_0qWOQpHJ98Q@mail.gmail.com>
 <67aa3d2d6df73_6ea21294e6@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67aa3d2d6df73_6ea21294e6@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/10/25 6:53 PM, Willem de Bruijn wrote:
> Eric Dumazet wrote:
>> On Mon, Feb 10, 2025 at 5:16 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>
>>> On 2/10/25 4:13 PM, Eric Dumazet wrote:
>>>> On Mon, Feb 10, 2025 at 5:00 AM Willem de Bruijn
>>>> <willemdebruijn.kernel@gmail.com> wrote:
>>>>>
>>>>> Paolo Abeni wrote:
>>>>>> While benchmarking the recently shared page frag revert, I observed a
>>>>>> lot of cache misses in the UDP RX path due to false sharing between the
>>>>>> sk_tsflags and the sk_forward_alloc sk fields.
>>>>>>
>>>>>> Here comes a solution attempt for such a problem, inspired by commit
>>>>>> f796feabb9f5 ("udp: add local "peek offset enabled" flag").
>>>>>>
>>>>>> The first patch adds a new proto op allowing protocol specific operation
>>>>>> on tsflags updates, and the 2nd one leverages such operation to cache
>>>>>> the problematic field in a cache friendly manner.
>>>>>>
>>>>>> The need for a new operation is possibly suboptimal, hence the RFC tag,
>>>>>> but I could not find other good solutions. I considered:
>>>>>> - moving the sk_tsflags just before 'sk_policy', in the 'sock_read_rxtx'
>>>>>>   group. It arguably belongs to such group, but the change would create
>>>>>>   a couple of holes, increasing the 'struct sock' size and would have
>>>>>>   side effects on other protocols
>>>>>> - moving the sk_tsflags just before 'sk_stamp'; similar to the above,
>>>>>>   would possibly reduce the side effects, as most of 'struct sock'
>>>>>>   layout will be unchanged. Could increase the number of cacheline
>>>>>>   accessed in the TX path.
>>>>>>
>>>>>> I opted for the present solution as it should minimize the side effects
>>>>>> to other protocols.
>>>>>
>>>>> The code looks solid at a high level to me.
>>>>>
>>>>> But if the issue can be adddressed by just moving a field, that is
>>>>> quite appealing. So have no reviewed closely yet.
>>>>>
>>>>
>>>> sk_tsflags has not been put in an optimal group, I would indeed move it,
>>>> even if this creates one hole.
>>>>
>>>> Holes tend to be used quite fast anyway with new fields.
>>>>
>>>> Perhaps sock_read_tx group would be the best location,
>>>> because tcp_recv_timestamp() is not called in the fast path.
>>>
>>> Just to wrap my head on the above reasoning: for UDP such a change could
>>> possibly increase the number of `struct sock` cache-line accessed in the
>>> RX path (the `sock_write_tx` group should not be touched otherwise) but
>>> that will not matter much, because we expect a low number of UDP sockets
>>> in the system, right?
>>
>> Are you referring to UDP applications needing timestamps ?
>>
>> Because sk_tsflags is mostly always used in TX
> 
> I thought the issue on rx was with the test in sock_recv_cmsgs.

Yes, the critical bits in my tests are in sock_recv_cmsgs(): such
function touches sk->sk_tsflags unconditionally on each recvmsg call.

/P


