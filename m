Return-Path: <netdev+bounces-29906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4DB7851DF
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E175281242
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33AD946F;
	Wed, 23 Aug 2023 07:44:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81AF883A
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:44:19 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC075E79
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:44:02 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RVynL23MWzLpL0;
	Wed, 23 Aug 2023 15:40:54 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 15:43:58 +0800
Message-ID: <2763f37a-8707-7fad-5dd4-cc4247fe3e1b@huawei.com>
Date: Wed, 23 Aug 2023 15:43:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next v4 3/3] net: lan743x: Return PTR_ERR() for
 fixed_phy_register()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <rafal@milecki.pl>, <bcm-kernel-feedback-list@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<opendmb@gmail.com>, <florian.fainelli@broadcom.com>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <andrew@lunn.ch>
References: <20230821025020.1971520-1-ruanjinjie@huawei.com>
 <20230821025020.1971520-4-ruanjinjie@huawei.com>
 <20230822170335.671f3bef@kernel.org>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230822170335.671f3bef@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/23 8:03, Jakub Kicinski wrote:
> On Mon, 21 Aug 2023 10:50:20 +0800 Jinjie Ruan wrote:
>> fixed_phy_register() returns -c, -EINVAL and -EBUSY,
>> etc, in addition to -EIO. The Best practice is to return these
>> error codes with PTR_ERR().
> 
> EPROBE_DEFER is not a unix error code. We can't return it to user
> space, so propagating it from ndo_open is not correct.

When the error is EPROBE_DEFER, Whether print the netdev_err is ok? And
what should it return?

How about this?

if (IS_ERR(phydev)) {
     ......
     if (PTR_ERR(phydev) != -EPROBE_DEFER)
         return PTR_ERR(phydev);
     else
         return -EIO;
}

> 
>> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
>> index a36f6369f132..c81cdeb4d4e7 100644
>> --- a/drivers/net/ethernet/microchip/lan743x_main.c
>> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
>> @@ -1515,7 +1515,7 @@ static int lan743x_phy_open(struct lan743x_adapter *adapter)
>>  							    &fphy_status, NULL);
>>  				if (IS_ERR(phydev)) {
>>  					netdev_err(netdev, "No PHY/fixed_PHY found\n");
>> -					return -EIO;
>> +					return PTR_ERR(phydev);
>>  				}
>>  			} else {
>>  				goto return_error;

