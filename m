Return-Path: <netdev+bounces-136326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41499A153A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 23:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A851C222F2
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B209E1D86E6;
	Wed, 16 Oct 2024 21:52:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07381D5CFA
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115557; cv=none; b=Hgk6q2aJi9EW+A7bg++a10QlcvwnxoU1ZzKXMi0ailUMfL0SabK/SBhoEjGbN+8RevVp9J0dCRVcaZG+xQUNSd4bNjQ/uCJiPTWqHeCMx2g/jM8cD9fKxzzFbdBo6okg7IO3rJ3j1zOZu9VriHUrww1slW9/UnEfdjyw8Y9wYGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115557; c=relaxed/simple;
	bh=tcNc/WHwbtrSjvHNY6VoFGsID5+2ekA+Dw1Mv/xHWGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6HpdhzN2kzzKZ/ttWtUzVRG+1RnsxUWKZ5g/9yj8ZFIT03paHWmBZ3IiONSKQrC/RvlgfhSd6oFy0Q5HvGJdltZYSDjNQrA40sRj7xTOERG351A60K0J9XzIoyby/l+qcZUBcddKUPZqW/3AKSP9aq8+AO0iI/bXE6+b5ZEBs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwU-0003SG-Ot
	for netdev@vger.kernel.org; Wed, 16 Oct 2024 23:52:30 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwQ-002OVI-Qb
	for netdev@vger.kernel.org; Wed, 16 Oct 2024 23:52:26 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 726F8354937
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 21:52:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 6FC1C354887;
	Wed, 16 Oct 2024 21:52:20 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 84f0d07b;
	Wed, 16 Oct 2024 21:52:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 16 Oct 2024 23:51:55 +0200
Subject: [PATCH net-next 07/13] net: fec: fec_probe(): update quirk: bring
 IRQs in correct order
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-fec-cleanups-v1-7-de783bd15e6a@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4182; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=tcNc/WHwbtrSjvHNY6VoFGsID5+2ekA+Dw1Mv/xHWGg=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnEDWHUQ1y/LJ9LWKdPDVg29YDLiDTbGto7my/U
 MlLBpL2+a2JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZxA1hwAKCRAoOKI+ei28
 b7G8B/9XMejTYEgUJzMVtEwthcAtlTIH9bg+bzj2LTZLeVqKzEmpC+Fx9s3UZ8NXizKNu5phs+s
 rwjmJSqb4v5tw3T5QUp9UiKxktMxUWTrboFnimf/BF2FsYIpvQYyu6MZxtazMNuXxhhF+VEpDkp
 gsEUNHkH9bwKEoAYHG7IwC3SejHTl5vMGwIP5Ql0HlpOLRoa3kjc45e1E+5Ea1aVF3M1NmwTjxT
 LKtB0sBwVHl1qFvbg3t4PxDbFrUC70dMmsp+S1qX5a1+6C9Rd7k6Ke9gy3bE/F0IFd4sV8WSCkg
 Tc+3XmaTbGNe6Cw/bM/kGIdTL9vkqfEusRa7H2w1F4ci51n6
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

With i.MX8MQ and compatible SoCs, the order of the IRQs in the device
tree is not optimal. The driver expects the first three IRQs to match
their corresponding queue, while the last (fourth) IRQ is used for the
PPS:

- 1st IRQ: "int0": queue0 + other IRQs
- 2nd IRQ: "int1": queue1
- 3rd IRQ: "int2": queue2
- 4th IRQ: "pps": pps

However, the i.MX8MQ and compatible SoCs do not use the
"interrupt-names" property and specify the IRQs in the wrong order:

- 1st IRQ: queue1
- 2nd IRQ: queue2
- 3rd IRQ: queue0 + other IRQs
- 4th IRQ: pps

First rename the quirk from FEC_QUIRK_WAKEUP_FROM_INT2 to
FEC_QUIRK_INT2_IS_MAIN_IRQ, to better reflect it's functionality.

If the FEC_QUIRK_INT2_IS_MAIN_IRQ quirk is active, put the IRQs back
in the correct order, this is done in fec_probe().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec.h      | 24 ++++++++++++++++++++++--
 drivers/net/ethernet/freescale/fec_main.c | 18 +++++++++++-------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 63744a86752540fcede7fc4c29865b2529492526..b0f1a3e28d5c8052be3a8a0fa18303a1df2bb5bd 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -504,8 +504,28 @@ struct bufdesc_ex {
  */
 #define FEC_QUIRK_DELAYED_CLKS_SUPPORT	(1 << 21)
 
-/* i.MX8MQ SoC integration mix wakeup interrupt signal into "int2" interrupt line. */
-#define FEC_QUIRK_WAKEUP_FROM_INT2	(1 << 22)
+/* With i.MX8MQ and compatible SoCs, the order of the IRQs in the
+ * device tree is not optimal. The driver expects the first three IRQs
+ * to match their corresponding queue, while the last (fourth) IRQ is
+ * used for the PPS:
+ *
+ * - 1st IRQ: "int0": queue0 + other IRQs
+ * - 2nd IRQ: "int1": queue1
+ * - 3rd IRQ: "int2": queue2
+ * - 4th IRQ: "pps": pps
+ *
+ * However, the i.MX8MQ and compatible SoCs do not use the
+ * "interrupt-names" property and specify the IRQs in the wrong order:
+ *
+ * - 1st IRQ: queue1
+ * - 2nd IRQ: queue2
+ * - 3rd IRQ: queue0 + other IRQs
+ * - 4th IRQ: pps
+ *
+ * If the following quirk is active, put the IRQs back in the correct
+ * order, this is done in fec_probe().
+ */
+#define FEC_QUIRK_DT_IRQ2_IS_MAIN_IRQ	BIT(22)
 
 /* i.MX6Q adds pm_qos support */
 #define FEC_QUIRK_HAS_PMQOS			BIT(23)
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d948ed9810027d5fabe521dc3af2cf505dacd13e..f124ffe3619d82dc089f8494d33d2398e6f631fb 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -157,7 +157,7 @@ static const struct fec_devinfo fec_imx8mq_info = {
 		  FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
 		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
 		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MULTI_QUEUES |
-		  FEC_QUIRK_HAS_EEE | FEC_QUIRK_WAKEUP_FROM_INT2 |
+		  FEC_QUIRK_HAS_EEE | FEC_QUIRK_DT_IRQ2_IS_MAIN_IRQ |
 		  FEC_QUIRK_HAS_MDIO_C45,
 };
 
@@ -4260,10 +4260,7 @@ static void fec_enet_get_wakeup_irq(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
-	if (fep->quirks & FEC_QUIRK_WAKEUP_FROM_INT2)
-		fep->wake_irq = fep->irq[2];
-	else
-		fep->wake_irq = fep->irq[0];
+	fep->wake_irq = fep->irq[0];
 }
 
 static int fec_enet_init_stop_mode(struct fec_enet_private *fep,
@@ -4495,10 +4492,17 @@ fec_probe(struct platform_device *pdev)
 		goto failed_init;
 
 	for (i = 0; i < irq_cnt; i++) {
-		snprintf(irq_name, sizeof(irq_name), "int%d", i);
+		int irq_num;
+
+		if (fep->quirks & FEC_QUIRK_DT_IRQ2_IS_MAIN_IRQ)
+			irq_num = (i + irq_cnt - 1) % irq_cnt;
+		else
+			irq_num = i;
+
+		snprintf(irq_name, sizeof(irq_name), "int%d", irq_num);
 		irq = platform_get_irq_byname_optional(pdev, irq_name);
 		if (irq < 0)
-			irq = platform_get_irq(pdev, i);
+			irq = platform_get_irq(pdev, irq_num);
 		if (irq < 0) {
 			ret = irq;
 			goto failed_irq;

-- 
2.45.2



