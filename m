Return-Path: <netdev+bounces-80083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A152287CEF5
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A968FB23A1C
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 14:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5341864C;
	Fri, 15 Mar 2024 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b="AGBP7Y01"
X-Original-To: netdev@vger.kernel.org
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734D41B7F8
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.202.192.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513089; cv=none; b=HW6l1n8kaHx1X8G4b0lPcVBjkde7bSfrAr1CXO3tR62ckfLfeoZzSjX4BsVZiu/wWdBNh3k7mFkh5ZxkWQ5TpM57U1mrkpAS+MrGu9klIH1bg7UmmZCxkrDU4bK8CBvVU/fUiz8RjYwkz10QK0KS+WAwzGXNNDHQVzD5RGf/7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513089; c=relaxed/simple;
	bh=wxRZ/g0jMt5ejgARFWIKZK6NUS/jxd4woZxPoPtKUqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/D3gjPJrLUagpe7Yh8pLK0EnNOsNLunGcZRTR+abe67YLoDqkniV/5BSTifbhupXFN4wS+9A/Kc+CvgYnrdyI5Ma03FLjnQmxXZGFeH/nd4uIxr/OOX7tUa+bwNUiqYXhvQHYsgUGyIV0dHDB/TzC2kJL0s54LhOCa0kccmK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org; spf=pass smtp.mailfrom=strongswan.org; dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b=AGBP7Y01; arc=none smtp.client-ip=109.202.192.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongswan.org
Received: from localhost (localhost [127.0.0.1])
	by mail.codelabs.ch (Postfix) with ESMTP id 8D46F5A0004;
	Fri, 15 Mar 2024 15:31:20 +0100 (CET)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b6TgvcrUrWJH; Fri, 15 Mar 2024 15:31:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strongswan.org;
	s=default; t=1710513079;
	bh=wxRZ/g0jMt5ejgARFWIKZK6NUS/jxd4woZxPoPtKUqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AGBP7Y01opQfbUsolCweUjWjFteJY39BQnZHIQKXQZhRG7Tdfc18DJz2N0eWQBcxG
	 WMT1ynrg6C+cXJzjLmY6PRkn5r2JJceTBvKAOnCbhmeCg+8CScvGhFYp+o2aXWRFQx
	 TUN1w8ovFV/dX85w9WBpTjiPS3nWSqCjlZq6orlVMvnS+bzcQhw+2KJsfmnyePQBjM
	 7KmqK8jewthB+NyP2pqyEntCnCa0hTf61nmAgMCckmQkzyAEdlp4LjbSnLlBUJZ+A2
	 Yk97delgFC79zXpfMsw2RriWzqazNX3RqfF4AFqlI7yHy5cAuSlDr1GQrm+oDkqetz
	 PWNb8Gub18bPA==
Received: from [IPV6:2a01:8b81:5400:f500:d47c:2824:818f:c8a] (unknown [IPv6:2a01:8b81:5400:f500:d47c:2824:818f:c8a])
	by mail.codelabs.ch (Postfix) with ESMTPSA id 469575A0003;
	Fri, 15 Mar 2024 15:31:19 +0100 (CET)
Message-ID: <ec5aacb4-e38c-4c26-a469-69f3315a81d8@strongswan.org>
Date: Fri, 15 Mar 2024 15:31:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: raw: Fix sending packets from raw sockets via
 IPsec tunnels
Content-Language: en-US, de-CH-frami
To: nicolas.dichtel@6wind.com, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <4f0d0955-8bfc-486e-a44f-0e12af8a403f@strongswan.org>
 <6cb11d93-fb10-4ca0-a5b2-93513ccefd60@6wind.com>
From: Tobias Brunner <tobias@strongswan.org>
Autocrypt: addr=tobias@strongswan.org; keydata=
 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
 tvkh7XWO2ycrW1UlzUzM4KV3SDLIhfOU
In-Reply-To: <6cb11d93-fb10-4ca0-a5b2-93513ccefd60@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>> Since the referenced commit, the xfrm_inner_extract_output() function
>> uses the skb's protocol field to determine the address family.  So not
>> setting it for IPv4 raw sockets meant that such packets couldn't be
>> tunneled via IPsec anymore.
>>
>> IPv6 raw sockets are not affected as they already set the protocol since
>> 9c9c9ad5fae7 ("ipv6: set skb->protocol on tcp, raw and ip6_append_data
>> genereated skbs").
>>
>> Fixes: 5f24f41e8ea6 ("xfrm: Remove inner/outer modes from input path")This is the input part, I presume you were thinking to the output part:
> Fixes: f4796398f21b ("xfrm: Remove inner/outer modes from output path")

Right, will fix.

>> Signed-off-by: Tobias Brunner <tobias@strongswan.org>
>> ---
>>  net/ipv4/raw.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
>> index 42ac434cfcfa..322e389021c3 100644
>> --- a/net/ipv4/raw.c
>> +++ b/net/ipv4/raw.c
>> @@ -357,6 +357,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
>>  		goto error;
>>  	skb_reserve(skb, hlen);
>>  
>> +	skb->protocol = htons(ETH_P_IP);
>>  	skb->priority = READ_ONCE(sk->sk_priority);
>>  	skb->mark = sockc->mark;
>>  	skb->tstamp = sockc->transmit_time;
> For !ipsec packet, dst_output()/ ip_output() is called. This last function set
> skb->protocol to htons(ETH_P_IP).
> What about doing the same in xfrm4_output() to avoid missing another path?

I took this approach because it worked and it aligns the code with the
IPv6 version.  Whether the code path would actually pass through the
function you mention before hitting the problematic one I don't know.

Regards,
Tobias


