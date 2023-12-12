Return-Path: <netdev+bounces-56573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A058B80F71E
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A241C20B33
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 19:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AAB6357B;
	Tue, 12 Dec 2023 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAoG1amb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5303463564
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 19:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E51C433C8;
	Tue, 12 Dec 2023 19:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702410490;
	bh=qDczTtlYCp7a7BcJiLC3PN8Q0SFMEEGLW9GR6eVl2jo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gAoG1ambZUOfniiu4ZYTYuQ1nq9sszRdJ1WH0mJmhFVFA36KgmFBQCL8oH9pdj8RF
	 H39v+20VO7Ci3x/pYE16b5Fuy+65d9GdtVwIMSbvjqM+AoNa5KjpTp8qAR5USzbHaL
	 X+vdh/KjT1cArDWiqoX8RbtLQdcN8oA1S31/SvrnSu8dwinbzi2+Blm5tePH2Kwx70
	 9myrzdzj6EYWM7Rl3E2d0J/i8NHzOjHwEuMldq2PUO1ozogBqtDUBw1tQ7gEWMPHug
	 s5u/XWDdQkiAt+lnrMYDrsj2Ife6bWcoBhwV1utOQnBCTtjJqYp2VPDu54+WhMZHid
	 OAjjHJEHuKxqw==
Message-ID: <133dfdf9-cfe3-422b-81d5-e7f26a192597@kernel.org>
Date: Tue, 12 Dec 2023 21:48:05 +0200
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
 <59f0dc65-127d-4668-9662-3eee2ab7af8a@kernel.org>
 <20231212145748.zuhn4o5j63ejcfyz@skbuf>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231212145748.zuhn4o5j63ejcfyz@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/2023 16:57, Vladimir Oltean wrote:
> On Tue, Dec 12, 2023 at 04:07:18PM +0200, Roger Quadros wrote:
>> What is the proper way to run the script?
>>
>> I've been hardcoding the following in the script.
>>
>> NETIFS=( "eth0" "eth1" )
>>
>> in setup_prepare()
>> 	h1=eth0
>> 	h2=eth1
>>
>> and run the script like so
>>
>> ./run_kselftest.sh -t net/forwarding:ethtool_mm.sh
> 
> IDK. I rsync the selftest dir to my board and do:
> 
> $ cd selftests/net/forwarding
> $ ./ethtool.mm eth0 eth1
> 
> Running through run_kselftest.sh is probably better. I think that also
> supports passing the network interfaces as arguments, no need to hack up
> the script.
> 
>>> diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
>>> index 39e736f30322..2740133f95ec 100755
>>> --- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
>>> +++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
>>> @@ -25,6 +25,10 @@ traffic_test()
>>>  	local after=
>>>  	local delta=
>>>  
>>> +	if [ has_pmac_stats[$netif] = false ]; then
>>
>> This should be
>> 	if [ ${has_pmac_stats[$if]} = false ]; then
>>
>> otherwise it doesn't work.
> 
> Makes sense.
> 
>>> +		src="aggregate"
>>> +	fi
>>> +
>>>  	before=$(ethtool_std_stats_get $if "eth-mac" "FramesTransmittedOK" $src)
>>>  
>>>  	$MZ $if -q -c $num_pkts -p 64 -b bcast -t ip -R $PREEMPTIBLE_PRIO
>>> @@ -284,6 +288,13 @@ for netif in ${NETIFS[@]}; do
>>>  		echo "SKIP: $netif does not support MAC Merge"
>>>  		exit $ksft_skip
>>>  	fi
>>> +
>>> +	if check_ethtool_pmac_std_stats_support $netif; then
>>> +		has_pmac_stats[$netif]=true
>>
>>
>>> +	else
>>> +		has_pmac_stats[$netif]=false
>>> +		echo "$netif does not report pMAC statistics, falling back to aggregate"
>>> +	fi
>>>  done
>>>  
>>>  trap cleanup EXIT
>>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>>> index 8f6ca458af9a..82ac6a066729 100755
>>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>>> @@ -146,6 +146,14 @@ check_ethtool_mm_support()
>>>  	fi
>>>  }
>>>  
>>> +check_ethtool_pmac_std_stats_support()
>>> +{
>>> +	local dev=$1; shift
>>> +
>>> +	[ -n "$(ethtool --json -S $dev --all-groups --src pmac 2>/dev/null | \
>>> +		jq '.[]')" ]
>>
>> This is evaluating to true instead of false on my platform so something needs to be fixed here.
>>
>> Below is the output of "ethtool --json -S eth0 --all-groups --src pmac"
>>
>> [ {
>>         "ifname": "eth0",
>>         "eth-phy": {},
>>         "eth-mac": {},
>>         "eth-ctrl": {},
>>         "rmon": {}
>>     } ]
>>
>> I suppose we want to check if eth-mac has anything or not.
>>
>> Something like this works
>>
>> 	[ 0 -ne $(ethtool --json -S $dev --all-groups --src pmac 2>/dev/null \
>> 		| jq '.[]."eth-mac" | length') ]
>>
>> OK?
> 
> Maybe giving the stats group as argument instead of hardcoding "eth-mac"
> would make sense. I hoped we could avoid hardcoding one particular group
> of counters in check_ethtool_pmac_std_stats_support().

You mean like this?

check_ethtool_pmac_std_stats_support()
{
	local dev=$1; shift
	local grp=$1; shift

	[ 0 -ne $(ethtool --json -S $dev --all-groups --src pmac 2>/dev/null \
		| jq '.[]."$grp" | length') ]
}

Caller will call like so
	check_ethtool_pmac_std_stats_support $netif eth-mac

-- 
cheers,
-roger

