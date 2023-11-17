Return-Path: <netdev+bounces-48576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3697EEE49
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378A61C20A72
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EF311CA3;
	Fri, 17 Nov 2023 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1BFD4E
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:17:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3uyQ-0007gT-3E; Fri, 17 Nov 2023 10:17:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3uyP-009e6D-Je; Fri, 17 Nov 2023 10:17:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3uyP-002yJf-AC; Fri, 17 Nov 2023 10:17:13 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: 
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Marek Majtyka <alardam@gmail.com>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Rob Herring <robh@kernel.org>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 3/7] net: ethernet: ti: cpsw-new: Don't error out in .remove()
Date: Fri, 17 Nov 2023 10:16:59 +0100
Message-ID: <20231117091655.872426-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de>
References: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pRqqeKcdhQwzz3WqDYFX15m8Wmx7j6+SSxzjpB2PRHA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVy+L5i60+g5zCFQoR9XpwdVxPzWS+SXuTSSRr /z0vzxzteGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVcviwAKCRCPgPtYfRL+ TupxB/44enSu4ws7zGlfVg6j+hGHF9PYcDHYkCgI3BqHLGROmcy13aQSxslOviwXJLo0y4t1b7G MlzxL95ycnY4mlQptJiZ1+ahqS1/iO4aoZw1d2OiLFly8dUWiw6FcIM435EWjKCoDjUjx5oam7e cCFty+Zc7wxIM1con2yuwanbB0+lB3GoqIF7TwUEn5k3lRxcrclmc6ECPBd5Eio4GBtW7x1w5d+ hVIs7knzwXHyRDDdD6frYUYncPr3nZSSb6p2LhNTQXQuRSmMxwbDV9scRwdsJ9GB0nfIRjc+Svb PF3kQDLWMoItthCIMaer1+UUwaZ8+V+2mNMnvIrBRZ0kusXm
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Returning early from .remove() with an error code still results in the
driver unbinding the device. So the driver core ignores the returned error
code and the resources that were not freed are never catched up. In
combination with devm this also often results in use-after-free bugs.

If runtime resume fails, it's still important to free all resources, so
don't return with an error code, but emit an error message and continue
freeing acquired stuff.

This prepares changing cpsw_remove() to return void.

Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/ti/cpsw_new.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 0e4f526b1753..a6ce409f563c 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -2042,16 +2042,24 @@ static int cpsw_remove(struct platform_device *pdev)
 	struct cpsw_common *cpsw = platform_get_drvdata(pdev);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
-		return ret;
+		/* There is no need to do something about that. The important
+		 * thing is to not exit early, but do all cleanup that doesn't
+		 * requrie register access.
+		 */
+		dev_err(&pdev->dev, "runtime resume failed (%pe)\n",
+			ERR_PTR(ret));
 
 	cpsw_unregister_notifiers(cpsw);
 	cpsw_unregister_devlink(cpsw);
 	cpsw_unregister_ports(cpsw);
 
-	cpts_release(cpsw->cpts);
-	cpdma_ctlr_destroy(cpsw->dma);
+	if (ret >= 0) {
+		cpts_release(cpsw->cpts);
+		cpdma_ctlr_destroy(cpsw->dma);
+	}
+
 	cpsw_remove_dt(cpsw);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.42.0


