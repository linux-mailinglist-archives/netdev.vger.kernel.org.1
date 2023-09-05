Return-Path: <netdev+bounces-32019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FD279213C
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 10:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7E81C208CE
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 08:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437EB6138;
	Tue,  5 Sep 2023 08:59:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DBD28F8
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 08:59:46 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F19F184
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 01:59:45 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RfztD4f4yz1M96P;
	Tue,  5 Sep 2023 16:57:56 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 16:59:42 +0800
Message-ID: <6c6c4c9d-fca9-2a52-18d1-29b450749d15@huawei.com>
Date: Tue, 5 Sep 2023 16:59:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <f.fainelli@gmail.com>, Andrew Lunn
	<andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<hkallweit1@gmail.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, "shenjian15@huawei.com" <shenjian15@huawei.com>,
	"liuyonglong@huawei.com" <liuyonglong@huawei.com>, <wangjie125@huawei.com>,
	<chenhao418@huawei.com>, Hao Lan <lanhao@huawei.com>,
	"wangpeiyang1@huawei.com" <wangpeiyang1@huawei.com>
Subject: Re: [PATCH net-next] net: phy: avoid kernel warning dump when
 stopping an errored PHY
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <aed0bc3b-2d48-2fd9-9587-5910ad68c180@gmail.com>
 <8e7e02d8-2b2a-8619-e607-fbac50706252@huawei.com>
 <ZPXs6i2S8GSCpVOV@shell.armlinux.org.uk>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <ZPXs6i2S8GSCpVOV@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


on 2023/9/4 22:42, Russell King (Oracle) wrote:
> Are you suggesting that the sequence is:
>
> phy_stop();
> reset netdev
> phy_start();
>
> ?
>
> Is the reason for doing this because you've already detected an issue
> with the hardware, and you're trying to recover it - and before you've
> called phy_stop() the hardware is already dead?

In our case, hardware is already dead before we called phy_stop().

>
> If that is the case, I'm not really sure what you expect to happen
> here. You've identified a race where the state machine is running in

What we expect is that the phy state is PHY_HALTED after we called
phy_stop(). So that we can do a phy_start() successully after resetting
our netdev.

> unison with phy_stop(), but in this circumstance it is also possible
> that the state machine could complete executing and have called
> phy_error_precise() before phy_stop() has even been called. In that
> case, you'll still get a warning-splat on the console from
> phy_error_precise().
>
> The only difference is that phy_stop() won't warn.
>
> That all said, this is obviously buggy, because phy_stop() has set
> the phydev state to PHY_HALTED and the state machine has unexpectedly
> changed its state.
>
> I wonder whether we should be tracking the phy_start/stop state
> separately, since we've had issues with phy_stop() warning when an
> error has occurred (see commit 59088b5a946e).
>
> Maybe something like this (untested)?

Thanks for your patch and it works in our case. By the way, when would you
push this patch?


Jijie Shao


