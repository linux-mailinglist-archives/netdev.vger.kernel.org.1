Return-Path: <netdev+bounces-23065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB0E76A914
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893001C20DBB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 06:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2835667;
	Tue,  1 Aug 2023 06:29:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624C3EA3
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:29:02 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E269F19AA;
	Mon, 31 Jul 2023 23:28:32 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFQ9r2JMzzVjrq;
	Tue,  1 Aug 2023 14:26:40 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 14:28:22 +0800
Subject: Re: [PATCH v2] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <yoshfuji@linux-ipv6.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <simon.horman@corigine.com>
References: <20230728121703.29572-1-yuehaibing@huawei.com>
 <20230731200959.2019cb9c@kernel.org>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <f91c3fd7-8d7a-7a91-8d16-935c90ef9b5d@huawei.com>
Date: Tue, 1 Aug 2023 14:28:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230731200959.2019cb9c@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/1 11:09, Jakub Kicinski wrote:
> On Fri, 28 Jul 2023 20:17:03 +0800 Yue Haibing wrote:
>>  #ifdef CONFIG_IPV6_PIMSM_V2
>> +	int nhoff = skb_network_offset(pkt);
>>  	if (assert == MRT6MSG_WHOLEPKT || assert == MRT6MSG_WRMIFWHOLE)
>> -		skb = skb_realloc_headroom(pkt, -skb_network_offset(pkt)
>> -						+sizeof(*msg));
>> +		skb = skb_realloc_headroom(pkt, -nhoff + sizeof(*msg));
> 
> These changes look unnecessary. You can leave this code be (as ugly as
> it is)...
> 
>>  	else
>>  #endif
>>  		skb = alloc_skb(sizeof(struct ipv6hdr) + sizeof(*msg), GFP_ATOMIC);
>> @@ -1073,7 +1073,7 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
>>  		   And all this only to mangle msg->im6_msgtype and
>>  		   to set msg->im6_mbz to "mbz" :-)
>>  		 */
>> -		skb_push(skb, -skb_network_offset(pkt));
>> +		__skb_pull(skb, nhoff);
> 
> .. and just replace the push here with:
> 
>   __skb_pull(skb, skb_network_offset(pkt));

Thanks， will do this in v3.
> 

