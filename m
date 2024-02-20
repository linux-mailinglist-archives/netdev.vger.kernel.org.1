Return-Path: <netdev+bounces-73208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DC185B5E8
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 09:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47B8B24FBD
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525625FBB6;
	Tue, 20 Feb 2024 08:51:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728D95F542
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419099; cv=none; b=cEWRMwfIO3hv0vpuk4MBaGCTzy1NWk0t3di1tHpjgJXd/TYAV+T72pmVmcFTsbGXafupVwlj5LPv2aPOL5sfCLp0ArXx0CavNqyjZDxZGTtrBVfl4VAYxooz+3+0Z0GMilGAiBh/azkhISk0fziFBi2NlVRBIHTTuF24jjnIEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419099; c=relaxed/simple;
	bh=XN7RmwhLW5sBzka0ipJ+2g5qwyh4VieVA2e5oVPHZho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAkr6gJgseuZ0pNdDkivASvb73GlGWcrzXg+Ci+AC1FyPNrXR3ajcbvwDtuTwIJlLFux/Iz/Vh8B+jBwTQASRFwk+fCmYAMSXbJSyxYvAZXiqcy5xPJycxtS53THTBUjYeAmrYi3CozouHG72168O1cVBs9meVRoNsk86+BSjQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqh-0001cW-JP
	for netdev@vger.kernel.org; Tue, 20 Feb 2024 09:51:35 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqg-001oEB-8B
	for netdev@vger.kernel.org; Tue, 20 Feb 2024 09:51:34 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id EAED9292F05
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 08:51:33 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 06A2C292EDB;
	Tue, 20 Feb 2024 08:51:32 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3a942b66;
	Tue, 20 Feb 2024 08:51:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 1/9] can: m_can: remove redundant check for pm_clock_support
Date: Tue, 20 Feb 2024 09:46:03 +0100
Message-ID: <20240220085130.2936533-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220085130.2936533-1-mkl@pengutronix.de>
References: <20240220085130.2936533-1-mkl@pengutronix.de>
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

m_can_clk_start() already skip starting the clock when
clock support is disabled, remove the redundant check in
m_can_class_register().

This also solves the imbalance with m_can_clk_stop() that is called
afterward in the same function before the return.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://lore.kernel.org/all/20240104235723.46931-1-francesco@dolcini.it
[mkl: rebased to net-next/main]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index b7dbce4c342a..290880ce5329 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2312,11 +2312,9 @@ int m_can_class_register(struct m_can_classdev *cdev)
 		}
 	}
 
-	if (cdev->pm_clock_support) {
-		ret = m_can_clk_start(cdev);
-		if (ret)
-			return ret;
-	}
+	ret = m_can_clk_start(cdev);
+	if (ret)
+		return ret;
 
 	if (cdev->is_peripheral) {
 		ret = can_rx_offload_add_manual(cdev->net, &cdev->offload,

base-commit: e1a00373e1305578cd09526aa056940409e6b877
-- 
2.43.0



