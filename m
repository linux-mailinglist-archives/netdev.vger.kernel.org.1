Return-Path: <netdev+bounces-29215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C41167821AD
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 04:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F64D280E4F
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 02:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B21EA1;
	Mon, 21 Aug 2023 02:50:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A41389
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 02:50:58 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7DE9D
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 19:50:57 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RTcMY722VzNmxF;
	Mon, 21 Aug 2023 10:47:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 10:50:54 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <rafal@milecki.pl>, <bcm-kernel-feedback-list@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <opendmb@gmail.com>, <florian.fainelli@broadcom.com>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <andrew@lunn.ch>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v4 1/3] net: bgmac: Return PTR_ERR() for fixed_phy_register()
Date: Mon, 21 Aug 2023 10:50:18 +0800
Message-ID: <20230821025020.1971520-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821025020.1971520-1-ruanjinjie@huawei.com>
References: <20230821025020.1971520-1-ruanjinjie@huawei.com>
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
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

fixed_phy_register() returns -EPROBE_DEFER, -EINVAL and -EBUSY,
etc, in addition to -ENODEV. The best practice is to return
these error codes with PTR_ERR().

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v4:
- Keep the code context consistent with another patch set.
- Update to bring the author's name before.
v3:
- Split the return value check into another patch set.
- Update the commit title and message.
---
 drivers/net/ethernet/broadcom/bgmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 52ee3751187a..448a1b90de5e 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1450,7 +1450,7 @@ int bgmac_phy_connect_direct(struct bgmac *bgmac)
 	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
 	if (IS_ERR(phy_dev)) {
 		dev_err(bgmac->dev, "Failed to register fixed PHY device\n");
-		return -ENODEV;
+		return PTR_ERR(phy_dev);
 	}
 
 	err = phy_connect_direct(bgmac->net_dev, phy_dev, bgmac_adjust_link,
-- 
2.34.1


