Return-Path: <netdev+bounces-133155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A1099520E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2631C24F05
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEB51DFE01;
	Tue,  8 Oct 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGDZMnut"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B341DFD80
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398423; cv=none; b=NPKwiUPrKrkFiWUWJzc2sA6r4gT81MOXlHjHqRE59C5C7I1jBvql78Ac8CADCB+Lh9N01TEuWvhFLhMG+F92rJp5s6ZIizlYJxx1buFh1u0d/lTO+WV3bJb33Bj7hOAR0wUhkHd1hSwxrM3M8tNnNsgpFmXTwX1Mz8yyiyW2bQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398423; c=relaxed/simple;
	bh=8sQMFVJPQ8zqE7DfzlAla3wCs6BtbyAE85LmTEMzAmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGOPH5jpysr99auG4UxBvSH18Zm4RwlEC9kMx6Zxd0CeBKa7Mg1aOlTjXm41c27tyXv2ZM02tFEYfovd+Et4uSAYjDWmnph6oe14tp69K26Mb/v8nA3lrtiWR0HTY2orsYLNzAoDRC1iRHcFkCJpeTddMR+E8vFXt1ro0GQ832E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGDZMnut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86071C4CEC7;
	Tue,  8 Oct 2024 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728398422;
	bh=8sQMFVJPQ8zqE7DfzlAla3wCs6BtbyAE85LmTEMzAmk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hGDZMnutOrVDc5X/lf8PRlaSWw03Pfk6dmVno9HnwwATIxm85qprk4BnwN5gFrQZx
	 gaNi41M2pWUJYhxEwWmYZX5OKNAgrTyPzueoYsi44YKSofn9dUtgsaE+bcUggq6seO
	 6mk2bLWQjGqU2oda/rW1bS9kIXlSyoxc5Iq2Obe2bvCi7p9Prgioe2E8LscICbv9Zu
	 e1D48rp8lppCQa+yrs75Mf2JaaGEggVwycuJzHq1yZBPKPbL7TQ1ErimzFEnKLxh1F
	 8d7f0lTaE60leVmYXn1ODoxfjUnaFT94ScuoVBVU1MDjYmQ1v+VVb4L2EroKvYzNnl
	 nOJHyUlxVSnFw==
Message-ID: <2266f05b-57ae-435b-ae4b-f7ff035e6ce4@kernel.org>
Date: Tue, 8 Oct 2024 08:40:21 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: switch inet6_addr_hash() to less
 predictable hash
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20241008120101.734521-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241008120101.734521-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 6:01 AM, Eric Dumazet wrote:
> In commit 3f27fb23219e ("ipv6: addrconf: add per netns perturbation
> in inet6_addr_hash()"), I added net_hash_mix() in inet6_addr_hash()
> to get better hash dispersion, at a time all netns were sharing the
> hash table.
> 
> Since then, commit 21a216a8fc63 ("ipv6/addrconf: allocate a per
> netns hash table") made the hash table per netns.
> 
> We could remove the net_hash_mix() from inet6_addr_hash(), but
> there is still an issue with ipv6_addr_hash().
> 
> It is highly predictable and a malicious user can easily create
> thousands of IPv6 addresses all stored in the same hash bucket.
> 
> Switch to __ipv6_addr_jhash(). We could use a dedicated
> secret, or reuse net_hash_mix() as I did in this patch.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/addrconf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



