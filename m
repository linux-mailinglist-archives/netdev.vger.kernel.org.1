Return-Path: <netdev+bounces-147531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BED9DA04B
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 02:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE2F28450C
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 01:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDA479F6;
	Wed, 27 Nov 2024 01:33:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E2367
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732671195; cv=none; b=tA0HNyxDizzcnE/4hByVHwScXe2hF7JmtR80s8okISZfVUdGN11PRuZo/P0BmZ0Qkpfkb9UzSWKYOhBtO8k9vnqioySunezdWOf8C2F+TqLPQw7MtJJejX6gxZwg6rvkjbf5bL85DGTu+2o8Afnk9CvSW8YKRvrRybyEFFTPzmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732671195; c=relaxed/simple;
	bh=k3naQO61NhkynvyA9QlaBEjL5OShHI3HoAlolUnw13I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i5i18oMHp7kAB5b6iceeYX6cgUjDTMogIQQGF/FRAjtCkQdfOJrWLxTYKy03RSZoIptrM5BGWJOpbd0dc/Gv2JszBUyUEtK811NqpE8duUn3bCfBBM25ktgBFxgOhBu7o9V4C2i/3F+IYze7+V5DNHGQprG1rwsD3IHwmDy0AmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XyhjL6SBhz1k0Nk;
	Wed, 27 Nov 2024 09:31:02 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 296171A0188;
	Wed, 27 Nov 2024 09:33:10 +0800 (CST)
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemd100023.china.huawei.com (7.221.188.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Nov 2024 09:33:09 +0800
Message-ID: <2db420da-eb80-483f-a9e5-c65e2ef9141f@huawei.com>
Date: Wed, 27 Nov 2024 09:33:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: Fix icmp host relookup triggering ip_rt_bug
To: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <horms@kernel.org>,
	<herbert@gondor.apana.org.au>, <steffen.klassert@secunet.com>,
	<netdev@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>
References: <20241126025943.1223254-1-dongchenchen2@huawei.com>
 <e4477a20-8f35-43de-a7f9-a0c7570248cc@kernel.org>
 <CANn89iLxm+=_rm-GcJ2LenRTDThx2gkrqEJ-bEWqOGSxFVUw9Q@mail.gmail.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <CANn89iLxm+=_rm-GcJ2LenRTDThx2gkrqEJ-bEWqOGSxFVUw9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100023.china.huawei.com (7.221.188.33)


On 2024/11/27 1:26, Eric Dumazet wrote:
> \\
>
> On Tue, Nov 26, 2024 at 5:23 PM David Ahern <dsahern@kernel.org> wrote:
>> On 11/25/24 7:59 PM, Dong Chenchen wrote:
>>> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
>>> index 4f088fa1c2f2..0d51f8434187 100644
>>> --- a/net/ipv4/icmp.c
>>> +++ b/net/ipv4/icmp.c
>>> @@ -515,7 +515,10 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
>>>                          flowi4_to_flowi(fl4), NULL, 0);
>>>        rt = dst_rtable(dst);
>>>        if (!IS_ERR(dst)) {
>>> -             if (rt != rt2)
>>> +             unsigned int addr_type = inet_addr_type_dev_table(net,
>>> +                                                     route_lookup_dev, fl4->daddr);
>>> +
>>          unsigned int addr_type;
>>
>>          addr_type = inet_addr_type_dev_table(net, route_lookup_dev,
>>                                               fl4->daddr);
>>
>> allows the lines to meet column limits and alignment requirements.
>>
>>> +             if (rt != rt2 || c == RTN_LOCAL)
>>>                        return rt;
>>>        } else if (PTR_ERR(dst) == -EPERM) {
>>>                rt = NULL;
> Also, we can avoid the expensive call to  inet_addr_type_dev_table()
> and addr_type variable with :
>
> if (rt != rt2)
>      return rt;
> if (inet_addr_type_dev_table(net, route_lookup_dev,
>                                                 fl4->daddr) == RTN_LOCAL)
>     return rt;

Thanks for your suggestions!

v3 will be sent.


