Return-Path: <netdev+bounces-215601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDAEB2F749
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE9F727CB1
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E302E03E3;
	Thu, 21 Aug 2025 11:54:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC32DAFD9;
	Thu, 21 Aug 2025 11:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777259; cv=none; b=Njgi/NtjiQphcWekUONTmVWSUIV67V9lj3UJfS8EnY+DCGqKZ0Dwmnybfh/l+KCYr/rdfHY/HTTX7dgKZ4Wsi8J/3CMIUPI/kRADFCPXkLSIq2iIZoSTNHm7porDmgMb0hJ6WkclXgPC3cGCqdY1OXilcGBKjowfw8Id2yDucvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777259; c=relaxed/simple;
	bh=PaAQHUyTGe+B93azQQXoaD5J7SC6s0Sk2ljBFxTqysk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oh61Qsw0V4RzvJBYz+gfl6XlJtAHi3HchX+4n7BUDACepgKDFXibdOnyGE1OxNqSAUOr/BvwjZgIWWpF0OmVYrJqvZYnBVTskY7w/c1eb65SnrNKyt0RS5c6ZQNLj2ATkAXgC9VOpGkuWbU4X/1I0djMBcGwqCrlxpoeLVC4ONE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c71qr6kZ0z2gL9S;
	Thu, 21 Aug 2025 19:51:20 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 83C731A016C;
	Thu, 21 Aug 2025 19:54:14 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 19:54:13 +0800
Message-ID: <1c4a6601-c484-4ffb-a0c1-ec02bd644a5e@huawei.com>
Date: Thu, 21 Aug 2025 19:54:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next] ipv6: mcast: Add ip6_mc_find_idev()
 helper
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250818101051.892443-1-yuehaibing@huawei.com>
 <4ff3b7df-cba0-4446-8411-7b99b5cdce69@redhat.com>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <4ff3b7df-cba0-4446-8411-7b99b5cdce69@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/8/21 17:42, Paolo Abeni wrote:
> On 8/18/25 12:10 PM, Yue Haibing wrote:
>> @@ -302,32 +310,18 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
>>  }
>>  EXPORT_SYMBOL(ipv6_sock_mc_drop);
>>  
>> -static struct inet6_dev *ip6_mc_find_dev(struct net *net,
>> -					 const struct in6_addr *group,
>> -					 int ifindex)
>> +static struct inet6_dev *ip6_mc_find_idev(struct net *net,
>> +					  const struct in6_addr *group,
>> +					  int ifindex)
>>  {
>> -	struct net_device *dev = NULL;
>> -	struct inet6_dev *idev;
>> -
>> -	if (ifindex == 0) {
>> -		struct rt6_info *rt;
>> +	struct inet6_dev *idev = NULL;
>> +	struct net_device *dev;
>>  
>> -		rcu_read_lock();
>> -		rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
>> -		if (rt) {
>> -			dev = dst_dev(&rt->dst);
>> -			dev_hold(dev);
>> -			ip6_rt_put(rt);
>> -		}
>> -		rcu_read_unlock();
>> -	} else {
>> -		dev = dev_get_by_index(net, ifindex);
>> +	dev = ip6_mc_find_dev(net, group, ifindex);
>> +	if (dev) {
>> +		idev = in6_dev_get(dev);
>> +		dev_put(dev);
>>  	}
>> -	if (!dev)
>> -		return NULL;
>> -
>> -	idev = in6_dev_get(dev);
>> -	dev_put(dev);
> 
> Not so minor nit: if you omit the last chunk (from 'if (dev) {' onwards,
> unneeded), the patch will be much more obvious and smaller. Also you
> could clarify a bit the commit message.

Thanks, it is indeed more clear, will do this in v2

> You can retain Dawid's ack when posting the next version
> 
> /P
> 
> 

