Return-Path: <netdev+bounces-152107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5379F2B2E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AAB91667E6
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 07:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C601FF60C;
	Mon, 16 Dec 2024 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnTIOmBG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5B1AAA24
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335534; cv=none; b=ora2x+RTWlR/LsqBTQUdwsPudTh4cHFOBbl4lf22cn/OLJgh68tO8GAKZ1ng1p15Uis6bu1oaa2geRqlDtbk6SKyd57JTo5dFSlVKw7pqQPEsQ5Zi3EEEVrHLLKgeMWfTIz9WNpkOOO3+16fSlLywfwcjSWJto0d+9iP+jzkuls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335534; c=relaxed/simple;
	bh=jXtHX0K+WBhaAW13qHP9sa2099pV0xSBgLH8GRDYvAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ni3Z8ibI9ILhDh1SdUDh6rsHErDabPO3BZuKW3HcI5h0KqrbCIp8wb6Tkcw2dP8TaDgnpn3fPXvu8Z6Qeqx8dE5b7638/nfGgmWnzDMzwTsJhJkeKO7fKEpl5loNK9t+vTQdBNWpH9qAF0HjYhzjzFp1+u0rfLQFxJBrrKUPhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnTIOmBG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734335531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Nu5fgGyhYkkZxJNjC8ytGWLfkwN3EPSX/6bR0OUdlU=;
	b=SnTIOmBG/3o2CNj7Gls710T64AAwTsY2Pxs0XT/cQbyjho1ErCVeMsbHFeIpHTYvHX1e57
	xJZwNgCUO7ejONVoxN8avV23/xDgX37Kxbq2Fp7ucvykktzdfOiGHXbEh9ktDE0GVP82PA
	9eEKDX6row/d88chmRg9MJBiFAQ9QC0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-GNXpQtgQPOSEa579BcfErg-1; Mon, 16 Dec 2024 02:52:09 -0500
X-MC-Unique: GNXpQtgQPOSEa579BcfErg-1
X-Mimecast-MFC-AGG-ID: GNXpQtgQPOSEa579BcfErg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3862be3bfc9so1973541f8f.3
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 23:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734335528; x=1734940328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Nu5fgGyhYkkZxJNjC8ytGWLfkwN3EPSX/6bR0OUdlU=;
        b=s2MpsSpotj+wS3jf8iXURTV9wVVU1kkAqMxby1ZyYhIdI6GbdpqrlkW35wu7D916Gy
         4NX0dLXDk7O7Da/gyBI2iKPMeN6qBAwYpHqzONy9gdds3pB1K+CGn9kBYPt1SYONJcSA
         qqazVSRVE+RJCaYGaGjvDrfMuSxqzrAZIuFv9N/Rn9FlC0Mq2XH2QNxygeyXGPrSoh4n
         LRIfBRskQOJw9Nb+tr6LoMFvBnP3XIzshvrFoUCuSa4lng1zEFA4cpd4ZPQXLzt0qawZ
         BqRGnal0Wjc5gSiIR9tTTDF0ZHmN7FRStbdgKQ76iIbFT08LXQt/FhO8oCIYkd6VJLdF
         GccQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWuex26AGKdOefUmTakppZ3Rpwaohw583eOqWddOehfVF0ATQfLdYhzFKOW3awapPgLB/BJmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0z0Qy4qWpORMC5885VpzUhFYz61y3Q/vM9VpljN8PYY86suVq
	+TASIII31KbDNAp4pBOSKKNuG1Zr3CwsKZi8HPp7oojT502rrYElwlCOsz80zQyZejJrv2gQ9Gb
	EC63OMQidTKGsYiZJk9j89Ro5cfYC55QFutvkORKP4NN6FB5qUOyhEQ==
X-Gm-Gg: ASbGncumcb12SenZfTCx0apEXoDAXXyJiwOlnf8QXDtWCrzCeuJbIvgAvgJwueONym7
	ixVgkBppfOh1ZvqUXj0pouHUP0cMpbN2iYg9MvWyW0f01nFaQa27ORklt/yvJN1hc0R4JVUWY1L
	wf0CKTJR0O5quWj7fVY2Q4Bb7HhNOBNvwt032vSpCsHLxyzVGqq14vfdBKsBDu7aaAbXcRttJF0
	c0KXPPzua3lfzGg2pslz1RtqRJnIsfaAVh4JJ1QjoNU7FCPjhhzTnS5I0sFFYM01dO29CxzpI7c
	GDK1qLU=
X-Received: by 2002:a5d:47a1:0:b0:385:f220:f779 with SMTP id ffacd0b85a97d-3888e0ba99amr7855952f8f.49.1734335528565;
        Sun, 15 Dec 2024 23:52:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNLtr68gE9l/spEXZHtOBvGQm96ADNXXuE5VgQ4ierUcuP5yQ3mfm71Gd4OTftNnxYaJ5lqg==
X-Received: by 2002:a5d:47a1:0:b0:385:f220:f779 with SMTP id ffacd0b85a97d-3888e0ba99amr7855930f8f.49.1734335528136;
        Sun, 15 Dec 2024 23:52:08 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8060592sm7227772f8f.98.2024.12.15.23.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 23:52:07 -0800 (PST)
Message-ID: <bdf0eec2-e168-48f7-9fdf-178cce4ee18b@redhat.com>
Date: Mon, 16 Dec 2024 08:52:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] Do not invoke addrconf_verify_rtnl
 unnecessarily
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, netdev@vger.kernel.org
References: <c67e10cf-ae33-4974-93c6-aaa111171635@redhat.com>
 <20241213151342.3614753-1-gnaaman@drivenets.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241213151342.3614753-1-gnaaman@drivenets.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 16:13, Gilad Naaman wrote:
>>> If the address IS perishable, and IS the soonest-to-be-expired address,
>>> calling or not-calling "verify" for a single address deletion is
>>> equivalent in cost.
>>
>> This last statement is not obvious to me, could you please expand the
>> reasoning?
> 
> Sorry, it does seem a bit vague when I am re-reading it now.
> 
> What I meant is that calling addrconf_verify_rtnl when no upkeep needs to be
> done has some cost K (in seconds) which is roughly a function of the
> total amount of addresses.
> 
> Let's say you've configured some addresses, 4 of which are perishable:
> 
> 	   |                
> 	T0-+- <---We are here
> 	   |                
> 	   |                
> 	T1-+- A <---Timer      
> 	   |                
> 	   |                
> 	   |                
> 	T2-+- B              
> 	   |                
> 	   |                
> 	   |                
> 	T3-+- C              
> 	   |                
> 	   |                
> 	   |                
> 	T4-+- D              
> 	   |                
> 	   |                
> 	   |                
> 	   v                
> 
> The timer is scheduled to expire in T1, because this is when address A
> perishes.
> 
> If you delete a non-perishable address, running addrconf_verify_rtnl is
> redundant, since it won't change the fact that the timer expires in T1.
> 
> If you delete A specifically, which is the cause of scheduling the timer
> to T1, you have 2 options:
> 
>  1. Pay K now, in T0, to reschedule the timer to T2
>  2. Pay nothing now, let the timer expire, pay the K in T1, and then reschedule

It looks like in this specific case option 1 will be cheaper, as it will
avoid an unneeded timer expiration.

> If we're talking about a deleting A, it seems equivalent in cost and result.
> Either way, exactly one K is paid, and the time eventually gets rescheduled to T2.
> 
> If we're talking about deleting an arbitrary address, using option 2 is
> better, since you do not lose functionaility, but you might be saving some
> Ks. (If you deleted B, the timer won't be rescheduled anyway)
> 
> If we're talking about deleting multiple/many address in a short time,
> option 2 is greatly preferable, since paying K for each address can get
> costly as the hash-table grows.

Makes sense to me.

>>> But calling "verify" immediately will result in a performance hit when
>>> deleting many addresses.
>>
>> Since this is about (control plane) performances, please include the
>> relevant test details (or even better, please add a small/fast self-test
>> covering the use-case).
> 
> Is it common to add scale-test to selftests?

AFAIK, not common at all. Note that the argument "so self-test for this
kind of thing" is actually a very good argument to add a self-tests.

> From my limited experience these tend to fail in automation for no good reason,
> though I feel I may have misunderstood the text in parens.
> I've added a link to the benchmark below.
> 
> Regarding the original test case:
> 
> We're developing a core-router and trying to scale-up to around 12K VLANs.
> Considering GUA+LLA this means 24K address in this table.
> In practice it's a bit more than that, due to other interfaces in the same
> namespace.
> 
> This makes addrconf_verify_rtnl very very very expensive for us.
> When initially setting the system up after boot, or when applying big
> configuration changes,
> adding addresses quickly slows down, as each added address has to pay
> for its predecesors. (all of our addresses are static)
> 
> On the reverse, when the VLANs' parent link goes down, the VLANs
> go down with it, causing us to pay for a lot of addrconf_verify_rtnl calls,
> during which rtnl_lock is held for a single long stretch of time.
> 
> I've ran some perf on an upatched kernel to demonstrate it:
> 
> 	https://github.com/gnaaman-dn/perf-addrconf-verify-rtnl
> 
> Turned out to be 13% of time when creating static addresses, and 18%
> when flushing them.
> 
> (In our original bug the VLANs were deleted, it is just easier to perf
> one iproute command if it's a flush)

Nice, so you already have the test infra ready :)

>>> @@ -3148,7 +3164,6 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
>>>  			    (ifp->flags & IFA_F_MANAGETEMPADDR))
>>>  				delete_tempaddrs(idev, ifp);
>>>  
>>> -			addrconf_verify_rtnl(net);
>>
>> With an additional 'addrconf_perishable' check here protecting the (here
>> removed) addrconf_verify_rtnl(), the patch will be IMHO much less prone
>> to unintended side-effects.
> 
> I hope my explanation will be convincing that that is not needed.
> (or just coherent enough to point out a mistake in my understanding)
> 
> If not, I will send V3 with this condition added, as in practice most
> of our addresses are static.

From my PoV, the main trouble is that this kind of change has the
potential of breaking things in subtle way. Your explanation above makes
sense to me, but I have the gut feeling I'm missing something.

A more verbose description will help for future memory.

Making the patch more straight-forward will give IMHO additional assurances.

A self-test could help tracking/detecting side-effects introduced here.

I think at least one of the above is needed, the more the better ;) Note
that the more verbose description could come in a form of a Link tag
pointing to this conversation.

Thanks,

Paolo


