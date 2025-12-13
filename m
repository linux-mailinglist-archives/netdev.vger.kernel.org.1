Return-Path: <netdev+bounces-244601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 206EDCBB40B
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 22:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DD6730084F9
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BEB145355;
	Sat, 13 Dec 2025 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el6DbGm5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2246F41C72
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765660694; cv=none; b=pH1Uxqz8JFx2uTbQjn6f/UdPy/EkLQ90BnkInm8a13RrSoJMsSIGyvEgWyyO9ggcNLwcz1hseB3qCov/GOuTRReuELIu4U97Qanx2i4C4Sf6LdE3yNKFk8uOl09wNRabzGUSLPHtQPN8Gp0DkevmW+bbQzOksvDVqYDast2oKf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765660694; c=relaxed/simple;
	bh=QlXd29BxM8/d4upaY8hXkZV7d/pqLmkI+knft24Jw+w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZGc8LsQ1RQSLWWe/R67x2xIrNYcGFgKiX0TScSEQB1pz9Hp1kvCrfKnkKk/NlLnG6nOuHbzNo6PavJUyl3ONmhyQ3I5jBeveDtBqNHYX7JMO2DGil1h/YOyipSbYhGmhFazDVyn9qXMceGWvvrMLfGhd1A041wunP7vybrjeNZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el6DbGm5; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78ab039ddb4so22738477b3.3
        for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 13:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765660690; x=1766265490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxP0vyBqa3FoyroIspo3YpuQ/8KUpoIT2RUb7IXnK2w=;
        b=el6DbGm5QkcnuFqj8xDXvyM/TR/3cAItsEU8QNDlBxNEzWZloQ6pIq2eguqmPoVfmA
         ziQWDfksSz6qlumXuFSHCsYI5m7O86xULAChaAkuFrDvpQVUOJa6Y6FZTj2KSC6Pga65
         1Ei18kKZOxwj4WjwYvVAUs/4liwIYSdq5XXTFzZWeIXeKPqDB+u4+1ZSHpY4059+szBS
         KCVZam90coWwTdjHLxaBWCwNj4wIPbSV1TtamLaLlEHaxzjRkns6htnPzCrmWsh7Um65
         cEpvvCS8QkuF5NubEa06Eb20mwBQPcIIw1vCpjjb43z5h57EOpsSAAFGNzz+vid7Vs/e
         CSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765660690; x=1766265490;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kxP0vyBqa3FoyroIspo3YpuQ/8KUpoIT2RUb7IXnK2w=;
        b=gDjqAB9XWlD9/XzIsBazJXP+9jDJ+VAxYfTeAPI159ypijVPwEwQFKJ/nqfd9v7CMw
         IYTGj1qs/Vy9PlaPXscfalfiWBX4vOOXmJTHRPuEfO4hYIN0WG82w7WY+ijw1zASBBWz
         kiYg13xowEI1yiSbOigPCDUY9VuH78ASIOolHnC/M/A45nFekSepXWTTPMD0Z99fJHMy
         D2FXdfFhLpvUAHLiPy1t8M+tzNPbQv0TvFj+Qfoz38cIvESVhSALkTNbT/psYgSbXdyR
         2E7zhxuq3XEZsfkP8P0NBuKTrAuI96R2zajGsttT4M8wlkMdzS97+6Z778J5gMx+rkFN
         Q7Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW4lSOiSnPSj6JiptZJ2EJ8gKehKzY/uZNgBMsaIUlCOugnNCgGXyhV7V3NTOtrKTq3ni57iv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7OjUPwZ/mj1MY17/UU55SHi1dBACwm+rFghAchetIPBStUAn+
	Dmzkz/WvusLxGoMv8QVPPJ8kNRltg4R5kWY0Qm6/nCTc5MyWyDfllafS
X-Gm-Gg: AY/fxX5mfbnz+bt8CXN/AStpaY/2VPb8TeQXC7azNO8bApoFe25o6MHhhUPkZ8KaPBp
	Jv2F6MJBYbU1U76dV5WRT0XRcd4pKGP8hIYfhdzLarUYQX2Mi0gSir2/Z6U1g8ICXlM4GiT83Ri
	+srgobsT3VfkqltkmbMmkhGyTHATkFaQDYCZAEoDrR8naP88Tgan2jdn5wMf/o7ExRlj7e5oJii
	UnloV4BoWqZD4toq7wlx+iyDz5H1XZbdiSgw/VxCCZ2YiZNXkxZS6r+AcAHIlBX/58ZSXPTLTEO
	iPheECTP8eoK8vweE1fUbudrlWTymZuYgmdLNQXrWE81IrzTtUi05VJIfN4EcAJT9AnDM3TvoDG
	i92AwiCyf1GH1bU31dM7Jw2gnWDbeIe1Z378O+IWxRPzMhUJtOJjJl6aixx5xTVsH9HzI2d7Iu1
	NsYGKnyu0Xp74N5fvo+Yp1lhFUcw9lUpr+QlJBze7w/3RW9y3NEGqWi60ppGAX2Hb1dqc=
X-Google-Smtp-Source: AGHT+IEeSoWqswwMle2jNFzPcGNeAQetfwDvjKXCdznkLlWumcudO0dcnM/DPARczEizg74mcnzpxg==
X-Received: by 2002:a05:690e:bc9:b0:644:60d9:752a with SMTP id 956f58d0204a3-6455566d486mr4147195d50.92.1765660689921;
        Sat, 13 Dec 2025 13:18:09 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78e74a4f908sm10941617b3.56.2025.12.13.13.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 13:18:09 -0800 (PST)
Date: Sat, 13 Dec 2025 16:18:08 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.ord>
Cc: Shuah Khan <shuah@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Message-ID: <willemdebruijn.kernel.2568c56f18788@gmail.com>
In-Reply-To: <20251213135849.2054677-2-vadim.fedorenko@linux.dev>
References: <20251213135849.2054677-1-vadim.fedorenko@linux.dev>
 <20251213135849.2054677-2-vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net 2/2] selftests: fib_nexthops: Add test case for ipv4
 multi nexthops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> The test checks that with multi nexthops route the preferred route is the
> one which matches source ip. In case when source ip is on loopback, it
> checks that the routes are balanced.

are balanced [across .. ]

> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  tools/testing/selftests/net/fib_nexthops.sh | 85 +++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
> index 2b0a90581e2f..9d6f57399a73 100755
> --- a/tools/testing/selftests/net/fib_nexthops.sh
> +++ b/tools/testing/selftests/net/fib_nexthops.sh
> @@ -31,6 +31,7 @@ IPV4_TESTS="
>  	ipv4_compat_mode
>  	ipv4_fdb_grp_fcnal
>  	ipv4_mpath_select
> +	ipv4_mpath_select_nogrp
>  	ipv4_torture
>  	ipv4_res_torture
>  "
> @@ -375,6 +376,17 @@ check_large_res_grp()
>  	log_test $? 0 "Dump large (x$buckets) nexthop buckets"
>  }
>  
> +get_route_dev_src()
> +{
> +	local pfx="$1"
> +	local src="$2"
> +	local out
> +
> +	if out=$($IP -j route get "$pfx" from "$src" | jq -re ".[0].dev"); then
> +		echo "$out"
> +	fi
> +}
> +
>  get_route_dev()
>  {
>  	local pfx="$1"
> @@ -641,6 +653,79 @@ ipv4_fdb_grp_fcnal()
>  	$IP link del dev vx10
>  }
>  
> +ipv4_mpath_select_nogrp()

There is more going on than just not using the group feature.

Would it make sense to split this into two test patches, a base test
and a follow-on that extends with the loopback special case?

> +{
> +	local rc dev match h addr
> +
> +	echo
> +	echo "IPv4 multipath selection no group"
> +	echo "------------------------"
> +	if [ ! -x "$(command -v jq)" ]; then
> +		echo "SKIP: Could not run test; need jq tool"
> +		return $ksft_skip
> +	fi
> +
> +	IP="ip -netns $peer"
> +	# Use status of existing neighbor entry when determining nexthop for
> +	# multipath routes.
> +	local -A gws
> +	gws=([veth2]=172.16.1.1 [veth4]=172.16.2.1)
> +	local -A other_dev
> +	other_dev=([veth2]=veth4 [veth4]=veth2)
> +	local -A local_ips
> +	local_ips=([veth2]=172.16.1.2 [veth4]=172.16.2.2 [veth5]=172.16.100.1)

Why do both loopback and veth5 exist with the same local ip. Can this just be lo?
> +	local -A route_devs
> +	route_devs=([veth2]=0 [veth4]=0)
> +
> +	run_cmd "$IP address add 172.16.100.1/32 dev lo"
> +	run_cmd "$IP ro add 172.16.102.0/24 nexthop via ${gws['veth2']} dev veth2 nexthop via ${gws['veth4']} dev veth4"
> +	rc=0
> +	for dev in veth2 veth4; do
> +		match=0
> +		from_ip="${local_ips[$dev]}"
> +		for h in {1..254}; do
> +			addr="172.16.102.$h"
> +			if [ "$(get_route_dev_src "$addr" "$from_ip")" = "$dev" ]; then
> +				match=1
> +				break
> +			fi
> +		done
> +		if (( match == 0 )); then
> +			echo "SKIP: Did not find a route using device $dev"
> +			return $ksft_skip
> +		fi
> +		run_cmd "$IP neigh add ${gws[$dev]} dev $dev nud failed"
> +		if ! check_route_dev "$addr" "${other_dev[$dev]}"; then
> +			rc=1
> +			break
> +		fi
> +		run_cmd "$IP neigh del ${gws[$dev]} dev $dev"
> +	done
> +
> +	log_test $rc 0 "Use valid neighbor during multipath selection"
> +
> +	from_ip="${local_ips["veth5"]}"
> +	for h in {1..254}; do
> +		addr="172.16.102.$h"
> +		route_dev=$(get_route_dev_src "$addr" "$from_ip")
> +		route_devs[$route_dev]=1
> +	done
> +	for dev in veth2 veth4; do
> +		if [ ${route_devs[$dev]} -eq 0 ]; then
> +			rc=1
> +			break;
> +		fi
> +	done
> +
> +	log_test $rc 0 "Use both neighbors during multipath selection"
> +
> +	run_cmd "$IP neigh add 172.16.1.2 dev veth1 nud incomplete"
> +	run_cmd "$IP neigh add 172.16.2.2 dev veth3 nud incomplete"
> +	run_cmd "$IP route get 172.16.101.1"
> +	# if we did not crash, success
> +	log_test $rc 0 "Multipath selection with no valid neighbor"
> +}
> +
>  ipv4_mpath_select()
>  {
>  	local rc dev match h addr
> -- 
> 2.47.3
> 



