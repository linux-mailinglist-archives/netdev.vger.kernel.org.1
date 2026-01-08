Return-Path: <netdev+bounces-247978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8286DD0155E
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 08:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00B3F30596A8
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 07:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC903168F5;
	Thu,  8 Jan 2026 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Ebv8cuW+";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Ebv8cuW+"
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92E42206A7;
	Thu,  8 Jan 2026 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767855663; cv=none; b=RzoFHrLLMIuJ/0wBHORdIKuyRcFfRLwY32/scPTFheZIdy5G2skNKiZ7VXQ560DXfkpsVbe2gqeRJ4dILQoQGwTbjC9hqJOMovrSXUTggdpX+TzV1TzAGJUOgE4jnJ9+mizEZsQbL+brjd39nT7ENPJfw1XcDKOee0MjxvY5koo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767855663; c=relaxed/simple;
	bh=WF713rbK7j9m0UsX+2BHjpruK6RM27al3etiKCRW2I4=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o41O9gHjOskNH9nr46Zg/WAs+G+rVNa+ZVD1QCSzMYxpVvjlYyx8S7tbazhYuI2F6825qTdcFdw8YrSYKdSJl5pVOwLUl3lxl4VAxD1eEaeg6E6t7mEwAaXHJa1GOlzS8MYImmXXiHGuWjzNtXAy0ziTlAeSwupodh2jibHy+FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Ebv8cuW+; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Ebv8cuW+; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=J/4Ru9Qo0gOgEQ5BwfK0ZY8r0PXcJK0pzkHLMSPctDg=;
	b=Ebv8cuW+eentUAvh8NHSLk3ToBe4OKSx/X05wlG6nNOoEDbHuJnPgcIqzm1a/nC8VJ//93jQF
	l0ekDzAfl+9f+PdUfr37Aib5C/FpQgYEEaewALllhfPBZ9DWXX4gCwjhofPQuqAfZ7oNsptsf3m
	hgoxxeWJCe9a4UeMP3/O4J0=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dmwkx5zyBz1BGVc;
	Thu,  8 Jan 2026 14:59:53 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=J/4Ru9Qo0gOgEQ5BwfK0ZY8r0PXcJK0pzkHLMSPctDg=;
	b=Ebv8cuW+eentUAvh8NHSLk3ToBe4OKSx/X05wlG6nNOoEDbHuJnPgcIqzm1a/nC8VJ//93jQF
	l0ekDzAfl+9f+PdUfr37Aib5C/FpQgYEEaewALllhfPBZ9DWXX4gCwjhofPQuqAfZ7oNsptsf3m
	hgoxxeWJCe9a4UeMP3/O4J0=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dmwgc5C0Fz1T4Lm;
	Thu,  8 Jan 2026 14:57:00 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0377B4056D;
	Thu,  8 Jan 2026 15:00:45 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 8 Jan 2026 15:00:44 +0800
Message-ID: <178a0dc6-438b-4f6f-9cf3-0fb36f7953b3@huawei.com>
Date: Thu, 8 Jan 2026 15:00:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next 2/6] net: phy: add support to set default
 rules
To: Andrew Lunn <andrew@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-3-shaojijie@huawei.com>
 <fe22ae64-2a09-45ce-8dbf-a4683745e21c@lunn.ch>
 <647f91c7-72c2-4e9d-a26d-3f1b5ee42b21@huawei.com>
 <4e884fc2-9f64-48dd-b0be-e9bb6ec0582d@lunn.ch>
 <3c82f4e1-0702-4617-b40c-d7f1cbd5a1de@huawei.com>
 <970a1e2d-c1b1-4b96-9e8e-71aea6b6dc44@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <970a1e2d-c1b1-4b96-9e8e-71aea6b6dc44@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2026/1/7 21:09, Andrew Lunn wrote:
> On Thu, Dec 18, 2025 at 09:35:44AM +0800, Jijie Shao wrote:
>> on 2025/12/17 21:53, Andrew Lunn wrote:
>>>> Some of our boards have only one LED, and we want to indicate both
>>>> link and active(TX and RX) status simultaneously.
>>> Configuration is generally policy, which is normally done in
>>> userspace. I would suggest a udev rule.
>>>
>>> 	Andrew
>> Yes, the PHY LED framework supports configuration from user space,
>> allowing users to configure their preferred policies according to their own requirements.
>> I believe this is the original intention of the LED framework.
>>
>> However, we cannot require users to actively configure policies,
>> nor can we restrict the types of OS versions they use.
>> Therefore, I personally think that the driver should still provide a reasonable default policy
>> to ensure that the LED behavior meets the needs of most scenarios.
> As i said, DT describes hardware, the fact there is an LED, what bus
> it is on, colour etc, is describing hardware. How you blink it is
> policy, so i expect the DT Maintainers will push back on putting
> policy into DT.
>
> So i think your best way forwards is as Russell suggests, some form of
> firmware sets the LED before Linux takes control of it. Or udev.
>
> 	Andrew

Yes, at present, this seems to be the only solution.
Recently, I have also been developing a UEFI driver for PXE,
which might be a solution.

However, there is no way to handle the issue with another patch;
I cannot directly modify the ACPI table (a risky operation).

Thanks,
Jijie Shao







