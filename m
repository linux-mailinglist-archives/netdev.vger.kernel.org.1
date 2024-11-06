Return-Path: <netdev+bounces-142497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7319F9BF5CB
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11380B21142
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355AA208219;
	Wed,  6 Nov 2024 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6mg0gNm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F0207A1A
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919448; cv=none; b=GnMXzAw/Afa8JlJg0z85Jv9BOpT5VJTXrl0lEXJYdeoNSR4PUrIw1R/orPR2nMjksbKjzNruhUJl5EmJtG5ICWnx1G3Ifecec850yUgSYczIuUVplOMSNxUdiW8HfjjhcsG1eV5x1OAXCBWrnP38JVrDIhq2nIVMSqu0fzN1NFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919448; c=relaxed/simple;
	bh=iaztL4lgaGUJOJlSqhcJDyDAEevvmS1wjxAiJLl1feE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jq1We1Du3pc+8KvbKyp2aa4ljRUp2qLmBYl0400zCTn0StyEjHQhfJaQuthhb9guYmQYr8jaOuRpJDsyNO5Wo3CrzFxghRLGMqycANfNcdeAPIvfjaLg+QusSF49zX6A0FzwtkTyG2MZKXE1D3E95xefHdru9KnGjs2DXI4mTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6mg0gNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA44C4CEC6;
	Wed,  6 Nov 2024 18:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730919446;
	bh=iaztL4lgaGUJOJlSqhcJDyDAEevvmS1wjxAiJLl1feE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l6mg0gNm0iwKFxjL09lsAnrycoLjFHTcq5NyF6TtvTAhiJwMRhLSEIA9k96ejQ+TC
	 0MFBC1BEjQ2K41XHcGO7tT/HHRPhxEV7LjH+Ljz2LDVHU8+hQyFtU6xJWnV7Gss4XI
	 kshSOeGMyuPBo/EFbeXQgS19fSSIL9ici17qSH8MZ2GWBlREwKOowCXlfyyVvbP2K2
	 lw6e2yeAlOUzlm3Ux3FSnC4TajinCTvWISLYGDCP80wtT7y6cMPpm8iiB9WLEiJCxk
	 d5KFKAs7jLLTPttyEx/VFhzfHKmP8/CSYi2sFINAQXELNkZqf2rC1F9ZPtTst2NyI+
	 Iwq59erSm2eFQ==
Message-ID: <ad29493c-9e48-4a94-b327-e47af3a9d137@kernel.org>
Date: Wed, 6 Nov 2024 11:57:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipv4: Cache pmtu for all packet paths if multipath
 enabled
Content-Language: en-US
To: Vladimir Vdovin <deliran@verdict.gg>, Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net
References: <20241029152206.303004-1-deliran@verdict.gg>
 <736cdd43-4c4b-4341-bd77-c9a365dec2e5@kernel.org>
 <ZyJo1561ADF_e2GO@shredder.mtl.com> <D5BTVREQGREW.3RSUZQK6LDN60@verdict.gg>
 <59b0acc7-196c-4ab8-9033-336136a47212@kernel.org>
 <D5F9OJYSMFXS.2HOGXNFVKTOLL@verdict.gg>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <D5F9OJYSMFXS.2HOGXNFVKTOLL@verdict.gg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 10:20 AM, Vladimir Vdovin wrote:
> On Tue Nov 5, 2024 at 6:52 AM MSK, David Ahern wrote:
>> On 11/2/24 10:20 AM, Vladimir Vdovin wrote:
>>>>
>>>> Doesn't IPv6 suffer from a similar problem?
>>
>> I believe the answer is yes, but do not have time to find a reproducer
>> right now.
>>
>>>
>>> I am not very familiar with ipv6,
>>> but I tried to reproduce same problem with my tests with same topology.
>>>
>>> ip netns exec ns_a-AHtoRb ip -6 r g fc00:1001::2:2 sport 30003 dport 443
>>> fc00:1001::2:2 via fc00:2::2 dev veth_A-R2 src fc00:1000::1:1 metric 1024 expires 495sec mtu 1500 pref medium
>>>
>>> ip netns exec ns_a-AHtoRb ip -6 r g fc00:1001::2:2 sport 30013 dport 443
>>> fc00:1001::2:2 via fc00:1::2 dev veth_A-R1 src fc00:1000::1:1 metric 1024 expires 484sec mtu 1500 pref medium

you should dump the cache to see the full exception list.

>>>
>>> It seems that there are no problems with ipv6. We have nhce entries for both paths.
>>
>> Does rt6_cache_allowed_for_pmtu return true or false for this test?
> It returns true.
> 
> 

Looking at the code, it is creating a single exception - not one per
path. I am fine with deferring the ipv6 patch until someone with time
and interest can work on it.

