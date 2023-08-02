Return-Path: <netdev+bounces-23470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2266376C178
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 02:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465911C21130
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3BC36B;
	Wed,  2 Aug 2023 00:26:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4747F
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8269C433C9;
	Wed,  2 Aug 2023 00:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690935987;
	bh=FRDta14x+I1PWkHXGZnBSnTYC19APGnHI3HxpdBTwBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XnVx+XX9iLmgipVPcQeptmg1BWItONeGhcFT7NmHywNrD/4wApmxm0MklnNV+e5t6
	 SSfhc7f7pE7QpdAqhzOgH6c7N4B4/vP875XYqxS9ZjKz/01uQdHXWtRkPM4WLktoQ5
	 enRKmbWUHhT226fausfmB8eJAyauFeXlZhJIoxTR8KEcQtYz0CBiLL6pseUHgWjiqK
	 UxpKpAMNHBQZ3LBgNpfTwYXupuoBG+VT8oa8JUNkiQlAzesGsTeBueOsoTSiVMpBsE
	 sdHfTTeWlHz/5tcuBfLJIMXfbhE9UmXM0UMElvyC1DWecNxm7lOSgkr2mVIqUpXrnk
	 DvHrBfj7P9SdA==
Message-ID: <802d3a2f-c2fb-2e11-b678-e8716ef93f12@kernel.org>
Date: Tue, 1 Aug 2023 18:26:26 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [net-next/RFC PATCH v1 1/4] net: Introduce new napi fields for
 rx/tx queues
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>,
 "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, sridhar.samudrala@intel.com
References: <168564116688.7284.6877238631049679250.stgit@anambiarhost.jf.intel.com>
 <168564134580.7284.16867711571036004706.stgit@anambiarhost.jf.intel.com>
 <20230602230635.773b8f87@kernel.org>
 <717fbdd6-9ef7-3ad6-0c29-d0f3798ced8e@intel.com>
 <20230712141442.44989fa7@kernel.org>
 <4c659729-32dc-491e-d712-2aa1bb99d26f@intel.com>
 <20230712165326.71c3a8ad@kernel.org> <20230728145908.2d94c01f@kernel.org>
 <44c5024a-d533-0ae4-355a-c568b67b1964@intel.com>
 <20230728160925.3a080631@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230728160925.3a080631@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/23 5:09 PM, Jakub Kicinski wrote:
> On Fri, 28 Jul 2023 15:37:14 -0700 Nambiar, Amritha wrote:
>> Hi Jakub, I have the next version of patches ready (I'll send that in a 
>> bit). I suggest if you could take a look at it and let me know your 
>> thoughts and then we can proceed from there.
> 
> Great, looking forward.
> 
>> About dumping queues and NAPIs separately, are you thinking about having 
>> both per-NAPI and per-queue instances, or do you think only one will 
>> suffice. The plan was to follow this work with a 'set-napi' series, 
>> something like,
>> set-napi <napi_id> queues <q_id1, q_id2, ...>
>> to configure the queue[s] that are to be serviced by the napi instance.
>>
>> In this case, dumping the NAPIs would be beneficial especially when 
>> there are multiple queues on the NAPI.
>>
>> WRT per-queue, are there a set of parameters that needs to exposed 
>> besides what's already handled by ethtool...
> 
> Not much at this point, maybe memory model. Maybe stats if we want to
> put stats in the same command. But the fact that sysfs has a bunch of
> per queue attributes makes me think that sooner or later we'll want
> queue as a full object in netlink. And starting out that way makes 
> the whole API cleaner, at least in my opinion.
> 
> If we have another object which wants to refer to queues (e.g. page
> pool) it's easier to express the topology when it's clear what is an
> object and what's just an attribute.
> 
>> Also, to configure a queue 
>> on a NAPI, set-queue <qid> <napi_id>, the existing NAPIs would have to 
>> be looked up from the queue parameters dumped.
> 
> The look up should not be much of a problem.
> 
> And don't you think that:
> 
>   set-queue queue 1 napi-id 101
>   set-queue queue 2 napi-id 101
> 
> is more natural than:
> 
>   set-napi napi-id 101 queues [1, 2]
> 
> Especially in presence of conflicts. If user tries:
> 
>   set-napi napi-id 101 queues [1, 2]
>   set-napi napi-id 102 queues [1, 2]
> 
> Do both napis now serve those queues? May seem obvious to us, but
> "philosophically" why does setting an attribute of object 102 change
> attributes of object 101?
> 
> If we ever gain the ability to create queues it will be:
> 
>   create-queue napi-id xyz
> 
> which also matches set-queue more nicely than napi base API.
> 

I take it you have this path in mind as a means of creating
"specialized" queues (e.g., io_uring and Rx ZC). Any slides or notes on
the bigger picture?

