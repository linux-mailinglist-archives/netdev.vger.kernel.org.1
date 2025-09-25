Return-Path: <netdev+bounces-226340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E58CB9F2CB
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CDC17796E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7413126BA;
	Thu, 25 Sep 2025 12:14:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2403002D6
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802454; cv=none; b=LK28wGvqQx94DXIsEuXt21jxi/Aa2LejSq0rZzQjklcBzVZvcbC+idTt0b/+fIZcRjpgn+OMLM5tzudQzYqokxBNgMZ1g53wI0y60Ax0qXeLb6DMnoa5LERJlCDPfIPjn4CCNLfPNecyRbccvu9w/gvmTXOn4FBCmInLERouJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802454; c=relaxed/simple;
	bh=CkIj3HLmKf5jbUZiyRR0DSk//7gm34O50sX2+Lqsmvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTUFbAx4OVy3oMi8ftoyKL6SaEG/YUioQojNDmrFo8NBlyCSDJ5P642Ke8Gcqi+8Hr3jn7rU4loxKwjapnCbT3PSN0WK6ZHW24Qc4DoLTBX7nhdhK7Gu8Ub9dqk5m9+izCsc7EAian8hwGPOJw/K1sK87ejtgOUCEEBi+mxWCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqw-0000YN-KS; Thu, 25 Sep 2025 14:13:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqv-000Pwj-0N;
	Thu, 25 Sep 2025 14:13:37 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D5CC147998A;
	Thu, 25 Sep 2025 12:13:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 30/48] can: dev: make can_get_relative_tdco() FD agnostic and move it to bittiming.h
Date: Thu, 25 Sep 2025 14:08:07 +0200
Message-ID: <20250925121332.848157-31-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol@kernel.org>

can_get_relative_tdco() needs to access can_priv->fd making it
specific to CAN FD. Change the function parameter from struct can_priv
to struct data_bittiming_params. This way, the function becomes CAN FD
agnostic and can be reused later on for the CAN XL TDC.

Now that we dropped the dependency on struct can_priv, also move
can_get_relative_tdco() back to bittiming.h where it was meant to
belong to.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-2-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/bittiming.h | 29 +++++++++++++++++++++++++++++
 include/linux/can/dev.h       | 29 -----------------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 6572ec1712ca..4d5f7794194a 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -160,6 +160,35 @@ int can_get_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		      const unsigned int bitrate_const_cnt,
 		      struct netlink_ext_ack *extack);
 
+/*
+ * can_get_relative_tdco() - TDCO relative to the sample point
+ *
+ * struct can_tdc::tdco represents the absolute offset from TDCV. Some
+ * controllers use instead an offset relative to the Sample Point (SP)
+ * such that:
+ *
+ * SSP = TDCV + absolute TDCO
+ *     = TDCV + SP + relative TDCO
+ *
+ * -+----------- one bit ----------+-- TX pin
+ *  |<--- Sample Point --->|
+ *
+ *                         --+----------- one bit ----------+-- RX pin
+ *  |<-------- TDCV -------->|
+ *                           |<------------------------>| absolute TDCO
+ *                           |<--- Sample Point --->|
+ *                           |                      |<->| relative TDCO
+ *  |<------------- Secondary Sample Point ------------>|
+ */
+static inline s32 can_get_relative_tdco(const struct data_bittiming_params *dbt_params)
+{
+	const struct can_bittiming *dbt = &dbt_params->data_bittiming;
+	s32 sample_point_in_tc = (CAN_SYNC_SEG + dbt->prop_seg +
+				  dbt->phase_seg1) * dbt->brp;
+
+	return (s32)dbt_params->tdc.tdco - sample_point_in_tc;
+}
+
 /*
  * can_bit_time() - Duration of one bit
  *
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index c2fe956ab776..8e75e9b3830a 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -85,35 +85,6 @@ static inline bool can_fd_tdc_is_enabled(const struct can_priv *priv)
 	return !!(priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 }
 
-/*
- * can_get_relative_tdco() - TDCO relative to the sample point
- *
- * struct can_tdc::tdco represents the absolute offset from TDCV. Some
- * controllers use instead an offset relative to the Sample Point (SP)
- * such that:
- *
- * SSP = TDCV + absolute TDCO
- *     = TDCV + SP + relative TDCO
- *
- * -+----------- one bit ----------+-- TX pin
- *  |<--- Sample Point --->|
- *
- *                         --+----------- one bit ----------+-- RX pin
- *  |<-------- TDCV -------->|
- *                           |<------------------------>| absolute TDCO
- *                           |<--- Sample Point --->|
- *                           |                      |<->| relative TDCO
- *  |<------------- Secondary Sample Point ------------>|
- */
-static inline s32 can_get_relative_tdco(const struct can_priv *priv)
-{
-	const struct can_bittiming *dbt = &priv->fd.data_bittiming;
-	s32 sample_point_in_tc = (CAN_SYNC_SEG + dbt->prop_seg +
-				  dbt->phase_seg1) * dbt->brp;
-
-	return (s32)priv->fd.tdc.tdco - sample_point_in_tc;
-}
-
 static inline u32 can_get_static_ctrlmode(struct can_priv *priv)
 {
 	return priv->ctrlmode & ~priv->ctrlmode_supported;
-- 
2.51.0


