Return-Path: <netdev+bounces-70846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB0F850C5D
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 00:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B6FB21680
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 23:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EBE17550;
	Sun, 11 Feb 2024 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xn8qa07u"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25713171BF
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 23:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707695196; cv=none; b=dpIU2ImFfMs7u2HDw/YDPE5jE4FIapUqQaQcfkkhUZTDVHBVZV4cgdvT8jO8TAvjVq4RgAQXFtHdDPDyoyJY7wMdgtXiN4hhKkCeQ9ya7DEQhHTz33bVeMU/d6rj5FXoP2gxPfxLrWR2uTBUGIflM9gBi+mtmJGCj4Y2sJfFU1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707695196; c=relaxed/simple;
	bh=jdFZMdcR4Y6l7+nKmvZVGpC1ufXVOlpC6c54dHLH3wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxTCcrZfi1YPqo3TAgpBYLBgSitIO7WIb8MPSxuGhEnFkN/kUnw1MoQQr+Iluco3MLbqfCTJcC1uhf4C4XGJNQI578diaVklSWLm+fX0sb3DEPjLxtVZ/HSjb3lDXlECGGX0u8B5BCq7JgKjZfxEssxqfvMhTSY6t+jcJHvifyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xn8qa07u; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e1977c1d-9db8-4a4b-b871-4dfb0b78cfc6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707695190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncDjSlzWVAPR7la1cOniFpu7SQQbx+4Gkw+PkGejvRY=;
	b=xn8qa07ukS/V06tXq0GbzD3+JAR6mi0F3/FTx5mOT1zAF/GhphvVOfhRkAL3qQkKjlH4S6
	gSm9J/dv+G4mupdj2Wx+XkbniODzuqD6tz8xW5epy8hM+kLIpGDuA7kltDexE52b5Um+ib
	Smc+VZFWti655ngGfqr+/PaEtJ/LY50=
Date: Sun, 11 Feb 2024 18:46:11 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net-timestamp: make sk_tskey more predictable in
 error path
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Vadim Fedorenko <vadfed@meta.com>, Andy Lutomirski <luto@amacapital.net>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org
References: <20240210230002.3778461-1-vadfed@meta.com>
 <65c90702da50f_178c3c294a3@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <65c90702da50f_178c3c294a3@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/02/2024 12:42, Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
>> When SOF_TIMESTAMPING_OPT_ID is used to ambiguate timestamped datagrams,
>> the sk_tskey can become unpredictable in case of any error happened
>> during sendmsg(). Move increment later in the code and make decrement of
>> sk_tskey in error path. This solution is still racy in case of multiple
>> threads doing snedmsg() over the very same socket in parallel, but still
>> makes error path much more predictable.
>>
>> Fixes: 09c2d251b707 ("net-timestamp: add key to disambiguate concurrent datagrams")
>> Reported-by: Andy Lutomirski <luto@amacapital.net>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   net/ipv4/ip_output.c  | 14 +++++++++-----
>>   net/ipv6/ip6_output.c | 14 +++++++++-----
>>   2 files changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>> index 41537d18eecf..ac4995ed17c7 100644
>> --- a/net/ipv4/ip_output.c
>> +++ b/net/ipv4/ip_output.c
>> @@ -974,7 +974,7 @@ static int __ip_append_data(struct sock *sk,
>>   	struct rtable *rt = (struct rtable *)cork->dst;
>>   	unsigned int wmem_alloc_delta = 0;
>>   	bool paged, extra_uref = false;
>> -	u32 tskey = 0;
>> +	u32 tsflags, tskey = 0;
>>   
>>   	skb = skb_peek_tail(queue);
>>   
>> @@ -982,10 +982,6 @@ static int __ip_append_data(struct sock *sk,
>>   	mtu = cork->gso_size ? IP_MAX_MTU : cork->fragsize;
>>   	paged = !!cork->gso_size;
>>   
>> -	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
>> -	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID)
>> -		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>> -
>>   	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
>>   
>>   	fragheaderlen = sizeof(struct iphdr) + (opt ? opt->optlen : 0);
>> @@ -1052,6 +1048,11 @@ static int __ip_append_data(struct sock *sk,
>>   
>>   	cork->length += length;
>>   
>> +	tsflags = READ_ONCE(sk->sk_tsflags);
>> +	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
>> +	    tsflags & SOF_TIMESTAMPING_OPT_ID)
>> +		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>> +
>>   	/* So, what's going on in the loop below?
>>   	 *
>>   	 * We use calculated fragment length to generate chained skb,
>> @@ -1274,6 +1275,9 @@ static int __ip_append_data(struct sock *sk,
>>   	cork->length -= length;
>>   	IP_INC_STATS(sock_net(sk), IPSTATS_MIB_OUTDISCARDS);
>>   	refcount_add(wmem_alloc_delta, &sk->sk_wmem_alloc);
>> +	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
>> +	    tsflags & SOF_TIMESTAMPING_OPT_ID)
>> +		atomic_dec(&sk->sk_tskey);
> 
> Instead of testing the same conditional twice have a local bool,
> e.g., hold_tskey? Akin to extra_uarf for MSG_ZEROCOPY.
> 

Ok, sure, will post v2 soon

