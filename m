Return-Path: <netdev+bounces-124969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0170996B753
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 734E3B222D8
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9011CF5F2;
	Wed,  4 Sep 2024 09:43:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF63D185B41
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443013; cv=none; b=jYLZwVKBeHA2Qr59rR4uuLr5Ed4zybm7P9WoIk9YU9jaqCP3RhM9kmmZGlewY9gRpqOBfzcWdAFbJ0wr8ZWtRrSinaBWgU41QOgBsu6Ib5GRrm4SX+ZwsKaTbwpfgv4znIgroXXBRpqJiUBJRaBExbNgkDqA096hXbZGaslwazM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443013; c=relaxed/simple;
	bh=PX9Ihc+hD7X7fZMbf5YbTvu6KSR9yCl8wp2g0J7CeJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyiRn/CvrslQahd8odSmFQQ4buIGS/7X8aCaRijLGFRiHWuNwqfy3Ze7lNtuZvOwmu7usXqkf+TLxvI6xx8wgiJAx44v8U3uVMPaX4FipmGd9ViAMO0YxZka0gxXrOS4w+XGp48KeDAyQ2pM4f8L+Vkzru3fyklz9fgtk/vr5hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmXy-0005t7-Ev
	for netdev@vger.kernel.org; Wed, 04 Sep 2024 11:43:30 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmXx-005QFN-VH
	for netdev@vger.kernel.org; Wed, 04 Sep 2024 11:43:30 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 584D43323E6
	for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 09:42:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id BCD72332365;
	Wed, 04 Sep 2024 09:42:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 15f734a4;
	Wed, 4 Sep 2024 09:42:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alibek Omarov <a1ba.omarov@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH net-next 09/20] can: rockchip_canfd: rkcanfd_handle_rx_int_one(): implement workaround for erratum 5: check for empty FIFO
Date: Wed,  4 Sep 2024 11:38:44 +0200
Message-ID: <20240904094218.1925386-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904094218.1925386-1-mkl@pengutronix.de>
References: <20240904094218.1925386-1-mkl@pengutronix.de>
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

The rk3568 CAN-FD errata sheet as of Tue 07 Nov 2023 11:25:31 +08:00
says:

| Erratum 5: Counters related to the TXFIFO and RXFIFO exhibit
| abnormal counting behavior.
|
| Due to a bug in the cross-asynchronous logic of the enable signals
| for rx_fifo_cnt and txe_fifo_frame_cnt counters, the counts of these
| two counters become inaccurate. This issue has resulted in the
| inability to use the TXFIFO and RXFIFO functions.

The errata sheet mentioned above states that only the rk3568v2 is
affected by this erratum, but tests with the rk3568v2 and rk3568v3
show that the RX_FIFO_CNT is sometimes too high. This leads to CAN
frames being read from the FIFO, which is then already empty.

Further tests on the rk3568v2 and rk3568v3 show that in this
situation (i.e. empty FIFO) all elements of the FIFO
header (frameinfo, id, ts) contain the same data.

On the rk3568v2 and rk3568v3, this problem only occurs extremely
rarely with the standard clock of 300 MHz, but almost immediately at
80 MHz.

To workaround this problem, check for empty FIFO with
rkcanfd_fifo_header_empty() in rkcanfd_handle_rx_int_one() and exit
early.

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20240904-rockchip-canfd-v5-9-8ae22bcb27cc@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-rx.c | 14 +++++++++++++
 drivers/net/can/rockchip/rockchip_canfd.h    | 22 ++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 5398aff0d180..609282359bca 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -47,6 +47,16 @@ rkcanfd_fifo_header_to_cfd_header(const struct rkcanfd_priv *priv,
 	return len + cfd->len;
 }
 
+static inline bool
+rkcanfd_fifo_header_empty(const struct rkcanfd_fifo_header *header)
+{
+	/* Erratum 5: If the FIFO is empty, we read the same value for
+	 * all elements.
+	 */
+	return header->frameinfo == header->id &&
+		header->frameinfo == header->ts;
+}
+
 static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
@@ -63,6 +73,10 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 	rkcanfd_read_rep(priv, RKCANFD_REG_RX_FIFO_RDATA,
 			 cfd->data, sizeof(cfd->data));
 
+	/* Erratum 5: Counters for TXEFIFO and RXFIFO may be wrong */
+	if (rkcanfd_fifo_header_empty(header))
+		return 0;
+
 	len = rkcanfd_fifo_header_to_cfd_header(priv, header, cfd);
 
 	/* Drop any received CAN-FD frames if CAN-FD mode is not
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 3dafb5e68dc5..c775e75a2740 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -315,6 +315,28 @@
 
 /* Erratum 5: Counters related to the TXFIFO and RXFIFO exhibit
  * abnormal counting behavior.
+ *
+ * The rk3568 CAN-FD errata sheet as of Tue 07 Nov 2023 11:25:31 +08:00
+ * states that only the rk3568v2 is affected by this erratum, but
+ * tests with the rk3568v2 and rk3568v3 show that the RX_FIFO_CNT is
+ * sometimes too high. This leads to CAN frames being read from the
+ * FIFO, which is then already empty.
+ *
+ * Further tests on the rk3568v2 and rk3568v3 show that in this
+ * situation (i.e. empty FIFO) all elements of the FIFO header
+ * (frameinfo, id, ts) contain the same data.
+ *
+ * On the rk3568v2 and rk3568v3, this problem only occurs extremely
+ * rarely with the standard clock of 300 MHz, but almost immediately
+ * at 80 MHz.
+ *
+ * To workaround this problem, check for empty FIFO with
+ * rkcanfd_fifo_header_empty() in rkcanfd_handle_rx_int_one() and exit
+ * early.
+ *
+ * To reproduce:
+ * assigned-clocks = <&cru CLK_CANx>;
+ * assigned-clock-rates = <80000000>;
  */
 #define RKCANFD_QUIRK_RK3568_ERRATUM_5 BIT(4)
 
-- 
2.45.2



