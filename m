Return-Path: <netdev+bounces-185653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4373AA9B35E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71633BD77A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED0F27D78C;
	Thu, 24 Apr 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FccHDcCu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981F199949
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510749; cv=none; b=oKnccOIxNCrWQYTZ8B0RdsJ/eK3i+9WYyEYnoEaDdNTyzOtqiIC0GSqVxEiZnDzH7gXJkvHiPveH5aenRJ6c43S1/s1/INDlGL2vph14Ei41AFi+3hNZZqGwrI9yVgHMR6pUavo0fMf7icRjR3NnELVkN1a+TQfLSWsZlwFbd38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510749; c=relaxed/simple;
	bh=rCFMNy5tkXd2YhJsLn6R9RiibEH3IZ3u65ilGHKdb9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGbj+YTXmRZCJfx7AET5a8lEKY21LKgv/ZlfY5vXOZNBlicO8WPnX+nt9Nt8RD4GK8Qo88LiNU1Zhyb/U0TaOHgG8zSJ7Z8V8IHM0KVFAthve9gSWcdqQpIoXVpcVIOlXeOVXuAZqHxbNlLIrnAwK5S/vysGZ4roEpgE5SsDUgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FccHDcCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA00C4CEEB;
	Thu, 24 Apr 2025 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745510748;
	bh=rCFMNy5tkXd2YhJsLn6R9RiibEH3IZ3u65ilGHKdb9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FccHDcCu+IiuzCngYOoA1RDz2FBMmT54TsXdFckYjZm0JLxEtu4NQvoz1gwwkMLSf
	 SnYxwK8c/lZ9a3yZB5M/aF6sMf/ssqshwzFrg8mzweE5gDP3xCpJNzbRbp3eFQ/aDb
	 GeH5OkWFxW6LTN+vSmudncG8vhBobYdLjNrTyvvoGlfgPg9HQxnyxjYjBTsGOSmbZI
	 CviV1HasnwSvZhPBx8rcsgkEVKZkULZ2blIuqEBPIb5SZfFEuMyR8bbSXzOSKgMhQt
	 Bdp9YAYOd3K4LtMUkaxltK91+fKloYLhdNYIYTprDZTNMZJQ8thCOmIlWlZghAtJhj
	 xdImgzN+CiJqA==
Message-ID: <e01f4834-cf22-4585-af83-946d2d12a534@kernel.org>
Date: Thu, 24 Apr 2025 09:05:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] ip: load balance tcp connections to
 single dst addr and port
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com, kuniyu@amazon.com,
 Willem de Bruijn <willemb@google.com>
References: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
 <20250424143549.669426-3-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250424143549.669426-3-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 7:35 AM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Load balance new TCP connections across nexthops also when they
> connect to the same service at a single remote address and port.
> 
> This affects only port-based multipath hashing:
> fib_multipath_hash_policy 1 or 3.
> 
> Local connections must choose both a source address and port when
> connecting to a remote service, in ip_route_connect. This
> "chicken-and-egg problem" (commit 2d7192d6cbab ("ipv4: Sanitize and
> simplify ip_route_{connect,newports}()")) is resolved by first
> selecting a source address, by looking up a route using the zero
> wildcard source port and address.
> 
> As a result multiple connections to the same destination address and
> port have no entropy in fib_multipath_hash.
> 
> This is not a problem when forwarding, as skb-based hashing has a
> 4-tuple. Nor when establishing UDP connections, as autobind there
> selects a port before reaching ip_route_connect.
> 
> Load balance also TCP, by using a random port in fib_multipath_hash.
> Port assignment in inet_hash_connect is not atomic with
> ip_route_connect. Thus ports are unpredictable, effectively random.
> 
> Implementation details:
> 
> Do not actually pass a random fl4_sport, as that affects not only
> hashing, but routing more broadly, and can match a source port based
> policy route, which existing wildcard port 0 will not. Instead,
> define a new wildcard flowi flag that is used only for hashing.
> 
> Selecting a random source is equivalent to just selecting a random
> hash entirely. But for code clarity, follow the normal 4-tuple hash
> process and only update this field.
> 
> fib_multipath_hash can be reached with zero sport from other code
> paths, so explicitly pass this flowi flag, rather than trying to infer
> this case in the function itself.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> v1->v2
>   - add (__force __be16) to use random data as __be16
> ---
>  include/net/flow.h  |  1 +
>  include/net/route.h |  3 +++
>  net/ipv4/route.c    | 13 ++++++++++---
>  net/ipv6/route.c    | 13 ++++++++++---
>  net/ipv6/tcp_ipv6.c |  2 ++
>  5 files changed, 26 insertions(+), 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



