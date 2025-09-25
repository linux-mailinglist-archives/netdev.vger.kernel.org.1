Return-Path: <netdev+bounces-226332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9976B9F2BA
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0D33B76C4
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B2F30C347;
	Thu, 25 Sep 2025 12:14:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52480303A3C
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802453; cv=none; b=CCskdUuvRFY1y6cwZCQ3zKvfrh0XPG7fP/Ix2iNKWq9Ax26e4aIaZj0ig73vkyH8fNsoIFBvw/K6Ug6fkHkq6XuvS/zgUjVyacukHPvFzFJ39V3WPbIXzb212u8Qy5uwtxzWptvlXnr4mnsjT0UKZV7VWYqKjq/49Li7n8bwPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802453; c=relaxed/simple;
	bh=685rTr9nCcwREiR08zo1S98YrF4qAPSK0xbXtvhANGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kI43u9PVfS+6aMKMKTm2afgA9nIk1rI3FW89/ie2cxBWlud7z1sanMFw6bIc7RcvvnzlMMgocrgraCg7dLT/vO72n94wUnjukNadGZfQYVgbQFDrauFNuOwkD7ntq5+KDQrMxg8VMCigL/U6VXUQJqQgvFYo7IrT9VTdjye9MuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqu-0000Vm-Gv; Thu, 25 Sep 2025 14:13:36 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqt-000PvQ-2D;
	Thu, 25 Sep 2025 14:13:35 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6FF52479975;
	Thu, 25 Sep 2025 12:13:35 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 09/48] can: rcar_can: Consistently use ndev for net_device pointers
Date: Thu, 25 Sep 2025 14:07:46 +0200
Message-ID: <20250925121332.848157-10-mkl@pengutronix.de>
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

Most net_device pointers are named "ndev", but some are called "dev".
Increase uniformity by always using "ndev".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/aac66fb5b5e1d6787121cf2ec36b551b41d4b32e.1755857536.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 87c134bcd48d..5b0b495d127c 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -420,9 +420,9 @@ static irqreturn_t rcar_can_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void rcar_can_set_bittiming(struct net_device *dev)
+static void rcar_can_set_bittiming(struct net_device *ndev)
 {
-	struct rcar_can_priv *priv = netdev_priv(dev);
+	struct rcar_can_priv *priv = netdev_priv(ndev);
 	struct can_bittiming *bt = &priv->can.bittiming;
 	u32 bcr;
 
@@ -715,10 +715,10 @@ static int rcar_can_do_set_mode(struct net_device *ndev, enum can_mode mode)
 	}
 }
 
-static int rcar_can_get_berr_counter(const struct net_device *dev,
+static int rcar_can_get_berr_counter(const struct net_device *ndev,
 				     struct can_berr_counter *bec)
 {
-	struct rcar_can_priv *priv = netdev_priv(dev);
+	struct rcar_can_priv *priv = netdev_priv(ndev);
 	int err;
 
 	err = clk_prepare_enable(priv->clk);
-- 
2.51.0


