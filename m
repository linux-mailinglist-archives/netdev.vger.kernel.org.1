Return-Path: <netdev+bounces-107196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC62B91A463
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E601283071
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303B3148313;
	Thu, 27 Jun 2024 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hz7N613c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB8C14830A
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719485859; cv=none; b=uHK5+U/wUAmYyZZK0ic+BBgRgb/9app/q2nbEb7fcMypNg46/BvZRYqKIWAOkr43vMqyG9oZU7nzAUFeOFc9of6sI4Iog+h3X8f6LaboWv/6o/d5N7+yG2uqEeShFk3azcDQ2b6PY0uexiIsP7bXgCJdvgcn9aHVdQmJFqN/Lc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719485859; c=relaxed/simple;
	bh=71oNo4w/OjGEfIImXQWy8FQ8MSSfGzGDVcDatKDnhQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bini6eU6dpgFcEWMy6Orh8rTa9EG/fh9BLZTi0EcV1kKoNFH6bMZXYFIkGvPWycTm+WAE4cwkXzj4YRrvn/mg4avs4qv+d1K1nbnQwEOA7+zXMSRhSveF+bR7lb5/upUYu2XOrQj2pJCgjtc9KDLBJyzZRzmTQkwy977KemZtBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hz7N613c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E72C2BBFC;
	Thu, 27 Jun 2024 10:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719485858;
	bh=71oNo4w/OjGEfIImXQWy8FQ8MSSfGzGDVcDatKDnhQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hz7N613c4TpcafgARSdmpoJ8HW2Q9k6yIMDg40fvYRouX2Wqmdh+ufasePFHCkbC2
	 lSPisEVIjLhUTXpuplz1mIqi5lKB25Mm0Lb9DXXSVhX46iKQz/Za+QDazkiwVzvXI8
	 f7hk54Xc08kadU7YCmJa4zmhYYqOkinEa47XPM6EJMvTM+TJJTZMCEf4ZS9Hp/J4VM
	 FYpKw7oXE7DEWSpmqecB8sdcupUASUEvoZJLmdbkhkVUy/1YU+BmdnKFnMeW3BHLVU
	 VY2osEanUnzz7o2lB2qUYhY64RtePFWpE80RbY88BxZ0dnZ9TVfdCeHUxQzAJ2bN18
	 egi9qhbw89GaA==
Date: Thu, 27 Jun 2024 11:57:34 +0100
From: Simon Horman <horms@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net 4/4] selftests: vrf_route_leaking: add local ping test
Message-ID: <20240627105734.GF3104@kernel.org>
References: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
 <20240624130859.953608-5-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624130859.953608-5-nicolas.dichtel@6wind.com>

On Mon, Jun 24, 2024 at 03:07:56PM +0200, Nicolas Dichtel wrote:
> The goal is to check that the source address selected by the kernel is
> routable when a leaking route is used.
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  .../selftests/net/vrf_route_leaking.sh        | 38 ++++++++++++++++++-
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/vrf_route_leaking.sh b/tools/testing/selftests/net/vrf_route_leaking.sh
> index 2da32f4c479b..6c59e0bbbde3 100755
> --- a/tools/testing/selftests/net/vrf_route_leaking.sh
> +++ b/tools/testing/selftests/net/vrf_route_leaking.sh
> @@ -533,6 +533,38 @@ ipv6_ping_frag_asym()
>  	ipv6_ping_frag asym
>  }
>  
> +ipv4_ping_local()
> +{
> +	local ttype="$1"
> +
> +	[ "x$ttype" = "x" ] && ttype="$DEFAULT_TTYPE"

Hi Nicolas,

I see this pattern already elsewhere in this file, but shellecheck flags that:

1. No arguments are passed to ipv4_ping_local
2. The condition can be more simply expressed as [ "$ttype" = "" ]
   (my 2c worth would be [ -z "$ttype" ])

Nit picking aside, I'm genuinely curious about 1, is it actually the case?

> +
> +	log_section "IPv4 ($ttype route): VRF ICMP local error route lookup ping"
> +
> +	setup_"$ttype"
> +
> +	check_connectivity || return
> +
> +	run_cmd ip netns exec $r1 ip vrf exec blue ping -c1 -w1 ${H2_N2_IP}
> +	log_test $? 0 "VRF ICMP local IPv4"
> +}

...

> @@ -594,12 +626,14 @@ do
>  	ipv4_traceroute|traceroute)      ipv4_traceroute;;&
>  	ipv4_traceroute_asym|traceroute) ipv4_traceroute_asym;;&
>  	ipv4_ping_frag|ping)             ipv4_ping_frag;;&
> +	ipv4_ping_local|ping)            ipv4_ping_local;;&
>  
>  	ipv6_ping_ttl|ping)              ipv6_ping_ttl;;&
>  	ipv6_ping_ttl_asym|ping)         ipv6_ping_ttl_asym;;&
>  	ipv6_traceroute|traceroute)      ipv6_traceroute;;&
>  	ipv6_traceroute_asym|traceroute) ipv6_traceroute_asym;;&
>  	ipv6_ping_frag|ping)             ipv6_ping_frag;;&
> +	ipv6_ping_local|ping)            ipv6_ping_local;;&
>  
>  	# setup namespaces and config, but do not run any tests
>  	setup_sym|setup)                 setup_sym; exit 0;;
> -- 
> 2.43.1
> 
> 

