Return-Path: <netdev+bounces-198429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1A2ADC26E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2EF3B6745
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 06:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAAD217F26;
	Tue, 17 Jun 2025 06:33:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8D2289349;
	Tue, 17 Jun 2025 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750142029; cv=none; b=cnSJ39WR64ckWHd9OofDbDag2NPOBQxxcGjwKH9b5Da2YqTdRCOeb9Qe10OXFrJE7NRK8RAp7mZegfgbBUBHpUzRD2YzTw6RPb77GcCnMg6Ezsv6QVenbHnajCWO6v4ty/ma31C2sm0FexdRA76bvyaEnkR0bcQA+NgrOP05rbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750142029; c=relaxed/simple;
	bh=p0ZHKgJeiGzErL88/GscM6rOo7KxAVj1KVR5oh3Kqqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bZagmUituwAcwYukxWLjjaTabSPiAOHPiYGmlz0HuNg9R2wSVckeaBIDXIKtr8VCMIaXjRltYkjuA/5Ceb8PfBksivDOzL+Mlkpp4CboF148C4iWl5j3XtzKLIC6ZYBKbho57uf5QsCId4zu8wM3l/3mKZtlj9w4QPbNJQpLXzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bLxmS2ZDfzRkQc;
	Tue, 17 Jun 2025 14:29:28 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C7F31402DB;
	Tue, 17 Jun 2025 14:33:44 +0800 (CST)
Received: from [10.67.112.40] (10.67.112.40) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Jun
 2025 14:33:43 +0800
Message-ID: <d152d5fa-e846-48ba-96f4-77493996d099@huawei.com>
Date: Tue, 17 Jun 2025 14:33:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC]Page pool buffers stuck in App's socket queue
To: Ratheesh Kannoth <rkannoth@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
References: <20250616080530.GA279797@maili.marvell.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250616080530.GA279797@maili.marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/6/16 16:05, Ratheesh Kannoth wrote:
> Hi,
> 
> Recently customer faced a page pool leak issue And keeps on gettting following message in
> console.
> "page_pool_release_retry() stalled pool shutdown 1 inflight 60 sec"
> 
> Customer runs "ping" process in background and then does a interface down/up thru "ip" command.
> 
> Marvell octeotx2 driver does destroy all resources (including page pool allocated for each queue of
> net device) during interface down event. This page pool destruction will wait for all page pool buffers
> allocated by that instance to return to the pool, hence the above message (if some buffers
> are stuck).
> 
> In the customer scenario, ping App opens both RAW and RAW6 sockets. Even though Customer ping
> only ipv4 address, this RAW6 socket receives some IPV6 Router Advertisement messages which gets generated
> in their network.
> 
> [   41.643448]  raw6_local_deliver+0xc0/0x1d8
> [   41.647539]  ip6_protocol_deliver_rcu+0x60/0x490
> [   41.652149]  ip6_input_finish+0x48/0x70
> [   41.655976]  ip6_input+0x44/0xcc
> [   41.659196]  ip6_sublist_rcv_finish+0x48/0x68
> [   41.663546]  ip6_sublist_rcv+0x16c/0x22c
> [   41.667460]  ipv6_list_rcv+0xf4/0x12c
> 
> Those packets will never gets processed. And if customer does a interface down/up, page pool
> warnings will be shown in the console.
> 
> Customer was asking us for a mechanism to drain these sockets, as they dont want to kill their Apps.
> The proposal is to have debugfs which shows "pid  last_processed_skb_time  number_of_packets  socket_fd/inode_number"
> for each raw6/raw4 sockets created in the system. and
> any write to the debugfs (any specific command) will drain the socket.
> 
> 1. Could you please comment on the proposal ?

I would say the above is kind of working around the problem.
It would be good to fix the Apps or fix the page_pool.

> 2. Could you suggest a better way ?

For fixing the page_pool part, I would be suggesting to keep track
of all the inflight pages and detach those pages from page_pool when
page_pool_destroy() is called, the tracking part was [1], unfortunately
the maintainers seemed to choose an easy way instead of a long term
direction, see [2].

1. https://lore.kernel.org/all/20250307092356.638242-1-linyunsheng@huawei.com/
2. https://lore.kernel.org/all/20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com/

