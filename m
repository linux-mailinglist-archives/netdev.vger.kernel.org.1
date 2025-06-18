Return-Path: <netdev+bounces-198898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C4DADE403
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 08:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9CB3B8816
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 06:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B45215783;
	Wed, 18 Jun 2025 06:53:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0305F522F;
	Wed, 18 Jun 2025 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750229602; cv=none; b=I2sMCfJ3z1p7v/KVLeHZml//yNftVyQXPAxHtEFX213PtfG8pAl9TCQS0Dsm2dX0PelqQD5mZxOpsFQC8L9ZbgCNp/NXXgClxJIlcRkmbDVeDOYtmg5ZRtxKn5SwwrRwTAwVPFRk32uEux/ttBc/UE+ec5gp3D8qVQeZIWqZajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750229602; c=relaxed/simple;
	bh=z6Zh6LHr9HQDygJksnzqsETbW3lKHUK6tVBn3W13Zl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gmOvFi/rHI8YUJChG1Txf/6znvBwmdIrHf1L1qcoHtH9yeuYNMYMxmsX82NONHYiTxFz6845Kplk3IVfPgzCvC+Gsi7n02WYmgy5ppT8vNTL8vUS9U3wuGUhS5qsRSubbeeYQ7kTEENiZ7DAxuuvcildTDaB4JZyHKdz87xsYc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bMYn174Hcz27g2B;
	Wed, 18 Jun 2025 14:32:05 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CB5901A0171;
	Wed, 18 Jun 2025 14:33:34 +0800 (CST)
Received: from [10.67.112.40] (10.67.112.40) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 18 Jun
 2025 14:33:34 +0800
Message-ID: <825fe267-0925-4b91-98ef-82dfb768f916@huawei.com>
Date: Wed, 18 Jun 2025 14:33:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC]Page pool buffers stuck in App's socket queue
To: Mina Almasry <almasrymina@google.com>
CC: Ratheesh Kannoth <rkannoth@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
References: <20250616080530.GA279797@maili.marvell.com>
 <d152d5fa-e846-48ba-96f4-77493996d099@huawei.com>
 <CAHS8izNBNoMfheMbW5_FS1zMHW61BZVzDLHgv0+E0Zn6U=jD-g@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAHS8izNBNoMfheMbW5_FS1zMHW61BZVzDLHgv0+E0Zn6U=jD-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/6/18 5:02, Mina Almasry wrote:
> On Mon, Jun 16, 2025 at 11:34 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2025/6/16 16:05, Ratheesh Kannoth wrote:
>>> Hi,
>>>
>>> Recently customer faced a page pool leak issue And keeps on gettting following message in
>>> console.
>>> "page_pool_release_retry() stalled pool shutdown 1 inflight 60 sec"
>>>
>>> Customer runs "ping" process in background and then does a interface down/up thru "ip" command.
>>>
>>> Marvell octeotx2 driver does destroy all resources (including page pool allocated for each queue of
>>> net device) during interface down event. This page pool destruction will wait for all page pool buffers
>>> allocated by that instance to return to the pool, hence the above message (if some buffers
>>> are stuck).
>>>
>>> In the customer scenario, ping App opens both RAW and RAW6 sockets. Even though Customer ping
>>> only ipv4 address, this RAW6 socket receives some IPV6 Router Advertisement messages which gets generated
>>> in their network.
>>>
>>> [   41.643448]  raw6_local_deliver+0xc0/0x1d8
>>> [   41.647539]  ip6_protocol_deliver_rcu+0x60/0x490
>>> [   41.652149]  ip6_input_finish+0x48/0x70
>>> [   41.655976]  ip6_input+0x44/0xcc
>>> [   41.659196]  ip6_sublist_rcv_finish+0x48/0x68
>>> [   41.663546]  ip6_sublist_rcv+0x16c/0x22c
>>> [   41.667460]  ipv6_list_rcv+0xf4/0x12c
>>>
>>> Those packets will never gets processed. And if customer does a interface down/up, page pool
>>> warnings will be shown in the console.
>>>
>>> Customer was asking us for a mechanism to drain these sockets, as they dont want to kill their Apps.
>>> The proposal is to have debugfs which shows "pid  last_processed_skb_time  number_of_packets  socket_fd/inode_number"
>>> for each raw6/raw4 sockets created in the system. and
>>> any write to the debugfs (any specific command) will drain the socket.
>>>
>>> 1. Could you please comment on the proposal ?
>>
>> I would say the above is kind of working around the problem.
>> It would be good to fix the Apps or fix the page_pool.
>>
>>> 2. Could you suggest a better way ?
>>
>> For fixing the page_pool part, I would be suggesting to keep track
>> of all the inflight pages and detach those pages from page_pool when
>> page_pool_destroy() is called, the tracking part was [1], unfortunately
>> the maintainers seemed to choose an easy way instead of a long term
>> direction, see [2].
> 
> This is not that accurate IMO. Your patch series and the merged patch
> series from Toke does the same thing: both keep track of dma-mapped

The main difference is the above 'dma-mapped'.

> pages, so that they can be unmapped at page_pool_destroy time. Toke
> just did the tracking in a simpler way that people were willing to
> review.
> 
> So, if you had a plan to detach pages on page_pool_destroy on top of
> your tracking, the exact same plan should work on top of Toke's
> tracking. It may be useful to code that and send an RFC if you have
> time. It would indeed fix this periodic warning issue.

As above, when page_pool_create() is called without PP_FLAG_DMA_MAP, the
dma-mapped pages tracking is not enough.

