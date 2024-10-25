Return-Path: <netdev+bounces-138914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921889AF682
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0AEB21F09
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 01:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF571F5E6;
	Fri, 25 Oct 2024 01:10:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024AD1DFF7;
	Fri, 25 Oct 2024 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818654; cv=none; b=XjwVwb+0HslpvlcZb5G/iabz6PeD3UFtvyAinUgvDrdLm5zqr/AhfJiwz89GWQ+dWlQUwJqADi4Nq5/oal0DOxTJ/+HLsX0elTJjJJH514Iblfw0I5q6FXVXhoSH32yPrMbYbyGbT5z1Bmeo5PEG9STZF7IlLe1SN1ccz3eO+aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818654; c=relaxed/simple;
	bh=9i2UpWailRVQSnQwpSxLeAa0iO8U2wBNPJ2Gp0fUjlY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cTc2Oz5U0C0P4/40vQ7rW2/YcQPp/ZXmg2iAoH9Yn1rY5qiAY8Oy/uMQyvgy3TnZQdPI52tRziNMdTIRoemsMNTN9Qqyzw2BBLCsGx8nS61/YzUWvh4IJ0/2o7ntYBcTklm3qxiXUsL32NYuMWTPwdweL4ptWtQZyaqEiOGocHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XZPp35ds2zQsBm;
	Fri, 25 Oct 2024 09:09:47 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 7527D1800DB;
	Fri, 25 Oct 2024 09:10:41 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 09:10:40 +0800
Message-ID: <977d1e83-b24b-4f4c-ad5b-8fb95f45d189@huawei.com>
Date: Fri, 25 Oct 2024 09:10:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Paolo Abeni <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<shenjian15@huawei.com>, <salil.mehta@huawei.com>, <liuyonglong@huawei.com>,
	<wangpeiyang1@huawei.com>, <lanhao@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net 1/9] net: hns3: default enable tx bounce buffer
 when smmu enabled
To: Simon Horman <horms@kernel.org>
References: <20241018101059.1718375-1-shaojijie@huawei.com>
 <20241018101059.1718375-2-shaojijie@huawei.com>
 <50874428-b4ef-4e65-b60b-1bd917f1933c@redhat.com>
 <d68ad0c3-3d53-406b-ad98-5686512fa48e@huawei.com>
 <20241024160404.GC1202098@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241024160404.GC1202098@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/25 0:04, Simon Horman wrote:
> On Thu, Oct 24, 2024 at 04:31:46PM +0800, Jijie Shao wrote:
>> on 2024/10/24 16:26, Paolo Abeni wrote:
>>> On 10/18/24 12:10, Jijie Shao wrote:
>>>> From: Peiyang Wang <wangpeiyang1@huawei.com>
>>>>
>>>> The SMMU engine on HIP09 chip has a hardware issue.
>>>> SMMU pagetable prefetch features may prefetch and use a invalid PTE
>>>> even the PTE is valid at that time. This will cause the device trigger
>>>> fake pagefaults. The solution is to avoid prefetching by adding a
>>>> SYNC command when smmu mapping a iova. But the performance of nic has a
>>>> sharp drop. Then we do this workaround, always enable tx bounce buffer,
>>>> avoid mapping/unmapping on TX path.
>>>>
>>>> This issue only affects HNS3, so we always enable
>>>> tx bounce buffer when smmu enabled to improve performance.
>>>>
>>>> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
>>>> Signed-off-by: Jian Shen <shenjian15@huawei.com>
>>>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>>> I'm sorry to nick pick on somewhat small details, but we really need a
>>> fixes tag here to make 110% clear is a bugfix. I guess it could be the
>>> commit introducing the support for the buggy H/W.
>>>
>>> Thanks,
>>>
>>> Paolo
>> I have a little doubt that this patch is about H/W problem,
>> so how can we write the the fixes tag?
> Hi Jijie,
>
> That is a good point. But the much point of the Fixes tag is to indicate how
> far back the fix should be backported. So I would say the ID of the patch
> where the user would have first seen this problem - possibly the patch that
> added the driver.

That's a good idea. Thank you.




