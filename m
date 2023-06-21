Return-Path: <netdev+bounces-12487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E8D737B53
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 08:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA861C20D87
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 06:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303511FB8;
	Wed, 21 Jun 2023 06:38:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FE81FAA
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:38:44 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C11B173F
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 23:38:42 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QmDKZ4w3wzqVDp;
	Wed, 21 Jun 2023 14:36:02 +0800 (CST)
Received: from [10.67.102.37] (10.67.102.37) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 21 Jun
 2023 14:38:39 +0800
Subject: Re: [PATCH net-next v2 3/4] net: hns3: fix strncpy() not using
 dest-buf length as length issue
To: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20230612122358.10586-1-lanhao@huawei.com>
 <20230612122358.10586-4-lanhao@huawei.com>
 <8e84a4a13d25ceed6ad2ad2e4137b2fc35a086e4.camel@redhat.com>
CC: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<richardcochran@gmail.com>, <wangpeiyang1@huawei.com>,
	<shenjian15@huawei.com>, <chenhao418@huawei.com>,
	<simon.horman@corigine.com>, <wangjie125@huawei.com>, <yuanjilin@cdjrlc.com>,
	<cai.huoqing@linux.dev>, <xiujianfeng@huawei.com>
From: Hao Lan <lanhao@huawei.com>
Message-ID: <90430ad3-a8e4-03bb-4add-652596e3d954@huawei.com>
Date: Wed, 21 Jun 2023 14:38:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8e84a4a13d25ceed6ad2ad2e4137b2fc35a086e4.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.37]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/6/14 18:34, Paolo Abeni wrote:
> On Mon, 2023-06-12 at 20:23 +0800, Hao Lan wrote:
>> From: Hao Chen <chenhao418@huawei.com>
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
>> index d385ffc21876..0749515e270b 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
>> @@ -438,19 +438,36 @@ static void hns3_dbg_fill_content(char *content, u16 len,
>>  				  const struct hns3_dbg_item *items,
>>  				  const char **result, u16 size)
>>  {
>> +#define HNS3_DBG_LINE_END_LEN	2
> 
> IMHO this macro should be defined outside the function (just before)
> for better readability.
> 

Hi Paolo Abeni,
Thank you for your advice. We use this macro style elsewhere in our code.
The style is consistent. Here we keep this macro style.

Yours,
Hao Lan

