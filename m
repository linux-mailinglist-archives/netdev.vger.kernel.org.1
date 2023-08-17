Return-Path: <netdev+bounces-28338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFE777F15F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EC21C212CE
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 07:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A196D2F1;
	Thu, 17 Aug 2023 07:40:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12BDDBB
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:40:39 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A32730CA
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 00:40:29 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRH203sNfzrSpG;
	Thu, 17 Aug 2023 15:39:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 15:40:26 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <Shyam-sundar.S-k@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <iyappan@os.amperecomputing.com>,
	<keyur@os.amperecomputing.com>, <quan@os.amperecomputing.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<yankejian@huawei.com>, <netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next 2/3] amd-xgbe: Return proper error code for get_phy_device()
Date: Thu, 17 Aug 2023 15:39:59 +0800
Message-ID: <20230817074000.355564-3-ruanjinjie@huawei.com>
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

get_phy_device() returns -EIO on bus access error and -ENOMEM
on kzalloc failure in addition to -ENODEV, just return -ENODEV is not
sensible, use PTR_ERR(phydev) to fix the issue.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 6a716337f48b..2f0a014ffc72 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -1090,7 +1090,7 @@ static int xgbe_phy_find_phy_device(struct xgbe_prv_data *pdata)
 				(phy_data->phydev_mode == XGBE_MDIO_MODE_CL45));
 	if (IS_ERR(phydev)) {
 		netdev_err(pdata->netdev, "get_phy_device failed\n");
-		return -ENODEV;
+		return PTR_ERR(phydev);
 	}
 	netif_dbg(pdata, drv, pdata->netdev, "external PHY id is %#010x\n",
 		  phydev->phy_id);
-- 
2.34.1


