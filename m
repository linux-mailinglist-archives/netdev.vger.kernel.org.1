Return-Path: <netdev+bounces-211859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A20CFB1BF78
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 06:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7424818A2A42
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 04:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A8213B5AE;
	Wed,  6 Aug 2025 04:00:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C293C1F;
	Wed,  6 Aug 2025 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754452849; cv=none; b=hRvl80ndC8CnKzmOAPlaE4Xr92/S/o2MeK+acKodjwEFs9sjMmR9k23DtY+ruoqSrYYI+PDDXrH4N6v4dTmOurK5TiDFgRZul0RFDug5QvyBCiOYepnxLzgJr/0kj7bHsfvP0BbtN4bvYEaXfL1EzQoMpfqHAWCrFQabFEZX774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754452849; c=relaxed/simple;
	bh=Yuw8bOEfvha+uWGO6FK0lOegX/jPVsfD62YLbYYk224=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pvRWdVahp7VP2mRSCUJaeRHnLwnHSYTqPU+YXjXhLzcRJ3liNtYr/7Y+XU6r81oac2MkOgNjMNCjbA+xwzGLE3nrIGr2CdvYE3p2UkM+bzVDAq64DcE5eOSdzkXESF/iVx571HUZYozhGDIIzQ3L1miOdLs+AjH2z9U5+qEqRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bxc1y55p4z13Mwn;
	Wed,  6 Aug 2025 11:57:26 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 87A2B1401F4;
	Wed,  6 Aug 2025 12:00:41 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 Aug 2025 12:00:40 +0800
Message-ID: <3aa80a19-d2cd-47a2-aaf9-4bc438b7656b@huawei.com>
Date: Wed, 6 Aug 2025 12:00:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net 2/3] net: hibmcge: fix the division by zero issue
To: Jakub Kicinski <kuba@kernel.org>
References: <20250802123226.3386231-1-shaojijie@huawei.com>
 <20250802123226.3386231-3-shaojijie@huawei.com>
 <20250805181446.3deaceb9@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250805181446.3deaceb9@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/8/6 9:14, Jakub Kicinski wrote:
> On Sat, 2 Aug 2025 20:32:25 +0800 Jijie Shao wrote:
>>   static inline u32 hbg_get_queue_used_num(struct hbg_ring *ring)
>>   {
>> +	if (!ring->len)
>> +		return 0;
>> +
>>   	return (ring->ntu + ring->len - ring->ntc) % ring->len;
> This should probably be a READ_ONCE() to a temporary variable.
> There is no locking in debugfs, AFAICT, the value may change
> between the test and the division / modulo.

Yes, there is indeed a very short time window.
I will add READ_ONCE() to ring->len and read it only once.

Thanks
Jijie Shao



