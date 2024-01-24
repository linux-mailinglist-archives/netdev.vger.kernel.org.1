Return-Path: <netdev+bounces-65477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6083283AB9B
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 15:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B0D28BF60
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E2477F3E;
	Wed, 24 Jan 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Hrqsxytb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F7377652
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106260; cv=none; b=jF02B2Pia/x7SqbOZ2fxWmJfx27csUK0fgNi4KcsZB1eSADBK4UXKw3xURK0EgXXA50QpI9LBrDIxKsNDviEz7FkiYIYJOenNMGXv8C5f7PyAzdp/ByyDE1Qx6MhrHq2C3JPmb0aZZjQswJkKupp1fJ+R6Y+DJcK6JB+muAveFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106260; c=relaxed/simple;
	bh=ap0whIFOgiOdEy5RxVOL7mD55FYjg5IFulCYrxH4GYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvrsTkdsPvCQSA9dhblxoAz/TCfkpjQSUpAnoz39wk5bbfxsgVs7YgdnO0TnmHzWe3FYPW9xo8g9AmOV9UUy+vFeRHGH0hY5t5EjIuq7AZMi4oqt6TsKLJAGwsIMnubj8UNu5veB9cA6JlUZLi8C3HuwvYH89iRDJ5zGpaWjSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Hrqsxytb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso66066075e9.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 06:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1706106257; x=1706711057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0S6UDrzs/qRIrU2an6ZKieHHaUOVxITSY2xkhpHx7LI=;
        b=HrqsxytbsQ/rL1ZXhvXLbdSukxWbkG65lG5Zo5qYG8mk10JYTd1fqY0ucTxx67olt6
         A1A/GLlFgAtWoJpbFIvDGjoEY0npV3u3fQspMtaN/owI5Bk0lVwul7YaLBS5LjcLFMit
         djKEZT1WopSpC5nVeAPFDqanevAj7bO++rtWVj5JndEF1pn+PeoSvqtS8T7G8vHuSKIE
         g4pODM598x8lIcNxqmlSPzKJid9CeBOuqLqeDB14qghSfUCB9E8rTRGM0BSxrvFemSNE
         I3ItP09PdU8vt2X63y56GA157Ktew4ruCbs4ssndr7LXeydW8RlaO9N+U5wHK+1yZHZq
         7X2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706106257; x=1706711057;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0S6UDrzs/qRIrU2an6ZKieHHaUOVxITSY2xkhpHx7LI=;
        b=Q1sFGXzUb54dfkXAq2A95EZyJDJh2MC33WP+qVNo5lvg/9mxp2cZdNml8rGtevQAAc
         xn9WBaok6rFkvpIi2wyFgSRXZOn5nJW+M5pJPT7v1s8XKPSDfL3zxayjIqkEFXSOaLj6
         vrOmZ+Ft800aNhCk8/SOcpfs7O0ZQIXRDLzavV66G4Y3kEp2bsnGlOg712i0uK1cSFCD
         qvKKVON4JTCkIA6hvnEaOdITKYHkLxdpqV2/nn655nzKlpt+Bs/eUgrezOC6xxKZXpgC
         T6x52A+H6dhRdVbzVcTvZJxpWmps5ef/khFHJVXGbhLXpaiyijLU4K4lxkz/xS+qa0Vs
         M7dg==
X-Gm-Message-State: AOJu0Yz1sWt0ZpMwnLTmD9nCl2VqDp4SLZwnrUKLUwt5EDXnwu1EG2H1
	Dq2nrO8PTY1ew+TppJhc6OZdXcEvv0nBLU95LpFEX+degqSsnXhY8cd1pRVKl2A=
X-Google-Smtp-Source: AGHT+IELGB88Vob7yTg2Y7ns1cUOjmSBR55TOU0D8MZA4EFcrpXcImCPHyoR6WzQtgRkV0YQUiYTpQ==
X-Received: by 2002:a7b:c38f:0:b0:40e:586b:e980 with SMTP id s15-20020a7bc38f000000b0040e586be980mr845207wmj.271.1706106257186;
        Wed, 24 Jan 2024 06:24:17 -0800 (PST)
Received: from [172.31.98.152] ([185.13.181.2])
        by smtp.gmail.com with ESMTPSA id iv17-20020a05600c549100b0040e5034d8e0sm50235301wmb.43.2024.01.24.06.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 06:24:16 -0800 (PST)
Message-ID: <8063713f-2811-4c4c-9372-c98daff2503c@6wind.com>
Date: Wed, 24 Jan 2024 15:24:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] ipmr: fix kernel panic when forwarding mcast packets
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Leone Fernando <leone4fernando@gmail.com>, netdev@vger.kernel.org
References: <20240124121538.3188769-1-nicolas.dichtel@6wind.com>
 <CANn89iJkEFuvYMHjM6g=4Jc2mp4wW1rN10QwxxvyfOJYC2h8mQ@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <CANn89iJkEFuvYMHjM6g=4Jc2mp4wW1rN10QwxxvyfOJYC2h8mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 24/01/2024 à 15:21, Eric Dumazet a écrit :
> On Wed, Jan 24, 2024 at 1:15 PM Nicolas Dichtel
> <nicolas.dichtel@6wind.com> wrote:
>>
>> The stacktrace was:
>> [   86.305548] BUG: kernel NULL pointer dereference, address: 0000000000000092
>>
> ...
> 
>> The original packet in ipmr_cache_report() may be queued and then forwarded
>> with ip_mr_forward(). This last function has the assumption that the skb
>> dst is set.
>>
>> After the below commit, the skb dst is dropped by ipv4_pktinfo_prepare(),
>> which causes the oops.
>>
>> Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> ---
>>  include/net/ip.h       | 2 +-
>>  net/ipv4/ip_sockglue.c | 5 +++--
>>  net/ipv4/ipmr.c        | 2 +-
>>  net/ipv4/raw.c         | 2 +-
>>  net/ipv4/udp.c         | 2 +-
>>  5 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/net/ip.h b/include/net/ip.h
>> index de0c69c57e3c..1e7f2e417ed2 100644
>> --- a/include/net/ip.h
>> +++ b/include/net/ip.h
>> @@ -767,7 +767,7 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev);
>>   *     Functions provided by ip_sockglue.c
>>   */
>>
>> -void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb);
>> +void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb, bool keep_dst);
>>  void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
>>                          struct sk_buff *skb, int tlen, int offset);
>>  int ip_cmsg_send(struct sock *sk, struct msghdr *msg,
>> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
>> index 7aa9dc0e6760..fe1ab335324f 100644
>> --- a/net/ipv4/ip_sockglue.c
>> +++ b/net/ipv4/ip_sockglue.c
>> @@ -1368,7 +1368,7 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
>>   * destination in skb->cb[] before dst drop.
>>   * This way, receiver doesn't make cache line misses to read rtable.
>>   */
>> -void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb)
>> +void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb, bool keep_dst)
>>  {
>>         struct in_pktinfo *pktinfo = PKTINFO_SKB_CB(skb);
>>         bool prepare = inet_test_bit(PKTINFO, sk) ||
>> @@ -1397,7 +1397,8 @@ void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb)
>>                 pktinfo->ipi_ifindex = 0;
>>                 pktinfo->ipi_spec_dst.s_addr = 0;
>>         }
>> -       skb_dst_drop(skb);
>> +       if (keep_dst == false)
>> +               skb_dst_drop(skb);
> 
> IMO this would look nicer if you had
> 
> void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb,
> bool drop_dst)
> ..
> if (drop_dst)
>    skb_dst_drop(skb);
Agreed, I hesitated :)

> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> Thanks.

Thank you,
Nicolas

