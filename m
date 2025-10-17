Return-Path: <netdev+bounces-230509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0267BBE9A6F
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914224279BC
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B532E141;
	Fri, 17 Oct 2025 15:08:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF2532E135
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713722; cv=none; b=pr3WsjujBY5c283VptUJeqCnxWmkMmsvH/mtXfgStgVl8CmqcvQO4CgKpl9bp4jTYJGSA9pHrJRrH/qV8uiiF5ZMcIsV4f8u49A+FR5nzH2Tj4lqt9PjOD0e8/+mFVgpMUGjtfH09O68J4BQ0ZyzoscJlgBhv1rHZCkoIB7hyBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713722; c=relaxed/simple;
	bh=UDfHSpXQzMniq/cZrxet6DUgMgxeaIhIHhw7wfrc3Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mczp44jly8Im3vyooBk1TNR8pdadynVBVBtRyC5g7od3sQiMjN20OPlwixBjKn0JtBS2ggpj20v4i13pOrUgMzUk3rTe1p0CqPCVcAUPAq9lLPnok/tJHYYZjCQqERmGPd5sz/TTDsyGlCZjOvoI8IufV5qwTKM+MtYqPWxcKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4E-0003OJ-Jf; Fri, 17 Oct 2025 17:08:30 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4E-00450y-0S;
	Fri, 17 Oct 2025 17:08:30 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D6B4D4892BD;
	Fri, 17 Oct 2025 15:08:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 12/13] can: m_can: m_can_tx_submit(): remove unneeded sanity checks
Date: Fri, 17 Oct 2025 17:04:20 +0200
Message-ID: <20251017150819.1415685-13-mkl@pengutronix.de>
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

m_can_tx_submit() is only called for peripheral devices. So remove the
sanity check.

Link: https://patch.msgid.link/20251008-m_can-cleanups-v1-6-1784a18eaa84@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 8013e8835027..713d3df296df 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1973,11 +1973,6 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 
 static void m_can_tx_submit(struct m_can_classdev *cdev)
 {
-	if (cdev->version == 30)
-		return;
-	if (!cdev->is_peripheral)
-		return;
-
 	m_can_write(cdev, M_CAN_TXBAR, cdev->tx_peripheral_submit);
 	cdev->tx_peripheral_submit = 0;
 }
-- 
2.51.0


