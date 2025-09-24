Return-Path: <netdev+bounces-225842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30F5B98D0F
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8DA2E3118
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1492877FE;
	Wed, 24 Sep 2025 08:21:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D38285053
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702109; cv=none; b=NoCD8GTK+3RAF41fQWMVGw85DziBSPiskfB3TDKWUXG5hD7tKDK8tRjddZGj8sOxMze9gXW2fsk9ENkf2wmdei+tMUurtMNdh8pcAQlUB9HN5/xY02d3AjfrYkqQu0gWTCRtz/y8RxdyPdyvqMBEO2596Pohyoq/RfS3SDDWWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702109; c=relaxed/simple;
	bh=v32u9sx+h2lMck8a93a/YOXyqKrFvoIeJWCYl2erV/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgE7HmOw7oRcdzYGJNUOB63wwHBZwtHgl1Pt06M6SVijY+ViBtRnjnKotHMw8NY64BtvtxG7Mv7/SKJqYAbCjZqWHSMXFFVPIvjcZTlcaaZuPIO5mbzJ3gZvoBweqZ9h+dIrCtGQ17x76Ylm5mekYeUcaUqb/Ym/hy8z2XhTodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkf-0001GR-8A; Wed, 24 Sep 2025 10:21:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-000DwR-1o;
	Wed, 24 Sep 2025 10:21:23 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C8D6147888A;
	Wed, 24 Sep 2025 08:21:08 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 19/48] can: rcar_can: Convert to %pe
Date: Wed, 24 Sep 2025 10:06:36 +0200
Message-ID: <20250924082104.595459-20-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Replace numerical error codes by mnemotechnic error codes, to improve
the user experience in case of errors.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/adb2dc49c78b45191de410f645a5e423d341f94e.1755857536.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 51bf8f7e7182..5f85f4e27205 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -521,20 +521,20 @@ static int rcar_can_open(struct net_device *ndev)
 	}
 	err = clk_prepare_enable(priv->can_clk);
 	if (err) {
-		netdev_err(ndev, "failed to enable CAN clock, error %d\n",
-			   err);
+		netdev_err(ndev, "failed to enable CAN clock: %pe\n",
+			   ERR_PTR(err));
 		goto out_rpm;
 	}
 	err = open_candev(ndev);
 	if (err) {
-		netdev_err(ndev, "open_candev() failed, error %d\n", err);
+		netdev_err(ndev, "open_candev() failed %pe\n", ERR_PTR(err));
 		goto out_can_clock;
 	}
 	napi_enable(&priv->napi);
 	err = request_irq(ndev->irq, rcar_can_interrupt, 0, ndev->name, ndev);
 	if (err) {
-		netdev_err(ndev, "request_irq(%d) failed, error %d\n",
-			   ndev->irq, err);
+		netdev_err(ndev, "request_irq(%d) failed %pe\n", ndev->irq,
+			   ERR_PTR(err));
 		goto out_close;
 	}
 	rcar_can_start(ndev);
@@ -786,8 +786,8 @@ static int rcar_can_probe(struct platform_device *pdev)
 	}
 	priv->can_clk = devm_clk_get(dev, clock_names[clock_select]);
 	if (IS_ERR(priv->can_clk)) {
+		dev_err(dev, "cannot get CAN clock: %pe\n", priv->can_clk);
 		err = PTR_ERR(priv->can_clk);
-		dev_err(dev, "cannot get CAN clock, error %d\n", err);
 		goto fail_clk;
 	}
 
@@ -813,7 +813,7 @@ static int rcar_can_probe(struct platform_device *pdev)
 
 	err = register_candev(ndev);
 	if (err) {
-		dev_err(dev, "register_candev() failed, error %d\n", err);
+		dev_err(dev, "register_candev() failed %pe\n", ERR_PTR(err));
 		goto fail_rpm;
 	}
 
-- 
2.51.0


