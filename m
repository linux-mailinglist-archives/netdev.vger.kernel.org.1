Return-Path: <netdev+bounces-230512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866A8BE9D50
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3381741B62
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 15:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4EC32C958;
	Fri, 17 Oct 2025 15:08:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCB3335083
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713723; cv=none; b=dTHOfL3Kh1MxxmAnIWIoHayNicCnUTq5aIzVx2y9UAxssdYcm7JYI/tGouvj/Tj2tdeKTvmIuZPiqGRcD7onSgaKovLu5QuIY89HtdfPBjfYVt/SyaWPrIMh6XIEKC74NNLkkuXroG5BD/n/5LKHEdO8aLxyVVVpJdV7hTubGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713723; c=relaxed/simple;
	bh=00lX3KxheJmvycyETGuhxv1nGFgDIT7ZRPW1cFwcATM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e43hjEyxW+ehlDaDmLVcNNcAWeknFYXS4jQxHL9Q2ZRfbIH/m2fXQ92xlY68eVLme1/WesAEBByCyysYEVaQv0+Z7uxdhbT3q5wHzHUsnjIat1/SgVbVIasFAKou7ga6Uc/7EAvLCx/LYndoB40En+135mc7CmV8CtgcvMUJplI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4E-0003OL-Jv; Fri, 17 Oct 2025 17:08:30 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4E-004510-0W;
	Fri, 17 Oct 2025 17:08:30 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E2ACB4892BE;
	Fri, 17 Oct 2025 15:08:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH net-next 13/13] can: m_can: m_can_get_berr_counter(): don't wake up controller if interface is down
Date: Fri, 17 Oct 2025 17:04:21 +0200
Message-ID: <20251017150819.1415685-14-mkl@pengutronix.de>
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

If the interface is down, the CAN controller might be powered down, the
clock disabled, and/or it's external reset asserted.

Don't wake up the controller to read the CAN bus error counters, if the
interface is down.

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://patch.msgid.link/20251008-m_can-cleanups-v1-7-1784a18eaa84@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 713d3df296df..eb856547ae7d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -791,6 +791,10 @@ static int m_can_get_berr_counter(const struct net_device *dev,
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	int err;
 
+	/* Avoid waking up the controller if the interface is down */
+	if (!(dev->flags & IFF_UP))
+		return 0;
+
 	err = m_can_clk_start(cdev);
 	if (err)
 		return err;
-- 
2.51.0


