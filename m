Return-Path: <netdev+bounces-217603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DE2B393AB
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED831670B5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 06:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC34271476;
	Thu, 28 Aug 2025 06:13:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A532557A;
	Thu, 28 Aug 2025 06:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756361614; cv=none; b=O7j4FU9x9CqeWQqpsjEYY8lwoE/ZxfBLaKQVTahK6EzpwNg4A/Ro6b7MGQrVpms1QY202RgbuC/k/7HE8WRQWclYf2YVH9dGdFwxprRDORVnxrS/HbcaOGsG+Z6bHjhg1c6XsLIRO8sFhM4jrLDksbjfsRhCRMDoby2bNcLy290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756361614; c=relaxed/simple;
	bh=ZZuDNn7FRATh0tW1y7Zxk61lzgpGaderuZU1GPjVkGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k8Px3fCQjUXmv8VTzh5pqYQ5pnW9+1cbFQoFh1PfyLcd59N+5nP7TXKIgoEgpXctMI5MOT0+7mQcFJvkMd8JTf2q0OPXVTsemomFy5gmUo6paN23zwKZxrHac3tdVPP3q55uqKI3AX5hK90o/1/Fq+13SR0qBINCNDqr0JHVc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cC9wT1ZFfz13NPb;
	Thu, 28 Aug 2025 14:09:45 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 921A6180B57;
	Thu, 28 Aug 2025 14:13:28 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 14:13:27 +0800
Message-ID: <5b0d6d7c-b65e-4022-b028-05f45fe56bf9@huawei.com>
Date: Thu, 28 Aug 2025 14:13:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: sit: Add ipip6_tunnel_dst_find() for
 cleanup
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250827040027.1013335-1-yuehaibing@huawei.com>
 <ec71f1cd-89b9-4a18-bcc6-0bac6f6660d0@intel.com>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <ec71f1cd-89b9-4a18-bcc6-0bac6f6660d0@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/8/27 22:45, Alexander Lobakin wrote:
> From: Yue Haibing <yuehaibing@huawei.com>
> Date: Wed, 27 Aug 2025 12:00:27 +0800
> 
>> Extract the dst lookup logic from ipip6_tunnel_xmit() into new helper
>> ipip6_tunnel_dst_find() to reduce code duplication and enhance readability.
>>
>> No functional change intended.
> 
> ...but bloat-o-meter stats would be nice to see here. I'm curious
> whether the object code got any changes or the compilers still just
> inline this function to both call sites.

On a x86_64, with allmodconfig:
before:
   text    data     bss     dec     hex filename
  96973   14687     256  111916   1b52c net/ipv6/sit.o

after:
   text    data     bss     dec     hex filename
  96699   14599     256  111554   1b3c2 net/ipv6/sit.o

I will add this in v2.

> 
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>>  net/ipv6/sit.c | 93 +++++++++++++++++++++++---------------------------
>>  1 file changed, 43 insertions(+), 50 deletions(-)
>>
>> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
>> index 12496ba1b7d4..bcd261ff985b 100644
>> --- a/net/ipv6/sit.c
>> +++ b/net/ipv6/sit.c
>> @@ -848,6 +848,47 @@ static inline __be32 try_6rd(struct ip_tunnel *tunnel,
>>  	return dst;
>>  }
>>  
>> +static bool ipip6_tunnel_dst_find(struct sk_buff *skb, __be32 *dst,
>> +				  bool is_isatap)
>> +{
>> +	const struct ipv6hdr *iph6 = ipv6_hdr(skb);
>> +	struct neighbour *neigh = NULL;
>> +	const struct in6_addr *addr6;
>> +	bool found = false;
>> +	int addr_type;
>> +
>> +	if (skb_dst(skb))
>> +		neigh = dst_neigh_lookup(skb_dst(skb), &iph6->daddr);
>> +
>> +	if (!neigh) {
>> +		net_dbg_ratelimited("nexthop == NULL\n");
>> +		return found;
> 
> Return false here right away.
> 
>> +	}
>> +
>> +	addr6 = (const struct in6_addr *)&neigh->primary_key;
>> +	addr_type = ipv6_addr_type(addr6);
>> +
>> +	if (is_isatap) {
>> +		if ((addr_type & IPV6_ADDR_UNICAST) &&
>> +		    ipv6_addr_is_isatap(addr6)) {
>> +			*dst = addr6->s6_addr32[3];
>> +			found = true;
>> +		}
>> +	} else {
>> +		if (addr_type == IPV6_ADDR_ANY) {
>> +			addr6 = &ipv6_hdr(skb)->daddr;
>> +			addr_type = ipv6_addr_type(addr6);
>> +		}
>> +
>> +		if ((addr_type & IPV6_ADDR_COMPATv4) != 0) {
>> +			*dst = addr6->s6_addr32[3];
>> +			found = true;
>> +		}
>> +	}
>> +	neigh_release(neigh);
>> +	return found;
> 
> I'd put 2 additional newlines here:
> 
> 	}
> 
> 	neigh_release(neigh);
> 
> 	return found;
> }
> 
> for readability purposes and also a NL before the final `return` is
> usually mandatory.

OK， thanks.
> 
> Thanks,
> Olek
> 

