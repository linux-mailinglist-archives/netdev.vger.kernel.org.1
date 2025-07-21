Return-Path: <netdev+bounces-208612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D48CB0C53D
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570A117EC40
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68AB191F92;
	Mon, 21 Jul 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wd3+3m4X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73E847F4A
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104746; cv=none; b=JWPywTyBAlGOxlso6qrlhAK8GmbC9b/v1iJyw3gSk//Q3wq95wpj/lqHwkjPqS1Ong83SdHNcQ4aENzqyUUNDmAV4jgSZVQazVKsXIMEVIr8GxxHwBValiRexexLN/8oRe8vdOn7C88mGrRMwjDCfLORWjuguG8fILrZfLsNjQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104746; c=relaxed/simple;
	bh=sL/WSEaLvUvXoFA0Bk5OKzRJTaW/F8v/BbslWje6YiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHbFY8GiBYjQCGjAOsDrjCEeMKmvvO0wbClf9g60C7nB6rjvkn5Un82F2x0XxkIQlP7h0RkJI/ycSIRvMhbExE24YMnuSX25L7bkkW+JDAVzR8X6hJ2MWivtFB5ardc9VTRqrwwM5cPnM2OkoyBpPEhfuUz8eZqT3F/pmhhFgxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wd3+3m4X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753104744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zndILsIpeYd+Oj83BYP5FYO7Mz/Z3y71Bx4P/KT11Fw=;
	b=Wd3+3m4XlR4ZyoEfAKm/J05F3uEzTEgO5VovwaMu9LJ+ka2wU86Ryym5RemnUE71V7syXj
	AiDRTemzPfS21sqDamxIApRYU2uaOtQdbT1V37iY3Mp+hisyoEwSzy5nbe/sRATUouO/b0
	LxibbiamHzdigr3dt3qZvfVbju0csTA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-XsRjmakPPPiyLmVpOQaWjQ-1; Mon, 21 Jul 2025 09:32:19 -0400
X-MC-Unique: XsRjmakPPPiyLmVpOQaWjQ-1
X-Mimecast-MFC-AGG-ID: XsRjmakPPPiyLmVpOQaWjQ_1753104739
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45526e19f43so17268425e9.3
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 06:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753104738; x=1753709538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zndILsIpeYd+Oj83BYP5FYO7Mz/Z3y71Bx4P/KT11Fw=;
        b=T/CmouOPgYg4uwW25TiJNPQrSV2fQguIu9fiycOy5H3UWO3ZYkdd+yqX1OZzn13O0c
         1/UyZ4Pyizh6FrWPDNroPkJeU/csvZQLOJ644xzKRBXQHJPghVlREw3o5G30GPRESd7O
         /+VIvDDhKovZENLtRB/E3uxFHm0ZxZHV/Wd9fXvV06JTXyaTUudKchlnF1MWYiNsPfC4
         QBh/YVTLIXx2Hce0aJzP5k18Bc/RqGl6u4e6RZADCWhLnhojBEwrj8pne2UyIhVx63yY
         q3i9PHClzyaRvEaAOMnnlT7+cAcfxVyVogNATKfae/oukAjJfp4p8vZp5E2iXKUI3D7n
         FBkg==
X-Gm-Message-State: AOJu0Yx/AGRymFrHzM5mQZZstpGBOReT+swEI89orMdB1N4LunejnOAe
	t4W2bbYGjvokfNDXVxMLl2fU9n9iD9EQC13+InO59MPcUG1LHzrUKoxsiK4yiZjbbrPJWL3l0je
	nru8hBNm2dQXvymVaSr2ujxqranHSl9VUY+IupPM0B6GMOMDNzRld1M7YPQ==
X-Gm-Gg: ASbGncsdmOW8lGQbRSeSz6tfYlRt4Qg/3IWJsZT/Atqs4L+hkMtmBCrCBct+lmXPDbO
	1QVjpJa6u0IuUq/QWHhuVhFNLhOdEs1jYo/vhlWtQicw5w2wLS4wItegvSX8ONnvR6Qi/vz+/xY
	nwTXFxZQ9avmEc68IDXQLZNBDTbBcWU6V99CmxA0GxLe3IOOF75Ki98EnpuRYB+IUesKvM7mvYB
	zwreKA32SE06DkmQ+9u8d14jwF1lgulHnuxrjnjBK88j7SYghYCqzKsbZM2c05Gh8VUMMTTRM+m
	DjWVps0UIrLw/ntYrIRBy2milB2BPGy36wwWDzLeAEsaE0tG8P0tDZuYx4jlat25+fGledUvKjg
	MTD0a6zNDsX0=
X-Received: by 2002:a05:600c:6298:b0:442:e9eb:1b48 with SMTP id 5b1f17b1804b1-4563b8f6167mr99357855e9.24.1753104738400;
        Mon, 21 Jul 2025 06:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExnLjbn9CK0DDuUcxcpA72LDIS2FZ7EhyyitaDg8Q6kjgRnaCac6i1PNNl3OYldlLIienvqQ==
X-Received: by 2002:a05:600c:6298:b0:442:e9eb:1b48 with SMTP id 5b1f17b1804b1-4563b8f6167mr99357485e9.24.1753104737901;
        Mon, 21 Jul 2025 06:32:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75ca42sm99007245e9.31.2025.07.21.06.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 06:32:17 -0700 (PDT)
Message-ID: <ebc7890c-e239-4a64-99af-df5053245b28@redhat.com>
Date: Mon, 21 Jul 2025 15:32:16 +0200
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89i+baSpvbJM6gcbSjZMmWVyvwsFotvH1czui9ARVRjS5Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/25 2:30 PM, Eric Dumazet wrote:
> On Mon, Jul 21, 2025 at 3:50 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 7/21/25 10:04 AM, Eric Dumazet wrote:
>>> On Fri, Jul 18, 2025 at 10:25 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>>
>>>> The nipa CI is reporting frequent failures in the mptcp_connect
>>>> self-tests.
>>>>
>>>> In the failing scenarios (TCP -> MPTCP) the involved sockets are
>>>> actually plain TCP ones, as fallback for passive socket at 2whs
>>>> time cause the MPTCP listener to actually create a TCP socket.
>>>>
>>>> The transfer is stuck due to the receiver buffer being zero.
>>>> With the stronger check in place, tcp_clamp_window() can be invoked
>>>> while the TCP socket has sk_rmem_alloc == 0, and the receive buffer
>>>> will be zeroed, too.
>>>>
>>>> Pass to tcp_clamp_window() even the current skb truesize, so that
>>>> such helper could compute and use the actual limit enforced by
>>>> the stack.
>>>>
>>>> Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>> ---
>>>>  net/ipv4/tcp_input.c | 12 ++++++------
>>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>>> index 672cbfbdcec1..c98de02a3c57 100644
>>>> --- a/net/ipv4/tcp_input.c
>>>> +++ b/net/ipv4/tcp_input.c
>>>> @@ -610,24 +610,24 @@ static void tcp_init_buffer_space(struct sock *sk)
>>>>  }
>>>>
>>>>  /* 4. Recalculate window clamp after socket hit its memory bounds. */
>>>> -static void tcp_clamp_window(struct sock *sk)
>>>> +static void tcp_clamp_window(struct sock *sk, int truesize)
>>>
>>>
>>> I am unsure about this one. truesize can be 1MB here, do we want that
>>> in general ?
>>
>> I'm unsure either. But I can't think of a different approach?!? If the
>> incoming truesize is 1M the socket should allow for at least 1M rcvbuf
>> size to accept it, right?
> 
> What I meant was :
> 
> This is the generic point, accepting skb->truesize as additional input
> here would make us more vulnerable, or we could risk other
> regressions.

Understood, thanks for the clarification.

> The question is : why does MPTCP end up here in the first place.
> Perhaps an older issue with an incorrectly sized sk_rcvbuf ?

I collected a few more data. The issue happens even with plain TCP
sockets[1].

The relevant transfer is on top of the loopback device. The scaling_rate
rapidly grows to 254 - that is `truesize` and `len` are very near.

The stall happens when the received get in a packet with a slightly less
'efficient' layout (in the experiment I have handy len is 71424,
truesize 72320) (almost) filling the receiver window.

On such input, tcp_clamp_window() shrinks the receiver buffer to the
current rmem usage. The same happens on retransmissions until rcvbuf
becomes 0.

I *think* that catching only the !sk_rmem_alloc case would avoid the
stall, but I think it's a bit 'late'. I'm unsure if we could
preventing/forbidding 'too high' values of scaling_rate? (also I'm
unsure where to draw the line exactly.

Cheers,

Paolo


[1] You can run the relevant test by adding '-t' on the mptcp_connect.sh
command line, but it will take a lot of time to run the 10-20 iterations
I need to observe the issue. To make it faster I manually trimmed the
not relevant test-cases.


