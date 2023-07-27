Return-Path: <netdev+bounces-21900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD79A7652F6
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DE91C2158D
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8BB1641A;
	Thu, 27 Jul 2023 11:56:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92650E56E
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 11:56:29 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7FA272E
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 04:56:28 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RBTjb02dQzrRh6;
	Thu, 27 Jul 2023 19:55:31 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 19:56:25 +0800
From: Chen Jiahao <chenjiahao16@huawei.com>
To: <justin.chen@broadcom.com>, <florian.fainelli@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<netdev@vger.kernel.org>
CC: <chenjiahao16@huawei.com>
Subject: [PATCH -next] net: bcmasp: Clean up redundant dev_err_probe()
Date: Thu, 27 Jul 2023 19:55:51 +0800
Message-ID: <20230727115551.2655840-1-chenjiahao16@huawei.com>
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
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Refering to platform_get_irq()'s definition, the return value has
already been checked, error message also been printed via
dev_err_probe() if ret < 0. Calling dev_err_probe() one more time
outside platform_get_irq() is obviously redundant.

Removing dev_err_probe() outside platform_get_irq() to clean up
above problem.

Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index a9984efff6d1..eb35ced1c8ba 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1232,7 +1232,7 @@ static int bcmasp_probe(struct platform_device *pdev)
 
 	priv->irq = platform_get_irq(pdev, 0);
 	if (priv->irq <= 0)
-		return dev_err_probe(dev, -EINVAL, "invalid interrupt\n");
+		return -EINVAL;
 
 	priv->clk = devm_clk_get_optional_enabled(dev, "sw_asp");
 	if (IS_ERR(priv->clk))
-- 
2.34.1


