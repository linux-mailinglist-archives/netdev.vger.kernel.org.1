Return-Path: <netdev+bounces-16193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E455574BB94
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 05:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0B12819DA
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 03:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26B115A3;
	Sat,  8 Jul 2023 03:31:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F657E2
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 03:31:34 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CD1211F
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 20:31:29 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QybPR3KyFzTjvh;
	Sat,  8 Jul 2023 11:30:19 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 8 Jul 2023 11:31:25 +0800
Subject: Re: [PATCH net] ipv6/addrconf: fix a potential refcount underflow for
 idev
To: Eric Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <hannes@stressinduktion.org>,
	<fbl@redhat.com>
References: <20230707101701.2474499-1-william.xuanziyang@huawei.com>
 <CANn89i+qfg_PHT7gPfEMwwZcxx-P7bB8ShYrYZM7exvBYHwSQw@mail.gmail.com>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <9e42c8c2-32c1-d2ef-34ce-f239a45005e4@huawei.com>
Date: Sat, 8 Jul 2023 11:31:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89i+qfg_PHT7gPfEMwwZcxx-P7bB8ShYrYZM7exvBYHwSQw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Fri, Jul 7, 2023 at 12:17 PM Ziyang Xuan
> <william.xuanziyang@huawei.com> wrote:
>>
>> Now in addrconf_mod_rs_timer(), reference idev depends on whether
>> rs_timer is not pending. Then modify rs_timer timeout.
>>
>> There is a time gap in [1], during which if the pending rs_timer
>> becomes not pending. It will miss to hold idev, but the rs_timer
>> is activated. Thus rs_timer callback function addrconf_rs_timer()
>> will be executed and put idev later without holding idev. A refcount
>> underflow issue for idev can be caused by this.
>>
>>         if (!timer_pending(&idev->rs_timer))
>>                 in6_dev_hold(idev);
>>                   <--------------[1]
>>         mod_timer(&idev->rs_timer, jiffies + when);
>>
>> Hold idev anyway firstly. Then call mod_timer() for rs_timer, put
>> idev if mod_timer() return 1. This modification takes into account
>> the case where "when" is 0.
>>
>> Fixes: b7b1bfce0bb6 ("ipv6: split duplicate address detection and router solicitation timer")
>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
>> ---
>>  net/ipv6/addrconf.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>> index 5479da08ef40..d36e6c5e3081 100644
>> --- a/net/ipv6/addrconf.c
>> +++ b/net/ipv6/addrconf.c
>> @@ -318,9 +318,9 @@ static void addrconf_del_dad_work(struct inet6_ifaddr *ifp)
>>  static void addrconf_mod_rs_timer(struct inet6_dev *idev,
>>                                   unsigned long when)
>>  {
>> -       if (!timer_pending(&idev->rs_timer))
>> -               in6_dev_hold(idev);
>> -       mod_timer(&idev->rs_timer, jiffies + when);
>> +       in6_dev_hold(idev);
>> +       if (mod_timer(&idev->rs_timer, jiffies + when))
>> +               in6_dev_put(idev);
>>  }
>>
> 
> 
> All callers own an implicit or explicit reference to idev, so you can
> use the traditional

Yes, thank you for your comment.

Thanks,
William Xuan

> 
> if (!mod_timer(&idev->rs_timer, jiffies + when))
>      in6_dev_hold(idev);
> .
> 

