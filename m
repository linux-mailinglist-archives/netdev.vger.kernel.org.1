Return-Path: <netdev+bounces-208630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A35B0C707
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9BC542A7D
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398EF2C327C;
	Mon, 21 Jul 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYxXAPaj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7246B292B3E
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109774; cv=none; b=R+N0p4yXUSoNmNmA6hPgtHFCH4C7kunu0Dmjo5e7RWTc+/HN5IgPS8ISY4j5VFU2m7TknEvcn9FxhARPuNdAk6N23zTJ5Y91qsU9oPUU94nkOJNWQH1KCZH8WJx1UdPJEb2chXSjEH6u3yMG6EnkVn9MvrZ6Q6mnOJOYxxIVHk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109774; c=relaxed/simple;
	bh=wSilg8p3/DlynqY12KlK3TSKPRHqN+p1JeLpljyqKq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/i6vXPmSOiglNiYknaZtb0rSrkmBzsfoRm2+x3KK6IiRYHU6Gje78ggcgM8hfjK6WJ+ezMQR9ext4RHw42zbr2AyYLnX9dHkg/hebiHuSsny+Ta3a+/vs2m7XEE9O4/NuDMmp2L/pStZyX9L7VMx01ReGV/ZjbMPcHfPK1HacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYxXAPaj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753109771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6IYommNo2zAzsmd3C7VaC0iDrAAB9j0D+lA0wbyx3l0=;
	b=dYxXAPajRPf3if93qLu9Htin7CGheEIXzY/k7Ek+LL5tL47ZxhRr4yW1cDhfL4Y3N+xaSg
	AS0awGOPDE/Aj9n5dOv2+AsVey40YJ7BayZmE47d+cmjrOb2C+KDWJ/vb/CIClwWMr+D0p
	6JYust7z3Rl4IpWl52Lb/QhKwEzd9vk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-fM6LYMoCMLKGpKWktwUvrg-1; Mon, 21 Jul 2025 10:56:09 -0400
X-MC-Unique: fM6LYMoCMLKGpKWktwUvrg-1
X-Mimecast-MFC-AGG-ID: fM6LYMoCMLKGpKWktwUvrg_1753109769
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-456106b7c4aso23444005e9.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 07:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753109768; x=1753714568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IYommNo2zAzsmd3C7VaC0iDrAAB9j0D+lA0wbyx3l0=;
        b=wbYKHBtsWcPdeGlBl0CQAZ2fHE8k3u4laudyWdWHKBsvGMLhjeM1ze3fzjqjeGYDlo
         0QqQIMpiN3w98vMUPLznARgea3iwxTxobeQXFwmN3fk5/1DjbEOOmdapALA/Y5++X+fD
         C+bhK8JVwW9vvYvxKNRgsGsrnkcL54G3YTGwA6zE6rICuOJb34Kv9J8xcwr1MeypV3KO
         p8+U+AzVEEX/zfFmE/oGfLcxKk4e7nMmwqP5ibfA8nEDej/ZodOT9zPUgrEYy+L+i1QO
         0X3EtO73bGjW7GDViy0yxpoYFafFdlHFMbBZvIiBLr/CB4EaVQYnv942djzT+mMEFx8E
         yW7g==
X-Gm-Message-State: AOJu0YycGSOd7ixyG682qKgTONxHHJzvfjW+mugtYSd8gGfXt7M5AN/g
	pT3xJyPGF6RKRPECmN7hxLkSfQ0dbARonKkDoUyKzzH06rB2YKIiaazKAPnIcbxNTRyDkcVwS9W
	o4XbbdOloSpa7mh69LpZzx2DQAZGeLags8sJT3A0Q0l6mq2h0gclROfCoUw==
X-Gm-Gg: ASbGncsoh+b+iV2c3VLeRKlpjAtEJjj2oWro3qFSqZ4GXnfSGwPplt3rkAO2wkNcrbn
	KRjGPNzIIszl/d/656zB4JCfcHqz0UFo8VJJp0ZEHg9YYmVGPDtn2Jjz2rg+vIflta30T4NOefi
	Bd1arbQTsBMxw5pE99rZaA/n//BaobNjwFHnSnqbzv2COXVpXvEJp6TcZ69Fzj9bx/8/Wfw186v
	O5VjZXJinG0K+c3FbBVA5ytYa3NsYRvnQj39XuK6PwZ9kvrPO/EmIBLN0WYVX+MoStCwLTJm7rc
	qPPsAG68h45vR7XGxKqZv/LAFt+aqQHgLf8Ylf+oiYvY87v1Mw9Y3GZCYzf22HZTtWDXZoLeem9
	JxP/yBRPDaAw=
X-Received: by 2002:a05:600c:858d:b0:456:22f8:3aa1 with SMTP id 5b1f17b1804b1-4563a4fdbd5mr100365205e9.2.1753109768505;
        Mon, 21 Jul 2025 07:56:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjESv+S7Vy585K8qWirEKVqx3Gry6l859rO4TPWPAbh31y8UkluGc7qIrLLv9kn/BsazlPhw==
X-Received: by 2002:a05:600c:858d:b0:456:22f8:3aa1 with SMTP id 5b1f17b1804b1-4563a4fdbd5mr100364775e9.2.1753109767887;
        Mon, 21 Jul 2025 07:56:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586144f80asm6530305e9.1.2025.07.21.07.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 07:56:07 -0700 (PDT)
Message-ID: <1d78b781-5cca-440c-b9d0-bdf40a410a3d@redhat.com>
Date: Mon, 21 Jul 2025 16:56:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] tcp: do not set a zero size receive buffer
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Matthieu Baerts <matttbe@kernel.org>
References: <cover.1752859383.git.pabeni@redhat.com>
 <3e080bdba9981988ff86e120df40a5f0dc6cd033.1752859383.git.pabeni@redhat.com>
 <CANn89i+KCsw+LH1X1yzmgr1wg5Vxm47AbAEOeOnY5gqq4ngH4w@mail.gmail.com>
 <f8178814-cf90-4021-a3e2-f2494dbf982a@redhat.com>
 <CANn89i+baSpvbJM6gcbSjZMmWVyvwsFotvH1czui9ARVRjS5Bw@mail.gmail.com>
 <ebc7890c-e239-4a64-99af-df5053245b28@redhat.com>
 <CANn89iJeXXJV-D5g3+hqStM1sH0UZ3jDeZmOu9mM_E_i9ZYaeA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iJeXXJV-D5g3+hqStM1sH0UZ3jDeZmOu9mM_E_i9ZYaeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/25 3:52 PM, Eric Dumazet wrote:
> On Mon, Jul 21, 2025 at 6:32 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 7/21/25 2:30 PM, Eric Dumazet wrote:
>>> On Mon, Jul 21, 2025 at 3:50 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>> On 7/21/25 10:04 AM, Eric Dumazet wrote:
>>>>> On Fri, Jul 18, 2025 at 10:25 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>>>>
>>>>>> The nipa CI is reporting frequent failures in the mptcp_connect
>>>>>> self-tests.
>>>>>>
>>>>>> In the failing scenarios (TCP -> MPTCP) the involved sockets are
>>>>>> actually plain TCP ones, as fallback for passive socket at 2whs
>>>>>> time cause the MPTCP listener to actually create a TCP socket.
>>>>>>
>>>>>> The transfer is stuck due to the receiver buffer being zero.
>>>>>> With the stronger check in place, tcp_clamp_window() can be invoked
>>>>>> while the TCP socket has sk_rmem_alloc == 0, and the receive buffer
>>>>>> will be zeroed, too.
>>>>>>
>>>>>> Pass to tcp_clamp_window() even the current skb truesize, so that
>>>>>> such helper could compute and use the actual limit enforced by
>>>>>> the stack.
>>>>>>
>>>>>> Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
>>>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>>>> ---
>>>>>>  net/ipv4/tcp_input.c | 12 ++++++------
>>>>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>>>>> index 672cbfbdcec1..c98de02a3c57 100644
>>>>>> --- a/net/ipv4/tcp_input.c
>>>>>> +++ b/net/ipv4/tcp_input.c
>>>>>> @@ -610,24 +610,24 @@ static void tcp_init_buffer_space(struct sock *sk)
>>>>>>  }
>>>>>>
>>>>>>  /* 4. Recalculate window clamp after socket hit its memory bounds. */
>>>>>> -static void tcp_clamp_window(struct sock *sk)
>>>>>> +static void tcp_clamp_window(struct sock *sk, int truesize)
>>>>>
>>>>>
>>>>> I am unsure about this one. truesize can be 1MB here, do we want that
>>>>> in general ?
>>>>
>>>> I'm unsure either. But I can't think of a different approach?!? If the
>>>> incoming truesize is 1M the socket should allow for at least 1M rcvbuf
>>>> size to accept it, right?
>>>
>>> What I meant was :
>>>
>>> This is the generic point, accepting skb->truesize as additional input
>>> here would make us more vulnerable, or we could risk other
>>> regressions.
>>
>> Understood, thanks for the clarification.
>>
>>> The question is : why does MPTCP end up here in the first place.
>>> Perhaps an older issue with an incorrectly sized sk_rcvbuf ?
>>
>> I collected a few more data. The issue happens even with plain TCP
>> sockets[1].
>>
>> The relevant transfer is on top of the loopback device. The scaling_rate
>> rapidly grows to 254 - that is `truesize` and `len` are very near.
>>
>> The stall happens when the received get in a packet with a slightly less
>> 'efficient' layout (in the experiment I have handy len is 71424,
>> truesize 72320) (almost) filling the receiver window.
>>
>> On such input, tcp_clamp_window() shrinks the receiver buffer to the
>> current rmem usage. The same happens on retransmissions until rcvbuf
>> becomes 0.
>>
>> I *think* that catching only the !sk_rmem_alloc case would avoid the
>> stall, but I think it's a bit 'late'.
> 
> A packetdrill test here would help understanding your concern.

I fear like a complete working script would take a lot of time, let me
try to sketch just the relevant part:

# receiver state is:
# rmem=110592 rcvbuf=174650 scaling_ratio=253 rwin=63232
# no OoO data, no memory pressure,

# the incoming packet is in sequence
+0 > P. 109297:172528(63232) ack 1

With just the 0 rmem check in tcp_prune_queue(), such function will
still invoke tcp_clamp_window() that will shrink the receive buffer to
110592.
tcp_collapse() can't make enough room and the incoming packet will be
dropped. I think we should instead accept such packet.

Side note: the above data are taken from an actual reproduction of the issue

Please LMK if the above clarifies a bit my doubt or if a full pktdrill
is needed.

Thanks,

Paolo


