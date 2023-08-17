Return-Path: <netdev+bounces-28337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465D177F15E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D9F1C212C0
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 07:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2081D51E;
	Thu, 17 Aug 2023 07:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44D0D51C
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:40:28 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B732D7C
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 00:40:27 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRGzS2Kk4zNn8j;
	Thu, 17 Aug 2023 15:36:52 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 15:40:23 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <Shyam-sundar.S-k@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <iyappan@os.amperecomputing.com>,
	<keyur@os.amperecomputing.com>, <quan@os.amperecomputing.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<yankejian@huawei.com>, <netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next 1/3] net: mdio: Fix return value check for get_phy_device()
Date: Thu, 17 Aug 2023 15:39:58 +0800
Message-ID: <20230817074000.355564-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817074000.355564-1-ruanjinjie@huawei.com>
References: <20230817074000.355564-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The get_phy_device() function returns error pointers and never
returns NULL. Update the checks accordingly.

Fixes: 43b3cf6634a4 ("drivers: net: phy: xgene: Add MDIO driver")
Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/mdio/mdio-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
index 683e8f8319ab..4e097ce2a7fd 100644
--- a/drivers/net/mdio/mdio-xgene.c
+++ b/drivers/net/mdio/mdio-xgene.c
@@ -265,7 +265,7 @@ struct phy_device *xgene_enet_phy_register(struct mii_bus *bus, int phy_addr)
 	struct phy_device *phy_dev;
 
 	phy_dev = get_phy_device(bus, phy_addr, false);
-	if (!phy_dev || IS_ERR(phy_dev))
+	if (IS_ERR(phy_dev))
 		return NULL;
 
 	if (phy_device_register(phy_dev))
-- 
2.34.1


