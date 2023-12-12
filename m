Return-Path: <netdev+bounces-56444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E21C80EE5F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0362B28146C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2377D73168;
	Tue, 12 Dec 2023 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq0e6W2o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6B61690
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 14:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D254C433C7;
	Tue, 12 Dec 2023 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702390044;
	bh=L3j/ao3RhaJxZFeEuMqwwJX3x1cbJT54cAlW9nrRPb4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eq0e6W2oGhF1FuOohuFamsGMeKupNNYZitnpTrsDjdDSC/DT1x4jlxWYDGa20m71F
	 juiDVWfEjCDrkh2daGpU2vG1Gx/KM6NuqYGuFiDPUN6MOGiRE0BXKrDYx3/uHz5XTn
	 iMpJmutzWJ/lyONPZv1PKgZ4vi35sVdp2fBAGXe9jMSL3pkLJpXjSBodRyOGTDCjGM
	 Zpl8OeQlJNLm5rsXsVREfrtCacvSOtqS6zAicBIHDOYeSIWVwHcVTjOerzKZZzXCWJ
	 +PpnzWgQhIYiSEFTKb/8PzAeH0MxX/6Q6jOS38ZHGZsF30F/9U6f/FACRis1hNFcSO
	 4Jpza4wmg7nPw==
Message-ID: <59f0dc65-127d-4668-9662-3eee2ab7af8a@kernel.org>
Date: Tue, 12 Dec 2023 16:07:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: forwarding: ethtool_mm: support devices
 that don't support pmac stats
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
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231211132415.ilhkajslbxf3wxjn@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vladimir,

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
> 2. someone mangled your patch into invalid bash syntax, splitting a line
>    into 2
> 3. "FramesTransmittedOOK" has an extra "O"
> 4. it would be preferable if you could evaluate only once whether pMAC
>    counters are reported, set a global variable, and in traffic_test(),
>    if that variable is true, override $src with "aggregate".
> 5. why did you split the selftest patches out of the am65-cpsw patch
>    set? It is for the am65-cpsw that they are needed.
> 
>>  
>>  	$MZ $if -q -c $num_pkts -p 64 -b bcast -t ip -R $PREEMPTIBLE_PRIO
>>  
>> -- 
>> 2.34.1
>>
> 
> Something like this?
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

What is the proper way to run the script?

I've been hardcoding the following in the script.

NETIFS=( "eth0" "eth1" )

in setup_prepare()
	h1=eth0
	h2=eth1

and run the script like so

./run_kselftest.sh -t net/forwarding:ethtool_mm.sh

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

This should be
	if [ ${has_pmac_stats[$if]} = false ]; then

otherwise it doesn't work.

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

This is evaluating to true instead of false on my platform so something needs to be fixed here.

Below is the output of "ethtool --json -S eth0 --all-groups --src pmac"
                                                                                                                                                                     
[ {
        "ifname": "eth0",
        "eth-phy": {},
        "eth-mac": {},
        "eth-ctrl": {},
        "rmon": {}
    } ]

I suppose we want to check if eth-mac has anything or not.

Something like this works

	[ 0 -ne $(ethtool --json -S $dev --all-groups --src pmac 2>/dev/null \
		| jq '.[]."eth-mac" | length') ]

OK?

> +}
> +
>  check_locked_port_support()
>  {
>  	if ! bridge -d link show | grep -q " locked"; then

also I had to revert a recent commit 

25ae948b4478 ("selftests/net: add lib.sh")

else i get an error message syaing ../lib.sh not found.
Looks like that is not getting deployed on kselftest-install

I will report this in the original patch thread as well.

-- 
cheers,
-roger

