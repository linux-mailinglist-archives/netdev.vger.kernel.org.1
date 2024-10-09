Return-Path: <netdev+bounces-133435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9925995E2F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 05:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F93D1F25E06
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 03:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D69F77F11;
	Wed,  9 Oct 2024 03:33:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76D27466;
	Wed,  9 Oct 2024 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728444802; cv=none; b=Tb47o2m1etiG6ckIwX1wzn3nVj/uzMo1uu1uULIbMkTpeO6xK3XaTwD8ERIgjc2LXPNi2nbkO5dEbBLuetM0229WD9cb+Se9aFqjGYhQXLu28G20s9O2qSTDgmFvk2XYdWlCnYpr3WmdGIlhUG396PJA/CxcCF2sksQ9Zi0kHao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728444802; c=relaxed/simple;
	bh=8CjK6FSEDY2dFSsO9YF3Kx3tKU6va4cUgPhiLZrBq2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cXTFLHJKyWa72lANz/zTRs2qtXF+H936VrdD1mN39Li98Yz7HJPrjgi8K+VjaCihHCcJyrOwv41UqjjZ/DQ1Arvs8p2vjSKgAOl9TmW0TNKlV54mjT1/aEUo0b7RUejkp0Cn0jSHrmtyrDpvdQo1dsH8uVw64uACLzabu2ivxMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XNdkz3rj2z1ymtl;
	Wed,  9 Oct 2024 11:33:15 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 283D21A0188;
	Wed,  9 Oct 2024 11:33:11 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Oct 2024 11:33:10 +0800
Message-ID: <e420a11f-1c07-4a3f-85b4-b7679b4e50ce@huawei.com>
Date: Wed, 9 Oct 2024 11:33:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] page_pool: fix timing for checking and
 disabling napi_local
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet
	<edumazet@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-2-linyunsheng@huawei.com>
 <20241008174022.0b6d92b9@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241008174022.0b6d92b9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/9 8:40, Jakub Kicinski wrote:
> On Wed, 25 Sep 2024 15:57:06 +0800 Yunsheng Lin wrote:
>> Use rcu mechanism to avoid the above concurrent access problem.
>>
>> Note, the above was found during code reviewing on how to fix
>> the problem in [1].
> 
> The driver must make sure NAPI cannot be running while
> page_pool_destroy() is called. There's even an WARN()
> checking this.. if you know what to look for.

I am guessing you are referring to the WARN() in
page_pool_disable_direct_recycling(), right?
If yes, I am aware of that WARN().

The problem is that at least from the skb_defer_free_flush()
case, it is not tied to any specific napi instance. When
skb_attempt_defer_free() calls kick_defer_list_purge() to
trigger running of net_rx_action(), skb_defer_free_flush() can
be called without tieing to any specific napi instance as my
understanding:
https://elixir.bootlin.com/linux/v6.7-rc8/source/net/core/dev.c#L6719

Or I am missing something obvious here? I even used below diff to
verify that and it did trigger without any napi in the sd->poll_list:

@@ -6313,6 +6313,9 @@ static void skb_defer_free_flush(struct softnet_data *sd)
        spin_unlock(&sd->defer_lock);

        while (skb != NULL) {
+               if (list_empty(&sd->poll_list))
+                       pr_err("defer freeing: %px with empty napi list\n", skb);
+
                next = skb->next;
                napi_consume_skb(skb, 1);
                skb = next;


> 
> 

