Return-Path: <netdev+bounces-106174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF029150B0
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4856D1F2313D
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F3A19DF77;
	Mon, 24 Jun 2024 14:45:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FBC19B3FD
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240351; cv=none; b=KxDVvI/g8Lwr6+Cgua25FsdUevb7uLeVfKQnBnF/BcsBN3L57StTo1UVHe1vFhwFU53zY2ajoMMojVbXBUgNRjkMkiL1kEzlj+5CUoBjY/cy3WnWluchoGyR2e2GkyvdvyDJr4HDlyNguprgaZpXNEdkjWHFtXL0AEmOJz1vDAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240351; c=relaxed/simple;
	bh=y4YMfF2UpMjx5Ir6P7k8Z/XygCqQWFGYcq5Dd8e1Vv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kHqRn9OVTQvbf36jXBP5/OGC2R8VuiS5iXjZ4d/YN5EzLOPjdYq3oTODLHbnnvFFiMb60PR7y4KO4iPCbbAo/TxczrWQf0NXL8HL348Kt9khGq1EdSZuRjSyWPE0TkgZd66Q9P+OOcElXk4LxOBrAZUGm5jepPmAVolY3QcGHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sLkx1-0002zo-68
	for netdev@vger.kernel.org; Mon, 24 Jun 2024 16:45:47 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sLkwy-004fqV-MB
	for netdev@vger.kernel.org; Mon, 24 Jun 2024 16:45:44 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5B6EE2F1A8C
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:45:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 294772F1A06;
	Mon, 24 Jun 2024 14:45:38 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 23a124fc;
	Mon, 24 Jun 2024 14:45:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 24 Jun 2024 16:45:09 +0200
Subject: [PATCH v3 5/9] can: mcp251xfd: mcp251xfd_handle_rxif_ring_uinc():
 factor out in separate function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240624-mcp251xfd-workaround-erratum-6-v3-5-caf7e5f27f60@pengutronix.de>
References: <20240624-mcp251xfd-workaround-erratum-6-v3-0-caf7e5f27f60@pengutronix.de>
In-Reply-To: <20240624-mcp251xfd-workaround-erratum-6-v3-0-caf7e5f27f60@pengutronix.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 =?utf-8?q?Stefan_Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>, 
 kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=2710; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=y4YMfF2UpMjx5Ir6P7k8Z/XygCqQWFGYcq5Dd8e1Vv4=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmeYaJJYxLnM+GqvP97euvl6f4no9sm6LOtWbuh
 CX0MuL6/beJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZnmGiQAKCRAoOKI+ei28
 b7jYCACKtH/+LVNgcuNT6g2qMDh/9Qnk3ugLr8y0Hj9Ufa5oo3ipARBpNFrDQqFl+FblJPZjNSG
 FAkojiHXHYOE0jjSiOeNAIAKzrjgvhuFGY5s2wiYIz2NQhiJzL/WaRO7RtguqVqeS+hzdcteFzs
 EL27a+dTkuR/z+76KZmXVIUxmvmVqjHLssEQgqHr2i7FencXAH8jZdCTpp7NiMLDN5RzAnQphEi
 yhCtR4WWG5jbqblGpbfJxoxobC+fRjevR88oGlaEpKtF5tKgfzqqy0Mq6NKoSHmOGMeqnbP6YMx
 hJt9TM3UUdQFjrRhX0kcHu7h9VutaVsslJV27ZnlGORNH8b1
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

This is a preparation patch.

Sending the UINC messages followed by incrementing the tail pointer
will be called in more than one place in upcoming patches, so factor
this out into a separate function.

Also make mcp251xfd_handle_rxif_ring_uinc() safe to be called with a
"len" of 0.

Tested-by: Stefan Althöfer <Stefan.Althoefer@janztec.com>
Tested-by: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c | 48 ++++++++++++++++++----------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
index 6d66b97709b8..2c2b057b7ac7 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
@@ -197,6 +197,37 @@ mcp251xfd_rx_obj_read(const struct mcp251xfd_priv *priv,
 	return err;
 }
 
+static int
+mcp251xfd_handle_rxif_ring_uinc(const struct mcp251xfd_priv *priv,
+				struct mcp251xfd_rx_ring *ring,
+				u8 len)
+{
+	int offset;
+	int err;
+
+	if (!len)
+		return 0;
+
+	/* Increment the RX FIFO tail pointer 'len' times in a
+	 * single SPI message.
+	 *
+	 * Note:
+	 * Calculate offset, so that the SPI transfer ends on
+	 * the last message of the uinc_xfer array, which has
+	 * "cs_change == 0", to properly deactivate the chip
+	 * select.
+	 */
+	offset = ARRAY_SIZE(ring->uinc_xfer) - len;
+	err = spi_sync_transfer(priv->spi,
+				ring->uinc_xfer + offset, len);
+	if (err)
+		return err;
+
+	ring->tail += len;
+
+	return 0;
+}
+
 static int
 mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
 			   struct mcp251xfd_rx_ring *ring)
@@ -210,8 +241,6 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
 		return err;
 
 	while ((len = mcp251xfd_get_rx_linear_len(ring))) {
-		int offset;
-
 		rx_tail = mcp251xfd_get_rx_tail(ring);
 
 		err = mcp251xfd_rx_obj_read(priv, ring, hw_rx_obj,
@@ -227,22 +256,9 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
 				return err;
 		}
 
-		/* Increment the RX FIFO tail pointer 'len' times in a
-		 * single SPI message.
-		 *
-		 * Note:
-		 * Calculate offset, so that the SPI transfer ends on
-		 * the last message of the uinc_xfer array, which has
-		 * "cs_change == 0", to properly deactivate the chip
-		 * select.
-		 */
-		offset = ARRAY_SIZE(ring->uinc_xfer) - len;
-		err = spi_sync_transfer(priv->spi,
-					ring->uinc_xfer + offset, len);
+		err = mcp251xfd_handle_rxif_ring_uinc(priv, ring, len);
 		if (err)
 			return err;
-
-		ring->tail += len;
 	}
 
 	return 0;

-- 
2.43.0



