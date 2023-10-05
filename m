Return-Path: <netdev+bounces-38393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A337BAAF6
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AC449282681
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9980643682;
	Thu,  5 Oct 2023 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2F842BEB
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD41CF0
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 12:58:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUK-0004pU-Qj
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:24 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUG-00BLKt-34
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0B03923003A
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 24E2F22FF98;
	Thu,  5 Oct 2023 19:58:16 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 973babda;
	Thu, 5 Oct 2023 19:58:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 18/37] can: at91_can: MSR Register: convert to FIELD_PREP()
Date: Thu,  5 Oct 2023 21:57:53 +0200
Message-Id: <20231005195812.549776-19-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231005195812.549776-1-mkl@pengutronix.de>
References: <20231005195812.549776-1-mkl@pengutronix.de>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use FIELD_PREP() to access the individual fields of the MSR register.

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-8-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index ec028fe833f0..41dd2ea239b9 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -83,6 +83,8 @@ enum at91_reg {
 #define AT91_MID_MIDVA_MASK GENMASK(28, 18)
 #define AT91_MID_MIDE BIT(29)
 
+#define AT91_MSR_MTIMESTAMP_MASK GENMASK(15, 0)
+#define AT91_MSR_MDLC_MASK GENMASK(19, 16)
 #define AT91_MSR_MRTR BIT(20)
 #define AT91_MSR_MABT BIT(22)
 #define AT91_MSR_MRDY BIT(23)
@@ -599,7 +601,7 @@ static void at91_read_mb(struct net_device *dev, unsigned int mb,
 		cf->can_id = FIELD_GET(AT91_MID_MIDVA_MASK, reg_mid);
 
 	reg_msr = at91_read(priv, AT91_MSR(mb));
-	cf->len = can_cc_dlc2len((reg_msr >> 16) & 0xf);
+	cf->len = can_cc_dlc2len(FIELD_GET(AT91_MSR_MDLC_MASK, reg_msr));
 
 	if (reg_msr & AT91_MSR_MRTR) {
 		cf->can_id |= CAN_RTR_FLAG;
-- 
2.40.1



