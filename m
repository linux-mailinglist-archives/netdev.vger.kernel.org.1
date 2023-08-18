Return-Path: <netdev+bounces-28678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B9D7803C5
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 04:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620D51C21535
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 02:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B55808;
	Fri, 18 Aug 2023 02:21:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D08398
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 02:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2510DC433C8;
	Fri, 18 Aug 2023 02:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692325310;
	bh=7x2/nVJt796L43hEwRPulQXX0cT4BE+/ulxwgzl+DjM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NdMW6VE9Z81hpu0JeSq6MGc4uUzEwZccpsFcVSH7j9ADJGGv5E/y23RN6cFnIKb9I
	 eSZBNjiVs8KWuEyh+7wJuUEN8dmU7A0BHB81rtkYTC0+KKJPmshIav5mHU22vvPsCj
	 UtkMP9hdbulRiAVMeTDv3jJpuMmP5ZzlwsmVWGb5dAvyWCY/8I5qgKRCsxDeueEhZ4
	 AlYq9F/m4ENiOZXtKyMxO+aCyMrRHhQktWlIYq0eZG8rVoHI+zas283BDbIGDhWCYV
	 M0zwDIot9vtsPgdS1Ml1mSvUDMoCLafmeRQYQeYPjhmHeiH1YjjcDBR0KKNBWotpyn
	 igjozetoYbXGw==
Message-ID: <275aa42e-51ba-1b31-15aa-3528dc29b447@kernel.org>
Date: Thu, 17 Aug 2023 20:21:49 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 02/11] netdev: implement netlink api to bind
 dma-buf to netdevice
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>, sdf@google.com,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20230810015751.3297321-1-almasrymina@google.com>
 <20230810015751.3297321-3-almasrymina@google.com>
 <7dd4f5b0-0edf-391b-c8b4-3fa82046ab7c@kernel.org>
 <20230815171638.4c057dcd@kernel.org>
 <64dcf5834c4c8_23f1f8294fa@willemb.c.googlers.com.notmuch>
 <c47219db-abf9-8a5c-9b26-61f65ae4dd26@kernel.org>
 <20230817190957.571ab350@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230817190957.571ab350@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/23 8:09 PM, Jakub Kicinski wrote:
>>
>> Flow steering to TC offloads -- more details on what you were thinking here?
> 
> I think TC flower can do almost everything ethtool -N can.
> So do we continue to developer for both APIs or pick one?

ok, tc flower; that did not come to mind. Don't use it often.

> 
>>>> I don't have a good sense of what a good model for cleanup and
>>>> permissions is (B). All I know is that if we need to tie things to
>>>> processes netlink can do it, and we shouldn't have to create our
>>>> own FS and special file descriptors...  
>>
>> From my perspective the main sticking point that has not been handled is
>> flushing buffers from the RxQ, but there is 100% tied to queue
>> management and a process' ability to effect a flush or queue tear down -
>> and that is the focus of your list below:
> 
> If you're thinking about it from the perspective of "application died
> give me back all the buffers" - the RxQ is just one piece, right?
> As we discovered with page pool - packets may get stuck in stack for
> ever.

Yes, flushing the retransmit queue for TCP is one of those places where
buffer references can get stuck for some amount of time.

>>
>> `ethtool -L/-G` and `ip link set {up/down}` pertain to the "general OS"
>> queues managed by a driver for generic workloads and networking
>> management (e.g., neigh discovery, icmp, etc). The discussions here
>> pertains to processes wanting to use their own memory or GPU memory in a
>> queue. Processes will come and go and the queue management needs to
>> align with that need without affecting all of the other queues managed
>> by the driver.
> 
> For sure, I'm just saying that both the old uAPI can be translated to
> the new driver API, and so should the new uAPIs. I focused on the
> driver facing APIs because I think that it's the hard part. We have
> many drivers, the uAPI is more easily dreamed up, no?

sure.



