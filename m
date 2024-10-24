Return-Path: <netdev+bounces-138504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79B29ADF34
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85874282BAD
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 08:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C506D18B46A;
	Thu, 24 Oct 2024 08:31:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E21AB525;
	Thu, 24 Oct 2024 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758713; cv=none; b=WYnSrTBZwNCH++pKbTkurpjrT43GE7kKLZXz+0puCaC3ZfqsPxE9QwqQNshT6JDMfD0mqcZ1DsRgYwiRALYGJaEmfnZzAe49pm7MAK1yTgVYGC+PDrNj6RWJzhu2edNsb7/J+ufRxXBz8UT3Gmj1KLX8eFj7pBs8k/4dmvr9JOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758713; c=relaxed/simple;
	bh=BF17VSasFWu3ct5Xtw3fwn5TGMxFxg37MvwZ9SW8E3s=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Sty+5b6u4kmpp1AtyWrGBQ89Z+AhjwyYjaOUbOJ2e9xZsoMNn4/0xcCV+zxtllfU339RdkncViD17ntkgDhDbZdJ3vOWaSStUtMe36KAz1iQGqeW2DC3TeZdHz81BhXturZoedUYQzCOkvGQQlEFSQMW7X7PXZ/XKt5Z2Ca1Ppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XYzc94VwCz10Nyq;
	Thu, 24 Oct 2024 16:29:45 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id BBCC318009B;
	Thu, 24 Oct 2024 16:31:48 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 16:31:47 +0800
Message-ID: <d68ad0c3-3d53-406b-ad98-5686512fa48e@huawei.com>
Date: Thu, 24 Oct 2024 16:31:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <liuyonglong@huawei.com>,
	<wangpeiyang1@huawei.com>, <lanhao@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net 1/9] net: hns3: default enable tx bounce buffer
 when smmu enabled
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <shenjian15@huawei.com>,
	<salil.mehta@huawei.com>
References: <20241018101059.1718375-1-shaojijie@huawei.com>
 <20241018101059.1718375-2-shaojijie@huawei.com>
 <50874428-b4ef-4e65-b60b-1bd917f1933c@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <50874428-b4ef-4e65-b60b-1bd917f1933c@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/24 16:26, Paolo Abeni wrote:
> On 10/18/24 12:10, Jijie Shao wrote:
>> From: Peiyang Wang <wangpeiyang1@huawei.com>
>>
>> The SMMU engine on HIP09 chip has a hardware issue.
>> SMMU pagetable prefetch features may prefetch and use a invalid PTE
>> even the PTE is valid at that time. This will cause the device trigger
>> fake pagefaults. The solution is to avoid prefetching by adding a
>> SYNC command when smmu mapping a iova. But the performance of nic has a
>> sharp drop. Then we do this workaround, always enable tx bounce buffer,
>> avoid mapping/unmapping on TX path.
>>
>> This issue only affects HNS3, so we always enable
>> tx bounce buffer when smmu enabled to improve performance.
>>
>> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
>> Signed-off-by: Jian Shen <shenjian15@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> I'm sorry to nick pick on somewhat small details, but we really need a
> fixes tag here to make 110% clear is a bugfix. I guess it could be the
> commit introducing the support for the buggy H/W.
>
> Thanks,
>
> Paolo

I have a little doubt that this patch is about H/W problem,
so how can we write the the fixes tag?

Thanks,
Jijie Shao



