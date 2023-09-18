Return-Path: <netdev+bounces-34798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DCB7A54BB
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C857282115
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37707358BD;
	Mon, 18 Sep 2023 20:43:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D816358A9
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:10 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7365B6
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:43:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4s-0007Ad-6z; Mon, 18 Sep 2023 22:42:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4q-007Ij0-Iv; Mon, 18 Sep 2023 22:42:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4q-002mol-9P; Mon, 18 Sep 2023 22:42:40 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Douglas Miller <dougmill@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Wei Fang <wei.fang@nxp.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alex Elder <elder@linaro.org>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 24/54] net: ethernet: ibm: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:56 +0200
Message-Id: <20230918204227.1316886-25-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7114; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=fl8Ou9wZj9Uje7eGBIKPKik1eHQdIJ7War0A2L99sLk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLX/botC31Sb4bGUxq3k3R8J80UdkUrR87BEe NUyth8DRdGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi1/wAKCRCPgPtYfRL+ Tul7CACMphZJOrDGGIzsELYYDzEu+ydK4O69cvA3lg+wO5Q8E6yQCg/mG3ZBsb6uttfA1ccaWtc SuKNYXUUHWTj9dpRaIm+5eXPkaVrWo1B204egYrui4EMZ8St8NDGZ//49WX2+3B3z/BZZMYDufp AZD+9nUvbwe8a9jC/O+dWBb0cjIrYI8FR2IANwc5sig2lS9caSd9zbt6YXej4gYFvLTwiAREaWm iC3PoCkyXPqj4YjXV4s2KeuGoZ7yJsDZsg1k6IKH2YBpIFux/IiIbLcMCvQ7HRRwT2qUweur1YK iETsVay2kzGJsG7Q1fO7oVvN5XiRtnPArOdouXoPOwPu1DCN
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

Trivially convert these drivers from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/ibm/ehea/ehea_main.c | 8 +++-----
 drivers/net/ethernet/ibm/emac/core.c      | 6 ++----
 drivers/net/ethernet/ibm/emac/mal.c       | 6 ++----
 drivers/net/ethernet/ibm/emac/rgmii.c     | 6 ++----
 drivers/net/ethernet/ibm/emac/tah.c       | 6 ++----
 drivers/net/ethernet/ibm/emac/zmii.c      | 6 ++----
 6 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index 0a56e9752464..251dedd55cfb 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -90,7 +90,7 @@ static struct ehea_bcmc_reg_array ehea_bcmc_regs;
 
 static int ehea_probe_adapter(struct platform_device *dev);
 
-static int ehea_remove(struct platform_device *dev);
+static void ehea_remove(struct platform_device *dev);
 
 static const struct of_device_id ehea_module_device_table[] = {
 	{
@@ -121,7 +121,7 @@ static struct platform_driver ehea_driver = {
 		.of_match_table = ehea_device_table,
 	},
 	.probe = ehea_probe_adapter,
-	.remove = ehea_remove,
+	.remove_new = ehea_remove,
 };
 
 void ehea_dump(void *adr, int len, char *msg)
@@ -3471,7 +3471,7 @@ static int ehea_probe_adapter(struct platform_device *dev)
 	return ret;
 }
 
-static int ehea_remove(struct platform_device *dev)
+static void ehea_remove(struct platform_device *dev)
 {
 	struct ehea_adapter *adapter = platform_get_drvdata(dev);
 	int i;
@@ -3492,8 +3492,6 @@ static int ehea_remove(struct platform_device *dev)
 	list_del(&adapter->list);
 
 	ehea_update_firmware_handles();
-
-	return 0;
 }
 
 static int check_module_parm(void)
diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 0c314bf97480..e6e47b1842ea 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3253,7 +3253,7 @@ static int emac_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static int emac_remove(struct platform_device *ofdev)
+static void emac_remove(struct platform_device *ofdev)
 {
 	struct emac_instance *dev = platform_get_drvdata(ofdev);
 
@@ -3290,8 +3290,6 @@ static int emac_remove(struct platform_device *ofdev)
 		irq_dispose_mapping(dev->emac_irq);
 
 	free_netdev(dev->ndev);
-
-	return 0;
 }
 
 /* XXX Features in here should be replaced by properties... */
@@ -3319,7 +3317,7 @@ static struct platform_driver emac_driver = {
 		.of_match_table = emac_match,
 	},
 	.probe = emac_probe,
-	.remove = emac_remove,
+	.remove_new = emac_remove,
 };
 
 static void __init emac_make_bootlist(void)
diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index c3236b59e7e9..462646d1b817 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -711,7 +711,7 @@ static int mal_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static int mal_remove(struct platform_device *ofdev)
+static void mal_remove(struct platform_device *ofdev)
 {
 	struct mal_instance *mal = platform_get_drvdata(ofdev);
 
@@ -740,8 +740,6 @@ static int mal_remove(struct platform_device *ofdev)
 			   NUM_RX_BUFF * mal->num_rx_chans), mal->bd_virt,
 			  mal->bd_dma);
 	kfree(mal);
-
-	return 0;
 }
 
 static const struct of_device_id mal_platform_match[] =
@@ -770,7 +768,7 @@ static struct platform_driver mal_of_driver = {
 		.of_match_table = mal_platform_match,
 	},
 	.probe = mal_probe,
-	.remove = mal_remove,
+	.remove_new = mal_remove,
 };
 
 int __init mal_init(void)
diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index fd437f986edf..e1712fdc3c31 100644
--- a/drivers/net/ethernet/ibm/emac/rgmii.c
+++ b/drivers/net/ethernet/ibm/emac/rgmii.c
@@ -273,7 +273,7 @@ static int rgmii_probe(struct platform_device *ofdev)
 	return rc;
 }
 
-static int rgmii_remove(struct platform_device *ofdev)
+static void rgmii_remove(struct platform_device *ofdev)
 {
 	struct rgmii_instance *dev = platform_get_drvdata(ofdev);
 
@@ -281,8 +281,6 @@ static int rgmii_remove(struct platform_device *ofdev)
 
 	iounmap(dev->base);
 	kfree(dev);
-
-	return 0;
 }
 
 static const struct of_device_id rgmii_match[] =
@@ -302,7 +300,7 @@ static struct platform_driver rgmii_driver = {
 		.of_match_table = rgmii_match,
 	},
 	.probe = rgmii_probe,
-	.remove = rgmii_remove,
+	.remove_new = rgmii_remove,
 };
 
 int __init rgmii_init(void)
diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index aae9a88d95d7..fa3488258ca2 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -130,7 +130,7 @@ static int tah_probe(struct platform_device *ofdev)
 	return rc;
 }
 
-static int tah_remove(struct platform_device *ofdev)
+static void tah_remove(struct platform_device *ofdev)
 {
 	struct tah_instance *dev = platform_get_drvdata(ofdev);
 
@@ -138,8 +138,6 @@ static int tah_remove(struct platform_device *ofdev)
 
 	iounmap(dev->base);
 	kfree(dev);
-
-	return 0;
 }
 
 static const struct of_device_id tah_match[] =
@@ -160,7 +158,7 @@ static struct platform_driver tah_driver = {
 		.of_match_table = tah_match,
 	},
 	.probe = tah_probe,
-	.remove = tah_remove,
+	.remove_new = tah_remove,
 };
 
 int __init tah_init(void)
diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
index 6337388ee5f4..26e86cdee2f6 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -278,7 +278,7 @@ static int zmii_probe(struct platform_device *ofdev)
 	return rc;
 }
 
-static int zmii_remove(struct platform_device *ofdev)
+static void zmii_remove(struct platform_device *ofdev)
 {
 	struct zmii_instance *dev = platform_get_drvdata(ofdev);
 
@@ -286,8 +286,6 @@ static int zmii_remove(struct platform_device *ofdev)
 
 	iounmap(dev->base);
 	kfree(dev);
-
-	return 0;
 }
 
 static const struct of_device_id zmii_match[] =
@@ -308,7 +306,7 @@ static struct platform_driver zmii_driver = {
 		.of_match_table = zmii_match,
 	},
 	.probe = zmii_probe,
-	.remove = zmii_remove,
+	.remove_new = zmii_remove,
 };
 
 int __init zmii_init(void)
-- 
2.40.1


