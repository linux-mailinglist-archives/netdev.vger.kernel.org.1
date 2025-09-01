Return-Path: <netdev+bounces-218629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EBFB3DB0B
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FA5189A127
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 07:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4313726CE22;
	Mon,  1 Sep 2025 07:31:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B924BBEE;
	Mon,  1 Sep 2025 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756711887; cv=none; b=ur+18SA3tmbi0U9bdQdwEbQaP5parYQhM2XaHlKazgTmo6+4OUXyL+YZDAUnHd3zpfqQnpFe8vJNhDEq0fLCtM1y4UoMEkhi/314wWq0UGG56NgT03g2XBs9RewSrBLM9tLM25ZDZ2A5eDTcWVVxcHah/fTS65MxpAN67lpWnhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756711887; c=relaxed/simple;
	bh=QGMoGqIdED4O3ey5zqwIkEIvo26Jj/aOE8HktcTBXxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AEdr3ut8fBmeEuG4Cg+vcBm2INmiFfIklnx6sZpTNW4Lr0nZ8n0kdws2h2k6Hz5IVeA0gkvibt13LtNCUAOp7LkVD7R5qT85nkTJsODfesNF4hi/SAzHzlPmTKtL6LVtvlL6fMsSmrv94g8TXH/zvlLC0wb+R+duTqIgH8Co0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cFgRd2FhtzdcrQ;
	Mon,  1 Sep 2025 15:26:53 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id A6342180B66;
	Mon,  1 Sep 2025 15:31:21 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 15:31:20 +0800
Message-ID: <52416304-2334-4a61-971c-5d579b23ec51@huawei.com>
Date: Mon, 1 Sep 2025 15:31:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] ipv6: sit: Add ipip6_tunnel_dst_find() for
 cleanup
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250829100946.3570871-1-yuehaibing@huawei.com>
 <18594f40-f86f-4a28-a97a-22d8d8b614b6@intel.com>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <18594f40-f86f-4a28-a97a-22d8d8b614b6@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/8/29 23:46, Alexander Lobakin wrote:
> From: Yue Haibing <yuehaibing@huawei.com>
> Date: Fri, 29 Aug 2025 18:09:46 +0800
> 
>> Extract the dst lookup logic from ipip6_tunnel_xmit() into new helper
>> ipip6_tunnel_dst_find() to reduce code duplication and enhance readability.
>> No functional change intended.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
>>
>> On a x86_64, with allmodconfig object size is also reduced:
>>
>> ./scripts/bloat-o-meter net/ipv6/sit.o net/ipv6/sit-new.o
>> add/remove: 5/3 grow/shrink: 3/4 up/down: 1841/-2275 (-434)
>> Function                                     old     new   delta
>> ipip6_tunnel_dst_find                          -    1697   +1697
>> __pfx_ipip6_tunnel_dst_find                    -      64     +64
>> __UNIQUE_ID_modinfo2094                        -      43     +43
>> ipip6_tunnel_xmit.isra.cold                   79      88      +9
>> __UNIQUE_ID_modinfo2096                       12      20      +8
>> __UNIQUE_ID___addressable_init_module2092       -       8      +8
>> __UNIQUE_ID___addressable_cleanup_module2093       -       8      +8
>> __func__                                      55      59      +4
>> __UNIQUE_ID_modinfo2097                       20      18      -2
>> __UNIQUE_ID___addressable_init_module2093       8       -      -8
>> __UNIQUE_ID___addressable_cleanup_module2094       8       -      -8
>> __UNIQUE_ID_modinfo2098                       18       -     -18
>> __UNIQUE_ID_modinfo2095                       43      12     -31
>> descriptor                                   112      56     -56
>> ipip6_tunnel_xmit.isra                      9910    7758   -2152
>> Total: Before=72537, After=72103, chg -0.60%
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>> v2: add newlines before return in ipip6_tunnel_dst_find()
>>     add bloat-o-meter info in commit log
>> ---
>>  net/ipv6/sit.c | 95 ++++++++++++++++++++++++--------------------------
>>  1 file changed, 45 insertions(+), 50 deletions(-)
>>
>> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
>> index 12496ba1b7d4..60bd7f01fa09 100644
>> --- a/net/ipv6/sit.c
>> +++ b/net/ipv6/sit.c
>> @@ -848,6 +848,49 @@ static inline __be32 try_6rd(struct ip_tunnel *tunnel,
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
>> +		return false;
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
>> +
>> +	neigh_release(neigh);
>> +
>> +	return found;
>> +}
>> +
>>  /*
>>   *	This function assumes it is being called from dev_queue_xmit()
>>   *	and that skb is filled properly by that function.
>> @@ -867,8 +910,6 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
>>  	__be32 dst = tiph->daddr;
>>  	struct flowi4 fl4;
>>  	int    mtu;
>> -	const struct in6_addr *addr6;
>> -	int addr_type;
>>  	u8 ttl;
>>  	u8 protocol = IPPROTO_IPV6;
>>  	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
>> @@ -878,28 +919,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
>>  
>>  	/* ISATAP (RFC4214) - must come before 6to4 */
>>  	if (dev->priv_flags & IFF_ISATAP) {
>> -		struct neighbour *neigh = NULL;
>> -		bool do_tx_error = false;
>> -
>> -		if (skb_dst(skb))
>> -			neigh = dst_neigh_lookup(skb_dst(skb), &iph6->daddr);
>> -
>> -		if (!neigh) {
>> -			net_dbg_ratelimited("nexthop == NULL\n");
>> -			goto tx_error;
>> -		}
>> -
>> -		addr6 = (const struct in6_addr *)&neigh->primary_key;
>> -		addr_type = ipv6_addr_type(addr6);
>> -
>> -		if ((addr_type & IPV6_ADDR_UNICAST) &&
>> -		     ipv6_addr_is_isatap(addr6))
>> -			dst = addr6->s6_addr32[3];
>> -		else
>> -			do_tx_error = true;
>> -
>> -		neigh_release(neigh);
>> -		if (do_tx_error)
>> +		if (!ipip6_tunnel_dst_find(skb, &dst, true))
>>  			goto tx_error;
>>  	}
> 
> Ooops, sorry that I didn't notice that before.
> You can flatten the conditions now:

Sorry for miss this, will resend with proposed changes, thanks.
> 
> 	if ((dev->priv_flags & IFF_ISATAP) &&
> 	    !ipip6_tunnel_dst_find(skb, &dst, true))
> 		goto tx_error;
> 
>>  
>> @@ -907,32 +927,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
>>  		dst = try_6rd(tunnel, &iph6->daddr);
>>  
>>  	if (!dst) {
>> -		struct neighbour *neigh = NULL;
>> -		bool do_tx_error = false;
>> -
>> -		if (skb_dst(skb))
>> -			neigh = dst_neigh_lookup(skb_dst(skb), &iph6->daddr);
>> -
>> -		if (!neigh) {
>> -			net_dbg_ratelimited("nexthop == NULL\n");
>> -			goto tx_error;
>> -		}
>> -
>> -		addr6 = (const struct in6_addr *)&neigh->primary_key;
>> -		addr_type = ipv6_addr_type(addr6);
>> -
>> -		if (addr_type == IPV6_ADDR_ANY) {
>> -			addr6 = &ipv6_hdr(skb)->daddr;
>> -			addr_type = ipv6_addr_type(addr6);
>> -		}
>> -
>> -		if ((addr_type & IPV6_ADDR_COMPATv4) != 0)
>> -			dst = addr6->s6_addr32[3];
>> -		else
>> -			do_tx_error = true;
>> -
>> -		neigh_release(neigh);
>> -		if (do_tx_error)
>> +		if (!ipip6_tunnel_dst_find(skb, &dst, false))
>>  			goto tx_error;
>>  	}
> 
> Same here:
> 
> 	if (!dst && !ipip6_tunnel_dst_find(skb, &dst, false))
> 		goto tx_error;
> 
> Thanks,
> Olek
> 

