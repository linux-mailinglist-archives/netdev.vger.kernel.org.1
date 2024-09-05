Return-Path: <netdev+bounces-125498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5A296D65B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89225B209B7
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744E198A24;
	Thu,  5 Sep 2024 10:47:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CCD1957F8
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533254; cv=none; b=XVGLtnv41q8PgvNYRF/kyFRFK4uQsEM6586GmylklvectqKGz9yLmjToFTePLLOYyWz1S/NQsBvJqzfk320kWNC+K6rYeJTEcQpBQnA0J5O0Yk3oUSiB+0x8DglXItKCcwsD2apnouf3pzReE7zi65VRI66ePrhYJUliSkB8Td8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533254; c=relaxed/simple;
	bh=rrLiFL4gYtGNDtzSXThw5aU/iSUs3LziwQd78xMPyI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pGqc/e9XA2eJXmS3u+R+cVUFNO2BWG6+qC1FUCQxA1+szyTzaYqK0njyzsIfHmlYcVoxe32bEI7fPajw7GtZmuJsosJfdtThivYr+Pwu2KcKOUeqFyy3v83mlObOSjhUby4rR0Q3XayErV2rtBL8iAu3Ckba+4ZdyDLAUNOViqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WzwxF4Gmzz1xwtX;
	Thu,  5 Sep 2024 18:45:21 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CA53F1A0188;
	Thu,  5 Sep 2024 18:47:22 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Sep 2024 18:47:22 +0800
Message-ID: <d50ac1a9-f1e2-49ee-b89b-05dac9bc6ee1@huawei.com>
Date: Thu, 5 Sep 2024 18:47:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net] net: make page pool stall netdev unregistration to
 avoid IOMMU crashes
To: Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>, Yonglong Liu
	<liuyonglong@huawei.com>, <fanghaiqing@huawei.com>, "Zhangkun(Ken,Turing)"
	<zhangkun09@huawei.com>
References: <20240806151618.1373008-1-kuba@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20240806151618.1373008-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/6 23:16, Jakub Kicinski wrote:
> There appears to be no clean way to hold onto the IOMMU, so page pool
> cannot outlast the driver which created it. We have no way to stall
> the driver unregister, but we can use netdev unregistration as a proxy.
> 
> Note that page pool pages may last forever, we have seen it happen
> e.g. when application leaks a socket and page is stuck in its rcv queue.

I am assuming the page will be released when the application dies or
exits, right?

Also I am not sure if the above application is privileged one or not?
If it is not a privileged one, perhaps we need to fix the above problem
in the kernel as it does not seem to make sense for a unprivileged
application to have the kernel leaking page and stall the unregistering
of devices.

> Hopefully this is fine in this particular case, as we will only stall
> unregistering of devices which want the page pool to manage the DMA
> mapping for them, i.e. HW backed netdevs. And obviously keeping
> the netdev around is preferable to a crash.

For the internal testing and debugging, it seems there are at least
two cases that the page is not released fast enough for now:
1. ipv4 packet defragmentation timeout: this seems to cause delay up
   to 30 secs:
#define IP_FRAG_TIME	(30 * HZ)		/* fragment lifetime	*/

2. skb_defer_free_flush(): this may cause infinite delay if there is
   no triggering for net_rx_action(). Below is the dump_stack() when
   the page is returned back to page_pool after reloading the driver,
   causing the triggering of net_rx_action():

[  515.286580] Call trace:
[  515.289012]  dump_backtrace+0x9c/0x100
[  515.292748]  show_stack+0x20/0x38
[  515.296049]  dump_stack_lvl+0x78/0x90
[  515.299699]  dump_stack+0x18/0x28
[  515.303001]  page_pool_put_unrefed_netmem+0x2c4/0x3d0
[  515.308039]  napi_pp_put_page+0xb4/0xe0
[  515.311863]  skb_release_data+0xf8/0x1e0
[  515.315772]  kfree_skb_list_reason+0xb4/0x2a0
[  515.320115]  skb_release_data+0x148/0x1e0
[  515.324111]  napi_consume_skb+0x64/0x190
[  515.328021]  net_rx_action+0x110/0x2a8
[  515.331758]  handle_softirqs+0x120/0x368
[  515.335668]  __do_softirq+0x1c/0x28
[  515.339143]  ____do_softirq+0x18/0x30
[  515.342792]  call_on_irq_stack+0x24/0x58
[  515.346701]  do_softirq_own_stack+0x24/0x38
[  515.350871]  irq_exit_rcu+0x94/0xd0
[  515.354347]  el1_interrupt+0x38/0x68
[  515.357910]  el1h_64_irq_handler+0x18/0x28
[  515.361994]  el1h_64_irq+0x64/0x68
[  515.365382]  default_idle_call+0x34/0x140
[  515.369378]  do_idle+0x20c/0x270
[  515.372593]  cpu_startup_entry+0x40/0x50
[  515.376503]  secondary_start_kernel+0x138/0x160
[  515.381021]  __secondary_switched+0xb8/0xc0

> 
> More work is needed for weird drivers which share one pool among
> multiple netdevs, as they are not allowed to set the pp->netdev
> pointer. We probably need to add a bit that says "don't expose
> to uAPI for them".

Which driver are we talking about here sharing one pool among multiple
netdevs? Is the sharing for memory saving?

> 

