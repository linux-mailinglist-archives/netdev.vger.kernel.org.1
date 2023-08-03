Return-Path: <netdev+bounces-23923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D077F76E284
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4EB1C2150B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F7214271;
	Thu,  3 Aug 2023 08:08:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545F156F6
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:08:44 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889423C3B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:08:40 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qRTNu-0000XI-Ie
	for netdev@vger.kernel.org; Thu, 03 Aug 2023 10:08:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5D73220227B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:08:36 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id AF2E120223F;
	Thu,  3 Aug 2023 08:08:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7caeede9;
	Thu, 3 Aug 2023 08:08:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 7/9] can: tcan4x5x: Add error messages in probe
Date: Thu,  3 Aug 2023 10:08:28 +0200
Message-Id: <20230803080830.1386442-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803080830.1386442-1-mkl@pengutronix.de>
References: <20230803080830.1386442-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Markus Schneider-Pargmann <msp@baylibre.com>

To be able to understand issues during probe easier, add error messages
if something fails.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://lore.kernel.org/all/20230728141923.162477-7-msp@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 29 +++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 2d329b4e4f52..8a4143809d33 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -402,6 +402,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	/* Sanity check */
 	if (freq < 20000000 || freq > TCAN4X5X_EXT_CLK_DEF) {
+		dev_err(&spi->dev, "Clock frequency is out of supported range %d\n",
+			freq);
 		ret = -ERANGE;
 		goto out_m_can_class_free_dev;
 	}
@@ -420,16 +422,23 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	/* Configure the SPI bus */
 	spi->bits_per_word = 8;
 	ret = spi_setup(spi);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "SPI setup failed %pe\n", ERR_PTR(ret));
 		goto out_m_can_class_free_dev;
+	}
 
 	ret = tcan4x5x_regmap_init(priv);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "regmap init failed %pe\n", ERR_PTR(ret));
 		goto out_m_can_class_free_dev;
+	}
 
 	ret = tcan4x5x_power_enable(priv->power, 1);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "Enabling regulator failed %pe\n",
+			ERR_PTR(ret));
 		goto out_m_can_class_free_dev;
+	}
 
 	version_info = tcan4x5x_find_version(priv);
 	if (IS_ERR(version_info)) {
@@ -438,16 +447,24 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	}
 
 	ret = tcan4x5x_get_gpios(mcan_class, version_info);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "Getting gpios failed %pe\n", ERR_PTR(ret));
 		goto out_power;
+	}
 
 	ret = tcan4x5x_init(mcan_class);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "tcan initialization failed %pe\n",
+			ERR_PTR(ret));
 		goto out_power;
+	}
 
 	ret = m_can_class_register(mcan_class);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "Failed registering m_can device %pe\n",
+			ERR_PTR(ret));
 		goto out_power;
+	}
 
 	netdev_info(mcan_class->net, "TCAN4X5X successfully initialized.\n");
 	return 0;
-- 
2.40.1



