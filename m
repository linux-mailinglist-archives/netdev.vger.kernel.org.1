Return-Path: <netdev+bounces-23578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9548076C8F8
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 11:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5714B1C21202
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224795684;
	Wed,  2 Aug 2023 09:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D405683
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 09:07:43 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08F02721
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 02:07:41 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RG5f00nmrzLp1g;
	Wed,  2 Aug 2023 17:04:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 17:07:38 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <iyappan@os.amperecomputing.com>, <keyur@os.amperecomputing.com>,
	<quan@os.amperecomputing.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next] drivers: net: xgene: Do not check for 0 return after calling platform_get_irq()
Date: Wed, 2 Aug 2023 17:06:57 +0800
Message-ID: <20230802090657.969923-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It is not possible for platform_get_irq() to return 0. Use the
return value from platform_get_irq().

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 390671640388..41d96f4b23d8 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -1632,7 +1632,7 @@ static int xgene_enet_get_irqs(struct xgene_enet_pdata *pdata)
 
 	for (i = 0; i < max_irqs; i++) {
 		ret = platform_get_irq(pdev, i);
-		if (ret <= 0) {
+		if (ret < 0) {
 			if (pdata->phy_mode == PHY_INTERFACE_MODE_XGMII) {
 				max_irqs = i;
 				pdata->rxq_cnt = max_irqs / 2;
@@ -1640,7 +1640,7 @@ static int xgene_enet_get_irqs(struct xgene_enet_pdata *pdata)
 				pdata->cq_cnt = max_irqs / 2;
 				break;
 			}
-			return ret ? : -ENXIO;
+			return ret;
 		}
 		pdata->irqs[i] = ret;
 	}
-- 
2.34.1


