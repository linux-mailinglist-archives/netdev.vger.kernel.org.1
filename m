Return-Path: <netdev+bounces-58762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B01818033
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 04:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E841C231C7
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 03:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A05F46A5;
	Tue, 19 Dec 2023 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAptozQe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55DBE79
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 03:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA8EC433C7;
	Tue, 19 Dec 2023 03:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702956133;
	bh=/NG1/kY5qKBtfobyTEJXH0D53immN0qWfP8+Hf8WEfA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WAptozQevlbmbpWs+NJr3tMbospaaGaV0kXK0yAh+RWi9Jayl2t34FV4RT+rrVrL+
	 HsFx0v6AvQLhL8Yp97JidLEcLkN5Kk531wamc41H0e5ggNUAEfe4YU1bDmxOr+lDwh
	 OsVDD0wLjl3ZG087r83b1MceBjI7H69vJ4QkT5mGvBbvl3HVC/URpbqKDyZF0/VbTT
	 j3VnISpnsDV/tM4HU+fZTDDCamdkxSTrXFr9zab/eSrstOAH9ZXiE0nfiLXq17njj5
	 pev8yzvbzuKx3QJ/UpW8jKfMHi/zdhZ/yIfNdmaEWjczs5gsIt7vx/DgDq+Y5D8s9/
	 7I7ZV4Ocn4h8A==
Message-ID: <e8fe542c-80ba-4ca2-a1fa-ec6d29194e81@kernel.org>
Date: Mon, 18 Dec 2023 20:22:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/ipv6: Revert remove expired routes with a
 separated list of routes
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, Kui-Feng Lee <thinker.li@gmail.com>
References: <20231217185505.22867-1-dsahern@kernel.org>
 <a289e845-f244-48a4-ba75-34ce027c0de4@gmail.com>
 <c3ae9c3a-9ecd-4b22-a908-9da587c1c88b@kernel.org>
 <9e8f86e1-8663-4bbb-baa9-fe0030dbbabd@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <9e8f86e1-8663-4bbb-baa9-fe0030dbbabd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/18/23 7:45 PM, Kui-Feng Lee wrote:
> 
> 
> On 12/18/23 18:38, David Ahern wrote:
>> On 12/18/23 6:14 PM, Kui-Feng Lee wrote:
>>>
>>>
>>> On 12/17/23 10:55, David Ahern wrote:
>>>> Revert the remainder of 5a08d0065a915 which added a warn on if a fib
>>>> entry is still on the gc_link list, and then revert  all of the commit
>>>> in the Fixes tag. The commit has some race conditions given how expires
>>>> is managed on a fib6_info in relation to timer start, adding the entry
>>>> to the gc list and setting the timer value leading to UAF. Revert
>>>> the commit and try again in a later release.
>>>
>>> May I know what your concerns are about the patch I provided?
>>> Even I try it again later, I still need to know what I miss and should
>>> address.
>>
>> This is a judgement call based on 6.7-rc number and upcoming holidays
>> with people offline. A bug fix is needed for a performance optimization;
>> the smart response here is to revert the patch and try again after the
>> holidays.
> Got it! Thanks!

In January, send a new set (RFC if it is still the merge window) with
the following:

1. audit all of the uses of RTF_EXPIRES. Some of the places need to be
cleaned up first. For example, rt6_add_dflt_router sets RTF_EXPIRES flag
but does not set fc_expires. I believe that function can be updated to
take the expires value and removes the need to set it later in
ndisc_router_discovery. See if the management of expires value can be
consolidated under the table lock.

2. Use gc_list instead of gc_link to be consistent with other gc lists
(and the fact that it is a list)

3. Add selftests using veth and namespaces to test RAs. It can depend on
and check for the existence of the ra or radvd command; the key is to
attempt a stress test on the router discovery path. Similarly for addrconf.

That is in addition to your new selftests in the last set you sent.

