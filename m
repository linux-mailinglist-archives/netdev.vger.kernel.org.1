Return-Path: <netdev+bounces-120832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE57995AF5E
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CCA1F22313
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 07:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F221531D2;
	Thu, 22 Aug 2024 07:34:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04AA933;
	Thu, 22 Aug 2024 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312043; cv=none; b=KSxg7SxUOWK1M273J7Ou8jexObbRXFhbv8N9T0wbzfbvdHOM7ZdOnOUe0G1aK3EskwahmJoxhQYwVTulPurqXKDYanwPRDsQYe+YGirxv3GJj8oUbblXeVnvZyNSBAItTL7JnhVYr3m0vJG8Ta/odmQ+0/qy1uI0SLNwbI4nb94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312043; c=relaxed/simple;
	bh=L30NV2AcPLbkhFmH0b3ez67bhMd6a1pynzfPCQXulrg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I9nTB2BH/fCeg26w4AS9H7HPh/rDofCwUeb8984gySOoc9Xw9HGn3KiKcP4jCe4QqK1ILMfRFVYkdckX8KWKqm8C9P8ZmCmnIlc4jw9SILOJTtP6xOXTdGtiybF952W2judCbBWaqWDJgJiWRxHWMhPPk5x9rKjdENpjiCflIHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WqFLq4Cz0z2Cc9Z;
	Thu, 22 Aug 2024 15:33:55 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 047EA140447;
	Thu, 22 Aug 2024 15:33:59 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 15:33:57 +0800
Message-ID: <2a809cfe-c64c-4fbe-96e5-179d5cd27779@huawei.com>
Date: Thu, 22 Aug 2024 15:33:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Jakub Kicinski <kuba@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <jdamato@fastly.com>, <horms@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net-next 11/11] net: add is_valid_ether_addr check in
 dev_set_mac_address
To: Andrew Lunn <andrew@lunn.ch>
References: <20240820140154.137876-1-shaojijie@huawei.com>
 <20240820140154.137876-12-shaojijie@huawei.com>
 <20240820185507.4ee83dcc@kernel.org>
 <7bc7a054-f180-444a-aac0-61997b43e5d6@huawei.com>
 <5948f3f7-a43c-4238-82ff-2806a5ef5975@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <5948f3f7-a43c-4238-82ff-2806a5ef5975@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/21 20:15, Andrew Lunn wrote:
> On Wed, Aug 21, 2024 at 02:04:01PM +0800, Jijie Shao wrote:
>> on 2024/8/21 9:55, Jakub Kicinski wrote:
>>> On Tue, 20 Aug 2024 22:01:54 +0800 Jijie Shao wrote:
>>>> core need test the mac_addr not every driver need to do.
>>>>
>>>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>>>> ---
>>>>    net/core/dev.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>> index e7260889d4cb..2e19712184bc 100644
>>>> --- a/net/core/dev.c
>>>> +++ b/net/core/dev.c
>>>> @@ -9087,6 +9087,8 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
>>>>    		return -EOPNOTSUPP;
>>>>    	if (sa->sa_family != dev->type)
>>>>    		return -EINVAL;
>>>> +	if (!is_valid_ether_addr(sa->sa_data))
>>>> +		return -EADDRNOTAVAIL;
>>> not every netdev is for an Ethernet device
>> ok， this patch will be removed in v3.
>> and the check will move to hibmcge driver.
> No, you just need to use the correct function to perform the check.
>
> __dev_open() does:
>
>          if (ops->ndo_validate_addr)
>                  ret = ops->ndo_validate_addr(dev);
>
> 	Andrew

okay, it looks perfect!
	
	Jijie Shao


