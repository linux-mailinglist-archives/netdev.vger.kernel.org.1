Return-Path: <netdev+bounces-178943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CABC5A799A4
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC6318940E4
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F621448E0;
	Thu,  3 Apr 2025 01:27:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C681442E8;
	Thu,  3 Apr 2025 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743643650; cv=none; b=eqnDOMmkGGLnReUEDvlGDKgctQ2e3uX9Xj2yZEWpp/pQVysXGF17PBUp27JOaGIh2yuB/rn4Ai4MpvHJs5DCMAGSOppSL3qj+cSUT7coeYh/p10ndl2WBTVwXCejC6WDoHCpXegdr2vaqJIHchSLNd9YS0ZMYNslDp/vPYtoUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743643650; c=relaxed/simple;
	bh=HrEzHW49QUEjGo21ffJZkq40lksee52rhcKU2sN/bgs=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L3n8V3ZNbBfUVkOJ3iKDtW7Q5cGEqXeN0PEbgl0rTpicrj6hIoT8JC8BVcNQARNbbGgfMAFclXpvMPb6m9jbE555bZSDgZm0qZnUyQ7F5Rzgk5Q41wKCeAfxRtvpPimnU1WRSg+Pr3t78cWA8Pk3QJNAnjoRAQoNeOHYSA+sBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZSkdJ5GNDz27h7X;
	Thu,  3 Apr 2025 09:28:04 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F1CA1A016C;
	Thu,  3 Apr 2025 09:27:25 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Apr 2025 09:27:24 +0800
Message-ID: <6d39ab4a-3388-498e-ad01-e3c426076191@huawei.com>
Date: Thu, 3 Apr 2025 09:27:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/3] net: hns3: fix a use of uninitialized variable
 problem
To: Simon Horman <horms@kernel.org>
References: <20250402121001.663431-1-shaojijie@huawei.com>
 <20250402121001.663431-2-shaojijie@huawei.com>
 <20250402135800.GP214849@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250402135800.GP214849@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/4/2 21:58, Simon Horman wrote:
> On Wed, Apr 02, 2025 at 08:09:59PM +0800, Jijie Shao wrote:
>> From: Yonglong Liu <liuyonglong@huawei.com>
>>
>> In hclge_add_fd_entry(), if the flow type is FLOW_EXT, and the data of
>> m_ext is all zero, then some members of the local variable "info" are
>> not initialized.
> Hi,
>
> I am assuming that this occurs when hclge_fd_check_spec() returns early
> like this:
>
>          if (!(fs->flow_type & FLOW_EXT) || hclge_fd_is_user_def_all_masked(fs))
>                  return 0;
>
> But if so, should the description be "flow type is not FLOW_EXT, ..."
> (note the "not")? Or perhaps more clearly refer to the FLOW_EXT bit
> not being set?
>
> Also, I think it would be worth mentioning hclge_fd_check_spec()
> in the patch description, perhaps something like this.
>
>    In hclge_add_fd_entry(), if  hclge_fd_check_spec() returns early
>    because the FLOW_EXT bit is not set in the flow type, and ...
>
> Also, does this manifest in a user-visible problem? If so, I think
> it would be good to describe it in the patch description.
>
> If not, I think it would be good to mention how the problem was found.
> E.g.: "flagged by static analysis" (and mention the tool if it is publicly
> Available. Or, "found by inspection".

Yes, your comments are reasonable.
I will add the description in v2

Thanks,
Jijie Shao

>
>> Fixes: 67b0e1428e2f ("net: hns3: add support for user-def data of flow director")
>> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ...

