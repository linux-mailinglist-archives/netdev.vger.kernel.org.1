Return-Path: <netdev+bounces-31904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DB07914FF
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 11:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5FB1C20749
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 09:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1894117E3;
	Mon,  4 Sep 2023 09:50:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F164B7E
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 09:50:38 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801451A5
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 02:50:36 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RfP1c1LjKz1DDZJ;
	Mon,  4 Sep 2023 17:47:16 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 17:50:33 +0800
Message-ID: <8e7e02d8-2b2a-8619-e607-fbac50706252@huawei.com>
Date: Mon, 4 Sep 2023 17:50:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <hkallweit1@gmail.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<rmk+kernel@armlinux.org.uk>, "shenjian15@huawei.com"
	<shenjian15@huawei.com>, "liuyonglong@huawei.com" <liuyonglong@huawei.com>,
	<wangjie125@huawei.com>, <chenhao418@huawei.com>, Hao Lan
	<lanhao@huawei.com>, <shaojijie@huawei.com>, "wangpeiyang1@huawei.com"
	<wangpeiyang1@huawei.com>
References: <aed0bc3b-2d48-2fd9-9587-5910ad68c180@gmail.com>
Subject: Re: [PATCH net-next] net: phy: avoid kernel warning dump when
 stopping an errored PHY
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <aed0bc3b-2d48-2fd9-9587-5910ad68c180@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,
We encountered an issue when resetting our netdevice recently, it seems
related to this patch.

During our process, we stop phy first and call phy_start() later.
phy_check_link_status returns error because it read mdio failed. The
reason why it happened is that the cmdq is unusable when we reset and we
can't access to mdio.

The process and logs are showed as followed:
Process:
reset process       |    phy_state_machine           |  phy_state
==========================================================================
                     | mutex_lock(&phydev->lock);     | PHY_RUNNING
                     | ...                            |
                     | case PHY_RUNNING:              |
                     | err = phy_check_link_status()  | PHY_RUNNING
                     | ...                            |
                     | mutex_unlock(&phydev->lock)    | PHY_RUNNING
  phy_stop()         |                                |
    ...              |                                |
    mutex_lock()     |                                | PHY_RUNNING
    ...              |                                |
    phydev->state =  |                                |
      PHY_HALTED;    |                                |  PHY_HALTED
    ...              |                                |
    mutex_unlock()   |                                |  PHY_HALTED
                     | phy_error_precise():           |
                     |   mutex_lock(&phydev->lock);   | PHY_HALTED
                     |   phydev->state = PHY_ERROR;   | PHY_ERROR
                     |   mutex_unlock(&phydev->lock); | PHY_ERROR
                     |                                |
phy_start()         |                                |  PHY_ERROR
   ...               |                                |
Logs:
[ 2622.146721] hns3 0000:35:00.0 eth1: Setting reset type 6
[ 2622.155182] hns3 0000:35:00.0: received reset event, reset type is 6
[ 2622.171641] hns3 0000:35:00.0: global reset requested
[ 2622.181867] hns3 0000:35:00.0: global reset interrupt
[ 2623.351382] ------------[ cut here ]------------
[ 2623.358012] phy_check_link_status+0x0/0xe0: returned: -16
[ 2623.370106] hns3 0000:35:00.0 eth1: net stop
[ 2623.377599] WARNING: CPU: 0 PID: 10 at drivers/net/phy/phy.c:1211
phy_state_machine+0xac/0x2b8
[ 2623.386026] RTL8211F Gigabit Ethernet mii-0000:35:00.0:02: PHY state
change RUNNING -> HALTED
                 ...
[ 2623.540165] Call trace:
[ 2623.543034]  phy_state_machine+0xac/0x2b8
[ 2623.548028]  process_one_work+0x1ec/0x478
[ 2623.552732]  worker_thread+0x74/0x448
[ 2623.556855]  kthread+0x120/0x130
[ 2623.560920]  ret_from_fork+0x10/0x20
[ 2623.565355] ---[ end trace 0000000000000000 ]---
[ 2623.577722] RTL8211F Gigabit Ethernet mii-0000:35:00.0:02: PHY state
change RUNNING -> ERROR
[ 2623.590490] hns3 0000:35:00.0 eth1: link down
[ 2623.707230] hns3 0000:35:00.0: prepare wait ok
[ 2624.169139] hns3 0000:35:00.0: The firmware version is 3.10.11.25
[ 2624.501223] hns3 0000:35:00.0: phc initializes ok!
[ 2624.553486] hns3 0000:35:00.0: Reset done, hclge driver initialization
finished.
[ 2625.586470] ------------[ cut here ]------------
[ 2625.593882] called from state ERROR
[ 2625.600677] WARNING: CPU: 1 PID: 352 at drivers/net/phy/phy.c:1392
phy_start+0x50/0xc8
                 ...
[ 2625.750077] Call trace:
[ 2625.752799]  phy_start+0x50/0xc8
[ 2625.756974]  hclge_mac_start_phy+0x34/0x50 [hclge]
                 ...
[ 2625.831224] ---[ end trace 0000000000000000 ]---
[ 2625.843790] hns3 0000:35:00.0 eth1: net open

We supposed to start phy successfully after calling phy_stop. However, the
phy state is PHY_ERROR. As aboved process, we can find
phy_check_link_status is called before phy_stop, but the final phy state
is set due to an error from phy_check_link_status. Becuase we reset our
netdevice successfully, the phy should not be PHY_ERROR when we call
phy_start. So, we supposed it might be a bug.

Additionally, what can we do if the phy is in PHY_ERROR?

Thanks!
Jijie Shao

