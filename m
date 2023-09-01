Return-Path: <netdev+bounces-31687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA49878F8E3
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 09:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170391C20B84
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 07:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DAA749C;
	Fri,  1 Sep 2023 07:04:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A176EBE
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 07:04:53 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C555EC5
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 00:04:51 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RcTT23SSGzhZHc;
	Fri,  1 Sep 2023 15:00:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 1 Sep
 2023 15:04:47 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bcm-kernel-feedback-list@broadcom.com>, <netdev@vger.kernel.org>, Justin
 Chen <justin.chen@broadcom.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next] net: bcmasp: Do not check for 0 return after calling platform_get_irq()
Date: Fri, 1 Sep 2023 15:04:43 +0800
Message-ID: <20230901070443.1308314-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It is not possible for platform_get_irq() to return 0. And it return
-EINVAL when the irq = 0 and -ENXIO when the irq can not be found. The
best practice is to return the err code from platform_get_irq().

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index d63d321f3e7b..05b07da03398 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1231,8 +1231,8 @@ static int bcmasp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq <= 0)
-		return -EINVAL;
+	if (priv->irq < 0)
+		return priv->irq;
 
 	priv->clk = devm_clk_get_optional_enabled(dev, "sw_asp");
 	if (IS_ERR(priv->clk))
-- 
2.34.1


