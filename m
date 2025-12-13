Return-Path: <netdev+bounces-244603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E2ECBB417
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 22:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36DC330057F5
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 21:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63704274B5F;
	Sat, 13 Dec 2025 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="he1VaT01"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968D61E7C03
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765660957; cv=none; b=mlOY3AVbQjwsxCGqULlVszqK+dDqnzyoJptGxYBH+PUd3APJ5HzB1syUxc4cU+lYcHNZsZfteZv8BIIMNLaoSMuopvZBxPSrbdYIUiOZJrm5P5FSbjix25r1g8uSvADPKAhLm4nhn7PRUCQk7oDTKKZPHr+0Psnjmx9umQAui4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765660957; c=relaxed/simple;
	bh=gPXoNEZiDm6kobIOIj2HAYgyT3gGBkPXl7YMgNbFB5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNTXWTA+BboYkIInXuWmYC80MUI7L7/Vp3NU4+alDFfu0FJxvjYqvPUcFDeD0EWg7u1w0axE5B9ouLzZxqsyg4eSk4m0MpPYG24lK7llGpI3LQtIe8bCMCL4HBO+9TQLr4N3hf2uHCpqHzFsVd2p0+xzN28ItYuz6hQbroGVIb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=he1VaT01; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d0b3f358-4e0a-42f3-84f0-cbcf19066d49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765660947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHhpxWpYhAvBp0gVYLRD2oBwqIaXWQ69bhDF4jGuxB0=;
	b=he1VaT01WCkwNL/Nt628zSFuUrZObo9bcuWGbAFZ8SkS+OYBhgqKaHO3mOewq+sPbKj5Ia
	FBtncwvUkYZTuX3KHUysxmjQckFwy2y+0Vp1DfsiHuJ2lKbAXlEBtLlcxra7aGU7LnzTC2
	5lOhg7ocpvqjBvyBCgFycDA1/p358Ec=
Date: Sun, 14 Dec 2025 06:22:18 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 1/2] net: fib: restore ECMP balance from loopback
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org
References: <20251213135849.2054677-1-vadim.fedorenko@linux.dev>
 <willemdebruijn.kernel.5c4c191262c5@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <willemdebruijn.kernel.5c4c191262c5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/12/2025 20:54, Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
>> Preference of nexthop with source address broke ECMP for packets with
>> source address from loopback interface. Original behaviour was to
>> balance over nexthops while now it uses the latest nexthop from the
>> group.
> 
> How does the loopback device specifically come into this?

It may be a dummy device as well. The use case is when there are 2 
physical interfaces and 1 service IP address, distributed by any
routing protocol. The socket is bound to service, thus it's used in
route selection.

> 
>>
>> For the case with 198.51.100.1/32 assigned to lo:
>>
>> before:
>>     done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
>>      255 veth3
>>
>> after:
>>     done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
>>      122 veth1
>>      133 veth3
>>
>> Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches source address")
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>>   net/ipv4/fib_semantics.c | 21 +++++++++++----------
>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
>> index a5f3c8459758..c54b4ad9c280 100644
>> --- a/net/ipv4/fib_semantics.c
>> +++ b/net/ipv4/fib_semantics.c
>> @@ -2165,9 +2165,9 @@ static bool fib_good_nh(const struct fib_nh *nh)
>>   void fib_select_multipath(struct fib_result *res, int hash,
>>   			  const struct flowi4 *fl4)
>>   {
>> +	bool first = false, found = false;
>>   	struct fib_info *fi = res->fi;
>>   	struct net *net = fi->fib_net;
>> -	bool found = false;
>>   	bool use_neigh;
>>   	__be32 saddr;
>>   
>> @@ -2190,23 +2190,24 @@ void fib_select_multipath(struct fib_result *res, int hash,
>>   		    (use_neigh && !fib_good_nh(nexthop_nh)))
>>   			continue;
>>   
>> -		if (!found) {
>> +		if (saddr && nexthop_nh->nh_saddr == saddr) {
>>   			res->nh_sel = nhsel;
>>   			res->nhc = &nexthop_nh->nh_common;
>> -			found = !saddr || nexthop_nh->nh_saddr == saddr;
>> +			return;
> 
> This can return a match that exceeds the upper bound, while better
> matches may exist.
> 
> Perhaps what we want is the following:
> 
> 1. if there are matches that match saddr, prefer those above others
>     - take the first match, as with hash input that results in load
>       balancing across flows
>        
> 2. else, take any match
>     - again, first fit
> 
> If no match below fib_nh_upper_bound is found, fall back to the first
> fit above that exceeds nh_upper_bound. Again, prefer first fit of 1 if
> it exists, else first fit of 2.

Oh, I see... in case when there are 2 different nexthops with the same
saddr, we have to balance as well, but with code it will stick to only
first nexthop.

> 
> If so then we need up to two concurrent stored options,
> first_match_saddr and first.

That will have to do a bit more assignments.

> Or alternatively use a score similar to inet listener lookup.

I'll check this option

> Since a new variable is added, I would rename found with
> first_match_saddr or similar to document the intent.

Ok.



