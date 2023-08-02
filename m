Return-Path: <netdev+bounces-23485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC0076C236
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 03:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F154A2819BB
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 01:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37A77FA;
	Wed,  2 Aug 2023 01:28:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D67E
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 01:28:35 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A35210D;
	Tue,  1 Aug 2023 18:28:34 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RFvRW1Gx2ztRks;
	Wed,  2 Aug 2023 09:25:11 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 09:28:32 +0800
Subject: Re: [PATCH v3] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
To: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <yoshfuji@linux-ipv6.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<simon.horman@corigine.com>
References: <20230801064318.34408-1-yuehaibing@huawei.com>
 <CANn89iJO44CiUjftDZHEjOCy5Q3-PDB12uWTkrbA5JJNXMoeDA@mail.gmail.com>
 <20230801131146.51a9aaf3@kernel.org>
 <0e3e2d6f-0e8d-ccb4-0750-928a568ccaaf@kernel.org>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <cad2b715-14fc-8424-f85d-b5391e0110dc@huawei.com>
Date: Wed, 2 Aug 2023 09:28:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0e3e2d6f-0e8d-ccb4-0750-928a568ccaaf@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/2 8:52, David Ahern wrote:
> On 8/1/23 2:11 PM, Jakub Kicinski wrote:
>> On Tue, 1 Aug 2023 09:51:29 +0200 Eric Dumazet wrote:
>>>> -               skb_push(skb, -skb_network_offset(pkt));
>>>> +               __skb_pull(skb, skb_network_offset(pkt));
>>>>
>>>>                 skb_push(skb, sizeof(*msg));
>>>>                 skb_reset_transport_header(skb);  
>>>
>>> Presumably this code has never been tested :/
>>
>> Could have been tested on 32bit, I wonder if there is more such bugs :S
> 
> that pattern shows up a few times:

Ok, I will test and fix these if any.
> 
> net/ipv4/ah4.c:	skb_push(skb, -skb_network_offset(skb));
> net/ipv4/esp4.c:	skb_push(skb, -skb_network_offset(skb));
> net/ipv4/esp4_offload.c:	skb_push(skb, -skb_network_offset(skb));
> net/ipv4/esp4_offload.c:	skb_push(skb, -skb_network_offset(skb));
> net/ipv4/xfrm4_tunnel.c:	skb_push(skb, -skb_network_offset(skb));
> net/ipv6/ah6.c:	skb_push(skb, -skb_network_offset(skb));
> net/ipv6/esp6.c:	skb_push(skb, -skb_network_offset(skb));
> net/ipv6/esp6_offload.c:	skb_push(skb, -skb_network_offset(skb));
> net/ipv6/esp6_offload.c:	skb_push(skb, -skb_network_offset(skb));
> net/ipv6/ip6mr.c:		skb_push(skb, -skb_network_offset(pkt));
> net/ipv6/mip6.c:	skb_push(skb, -skb_network_offset(skb));
> net/ipv6/mip6.c:	skb_push(skb, -skb_network_offset(skb));
> net/ipv6/xfrm6_tunnel.c:	skb_push(skb, -skb_network_offset(skb));
> net/xfrm/xfrm_ipcomp.c:	skb_push(skb, -skb_network_offset(skb));
> .
> 

