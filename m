Return-Path: <netdev+bounces-198944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1133BADE6B8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDDE17A484
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F267284B56;
	Wed, 18 Jun 2025 09:23:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6428314B
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238625; cv=none; b=fMIJHPev+MQGY+Etaivh6YRqOviqJzGgrEmcjJlMHVOiRI1w3ZITKd3HRN5F2A1CRArt7hj3KCUpMS7XkZsS6/nj7iNoSPp+Of0UUV3AS0PxxjjrVgiXaP9LBescL6Nvaxima5WAQ/1dSpxn7oG9WPqHO467QnZeSh1GGKo+TKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238625; c=relaxed/simple;
	bh=6hwn/6BREO5au1JmUC90LAfXNuf6n/snehSm0zyyp+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owuY+ZOiqPkD4w8ZQR6xM6d8fbyCprJp7eU6OUxZ1kYKQLp1pWQ37+T0cYJjMLVJM4LHDbkLFuxbRPoQgbivBXQJN/s3MrD6LYLM0p50saF9Dt44YgoMo9JEfcYm/8Dqoq7hEe/T0WtNdmogNy+X3fx1zSx+sjsGk0h+7rgbOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1B-0006Z2-V0
	for netdev@vger.kernel.org; Wed, 18 Jun 2025 11:23:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1B-00477X-0X
	for netdev@vger.kernel.org;
	Wed, 18 Jun 2025 11:23:41 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id CF06442B2A1
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:23:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 13AA742B275;
	Wed, 18 Jun 2025 09:23:39 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bee6578c;
	Wed, 18 Jun 2025 09:23:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/10] can: rcar_canfd: Add helper variable dev to rcar_canfd_reset_controller()
Date: Wed, 18 Jun 2025 11:19:58 +0200
Message-ID: <20250618092336.2175168-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250618092336.2175168-1-mkl@pengutronix.de>
References: <20250618092336.2175168-1-mkl@pengutronix.de>
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

rcar_canfd_reset_controller() has many users of "pdev->dev".  Introduce
a shorthand to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/21e64816808eb3eba722f4c547f4f5112d5d62a6.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index ddf3b91d3d2b..3244584a6ee5 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -841,6 +841,7 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 
 static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 {
+	struct device *dev = &gpriv->pdev->dev;
 	u32 sts, ch;
 	int err;
 
@@ -850,7 +851,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
 				 !(sts & RCANFD_GSTS_GRAMINIT), 2, 500000);
 	if (err) {
-		dev_dbg(&gpriv->pdev->dev, "global raminit failed\n");
+		dev_dbg(dev, "global raminit failed\n");
 		return err;
 	}
 
@@ -863,7 +864,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
 				 (sts & RCANFD_GSTS_GRSTSTS), 2, 500000);
 	if (err) {
-		dev_dbg(&gpriv->pdev->dev, "global reset failed\n");
+		dev_dbg(dev, "global reset failed\n");
 		return err;
 	}
 
@@ -887,8 +888,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 					 (sts & RCANFD_CSTS_CRSTSTS),
 					 2, 500000);
 		if (err) {
-			dev_dbg(&gpriv->pdev->dev,
-				"channel %u reset failed\n", ch);
+			dev_dbg(dev, "channel %u reset failed\n", ch);
 			return err;
 		}
 	}
-- 
2.47.2



