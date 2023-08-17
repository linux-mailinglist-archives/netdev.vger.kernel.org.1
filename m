Return-Path: <netdev+bounces-28455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E283F77F7CB
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9878D281FB1
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F91B1427E;
	Thu, 17 Aug 2023 13:32:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CCD14266
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 13:32:39 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBB03590
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 06:32:11 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRQql2DJpzkWr9;
	Thu, 17 Aug 2023 21:30:43 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 21:32:04 +0800
Message-ID: <5ef6157c-ed9e-631d-33dc-2380890d12ee@huawei.com>
Date: Thu, 17 Aug 2023 21:32:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next v2 1/4] net: phy: fixed_phy: Fix return value
 check for fixed_phy_get_gpiod
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <rafal@milecki.pl>, <bcm-kernel-feedback-list@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <opendmb@gmail.com>, <florian.fainelli@broadcom.com>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<mdf@kernel.org>, <pgynther@google.com>,
	<Pavithra.Sathyanarayanan@microchip.com>, <netdev@vger.kernel.org>
References: <20230817121631.1878897-1-ruanjinjie@huawei.com>
 <20230817121631.1878897-2-ruanjinjie@huawei.com>
 <ZN4cM+EvXUtTqNwH@shell.armlinux.org.uk>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <ZN4cM+EvXUtTqNwH@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/17 21:10, Russell King (Oracle) wrote:
> On Thu, Aug 17, 2023 at 08:16:28PM +0800, Ruan Jinjie wrote:
>> Since fixed_phy_get_gpiod() return NULL instead of ERR_PTR(),
>> if it fails, the IS_ERR() can never return the error. So check NULL
>> and return ERR_PTR(-EINVAL) if fails.
> 
> No, this is totally and utterly wrong, and this patch introduces a new
> bug. The original code is _correct_.
> 
>> Fixes: 71bd106d2567 ("net: fixed-phy: Add fixed_phy_register_with_gpiod() API")
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>> ---
>>  drivers/net/phy/fixed_phy.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
>> index aef739c20ac4..4e7406455b6e 100644
>> --- a/drivers/net/phy/fixed_phy.c
>> +++ b/drivers/net/phy/fixed_phy.c
>> @@ -239,8 +239,8 @@ static struct phy_device *__fixed_phy_register(unsigned int irq,
>>  	/* Check if we have a GPIO associated with this fixed phy */
>>  	if (!gpiod) {
>>  		gpiod = fixed_phy_get_gpiod(np);
>> -		if (IS_ERR(gpiod))
>> -			return ERR_CAST(gpiod);
>> +		if (!gpiod)
>> +			return ERR_PTR(-EINVAL);
> 
> Let's look at fixed_phy_get_gpiod():
> 
>         gpiod = fwnode_gpiod_get_index(of_fwnode_handle(fixed_link_node),
>                                        "link", 0, GPIOD_IN, "mdio");
>         if (IS_ERR(gpiod) && PTR_ERR(gpiod) != -EPROBE_DEFER) {
> ...
> 		gpiod = NULL;
> 	}
> ...
> 	return gpiod;
> 
> If fwnode_gpiod_get_index() returns -EPROBE_DEFER, _then_ we return an
> error pointer. So it _does_ return an error pointer.
> 
> It also returns NULL when there is no device node passed to it, or
> if there is no fixed-link specifier, or there is some other error
> from fwnode_gpiod_get_index().
> 
> Otherwise, it returns a valid pointer to a gpio descriptor.
> 
> The gpio is optional. The device node is optional. When
> fixed_phy_get_gpiod() returns NULL, it is _not_ an error, it means
> that we don't have a GPIO. Just because something returns NULL does
> _not_ mean it's an error - please get out of that thinking, because
> if you don't your patches will introduce lots of new bugs.

Thank you, I understand what you mean, NULL is not an error here, so it
is not handled.

> 
> Only when fwnode_gpiod_get_index() wants to defer probe do we return
> an error.
> 
> So, sorry but NAK to this patch, it is incorrect.
> 

