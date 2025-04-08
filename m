Return-Path: <netdev+bounces-180075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEFAA7F74B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF7D175AAC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 08:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C586E25F97B;
	Tue,  8 Apr 2025 08:08:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B19720459F;
	Tue,  8 Apr 2025 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099715; cv=none; b=kqdZPkik5Jfe6WrIMJej3vPZus/fHOkMFut2m7PIemcTCC6RVx/1wu4blVMrZ9FYkwgm37CxGwZo4zYBb+cZd+9PxGpTz3i0Zw5bCEYfmsViPPMZTLTdIYZyj1HFOWMZdcr3/Nr4G3jw4fmOEVuXpUEVAl5c9G6FDyUikJrqrR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099715; c=relaxed/simple;
	bh=r+T5hIHBLgYvpmfuRv9rLfqPaPhsXS05wJYQCJNX7Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tQed6t/7mmkVNBxrIrr9WoQKy2TB34puYObCcLpYkBlDrKzYNd4FCPXhWonjZvjc2XK9uOJDmQL1baDVw3Uq8KnUQcvDBkLwjhGD5fJbYrYM2iaIulMxhn9UEDmEuI2ZlHeAsNVuD9RaSl/n3VeOUzgJZ/5ru8hC3nE3H/HVYVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZWymr5bcnzHrFr;
	Tue,  8 Apr 2025 15:45:48 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B585D1800D1;
	Tue,  8 Apr 2025 15:49:11 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 15:49:10 +0800
Message-ID: <bfa5e258-fcca-4bb8-b5e9-50ba8e7fa249@huawei.com>
Date: Tue, 8 Apr 2025 15:49:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] ipv6: sit: fix skb_under_panic with overflowed
 needed_headroom
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<horms@kernel.org>, <kuniyu@amazon.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250401021617.1571464-1-wangliang74@huawei.com>
 <fe13ece8-67ea-48c0-a155-0cb6d2bcfc52@redhat.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <fe13ece8-67ea-48c0-a155-0cb6d2bcfc52@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2025/4/3 19:50, Paolo Abeni 写道:
> On 4/1/25 4:16 AM, Wang Liang wrote:
>> @@ -1452,7 +1457,9 @@ static int ipip6_tunnel_init(struct net_device *dev)
>>   	tunnel->dev = dev;
>>   	strcpy(tunnel->parms.name, dev->name);
>>   
>> -	ipip6_tunnel_bind_dev(dev);
>> +	err = ipip6_tunnel_bind_dev(dev);
>> +	if (err)
>> +		return err;
>>   
>>   	err = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
>>   	if (err)
> I think you additionally need to propagate the error in
> ipip6_tunnel_update() and handle it in ipip6_changelink() and
> ipip6_tunnel_change().


Thanks，I will add it in next patch.

>
> Side note: possibly other virtual devices are prone to similar issue. I
> suspect vxlan and gre. Could you please have a look?


Ok, I will try to reproduce the issue in vxvlan/gre scene later.

> Thanks,
>
> Paolo
>
>

