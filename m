Return-Path: <netdev+bounces-45710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042B17DF21F
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 13:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72715B21255
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C878C18AFA;
	Thu,  2 Nov 2023 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977DC6FC3
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 12:16:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6657AD40;
	Thu,  2 Nov 2023 05:16:47 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SLjTH6PLjzrTvq;
	Thu,  2 Nov 2023 20:13:39 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 2 Nov 2023 20:16:42 +0800
Message-ID: <c87cfcbc-8cd6-4a01-bac0-74113f7ca904@huawei.com>
Date: Thu, 2 Nov 2023 20:16:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 6/7] net: hns3: fix VF reset fail issue
To: Paolo Abeni <pabeni@redhat.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>
References: <20231028025917.314305-1-shaojijie@huawei.com>
 <20231028025917.314305-7-shaojijie@huawei.com>
 <9bc9514044063bc57155fb786f970ca1d69758b4.camel@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <9bc9514044063bc57155fb786f970ca1d69758b4.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.192]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected

on 2023/11/2 18:45, Paolo Abeni wrote:
> On Sat, 2023-10-28 at 10:59 +0800, Jijie Shao wrote:
>>   
>> -static void hclgevf_clear_event_cause(struct hclgevf_dev *hdev, u32 regclr)
>> +static void hclgevf_clear_event_cause(struct hclgevf_dev *hdev, u32 regclr,
>> +				      bool need_dalay)
>>   {
>> +#define HCLGEVF_RESET_DELAY		5
>> +
>> +	if (need_dalay)
>> +		mdelay(HCLGEVF_RESET_DELAY);
> 5ms delay in an interrupt handler is quite a lot. What about scheduling
> a timer from the IH to clear the register when such delay is needed?
>
> Thanks!
>
> Paolo

Using timer in this case will complicate the code and make maintenance difficult.

We consider reducing the delay time by polling. For example,
the code cycles every 50 us to check whether the write register takes effect.
If yes, the function returns immediately. or the code cycles until 5 ms.

Is this method appropriate?

Thanks!
Jijie


