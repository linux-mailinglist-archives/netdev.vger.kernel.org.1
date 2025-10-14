Return-Path: <netdev+bounces-229266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14232BD9EF4
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0331502FAF
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6669C316180;
	Tue, 14 Oct 2025 14:10:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1A3314D19
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451035; cv=none; b=EUrgp0C/JOZSfHR80L2zFQkUiqVXiTei6NOJhTG/UesmonvnLj7lQGu5K0v33XrBVP1NWKxFBmT0AFdCbOW0iqxXbLGF2bN+JztCfq4cmdYhCTS0m9fYJvfOSWLiOcpKEpVqaQOtmeT1K5ESL3TSPKJZJJpo2v0PmSy+uHsjhII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451035; c=relaxed/simple;
	bh=rwPR9Y3S5X1jNFtstjpORz/sGfQMScJphvyaP9mttPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmng2yTNxPFjeaHCN6SoEJ8y4tFZJc7GeU4O+uGSvVGRrUXJhxIEj0tTXQNk2+JLLd4oz8GpEXQUvkwrWa2z+p3NexciloYyHGaSOpP3PYXz2zOBrr5gZlSSBmfPClw+04xwzrutQ+aJdrdjHINOevpJd7/UsEapN8wqqC9g7Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8fjK-0008IK-TW; Tue, 14 Oct 2025 16:10:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8fjK-003ZQ2-1a;
	Tue, 14 Oct 2025 16:10:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 386EA485F1A;
	Tue, 14 Oct 2025 14:10:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH net 06/10] can: m_can: fix CAN state in system PM
Date: Tue, 14 Oct 2025 14:17:53 +0200
Message-ID: <20251014122140.990472-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122140.990472-1-mkl@pengutronix.de>
References: <20251014122140.990472-1-mkl@pengutronix.de>
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

A suspend/resume cycle on a down interface results in the interface
coming up in Error Active state. A suspend/resume cycle on an Up
interface will always result in Error Active state, regardless of the
actual CAN state.

During suspend, only set running interfaces to CAN_STATE_SLEEPING.
During resume only touch the CAN state of running interfaces. For
wakeup sources, set the CAN state depending on the Protocol Status
Regitser (PSR), for non wakeup source interfaces m_can_start() will do
the same.

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://patch.msgid.link/20250929-m_can-fix-state-handling-v4-4-682b49b49d9a@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index b6db5b57241c..f2576e577058 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2503,12 +2503,11 @@ int m_can_class_suspend(struct device *dev)
 		}
 
 		m_can_clk_stop(cdev);
+		cdev->can.state = CAN_STATE_SLEEPING;
 	}
 
 	pinctrl_pm_select_sleep_state(dev);
 
-	cdev->can.state = CAN_STATE_SLEEPING;
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(m_can_class_suspend);
@@ -2521,8 +2520,6 @@ int m_can_class_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
-
 	if (netif_running(ndev)) {
 		ret = m_can_clk_start(cdev);
 		if (ret)
@@ -2540,6 +2537,8 @@ int m_can_class_resume(struct device *dev)
 			if (cdev->ops->init)
 				ret = cdev->ops->init(cdev);
 
+			cdev->can.state = m_can_state_get_by_psr(cdev);
+
 			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
 		} else {
 			ret  = m_can_start(ndev);
-- 
2.51.0


