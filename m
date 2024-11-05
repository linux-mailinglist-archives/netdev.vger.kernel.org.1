Return-Path: <netdev+bounces-141793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E1E9BC416
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 04:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC15B21659
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62697188A15;
	Tue,  5 Nov 2024 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8U6Z00o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D5137C37
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 03:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730778758; cv=none; b=cg5yETWES5O1yFHwgkLSR1pS4d6grqKDIwNznR6FjLco/xU7W7pjNsk4YfrAM4Sm70UbVbUbLuPOBVtApR6y23vBlFkU0mFe8e3Yb98GJNaC+XGLy5f45zvj8wsQvluN6cbJMFXm4OqTMaibwq+sZKztL3AAojdkQxefpJkHBW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730778758; c=relaxed/simple;
	bh=pfVeG4MFFA34k6P9C8PtJGC8cWiDsHokC/HdvI0BwJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ng9+kLncT3eKURdEEjXnTnHJD7pA33gNy+bnAhAUmWPVJyIkM3JeJd1OZY/6JXuZcQtwcbY/qiju80JlAc9Md7arZ1TM1VEzYF8zXyswYuIMyQ9z/Vh7AcSZGc58L9D6n+SbEaMVHqjkePq2+V4CqcqLNJa+kLuyz9ZUis6UDiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8U6Z00o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EE9C4CECF;
	Tue,  5 Nov 2024 03:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730778757;
	bh=pfVeG4MFFA34k6P9C8PtJGC8cWiDsHokC/HdvI0BwJY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b8U6Z00osUo0u6ITHuyrvJnwD+d0rugVrrM5UZJ/t7g9rZFGi29i9ynPZb3G7odGz
	 b/LtWfxLDsqGI/7Rd013djn67FItCz97Qb54FXpmJ7UnTXxxoJGV4wDFs5FLYguVy7
	 lS8+MXmuv/ih9xLCOL/6LfPphEeiru7CaG/0pnKVDHf+9+HO0F7yyFAYpUiYfc0HP9
	 CT8rzXqM6Zw4sSJ9w8ety8SsE3i3N7JSwVb5yELgxiHdH0+o4/TdjR0jMp8pqYnipx
	 9ohiu6a4P7iEW74h5ukYsfL5mu9u2tJfnbbYd3fmSyb6jFsYCIe0mDYuDY8QhUohSU
	 7pQls+lDKLp8w==
Message-ID: <59b0acc7-196c-4ab8-9033-336136a47212@kernel.org>
Date: Mon, 4 Nov 2024 20:52:36 -0700
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
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <D5BTVREQGREW.3RSUZQK6LDN60@verdict.gg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/24 10:20 AM, Vladimir Vdovin wrote:
>>
>> Doesn't IPv6 suffer from a similar problem?

I believe the answer is yes, but do not have time to find a reproducer
right now.

> 
> I am not very familiar with ipv6,
> but I tried to reproduce same problem with my tests with same topology.
> 
> ip netns exec ns_a-AHtoRb ip -6 r g fc00:1001::2:2 sport 30003 dport 443
> fc00:1001::2:2 via fc00:2::2 dev veth_A-R2 src fc00:1000::1:1 metric 1024 expires 495sec mtu 1500 pref medium
> 
> ip netns exec ns_a-AHtoRb ip -6 r g fc00:1001::2:2 sport 30013 dport 443
> fc00:1001::2:2 via fc00:1::2 dev veth_A-R1 src fc00:1000::1:1 metric 1024 expires 484sec mtu 1500 pref medium
> 
> It seems that there are no problems with ipv6. We have nhce entries for both paths.

Does rt6_cache_allowed_for_pmtu return true or false for this test?

