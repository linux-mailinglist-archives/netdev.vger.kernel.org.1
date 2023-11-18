Return-Path: <netdev+bounces-48951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733BB7F0225
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 20:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1572280E8B
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 19:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352171A700;
	Sat, 18 Nov 2023 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h+5eiAAZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F2F84
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 11:00:46 -0800 (PST)
Message-ID: <8039ce7e-df3c-4195-b5cf-a10211c770ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700334045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVuta+h3EcKrfQEssHO8nWg2MAtI0onueMyKiIQ19WE=;
	b=h+5eiAAZl//UcyBvYzq9sMuCpTL/7n3a8+scli3Q/3AwtsdNQ+tk00ffPrxS+mnVJSHum4
	esB8Zgq7uCEWG5Ldj/22sD62dP0R6DTjm65aBa1XVRNclfi6FubAWvXD01z+HD2RA5sK1Z
	vE4FdDWidDoaVp+HUCc2iYA8Wn9z1vw=
Date: Sat, 18 Nov 2023 19:00:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next 08/14] net/mlx5e: Introduce lost_cqe statistic counter
 for PTP Tx port timestamping CQ
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>
References: <20231113230051.58229-1-saeed@kernel.org>
 <20231113230051.58229-9-saeed@kernel.org>
 <b6f7e7b9-163b-4c84-ad64-53bb147e8684@linux.dev> <87bkbtpjck.fsf@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <87bkbtpjck.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/11/2023 14:51, Rahul Rameshbabu wrote:
> On Tue, 14 Nov, 2023 10:22:43 -0500 Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
>> On 13/11/2023 15:00, Saeed Mahameed wrote:
>>> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>>> Track the number of times the a CQE was expected to not be delivered on PTP
>>> Tx port timestamping CQ. A CQE is expected to not be delivered of a certain
>>> amount of time passes since the corresponding CQE containing the DMA
>>> timestamp information has arrived. Increment the late_cqe counter when such
>>> a CQE does manage to be delivered to the CQ.
>>>
>>
>> It looks like missed/late timestamps is common problem for NICs. What do
>> you think about creating common counters in ethtool to have general
>> interface to provide timestamps counters? It may simplify things a lot.
> 
> Hi Vadim,
> 
> I just took a look at the tree and believe devices supported by the
> following drivers have missed/late timestamps.
> 
>    - mlx5
>    - i40e
>    - ice
>    - stmicro
> 
> The above is from a very precursory grep through the netdev tree and
> maybe inaccurate/incomplete.
> 
> You probably saw that Saeed already pulled out our vendor specific stat
> counters from his v2 submission. Lets discuss the more appropriate
> common counters in ethtool.
> 
> Similar to fec-stat in Documentation/netlink/specs/ethtool.yaml, should
> we make a new statistics group for these timestamp related counters
> (timestamp-stat) as follows?
> 
>    1. Implement an ethtool_timestamp_stats struct in ethtool.h
>    2. Add the relevant callback support in ethtool
>    3. Add the correct spec changes in the ynl spec.
>    4. Implement the callback in the appropriate drivers
>    5. Separately prepare relevant userspace changes for ethtool.
> 
> If this seems reasonable, I can start preparing an RFC to send out to
> the mailing list.

Hi Rahul!

Thanks for taking care of this. The list of drivers seems reasonable at
the first look. But I believe more vendors will jump into it once the
spec is ready.

The new group in the ethtool yml spec seams reasonable. The steps
provided look good, I'll be happy to review your RFC patches.

Thanks,
Vadim


