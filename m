Return-Path: <netdev+bounces-34229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A897A2E60
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 09:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED48128208C
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 07:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55517461;
	Sat, 16 Sep 2023 07:20:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611BE6131
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 07:20:34 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BF6CD8
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 00:20:31 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rnj8M0WyNz1N7w0;
	Sat, 16 Sep 2023 15:18:27 +0800 (CST)
Received: from [10.67.120.135] (10.67.120.135) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 16 Sep 2023 15:20:27 +0800
Subject: Re: [RFCv8 PATCH net-next 00/55] net: extend the type of
 netdev_features_t to bitmap
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <ecree.xilinx@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <saeed@kernel.org>,
	<leon@kernel.org>, <netdev@vger.kernel.org>, <linuxarm@huawei.com>
References: <20220918094336.28958-1-shenjian15@huawei.com>
 <20221125154421.82829-1-alexandr.lobakin@intel.com>
 <724a884e-d5ca-8192-b3be-bf68711be515@huawei.com>
 <20221128155127.2101925-1-alexandr.lobakin@intel.com>
 <d250f3b2-a63e-f0c5-fb48-52210922a846@intel.com>
From: "shenjian (K)" <shenjian15@huawei.com>
Message-ID: <0352cd0e-9721-514d-0683-0eed91f711d7@huawei.com>
Date: Sat, 16 Sep 2023 15:20:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d250f3b2-a63e-f0c5-fb48-52210922a846@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.135]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/9/13 18:28, Alexander Lobakin 写道:
> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date: Mon, 28 Nov 2022 16:51:27 +0100
>
>> From: "shenjian (K)" <shenjian15@huawei.com>
>> Date: Mon, 28 Nov 2022 23:22:28 +0800
>>
>>> 2022/11/25 23:44, Alexander Lobakin:
>>>> From: Jian Shen <shenjian15@huawei.com>
>>>> Date: Sun, 18 Sep 2022 09:42:41 +0000
>>>>
>>>>> For the prototype of netdev_features_t is u64, and the number
>>>>> of netdevice feature bits is 64 now. So there is no space to
>>>>> introduce new feature bit.
>>>>>
>>>>> This patchset try to solve it by change the prototype of
>>>>> netdev_features_t from u64 to structure below:
>>>>> 	typedef struct {
>>>>> 		DECLARE_BITMAP(bits, NETDEV_FEATURE_COUNT);
>>>>> 	} netdev_features_t;
>>>>>
>>>>> With this change, it's necessary to introduce a set of bitmap
>>>>> operation helpers for netdev features. [patch 1]
>>>> Hey,
>>>>
>>>> what's the current status, how's going?
>>>>
>>>> [...]
>>> Hi, Alexander
>>>
>>> Sorry to reply late, I'm still working on this, dealing with split the
>>> patchset.
>> Hey, no worries. Just curious as I believe lots of new features are
>> waiting for new bits to be available :D
> Hey,
>
> Any news?
Sorry， Olek .

Would you like to continue the work ? I thought I could finish this work 
as soon as possible, but in fact, there is a serious time conflict.

Jian

>>> Btw, could you kindly review this V8 set? I have adjusted the protocol
>>> of many interfaces and helpers,
>> I'll try to find some time to review it this week, will see.
>>
>>> to avoiding return or pass data large than 64bits. Hope to get more
>> Yes, I'd prefer to not pass more than 64 bits in one function
>> argument, which means functions operating with netdev_features_t
>> must start take pointers. Otherwise, with passing netdev_features_t
>> directly as a struct, the very first newly added feature will do
>> 8 -> 16 bytes on the stack per argument, boom.
>>
>>> opinions.
>>>
>>> Thanks!
>>>
>>> Jian
>>>>> -- 
>>>>> 2.33.0
>>>> Thanks,
>>>> Olek
>> Thanks,
>> Olek
> Thanks,
> Olek
> .
>


