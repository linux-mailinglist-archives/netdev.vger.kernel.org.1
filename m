Return-Path: <netdev+bounces-123890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB856966BD7
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 00:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8B5B22A51
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3006F1BF7FD;
	Fri, 30 Aug 2024 21:59:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1D1C174D
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725055164; cv=none; b=Qp0SAexXvc7+8j8tGu3AXcm6Tqt/aLV9WIGyRGskWbvaBXwGLA+1CfmWFNG15KvPh6xSTO4VN99VpME8WEQ8nAWLfSJOLfbOZCZlLW1GFkip6IzX63oOfh6zmWEw0EL7gIDIJSHNYIYUYBi7dAiCssEZBEH8TBRaVsRpOihkStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725055164; c=relaxed/simple;
	bh=z5g8CUyWdwGoLJkTrEEvF8FYnMk1J3zLvchqRzqWO6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWdgYrnmop2Kuw/uM9iLfFXFZc0myo36mRwIBEy6fsrHin1dgaW1sIlOcmFzWDnQdPbgPLa7vGSilydSlkJJVoZem4XsJgY2j6E0Qq15xe2gjB2Sskmi7+nfYFANeyXHdfTyzbvTh0ZhIQDCHYnVgZ3EpHxxFnPoILLp4HrbniY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eK-0004Cf-Ou
	for netdev@vger.kernel.org; Fri, 30 Aug 2024 23:59:20 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eJ-004FWU-6f
	for netdev@vger.kernel.org; Fri, 30 Aug 2024 23:59:19 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id DB80832E50D
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 21:59:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E0FC732E4D7;
	Fri, 30 Aug 2024 21:59:16 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d1e3a0a9;
	Fri, 30 Aug 2024 21:59:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 03/13] can: m_can: Reset coalescing during suspend/resume
Date: Fri, 30 Aug 2024 23:53:38 +0200
Message-ID: <20240830215914.1610393-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830215914.1610393-1-mkl@pengutronix.de>
References: <20240830215914.1610393-1-mkl@pengutronix.de>
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

From: Markus Schneider-Pargmann <msp@baylibre.com>

During resume the interrupts are limited to IR_RF0N and the chip keeps
running. In this case if coalescing is enabled and active we may miss
waterlevel interrupts during suspend. It is safer to reset the
coalescing by stopping the timer and adding IR_RF0N | IR_TEFN to the
interrupts.

This is a theoratical issue and probably extremely rare.

Cc: Martin Hundebøll <martin@geanix.com>
Fixes: 4a94d7e31cf5 ("can: m_can: allow keeping the transceiver running in suspend")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://lore.kernel.org/all/20240805183047.305630-2-msp@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index cd83c8b5d4b1..31991e2f343e 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2430,12 +2430,15 @@ int m_can_class_suspend(struct device *dev)
 		netif_device_detach(ndev);
 
 		/* leave the chip running with rx interrupt enabled if it is
-		 * used as a wake-up source.
+		 * used as a wake-up source. Coalescing needs to be reset then,
+		 * the timer is cancelled here, interrupts are done in resume.
 		 */
-		if (cdev->pm_wake_source)
+		if (cdev->pm_wake_source) {
+			hrtimer_cancel(&cdev->hrtimer);
 			m_can_write(cdev, M_CAN_IE, IR_RF0N);
-		else
+		} else {
 			m_can_stop(ndev);
+		}
 
 		m_can_clk_stop(cdev);
 	}
@@ -2465,6 +2468,13 @@ int m_can_class_resume(struct device *dev)
 			return ret;
 
 		if (cdev->pm_wake_source) {
+			/* Restore active interrupts but disable coalescing as
+			 * we may have missed important waterlevel interrupts
+			 * between suspend and resume. Timers are already
+			 * stopped in suspend. Here we enable all interrupts
+			 * again.
+			 */
+			cdev->active_interrupts |= IR_RF0N | IR_TEFN;
 			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
 		} else {
 			ret  = m_can_start(ndev);
-- 
2.45.2



