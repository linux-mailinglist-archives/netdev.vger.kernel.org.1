Return-Path: <netdev+bounces-129298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5BB97EBEE
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222EF2837D2
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B378E19924E;
	Mon, 23 Sep 2024 12:58:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB781990C0
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096298; cv=none; b=DZCD9jw9ad0CRVSTcGXGtOoXkA5o2WLFNuhsBiFxRhvJR6RXLaMrNKln955vboYKdPPoEaWqWK6r5USVhehl2BCLZjOMSSUbIoa6AXNI9ZNtYwzbg/k2y3YkDdtmVxUuFM6mHHGhX1Cpg3wieE/FfhAn8OkYlRh+7KVn/iGB5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096298; c=relaxed/simple;
	bh=Jeohuhgz5kAQqFYLBgzOKWOTOUIvzxtL/EJgoX/sSt0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OpXHsmKJQYRxtClBEGvZ45mhQ7EAXeBBQqPJ+W7qYxaJOobsGMbHKoM4fCQFV9X3S4QsT9xu6EnsyOWgIWpCE705BL5u9vTv1U+SdSvn4M92XlGItLVcigfZedEib5/+zOHFdAVcsMroBQYw5YZWayPXC4gHUonw1Kn4/jegq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XC31M3kcfz1S87D;
	Mon, 23 Sep 2024 20:57:27 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 00D4D140259;
	Mon, 23 Sep 2024 20:58:13 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 20:58:12 +0800
Message-ID: <56bbcfbd-149f-4f78-ae73-3bba3bbdd146@huawei.com>
Date: Mon, 23 Sep 2024 20:58:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>, =?UTF-8?B?6ZmI5pmf56W6?=
	<harry-chen@outlook.com>, =?UTF-8?B?5byg5a6H57+U?= <zz593141477@gmail.com>,
	=?UTF-8?B?6ZmI5ZiJ5p2w?= <jiegec@qq.com>, Mirror Admin Tuna
	<mirroradmin@tuna.tsinghua.edu.cn>, Salil Mehta <salil.mehta@huawei.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>
Subject: Re: [BUG Report] hns3: tx_timeout on high memory pressure
To: Miao Wang <shankerwangmiao@gmail.com>
References: <4068C110-62E5-4EAA-937C-D298805C56AE@gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <4068C110-62E5-4EAA-937C-D298805C56AE@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/9/23 0:38, Miao Wang wrote:
> It seems that hns3 driver is trying to allocating 16 continuous pages of memory
> when initializing, which could fail when the system is under high memory
> pressure.
>
> I have two questions about this:
>
> 1. Is it expected that tx timeout really related to the high memory pressure,
>     or the driver does not work properly under such condition?
>
> 2. Can allocating continuous pages of memory on initialization can be avoided?
>     I previously met similar problem on the veth driver, which was latter fixed
>     by commit  1ce7d306ea63 ("veth: try harder when allocating queue memory"),
>     where the memory allocating was changed to kvcalloc() to reduces the
>     possibility of allocation failure. I wonder if similar changes can be applied
>     to hns3 when allocating memory regions for non-DMA usage.
>     

Hi:

in dmesg, we can see:
tx_timeout count: 35, queue id: 1, SW_NTU: 0x346, SW_NTC: 0x334, napi state: 17
BD_NUM: 0x7f HW_HEAD: 0x346, HW_TAIL: 0x346, BD_ERR: 0x0, INT: 0x0

Because HW_HEAD==HW_TAIL, the hardware has sent all the packets.
napi state: 17, Therefore, the TX interrupt is received and npai scheduling is triggered.
However, napi scheduling is not complete, Maybe napi.poll() is not executed.
Is npai not scheduled in time due to high CPU load in the environment?

To solve the memory allocating failure problem,
you can use kvcalloc to prevent continuous page memory allocating and
reduce the probability of failure in OOM.

Thanks，
Jijie Shao


