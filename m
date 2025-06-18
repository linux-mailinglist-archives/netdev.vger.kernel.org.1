Return-Path: <netdev+bounces-198947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE73ADE6BC
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE0C189A1C7
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D3B2853F2;
	Wed, 18 Jun 2025 09:23:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C77285062
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238628; cv=none; b=E+iPQfJSpTaZc6HDEFWXDJQng5d25UnWEi56Gj1YvesOLA7bMLgtTW2SN9mIAeK51W9i8dQ3w1BZyPfLdNT9qlWN4GBk4p27CeKBukNKGNW5nz4+GOJclop8fdgo1wpV7KQVH0PpOqfaaDiX5iCqpbBFe7khLYTe+Z4Ni0X2V2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238628; c=relaxed/simple;
	bh=KFAnoftvOfmuCOMKFcSuVx5aYirtA0FT5IpIuRgJ5zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMuuV/9jLM8tJ5HNiq3BLlAR7wv5aijI6m5gPRSdcCW8+qRtn0aVxlWG5xjy9IQtuCl83yAcbKoJYVLDhKptFGudoexYj2S2g2ndpeonXexkxVJYaVuuqlPo6dev6s0vyfhGA8jWpiv319kY/FtDBdv7+kffcUtrbm9yAAgmUJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1E-0006er-CF
	for netdev@vger.kernel.org; Wed, 18 Jun 2025 11:23:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1C-0047A3-35
	for netdev@vger.kernel.org;
	Wed, 18 Jun 2025 11:23:42 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A51FC42B2CB
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:23:42 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 8C9D542B283;
	Wed, 18 Jun 2025 09:23:39 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d73bd047;
	Wed, 18 Jun 2025 09:23:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 09/10] can: rcar_canfd: Return early in rcar_canfd_set_bittiming() when not FD
Date: Wed, 18 Jun 2025 11:20:03 +0200
Message-ID: <20250618092336.2175168-10-mkl@pengutronix.de>
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

Return early after completing all setup for non-FD mode in
rcar_canfd_set_bittiming(), to prepare for the advent of more FD-only
setup.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/35fcdcad026cfdd0fd361637f065842d99a6c19d.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 9ee49ef57e4f..3340ae75bbec 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1484,18 +1484,19 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 
 	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
-		/* Data bit timing settings */
-		brp = dbt->brp - 1;
-		sjw = dbt->sjw - 1;
-		tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
-		tseg2 = dbt->phase_seg2 - 1;
+	if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD))
+		return;
 
-		cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
-		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
+	/* Data bit timing settings */
+	brp = dbt->brp - 1;
+	sjw = dbt->sjw - 1;
+	tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
+	tseg2 = dbt->phase_seg2 - 1;
 
-		rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
-	}
+	cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
+	       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
+
+	rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
 }
 
 static int rcar_canfd_start(struct net_device *ndev)
-- 
2.47.2



