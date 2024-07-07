Return-Path: <netdev+bounces-109696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDB6929911
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 19:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AC31F21307
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 17:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936C33CF51;
	Sun,  7 Jul 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot5d1zwq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6561429B
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371697; cv=none; b=N5eL7P3OJWNt9ws1yL/pqHdOy5KVyIPpfI/xvodGhFKaeBnqkGSacSKI8/HbDhudzZYrbdFKtgFlsoOC4/o1n+elhXnd/9dtWCM719wRs+sD1c5lnDo6gFw3oqITvJ5VVqAdsftZcMedG6nLz8ZFRimNDZdo5sL4QgetALfNplY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371697; c=relaxed/simple;
	bh=Nvob+T+3pcV0H5xm8DUHEs/RXZYr0VKmbc3x0yzfOyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fd4tHgGdKqcNU62w52/QyOIQ8Z0ZKSd/EWpeoyETw7G6JhOym+eFaHDMNrGF78yIqvv+G3ZgT7PCdUtLeFMwwcRMPFXlYCgJ2dNocp243/QxyM9PKJX/VtD3bZi5Zl7xUr9xPtqE6WTqkztxuavZS10etfd87nUGa1PeRBlHapE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot5d1zwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B476AC3277B;
	Sun,  7 Jul 2024 17:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720371697;
	bh=Nvob+T+3pcV0H5xm8DUHEs/RXZYr0VKmbc3x0yzfOyw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ot5d1zwq3vluUpyxdqapG+iLA6ygndzYrJhDm2p4Qy+yiU8G68/TU+O3+0lc0jqb8
	 Z+VI1RQSFU4b0yNZOjpqd3VnOBU6UWbyInueBInam/cqDJTPeU73dEPgEN6i9Y1ML+
	 HGWgxhOaP6dnnkPKTX0ujI4wjx5Q56bLLXvNq0MzC1fO/4jS3TeMY2pPW1zyEWwQDS
	 RPbhf3nPLhVM6zCHPo60YWbD7beMJ74Z7gyoP/E88u+yjxTLSHmJzingxB2Kwde8il
	 Bzojxt5vJYW5fRpfZjzLe0H5izhVPNINcFx3o0pZUQmJkvQb67LxWKCzCUp7ESxbFx
	 /eEUs6Q9gtECQ==
Message-ID: <7c0f83b1-5b62-4c47-8112-94adde090314@kernel.org>
Date: Sun, 7 Jul 2024 11:01:36 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 4/4] selftests: vrf_route_leaking: add local ping
 test
Content-Language: en-US
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
References: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
 <20240705145302.1717632-5-nicolas.dichtel@6wind.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240705145302.1717632-5-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/5/24 8:52 AM, Nicolas Dichtel wrote:
> diff --git a/tools/testing/selftests/net/vrf_route_leaking.sh b/tools/testing/selftests/net/vrf_route_leaking.sh
> index 2da32f4c479b..1fd8ceb0711c 100755
> --- a/tools/testing/selftests/net/vrf_route_leaking.sh
> +++ b/tools/testing/selftests/net/vrf_route_leaking.sh
> @@ -533,6 +533,30 @@ ipv6_ping_frag_asym()
>  	ipv6_ping_frag asym
>  }
>  
> +ipv4_ping_local()
> +{
> +	log_section "IPv4 (sym route): VRF ICMP local error route lookup ping"
> +
> +	setup_sym
> +
> +	check_connectivity || return
> +
> +	run_cmd ip netns exec $r1 ip vrf exec blue ping -c1 -w1 ${H2_N2_IP}
> +	log_test $? 0 "VRF ICMP local IPv4"
> +}
> +
> +ipv6_ping_local()
> +{
> +	log_section "IPv6 (sym route): VRF ICMP local error route lookup ping"
> +
> +	setup_sym
> +
> +	check_connectivity6 || return
> +
> +	run_cmd ip netns exec $r1 ip vrf exec blue ${ping6} -c1 -w1 ${H2_N2_IP6}
> +	log_test $? 0 "VRF ICMP local IPv6"
> +}

please add tcp and udp tests as well.


