Return-Path: <netdev+bounces-71447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4D28534EF
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 16:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF16B1C2685E
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C545EE9C;
	Tue, 13 Feb 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx/1gMR3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA0C5EE7F
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838844; cv=none; b=s4E+gOMt8Pg5EObJA57RsDrp+QG8z+lO3tvQe5002N04yk5DlDhC3XTPcjzM5Yx2jNY/UkZl2mvSfzjCQKvICjMa0GyV4SugRNSJCWmLz/zbbAIpkvB74lFdba6/SJV8ujk95AjrjjJFPblxt15tbHQRH0OhFcczGhvg7pq3RMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838844; c=relaxed/simple;
	bh=5774MiP3160DZnlsEwjEiqLQHBGGmKhgE5JNpfZ7iC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YNKOwZZu4dD/8CTgQM93obBSbSCpMVjEiuu4nsdbd9hgXDE5PQuWG5eUmUrS8nFlRtcqAdxoqowVGABLBKsDDVXGOhAHt8zRq8R8Ew9W9hfU+5E3Ep4VABFr1eQ9Mv7UFiv8KMKxm93YDXeYtPDPn5ULPbAieDZzYo/aOU4YQ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx/1gMR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E11AC433C7;
	Tue, 13 Feb 2024 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838843;
	bh=5774MiP3160DZnlsEwjEiqLQHBGGmKhgE5JNpfZ7iC4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vx/1gMR3Kh0udfV3t0FGFUk4MyZq+YbH4hqv3IbR1TyugjCqBIsDPpHHuGPQnDNN6
	 SOqcXYp2l0D8nGReBNkjOR6F94mvruhsQZN/0nI9G9L3ty1xxrrPmj9KElQ5RmTqH4
	 Igrn2Ux2YrYdrzoWSWJ/Nc8B2daaG5RjnulfNol2+yeTF2/oU7hIBIgjaWnLescHnH
	 I+EjZ17teGnW0C1v/KR0TpJ3q07W4ZKKmSdexG0Jnj5cks30+6pUEW8mg6qQ6OwB+R
	 gLqqmo47b4LlPqI78xrMwXcArVqTyZR/E6dKwcxQ7rIFcHp8aZmq2WvGt/YtV2tXIE
	 Ywi/gr6qvVMWg==
Message-ID: <89281fb2-fb5d-416a-aff9-31cf6a0d4525@kernel.org>
Date: Tue, 13 Feb 2024 08:40:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: ipv6/addrconf: clamp preferred_lft to
 the minimum required
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com, kuba@kernel.org, jikos@kernel.org,
 Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org, dan@danm.net,
 bagasdotme@gmail.com, davem@davemloft.net
References: <20240209061035.3757-1-alexhenrie24@gmail.com>
 <20240209061035.3757-3-alexhenrie24@gmail.com>
 <13efb9e14d378cf6ed81650f52fce21ce6faafe1.camel@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <13efb9e14d378cf6ed81650f52fce21ce6faafe1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 3:13 AM, Paolo Abeni wrote:
>> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>> index 0b78ffc101ef..8d3023e54822 100644
>> --- a/net/ipv6/addrconf.c
>> +++ b/net/ipv6/addrconf.c
>> @@ -1347,6 +1347,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
>>  	unsigned long regen_advance;
>>  	unsigned long now = jiffies;
>>  	s32 cnf_temp_preferred_lft;
>> +	u32 if_public_preferred_lft;
> 
> [only if a repost is needed for some other reason] please respect the
> reverse x-mas tree above.
> 
>>  	struct inet6_ifaddr *ift;
>>  	struct ifa6_config cfg;
>>  	long max_desync_factor;
>> @@ -1401,11 +1402,13 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
>>  		}
>>  	}
>>  
>> +	if_public_preferred_lft = ifp->prefered_lft;
>> +
>>  	memset(&cfg, 0, sizeof(cfg));
>>  	cfg.valid_lft = min_t(__u32, ifp->valid_lft,
>>  			      idev->cnf.temp_valid_lft + age);
>>  	cfg.preferred_lft = cnf_temp_preferred_lft + age - idev->desync_factor;
>> -	cfg.preferred_lft = min_t(__u32, ifp->prefered_lft, cfg.preferred_lft);
>> +	cfg.preferred_lft = min_t(__u32, if_public_preferred_lft, cfg.preferred_lft);
>>  	cfg.preferred_lft = min_t(__u32, cfg.valid_lft, cfg.preferred_lft);
>>  
>>  	cfg.plen = ifp->prefix_len;
>> @@ -1414,19 +1417,41 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
>>  
>>  	write_unlock_bh(&idev->lock);
>>  
>> -	/* A temporary address is created only if this calculated Preferred
>> -	 * Lifetime is greater than REGEN_ADVANCE time units.  In particular,
>> -	 * an implementation must not create a temporary address with a zero
>> -	 * Preferred Lifetime.
>> +	/* From RFC 4941:
>> +	 *
>> +	 *     A temporary address is created only if this calculated Preferred
>> +	 *     Lifetime is greater than REGEN_ADVANCE time units.  In
>> +	 *     particular, an implementation must not create a temporary address
>> +	 *     with a zero Preferred Lifetime.
>> +	 *
>> +	 *     ...
>> +	 *
>> +	 *     When creating a temporary address, the lifetime values MUST be
>> +	 *     derived from the corresponding prefix as follows:
>> +	 *
>> +	 *     ...
>> +	 *
>> +	 *     *  Its Preferred Lifetime is the lower of the Preferred Lifetime
>> +	 *        of the public address or TEMP_PREFERRED_LIFETIME -
>> +	 *        DESYNC_FACTOR.
>> +	 *
>> +	 * To comply with the RFC's requirements, clamp the preferred lifetime
>> +	 * to a minimum of regen_advance, unless that would exceed valid_lft or
>> +	 * ifp->prefered_lft.
>> +	 *
>>  	 * Use age calculation as in addrconf_verify to avoid unnecessary
>>  	 * temporary addresses being generated.
>>  	 */
>>  	age = (now - tmp_tstamp + ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
>>  	if (cfg.preferred_lft <= regen_advance + age) {
>> -		in6_ifa_put(ifp);
>> -		in6_dev_put(idev);
>> -		ret = -1;
>> -		goto out;
>> +		cfg.preferred_lft = regen_advance + age + 1;
>> +		if (cfg.preferred_lft > cfg.valid_lft ||
>> +		    cfg.preferred_lft > if_public_preferred_lft) {
>> +			in6_ifa_put(ifp);
>> +			in6_dev_put(idev);
>> +			ret = -1;
>> +			goto out;
>> +		}
>>  	}
>>  
>>  	cfg.ifa_flags = IFA_F_TEMPORARY;
> 
> The above sounds reasonable to me, but I would appreciate a couple of
> additional eyeballs on it. @David, could you please have a look?
> 

I went through the set this past weekend along with the earlier thread
with the problem Dan mentioned. I think the logic is ok. Dan: did you
get a chance to test this set?

Reviewed-by: David Ahern <dsahern@kernel.org>


