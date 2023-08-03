Return-Path: <netdev+bounces-23925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A48A76E28A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B041C21545
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D56156E5;
	Thu,  3 Aug 2023 08:08:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B23115AF9
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:08:47 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49265FFA
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:08:40 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qRTNu-0000Xd-M1
	for netdev@vger.kernel.org; Thu, 03 Aug 2023 10:08:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 7516A20227D
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:08:36 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D7FF7202243;
	Thu,  3 Aug 2023 08:08:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ddfc77e7;
	Thu, 3 Aug 2023 08:08:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 8/9] can: c_can: Do not check for 0 return after calling platform_get_irq()
Date: Thu,  3 Aug 2023 10:08:29 +0200
Message-Id: <20230803080830.1386442-9-mkl@pengutronix.de>
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
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ruan Jinjie <ruanjinjie@huawei.com>

It is not possible for platform_get_irq() to return 0. Use the
return value from platform_get_irq().

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Link: https://lore.kernel.org/all/20230802030900.2271322-1-ruanjinjie@huawei.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can_platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 925930b6c4ca..f44ba2600415 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -285,8 +285,8 @@ static int c_can_plat_probe(struct platform_device *pdev)
 
 	/* get the platform data */
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		ret = -ENODEV;
+	if (irq < 0) {
+		ret = irq;
 		goto exit;
 	}
 
-- 
2.40.1



