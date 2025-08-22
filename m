Return-Path: <netdev+bounces-216013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC9B3180D
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A214600D7A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67BE2FB98A;
	Fri, 22 Aug 2025 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="3BYFJHp4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09223271443
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866409; cv=none; b=mH/2Jd0gg/7FqIrsa7/ajEJ8Zsu9wcSju1+Hw5Sl4zfqXBtB6RWNYHUQvVhIms0T2LyaUjMh+lmym/SuYYlVX/jrNlTMzYRyEEXrTC4LsBJXPUxbfVZH7x/UTDhLx7vDVFZrulhPaX6ZZkWa3ewJVZRR50z8QKQxo3+4RdlJxUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866409; c=relaxed/simple;
	bh=dph5PYREDD1pA0b8chqVFqGvC+vOsxLs/HqOrSPAUes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAJT9bcGnpY1uI2Sqo3apjfOUUBG4m4J6R6NbIvTFD8uUE2xu2lZaOeVbPFM8f3SbMczd8/K4wWqYq65jGi+Pv3eEgZifqx1H/qx/7s4W1UnyDMR5jlZGsRqoYHoXlNHD/UzzMZ1p390SAwqR6XeQpW7kse/2LdjN29zgRfq1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=3BYFJHp4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso2401937b3a.0
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 05:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1755866406; x=1756471206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+yr9sRToH/PruAdIM7WqBdD3kL6ipM/1pLENcMhk1k=;
        b=3BYFJHp4t8Uz2lOHeVi/WjBt60rnY+N2KcNxGq39dpJdpJTj5U5P6ezvTwrJUDU9l7
         3Jb1iz+nD3Y+tkXLroqhSA6OEZfnaPRF79I7cLGR0WvunLaGZG3innM5YqJ8CFW4CGHq
         JDy1qY/gpL0rctROy3bM5jEmA9JjIzr39ThsjIQa8vTWu1stkmeXc+HfwDRY/q1+dXAN
         YLFCWaXJgrcE0bPYKCMuuJ/rvNl/mqedyse36M1i/+sq15UdBlAxvRaE74Eg7bZybk+s
         gRFkt5Z6heJTOo+kH6YoZBuHFwwqIhFfDPGNyrjkEeUzkDsvdr9lKaMKhKSs9rbQ03Bj
         6jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755866406; x=1756471206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+yr9sRToH/PruAdIM7WqBdD3kL6ipM/1pLENcMhk1k=;
        b=Kx41uu9TXydvf6HmvAnmunNU7GO7Ffowhe9TF2MH5ZxRns5WW90ZIUtHjfzTlU4prz
         E+eeba2TCWn4OU1Mp5xLiAgrEXBK26LQOWYAuQ6VNV8AHr+AFSiQb/vvNQBuQZRPBxZ7
         6EnV2L5d94D/J72ne/9qujJuCW7qS91cwohqF9SI2rbTMGylgPLKAQ1v4/DZOyLETLlP
         NCA275t2y0IojfXJnFJ4kBJzddc2KFAR5q4MS/XQ9zSxvYyXHUsBl6huuLGEBS0JPL28
         p0lCYnVlfVQGgyT1iQ90o1ZYuGycTQAAjMIgZA3rbRzAjN4KolGi75MExkibbKlYJAO9
         XGCw==
X-Forwarded-Encrypted: i=1; AJvYcCUqXCRGNTZvz8CYJTDDJe6lgqfr3xYuRKFKDW0dnCd4386ncDfCEQhRKzaHbTg+1Wm5Qyaz9t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPDpTn/L8CkM8cF1daEpjJsgk4aIBiOVn6z/zfUZQC1wge7IUY
	CkKslYChJ2JTsl9RT2h8N5ZYLsgKHB30B2eYxokQYZWwHQHdrUrGlsI1W8WJfZyjvQ==
X-Gm-Gg: ASbGncuvloHaOUCdaINj6QqqfgnxftrmEQfaEoYS3f8Zbcjgu9WsMcEYKt/Bagf+egY
	8aQEkOBMMyC0Erm1ypAVvhlYfaKagMW5g/cEVTdQha27nkor1emXfAVjqLJWuXxFwuSjBrPJlvp
	Vv3PCQxIGlXE8X6d9WEbCzWX32GJeAOAu08KsVTa3OiE8W/gMMJyZYLott0EY7ADCn0EaSgHKcU
	m2d4CmIXEque919oJ8rq6EpwLPrUCvOJpbkY6obE91eN+k5LUtqjI3UNAimmgA6w/63wXbJOJMV
	GcfPHmL43PW+7gonhctlcZUh7018FI5J96wUtkuxMfDVefpWQqlJu+V62xgyskdhCiSuPnJxFav
	mpXUz1aOwzbJbL4lCZuCAyfUVb8h+Pfxu7+PfvAHAoH6yBxyKwtnd9Ro5/+pul53yHLBQ
X-Google-Smtp-Source: AGHT+IH5GwW/1LtdiOxW1n+MhOlbTwJKo2G4oIdIoLQEQsy6aOmCo5AeIoYMEsOb8r546lNVBC0s3w==
X-Received: by 2002:a05:6a20:7fa0:b0:21f:5598:4c2c with SMTP id adf61e73a8af0-24340b01969mr4479905637.13.1755866406259;
        Fri, 22 Aug 2025 05:40:06 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:f78a:6c07:66e5:2cc3:7521? ([2804:7f1:e2c3:f78a:6c07:66e5:2cc3:7521])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-325132487b3sm2485980a91.11.2025.08.22.05.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 05:40:05 -0700 (PDT)
Message-ID: <98c5d450-e766-45cd-a300-bbeaf31cb0b9@mojatatu.com>
Date: Fri, 22 Aug 2025 09:40:01 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] tcp: Destroy TCP-AO, TCP-MD5 keys in
 .sk_destruct()
To: dima@arista.com, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Bob Gilligan <gilligan@arista.com>,
 Salam Noureddine <noureddine@arista.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250822-b4-tcp-ao-md5-rst-finwait2-v1-0-25825d085dcb@arista.com>
 <20250822-b4-tcp-ao-md5-rst-finwait2-v1-1-25825d085dcb@arista.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250822-b4-tcp-ao-md5-rst-finwait2-v1-1-25825d085dcb@arista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/22/25 01:55, Dmitry Safonov via B4 Relay wrote:
> From: Dmitry Safonov <dima@arista.com>
> 
> Currently there are a couple of minor issues with destroying the keys
> tcp_v4_destroy_sock():
> 
> 1. The socket is yet in TCP bind buckets, making it reachable for
>     incoming segments [on another CPU core], potentially available to send
>     late FIN/ACK/RST replies.
> 
> 2. There is at least one code path, where tcp_done() is called before
>     sending RST [kudos to Bob for investigation]. This is a case of
>     a server, that finished sending its data and just called close().
> 
>     The socket is in TCP_FIN_WAIT2 and has RCV_SHUTDOWN (set by
>     __tcp_close())
> 
>     tcp_v4_do_rcv()/tcp_v6_do_rcv()
>       tcp_rcv_state_process()            /* LINUX_MIB_TCPABORTONDATA */
>         tcp_reset()
>           tcp_done_with_error()
>             tcp_done()
>               inet_csk_destroy_sock()    /* Destroys AO/MD5 keys */
>       /* tcp_rcv_state_process() returns SKB_DROP_REASON_TCP_ABORT_ON_DATA */
>     tcp_v4_send_reset()                  /* Sends an unsigned RST segment */
> 
>     tcpdump:
>> 22:53:15.399377 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 (0x0800), length 74: (tos 0x0, ttl 64, id 33929, offset 0, flags [DF], proto TCP (6), length 60)
>>      1.0.0.1.34567 > 1.0.0.2.49848: Flags [F.], seq 2185658590, ack 3969644355, win 502, options [nop,nop,md5 valid], length 0
>> 22:53:15.399396 00:00:01:01:00:00 > 00:00:b2:1f:00:00, ethertype IPv4 (0x0800), length 86: (tos 0x0, ttl 64, id 51951, offset 0, flags [DF], proto TCP (6), length 72)
>>      1.0.0.2.49848 > 1.0.0.1.34567: Flags [.], seq 3969644375, ack 2185658591, win 128, options [nop,nop,md5 valid,nop,nop,sack 1 {2185658590:2185658591}], length 0
>> 22:53:16.429588 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 (0x0800), length 60: (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TCP (6), length 40)
>>      1.0.0.1.34567 > 1.0.0.2.49848: Flags [R], seq 2185658590, win 0, length 0
>> 22:53:16.664725 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 (0x0800), length 74: (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TCP (6), length 60)
>>      1.0.0.1.34567 > 1.0.0.2.49848: Flags [R], seq 2185658591, win 0, options [nop,nop,md5 valid], length 0
>> 22:53:17.289832 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 (0x0800), length 74: (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TCP (6), length 60)
>>      1.0.0.1.34567 > 1.0.0.2.49848: Flags [R], seq 2185658591, win 0, options [nop,nop,md5 valid], length 0
> 
>    Note the signed RSTs later in the dump - those are sent by the server
>    when the fin-wait socket gets removed from hash buckets, by
>    the listener socket.
> 
> Instead of destroying AO/MD5 info and their keys in inet_csk_destroy_sock(),
> slightly delay it until the actual socket .sk_destruct(). As shutdown'ed
> socket can yet send non-data replies, they should be signed in order for
> the peer to process them. Now it also matches how AO/MD5 gets destructed
> for TIME-WAIT sockets (in tcp_twsk_destructor()).
> 
> This seems optimal for TCP-MD5, while for TCP-AO it seems to have an
> open problem: once RST get sent and socket gets actually destructed,
> there is no information on the initial sequence numbers. So, in case
> this last RST gets lost in the network, the server's listener socket
> won't be able to properly sign another RST. Nothing in RFC 1122
> prescribes keeping any local state after non-graceful reset.
> Luckily, BGP are known to use keep alive(s).
> 
> While the issue is quite minor/cosmetic, these days monitoring network
> counters is a common practice and getting invalid signed segments from
> a trusted BGP peer can get customers worried.
> 
> Investigated-by: Bob Gilligan <gilligan@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>   net/ipv4/tcp.c      | 31 +++++++++++++++++++++++++++++++
>   net/ipv4/tcp_ipv4.c | 25 -------------------------
>   2 files changed, 31 insertions(+), 25 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 71a956fbfc5533224ee00e792de2cfdccd4d40aa..4e996e937e8e5f0e75764caa24240e25006deece 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -412,6 +412,36 @@ static u64 tcp_compute_delivery_rate(const struct tcp_sock *tp)
>   	return rate64;
>   }
> [...]
> +
> +static void tcp_destruct_sock(struct sock *sk)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);

It looks like this variable is unused when CONFIG_TCP_MD5SIG is not set 

and this is causing the test CI build to fail.

net/ipv4/tcp.c: In function ‘tcp_destruct_sock’:
net/ipv4/tcp.c:417:26: error: unused variable ‘tp’ [-Werror=unused-variable]
   417 |         struct tcp_sock *tp = tcp_sk(sk);
       |                          ^~
cc1: all warnings being treated as errors
make[4]: *** [scripts/Makefile.build:287: net/ipv4/tcp.

cheers,
Victor

