Return-Path: <netdev+bounces-192594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 309D1AC0770
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABA51BC4109
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B085E28936F;
	Thu, 22 May 2025 08:41:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD32288C21
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903307; cv=none; b=hI/1BcI+/BGoNrTZlkwRS2k74oyTLZPJciLIR5scs6enkBrpgi64VyqkRlifbeZ9WRhw9Ou4rTOimrSyLvaiehJAg2YnAlwvqUyyxyAp4Kh9XUfZdHPqV11dys7ncALitwXmCTtPeT668KtwbAWz3BQeiJMcK3K7p4BYty68CrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903307; c=relaxed/simple;
	bh=aqmEdjwH4iTaeQJpjSk66P9wmj/gw+ZvQ4EktPg24Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgZ2UiV5DT+FdbdFCmyqv1FMGYLJctQXwX/zdmixEQtvOcbhbd6cbbMpgEvENLdrvu6W8/MPPvd20/QIP1DR8h0VNfm7bq3l16mLUQ5jQKN6I2vCGgsdX2Fi6qxA5o0H8Ivvx5tlGpFXDssQ6jdEzC5KeGQho/bjo7XsqIpcPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Uk-0006C8-IL
	for netdev@vger.kernel.org; Thu, 22 May 2025 10:41:42 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Ug-000hnC-2z
	for netdev@vger.kernel.org;
	Thu, 22 May 2025 10:41:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8BC70417328
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:41:38 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 2FF404172E9;
	Thu, 22 May 2025 08:41:36 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f421c753;
	Thu, 22 May 2025 08:41:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/22] can: rcar_canfd: Add max_cftml variable to struct rcar_canfd_hw_info
Date: Thu, 22 May 2025 10:36:39 +0200
Message-ID: <20250522084128.501049-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522084128.501049-1-mkl@pengutronix.de>
References: <20250522084128.501049-1-mkl@pengutronix.de>
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

R-Car Gen3 has CFTML max positional value is 15 whereas on R-Car Gen4 it
is 31. Add a max_cftml variable to struct rcar_canfd_hw_info to handle
this difference.

While at it, rename the parameter x->cftml in RCANFD_CFCC_CFTML macro to
make it clear.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-12-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 322d72df10ed..5465fa897223 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -225,8 +225,11 @@
 /* Common FIFO bits */
 
 /* RSCFDnCFDCFCCk */
-#define RCANFD_CFCC_CFTML(gpriv, x)	\
-	(((x) & reg_gen4(gpriv, 0x1f, 0xf)) << reg_gen4(gpriv, 16, 20))
+#define RCANFD_CFCC_CFTML(gpriv, cftml) \
+({\
+	typeof(gpriv) (_gpriv) = (gpriv); \
+	(((cftml) & (_gpriv)->info->max_cftml) << reg_gen4(_gpriv, 16, 20)); \
+})
 #define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
 #define RCANFD_CFCC_CFIM		BIT(12)
 #define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
@@ -505,6 +508,7 @@ struct rcar_canfd_global;
 struct rcar_canfd_hw_info {
 	u8 rnc_field_width;
 	u8 max_aflpn;
+	u8 max_cftml;
 	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
@@ -583,6 +587,7 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
+	.max_cftml = 15,
 	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -591,6 +596,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.rnc_field_width = 16,
 	.max_aflpn = 127,
+	.max_cftml = 31,
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -599,6 +605,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
+	.max_cftml = 15,
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
-- 
2.47.2



