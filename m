Return-Path: <netdev+bounces-14763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD4743B2B
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 13:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4924B1C20BA5
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 11:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F5D13AF6;
	Fri, 30 Jun 2023 11:52:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361314265
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 11:52:25 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558CA3AAB
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 04:52:23 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qstrh2HrfzMpcK;
	Fri, 30 Jun 2023 19:49:08 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 30 Jun
 2023 19:52:20 +0800
Subject: Re: [PATCH net-next] skbuff: Optimize SKB coalescing for page pool
 case
To: Liang Chen <liangchen.linux@gmail.com>
CC: <ilias.apalodimas@linaro.org>, <hawk@kernel.org>, <kuba@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
References: <20230628121150.47778-1-liangchen.linux@gmail.com>
 <5b81338a-f784-d73e-170c-d12af38692cb@huawei.com>
 <CAKhg4tJkprS+dFcpLALP_e1kpHJ-DwabOMFaXxsPx+7O0c-geQ@mail.gmail.com>
 <CAKhg4t+RUeoTv_OnD5nMAXWeATqRC+tcyzbnz_jXBQGzd90rpQ@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <c04ee7cd-63a2-e35b-515c-726c10072f0e@huawei.com>
Date: Fri, 30 Jun 2023 19:52:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKhg4t+RUeoTv_OnD5nMAXWeATqRC+tcyzbnz_jXBQGzd90rpQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/6/29 20:19, Liang Chen wrote:
> On Thu, Jun 29, 2023 at 8:17 PM Liang Chen <liangchen.linux@gmail.com> wrote:
>>
>> On Thu, Jun 29, 2023 at 2:53 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>
>>> On 2023/6/28 20:11, Liang Chen wrote:
>>>> In order to address the issues encountered with commit 1effe8ca4e34
>>>> ("skbuff: fix coalescing for page_pool fragment recycling"), the
>>>> combination of the following condition was excluded from skb coalescing:
>>>>
>>>> from->pp_recycle = 1
>>>> from->cloned = 1
>>>> to->pp_recycle = 1
>>>>
>>>> However, with page pool environments, the aforementioned combination can
>>>> be quite common. In scenarios with a higher number of small packets, it
>>>> can significantly affect the success rate of coalescing. For example,
>>>> when considering packets of 256 bytes size, our comparison of coalescing
>>>> success rate is as follows:
>>>
>>> As skb_try_coalesce() only allow coaleascing when 'to' skb is not cloned.
>>>
>>> Could you give more detailed about the testing when we have a non-cloned
>>> 'to' skb and a cloned 'from' skb? As both of them should be belong to the
>>> same flow.
>>>
>>> I had the below patchset trying to do something similar as this patch does:
>>> https://lore.kernel.org/all/20211009093724.10539-5-linyunsheng@huawei.com/
>>>
>>> It seems this patch is only trying to optimize a specific case for skb
>>> coalescing, So if skb coalescing between non-cloned and cloned skb is a
>>> common case, then it might worth optimizing.
>>>
>>
>> Sure, Thanks for the information! The testing is just a common iperf
>> test as below.
>>
>> iperf3 -c <server IP> -i 5 -f g -t 0 -l 128
>>
>> We observed the frequency of each combination of the pp (page pool)
>> and clone condition when entering skb_try_coalesce. The results
>> motivated us to propose such an optimization, as we noticed that case
>> 11 (from pp/clone=1/1 and to pp/clone = 1/0) occurs quite often.
>>
>> +-------------+--------------+--------------+--------------+--------------+
>> |   from/to   | pp/clone=0/0 | pp/clone=0/1 | pp/clone=1/0 | pp/clone=1/1 |
>> +-------------+--------------+--------------+--------------+--------------+
>> |pp/clone=0/0 | 0            | 1            | 2            | 3            |
>> |pp/clone=0/1 | 4            | 5            | 6            | 7            |
>> |pp/clone=1/0 | 8            | 9            | 10           | 11           |
>> |pp/clone=1/1 | 12           | 13           | 14           | 15           |
>> |+------------+--------------+--------------+--------------+--------------+


I run the iperf test, it seems there is only one skb_clone() calling for each
round, and I was using 'iperf', not 'iperf3'.
Is there any app like tcpdump running? It seems odd that the skb from the rx
need to be cloned for a common iperf test, which app or configuration is causing
the cloning?

Maybe using the ftrace to see the skb_clone() calling?
echo skb_clone > set_ftrace_filter
echo function > current_tracer

