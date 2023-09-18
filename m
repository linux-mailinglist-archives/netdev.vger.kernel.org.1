Return-Path: <netdev+bounces-34748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 518337A5445
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1FC2816B0
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDEB450E9;
	Mon, 18 Sep 2023 20:42:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33985450D6
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106D810D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4o-0006nb-Jb; Mon, 18 Sep 2023 22:42:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4o-007IiN-3U; Mon, 18 Sep 2023 22:42:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4n-002mo7-OH; Mon, 18 Sep 2023 22:42:37 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 14/54] net: ethernet: cavium: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:46 +0200
Message-Id: <20230918204227.1316886-15-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=H8wm3+1bM870xkjbSzba5N8n2u8MnrP7uTtNDVTS4SE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLX03ttt5sr02acSIF6XwD4/iBoSGSi+S+JU3 IjelQYAUBuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi19AAKCRCPgPtYfRL+ TlfPCACvMexESsLJJ/J+yOFJQ+GjBqEeTL2SYX5McK5N8KVB8dy76T21hz438DwX6LML1Ke82qt ZBqvoBaAjZJ4zei5Q7gdEzfHkgij03fST0J0IcZBcnZgAoVkjlEdO6irPd3ISR/aQO3vHS8qO/z Ufrm9kIN47NT9TQhyG1W2OPJWF/cOkIFjwu67dw+TK+Ty6LtCHkqqEEvbB9Cs9o9JZpiSYS8uOe VhsmT8aTrPDwokohJZipMlsCePktUg1VwTcs/FgRlT+mCHGqMRvBIIJ1EXFqmpx/8nC5VlZNVAT 0XSKLL8qe/iKfa+2aJBw5Y3XrVdEoSuIX6LzLlAZj9EkK4Ci
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

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
index edde0b8fa49c..007d4b06819e 100644
--- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
@@ -1521,7 +1521,7 @@ static int octeon_mgmt_probe(struct platform_device *pdev)
 	return result;
 }
 
-static int octeon_mgmt_remove(struct platform_device *pdev)
+static void octeon_mgmt_remove(struct platform_device *pdev)
 {
 	struct net_device *netdev = platform_get_drvdata(pdev);
 	struct octeon_mgmt *p = netdev_priv(netdev);
@@ -1529,7 +1529,6 @@ static int octeon_mgmt_remove(struct platform_device *pdev)
 	unregister_netdev(netdev);
 	of_node_put(p->phy_np);
 	free_netdev(netdev);
-	return 0;
 }
 
 static const struct of_device_id octeon_mgmt_match[] = {
@@ -1546,7 +1545,7 @@ static struct platform_driver octeon_mgmt_driver = {
 		.of_match_table = octeon_mgmt_match,
 	},
 	.probe		= octeon_mgmt_probe,
-	.remove		= octeon_mgmt_remove,
+	.remove_new	= octeon_mgmt_remove,
 };
 
 module_platform_driver(octeon_mgmt_driver);
-- 
2.40.1


