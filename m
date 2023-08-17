Return-Path: <netdev+bounces-28419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835CD77F635
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A241C213AB
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C2C13FEF;
	Thu, 17 Aug 2023 12:17:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAA813FEE
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 12:17:08 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470CB271B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 05:17:07 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRP8K5z0BzVk0R;
	Thu, 17 Aug 2023 20:14:57 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 20:17:04 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <rafal@milecki.pl>, <bcm-kernel-feedback-list@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <opendmb@gmail.com>, <florian.fainelli@broadcom.com>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <mdf@kernel.org>, <pgynther@google.com>,
	<Pavithra.Sathyanarayanan@microchip.com>, <netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v2 1/4] net: phy: fixed_phy: Fix return value check for fixed_phy_get_gpiod
Date: Thu, 17 Aug 2023 20:16:28 +0800
Message-ID: <20230817121631.1878897-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817121631.1878897-1-ruanjinjie@huawei.com>
References: <20230817121631.1878897-1-ruanjinjie@huawei.com>
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

Since fixed_phy_get_gpiod() return NULL instead of ERR_PTR(),
if it fails, the IS_ERR() can never return the error. So check NULL
and return ERR_PTR(-EINVAL) if fails.

Fixes: 71bd106d2567 ("net: fixed-phy: Add fixed_phy_register_with_gpiod() API")
Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/phy/fixed_phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index aef739c20ac4..4e7406455b6e 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -239,8 +239,8 @@ static struct phy_device *__fixed_phy_register(unsigned int irq,
 	/* Check if we have a GPIO associated with this fixed phy */
 	if (!gpiod) {
 		gpiod = fixed_phy_get_gpiod(np);
-		if (IS_ERR(gpiod))
-			return ERR_CAST(gpiod);
+		if (!gpiod)
+			return ERR_PTR(-EINVAL);
 	}
 
 	/* Get the next available PHY address, up to PHY_MAX_ADDR */
-- 
2.34.1


