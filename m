Return-Path: <netdev+bounces-23935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5393176E31E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C602812FE
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285F015482;
	Thu,  3 Aug 2023 08:29:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDAC14AB6
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:29:56 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1313061A8
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:29:33 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RGhnR2QVRz1GDTL;
	Thu,  3 Aug 2023 16:28:27 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 16:29:30 +0800
From: Zhu Wang <wangzhu9@huawei.com>
To: <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <wangzhu9@huawei.com>
Subject: [PATCH -next] net: lan966x: Do not check 0 for platform_get_irq_byname()
Date: Thu, 3 Aug 2023 16:29:00 +0800
Message-ID: <20230803082900.14921-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since platform_get_irq_byname() never returned zero, so it need not to
check whether it returned zero, it returned -EINVAL or -ENXIO when
failed, so we replace the return error code with the result it returned.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index fbb0bb4594cd..824961ec1370 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1108,8 +1108,8 @@ static int lan966x_probe(struct platform_device *pdev)
 
 	/* set irq */
 	lan966x->xtr_irq = platform_get_irq_byname(pdev, "xtr");
-	if (lan966x->xtr_irq <= 0)
-		return -EINVAL;
+	if (lan966x->xtr_irq < 0)
+		return lan966x->xtr_irq;
 
 	err = devm_request_threaded_irq(&pdev->dev, lan966x->xtr_irq, NULL,
 					lan966x_xtr_irq_handler, IRQF_ONESHOT,
-- 
2.17.1


