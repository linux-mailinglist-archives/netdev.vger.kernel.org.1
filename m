Return-Path: <netdev+bounces-226298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34960B9F1DF
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A367D3263B6
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE8F2FF15E;
	Thu, 25 Sep 2025 12:14:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BFF2FFDF3
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802444; cv=none; b=jPZokh2Ib/jM+E2TCVTDqPGjDRRyGtYdej0e7QO+29YqrJoQlRiD7istlDb18B5HLI0MazfPc4g2ZrYHjd8udhm1mwxXvrNVdZGhbY1zzUaNFAtgjgNiR/Gghth8Q+1wogCb6OeNpzzzv1Fz3bsQL1F5M1VxzCvmIvJedMjN/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802444; c=relaxed/simple;
	bh=M/ntwWkRcMSeeAuxA1GvbveI4LPTahtD5a0uxKFl5Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXDlqRs15mcv8KJI1/Kn+NW+gxYP44G6rGtUANGZwZL53cifi80HPX5pA/GSo0jFycWv310PvIxA/1zAG/atXPNE49m4q/M6cVfU80ymU34/KwhWSsgZ9S0QLnXr2W36rOvmrU1SPUrpR1Em9Ivk3RkwPuhQHP395ZnaC52NvxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqu-0000Vo-Gv; Thu, 25 Sep 2025 14:13:36 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqt-000PvZ-2i;
	Thu, 25 Sep 2025 14:13:35 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 93B6F479977;
	Thu, 25 Sep 2025 12:13:35 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/48] can: rcar_can: Convert to Runtime PM
Date: Thu, 25 Sep 2025 14:07:48 +0200
Message-ID: <20250925121332.848157-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925121332.848157-1-mkl@pengutronix.de>
References: <20250925121332.848157-1-mkl@pengutronix.de>
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

The R-Car CAN module is part of a Clock Domain on all supported SoCs.
Hence convert its driver from explicit clock management to Runtime PM.

While at it, use %pe to format error codes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/68bfa5480a79c17c6ceec4fb073f33872e7ff5d0.1755857536.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c | 48 ++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 57030992141c..15dbaa52a7b1 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -16,6 +16,7 @@
 #include <linux/can/dev.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 
 #define RCAR_CAN_DRV_NAME	"rcar_can"
 
@@ -92,7 +93,6 @@ struct rcar_can_priv {
 	struct net_device *ndev;
 	struct napi_struct napi;
 	struct rcar_can_regs __iomem *regs;
-	struct clk *clk;
 	struct clk *can_clk;
 	u32 tx_head;
 	u32 tx_tail;
@@ -506,18 +506,17 @@ static int rcar_can_open(struct net_device *ndev)
 	struct rcar_can_priv *priv = netdev_priv(ndev);
 	int err;
 
-	err = clk_prepare_enable(priv->clk);
+	err = pm_runtime_resume_and_get(ndev->dev.parent);
 	if (err) {
-		netdev_err(ndev,
-			   "failed to enable peripheral clock, error %d\n",
-			   err);
+		netdev_err(ndev, "pm_runtime_resume_and_get() failed %pe\n",
+			   ERR_PTR(err));
 		goto out;
 	}
 	err = clk_prepare_enable(priv->can_clk);
 	if (err) {
 		netdev_err(ndev, "failed to enable CAN clock, error %d\n",
 			   err);
-		goto out_clock;
+		goto out_rpm;
 	}
 	err = open_candev(ndev);
 	if (err) {
@@ -539,8 +538,8 @@ static int rcar_can_open(struct net_device *ndev)
 	close_candev(ndev);
 out_can_clock:
 	clk_disable_unprepare(priv->can_clk);
-out_clock:
-	clk_disable_unprepare(priv->clk);
+out_rpm:
+	pm_runtime_put(ndev->dev.parent);
 out:
 	return err;
 }
@@ -578,7 +577,7 @@ static int rcar_can_close(struct net_device *ndev)
 	free_irq(ndev->irq, ndev);
 	napi_disable(&priv->napi);
 	clk_disable_unprepare(priv->can_clk);
-	clk_disable_unprepare(priv->clk);
+	pm_runtime_put(ndev->dev.parent);
 	close_candev(ndev);
 	return 0;
 }
@@ -721,12 +720,15 @@ static int rcar_can_get_berr_counter(const struct net_device *ndev,
 	struct rcar_can_priv *priv = netdev_priv(ndev);
 	int err;
 
-	err = clk_prepare_enable(priv->clk);
+	err = pm_runtime_resume_and_get(ndev->dev.parent);
 	if (err)
 		return err;
+
 	bec->txerr = readb(&priv->regs->tecr);
 	bec->rxerr = readb(&priv->regs->recr);
-	clk_disable_unprepare(priv->clk);
+
+	pm_runtime_put(ndev->dev.parent);
+
 	return 0;
 }
 
@@ -770,13 +772,6 @@ static int rcar_can_probe(struct platform_device *pdev)
 
 	priv = netdev_priv(ndev);
 
-	priv->clk = devm_clk_get(dev, "clkp1");
-	if (IS_ERR(priv->clk)) {
-		err = PTR_ERR(priv->clk);
-		dev_err(dev, "cannot get peripheral clock, error %d\n", err);
-		goto fail_clk;
-	}
-
 	if (!(BIT(clock_select) & RCAR_SUPPORTED_CLOCKS)) {
 		err = -EINVAL;
 		dev_err(dev, "invalid CAN clock selected\n");
@@ -806,16 +801,20 @@ static int rcar_can_probe(struct platform_device *pdev)
 
 	netif_napi_add_weight(ndev, &priv->napi, rcar_can_rx_poll,
 			      RCAR_CAN_NAPI_WEIGHT);
+
+	pm_runtime_enable(dev);
+
 	err = register_candev(ndev);
 	if (err) {
 		dev_err(dev, "register_candev() failed, error %d\n", err);
-		goto fail_candev;
+		goto fail_rpm;
 	}
 
 	dev_info(dev, "device registered (IRQ%d)\n", ndev->irq);
 
 	return 0;
-fail_candev:
+fail_rpm:
+	pm_runtime_disable(dev);
 	netif_napi_del(&priv->napi);
 fail_clk:
 	free_candev(ndev);
@@ -829,6 +828,7 @@ static void rcar_can_remove(struct platform_device *pdev)
 	struct rcar_can_priv *priv = netdev_priv(ndev);
 
 	unregister_candev(ndev);
+	pm_runtime_disable(&pdev->dev);
 	netif_napi_del(&priv->napi);
 	free_candev(ndev);
 }
@@ -852,22 +852,22 @@ static int rcar_can_suspend(struct device *dev)
 	writew(ctlr, &priv->regs->ctlr);
 	priv->can.state = CAN_STATE_SLEEPING;
 
-	clk_disable(priv->clk);
+	pm_runtime_put(dev);
 	return 0;
 }
 
 static int rcar_can_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
-	struct rcar_can_priv *priv = netdev_priv(ndev);
 	int err;
 
 	if (!netif_running(ndev))
 		return 0;
 
-	err = clk_enable(priv->clk);
+	err = pm_runtime_resume_and_get(dev);
 	if (err) {
-		netdev_err(ndev, "clk_enable() failed, error %d\n", err);
+		netdev_err(ndev, "pm_runtime_resume_and_get() failed %pe\n",
+			   ERR_PTR(err));
 		return err;
 	}
 
-- 
2.51.0


