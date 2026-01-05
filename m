Return-Path: <netdev+bounces-246875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA0ACF20EB
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 07:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 179573010FC6
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 06:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B948F32549B;
	Mon,  5 Jan 2026 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KK7NpNdN"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209C2324B34
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767594235; cv=none; b=P9itzp96yBpW7wcG+OPYeXDSrEX4JkRlugTwf+BgaB1DiPty6bBdd3HxwQ0arlz7eIcjsNYEAFhfnY8hq5BRMPeVjHowvEbe/aT06HZTm/Pb774F/xlwYDExeP6bX0hzaPgLb9IISwHeYVZtxCFe5m0OIIWyfTI3HcudK0IHR3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767594235; c=relaxed/simple;
	bh=A6+CEtfq0VwzTkHZqgHPIZ2n+e/fR+INR4ete83AY48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKsn18VMdvYomYgVfn5vshRnLEHAM1O2Xlb3ZYB514bAk7kpNCnr1lEEwDq3yqaD5LRY+dfQ5a+gLvi3WacCAqrKwSCRPn8MerDG9cNA0NOqtaz8bJnzjPUd1da9CVMXp+/9E7D4J6Ah3mU+vqSnkkPkUAwy+EGwruD+nVQGrLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KK7NpNdN; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <130d8c90-6285-41b0-926e-d6df9791bcd4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767594219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSRGwI+y5Xp8Cwj5Qnu7i8q65ZGA395EeFAJkdkgb7c=;
	b=KK7NpNdNAhjcCVjMneXpn1xmj+vKRCCHDDlJyKIYqe18SfnkQSgk9Q+vdpeGH6LtP4WXxT
	0dgeDzeDQPO6/pb/Kb8nTuXKaarElMrZRDy2Ns5bgjT7F6QilWiSWv1YCkhzWmIwKVCcg0
	Chu6a3SStKZhNZ/E3E43msOAMvZTBuY=
Date: Mon, 5 Jan 2026 14:23:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3] page_pool: Add page_pool_release_stalled
 tracepoint
Content-Language: en-US
To: Yunsheng Lin <linyunsheng@huawei.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 kerneljasonxing@gmail.com, lance.yang@linux.dev, jiayuan.chen@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Leon Huang Fu <leon.huangfu@shopee.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, kernel-team <kernel-team@cloudflare.com>,
 Yan Zhai <yan@cloudflare.com>
References: <20260102071745.291969-1-leon.hwang@linux.dev>
 <011ca15e-107b-4679-8203-f5f821f27900@kernel.org>
 <dfc33064-f99f-4728-858f-95c80300bcff@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <dfc33064-f99f-4728-858f-95c80300bcff@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/1/26 10:18, Yunsheng Lin wrote:
> On 2026/1/2 19:43, Jesper Dangaard Brouer wrote:
>>
>>
>> On 02/01/2026 08.17, Leon Hwang wrote:
>>> Introduce a new tracepoint to track stalled page pool releases,
>>> providing better observability for page pool lifecycle issues.
>>>
>>
>> In general I like/support adding this tracepoint for "debugability" of
>> page pool lifecycle issues.
>>
>> For "observability" @Kuba added a netlink scheme[1][2] for page_pool[3], which gives us the ability to get events and list page_pools from userspace.
>> I've not used this myself (yet) so I need input from others if this is something that others have been using for page pool lifecycle issues?
>>
>> Need input from @Kuba/others as the "page-pool-get"[4] state that "Only Page Pools associated with a net_device can be listed".  Don't we want the ability to list "invisible" page_pool's to allow debugging issues?
>>
>>  [1] https://docs.kernel.org/userspace-api/netlink/intro-specs.html
>>  [2] https://docs.kernel.org/userspace-api/netlink/index.html
>>  [3] https://docs.kernel.org/netlink/specs/netdev.html
>>  [4] https://docs.kernel.org/netlink/specs/netdev.html#page-pool-get
>>
>> Looking at the code, I see that NETDEV_CMD_PAGE_POOL_CHANGE_NTF netlink
>> notification is only generated once (in page_pool_destroy) and not when
>> we retry in page_pool_release_retry (like this patch).  In that sense,
>> this patch/tracepoint is catching something more than netlink provides.
>> First I though we could add a netlink notification, but I can imagine
>> cases this could generate too many netlink messages e.g. a netdev with
>> 128 RX queues generating these every second for every RX queue.
>>
>> Guess, I've talked myself into liking this change, what do other
>> maintainers think?  (e.g. netlink scheme and debugging balance)
>>
>>
>>> Problem:
>>> Currently, when a page pool shutdown is stalled due to inflight pages,
>>> the kernel only logs a warning message via pr_warn(). This has several
>>> limitations:
>>>
>>> 1. The warning floods the kernel log after the initial DEFER_WARN_INTERVAL,
>>>     making it difficult to track the progression of stalled releases
>>> 2. There's no structured way to monitor or analyze these events
>>> 3. Debugging tools cannot easily capture and correlate stalled pool
>>>     events with other network activity
>>>
>>> Solution:
>>> Add a new tracepoint, page_pool_release_stalled, that fires when a page
>>> pool shutdown is stalled. The tracepoint captures:
>>> - pool: pointer to the stalled page_pool
>>> - inflight: number of pages still in flight
>>> - sec: seconds since the release was deferred
>>>
>>> The implementation also modifies the logging behavior:
>>> - pr_warn() is only emitted during the first warning interval
>>>    (DEFER_WARN_INTERVAL to DEFER_WARN_INTERVAL*2)
>>> - The tracepoint is fired always, reducing log noise while still
>>>    allowing monitoring tools to track the issue
> 
> If the initial log is still present, I don't really see what's the benefit
> of re-triggering logs or tracepoints when the first two fields are unchanged
> and the last two fields can be inspected using some tool? If there are none,
> perhaps we only need to print the first trigger log and a log upon completion
> of page_pool destruction.
> 

Even though it is possible to inspect the last two fields via the
workqueue (e.g., by tracing page_pool_release_retry with BPF tools),
this is not a practical approach for routine monitoring or debugging.

With the proposed tracepoint, obtaining these fields becomes
straightforward and lightweight, making it much easier to observe and
reason about stalled page pool releases in real systems.

In the issue I encountered, it was crucial to notice that the inflight
count was gradually decreasing over time. This gave me confidence that
some orphaned pages were eventually being returned to the page pool.
Based on that signal, I was then able to capture the call stack of
page_pool_put_defragged_page (kernel v6.6) to identify the code path
responsible for returning those pages.

Without repeated pr_warn logs or tracepoint events, it would have been
significantly harder to observe this progression and correlate it with
the eventual page returns.

Thanks,
Leon

