Return-Path: <netdev+bounces-118417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEC8951865
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 12:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C262839BA
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4321AD416;
	Wed, 14 Aug 2024 10:10:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321D94D8B9
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630206; cv=none; b=nXgn1QZQfxpuHpKsqJMz20uBYk6dSHHzRYodx7yQOYUqTMjpVum122/pfnPrN8o9omB9ZRzgVZlznsqQJa4nO6vQ+YzOwXZvTxqakZdkXII7mc6sZkjfgLc0RSJ3KQXBcYY/9gwLBYXwL9ZH1liYduxMh53+pIFXlbLRlheW2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630206; c=relaxed/simple;
	bh=0IuBZ0SAyiP/r1LDDwAdpT8rviUYKnTAx/AwpYQtuN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YbZlNQkBxaWfwax3lu5OcWwNf4Hp2NOc5+CJBy+3gsKqks5+zWJOE/GlloPxOCq7AJQcT5Ky+8TuMXU7m4TlnN5FO8MgqhqQyH30FIopCDzgPXAAU9EXAoff+Sn9FXIONzMhdHHRnKbnXRy/cC26FqD+ueL69HrvQQFsHVeocj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WkP502SGvz2CmWl;
	Wed, 14 Aug 2024 18:05:08 +0800 (CST)
Received: from kwepemf200007.china.huawei.com (unknown [7.202.181.233])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D6E118001B;
	Wed, 14 Aug 2024 18:10:00 +0800 (CST)
Received: from [10.67.121.184] (10.67.121.184) by
 kwepemf200007.china.huawei.com (7.202.181.233) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 14 Aug 2024 18:09:59 +0800
Message-ID: <cec044dc-504c-47e6-8ffa-58e8c9b42713@huawei.com>
Date: Wed, 14 Aug 2024 18:09:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net] net: make page pool stall netdev unregistration to
 avoid IOMMU crashes
To: Jakub Kicinski <kuba@kernel.org>
CC: Yunsheng Lin <linyunsheng@huawei.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>
References: <20240806151618.1373008-1-kuba@kernel.org>
 <523894ab-2d38-415f-8306-c0d1abd911ec@huawei.com>
 <20240807072908.1da91994@kernel.org>
 <977c3d82-e2f0-4466-9100-7ea781e91ce1@huawei.com>
 <20240808070511.0befbdde@kernel.org>
 <758b4d47-c980-4f66-b4a4-949c3fc4b040@huawei.com>
 <20240809205717.0c966bad@kernel.org>
Content-Language: en-US
From: Yonglong Liu <liuyonglong@huawei.com>
In-Reply-To: <20240809205717.0c966bad@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf200007.china.huawei.com (7.202.181.233)


On 2024/8/10 11:57, Jakub Kicinski wrote:
> On Fri, 9 Aug 2024 14:06:02 +0800 Yonglong Liu wrote:
>> [ 7724.272853] hns3 0000:7d:01.0: page_pool_release_retry(): eno1v0
>> stalled pool shutdown: id 553, 82 inflight 6706 sec (hold netdev: 1855491)
> Alright :( You gotta look around for those 82 pages somehow with drgn.
> bpftrace+kfunc the work that does the periodic print to get the address
> of the page pool struct and then look around for pages from that pp.. :(

I spent some time to learn how to use the drgn, and found those page, 
but I think those page

is allocated by the hns3 driver, how to find out who own those page now?

The following is a page info:

*(struct page *)0xfffffe004359de80 = { .flags = (unsigned 
long)432345014471753728, .lru = (struct list_head){ .next = (struct 
list_head *)0xdead000000000040, .prev = (struct list_head 
*)0xffff002105c18000, }, .__filler = (void *)0xdead000000000040, 
.mlock_count = (unsigned int)96567296, .buddy_list = (struct list_head){ 
.next = (struct list_head *)0xdead000000000040, .prev = (struct 
list_head *)0xffff002105c18000, }, .pcp_list = (struct list_head){ .next 
= (struct list_head *)0xdead000000000040, .prev = (struct list_head 
*)0xffff002105c18000, }, .mapping = (struct address_space *)0x0, .index 
= (unsigned long)4223168512, .share = (unsigned long)4223168512, 
.private = (unsigned long)2, .pp_magic = (unsigned 
long)16045481047390945344, .pp = (struct page_pool *)0xffff002105c18000, 
._pp_mapping_pad = (unsigned long)0, .dma_addr = (unsigned 
long)4223168512, .pp_ref_count = (atomic_long_t){ .counter = (s64)2, }, 
.compound_head = (unsigned long)16045481047390945344, .pgmap = (struct 
dev_pagemap *)0xdead000000000040, .zone_device_data = (void 
*)0xffff002105c18000, .callback_head = (struct callback_head){ .next = 
(struct callback_head *)0xdead000000000040, .func = (void (*)(struct 
callback_head *))0xffff002105c18000, }, ._mapcount = (atomic_t){ 
.counter = (int)-1, }, .page_type = (unsigned int)4294967295, ._refcount 
= (atomic_t){ .counter = (int)1, }, .memcg_data = (unsigned long)0, }


