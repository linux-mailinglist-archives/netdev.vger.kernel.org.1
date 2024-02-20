Return-Path: <netdev+bounces-73209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C1185B5E9
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 09:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F131F21C4C
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5B86025F;
	Tue, 20 Feb 2024 08:51:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A85F541
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419099; cv=none; b=gXNRmLX9Dh4i3zHR/F2DGs8vvYH4Chff+fKxc4cuBbljJ9zx3ai3g6bTGYkIWTF2dXrev57KWFedDNtsSbiWtQ/iBmay7cQJxjon3cY1fXiPZ9oEvRhtsP2Qlg20HWGbT5LIlrLMUYCm+CFYaYtJSk1FYr0uCSW3iMzKUudjTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419099; c=relaxed/simple;
	bh=HMWKONxt18KuLDWiBny4rU1gOb7t30r7QsDINqcGiR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8kofKPA0PUNOOB+YeIucCTeh6aw1QIPXvrj90PifDuvQFVnO6SqEOOQNNDfZuss5yhuNZzxajoAYAFLqrJhrHTgjXuCPEJ6xgNNShX/Q7TyePQqsCCKSup//QS+0pfJ9ow4vMV65Tfp9XnrzvsyNKV45TMvTd5SUi33K7yMVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqh-0001cv-KO
	for netdev@vger.kernel.org; Tue, 20 Feb 2024 09:51:35 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqg-001oEV-FQ
	for netdev@vger.kernel.org; Tue, 20 Feb 2024 09:51:34 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 29A55292F0A
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 08:51:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 7116A292EDF;
	Tue, 20 Feb 2024 08:51:32 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9056ca36;
	Tue, 20 Feb 2024 08:51:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 3/9] can: m_can: allow keeping the transceiver running in suspend
Date: Tue, 20 Feb 2024 09:46:05 +0100
Message-ID: <20240220085130.2936533-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220085130.2936533-1-mkl@pengutronix.de>
References: <20240220085130.2936533-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Martin Hundebøll <martin@geanix.com>

Add a flag to the device class structure that leaves the chip in a
running state with rx interrupt enabled, so that an m_can device driver
can configure and use the interrupt as a wakeup source.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c          | 22 +++++++++++++++++-----
 drivers/net/can/m_can/m_can.h          |  1 +
 drivers/net/can/m_can/m_can_pci.c      |  1 +
 drivers/net/can/m_can/m_can_platform.c |  1 +
 drivers/net/can/m_can/tcan4x5x-core.c  |  1 +
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 290880ce5329..14b231c4d7ec 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2382,7 +2382,15 @@ int m_can_class_suspend(struct device *dev)
 	if (netif_running(ndev)) {
 		netif_stop_queue(ndev);
 		netif_device_detach(ndev);
-		m_can_stop(ndev);
+
+		/* leave the chip running with rx interrupt enabled if it is
+		 * used as a wake-up source.
+		 */
+		if (cdev->pm_wake_source)
+			m_can_write(cdev, M_CAN_IE, IR_RF0N);
+		else
+			m_can_stop(ndev);
+
 		m_can_clk_stop(cdev);
 	}
 
@@ -2409,11 +2417,15 @@ int m_can_class_resume(struct device *dev)
 		ret = m_can_clk_start(cdev);
 		if (ret)
 			return ret;
-		ret  = m_can_start(ndev);
-		if (ret) {
-			m_can_clk_stop(cdev);
 
-			return ret;
+		if (cdev->pm_wake_source) {
+			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
+		} else {
+			ret  = m_can_start(ndev);
+			if (ret) {
+				m_can_clk_stop(cdev);
+				return ret;
+			}
 		}
 
 		netif_device_attach(ndev);
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 2986c4ce0b2f..3a9edc292593 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -97,6 +97,7 @@ struct m_can_classdev {
 	u32 irqstatus;
 
 	int pm_clock_support;
+	int pm_wake_source;
 	int is_peripheral;
 
 	// Cached M_CAN_IE register content
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index f2219aa2824b..45400de4163d 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -125,6 +125,7 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	mcan_class->dev = &pci->dev;
 	mcan_class->net->irq = pci_irq_vector(pci, 0);
 	mcan_class->pm_clock_support = 1;
+	mcan_class->pm_wake_source = 0;
 	mcan_class->can.clock.freq = id->driver_data;
 	mcan_class->ops = &m_can_pci_ops;
 
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index ab1b8211a61c..df0367124b4c 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -139,6 +139,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	mcan_class->net->irq = irq;
 	mcan_class->pm_clock_support = 1;
+	mcan_class->pm_wake_source = 0;
 	mcan_class->can.clock.freq = clk_get_rate(mcan_class->cclk);
 	mcan_class->dev = &pdev->dev;
 	mcan_class->transceiver = transceiver;
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index ae8c42f5debd..71a9e1bec008 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -411,6 +411,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	priv->spi = spi;
 
 	mcan_class->pm_clock_support = 0;
+	mcan_class->pm_wake_source = 0;
 	mcan_class->can.clock.freq = freq;
 	mcan_class->dev = &spi->dev;
 	mcan_class->ops = &tcan4x5x_ops;
-- 
2.43.0



