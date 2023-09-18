Return-Path: <netdev+bounces-34728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994C67A536E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BFA1C209B2
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC1F28E23;
	Mon, 18 Sep 2023 19:51:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F129327ECE
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:51:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F41116
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:51:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKHA-0003kM-8w; Mon, 18 Sep 2023 21:51:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH7-007I8Q-Ei; Mon, 18 Sep 2023 21:51:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH7-002mC2-4v; Mon, 18 Sep 2023 21:51:17 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/19] net: mdio: aspeed: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 21:50:44 +0200
Message-Id: <20230918195102.1302746-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
References: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+rLYLOsUpr8kyy+QFlBR3XWIcdLjwnZ/LnhP5xUSMTQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKoAeA+IS0yQi6cSoY2pH7ok+WjtIDnAYn1k9 fgK9LXFin6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiqAAAKCRCPgPtYfRL+ Tg6MB/9RzPdhExQILy67IDnTq81/pUsM2T6QgTRxzoOE6vIqMyoKjvG5Ep1oj4jtvqjXcSom28W La0nOZIorIudcmyTU81CVvJt/2uzvLIUbY2DySyTfpVCg6VXUrrvFme+raLXLLm7UVlwBfgwYhr IYhRPmDLyIyamGf02ZQ6D+GvY5cgIj308E4nC7TZpGebXQugLlQAcATzjBG52rnt4kJs+xiOYVy M5KKEELd2Fr1PUJeE2xWJl721EU7OOE8jcR/fp/Mds9v0KaY9X8+qJExQvhwPr8+shvEjYxvP84 adrN5A/M+Bg7wuoCPU36gwxA5XHm8oC8d6QlBrm8aMil5+QA
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
 drivers/net/mdio/mdio-aspeed.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index c727103c8b05..70edeeb7771e 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -177,15 +177,13 @@ static int aspeed_mdio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int aspeed_mdio_remove(struct platform_device *pdev)
+static void aspeed_mdio_remove(struct platform_device *pdev)
 {
 	struct mii_bus *bus = (struct mii_bus *)platform_get_drvdata(pdev);
 	struct aspeed_mdio *ctx = bus->priv;
 
 	reset_control_assert(ctx->reset);
 	mdiobus_unregister(bus);
-
-	return 0;
 }
 
 static const struct of_device_id aspeed_mdio_of_match[] = {
@@ -200,7 +198,7 @@ static struct platform_driver aspeed_mdio_driver = {
 		.of_match_table = aspeed_mdio_of_match,
 	},
 	.probe = aspeed_mdio_probe,
-	.remove = aspeed_mdio_remove,
+	.remove_new = aspeed_mdio_remove,
 };
 
 module_platform_driver(aspeed_mdio_driver);
-- 
2.40.1


