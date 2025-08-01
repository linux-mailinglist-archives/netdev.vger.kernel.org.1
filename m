Return-Path: <netdev+bounces-211330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9135EB1805E
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CBC23B726B
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B98C218ADE;
	Fri,  1 Aug 2025 10:46:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2589615DBC1;
	Fri,  1 Aug 2025 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754045182; cv=none; b=vEcpZt5fuqOoisVgptsHD4SBUhYMMiSNP7LwNzzMullqwPH/PqcSBdTEYAC6EjHq5Jn25udTKOS+NQsx6S0m1pJXffkjQeUEVsg3xTDvy3eTncdaBUXbjPup7a14sO70zY6IsFS/ay54nOyxxvPEjt1yEgKAIPtGkKnbNDNEU20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754045182; c=relaxed/simple;
	bh=O3INA7RvN/wZUo1wVHML2fUr9P9OP2pLkh9o6VnxvOQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sQmg9X3TvjVZK8TkcdpyPcwNI67Ss927/z0fe74MG5y7I4uUlYc3O4cskBynqy50NnWqfj7U/l98V1PwOKni/6K8T0k1bg98jSmJfl836FQU9pDcf/if3db1sFSssWUZNgbAhTUMkuQ1xqYG01YwkeHfwVl6G0qoCYXfTBV5MmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4btjMC4V9zz27j4w;
	Fri,  1 Aug 2025 18:47:19 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B2FD41A016C;
	Fri,  1 Aug 2025 18:46:17 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Aug 2025 18:46:16 +0800
Message-ID: <3bf4236a-2f68-4c09-a9bc-9534111854f2@huawei.com>
Date: Fri, 1 Aug 2025 18:46:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/3] net: hibmcge: fix the division by zero issue
To: Simon Horman <horms@kernel.org>
References: <20250731134749.4090041-1-shaojijie@huawei.com>
 <20250731134749.4090041-3-shaojijie@huawei.com>
 <20250801101154.GK8494@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250801101154.GK8494@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/8/1 18:11, Simon Horman wrote:
> On Thu, Jul 31, 2025 at 09:47:48PM +0800, Jijie Shao wrote:
>> When the network port is down, the queue is released, and ring->len is 0.
>> In debugfs, hbg_get_queue_used_num() will be called,
>> which may lead to a division by zero issue.
>>
>> This patch adds a check, if ring->len is 0,
>> hbg_get_queue_used_num() directly returns 0.
>>
>> Fixes: 40735e7543f9 ("net: hibmcge: Implement .ndo_start_xmit function")
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Thanks,
>
> Thinking aloud:
>
> I see that hbg_get_queue_used_num() can be called for both RX and TX
> rings via the debugfs code hbg_dbg_ring(). And that hbg_net_stop()
> clears the RX and TX ring configuration using hbg_txrx_uninit().

Yes, yes.

> So I agree that when the port is down ring-len will be 0.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
>

