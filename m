Return-Path: <netdev+bounces-31707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE4D78FA8B
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 11:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0633528193A
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5383946F;
	Fri,  1 Sep 2023 09:17:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B2399
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 09:17:42 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3279DB5;
	Fri,  1 Sep 2023 02:17:41 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RcXSs6wNpz1L9Ft;
	Fri,  1 Sep 2023 17:15:57 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 17:17:38 +0800
Message-ID: <abb4efba-90b4-da14-5683-3cd96819a5e0@huawei.com>
Date: Fri, 1 Sep 2023 17:17:38 +0800
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
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <7127fe5a4f2cfcdc3a55269f0a427477e264fabc.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/1 14:32, Johannes Berg wrote:
> On Fri, 2023-09-01 at 11:53 +0800, Zhengchao Shao wrote:
>>
>> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
>> index 24315d7b3126..f79e2343dddd 100644
>> --- a/net/mac80211/main.c
>> +++ b/net/mac80211/main.c
>> @@ -285,6 +285,9 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
>>   	if (!changed || sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
>>   		return;
>>   
>> +	if (!ieee80211_sdata_running(sdata))
>> +		return;
>> +
>>   	if (!check_sdata_in_driver(sdata))
>>   		return;
>>
> 
> I don't think this is right. Do you see anything else checking that it's
> running right before checking it's in the driver? :)
> 
> Why can we even get into this call at all? I think the problem is
> already in cfg80211 allowing this.
> 
> johannes
> 

Hi johannes:
	Do you mean it shouldn't be allowed to set mcast rate when dev
is stopped, as in the following code?

--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1229,7 +1229,7 @@ rdev_set_mcast_rate(struct 
cfg80211_registered_device *rdev,
         int ret = -ENOTSUPP;

         trace_rdev_set_mcast_rate(&rdev->wiphy, dev, mcast_rate);
-       if (rdev->ops->set_mcast_rate)
+       if (rdev->ops->set_mcast_rate && netif_running(dev))
                 ret = rdev->ops->set_mcast_rate(&rdev->wiphy, dev, 
mcast_rate);
         trace_rdev_return_int(&rdev->wiphy, ret);
         return ret;


Thank you

Zhengchao Shao

