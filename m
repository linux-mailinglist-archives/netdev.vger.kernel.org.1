Return-Path: <netdev+bounces-132324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8E4991389
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 02:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB5E284237
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A144A24;
	Sat,  5 Oct 2024 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kYH20xbD"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444E5231C94
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728088631; cv=none; b=eUmzUJVaMWkGPtJKXUg9rlZ2IlmV0oSFoVemQch9Ir5FZqF4qo5t4Hjvn3McjPTuK7JAuMYdsc8Tq7afia8gqno38EpToZXxEcFzoygJDtSEpH0WS2L6xWziuadr55LX8T5UYcesqpzT16oN+v28uKSvjt8vT26yJq3bA8C5cJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728088631; c=relaxed/simple;
	bh=ye22A0Zj+B/zYoCuQv8vRffhP+216i6TJRLjOlZ8zGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIrqkdcKu8L4efTrsuJ572Y1AeG+iRkUoJSD61wAL/5X0KXlZ14UrZjmAmtXT4w+ffX6UNIT7FshEw41FFbzwHJ2Gu+LZ2nRurKQwxj5+uACSiX0X7F8RGmHxurIUaQDKFd8rw/AiNw9D4sM9vRNA9Ny3uzO/lTyHPQoVTG/I98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kYH20xbD; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <604aa161-9648-41bd-9ede-940e51f7248c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728088625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qJGDnqP8kw73g84YBNYT1lRx97u7k4/KMG+YvSNwXM=;
	b=kYH20xbDvfiWC2rKSCQ3NSjvKYTj9Zk/cvIF3EK1r2fmfavywP0XMbAYNX+1rqk1ZGE2IN
	HhLZTBdYP6XBRCUiUfiDCbmS2pTpxh1lPpjVaI63SIBcCHTacaqBWUrwFcDcvNH0ONLVkt
	S1qFOwrdc+qqx1dmxEBuQlYrMq6ov20=
Date: Fri, 4 Oct 2024 17:36:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/5] net: add TIME_WAIT logic to sk_to_full_sk()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, eric.dumazet@gmail.com,
 netdev@vger.kernel.org
References: <20241004191644.1687638-1-edumazet@google.com>
 <20241004191644.1687638-2-edumazet@google.com>
 <CANn89i+PxDFAkc_O9VdP3KgdBsRtpgaTCuYnH11ccLZAzpKMpA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CANn89i+PxDFAkc_O9VdP3KgdBsRtpgaTCuYnH11ccLZAzpKMpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/4/24 2:56 PM, Eric Dumazet wrote:
> On Fri, Oct 4, 2024 at 9:16 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> TCP will soon attach TIME_WAIT sockets to some ACK and RST.
>>
>> Make sure sk_to_full_sk() detects this and does not return
>> a non full socket.
>>
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> ---
>>   include/net/inet_sock.h | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
>> index 394c3b66065e20d34594d6e2a2010c55bb457810..cec093b78151b9a3b95ad4b3672a72b0aa9a8305 100644
>> --- a/include/net/inet_sock.h
>> +++ b/include/net/inet_sock.h
>> @@ -319,8 +319,10 @@ static inline unsigned long inet_cmsg_flags(const struct inet_sock *inet)
>>   static inline struct sock *sk_to_full_sk(struct sock *sk)
>>   {
>>   #ifdef CONFIG_INET
>> -       if (sk && sk->sk_state == TCP_NEW_SYN_RECV)
>> +       if (sk && READ_ONCE(sk->sk_state) == TCP_NEW_SYN_RECV)
>>                  sk = inet_reqsk(sk)->rsk_listener;
>> +       if (sk && READ_ONCE(sk->sk_state) == TCP_TIME_WAIT)
>> +               sk = NULL;
>>   #endif
>>          return sk;
>>   }
> 
> It appears some callers do not check if the return value could be NULL.
> I will have to add in v2 :
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index ce91d9b2acb9f8991150ceead4475b130bead438..c3ffb45489a6924c1bc80355e862e243ec195b01
> 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -209,7 +209,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>          int __ret = 0;                                                         \
>          if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {                    \

The above "&& sk" test can probably be removed after the "__sk &&" addition below.

>                  typeof(sk) __sk = sk_to_full_sk(sk);                           \
> -               if (sk_fullsock(__sk) && __sk == skb_to_full_sk(skb) &&        \
> +               if (__sk && sk_fullsock(__sk) && __sk == skb_to_full_sk(skb) &&        \

sk_to_full_sk() includes the TCP_TIME_WAIT check now. I wonder if testing __sk
for NULL is good enough and the sk_fullsock(__sk) check can be removed also.

Thanks for working on this series. It is useful for the bpf prog.

>                      cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS))         \
>                          __ret = __cgroup_bpf_run_filter_skb(__sk, skb,         \
>                                                        CGROUP_INET_EGRESS); \
> diff --git a/net/core/filter.c b/net/core/filter.c
> index bd0d08bf76bb8de39ca2ca89cda99a97c9b0a034..533025618b2c06efa31548708f21d9e0ccbdc68d
> 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6778,7 +6778,7 @@ __bpf_sk_lookup(struct sk_buff *skb, struct
> bpf_sock_tuple *tuple, u32 len,
>                  /* sk_to_full_sk() may return (sk)->rsk_listener, so
> make sure the original sk
>                   * sock refcnt is decremented to prevent a request_sock leak.
>                   */
> -               if (!sk_fullsock(sk2))
> +               if (sk2 && !sk_fullsock(sk2))
>                          sk2 = NULL;
>                  if (sk2 != sk) {
>                          sock_gen_put(sk);
> @@ -6826,7 +6826,7 @@ bpf_sk_lookup(struct sk_buff *skb, struct
> bpf_sock_tuple *tuple, u32 len,
>                  /* sk_to_full_sk() may return (sk)->rsk_listener, so
> make sure the original sk
>                   * sock refcnt is decremented to prevent a request_sock leak.
>                   */
> -               if (!sk_fullsock(sk2))
> +               if (sk2 && !sk_fullsock(sk2))
>                          sk2 = NULL;
>                  if (sk2 != sk) {
>                          sock_gen_put(sk);
> @@ -7276,7 +7276,7 @@ BPF_CALL_1(bpf_get_listener_sock, struct sock *, sk)
>   {
>          sk = sk_to_full_sk(sk);
> 
> -       if (sk->sk_state == TCP_LISTEN && sock_flag(sk, SOCK_RCU_FREE))
> +       if (sk && sk->sk_state == TCP_LISTEN && sock_flag(sk, SOCK_RCU_FREE))
>                  return (unsigned long)sk;
> 
>          return (unsigned long)NULL;


