Return-Path: <netdev+bounces-14435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA8374139F
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 16:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5C61C203AB
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06E5C2E7;
	Wed, 28 Jun 2023 14:19:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EACC122
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 14:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BCFC433C8;
	Wed, 28 Jun 2023 14:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687961972;
	bh=yrVlAWiwxFJi/PSUnLEvi1oEGkS0sNHufr0RPMimCWE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=YM1IppAygzGHN4bX7d7k6Q2VpMqf5//MszBZC+ih6wU75AtTQ74afbl1qmk+6t1Rv
	 MMVMDEyz45sK6IV5iE2ddrwcMiNbbnK7+EMYQXQtuAeNXwDLzyFUlvbpdQoIXLklzp
	 HEfAtDBLEossqE8WvxDajNU1kRioww6Cf1sRB441Kweah2/4Unnb/TzGEwADLZnUPA
	 X8aiQIQXw0eizjV037noLjdItbiQFa0LaTE2BrptArYy0HBQph5tfeq4qPcNqaE8Lp
	 P5md2kIb6rlvkoc0SzH2s1BEPc2kB0Bc7ubHbUnDB2iPlK99S6iZ+/5jSsvdsDmSkg
	 SrPLI/4D9xOPg==
Message-ID: <b45cedc6-3dbe-5cbb-1938-5c33cf9fc70d@kernel.org>
Date: Wed, 28 Jun 2023 08:19:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
To: Gal Pressman <gal@nvidia.com>, Richard Gobert <richardbgobert@gmail.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, aleksander.lobakin@intel.com, lixiaoyan@google.com,
 lucien.xin@gmail.com, alexanderduyck@fb.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230601160924.GA9194@debian> <20230601161407.GA9253@debian>
 <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
 <fe5c86d1-1fd5-c717-e40c-c9cc102624ed@kernel.org>
 <b3908ce2-43e1-b56d-5d1d-48a932a2a016@nvidia.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <b3908ce2-43e1-b56d-5d1d-48a932a2a016@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/23 6:42 AM, Gal Pressman wrote:
> On 27/06/2023 17:21, David Ahern wrote:
>> On 6/26/23 2:55 AM, Gal Pressman wrote:
>>> I believe this commit broke gro over udp tunnels.
>>> I'm running iperf tcp traffic over geneve interfaces and the bandwidth
>>> is pretty much zero.
>>>
>>
>> Could you add a test script to tools/testing/selftests/net? It will help
>> catch future regressions.
>>
> 
> I'm checking internally, someone from the team might be able to work on
> this, though I'm not sure that a test that verifies bandwidth makes much
> sense as a selftest.
> 

With veth and namespaces I expect up to 25-30G performance levels,
depending on the test. When something fundamental breaks like this patch
a drop to < 1G would be a red flag, so there is value to the test.

