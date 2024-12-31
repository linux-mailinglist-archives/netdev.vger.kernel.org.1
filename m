Return-Path: <netdev+bounces-154630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A00609FEF18
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 12:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E26A1882E86
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C3B191493;
	Tue, 31 Dec 2024 11:37:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84262AEE9
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735645044; cv=none; b=RY0RPTv8PiOb3yRH1tT6XwBxC+b4rrxIVprnUPvMptM+TMMEXGw/PfYnlN5+PAR750dMrbQ/U31r3lFBxdLsvL1AZEDfA3s8783/Od0OA3AaDDwzu/wkhFCOOUkrn6zp7CSeJBQN2TWrC45VbQNKkxnQYZqM0LfAgYZrZH9i4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735645044; c=relaxed/simple;
	bh=2ZMHIw7pHMR4EQV3vjtdYgnbaGGsuG2CUXVmY1zCPUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vEcKie8mVT0gKVaUjqjeDaTviDN+dYT1446eZQ4fUECf8mPuqQHwRROcYtbkacSmA7Byw0cAQz8tXbcal9TEX5hP+U4289gYtLcMY7Vt3luLdO9g3wUrQLFQ5kGN7T8/j+19Dz+/hVihyCW8opWoeTRgfCMErobzl1KbPlQzq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YMrT060nkz1M7t3;
	Tue, 31 Dec 2024 19:33:40 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5BC13180087;
	Tue, 31 Dec 2024 19:37:12 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 31 Dec 2024 19:37:12 +0800
Message-ID: <731d74c2-7cc6-4d60-a2a4-c451d399e442@huawei.com>
Date: Tue, 31 Dec 2024 19:37:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/6] enic: Use the Page Pool API for RX when
 MTU is less than page size
To: Jakub Kicinski <kuba@kernel.org>
CC: John Daley <johndale@cisco.com>, <benve@cisco.com>, <satishkh@cisco.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, Nelson Escobar
	<neescoba@cisco.com>
References: <20241228001055.12707-1-johndale@cisco.com>
 <20241228001055.12707-5-johndale@cisco.com>
 <ef5266a0-6d7a-4327-be7c-11f46f8d1074@huawei.com>
 <20241230084449.545b746f@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241230084449.545b746f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/12/31 0:44, Jakub Kicinski wrote:
> On Mon, 30 Dec 2024 17:18:39 +0800 Yunsheng Lin wrote:
>> On 2024/12/28 8:10, John Daley wrote:
>>> +void enic_rq_free_page(struct vnic_rq *vrq, struct vnic_rq_buf *buf)
>>> +{
>>> +	struct enic *enic = vnic_dev_priv(vrq->vdev);
>>> +	struct enic_rq *rq = &enic->rq[vrq->index];
>>> +
>>> +	if (!buf->os_buf)
>>> +		return;
>>> +
>>> +	page_pool_put_page(rq->pool, (struct page *)buf->os_buf,
>>> +			   get_max_pkt_len(enic), true);  
>>
>> It seems the above has a similar problem of not using
>> page_pool_put_full_page() when page_pool_dev_alloc() API is used and
>> page_pool is created with PP_FLAG_DMA_SYNC_DEV flags.
>>
>> It seems like a common mistake that a WARN_ON might be needed to catch
>> this kind of problem.
> 
> Agreed. Maybe also add an alias to page_pool_put_full_page() called
> something like page_pool_dev_put_page() to correspond to the alloc
> call? I suspect people don't understand the internals and "releasing
> full page" feels wrong when they only allocated a portion..

Yes, I guess so too.
But as all the alloc APIs have the 'dev' version of API:
page_pool_dev_alloc
page_pool_dev_alloc_frag
page_pool_dev_alloc_pages
page_pool_dev_alloc_va

Only adding 'dev' does not seem to clear the confusion from API naming
perspective.

