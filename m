Return-Path: <netdev+bounces-31715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B22178FB9F
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 12:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A13281984
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E85A940;
	Fri,  1 Sep 2023 10:14:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC40945F
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 10:14:04 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3E2E56;
	Fri,  1 Sep 2023 03:14:00 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RcYjs0Vy8zrS0t;
	Fri,  1 Sep 2023 18:12:17 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 18:13:58 +0800
Message-ID: <b5052977-1e5b-faa9-a77e-ac418e942873@huawei.com>
Date: Fri, 1 Sep 2023 18:13:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net,v2] wifi: mac80211: fix WARNING in
 ieee80211_link_info_change_notify()
To: Johannes Berg <johannes@sipsolutions.net>,
	<linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20230901035301.3473463-1-shaozhengchao@huawei.com>
 <7127fe5a4f2cfcdc3a55269f0a427477e264fabc.camel@sipsolutions.net>
 <abb4efba-90b4-da14-5683-3cd96819a5e0@huawei.com>
 <4e96e981f58ca5bccf71952f76efe5e08a88f11d.camel@sipsolutions.net>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <4e96e981f58ca5bccf71952f76efe5e08a88f11d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/1 17:19, Johannes Berg wrote:
> Hi,
> 
> 
>> 	Do you mean it shouldn't be allowed to set mcast rate when dev
>> is stopped,
>>
> 
> Probably?
> 
>>   as in the following code?
>>
>> --- a/net/wireless/rdev-ops.h
>> +++ b/net/wireless/rdev-ops.h
>> @@ -1229,7 +1229,7 @@ rdev_set_mcast_rate(struct
>> cfg80211_registered_device *rdev,
>>           int ret = -ENOTSUPP;
>>
>>           trace_rdev_set_mcast_rate(&rdev->wiphy, dev, mcast_rate);
>> -       if (rdev->ops->set_mcast_rate)
>> +       if (rdev->ops->set_mcast_rate && netif_running(dev))
>>                   ret = rdev->ops->set_mcast_rate(&rdev->wiphy, dev,
>>
> 
> Certainly not. Please don't do random patches without looking at the
> subsystem as a whole. If you don't want to take the time to understand
> how things work in wireless, then better don't send patches at all.
> 
> johannes

Hi johannes:
	It's a little difficult for me to solve this warning. This
warning has been going on for more than one year. Could you help solve 
it? Thank you.

links: 
https://groups.google.com/g/syzkaller-bugs/c/FofxpVlkONg/m/v296EFNnAAAJ

Zhengchao Shao

