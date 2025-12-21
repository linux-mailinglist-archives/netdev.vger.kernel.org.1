Return-Path: <netdev+bounces-245644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8B7CD4299
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 16:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADAC63005284
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8602FDC40;
	Sun, 21 Dec 2025 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDb1qHg4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D51230BF6
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766332761; cv=none; b=iVS69fXPWp4Gfy/E6uIa3juI1h7ycHxFXZdNzmqhXPk4tZrmYXDOh5vYzn14tJZL7+m1D3woSqDqcCWCawhbqGfoQt66Wlbo2UsaxzzHp/ndXw2rsS5IVDWdiJmLy7XP6ip3RrUkE4t6p4aRcvhMUDbzFaH7KaHLa4O9OO3Ms6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766332761; c=relaxed/simple;
	bh=MtUBS4xGnK4wE5fi/FDlNFa/0vKaJk4Ms38RWj5+L1c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jvr2sjSyNpBzQLDwypCHCwTDQanCSSnlU68fdCEac67R5ti0yJVuaxmAtnfNPE9xihqrs4OMOjaAbmdBtRYJ/Ob1ZzAiheqGInat27/YcuwNEwQvbNxSstdKKLr3nCYKV6WWSebdXOHunYIgFGtlRZjEL95u8vwjvqUITGEY3UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDb1qHg4; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78fd6189c88so2151407b3.0
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 07:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766332759; x=1766937559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNSdPBk3V0ReeruxDeFVBGsdwB3Xhk69mnYONF3p3NM=;
        b=SDb1qHg4CXi44XKIphQ2ei1Ab7cJt+MbOY9863ewnAkumb7BHM3KSziVLeLw1cWQxz
         uWQf39QJLgTEpz7CYF29GMhaVmsQxFTM0xIxiVUYCe0+diWUAkotDWefkt9dZPoEZfh5
         fq1x9CixhCQ++pBWWWQUYJCo/dKqkyrie/O0pxz9k7tofsdnxaEMEaSbPIguygQXlsIV
         8Zb5erUlp55i65Tc4zuxZsEnFxJEj4UX6KVGu7+Jze6WKn+EWFUgdqbDEOL5aDeE7+lE
         aWIXLkJMVTdKXMeY8feLU/Yu3KHRLHlRvt8udEklh9pVgXl2UQOlHf3DpyraaRCpFJd6
         K9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766332759; x=1766937559;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNSdPBk3V0ReeruxDeFVBGsdwB3Xhk69mnYONF3p3NM=;
        b=ZQsipgshfYJBfgdHEHL16Xk1DBbpBksZkAoHqHfleDIrOU9sHJlOEErRCKrsfB7dsJ
         dCjBCk1oBA5Z/iCkEVpbKvwb6mPgMThHxj7QvcfAg6oFrzZa2WTNfv9Fqvs1A5miNG8J
         njdPt0wvuaNiki414ttyrHl6evu9T9W6PQPLr8K/rAI381Uwypv3fw5AkUFk1DMQMCP+
         GZVQ51tIqazIk0VT+BW7geESkGr67TUl35Et8m4E77Mt8o/d3z7PyyyAqMMEm9mXc/VI
         CGVvlb8wSQ2cYa44JXj1sWlqOMIUERGzd7eJIQMwJkui3h/Z/FGsuH+Du21PM4b6n6IA
         wcxw==
X-Forwarded-Encrypted: i=1; AJvYcCUyLqQCpbWUxYvz739IVjNc9j02leWykC20r1mfYVs718vjecCxw7vKR5CyDSDKE1SdvLaiN/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytrLUTIwJhq0hLty5wtAl8isCsIeX+elHxUq1ivdO0R34nVIaa
	SUVqn7FXF/1wml0QAro//5UjhtrzFSmIhcJkIl9oIWZtFx+UAYmTt1KI
X-Gm-Gg: AY/fxX4oJNAzVDY4BXg1JE0P+AJRAWwJiGvB+fTpBGOmu+3b2D2FwB43wyyH41fulKk
	FC464ZzfzSOKEe5LCwaUG1/r+iN4yKr9jd+Yr+K7ILPDIAqdtu2JSyPatKWa3vrmYUMKf35iqpD
	enw4NguwZYQNbjssv8wwpkslc3FMRyxDGgkc/BWCHj8FsbtQau6GSUNJLbdkrcFOc/WNXtolSii
	AFStgynZzi35zTutsttvOAcONFOXYf6KDrAUJmkQNmPFq4pDeyRUAEokLlLzy6psHxn4Q42MpCB
	VP5Waa9PMuC7321SZHbZZeT6L/pEKBgBFs9NtlHuG7EfpwR1mr5xtNP2oYzeJcKbpcJhLQfasHK
	ftddEwEr2fLbRF6GLWWuQLNmVIoeI5ODIsiX61pCOwL8fhuyuqA2Co/bPJKhbGTTtEaPAE3W08n
	KhzinptzzEMDokc/fHNV8Zmzn65ahLtjYkbWQ7D+BlrtCh7/h0XSONXg+yJSbhaaaZiOQ=
X-Google-Smtp-Source: AGHT+IGF+VpTiOMDUWzWEtigEDLCqB+tCQ//FVIu/7r5ZeP1B6gsQjy211tNlXOlJsHzAdCr9FTJlA==
X-Received: by 2002:a05:690c:905:b0:78d:b1e9:85e7 with SMTP id 00721157ae682-78fb4059869mr75758977b3.53.1766332759276;
        Sun, 21 Dec 2025 07:59:19 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78fb451ba61sm33755087b3.39.2025.12.21.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 07:59:18 -0800 (PST)
Date: Sun, 21 Dec 2025 10:59:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Message-ID: <willemdebruijn.kernel.14a486c1824f2@gmail.com>
In-Reply-To: <20251220032335.3517241-2-vadim.fedorenko@linux.dev>
References: <20251220032335.3517241-1-vadim.fedorenko@linux.dev>
 <20251220032335.3517241-2-vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net v2 2/2] selftests: fib_test: Add test case for ipv4
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
> one which matches source ip. In case when source ip is on dummy
> interface, it checks that the routes are balanced.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> v1 -> v2:
> - move tests to fib_tests.sh
> ---
>  tools/testing/selftests/net/fib_tests.sh | 70 +++++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
> index a88f797c549a..c5694cc4ddd2 100755
> --- a/tools/testing/selftests/net/fib_tests.sh
> +++ b/tools/testing/selftests/net/fib_tests.sh
> @@ -12,7 +12,7 @@ TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
>         ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
>         ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test \
>         ipv4_mpath_list ipv6_mpath_list ipv4_mpath_balance ipv6_mpath_balance \
> -       fib6_ra_to_static"
> +       ipv4_mpath_balance_preferred fib6_ra_to_static"
>  
>  VERBOSE=0
>  PAUSE_ON_FAIL=no
> @@ -2751,6 +2751,73 @@ ipv4_mpath_balance_test()
>  	forwarding_cleanup
>  }
>  
> +get_route_dev_src()
> +{
> +	local pfx="$1"
> +	local src="$2"

only with my highly pedantic hat on, and only if respinning: these can be local -r

> +	local out
> +
> +	if out=$($IP -j route get "$pfx" from "$src" | jq -re ".[0].dev"); then
> +		echo "$out"
> +	fi
> +}
> +
> +ipv4_mpath_preferred()
> +{
> +	local src_ip=$1
> +	local pref_dev=$2
> +	local dev routes
> +	local route0=0
> +	local route1=0
> +	local pref_route=0
> +	num_routes=254
> +
> +	for i in $(seq 1 $num_routes) ; do
> +		dev=$(get_route_dev_src 172.16.105.$i $src_ip)

Similarly, I was going to ask to avoid open coding the ip prefixes
repeatedly. But that is the style in this file, so fine to follow.

> +		if [ "$dev" = "$pref_dev" ]; then
> +			pref_route=$((pref_route+1))
> +		elif [ "$dev" = "veth1" ]; then
> +			route0=$((route0+1))
> +		elif [ "$dev" = "veth3" ]; then
> +			route1=$((route1+1))
> +		fi
> +	done
> +
> +	routes=$((route0+route1))
> +
> +	[ "$VERBOSE" = "1" ] && echo "multipath: routes seen: ($route0,$route1,$pref_route)"
> +
> +	if [ x"$pref_dev" = x"" ]; then
> +		[[ $routes -ge $num_routes ]] && [[ $route0 -gt 0 ]] && [[ $route1 -gt 0 ]]
> +	else
> +		[[ $pref_route -ge $num_routes ]]
> +	fi
> +
> +}
> +
> +ipv4_mpath_balance_preferred_test()
> +{
> +	echo
> +	echo "IPv4 multipath load balance preferred route"
> +
> +	forwarding_setup
> +
> +	$IP route add 172.16.105.0/24 \
> +		nexthop via 172.16.101.2 \
> +		nexthop via 172.16.103.2
> +
> +	ipv4_mpath_preferred 172.16.101.1 veth1
> +	log_test $? 0 "IPv4 multipath loadbalance from veth1"
> +
> +	ipv4_mpath_preferred 172.16.103.1 veth3
> +	log_test $? 0 "IPv4 multipath loadbalance from veth3"
> +
> +	ipv4_mpath_preferred 198.51.100.1
> +	log_test $? 0 "IPv4 multipath loadbalance from dummy"
> +
> +	forwarding_cleanup
> +}
> +
>  ipv6_mpath_balance_test()
>  {
>  	echo
> @@ -2861,6 +2928,7 @@ do
>  	ipv6_mpath_list)		ipv6_mpath_list_test;;
>  	ipv4_mpath_balance)		ipv4_mpath_balance_test;;
>  	ipv6_mpath_balance)		ipv6_mpath_balance_test;;
> +	ipv4_mpath_balance_preferred)	ipv4_mpath_balance_preferred_test;;
>  	fib6_ra_to_static)		fib6_ra_to_static;;
>  
>  	help) echo "Test names: $TESTS"; exit 0;;
> -- 
> 2.47.3
> 



