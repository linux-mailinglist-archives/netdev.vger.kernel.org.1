Return-Path: <netdev+bounces-138658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548B99AE7CA
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8635B1C213F4
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6201FC7D7;
	Thu, 24 Oct 2024 14:07:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79191FBF7C;
	Thu, 24 Oct 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778834; cv=none; b=ZSuckltTAFj/8wUvg3xKJRl0Yf+f9yz8Ov6LGuQpIN+H/9mTorFcv48fXYjHAy9vbEvfeCye1QUfdUzl7pq9nGrsY2TVZq87hwEhRuF1j1cfYscrnrcnzy14JlVsT6coM/SXRuDDKJgjuIRA7ODNZK46J6ZYcAWBKgnxOF/GTr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778834; c=relaxed/simple;
	bh=5oWYLx/0d5NYFF42DuAHF/AodoqpP22D1jgieW8UBwY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s/ayykvfR/r1vvWyhnRBZT21fq+QA6h0tjV7J0Tbq0/tQsRege2IYZwYbrwsk6uwOMX+IytjcZzfanuLGZAOgwOWtm0zWI7fgLQmbpSHDUISs3uqCJxTzMRHDoDbwl6Gq90cKT3FLQtW86UiaLD586blRACfL4/wzjTO9L2p+DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XZ74R033tzQrhF;
	Thu, 24 Oct 2024 22:06:15 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 3471E1402E1;
	Thu, 24 Oct 2024 22:07:08 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 22:07:06 +0800
Message-ID: <b0f662b0-938e-43bd-a429-1da15e5a7361@huawei.com>
Date: Thu, 24 Oct 2024 22:07:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/7] net: hibmcge: Add unicast frame filter
 supported in this module
To: Andrew Lunn <andrew@lunn.ch>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
 <20241023134213.3359092-4-shaojijie@huawei.com>
 <d66c277b-ea1c-4c33-ab2e-8bd1a0400543@lunn.ch>
 <c4d40afe-b48a-43da-be88-f7ee38dd720c@huawei.com>
 <a7f38f53-848f-42c5-ad20-a453474a835a@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <a7f38f53-848f-42c5-ad20-a453474a835a@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/24 20:07, Andrew Lunn wrote:
> On Thu, Oct 24, 2024 at 11:09:22AM +0800, Jijie Shao wrote:
>> on 2024/10/23 22:05, Andrew Lunn wrote:
>>>> +static int hbg_add_mac_to_filter(struct hbg_priv *priv, const u8 *addr)
>>>> +{
>>>> +	u32 index;
>>>> +
>>>> +	/* already exists */
>>>> +	if (!hbg_get_index_from_mac_table(priv, addr, &index))
>>>> +		return 0;
>>>> +
>>>> +	for (index = 0; index < priv->filter.table_max_len; index++)
>>>> +		if (is_zero_ether_addr(priv->filter.mac_table[index].addr)) {
>>>> +			hbg_set_mac_to_mac_table(priv, index, addr);
>>>> +			return 0;
>>>> +		}
>>>> +
>>>> +	if (!priv->filter.table_overflow) {
>>>> +		priv->filter.table_overflow = true;
>>>> +		hbg_update_promisc_mode(priv->netdev);
>>>> +		dev_info(&priv->pdev->dev, "mac table is overflow\n");
>>>> +	}
>>>> +
>>>> +	return -ENOSPC;
>>> I _think_ this is wrong. If you run out of hardware resources, you
>>> should change the interface to promiscuous mode and let the stack do
>>> the filtering. Offloading it to hardware is just an acceleration,
>>> nothing more.
>>>
>>> 	Andrew
>> In hbg_update_promisc_mode():
>> priv->filter.enabled = !(priv->filter.table_overflow || (netdev->flags & IFF_PROMISC));
>> hbg_hw_set_mac_filter_enable(priv, priv->filter.enabled);
>>
>> if table_overflow， and netdev->flags not set IFF_PROMISC，
>> the priv->filter.enabled will set to false， Then， The MAC filter will be closed.
>> I think it's probably the same thing you said
>>
>> In this:
>> +	if (!priv->filter.table_overflow) {
>> +		priv->filter.table_overflow = true;
>> +		hbg_update_promisc_mode(priv->netdev);
>> +		dev_info(&priv->pdev->dev, "mac table is overflow\n");
>> +	}
>> +
>> +	return -ENOSPC;
>>
>> When the first overflow occurs, a log is printed, the MAC filter will be disabled, and -ENOSPC is returned.
>> If continue to add MAC addresses, -ENOSPC is returned only.
> This is not obvious from a quick look at the code. Maybe a comment
> would be good.
>
> 	Andrew

ok, Thanks!



