Return-Path: <netdev+bounces-134132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFE39981E1
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593851C2620A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17561C2335;
	Thu, 10 Oct 2024 09:14:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED65192B78;
	Thu, 10 Oct 2024 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551685; cv=none; b=FEknfpR+bk2tuQDzNlqFVC4rqRfDExx31/2iZ39UDVqQiCsI/4ZKCc+lWvQ+zlW+nziHc+0R0JclWIissoBs8NYD1iZFlYaCRjAiqfspo3W8Ma5LJzpSmHlVd4i3hxqMXyRmjOtzuOHsVtY4r0fJQTSTAP42hnDr3MHhFN1hWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551685; c=relaxed/simple;
	bh=CljuXAkiklBjjcflk23mN/Np2eZe6Y4+FidqPD/vwQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tlJ6GM2AQzNs6kj0EiTZgi4rj21d1gL/lbu2zqyAAYH17gIlblP2LPoVaM4NneyH8hCIpEmOFuDlcRFq3ipffTWVC7dvAOnwSOAoD9viAa4E3lAJTHyfmFopKtChWOWuwkUA/D4/plhQzubGZmnbscl5FlEeW4WRuKxMbCkCEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPPDs3RQqzyScP;
	Thu, 10 Oct 2024 17:13:17 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C78261402CB;
	Thu, 10 Oct 2024 17:14:34 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 17:14:34 +0800
Message-ID: <1cf2b294-d0b4-4116-bd14-a937bce7da4a@huawei.com>
Date: Thu, 10 Oct 2024 17:14:34 +0800
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
 <e420a11f-1c07-4a3f-85b4-b7679b4e50ce@huawei.com>
 <20241009081314.611a5825@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241009081314.611a5825@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/9 23:13, Jakub Kicinski wrote:
> On Wed, 9 Oct 2024 11:33:02 +0800 Yunsheng Lin wrote:
>> Or I am missing something obvious here?
> 
> Seemingly the entire logic of how the safety of the lockless caching 
> is ensured.

I looked at it more closely, it seems what you meant ensuring is by setting
the napi->list_owner to -1 when disabling NAPI, right?

But letting skb_defer_free_flush() holding on the napi instance to check
the napi->list_owner without synchronizing with page_pool_destroy() seems
a little surprised to me, as page_pool_destroy() may return to driver to
free the napi even if it is a very very small time window, causing a
possible used-after-free problem?

          CPU 0                           CPU1
           .                               .
           .                   skb_defer_free_flush()
           .                               .
           .                  napi = READ_ONCE(pool->p.napi);
           .                               .
page_pool_disable_direct_recycling()       .
    driver free napi memory                .
           .                               .
           .              napi && READ_ONCE(napi->list_owner) == cpuid
           .                               .

> 
> But I don't think you don't trust my opinion so I'll let others explain
> this to you..

