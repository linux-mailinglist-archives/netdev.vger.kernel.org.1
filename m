Return-Path: <netdev+bounces-29216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FBB7821AE
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 04:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B9A1C20850
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 02:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87486137B;
	Mon, 21 Aug 2023 02:51:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72F15C0
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 02:51:00 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749D99C
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 19:50:59 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RTcP85JtwzVkKK;
	Mon, 21 Aug 2023 10:48:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 10:50:56 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <rafal@milecki.pl>, <bcm-kernel-feedback-list@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <opendmb@gmail.com>, <florian.fainelli@broadcom.com>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <andrew@lunn.ch>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v4 2/3] net: bcmgenet: Return PTR_ERR() for fixed_phy_register()
Date: Mon, 21 Aug 2023 10:50:19 +0800
Message-ID: <20230821025020.1971520-3-ruanjinjie@huawei.com>
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
etc, in addition to -ENODEV. The Best practice is to return these
error codes with PTR_ERR().

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Acked-by: Doug Berger <opendmb@gmail.com>
---
v4:
- Keep the code context consistent with another patch set.
- Update to bring the author's name before.
---
v3:
- Split the return value check into another patch set.
- Update the commit title and message.
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index cc3afb605b1e..97ea76d443ab 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -619,7 +619,7 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
 		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
 		if (IS_ERR(phydev)) {
 			dev_err(kdev, "failed to register fixed PHY device\n");
-			return -ENODEV;
+			return PTR_ERR(phydev);
 		}
 
 		/* Make sure we initialize MoCA PHYs with a link down */
-- 
2.34.1


