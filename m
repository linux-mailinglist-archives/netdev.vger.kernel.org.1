Return-Path: <netdev+bounces-62480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241D58277F2
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 19:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83EB1B22194
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 18:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EE9537EF;
	Mon,  8 Jan 2024 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxcG2U5x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98B54F82
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 18:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D195C433C7;
	Mon,  8 Jan 2024 18:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704739974;
	bh=WV2kPKHjsGi70cOH+10+L8H8XZ6dstODp+rMcpq909U=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=QxcG2U5x2shCcjKlcoFGtbBn57H1Cs+mrDURhB6CmXktJAhuhMX65WZQ8EBbE9alC
	 eNSYSyqSdOZCEiFw0yqW0ZP0Sb0WRHfGsvSr7ygcP+Ap8Nv5hS/HOj0qAHEm3FbgL+
	 gAEi9tiMS/LnWFW2JCuyR0A+vxT9I33us45MuH2m7B4jqncRY5fmQqdLJCE0Fjmhu3
	 HcJ3zjgM+KbMfbmpoejWd+QuWCUmJmqAfk283sN3IqkCnFdIfiXNMHT+ma11ohtct8
	 2zceGkhTDfKtLWZsZ/r8HG2CamrflTLsEuT26zKClZpI6patF1rp1a23LuD4Ua+gmS
	 4o4jiylHPEdPw==
Message-ID: <fa542b36-2095-47f9-850f-029ded8e34a4@kernel.org>
Date: Mon, 8 Jan 2024 11:52:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ipv6/addrconf: make regen_advance
 independent of retrans time
To: Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org,
 dan@danm.net, bagasdotme@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jikos@kernel.org
References: <20240108155347.156525-1-alexhenrie24@gmail.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240108155347.156525-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/24 8:53 AM, Alex Henrie wrote:
> In RFC 4941, REGEN_ADVANCE is a constant value of 5 seconds, and the RFC
> does not permit the creation of temporary addresses with lifetimes
> shorter than that:
> 
>> When processing a Router Advertisement with a Prefix
>> Information option carrying a global scope prefix for the purposes of
>> address autoconfiguration (i.e., the A bit is set), the node MUST
>> perform the following steps:
> 
>> 5.  A temporary address is created only if this calculated Preferred
>>     Lifetime is greater than REGEN_ADVANCE time units.
> 
> Moreover, using a non-constant regen_advance has undesirable side
> effects. If regen_advance swelled above temp_prefered_lft,
> ipv6_create_tempaddr would error out without creating any new address.
> On my machine and network, this error happened immediately with the
> preferred lifetime set to 1 second, after a few minutes with the
> preferred lifetime set to 4 seconds, and not at all with the preferred
> lifetime set to 5 seconds. During my investigation, I found a Stack
> Exchange post from another person who seems to have had the same
> problem: They stopped getting new addresses if they lowered the
> preferred lifetime below 3 seconds, and they didn't really know why.
> 
> Some users want to change their IPv6 address as frequently as possible
> regardless of the RFC's arbitrary minimum lifetime. For the benefit of
> those users, add a regen_advance sysctl parameter that can be set to
> below or above 5 seconds.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc4941#section-3.3
> Link: https://serverfault.com/a/1031168/310447
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 20 +++++++++++++-------
>  include/linux/ipv6.h                   |  1 +
>  include/net/addrconf.h                 |  5 +++--
>  net/ipv6/addrconf.c                    | 17 +++++++++++------
>  4 files changed, 28 insertions(+), 15 deletions(-)
> 

net-next is closed; please repost in 2 weeks once it has re-opened.


