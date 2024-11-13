Return-Path: <netdev+bounces-144428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2DE9C734B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90BA0B33B40
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 14:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F021EF0BB;
	Wed, 13 Nov 2024 14:13:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D43938DE9
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507219; cv=none; b=q7h/9aTl9KI6R6tgQ4fpcrg07YMnM/vC83CU5DwB4OfRDWZt0KXZC2CpaJVH7Sv5XPIhwVsfoEpBTCtVFrePe1yd0hRDaudhXR4gLVH9PQU14mVep+WbMvO/d4xkIx+67/Iuf/AMnvs4NodS/g0+ooZFns+2vng39l7J/Z1U8Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507219; c=relaxed/simple;
	bh=GWV8bEHdSNFhWL+pf9N78emUz1WEYHvGCNfV27f0p24=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XPsUPsK6cxwsKPtxPAEd1YwkPWM8N/lt9GQtYgcYVieubarrY6WMccUO3M9+7J6bTaw/bfgKpveXXoIfdgvqvWNW8eCyYlUgvTQr+CS6i9UumGliPI/JcGFAe7AHP9OeVJAFFGege8JuYUCyOVji6T1W028SwuuOu/AaIOmoNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XpQFT0M5Wz2Dgvg;
	Wed, 13 Nov 2024 22:11:41 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 40AFF1400F4;
	Wed, 13 Nov 2024 22:13:31 +0800 (CST)
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemd100023.china.huawei.com (7.221.188.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Nov 2024 22:13:30 +0800
Message-ID: <9b9c7edf-fa68-465e-a960-0fe07773ba82@huawei.com>
Date: Wed, 13 Nov 2024 22:13:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: Fix icmp host relookup triggering ip_rt_bug
To: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>
References: <20241111123915.3879488-1-dongchenchen2@huawei.com>
 <ZzK5A9DDxN-YJlsk@gondor.apana.org.au>
 <8acfac66-bd2f-44a0-a113-89951dcfd2d3@huawei.com>
 <ZzLWcxskwi9e_bPf@gondor.apana.org.au>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <ZzLWcxskwi9e_bPf@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100023.china.huawei.com (7.221.188.33)

>> If skb_in is outbound, fl4_dec.saddr is not nolocal. It may be no input
>> route from B to A for
>>
>> first communication.
> You're right.  So the problem here is that for the case of A
> being local, we should not be taking the ip_route_input code
> path (this is intended for forwarded packets).
>
> In fact if A is local, and we're sending an ICMP message to A,
> then perhaps we could skip the IPsec lookup completely and just
> do normal routing?
>
> Steffen, what do you think?
>
> So I think it boils down to two choices:
>
> 1) We could simply drop IPsec processing if we notice that A
> (fl.fl4_dst) is local;

Hi, Herbert! Thanks for your suggestions very much.

maybe we can fix it as below:
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e1384e7331d8..5f63c4dde4e9 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -517,7 +517,9 @@ static struct rtable *icmp_route_lookup(struct net *net,
                           flowi4_to_flowi(fl4), NULL, 0);
         rt = dst_rtable(dst);
         if (!IS_ERR(dst)) {
-               if (rt != rt2)
+               unsigned int addr_type = inet_addr_type_dev_table(net, 
route_lookup_dev, fl4->daddr);
+               if (rt != rt2 || addr_type == RTN_LOCAL)
                         return rt;
         } else if (PTR_ERR(dst) == -EPERM) {
                 rt = NULL;
> 2) Or we could take the __ip_route_output_key code path and
> continue to do the xfrm lookup when A is local.
If only skip input route lookup as below, xfrm_lookup check may return 
ENOENT
for no xfrm pol or dst nofrm flag.

@@ -543,6 +544,10 @@ static struct rtable *icmp_route_lookup(struct net 
*net, err = PTR_ERR(rt2); goto relookup_failed; } + + unsigned int 
addr_type = inet_addr_type_dev_table(net, route_lookup_dev, fl4->daddr); 
+ if (addr_type == RTN_LOCAL) + goto relookup; /* Ugh! */ orefdst = 
skb_in->_skb_refdst; /* save old refdst */

xfrm_lookup
xfrm_lookup_with_ifid
       if (!if_id && ((dst_orig->flags & DST_NOXFRM) ||
!net->xfrm.policy_count[XFRM_POLICY_OUT]))
         goto nopol;

Thanks a lot!
Dong Chenchen

> Thanks,

