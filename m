Return-Path: <netdev+bounces-38412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679107BAB26
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 425E9282D34
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CC74448E;
	Thu,  5 Oct 2023 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF243688
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EA2FA
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 12:58:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUM-0004tm-SO
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:26 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUI-00BLOy-4e
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:22 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D32A523008A
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 63B7623000C;
	Thu,  5 Oct 2023 19:58:18 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1f4cf061;
	Thu, 5 Oct 2023 19:58:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 36/37] can: at91_can: at91_alloc_can_err_skb() introduce new function
Date: Thu,  5 Oct 2023 21:58:11 +0200
Message-Id: <20231005195812.549776-37-mkl@pengutronix.de>
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

This is a preparation patch to convert the driver to make use of the
rx-offload helper. With rx-offload the received CAN frames are sorted
by their timestamp. Regular CAN RX'ed and TX'ed CAN frames are
timestamped by the hardware. Error events are not.

Introduce a new function at91_alloc_can_err_skb() the allocates an
error SKB and reads the current timestamp from the controller.

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-26-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index d5e1d1b2cdd1..ca62aa027e5f 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -576,6 +576,22 @@ static inline void at91_activate_rx_mb(const struct at91_priv *priv,
 	at91_write(priv, AT91_TCR, mask);
 }
 
+static inline u32 at91_get_timestamp(const struct at91_priv *priv)
+{
+	return at91_read(priv, AT91_TIM);
+}
+
+static inline struct sk_buff *
+at91_alloc_can_err_skb(struct net_device *dev,
+		       struct can_frame **cf, u32 *timestamp)
+{
+	const struct at91_priv *priv = netdev_priv(dev);
+
+	*timestamp = at91_get_timestamp(priv);
+
+	return alloc_can_err_skb(dev, cf);
+}
+
 /**
  * at91_rx_overflow_err - send error frame due to rx overflow
  * @dev: net device
-- 
2.40.1



