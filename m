Return-Path: <netdev+bounces-28442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DEE77F774
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FACB1C21316
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F299314266;
	Thu, 17 Aug 2023 13:14:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E735D14265
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 13:14:21 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE65B2133
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 06:14:04 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RRQP31m6PzFqZl;
	Thu, 17 Aug 2023 21:11:03 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 21:14:01 +0800
Message-ID: <64c6610c-d027-6da9-7d56-15a9bc657995@huawei.com>
Date: Thu, 17 Aug 2023 21:14:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next v2 3/4] net: bcmgenet: Fix return value check for
 fixed_phy_register()
Content-Language: en-US
To: Heiner Kallweit <hkallweit1@gmail.com>, <rafal@milecki.pl>,
	<bcm-kernel-feedback-list@broadcom.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<opendmb@gmail.com>, <florian.fainelli@broadcom.com>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<mdf@kernel.org>, <pgynther@google.com>,
	<Pavithra.Sathyanarayanan@microchip.com>, <netdev@vger.kernel.org>
References: <20230817121631.1878897-1-ruanjinjie@huawei.com>
 <20230817121631.1878897-4-ruanjinjie@huawei.com>
 <201a9a79-9e60-5e06-1a8c-4c54a9ed4d51@gmail.com>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <201a9a79-9e60-5e06-1a8c-4c54a9ed4d51@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/17 20:36, Heiner Kallweit wrote:
> On 17.08.2023 14:16, Ruan Jinjie wrote:
>> The fixed_phy_register() function returns error pointers and never
>> returns NULL. Update the checks accordingly.
>>
>> And it also returns -EPROBE_DEFER, -EINVAL and -EBUSY, etc, in addition to
>> -ENODEV, just return -ENODEV is not sensible, use PTR_ERR to
>> fix the issue.
>>
> It's right that by returning -ENODEV detail information about the
> error cause is lost. However callers may rely on the function to
> return -ENODEV in case of an error. Did you check for this?

I have checked it again, there is no rely on the function to -ENODEV in
case of an error.

> Even if yes: This second part of the patch is an improvement,
> and therefore should be a separate patch.

Thank you! I'll split the two parts into 2 patches.

> 
>> Fixes: b0ba512e25d7 ("net: bcmgenet: enable driver to work without a device tree")
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>> ---
>> v2:
>> - Remove redundant NULL check and fix the return value.
>> - Update the commit title and message.
>> - Add the fix tag.
>> ---
>>  drivers/net/ethernet/broadcom/genet/bcmmii.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
>> index 0092e46c46f8..97ea76d443ab 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
>> @@ -617,9 +617,9 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
>>  		};
>>  
>>  		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
>> -		if (!phydev || IS_ERR(phydev)) {
>> +		if (IS_ERR(phydev)) {
>>  			dev_err(kdev, "failed to register fixed PHY device\n");
>> -			return -ENODEV;
>> +			return PTR_ERR(phydev);
>>  		}
>>  
>>  		/* Make sure we initialize MoCA PHYs with a link down */
> 

