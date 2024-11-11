Return-Path: <netdev+bounces-143718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B01F9C3D5D
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 12:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26F31C21C38
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 11:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B1019ABC5;
	Mon, 11 Nov 2024 11:31:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0DE18B477;
	Mon, 11 Nov 2024 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324688; cv=none; b=Vu235pAISZyEaqHQLkIOUY/rW5yOmKuXEpcI+93EENjx4xUUFI8OPozGfrvFvZEy2aD+NCjpc3eHhi7v/T75ONgf85tbN412yqk1TYNEufMqQ9ByuqRkjcfz2P7S6xLXGYzs751tOtDasv5EBSkO/Cq/hcEInu6l7sTB+KnVNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324688; c=relaxed/simple;
	bh=byO06VlftwJVrxXzWWMMcmptQKF3tyHFGekyDgcW5LY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=ZbarT0PpEvx+1olenAULRtvaIUKMLd+a2n9YmwM1J90HJnS1kz5vLKemGeP4/5FmyYKADWiTgPB0MhHswqpmowWKXQV3U5XM9lJN93xHug93KCyfD6VoX9HQxxceorLuhLUvvTW9rpWJ1PHNUXcVY9RjCxaFh7DsHyAl427KnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xn6h05zhdz28fSh;
	Mon, 11 Nov 2024 19:26:40 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6929B1A0188;
	Mon, 11 Nov 2024 19:31:22 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Nov 2024 19:31:22 +0800
Message-ID: <4564c77b-a54d-4307-b043-d08e314c4c5f@huawei.com>
Date: Mon, 11 Nov 2024 19:31:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
From: Yunsheng Lin <linyunsheng@huawei.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <fanghaiqing@huawei.com>,
	<liuyonglong@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, kernel-team
	<kernel-team@cloudflare.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <0c146fb8-4c95-4832-941f-dfc3a465cf91@kernel.org>
 <204272e7-82c3-4437-bb0d-2c3237275d1f@huawei.com>
Content-Language: en-US
In-Reply-To: <204272e7-82c3-4437-bb0d-2c3237275d1f@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/26 15:33, Yunsheng Lin wrote:

...

>>>
>>> AFAIU Jakub's comment on his RFC patch for waiting, he was suggesting
>>> exactly this: Add the wait, and see if the cases where it can stall turn
>>> out to be problems in practice.
>>
>> +1
>>
>> I like Jakub's approach.
> 
> As mentioned in Toke's comment, I am still not convinced that there is some
> easy way of waiting here, doing the kick in the kernel space is hard enough,
> I am not even sure if kick need to be done or how it can be done in the user
> space if some page_pool owned page is held from user space for the cases of zero
> rx copy, io_uring and devmem tcp? killing the userspace app?
> 
> If you and Toke still think the waiting is the way out for the problem here, maybe
> we should wait for jakub's opinion and let him decide if he want to proceed with
> his waiting patch.

Is there any other suggestion/concern about how to fix the problem here?

From the previous discussion, it seems the main concern about tracking the
inflight pages is about how many inflight pages it is needed.

If there is no other suggestion/concern , it seems the above concern might be
addressed by using pre-allocated memory to satisfy the mostly used case, and
use the dynamically allocated memory if/when necessary.

