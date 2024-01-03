Return-Path: <netdev+bounces-61289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4B482315A
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 17:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D491F232FB
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F96418C1A;
	Wed,  3 Jan 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/yDUxZB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373C41BDCE
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 16:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAE5C433C7;
	Wed,  3 Jan 2024 16:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704299767;
	bh=2JvocjoafpLAZMtUkb0lZ2Ycd46t524yDdLDrLMComs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e/yDUxZB22IMtyp8gmuNQUkEl/Ia+Wb2q9fWKeXDgrUddy5Oc1m2TYuWgUJYU/BHU
	 jytcL6Wgy3zbwq3/yWqP1HQ3R0eTniY6S7MpEB9RN/6GDKdN4ewVsJ8VCxVM+41XR/
	 HD6KcKR23FAQTSuJHr9dO842Wfvf+CrxqU/CvastjMnMDXn7gVVa1zHKiq9PL00yCR
	 OPTmeOT1cVYk+nQX/2r/QvZOUZFdcKkBbBZvLkFU9/3YoC167yq1iMIrM2ZRPVMdOu
	 a6ar9yai5naj1kzP9O3C+w3Qr+nKrZW6CjF5pLbOMUfM3XdMswA0Cy1FdgO9VAhmzV
	 adf7C6+fYKXeQ==
Message-ID: <3e9e4f3a-8968-4009-9e93-fe0bc8121392@kernel.org>
Date: Wed, 3 Jan 2024 09:36:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] selftests: rtnetlink: check enslaving iface in
 a bond
Content-Language: en-US
To: nicolas.dichtel@6wind.com, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>
Cc: netdev@vger.kernel.org
References: <20240103094846.2397083-1-nicolas.dichtel@6wind.com>
 <20240103094846.2397083-3-nicolas.dichtel@6wind.com>
 <2b3084da-ab85-412d-a0e8-3e50903937df@kernel.org>
 <0cc0cfc3-14d3-43d9-8fa8-b2b76b1ca14e@6wind.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <0cc0cfc3-14d3-43d9-8fa8-b2b76b1ca14e@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/3/24 9:17 AM, Nicolas Dichtel wrote:
> Le 03/01/2024 à 16:42, David Ahern a écrit :
>> On 1/3/24 2:48 AM, Nicolas Dichtel wrote:
>>> @@ -1239,6 +1240,44 @@ kci_test_address_proto()
>>>  	return $ret
>>>  }
>>>  
>>> +kci_test_enslave_bonding()
>>> +{
>>> +	local testns="testns"
>>> +	local bond="bond123"
>>> +	local dummy="dummy123"
>>> +	local ret=0
>>> +
>>> +	run_cmd ip netns add "$testns"
>>> +	if [ $? -ne 0 ]; then
>>> +		end_test "SKIP bonding tests: cannot add net namespace $testns"
>>> +		return $ksft_skip
>>> +	fi
>>> +
>>> +	# test native tunnel
>>> +	run_cmd ip -netns $testns link add dev $bond type bond mode balance-rr
>>> +	run_cmd ip -netns $testns link add dev $dummy type dummy
>>> +	run_cmd ip -netns $testns link set dev $dummy up
>>> +	run_cmd ip -netns $testns link set dev $dummy master $bond down
>>> +	if [ $ret -ne 0 ]; then
>>> +		end_test "FAIL: enslave an up interface in a bonding"
>>
>> interface is up, being put as a port on a bond and taken down at the
>> same time. That does not match this error message.
> The idea was "the command used to enslave an up interface fails".
> What about: "FAIL: set down and enslave an up interface in a bonding"

The 'set down' is part of the adding to the bond command. how about:

FAIL: Initially up interface added to a bond and set down.


