Return-Path: <netdev+bounces-225504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E21B94D60
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E62119036C8
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 07:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34AB319870;
	Tue, 23 Sep 2025 07:43:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10006318151
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613382; cv=none; b=kpezN+94YmjwO2/W5jKNdzZhUq298gDp4R835nlJsdX5qqo6aw1Ne1yv+FV7r7qjEDhDQ9/5GsTxE5YIX9ZCXC9vqW/O03INr+xXnwtUi/x3IKR00EOho6M0T6zvXW10wEbdpQaJtNcAyJEahj/sDgvgRmCe5yoNPiy6zfN4MH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613382; c=relaxed/simple;
	bh=1EoobT2+Dzml2fjU142cQZpj8fDvHuvbhqFud8I75Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZqRN1ePdoaJ2+6+57TQE64fu8dLtUfW0dbTSzoQVCMvju7YeC/tLcBN7haGwV0DUh8Tj4nuMbqHLyS75KnsIznx8Zsem/L6wmfHNc2PLNORErjsIoeF1Ha5LghM8GveUY/SGwxob1GsXQUEiGmbQFQHPD7sPiPkaDPyBDnDPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0xfh-0003cm-4X; Tue, 23 Sep 2025 09:42:45 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0xfg-0003Ng-0C;
	Tue, 23 Sep 2025 09:42:44 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id ACE74477A86;
	Tue, 23 Sep 2025 07:34:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Tranh Ha <tranh.ha.xb@renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/7] can: rcar_canfd: Fix controller mode setting
Date: Tue, 23 Sep 2025 09:32:48 +0200
Message-ID: <20250923073427.493034-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923073427.493034-1-mkl@pengutronix.de>
References: <20250923073427.493034-1-mkl@pengutronix.de>
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

From: Duy Nguyen <duy.nguyen.rh@renesas.com>

Driver configures register to choose controller mode before
setting all channels to reset mode leading to failure.
The patch corrects operation of mode setting.

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Signed-off-by: Tranh Ha <tranh.ha.xb@renesas.com>
Link: https://patch.msgid.link/TYWPR01MB87434739F83E27EDCD23DF44B416A@TYWPR01MB8743.jpnprd01.prod.outlook.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index b3c8c592fb0e..7e8b1d2f1af6 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -823,9 +823,6 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	/* Reset Global error flags */
 	rcar_canfd_write(gpriv->base, RCANFD_GERFL, 0x0);
 
-	/* Set the controller into appropriate mode */
-	rcar_canfd_set_mode(gpriv);
-
 	/* Transition all Channels to reset mode */
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_clear_bit(gpriv->base,
@@ -844,6 +841,10 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 			return err;
 		}
 	}
+
+	/* Set the controller into appropriate mode */
+	rcar_canfd_set_mode(gpriv);
+
 	return 0;
 }
 
-- 
2.51.0


