Return-Path: <netdev+bounces-72708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9EB85946B
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 04:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6FD1F220DD
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 03:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1457815D4;
	Sun, 18 Feb 2024 03:49:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F2215C0
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 03:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708228198; cv=none; b=VTtBKmAYwNp4Oe18wnUHO7EUCdEoGTkaciI82hidmDtlBiN6biie/nkSs6CtjKbKflvmoE5m/8kLW/dsJkedowsUwRNHhvuegzLnY9Xf8dJMsFQ2PnMprbVwpEJ0T+BIOD4+BE2Zuvk2jf4dVBSKf9pdKJiQI5R0P6QV6FHZ+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708228198; c=relaxed/simple;
	bh=WVnOmh2FPOOeQdG0uyG0taLtLGSBA6trvBtKJX7ma08=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=L+kH7JNaqJeVu2TeRIhRthHioAZpsZ3OBOYEGUXvmF05J82fpr2g3MOROK+cEDRHXI+xXOzGW0poxAuQ0Fz9cAHBYV5UJxr1EK4c0NTetgRMaaFE1riUFjuylUadzBPuxzYCm/DFmXtT12of/jvQXqVOKbdCL0XoCcxdu3T2Rdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tcs7j3Zrpz2Bcp1;
	Sun, 18 Feb 2024 11:47:45 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 74FA11A016B;
	Sun, 18 Feb 2024 11:49:51 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 11:49:50 +0800
Subject: Re: [PATCH net-next] net: page_pool: fix recycle stats for system
 page_pool allocator
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <hawk@kernel.org>, <ilias.apalodimas@linaro.org>,
	<toke@redhat.com>, <aleksander.lobakin@intel.com>
References: <87f572425e98faea3da45f76c3c68815c01a20ee.1708075412.git.lorenzo@kernel.org>
 <2f315c01-37ba-77e2-1d0f-568f453b3166@huawei.com>
 <ZdCR6i85oEvoxMzF@lore-desk>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <b9fba731-fe69-5eb6-8f9e-a477fe5cc124@huawei.com>
Date: Sun, 18 Feb 2024 11:49:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZdCR6i85oEvoxMzF@lore-desk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/2/17 19:00, Lorenzo Bianconi wrote:
>>>  #ifdef CONFIG_PAGE_POOL_STATS
>>> -	pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
>>> -	if (!pool->recycle_stats)
>>> -		return -ENOMEM;
>>> +	if (!(pool->p.flags & PP_FLAG_SYSTEM_POOL)) {
>>> +		pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
>>> +		if (!pool->recycle_stats)
>>> +			return -ENOMEM;
>>> +	} else {
>>> +		/* For system page pool instance we use a singular stats object
>>> +		 * instead of allocating a separate percpu variable for each
>>> +		 * (also percpu) page pool instance.
>>> +		 */
>>> +		pool->recycle_stats = &pp_system_recycle_stats;
>>
>> Do we need to return -EINVAL here if page_pool_init() is called with
>> pool->p.flags & PP_FLAG_SYSTEM_POOL being true and cpuid being a valid
>> cpu?

My fault, the above "cpuid being a valid cpu" should be "cpuid not being a
valid cpu".
In other word, do we need to protect user from calling page_pool_init()
with PP_FLAG_SYSTEM_POOL flag and cpuid being -1?


>> If yes, it seems we may be able to use the cpuid to decide if we need
>> to allocate a new pool->recycle_stats without adding a new flag.
> 
> for the current use-cases cpuid is set to a valid core id just for system
> page_pool but in the future probably there will not be a 1:1 relation (e.g.
> we would want to pin a per-cpu page_pool instance to a particular CPU?)

if it is a per-cpu page_pool instance, doesn't it run into the similar
problem this patch is trying to fix?

> 
>>
>> If no, the API for page_pool_create_percpu() seems a litte weird as it
>> relies on the user calling it correctly.
>>
>> Also, do we need to enforce that page_pool_create_percpu() is only called
>> once for the same cpu? if no, we may have two page_pool instance sharing
>> the same stats.
> 
> do you mean for the same pp instance? I guess it is not allowed by the APIs.

As above comment, if the user is passing a valid cpuid, the PP_FLAG_SYSTEM_POOL
flag need to be set too? if yes, doesn't the new flag seems somewhat redundant
here?

