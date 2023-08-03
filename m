Return-Path: <netdev+bounces-23924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7245176E285
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267F128146F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA20715AC6;
	Thu,  3 Aug 2023 08:08:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71DF156F7
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:08:44 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B6F3C14
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:08:39 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qRTNu-0000VP-4k
	for netdev@vger.kernel.org; Thu, 03 Aug 2023 10:08:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D58B4202274
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:08:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 91BB320223B;
	Thu,  3 Aug 2023 08:08:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 927b9bac;
	Thu, 3 Aug 2023 08:08:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 6/9] can: tcan4x5x: Add support for tcan4552/4553
Date: Thu,  3 Aug 2023 10:08:27 +0200
Message-Id: <20230803080830.1386442-7-mkl@pengutronix.de>
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

tcan4552 and tcan4553 do not have wake or state pins, so they are
currently not compatible with the generic driver. The generic driver
uses tcan4x5x_disable_state() and tcan4x5x_disable_wake() if the gpios
are not defined. These functions use register bits that are not
available in tcan4552/4553.

This patch adds support by introducing version information to reflect if
the chip has wake and state pins. Also the version is now checked.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://lore.kernel.org/all/20230728141923.162477-6-msp@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 104 ++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index fb9375fa20ec..2d329b4e4f52 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -7,6 +7,7 @@
 #define TCAN4X5X_EXT_CLK_DEF 40000000
 
 #define TCAN4X5X_DEV_ID1 0x00
+#define TCAN4X5X_DEV_ID1_TCAN 0x4e414354 /* ASCII TCAN */
 #define TCAN4X5X_DEV_ID2 0x04
 #define TCAN4X5X_REV 0x08
 #define TCAN4X5X_STATUS 0x0C
@@ -103,6 +104,37 @@
 #define TCAN4X5X_WD_3_S_TIMER BIT(29)
 #define TCAN4X5X_WD_6_S_TIMER (BIT(28) | BIT(29))
 
+struct tcan4x5x_version_info {
+	const char *name;
+	u32 id2_register;
+
+	bool has_wake_pin;
+	bool has_state_pin;
+};
+
+enum {
+	TCAN4552 = 0,
+	TCAN4553,
+	TCAN4X5X,
+};
+
+static const struct tcan4x5x_version_info tcan4x5x_versions[] = {
+	[TCAN4552] = {
+		.name = "4552",
+		.id2_register = 0x32353534,
+	},
+	[TCAN4553] = {
+		.name = "4553",
+		.id2_register = 0x32353534,
+	},
+	/* generic version with no id2_register at the end */
+	[TCAN4X5X] = {
+		.name = "generic",
+		.has_wake_pin = true,
+		.has_state_pin = true,
+	},
+};
+
 static inline struct tcan4x5x_priv *cdev_to_priv(struct m_can_classdev *cdev)
 {
 	return container_of(cdev, struct tcan4x5x_priv, cdev);
@@ -254,18 +286,53 @@ static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
 				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
 }
 
-static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
+static const struct tcan4x5x_version_info
+*tcan4x5x_find_version(struct tcan4x5x_priv *priv)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, TCAN4X5X_DEV_ID1, &val);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (val != TCAN4X5X_DEV_ID1_TCAN) {
+		dev_err(&priv->spi->dev, "Not a tcan device %x\n", val);
+		return ERR_PTR(-ENODEV);
+	}
+
+	ret = regmap_read(priv->regmap, TCAN4X5X_DEV_ID2, &val);
+	if (ret)
+		return ERR_PTR(ret);
+
+	for (int i = 0; i != ARRAY_SIZE(tcan4x5x_versions); ++i) {
+		const struct tcan4x5x_version_info *vinfo = &tcan4x5x_versions[i];
+
+		if (!vinfo->id2_register || val == vinfo->id2_register) {
+			dev_info(&priv->spi->dev, "Detected TCAN device version %s\n",
+				 vinfo->name);
+			return vinfo;
+		}
+	}
+
+	return &tcan4x5x_versions[TCAN4X5X];
+}
+
+static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
+			      const struct tcan4x5x_version_info *version_info)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
 	int ret;
 
-	tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
-						    GPIOD_OUT_HIGH);
-	if (IS_ERR(tcan4x5x->device_wake_gpio)) {
-		if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+	if (version_info->has_wake_pin) {
+		tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
+							    GPIOD_OUT_HIGH);
+		if (IS_ERR(tcan4x5x->device_wake_gpio)) {
+			if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
 
-		tcan4x5x_disable_wake(cdev);
+			tcan4x5x_disable_wake(cdev);
+		}
 	}
 
 	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
@@ -277,12 +344,14 @@ static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
-	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
-							      "device-state",
-							      GPIOD_IN);
-	if (IS_ERR(tcan4x5x->device_state_gpio)) {
-		tcan4x5x->device_state_gpio = NULL;
-		tcan4x5x_disable_state(cdev);
+	if (version_info->has_state_pin) {
+		tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
+								      "device-state",
+								      GPIOD_IN);
+		if (IS_ERR(tcan4x5x->device_state_gpio)) {
+			tcan4x5x->device_state_gpio = NULL;
+			tcan4x5x_disable_state(cdev);
+		}
 	}
 
 	return 0;
@@ -299,6 +368,7 @@ static struct m_can_ops tcan4x5x_ops = {
 
 static int tcan4x5x_can_probe(struct spi_device *spi)
 {
+	const struct tcan4x5x_version_info *version_info;
 	struct tcan4x5x_priv *priv;
 	struct m_can_classdev *mcan_class;
 	int freq, ret;
@@ -361,7 +431,13 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	if (ret)
 		goto out_m_can_class_free_dev;
 
-	ret = tcan4x5x_get_gpios(mcan_class);
+	version_info = tcan4x5x_find_version(priv);
+	if (IS_ERR(version_info)) {
+		ret = PTR_ERR(version_info);
+		goto out_power;
+	}
+
+	ret = tcan4x5x_get_gpios(mcan_class, version_info);
 	if (ret)
 		goto out_power;
 
-- 
2.40.1



