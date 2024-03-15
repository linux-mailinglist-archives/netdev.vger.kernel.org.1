Return-Path: <netdev+bounces-80089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1704787CF85
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F901F2347F
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 14:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2343BB32;
	Fri, 15 Mar 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EF3zP48R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786903A1DF
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514503; cv=none; b=CQpRcrLovaLyd/wJ2yw0TySt65f24FpbbLBJOoSSa6jbhbmRj06uwWQ4ScQttokG/VgwFecLs1vEC7SlWzb9MCFWtzPevH/VE/shCJGSwyxO1qfvPxDsEc5kBqTQD/hDTsNvlnALMXgLh5M1Lo8gJxTddxoUTC3KZIV86Zu5Qh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514503; c=relaxed/simple;
	bh=MAYtjasQaxfso6wJHp0xmnAz2FQmx8v21kBvAdeElI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbxNU/HFtyguvZX4DVEM24zjZfCmSykiJGmANROYpXe1KN/fbOD9kURnjKmKA584SpChttvfChUsIBsgRvPQjGs1ilz13y/SnituB0B0Jesv1tmzig+RwnNsxy9w4ENO5/Sy8lv3U9GxJfSQf01v1SItkCoUkopYiGwrIUsWSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EF3zP48R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F22C433F1;
	Fri, 15 Mar 2024 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710514503;
	bh=MAYtjasQaxfso6wJHp0xmnAz2FQmx8v21kBvAdeElI8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EF3zP48Rewd7F87+gPtwrzu/dGe7zxyWfgx59ZMWY7fQqoIawnIgeiUfLYLl2gS78
	 nRxHvVck+F88dAUf809/YUNMH1iL2GuFR71PbhghJ82GJEgWKV2wyNtyDkdPwOOZuM
	 5slibq3PGilQJSJEZsnOy1nfWMiFHu06wNanp6nTKTLiGbUV1m8Z8EfLs5KNnF7ixP
	 MR0jF8BeTSra28z3u24Hy0gZ/Nq357n0n79auDSz4Sta/q4uhH86+H5WLL02MjsdT5
	 U+kRLARl4tf/mZ2H6ntNXsJGYBCLKxlyv/sqv5jy/XYjhk4mg35Y2WViuHslD/v44N
	 vuFETv7v30vSg==
Message-ID: <4ebe673f-a758-45a5-914a-d6ed60400dee@kernel.org>
Date: Fri, 15 Mar 2024 08:55:01 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: raw: Fix sending packets from raw sockets via
 IPsec tunnels
To: Tobias Brunner <tobias@strongswan.org>, nicolas.dichtel@6wind.com,
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <4f0d0955-8bfc-486e-a44f-0e12af8a403f@strongswan.org>
 <6cb11d93-fb10-4ca0-a5b2-93513ccefd60@6wind.com>
 <ec5aacb4-e38c-4c26-a469-69f3315a81d8@strongswan.org>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ec5aacb4-e38c-4c26-a469-69f3315a81d8@strongswan.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 8:31 AM, Tobias Brunner wrote:
>>> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
>>> index 42ac434cfcfa..322e389021c3 100644
>>> --- a/net/ipv4/raw.c
>>> +++ b/net/ipv4/raw.c
>>> @@ -357,6 +357,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
>>>  		goto error;
>>>  	skb_reserve(skb, hlen);
>>>  
>>> +	skb->protocol = htons(ETH_P_IP);
>>>  	skb->priority = READ_ONCE(sk->sk_priority);
>>>  	skb->mark = sockc->mark;
>>>  	skb->tstamp = sockc->transmit_time;
>> For !ipsec packet, dst_output()/ ip_output() is called. This last function set
>> skb->protocol to htons(ETH_P_IP).
>> What about doing the same in xfrm4_output() to avoid missing another path?
> 
> I took this approach because it worked and it aligns the code with the
> IPv6 version.

I agree with that; setting it in raw_send_hdrinc makes it consistent
across protocols.


Reviewed-by: David Ahern <dsahern@kernel.org>


