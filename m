Return-Path: <netdev+bounces-23918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960BB76E27E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBC72820A8
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F60A14A8C;
	Thu,  3 Aug 2023 08:08:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498414A83
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:08:42 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A9F5FEA
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:08:37 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qRTNs-0000Sr-1D
	for netdev@vger.kernel.org; Thu, 03 Aug 2023 10:08:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A4F43202257
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:08:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E6CF120222E;
	Thu,  3 Aug 2023 08:08:32 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a947b230;
	Thu, 3 Aug 2023 08:08:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 1/9] can: flexcan: fix the return value handle for platform_get_irq()
Date: Thu,  3 Aug 2023 10:08:22 +0200
Message-Id: <20230803080830.1386442-2-mkl@pengutronix.de>
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

From: Ruan Jinjie <ruanjinjie@huawei.com>

There is no possible for platform_get_irq() to return 0
and the return value of platform_get_irq() is more sensible
to show the error reason.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Link: https://lore.kernel.org/all/20230731075252.359965-1-ruanjinjie@huawei.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan/flexcan-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 48273d51f271..add39e922b89 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2089,8 +2089,8 @@ static int flexcan_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENODEV;
+	if (irq < 0)
+		return irq;
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
@@ -2167,13 +2167,13 @@ static int flexcan_probe(struct platform_device *pdev)
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		priv->irq_boff = platform_get_irq(pdev, 1);
-		if (priv->irq_boff <= 0) {
-			err = -ENODEV;
+		if (priv->irq_boff < 0) {
+			err = priv->irq_boff;
 			goto failed_platform_get_irq;
 		}
 		priv->irq_err = platform_get_irq(pdev, 2);
-		if (priv->irq_err <= 0) {
-			err = -ENODEV;
+		if (priv->irq_err < 0) {
+			err = priv->irq_err;
 			goto failed_platform_get_irq;
 		}
 	}

base-commit: 2b3082c6ef3b0104d822f6f18d2afbe5fc9a5c2c
-- 
2.40.1



