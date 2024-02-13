Return-Path: <netdev+bounces-71312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DD4852F8D
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47FE5B23E62
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383AD4CE18;
	Tue, 13 Feb 2024 11:34:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CA63A1D9
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824093; cv=none; b=GAV57t2CAOxME/lD0ZTx3qS4Xy/S89TBmmE6SXqpLpRGdEWOZ2YK4vPcuJ1Ao7rNVE+EHruDoMDAqwGUPF0mMzB5O7mQbwy6FZAYZH5kk/CniF3JrS7EbvrZt0thxrrsO+IfLt5bhrihKs5AXqjtFAIj16RRqjFqlihM2yBv2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824093; c=relaxed/simple;
	bh=C1Xypfglw2+YGYvCKvkUdSO+59VsQ9oFS0SgSH2DEyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Riksvwm+OofB+o76MxTezGksqLjNsYRO1I2CIc+2Wlqj9mt4pl3Rdmdhcii5Kw3kQIvLBASFUkNx5dyLcmhLCBh/T96UXmn4f9tPl6GF6nJNNVZ4Qq2DSf0QL2zz0WquLriuymKNV8687eA8bRIKDgDj6ytT2CIeMbupVgCNbaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3n-00019b-Ml
	for netdev@vger.kernel.org; Tue, 13 Feb 2024 12:34:47 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3j-000TUi-1A
	for netdev@vger.kernel.org; Tue, 13 Feb 2024 12:34:43 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B015B28D6A5
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:34:42 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 8C8CC28D634;
	Tue, 13 Feb 2024 11:34:39 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 77708002;
	Tue, 13 Feb 2024 11:34:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Simon Horman <simon.horman@corigine.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/23] can: m_can: Write transmit header and data in one transaction
Date: Tue, 13 Feb 2024 12:25:10 +0100
Message-ID: <20240213113437.1884372-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213113437.1884372-1-mkl@pengutronix.de>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
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

From: Markus Schneider-Pargmann <msp@baylibre.com>

Combine header and data before writing to the transmit fifo to reduce
the overhead for peripheral chips.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/all/20240207093220.2681425-4-msp@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 45391492339e..a01c9261331d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -320,6 +320,12 @@ struct id_and_dlc {
 	u32 dlc;
 };
 
+struct m_can_fifo_element {
+	u32 id;
+	u32 dlc;
+	u8 data[CANFD_MAX_DLEN];
+};
+
 static inline u32 m_can_read(struct m_can_classdev *cdev, enum m_can_reg reg)
 {
 	return cdev->ops->read_reg(cdev, reg);
@@ -1637,9 +1643,10 @@ static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
 static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 {
 	struct canfd_frame *cf = (struct canfd_frame *)cdev->tx_skb->data;
+	u8 len_padded = DIV_ROUND_UP(cf->len, 4);
+	struct m_can_fifo_element fifo_element;
 	struct net_device *dev = cdev->net;
 	struct sk_buff *skb = cdev->tx_skb;
-	struct id_and_dlc fifo_header;
 	u32 cccr, fdflags;
 	u32 txfqs;
 	int err;
@@ -1650,27 +1657,27 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	/* Generate ID field for TX buffer Element */
 	/* Common to all supported M_CAN versions */
 	if (cf->can_id & CAN_EFF_FLAG) {
-		fifo_header.id = cf->can_id & CAN_EFF_MASK;
-		fifo_header.id |= TX_BUF_XTD;
+		fifo_element.id = cf->can_id & CAN_EFF_MASK;
+		fifo_element.id |= TX_BUF_XTD;
 	} else {
-		fifo_header.id = ((cf->can_id & CAN_SFF_MASK) << 18);
+		fifo_element.id = ((cf->can_id & CAN_SFF_MASK) << 18);
 	}
 
 	if (cf->can_id & CAN_RTR_FLAG)
-		fifo_header.id |= TX_BUF_RTR;
+		fifo_element.id |= TX_BUF_RTR;
 
 	if (cdev->version == 30) {
 		netif_stop_queue(dev);
 
-		fifo_header.dlc = can_fd_len2dlc(cf->len) << 16;
+		fifo_element.dlc = can_fd_len2dlc(cf->len) << 16;
 
 		/* Write the frame ID, DLC, and payload to the FIFO element. */
-		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, &fifo_header, 2);
+		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, &fifo_element, 2);
 		if (err)
 			goto out_fail;
 
 		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_DATA,
-				       cf->data, DIV_ROUND_UP(cf->len, 4));
+				       cf->data, len_padded);
 		if (err)
 			goto out_fail;
 
@@ -1732,15 +1739,15 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 				fdflags |= TX_BUF_BRS;
 		}
 
-		fifo_header.dlc = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
+		fifo_element.dlc = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
 			FIELD_PREP(TX_BUF_DLC_MASK, can_fd_len2dlc(cf->len)) |
 			fdflags | TX_BUF_EFC;
-		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, &fifo_header, 2);
-		if (err)
-			goto out_fail;
 
-		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DATA,
-				       cf->data, DIV_ROUND_UP(cf->len, 4));
+		memcpy_and_pad(fifo_element.data, CANFD_MAX_DLEN, &cf->data,
+			       cf->len, 0);
+
+		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID,
+				       &fifo_element, 2 + len_padded);
 		if (err)
 			goto out_fail;
 
-- 
2.43.0



