Return-Path: <netdev+bounces-208649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FA3B0C87D
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 18:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80FA1681F3
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7756205E26;
	Mon, 21 Jul 2025 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRZ8N+ps"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3416A1F5834
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753114657; cv=none; b=uUHKrC9a4g7IPzOaNwFBzW5CIDYtKZciyZRvDTM/+USuMegUbqcUKs58LqpqtaEb+WPbbDF0v9SbrknCqjjR5B4dl9uQrjr96Y9xoiGQ211TD3gWjxPigoL7wZ9fDYhRMWZZlKR63vqxFxgQpuPk+uf6U55Mz98xujzkSRQMktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753114657; c=relaxed/simple;
	bh=fwv5H/Io0ydPlEB6QDN1RAfsQ3KsKiaX6o7bG+kYmEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMHe7OpcT0pMbXgL4tikk8eJ/a9vk8LpqvxM77qcAK/K+Ji5lAYwneTj4TDWATzdnFjs+U0LZhyXeDQDLhf+Rzr6FZD4MgxqFeubyHRbSSbYPmvov1EuQk8RQqbBIhkyIYULVbm1hPNhJySYzOOw6siP8gAF7U6CSPkYZ/49TV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cRZ8N+ps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753114654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ovrmvUv5UZX43qqZLj6iuFt06QVDpvYJAVq9IaEEx0=;
	b=cRZ8N+psDk1P9OHAyLKAqnPIZo39k1xvSSqMNYY8ODybXJYxy7Ik34bwKwaN6OGvLjIg7B
	91cbJLYIAd8EPqGHv89knYcmXVRlqmmCmbZ95uF3M1b8FTwmWdhf28wB1JvykBBOnFtJ2Z
	64O/KbkxmgPP36Au6+JD+0wwxi/edZw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Ih12SUyuPEK5-cdc6dIo3g-1; Mon, 21 Jul 2025 12:17:32 -0400
X-MC-Unique: Ih12SUyuPEK5-cdc6dIo3g-1
X-Mimecast-MFC-AGG-ID: Ih12SUyuPEK5-cdc6dIo3g_1753114652
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b20f50da27so2189843f8f.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 09:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753114651; x=1753719451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ovrmvUv5UZX43qqZLj6iuFt06QVDpvYJAVq9IaEEx0=;
        b=xLA9l1Vh6uo1AKaKEXM5RMr1Le6Gzt4delSuDinQwqdyDgBfs5ogO12vSzbl1oGTSI
         5P03sDhzkk7Nb7XQOel3dy4YodDiLWQ8UVvv08K05Yn07cXw9ihO4gH5bCX9iKwYeJjb
         IhJvgz6MtyGZ5lgOiwtGd6XG3KEJ6R7CjC6ObQOV2KuLr6aLj/olPPquG4jnUJ8M2Zja
         bGmNe5Q4WptQ24sfBs3B3oM5dY3G6VOh9qlEZToM3RfDd/5r9DhDe9igdtlYJvVXr+cp
         KFO4o7id5UhiWt7gHu5l82rT21WWq9NA8QIER62gm/LrZNkYQP1/io3p6pM3zDD9zk+O
         512A==
X-Gm-Message-State: AOJu0YynfqU6unZSiTjSPAvBzTxZO1m1qWXRbcXGMc+ekmCpBHctdmGv
	lBQQN6Nkt6pk02Pys7OailCsrKgx4PfIZhz9MjO+yME4607piajPxXzgK9zhtMuC5V4tR72unfz
	pyxq3/qyWUVj6ecuBz2hRvg62r1EBmcBTGdgJXPSzKWR182ggMb8UA+NRsg==
X-Gm-Gg: ASbGncviGlCke0PcwJg2P63Dh5ME9vPh4W6wYvzTsQVgbJcQo1wEoAxO27wp1T4u3YY
	d9XRk+bgxfyfVO+7O5oRhAUvGYDWUme8xU/dCl2iHGPlPcqb0rUjJT7/ZwG10ebG0+EgQ/ZGZ5k
	2oTmWY+xIL9QAtVuuDHd1uizRRd6yLIHXXULgEXWxY+zwjz8PCnTQjb4wv4qsXCtEX4ABlWZ2jo
	p7bBO1PG2pWsAtxjY06Kb3HcT6SS2YI0eVAvifkfV9U+R6rrCFibJ55zE1laiuI7LmKyLrkncN7
	vQ76gT1Jfr4MSC1TpNIhkb/BjfeJi8b34toiVvUmXnFvG9X+0G0LyoZCpEjLzLJHkJHMBmEOek8
	/hYfduiynJBs=
X-Received: by 2002:a05:6000:2382:b0:3b7:5a57:edf2 with SMTP id ffacd0b85a97d-3b7634edfacmr144746f8f.20.1753114651350;
        Mon, 21 Jul 2025 09:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq6kYqjrT2QenFGgBTrntQaZWis1tg0Ki3G9FMyGsTDi/Dci66bx+nIQe7P3XVkygsGhw7Yg==
X-Received: by 2002:a05:6000:2382:b0:3b7:5a57:edf2 with SMTP id ffacd0b85a97d-3b7634edfacmr144706f8f.20.1753114650793;
        Mon, 21 Jul 2025 09:17:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca25443sm10939178f8f.9.2025.07.21.09.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 09:17:30 -0700 (PDT)
Message-ID: <cc1cb5c2-9652-4b01-9008-22965685b73b@redhat.com>
Date: Mon, 21 Jul 2025 18:17:29 +0200
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
 <1d78b781-5cca-440c-b9d0-bdf40a410a3d@redhat.com>
 <CANn89iLwpjs7-1qZ+wvFsav_Th9_PJvHvgfWPhz3wxUJwRx70Q@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLwpjs7-1qZ+wvFsav_Th9_PJvHvgfWPhz3wxUJwRx70Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/25 5:21 PM, Eric Dumazet wrote:
> On Mon, Jul 21, 2025 at 7:56 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 7/21/25 3:52 PM, Eric Dumazet wrote:
>>> On Mon, Jul 21, 2025 at 6:32 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>> On 7/21/25 2:30 PM, Eric Dumazet wrote:
>>>>> On Mon, Jul 21, 2025 at 3:50 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>>>> On 7/21/25 10:04 AM, Eric Dumazet wrote:
>>>>>>> On Fri, Jul 18, 2025 at 10:25 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>>>>>>
>>>>>>>> The nipa CI is reporting frequent failures in the mptcp_connect
>>>>>>>> self-tests.
>>>>>>>>
>>>>>>>> In the failing scenarios (TCP -> MPTCP) the involved sockets are
>>>>>>>> actually plain TCP ones, as fallback for passive socket at 2whs
>>>>>>>> time cause the MPTCP listener to actually create a TCP socket.
>>>>>>>>
>>>>>>>> The transfer is stuck due to the receiver buffer being zero.
>>>>>>>> With the stronger check in place, tcp_clamp_window() can be invoked
>>>>>>>> while the TCP socket has sk_rmem_alloc == 0, and the receive buffer
>>>>>>>> will be zeroed, too.
>>>>>>>>
>>>>>>>> Pass to tcp_clamp_window() even the current skb truesize, so that
>>>>>>>> such helper could compute and use the actual limit enforced by
>>>>>>>> the stack.
>>>>>>>>
>>>>>>>> Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
>>>>>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>>>>>> ---
>>>>>>>>  net/ipv4/tcp_input.c | 12 ++++++------
>>>>>>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>>>>>>> index 672cbfbdcec1..c98de02a3c57 100644
>>>>>>>> --- a/net/ipv4/tcp_input.c
>>>>>>>> +++ b/net/ipv4/tcp_input.c
>>>>>>>> @@ -610,24 +610,24 @@ static void tcp_init_buffer_space(struct sock *sk)
>>>>>>>>  }
>>>>>>>>
>>>>>>>>  /* 4. Recalculate window clamp after socket hit its memory bounds. */
>>>>>>>> -static void tcp_clamp_window(struct sock *sk)
>>>>>>>> +static void tcp_clamp_window(struct sock *sk, int truesize)
>>>>>>>
>>>>>>>
>>>>>>> I am unsure about this one. truesize can be 1MB here, do we want that
>>>>>>> in general ?
>>>>>>
>>>>>> I'm unsure either. But I can't think of a different approach?!? If the
>>>>>> incoming truesize is 1M the socket should allow for at least 1M rcvbuf
>>>>>> size to accept it, right?
>>>>>
>>>>> What I meant was :
>>>>>
>>>>> This is the generic point, accepting skb->truesize as additional input
>>>>> here would make us more vulnerable, or we could risk other
>>>>> regressions.
>>>>
>>>> Understood, thanks for the clarification.
>>>>
>>>>> The question is : why does MPTCP end up here in the first place.
>>>>> Perhaps an older issue with an incorrectly sized sk_rcvbuf ?
>>>>
>>>> I collected a few more data. The issue happens even with plain TCP
>>>> sockets[1].
>>>>
>>>> The relevant transfer is on top of the loopback device. The scaling_rate
>>>> rapidly grows to 254 - that is `truesize` and `len` are very near.
>>>>
>>>> The stall happens when the received get in a packet with a slightly less
>>>> 'efficient' layout (in the experiment I have handy len is 71424,
>>>> truesize 72320) (almost) filling the receiver window.
>>>>
>>>> On such input, tcp_clamp_window() shrinks the receiver buffer to the
>>>> current rmem usage. The same happens on retransmissions until rcvbuf
>>>> becomes 0.
>>>>
>>>> I *think* that catching only the !sk_rmem_alloc case would avoid the
>>>> stall, but I think it's a bit 'late'.
>>>
>>> A packetdrill test here would help understanding your concern.
>>
>> I fear like a complete working script would take a lot of time, let me
>> try to sketch just the relevant part:
>>
>> # receiver state is:
>> # rmem=110592 rcvbuf=174650 scaling_ratio=253 rwin=63232
>> # no OoO data, no memory pressure,
>>
>> # the incoming packet is in sequence
>> +0 > P. 109297:172528(63232) ack 1
>>
>> With just the 0 rmem check in tcp_prune_queue(), such function will
>> still invoke tcp_clamp_window() that will shrink the receive buffer to
>> 110592.
> 
> As long as an ACK is sent back with a smaller RWIN, I think this would
> be reasonable in this case.

I fear some possible regression, as the sender will see some unexpected
drops, even on loopback and while not misbehaving.

But I tested your proposed code here and AFAICS solves the issue and I
could not spot anything suspicious so far.

So I'll send a v2 using that.

Thanks!

Paolo


