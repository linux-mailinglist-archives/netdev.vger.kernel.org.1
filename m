Return-Path: <netdev+bounces-55897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED61D80CBBB
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3211C21296
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F318247A45;
	Mon, 11 Dec 2023 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8nKFyWn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6347A41
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5324BC433CD;
	Mon, 11 Dec 2023 13:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302834;
	bh=8e8vQE70TfsTGeC+ewIHkiniZer9gGFAlcUgFP8KlDo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L8nKFyWnOjDJobGOr48MeChHm9Cnmg963UAqSvR6+Xa+YGhCpvbEHqHjThCP+RSqt
	 rf/8krZonUlBQsI9w4g72WAhA08R1zUavq5Zwl1EaZD9WXS0rXzFz6p746JMJ/Jj/b
	 vrvIeSPtQSB9kNuwO91o94O/iGRDFlNuujM3X7D44khacdq0pLUkcxXtwcHQvbbBn2
	 LmnIQ2kx7D/1yHcQmx2QEFCJbPPEhSmvq2EfeHgTuBP4k9jj2XeJrBp4SpJ2cJyP5s
	 B9kWjz/HAnvhFDhQe7I9X/dCCPn46YkBubvb0HSCAhRDwWAWsLG3DEVBc+o9DYozeE
	 szg5xWMAv4lsw==
Message-ID: <15f77150-f946-46a9-9af4-383f9be23369@kernel.org>
Date: Mon, 11 Dec 2023 15:53:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: forwarding: ethtool_mm: support devices
 that don't support pmac stats
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, horms@kernel.org,
 p-varis@ti.com, netdev@vger.kernel.org
References: <20231211120138.5461-1-rogerq@kernel.org>
 <20231211120138.5461-1-rogerq@kernel.org>
 <20231211120138.5461-3-rogerq@kernel.org>
 <20231211120138.5461-3-rogerq@kernel.org>
 <20231211132415.ilhkajslbxf3wxjn@skbuf>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231211132415.ilhkajslbxf3wxjn@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/2023 15:24, Vladimir Oltean wrote:
> On Mon, Dec 11, 2023 at 02:01:38PM +0200, Roger Quadros wrote:
>> Some devices do not support individual 'pmac' and 'emac' stats.
>> For such devices, resort to 'aggregate' stats.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  tools/testing/selftests/net/forwarding/ethtool_mm.sh | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
>> index 6212913f4ad1..e3f2e62029ca 100755
>> --- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
>> +++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
>> @@ -26,6 +26,13 @@ traffic_test()
>>  	local delta=
>>  
>>  	before=$(ethtool_std_stats_get $if "eth-mac" "FramesTransmittedOK" $src)
>> +	# some devices don't support individual pmac/emac stats,
>> +	# use aggregate stats for them.
>> +        if [ "$before" == null ]; then
>> +                src="aggregate"
>> +                before=$(ethtool_std_stats_get $if "eth-mac" "FramesTransmittedOO
>> +K" $src)
>> +        fi
> 
> 1. please follow the existing indentation scheme, don't mix tabs with spaces

Sure. Will fix.

> 2. someone mangled your patch into invalid bash syntax, splitting a line
>    into 2
> 3. "FramesTransmittedOOK" has an extra "O"

Will fix. The mangling happened at my end.

> 4. it would be preferable if you could evaluate only once whether pMAC
>    counters are reported, set a global variable, and in traffic_test(),
>    if that variable is true, override $src with "aggregate".
> 5. why did you split the selftest patches out of the am65-cpsw patch
>    set? It is for the am65-cpsw that they are needed.

Needed for the tests to pass, yes.
I'll add them back at the beginning of the series.

> 
>>  
>>  	$MZ $if -q -c $num_pkts -p 64 -b bcast -t ip -R $PREEMPTIBLE_PRIO
>>  
>> -- 
>> 2.34.1
>>
> 
> Something like this?

Thanks for the hint!

> 
> From ef5688a78908d99b607909fd7c93829c6a018b61 Mon Sep 17 00:00:00 2001
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Date: Mon, 11 Dec 2023 15:21:25 +0200
> Subject: [PATCH] selftests: forwarding: ethtool_mm: fall back to aggregate if
>  device does not report pMAC stats
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  tools/testing/selftests/net/forwarding/ethtool_mm.sh | 11 +++++++++++
>  tools/testing/selftests/net/forwarding/lib.sh        |  8 ++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> index 39e736f30322..2740133f95ec 100755
> --- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> +++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> @@ -25,6 +25,10 @@ traffic_test()
>  	local after=
>  	local delta=
>  
> +	if [ has_pmac_stats[$netif] = false ]; then
> +		src="aggregate"
> +	fi
> +
>  	before=$(ethtool_std_stats_get $if "eth-mac" "FramesTransmittedOK" $src)
>  
>  	$MZ $if -q -c $num_pkts -p 64 -b bcast -t ip -R $PREEMPTIBLE_PRIO
> @@ -284,6 +288,13 @@ for netif in ${NETIFS[@]}; do
>  		echo "SKIP: $netif does not support MAC Merge"
>  		exit $ksft_skip
>  	fi
> +
> +	if check_ethtool_pmac_std_stats_support $netif; then
> +		has_pmac_stats[$netif]=true
> +	else
> +		has_pmac_stats[$netif]=false
> +		echo "$netif does not report pMAC statistics, falling back to aggregate"
> +	fi
>  done
>  
>  trap cleanup EXIT
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 8f6ca458af9a..82ac6a066729 100755
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -146,6 +146,14 @@ check_ethtool_mm_support()
>  	fi
>  }
>  
> +check_ethtool_pmac_std_stats_support()
> +{
> +	local dev=$1; shift
> +
> +	[ -n "$(ethtool --json -S $dev --all-groups --src pmac 2>/dev/null | \
> +		jq '.[]')" ]
> +}
> +
>  check_locked_port_support()
>  {
>  	if ! bridge -d link show | grep -q " locked"; then

-- 
cheers,
-roger

