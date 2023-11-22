Return-Path: <netdev+bounces-49851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB527F3AF3
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB5E280EAC
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6941B15A5;
	Wed, 22 Nov 2023 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="RC2EL6F5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2C1AA
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 17:00:12 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32fdc5be26dso3923441f8f.2
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 17:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700614810; x=1701219610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7z/Ncze8VsxsQV1/X1aHBHLUuutXLztntTa5pi1dYLs=;
        b=RC2EL6F5X7lwgIY/nWSO438Mq/MuoWSvG6hDsB4jeubmsjh4fM/yY06uxFOdlikVvE
         KpRNYqiKHceHvxhtaLC1xJRqb7TBmLY4abEeya0s3Ai9p8bBrONPAVeNS8YfxTbiU2Jc
         Y1vvAAusBYtBs5ouYrqezB6mpgQjSYnoYlsfm956OIp37qOAecbUrt0SdwPQSBBBQttG
         dFCf8AKNWkueGRvS0Ip1+AnSNsf+hk9D4utd0fbSFEoD+KoHdSLBJZLdAX36yHfd8cCh
         iKC19BYsULHSd3j3JkXayYdsho046FC0drigacJn/VYEaDqyjQlrHukDHhwIq86RgK/Z
         4guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700614810; x=1701219610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7z/Ncze8VsxsQV1/X1aHBHLUuutXLztntTa5pi1dYLs=;
        b=B9JwIoL7FohFmR/a8LAGZH/Qkr9vRAKU3+ao6D5q/pBP3dDh3FGzS1Hie6dlUm56cG
         CnS6GMfPz09kP3xCcqLamj+gWK0uUZM0T9I0MElnGgp7iV06R/obE8CZyy2mQVtXa7pa
         7myJKu6O6oGFoFMzyEgbX/EiKIkXZ3ZC3/pYpY4IpsxO05RyK9+PjSIsin0s5Fa+Km80
         FWUL3x1bcf7hem9q0SIbHv/hxN0nQ9vkpUFuV4DcT1irYkRxURX1D0YNg4CySFf7yBdv
         5khsrYV3lCDHk1Hn8ZMmZqxurbuCn6fMnqLV7CvZHbz9cWf8H2jALSXuUzMM0qcXp+ub
         Vu5Q==
X-Gm-Message-State: AOJu0Yw0LAAyZdBdaAt2h/pm9Eda1+fVfDkk18robzLiuIqDkW/IN5FI
	XdlhYAFP1LDMFWJ16xQwaq1ngw==
X-Google-Smtp-Source: AGHT+IGWfqttaUh7V6lCiHLkEQqnJfYw1U5++qE0LNe7r9fT0KxEwUqIRkLzKCuyF/8jxNnoVwJbzw==
X-Received: by 2002:a5d:56c4:0:b0:32d:9a8f:6245 with SMTP id m4-20020a5d56c4000000b0032d9a8f6245mr341419wrw.68.1700614810074;
        Tue, 21 Nov 2023 17:00:10 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l26-20020a05600c1d1a00b004067e905f44sm377388wms.9.2023.11.21.17.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 17:00:09 -0800 (PST)
Message-ID: <85e84d97-af6d-47e7-b188-0ee000c4ee8c@arista.com>
Date: Wed, 22 Nov 2023 01:00:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] net/tcp: Reset TCP-AO cached keys on listen() syscall
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
 Francesco Ruggeri <fruggeri05@gmail.com>,
 Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20231121020111.1143180-1-dima@arista.com>
 <20231121020111.1143180-5-dima@arista.com>
 <CANn89i+xvBQY5HLXNkjW0o9R4SX1hqRisJnr54ZqwuOpEJdHeA@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89i+xvBQY5HLXNkjW0o9R4SX1hqRisJnr54ZqwuOpEJdHeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/21/23 08:18, Eric Dumazet wrote:
> On Tue, Nov 21, 2023 at 3:01 AM Dmitry Safonov <dima@arista.com> wrote:
>>
>> TCP_LISTEN sockets are not connected to any peer, so having
>> current_key/rnext_key doesn't make sense.
>>
>> The userspace may falter over this issue by setting current or rnext
>> TCP-AO key before listen() syscall. setsockopt(TCP_AO_DEL_KEY) doesn't
>> allow removing a key that is in use (in accordance to RFC 5925), so
>> it might be inconvenient to have keys that can be destroyed only with
>> listener socket.
> 
> I think this is the wrong way to solve this issue. listen() should not
> mess with anything else than socket state.
> 
>>
>> Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
[..]
>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>> index fb81de10d332..a08d1266344f 100644
>> --- a/net/ipv4/af_inet.c
>> +++ b/net/ipv4/af_inet.c
>> @@ -200,6 +200,7 @@ int __inet_listen_sk(struct sock *sk, int backlog)
>>          * we can only allow the backlog to be adjusted.
>>          */
>>         if (old_state != TCP_LISTEN) {
>> +               tcp_ao_listen(sk);
> 
> Ouch...
> 
> Please add your hook in tcp_disconnect() instead of this layering violation.
> 
> I think you missed the fact that applications can call listen(fd,
> backlog) multiple times,
> if they need to dynamically adjust backlog.

Hmm, unsure, I've probably failed at describing the issue or failing to
understand your reply :-)

Let me try again:
1. sk = socket(AF_*, SOCK_STREAM, IPPROTO_TCP)
2. setsockopt(sk, TCP_AO_ADD_KEY, ...) - adding a key to use later
3. setsockopt(sk, IPPROTO_TCP, TCP_AO_INFO, set_current=1) - could be
   done straight on adding a key at (2), but for an example, explicitely
4.a. connect(sk, peer) - all as expected, the current key will be the
     one that is used for SYN (and ending ACK if the peer doesn't
     request to switch)
4.b  listen(sk, ...) - userspace shoots itself in foot: the current_key
     has no usage on TCP_LISTEN, so it just "hangs" as a pointer until
     the socket gets destroyed.

An alternative fix would be to make setsockopt(TCP_AO_DEL_KEY) remove a
key even if it's current_key on TCP_LISTEN, re-setting that to NULL.

Now as I described, somewhat feeling like the alternative fix sounds
better. Will proceed with that for v2.

Thanks,
             Dmitry


