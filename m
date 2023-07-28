Return-Path: <netdev+bounces-22267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1A6766C66
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 14:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EC12825DE
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A0012B79;
	Fri, 28 Jul 2023 12:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5513ACF
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 12:00:25 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FAA44A6;
	Fri, 28 Jul 2023 05:00:23 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RC5lf0tWnz1GDHQ;
	Fri, 28 Jul 2023 19:59:26 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 20:00:21 +0800
Subject: Re: [PATCH] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
To: Eric Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yoshfuji@linux-ipv6.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20230728100035.32092-1-yuehaibing@huawei.com>
 <CANn89iJd5amMy+znSi_fP_zNLB3yta7XKcG7fVFk9h0JWDy6Pg@mail.gmail.com>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <1578283a-37fc-3679-25fe-3650cf150d11@huawei.com>
Date: Fri, 28 Jul 2023 20:00:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iJd5amMy+znSi_fP_zNLB3yta7XKcG7fVFk9h0JWDy6Pg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/28 18:50, Eric Dumazet wrote:
> On Fri, Jul 28, 2023 at 12:01 PM Yue Haibing <yuehaibing@huawei.com> wrote:
>>
>>  skbuff: skb_under_panic: text:ffffffff88771f69 len:56 put:-4
>>  head:ffff88805f86a800 data:ffff887f5f86a850 tail:0x88 end:0x2c0 dev:pim6reg
>>  ------------[ cut here ]------------
>>
> 
>> When setup a vlan device on dev pim6reg, DAD ns packet may sent on reg_vif_xmit().
>> reg_vif_xmit()
>>     ip6mr_cache_report()
>>         skb_push(skb, -skb_network_offset(pkt));//skb_network_offset(pkt) is 4
>> And skb_push declar as this:
>>         void *skb_push(struct sk_buff *skb, unsigned int len);
>>                 skb->data -= len;
>>                 //0xffff888f5f86a84c - 0xfffffffc = 0xffff887f5f86a850
>> skb->data is set to 0xffff887f5f86a850, which is invalid mem addr, lead to skb_push() fails.
>>
>> Fixes: 14fb64e1f449 ("[IPV6] MROUTE: Support PIM-SM (SSM).")
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>>  net/ipv6/ip6mr.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
>> index cc3d5ad17257..ee9c2ff8b0e4 100644
>> --- a/net/ipv6/ip6mr.c
>> +++ b/net/ipv6/ip6mr.c
>> @@ -1051,9 +1051,9 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
>>         int ret;
>>
>>  #ifdef CONFIG_IPV6_PIMSM_V2
>> +       int nhoff = skb_network_offset(pkt);
>>         if (assert == MRT6MSG_WHOLEPKT || assert == MRT6MSG_WRMIFWHOLE)
>> -               skb = skb_realloc_headroom(pkt, -skb_network_offset(pkt)
>> -                                               +sizeof(*msg));
>> +               skb = skb_realloc_headroom(pkt, -nhoff + sizeof(*msg));
>>         else
>>  #endif
>>                 skb = alloc_skb(sizeof(struct ipv6hdr) + sizeof(*msg), GFP_ATOMIC);
>> @@ -1073,7 +1073,8 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
>>                    And all this only to mangle msg->im6_msgtype and
>>                    to set msg->im6_mbz to "mbz" :-)
>>                  */
>> -               skb_push(skb, -skb_network_offset(pkt));
>> +               skb->data += nhoff;
>> +               skb->len  -= nhoff;
> 
> __skb_pull(skb, nhoff);

Thanks， will do this in v2.
> 
>>
>>                 skb_push(skb, sizeof(*msg));
>>                 skb_reset_transport_header(skb);
>> --
>> 2.34.1
>>
> .
> 

