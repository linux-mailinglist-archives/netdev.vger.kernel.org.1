Return-Path: <netdev+bounces-34763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4417A545F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF8E1C2093C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B482AB21;
	Mon, 18 Sep 2023 20:42:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D41286B7
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE2B112
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4m-0006iv-KC; Mon, 18 Sep 2023 22:42:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4m-007Iht-7G; Mon, 18 Sep 2023 22:42:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4l-002mne-Tt; Mon, 18 Sep 2023 22:42:35 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 07/54] net: ethernet: apm: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:39 +0200
Message-Id: <20230918204227.1316886-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de>
References: <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3046; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=c+CenKq33DI+TiHFrHo/iL57XLm3lgk68xk7Dl301iw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLXsQLD7F9tlb2yzT3+hJWWLlXZzBSqZiMqeI cEft1OQHDSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi17AAKCRCPgPtYfRL+ TkKXB/oDM4dlKpSew3ITexUsNPfxIMz3pTJJ3KcHHGoS4ghkXPJI9MAbhSuu7dQ6dm7pG8+pFUB FYuec9qkS8bB6rV3WdJYqytJwMi5vCiFFIRTf+zaSgN0L42kqXRVE3CtFBXUsaFJJUdPJ7V24PY hZY69WKsYYTE68fJEVRjAAsO+aE4F/sixw7C4Dh94sUFM8qL+UDLp7o3S8uMwpXOUeCJqWq4Otj c3ugcmn+bnvoSQW/eS/IXRNjvkKwJ62UD/vsv+czIKgODavy9sNZX8RVvjfo0F+d9AnHRfvR9ML p4oVVL//ojv1SmGY607ZpxsD2pfkUZn4Ld8Gh0dmAXkQO5ik
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

Trivially convert these driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/apm/xgene-v2/main.c         | 6 ++----
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene-v2/main.c b/drivers/net/ethernet/apm/xgene-v2/main.c
index 379d19d18dbe..9e90c2381491 100644
--- a/drivers/net/ethernet/apm/xgene-v2/main.c
+++ b/drivers/net/ethernet/apm/xgene-v2/main.c
@@ -690,7 +690,7 @@ static int xge_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int xge_remove(struct platform_device *pdev)
+static void xge_remove(struct platform_device *pdev)
 {
 	struct xge_pdata *pdata;
 	struct net_device *ndev;
@@ -706,8 +706,6 @@ static int xge_remove(struct platform_device *pdev)
 	xge_mdio_remove(ndev);
 	unregister_netdev(ndev);
 	free_netdev(ndev);
-
-	return 0;
 }
 
 static void xge_shutdown(struct platform_device *pdev)
@@ -736,7 +734,7 @@ static struct platform_driver xge_driver = {
 		   .acpi_match_table = ACPI_PTR(xge_acpi_match),
 	},
 	.probe = xge_probe,
-	.remove = xge_remove,
+	.remove_new = xge_remove,
 	.shutdown = xge_shutdown,
 };
 module_platform_driver(xge_driver);
diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 4d4140b7c450..b5d9f9a55b7f 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -2127,7 +2127,7 @@ static int xgene_enet_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int xgene_enet_remove(struct platform_device *pdev)
+static void xgene_enet_remove(struct platform_device *pdev)
 {
 	struct xgene_enet_pdata *pdata;
 	struct net_device *ndev;
@@ -2149,8 +2149,6 @@ static int xgene_enet_remove(struct platform_device *pdev)
 	xgene_enet_delete_desc_rings(pdata);
 	pdata->port_ops->shutdown(pdata);
 	free_netdev(ndev);
-
-	return 0;
 }
 
 static void xgene_enet_shutdown(struct platform_device *pdev)
@@ -2174,7 +2172,7 @@ static struct platform_driver xgene_enet_driver = {
 		   .acpi_match_table = ACPI_PTR(xgene_enet_acpi_match),
 	},
 	.probe = xgene_enet_probe,
-	.remove = xgene_enet_remove,
+	.remove_new = xgene_enet_remove,
 	.shutdown = xgene_enet_shutdown,
 };
 
-- 
2.40.1


