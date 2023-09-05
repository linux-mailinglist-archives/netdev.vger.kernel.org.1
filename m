Return-Path: <netdev+bounces-32017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF71792126
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 10:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FC41C2030B
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 08:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE99566D;
	Tue,  5 Sep 2023 08:49:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D79028F8
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 08:49:36 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78659AA
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 01:49:35 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RfzcJ50w7zGprd;
	Tue,  5 Sep 2023 16:45:52 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 16:49:31 +0800
Message-ID: <29917acb-bd80-10e5-b1ae-c844ea0e9cbb@huawei.com>
Date: Tue, 5 Sep 2023 16:49:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <f.fainelli@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <hkallweit1@gmail.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <rmk+kernel@armlinux.org.uk>,
	"shenjian15@huawei.com" <shenjian15@huawei.com>, "liuyonglong@huawei.com"
	<liuyonglong@huawei.com>, <wangjie125@huawei.com>, <chenhao418@huawei.com>,
	Hao Lan <lanhao@huawei.com>, "wangpeiyang1@huawei.com"
	<wangpeiyang1@huawei.com>
Subject: Re: [PATCH net-next] net: phy: avoid kernel warning dump when
 stopping an errored PHY
To: Andrew Lunn <andrew@lunn.ch>
References: <aed0bc3b-2d48-2fd9-9587-5910ad68c180@gmail.com>
 <8e7e02d8-2b2a-8619-e607-fbac50706252@huawei.com>
 <fd08a80d-c70b-4943-8cca-b038f54f8eaa@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <fd08a80d-c70b-4943-8cca-b038f54f8eaa@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


on 2023/9/4 21:43, Andrew Lunn wrote:
> On Mon, Sep 04, 2023 at 05:50:32PM +0800, Jijie Shao wrote:
>> Hi all,
>> We encountered an issue when resetting our netdevice recently, it seems
>> related to this patch.
>>
>> During our process, we stop phy first and call phy_start() later.
>> phy_check_link_status returns error because it read mdio failed. The
>> reason why it happened is that the cmdq is unusable when we reset and we
>> can't access to mdio.
> At what point in the flow below do you apply the reset which stops
> access to the MDIO bus? Ideally you want to do phy_stop(), then apply
> the reset, get the hardware working again, and then do a phy_start().
>

When we do a phy_stop(), hardware might be error and we can't access to
mdio.And our process is read/write mdio failed first, then do phy_stop(),
reset hardware and call phy_start() finally.

We note there are several times lock during phy_state_machine(). The first
is to handle phydev state. It's noting that a competition of phydev lock
happend again if phy_check_link_status() returns an error. Why we don't
held lock until changing state to PHY_ERROR if phy_check_link_status()
returns an error?

Jijie Shao


