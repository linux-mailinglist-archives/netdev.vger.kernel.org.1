Return-Path: <netdev+bounces-127407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A3B97542C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB921282219
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC79419EEA1;
	Wed, 11 Sep 2024 13:30:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8E1E4B2;
	Wed, 11 Sep 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061440; cv=none; b=Lb10ozrU9c1/6vq8uVkNcEQsZPPm3/teqW8259gJxdz+1pB4a8lg96MeVvwYjK2lMFlwQh/G/nKD7qixrxQG2gpftNfuLar5pzuZab/qCmUeoD6pQT1CXFVLv1hkZyQpM9SV6XS+jKCXh/EDr+JAATx8LEVGwBjqruJ11Bl/GuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061440; c=relaxed/simple;
	bh=NxMiPe49Cx6o87TTz/SNfkbdjVafkgNygz0CGPGWrzs=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PU6U78fAdlUet7unCRhE5YQPoMzyLXNm9UFbdGZyY/OgAV27oLfqbUt2P0ANjB3gZHzCX97d0jZHf3Vu89LkrvkQ8qf0ytO8oRyvZ62ZAJBueB042kU9TwlwzN+V4vM3ukMBi9pnouE6g2VeLPNjiaook2Ptq8RmpTCaOCdsxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X3hDx1Sj3z1HJTc;
	Wed, 11 Sep 2024 21:26:57 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 76F2C14010C;
	Wed, 11 Sep 2024 21:30:32 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 21:30:31 +0800
Message-ID: <dbc5f648-4fc0-48f6-be71-cbecd1f54522@huawei.com>
Date: Wed, 11 Sep 2024 21:30:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <jdamato@fastly.com>, <horms@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V9 net-next 11/11] net: add ndo_validate_addr check in
 dev_set_mac_address
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>, Andrew Lunn
	<andrew@lunn.ch>
References: <20240910075942.1270054-1-shaojijie@huawei.com>
 <20240910075942.1270054-12-shaojijie@huawei.com>
 <CAH-L+nP2oy4Haw1+8Jy3GGgphxBii8m2zD03FXbC0SeR7QdhQg@mail.gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <CAH-L+nP2oy4Haw1+8Jy3GGgphxBii8m2zD03FXbC0SeR7QdhQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/9/10 16:39, Kalesh Anakkur Purayil wrote:
> On Tue, Sep 10, 2024 at 1:36 PM Jijie Shao <shaojijie@huawei.com> wrote:
>> If driver implements ndo_validate_addr,
>> core should check the mac address before ndo_set_mac_address.
>>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> ---
>> ChangeLog:
>> v2 -> v3:
>>    - Use ndo_validate_addr() instead of is_valid_ether_addr()
>>      in dev_set_mac_address(), suggested by Jakub and Andrew.
>>    v2: https://lore.kernel.org/all/20240820140154.137876-1-shaojijie@huawei.com/
>> ---
>>   net/core/dev.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 22c3f14d9287..00e0f473ed44 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -9087,6 +9087,11 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
>>                  return -EOPNOTSUPP;
>>          if (sa->sa_family != dev->type)
>>                  return -EINVAL;
>> +       if (ops->ndo_validate_addr) {
>> +               err = ops->ndo_validate_addr(dev);
>> +               if (err)
>> +                       return err;
>> +       }

This patch may not work as expected.

ndo_validate_addr() has only one parameter.
The sa parameter of the MAC address is not transferred to the function.
So ndo_validate_addr() checks the old MAC address, not the new MAC address.

I haven't found a better way to fix it yet.
This patch may be dropped in v10.

Sorry,
	Jijie Shao





