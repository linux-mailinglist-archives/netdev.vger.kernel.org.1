Return-Path: <netdev+bounces-154632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CAE9FEF25
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 12:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9437E188086E
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 11:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F17A192590;
	Tue, 31 Dec 2024 11:50:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A86A944E
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735645811; cv=none; b=iuAfVneRLzRzCVIB3G4pEpBt6JJZPHlEKNgLzFimEY322YX5RVh40G6ZD0Gbv0JAx2ogmBKl5oVugbWqc/qo703TaOro6/6MO+G1RhG30mkW4/u8vGOi6Ytn32nLxj/WDeA98Ya3IWfpDcfxW8JLYls7MEXJ0WXbtiiiEpHgyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735645811; c=relaxed/simple;
	bh=taHlsADHzdST+Lz4qtqCU0+J54skEacVOjC/uhug24c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=GhjgZRPUtTBD2+qVllowgVEB1zVlEU+artmP6ZNRpcPZdDkwYfoNdMGqbSAOiF8NaclJBTug3vYtRn6ll8Ut1CtoVzBmOH8v6wI4MGfdX4aRT65SbStCaTTAP4hGoYDgO/GVn9Q6a5itMx60w01btIT4T3zCER9mRA5RlctKao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YMrrF14LZz20n9W;
	Tue, 31 Dec 2024 19:50:21 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C6F0140133;
	Tue, 31 Dec 2024 19:50:00 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 31 Dec 2024 19:49:59 +0800
Message-ID: <6243b59f-dc40-4d97-bf16-77ae276e4a06@huawei.com>
Date: Tue, 31 Dec 2024 19:49:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] bnxt_en: handle tpa_info in queue API
 implementation
From: Yunsheng Lin <linyunsheng@huawei.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Michael Chan <michael.chan@broadcom.com>, David Wei <dw@davidwei.uk>,
	<netdev@vger.kernel.org>, Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20241204041022.56512-1-dw@davidwei.uk>
 <20241204041022.56512-4-dw@davidwei.uk>
 <9ca8506d-c42d-40a0-9532-7a95c06fed39@huawei.com>
 <0bc60b9d-fbf7-4421-ab6a-5854355d68f4@davidwei.uk>
 <a1d5ffda-1e6c-4730-8b36-6ba644bb0118@huawei.com>
 <fedc8606-b3bc-4fb1-8803-a004cb24216e@davidwei.uk>
 <CACKFLik1-rQB2QHY1pZ3eF0GYGUCgXFHvhh50DNboXV+A7MCuA@mail.gmail.com>
 <20241211164841.44cba0ad@kernel.org>
 <b0a4f301-9dfa-4785-9468-85f3849db81d@huawei.com>
 <20241212065614.189cc7bc@kernel.org>
 <6b876bf8-ad97-49c9-867d-f16f122bd514@huawei.com>
Content-Language: en-US
In-Reply-To: <6b876bf8-ad97-49c9-867d-f16f122bd514@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/12/13 20:17, Yunsheng Lin wrote:
> On 2024/12/12 22:56, Jakub Kicinski wrote:
>> On Thu, 12 Dec 2024 19:23:52 +0800 Yunsheng Lin wrote:
>>> It seems an extra RCU sync is not really needed if page_pool_destroy()
>>> for the old page_pool is called between napi_disable() and napi_enable()
>>> as page_pool_destroy() already have a RCU sync.
>>
>> I did my best.
>>
> 
> I am not sure how to interpret the above comment.
> 
> Anyway, I guess it can be said the patch in [1] is only trying to fix
> a use-after-freed problem basing on the assumption that the softirq
> context on the same CPU has ensured sequential execution and a specific
> NAPI instance executed between different CPUs has also ensured sequential
> execution, so page_pool_napi_local() will only return true for a softirq
> context specific to the CPU being pool->p.napi->list_owner when list_owner
> != -1 after napi_enable() is called, and page_pool_napi_local() will always
> return false after napi_disable() is called as pool->p.napi->list_owner is
> always -1 even when skb_defer_free_flush() can be called without binding to
> any NAPI instance and can be executed in the softirq context of any CPU.
> 
> If there is any timing window you think that might cause page_pool_napi_local()
> to return true unexpectly, it would be good to be more specific about it and
> a bigger rcu lock might be needed instead of a small rcu lock in [1].

Please let me know if there is other obvious timing window that need fixing.
If not, I am planning to keep that patch as part of the dma unmapping patchset
as the dma unmapping fix patch depends on synchronize_rcu() added in that patch
and the time window is so small that it doesn't seem to be an urgent fix, so
target the net-next as the dma unmapping fix does.

> 
> 1. https://lore.kernel.org/all/20241120103456.396577-2-linyunsheng@huawei.com/#r
> 

