Return-Path: <netdev+bounces-41926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D667CC3E1
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254C7B21003
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4648F42BF6;
	Tue, 17 Oct 2023 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB423CD1B
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 13:03:08 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23537B0;
	Tue, 17 Oct 2023 06:03:06 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S8vDC2n1wzvQDc;
	Tue, 17 Oct 2023 20:58:19 +0800 (CST)
Received: from [192.168.98.231] (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 21:03:02 +0800
Message-ID: <150d8d95-a6cd-dc28-618b-6cc5295b4bf9@huawei.com>
Date: Tue, 17 Oct 2023 21:03:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 5/6] net: hns3: fix wrong print link down up
From: Jijie Shao <shaojijie@huawei.com>
To: Andrew Lunn <andrew@lunn.ch>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
 <20230728075840.4022760-6-shaojijie@huawei.com>
 <7ce32389-550b-4beb-82b1-1b6183fdeabb@lunn.ch>
 <2c6514a7-db97-f345-9bc4-affd4eba2dda@huawei.com>
 <73b41fe2-12dd-4fc0-a44d-f6f94e6541fc@lunn.ch>
 <ef5489f9-43b4-ee59-699b-3f54a30c00aa@huawei.com>
 <e7219114-774f-49d0-8985-8875fd351b60@lunn.ch>
 <a21beff2-9f38-d354-6049-aed20c18c8d4@huawei.com>
In-Reply-To: <a21beff2-9f38-d354-6049-aed20c18c8d4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


on 2023/7/31 17:10, Jijie Shao wrote:
>
> on 2023/7/30 2:23, Andrew Lunn wrote:
>>>      Now i wounder if you are fixing the wrong thing. Maybe you 
>>> should be
>>>      fixing the PHY so it does not report up and then down? You say 
>>> 'very
>>>      snall intervals', which should in fact be 1 second. So is the PHY
>>>      reporting link for a number of poll intervals? 1min to 10 minutes?
>>>
>>>                Andrew
>>>
>>> Yes, according to the log records, the phy polls every second,
>>> but the link status changes take time.
>>> Generally, it takes 10 seconds for the phy to detect link down,
>>> but occasionally it takes several minutes to detect link down,
>> What PHY driver is this?
>>
>> It is not so clear what should actually happen with auto-neg turned
>> off. With it on, and the link going down, the PHY should react after
>> about 1 second. It is not supposed to react faster than that, although
>> some PHYs allow fast link down notification to be configured.
>>
>> Have you checked 802.3 to see what it says about auto-neg off and link
>> down detection?
>>
>> I personally would not suppress this behaviour in the MAC
>> driver. Otherwise you are going to have funny combinations of special
>> cases of a feature which very few people actually use, making your
>> maintenance costs higher.
>>
>>         Andrew

Hi Andrew,
We've rewritten the commit log to explain this problem,
Would you please take some time to review that?

The following is the new commit log:
This patch is to correct a wrong log info "link down/up" in hns3 driver.
When setting autoneg off without changing speed and duplex, the link
should be not changed. However in hns3 driver, it print link down/up once
incorrectly. We trace the phy machine state and find the phy change form
PHY_UP to PHY_RUNNING. No other state of PHY occurs during this process.
MDIO trace also indicate the link is on. The wrong log info and mdio
trace are showed as followed:

[  843.720783][  T367] hns3 0000:35:00.0 eth1: set link(phy): autoneg=0,
speed=10, duplex=1
[  843.736087][  T367] hns3 0000:35:00.0 eth1: link down
[  843.773506][   T17] RTL8211F Gigabit Ethernet mii-0000:35:00.0:02: PHY
state change UP -> RUNNING
[  844.674668][   T31] hns3 0000:35:00.0 eth1: link up

      kworker/1:1-32      [001] ....   841.457231: mdio_access: mii-0000:
35:00.0 read  phy:0x02 reg:0x01 val:0x79ad
      kworker/1:1-32      [001] ....   842.486496: mdio_access: mii-0000:
35:00.0 read  phy:0x02 reg:0x01 val:0x79ad
      kworker/1:1-32      [001] ....   843.520565: mdio_access: mii-0000:
35:00.0 read  phy:0x02 reg:0x01 val:0x79ad
      kworker/0:1-17      [000] ....   843.757147: mdio_access: mii-0000:
35:00.0 read  phy:0x02 reg:0x01 val:0x798d
      kworker/0:1-17      [000] ....   844.799141: mdio_access: mii-0000:
35:00.0 read  phy:0x02 reg:0x01 val:0x798d
      kworker/0:1-17      [000] ....   845.831513: mdio_access: mii-0000:
35:00.0 read  phy:0x02 reg:0x01 val:0x798d
      kworker/0:1-17      [000] ....   846.863053: mdio_access: mii-0000:
35:00.0 read  phy:0x02 reg:0x01 val:0x798d

Regards
Jijie



