Return-Path: <netdev+bounces-123458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA98964EDB
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFC0281F67
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BCC1BA273;
	Thu, 29 Aug 2024 19:29:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BBF1B9B20
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959799; cv=none; b=hrhv9dDUO1F/tgHlphM8v7wR35jEfFGJoyy/1yac+tMCnjeDMJJJo+juUjA9FVoscI7t1BqTJQuc0qwZIy3m50RNyQ57QpNjz0P/aZTW6GFyEHbBaPsSHPini3gRwgFnHpKo1yurIJWT/yFFegFjvEEKG/3lurkD6XUpZzgdNeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959799; c=relaxed/simple;
	bh=WFoQMeWLzU/GI3a3uOFI0dcxsePRFGRjo6oQCw23CTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFlVopsAtTO7FtEENgDdK3l1gaasuyghtrMuK1ActRMI2SCZe7awNfhn5+R6gOBevjhAEl9hTu4BX8g3zd+dVN1tY1kDCP4t0NX4hziXkvZkWjPctZ7amcHGosB+zc1Zkjdy+sAuuPnRkKx9fn4vgUgyiuXDaqW9Fd3qjbp2Y/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjkqA-00064m-PA
	for netdev@vger.kernel.org; Thu, 29 Aug 2024 21:29:54 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjkq9-003ypp-Ql
	for netdev@vger.kernel.org; Thu, 29 Aug 2024 21:29:53 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8611132D49C
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 19:29:53 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D977D32D46F;
	Thu, 29 Aug 2024 19:29:51 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 093c9286;
	Thu, 29 Aug 2024 19:29:51 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Simon Horman <horms@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 02/13] can: m_can: Release irq on error in m_can_open
Date: Thu, 29 Aug 2024 21:20:35 +0200
Message-ID: <20240829192947.1186760-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240829192947.1186760-1-mkl@pengutronix.de>
References: <20240829192947.1186760-1-mkl@pengutronix.de>
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

From: Simon Horman <horms@kernel.org>

It appears that the irq requested in m_can_open() may be leaked
if an error subsequently occurs: if m_can_start() fails.

Address this by calling free_irq in the unwind path for
such cases.

Flagged by Smatch.
Compile tested only.

Fixes: eaacfeaca7ad ("can: m_can: Call the RAM init directly from m_can_chip_config")
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/all/20240805-mcan-irq-v2-1-7154c0484819@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 7f63f866083e..cd83c8b5d4b1 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2052,7 +2052,7 @@ static int m_can_open(struct net_device *dev)
 	/* start the m_can controller */
 	err = m_can_start(dev);
 	if (err)
-		goto exit_irq_fail;
+		goto exit_start_fail;
 
 	if (!cdev->is_peripheral)
 		napi_enable(&cdev->napi);
@@ -2061,6 +2061,9 @@ static int m_can_open(struct net_device *dev)
 
 	return 0;
 
+exit_start_fail:
+	if (cdev->is_peripheral || dev->irq)
+		free_irq(dev->irq, dev);
 exit_irq_fail:
 	if (cdev->is_peripheral)
 		destroy_workqueue(cdev->tx_wq);
-- 
2.45.2



