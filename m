Return-Path: <netdev+bounces-28418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5EB77F634
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231191C21336
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9B013AFC;
	Thu, 17 Aug 2023 12:17:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E0E55B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 12:17:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB112213F
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 05:17:05 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRP6g0SbmzNmjX;
	Thu, 17 Aug 2023 20:13:31 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 20:17:02 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <rafal@milecki.pl>, <bcm-kernel-feedback-list@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <opendmb@gmail.com>, <florian.fainelli@broadcom.com>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <mdf@kernel.org>, <pgynther@google.com>,
	<Pavithra.Sathyanarayanan@microchip.com>, <netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v2 0/4] net: Fix return value check for fixed_phy_register()
Date: Thu, 17 Aug 2023 20:16:27 +0800
Message-ID: <20230817121631.1878897-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since fixed_phy_get_gpiod() return NULL instead of
ERR_PTR(), the IS_ERR() check is not correct to return the err.

The fixed_phy_register() function returns error pointers and never
returns NULL.

And fixed_phy_register() function also returns -EPROBE_DEFER, -EINVAL and
-EBUSY, etc, in addition to -ENODEV or -EIO, Use PTR_ERR instead.

Changes in v2:
- Remove redundant NULL check.
- Fix the return value for fixed_phy_register().
- Fix the return value check for fixed_phy_get_gpiod().
- Fix the return value also for lan743x.

Ruan Jinjie (4):
  net: phy: fixed_phy: Fix return value check for fixed_phy_get_gpiod
  net: bgmac: Fix return value check for fixed_phy_register()
  net: bcmgenet: Fix return value check for fixed_phy_register()
  net: lan743x: Fix return value check for fixed_phy_register()

 drivers/net/ethernet/broadcom/bgmac.c         | 4 ++--
 drivers/net/ethernet/broadcom/genet/bcmmii.c  | 4 ++--
 drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
 drivers/net/phy/fixed_phy.c                   | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.34.1


