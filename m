Return-Path: <netdev+bounces-144641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBF19C801A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E771B2351C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 01:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C6F2EAE4;
	Thu, 14 Nov 2024 01:41:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA772309B8
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731548485; cv=none; b=P6kKugyi72pr5HzBUlSDWISQUdA7CA8vJNMBHTj/QO8nI5c1ytZdWUw7Gxvuqgf6znZjuZpRUwhHeGI8BkuCYGzwgbCalncRf0o/15lMNVdc/zgmcvqy1HIpddzAdbiyp4qIjjxe7mRFgnBSfInkByxNBd9+1clvWYzDi8cIeac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731548485; c=relaxed/simple;
	bh=/sGVijHRI1ahXnEl7R2BFYaEqtSGhStIZ15Iu0wSW2I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=u28fXMgb4BMo9EW961IbUpu2mLsK13/TPaU1+vWrSCzt2jJfZ5aUxQ/5Aees/5Vfu1GJZ2Ogva6ANXb2Y1xkgBs4Zbys9+3lDDy7mBKSxW0DA8cQPxR/w6RO9SgySLjxxSerRte70gXmaO/UeiUAIKmIOf3mfmCS6hbgPoWQszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XpjVJ3sBGz1V47X;
	Thu, 14 Nov 2024 09:38:48 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 713ED14037E;
	Thu, 14 Nov 2024 09:41:18 +0800 (CST)
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemd100023.china.huawei.com (7.221.188.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Nov 2024 09:41:17 +0800
Message-ID: <06a0b358-d2f3-4248-82fb-7f599a2200a0@huawei.com>
Date: Thu, 14 Nov 2024 09:41:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: Fix icmp host relookup triggering ip_rt_bug
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>
References: <20241111123915.3879488-1-dongchenchen2@huawei.com>
 <ZzK5A9DDxN-YJlsk@gondor.apana.org.au>
 <8acfac66-bd2f-44a0-a113-89951dcfd2d3@huawei.com>
 <ZzLWcxskwi9e_bPf@gondor.apana.org.au>
 <9b9c7edf-fa68-465e-a960-0fe07773ba82@huawei.com>
 <97456f7d-83f3-404c-bc42-0a5f00af023e@huawei.com>
In-Reply-To: <97456f7d-83f3-404c-bc42-0a5f00af023e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100023.china.huawei.com (7.221.188.33)


On 2024/11/13 22:19, dongchenchen (A) wrote:
>
> On 2024/11/13 22:13, dongchenchen (A) wrote:
>>>> If skb_in is outbound, fl4_dec.saddr is not nolocal. It may be no 
>>>> input
>>>> route from B to A for
>>>>
>>>> first communication.
>>> You're right.  So the problem here is that for the case of A
>>> being local, we should not be taking the ip_route_input code
>>> path (this is intended for forwarded packets).
>>>
>>> In fact if A is local, and we're sending an ICMP message to A,
>>> then perhaps we could skip the IPsec lookup completely and just
>>> do normal routing?
>>>
>>> Steffen, what do you think?
>>>
>>> So I think it boils down to two choices:
>>>
>>> 1) We could simply drop IPsec processing if we notice that A
>>> (fl.fl4_dst) is local;
>>
>> Hi, Herbert! Thanks for your suggestions very much.
>>
>> maybe we can fix it as below:
>> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
>> index e1384e7331d8..5f63c4dde4e9 100644
>> --- a/net/ipv4/icmp.c
>> +++ b/net/ipv4/icmp.c
>> @@ -517,7 +517,9 @@ static struct rtable *icmp_route_lookup(struct 
>> net *net,
>>                           flowi4_to_flowi(fl4), NULL, 0);
>>         rt = dst_rtable(dst);
>>         if (!IS_ERR(dst)) {
>> -               if (rt != rt2)
>> +               unsigned int addr_type = 
>> inet_addr_type_dev_table(net, route_lookup_dev, fl4->daddr);
>> +               if (rt != rt2 || addr_type == RTN_LOCAL)
>>                         return rt;
>>         } else if (PTR_ERR(dst) == -EPERM) {
>>                 rt = NULL;
>>> 2) Or we could take the __ip_route_output_key code path and
>>> continue to do the xfrm lookup when A is local.
>
> sorry,  resend it due to format problems
>
> If only skip input route lookup as below, xfrm_lookup check may return 
> ENOENT
> for no xfrm pol or dst nofrm flag.

Sorry, I misunderstood earlier.
it's correct to return ENOENT here.
The difference from the above is:
If A is local, rt1->dst->dev is lo (fl4->dst is A),
rt2->dst->dev is actual dev selected by daddr B(fl4_2->dst is B)

>
> @@ -543,6 +544,10 @@ static struct rtable *icmp_route_lookup(struct 
> net *net,
>                         err = PTR_ERR(rt2);
>                         goto relookup_failed;
>                 }
> +
> +               unsigned int addr_type = inet_addr_type_dev_table(net, 
> route_lookup_dev, fl4->daddr);
> +               if (addr_type == RTN_LOCAL)
> +                       goto relookup;
>                 /* Ugh! */
>                 orefdst = skb_in->_skb_refdst; /* save old refdst */
>
> xfrm_lookup
>     xfrm_lookup_with_ifid
>         if (!if_id && ((dst_orig->flags & DST_NOXFRM) ||
>             !net->xfrm.policy_count[XFRM_POLICY_OUT]))
>             goto nopol;
>

