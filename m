Return-Path: <netdev+bounces-13775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECDC73CE02
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 04:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624431C2088E
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 02:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E41632;
	Sun, 25 Jun 2023 02:19:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD27F
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 02:19:51 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64E5DA
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 19:19:49 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QpZNy0wg3ztQrt;
	Sun, 25 Jun 2023 10:17:06 +0800 (CST)
Received: from [10.174.178.171] (10.174.178.171) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 10:19:46 +0800
Subject: Re: [Question] integer overflow in function
 __qdisc_calculate_pkt_len()
To: Jakub Kicinski <kuba@kernel.org>
CC: Networking <netdev@vger.kernel.org>
References: <7723cc01-57bf-2b64-7f78-98a0e6508a2e@huawei.com>
 <20230605161922.5e417434@kernel.org>
 <c6ab254d-76c3-7507-3935-e9bad4da0bab@huawei.com>
 <20230606084919.5549dd58@kernel.org>
From: "luwei (O)" <luwei32@huawei.com>
Message-ID: <374426a9-2739-9aab-4ee4-ef31dab402a2@huawei.com>
Date: Sun, 25 Jun 2023 10:19:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230606084919.5549dd58@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.171]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


在 2023/6/6 11:49 PM, Jakub Kicinski 写道:
> On Tue, 6 Jun 2023 20:54:47 +0800 luwei (O) wrote:
>>> on a quick look limiting the cell_align to S16_MIN at the netlink level
>>> (NLA_POLICY_MIN()) seems reasonable, feel free to send a patch.
>>> .
>> Thanks for your reply, but do your mean cell_align or overhead? It seems
>> limit cell_align to
>>
>> S16_MIN(-32768) can still cause the overflow:
>>
>>       66 + (-2147483559) + (-32767) = 2147451036
>>
>>     skb->len = 66
>>     stab->szopts.overhead = -2147483559
>>     stab->szopts.cell_align = -32767
> Could you explain what the problem caused by the overflow will be?

yes, it affects the final result of pkt_len in 
__qdisc_calculate_pkt_len().  In the previous example, the final pkt_len 
will be 2147451040

which is very different from the origin skb->len 66 and it will reduce 
traffic control accuracy heavily.

it is calculated as follows:

void __qdisc_calculate_pkt_len(struct sk_buff *skb,
                                const struct qdisc_size_table *stab)
{
         int pkt_len, slot;

         pkt_len = skb->len + stab->szopts.overhead;     // pkt_len = 66 
+ (-2147483559) = -2147483493
         if (unlikely(!stab->szopts.tsize))
                 goto out;

         slot = pkt_len + stab->szopts.cell_align;            // slot  = 
-2147483493 + (-32767) = 2147451036
         if (unlikely(slot < 0))
                 slot = 0;

         slot >>= stab->szopts.cell_log;          slot  =  2147451036 
 >>  2 =  536862759
         if (likely(slot < stab->szopts.tsize))
                 pkt_len = stab->data[slot];
         else
                 pkt_len = stab->data[stab->szopts.tsize - 1] *
                                 (slot / stab->szopts.tsize) +
                                 stab->data[slot % 
stab->szopts.tsize];    // pkt_len  = 2048 * (536862759 / 512) + 160 = 
2147451040

         pkt_len <<= stab->szopts.size_log;
out:
         if (unlikely(pkt_len < 1))
                 pkt_len = 1;
         qdisc_skb_cb(skb)->pkt_len = pkt_len;
}
EXPORT_SYMBOL(__qdisc_calculate_pkt_len);
> .

-- 
Best Regards,
Lu Wei


