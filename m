Return-Path: <netdev+bounces-225848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A38DB98D42
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39DC4C434E
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AA828B415;
	Wed, 24 Sep 2025 08:21:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC33285C84
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702110; cv=none; b=aENO0pGg9sVJwMmUXNHQhBm544UmTXPQQDbvFOMXxe3qzOjlpQ6rKMOK7lnE1NKO0CaOvDgBaJNHIa2kLsiMRfotYGeLFn95hPHh9VahahA4wTyhuzKNHDuZ8GLu7FW4oAlv9qYgZYoKsnBoteNEfv0cJTtiXXJMCdjC4smJiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702110; c=relaxed/simple;
	bh=3LvWzrpx/vafRuQvjuDqxKt00A0XYzlQWhBOfraj9o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iywY5zYBHvcu7cBRlaRXYGKDB9gWC2/dHrtL/sAKscuhBbvnGZRp0pogwTbCFHrzqN+XGyKrP2L5N4LLSkfQqgrTpalbUmf6iL7geI1o+NeIGAl+I5ysWVTkBE87Lovm6C4+wyhOBEgMotMzPDalDRrlv8dVh+IR6FaJwmssB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kki-0001E7-2f; Wed, 24 Sep 2025 10:21:28 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkc-000DvY-1Z;
	Wed, 24 Sep 2025 10:21:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3F79E47886E;
	Wed, 24 Sep 2025 08:21:07 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 06/48] can: rcar_canfd: Update RCANFD_CFG_* macros
Date: Wed, 24 Sep 2025 10:06:23 +0200
Message-ID: <20250924082104.595459-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Update RCANFD_CFG_* macros to give a meaning to the magic number using
GENMASK macro and extract the values using FIELD_PREP macro.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250908120940.147196-3-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 4185fc5b4a70..8d0d0825cb54 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -103,10 +103,10 @@
 /* Channel register bits */
 
 /* RSCFDnCmCFG - Classical CAN only */
-#define RCANFD_CFG_SJW(x)		(((x) & 0x3) << 24)
-#define RCANFD_CFG_TSEG2(x)		(((x) & 0x7) << 20)
-#define RCANFD_CFG_TSEG1(x)		(((x) & 0xf) << 16)
-#define RCANFD_CFG_BRP(x)		(((x) & 0x3ff) << 0)
+#define RCANFD_CFG_SJW		GENMASK(25, 24)
+#define RCANFD_CFG_TSEG2	GENMASK(22, 20)
+#define RCANFD_CFG_TSEG1	GENMASK(19, 16)
+#define RCANFD_CFG_BRP		GENMASK(9, 0)
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
@@ -1411,8 +1411,8 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) | RCANFD_NCFG_NBRP(brp) |
 		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
 	} else {
-		cfg = (RCANFD_CFG_TSEG1(tseg1) | RCANFD_CFG_BRP(brp) |
-		       RCANFD_CFG_SJW(sjw) | RCANFD_CFG_TSEG2(tseg2));
+		cfg = FIELD_PREP(RCANFD_CFG_TSEG1, tseg1) | FIELD_PREP(RCANFD_CFG_BRP, brp) |
+		      FIELD_PREP(RCANFD_CFG_SJW, sjw) | FIELD_PREP(RCANFD_CFG_TSEG2, tseg2);
 	}
 
 	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
-- 
2.51.0


