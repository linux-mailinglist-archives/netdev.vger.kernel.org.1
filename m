Return-Path: <netdev+bounces-230510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C750BE9C3A
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93D174769B
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 15:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D1E336ED9;
	Fri, 17 Oct 2025 15:08:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96D3328FA
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713723; cv=none; b=uOXewLdiUeJ7VGdozE0Or45N8dcHvdSryOUMDiNg+8MsJmgvyc+SEmiE+ga7ysEXPYbC2Oq2gWjVCs7IcTPHYQKhH5XIhnG3ct7aRKzBm/C/EQnV87JsZ8Y3Zdqrxf85VmtyaaQusr8pfMJ5YbYtyOKclx/UWJCXZ7fGU1tYLuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713723; c=relaxed/simple;
	bh=iKC1GWmLVeBAiHm1oZ3X2Qx/1NWmoClug8KtvMaZxzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXw0imPribm+0nN/wzCiVoKjQ4cemP82lFbBoo9mh0WT0zW87qQ9PMU41dA4ZVvbDUrWSYYh4Ga3Px97ijtrMYn6o5a4ImFvX8dT/SJ2KUpjm52UI4lcthAsfCcLRq2DuUtbmbVunVDKLP0ko649I5ail4cFtXYTHhEeL5PO/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4E-0003Mw-2P; Fri, 17 Oct 2025 17:08:30 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4D-00450V-19;
	Fri, 17 Oct 2025 17:08:29 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 046674892B2;
	Fri, 17 Oct 2025 15:08:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH net-next 01/13] can: m_can: add support for optional reset
Date: Fri, 17 Oct 2025 17:04:09 +0200
Message-ID: <20251017150819.1415685-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017150819.1415685-1-mkl@pengutronix.de>
References: <20251017150819.1415685-1-mkl@pengutronix.de>
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

This patch has been split from the original series [1].

In some SoCs (observed on the STM32MP15) the M_CAN IP core keeps the CAN
state and CAN error counters over an internal reset cycle. The STM32MP15
SoC provides an external reset, which is shared between both M_CAN cores.

Add support for an optional external reset. Take care of shared resets,
de-assert reset during the probe phase in m_can_class_register() and while
the interface is up, assert the reset otherwise.

[1] https://lore.kernel.org/all/20250923-m_can-fix-state-handling-v3-0-06d8baccadbf@pengutronix.de

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://patch.msgid.link/20251008-m_can-add-reset-v1-1-49f0bbf820c4@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 27 ++++++++++++++++++++++++---
 drivers/net/can/m_can/m_can.h |  1 +
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index ad4f577c1ef7..48b7a67336b5 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -23,6 +23,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 #include "m_can.h"
 
@@ -1827,6 +1828,7 @@ static int m_can_close(struct net_device *dev)
 
 	close_candev(dev);
 
+	reset_control_assert(cdev->rst);
 	m_can_clk_stop(cdev);
 	phy_power_off(cdev->transceiver);
 
@@ -2069,11 +2071,15 @@ static int m_can_open(struct net_device *dev)
 	if (err)
 		goto out_phy_power_off;
 
+	err = reset_control_deassert(cdev->rst);
+	if (err)
+		goto exit_disable_clks;
+
 	/* open the can device */
 	err = open_candev(dev);
 	if (err) {
 		netdev_err(dev, "failed to open can device\n");
-		goto exit_disable_clks;
+		goto out_reset_control_assert;
 	}
 
 	if (cdev->is_peripheral)
@@ -2129,6 +2135,8 @@ static int m_can_open(struct net_device *dev)
 	else
 		napi_disable(&cdev->napi);
 	close_candev(dev);
+out_reset_control_assert:
+	reset_control_assert(cdev->rst);
 exit_disable_clks:
 	m_can_clk_stop(cdev);
 out_phy_power_off:
@@ -2417,15 +2425,24 @@ int m_can_class_register(struct m_can_classdev *cdev)
 		}
 	}
 
+	cdev->rst = devm_reset_control_get_optional_shared(cdev->dev, NULL);
+	if (IS_ERR(cdev->rst))
+		return dev_err_probe(cdev->dev, PTR_ERR(cdev->rst),
+				     "Failed to get reset line\n");
+
 	ret = m_can_clk_start(cdev);
 	if (ret)
 		return ret;
 
+	ret = reset_control_deassert(cdev->rst);
+	if (ret)
+		goto clk_disable;
+
 	if (cdev->is_peripheral) {
 		ret = can_rx_offload_add_manual(cdev->net, &cdev->offload,
 						NAPI_POLL_WEIGHT);
 		if (ret)
-			goto clk_disable;
+			goto out_reset_control_assert;
 	}
 
 	if (!cdev->net->irq) {
@@ -2454,8 +2471,10 @@ int m_can_class_register(struct m_can_classdev *cdev)
 		 KBUILD_MODNAME, cdev->net->irq, cdev->version);
 
 	/* Probe finished
-	 * Stop clocks. They will be reactivated once the M_CAN device is opened
+	 * Assert reset and stop clocks.
+	 * They will be reactivated once the M_CAN device is opened
 	 */
+	reset_control_assert(cdev->rst);
 	m_can_clk_stop(cdev);
 
 	return 0;
@@ -2463,6 +2482,8 @@ int m_can_class_register(struct m_can_classdev *cdev)
 rx_offload_del:
 	if (cdev->is_peripheral)
 		can_rx_offload_del(&cdev->offload);
+out_reset_control_assert:
+	reset_control_assert(cdev->rst);
 clk_disable:
 	m_can_clk_stop(cdev);
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index bd4746c63af3..7b7600697c6b 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -86,6 +86,7 @@ struct m_can_classdev {
 	struct device *dev;
 	struct clk *hclk;
 	struct clk *cclk;
+	struct reset_control *rst;
 
 	struct workqueue_struct *tx_wq;
 	struct phy *transceiver;

base-commit: 7e0d4c111369ed385ec4aaa6c9c78c46efda54d0
-- 
2.51.0


