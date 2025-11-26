Return-Path: <netdev+bounces-241935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72357C8AC54
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F90F3B72E8
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583DD33C520;
	Wed, 26 Nov 2025 15:57:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC7433BBCC
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172648; cv=none; b=HZv6ep7OaaNxYyiQAfmLU27oEpWrK4E7v5GG4+WaaJH5BTr5XYrgLmWNo3DnyOXr1LfeXQjGeQYOYZODRD96gsLxA39vQWvM0JzdZGXSjjGDm52rFX8TmdZofm8Dvpq+HbhELjYuCBxxqcM9eyDyg/Fvy0QNj9jNpEQgxHmk4+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172648; c=relaxed/simple;
	bh=xs4MSBv2yBnh/oYx8/L1xkLl/8lo6u0ioADxDFJql4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRR/soeaxBUPETXktOwxgy903kUi0gy7mzZjbAa2uzTDuONUIwRuB2edhEj2QNPIvf0z44+sftalbkMYGmf4EXwjNWIoNAyHq38DIdB9Am0Nryut2IQxlXifggdeIUY/HJf12GJors3EI6XlvpNDqtsKJ1f3Ken9Akj8gIRvYS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOHtO-000653-Fc; Wed, 26 Nov 2025 16:57:18 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOHtO-002dLj-0K;
	Wed, 26 Nov 2025 16:57:18 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CC1794A8E35;
	Wed, 26 Nov 2025 15:57:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 5/8] can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing data
Date: Wed, 26 Nov 2025 16:41:15 +0100
Message-ID: <20251126155713.217105-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126155713.217105-1-mkl@pengutronix.de>
References: <20251126155713.217105-1-mkl@pengutronix.de>
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

The URB received in gs_usb_receive_bulk_callback() contains a struct
gs_host_frame. The length of the data after the header depends on the
gs_host_frame hf::flags and the active device features (e.g. time
stamping).

Introduce a new function gs_usb_get_minimum_length() and check that we have
at least received the required amount of data before accessing it. Only
copy the data to that skb that has actually been received.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Link: https://patch.msgid.link/20251114-gs_usb-fix-usb-callbacks-v1-3-a29b42eacada@pengutronix.de
[mkl: rename gs_usb_get_minimum_length() -> +gs_usb_get_minimum_rx_length()]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 59 +++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 51f8d694104d..8d8a610f9144 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -261,6 +261,11 @@ struct canfd_quirk {
 	u8 quirk;
 } __packed;
 
+/* struct gs_host_frame::echo_id == GS_HOST_FRAME_ECHO_ID_RX indicates
+ * a regular RX'ed CAN frame
+ */
+#define GS_HOST_FRAME_ECHO_ID_RX 0xffffffff
+
 struct gs_host_frame {
 	struct_group(header,
 		u32 echo_id;
@@ -570,6 +575,37 @@ gs_usb_get_echo_skb(struct gs_can *dev, struct sk_buff *skb,
 	return len;
 }
 
+static unsigned int
+gs_usb_get_minimum_rx_length(const struct gs_can *dev, const struct gs_host_frame *hf,
+			     unsigned int *data_length_p)
+{
+	unsigned int minimum_length, data_length = 0;
+
+	if (hf->flags & GS_CAN_FLAG_FD) {
+		if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX)
+			data_length = can_fd_dlc2len(hf->can_dlc);
+
+		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			/* timestamp follows data field of max size */
+			minimum_length = struct_size(hf, canfd_ts, 1);
+		else
+			minimum_length = sizeof(hf->header) + data_length;
+	} else {
+		if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX &&
+		    !(hf->can_id & cpu_to_le32(CAN_RTR_FLAG)))
+			data_length = can_cc_dlc2len(hf->can_dlc);
+
+		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			/* timestamp follows data field of max size */
+			minimum_length = struct_size(hf, classic_can_ts, 1);
+		else
+			minimum_length = sizeof(hf->header) + data_length;
+	}
+
+	*data_length_p = data_length;
+	return minimum_length;
+}
+
 static void gs_usb_receive_bulk_callback(struct urb *urb)
 {
 	struct gs_usb *parent = urb->context;
@@ -578,7 +614,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	int rc;
 	struct net_device_stats *stats;
 	struct gs_host_frame *hf = urb->transfer_buffer;
-	unsigned int minimum_length;
+	unsigned int minimum_length, data_length;
 	struct gs_tx_context *txc;
 	struct can_frame *cf;
 	struct canfd_frame *cfd;
@@ -621,20 +657,33 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (!netif_running(netdev))
 		goto resubmit_urb;
 
-	if (hf->echo_id == -1) { /* normal rx */
+	minimum_length = gs_usb_get_minimum_rx_length(dev, hf, &data_length);
+	if (urb->actual_length < minimum_length) {
+		stats->rx_errors++;
+		stats->rx_length_errors++;
+
+		if (net_ratelimit())
+			netdev_err(netdev,
+				   "short read (actual_length=%u, minimum_length=%u)\n",
+				   urb->actual_length, minimum_length);
+
+		goto resubmit_urb;
+	}
+
+	if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX) { /* normal rx */
 		if (hf->flags & GS_CAN_FLAG_FD) {
 			skb = alloc_canfd_skb(netdev, &cfd);
 			if (!skb)
 				return;
 
 			cfd->can_id = le32_to_cpu(hf->can_id);
-			cfd->len = can_fd_dlc2len(hf->can_dlc);
+			cfd->len = data_length;
 			if (hf->flags & GS_CAN_FLAG_BRS)
 				cfd->flags |= CANFD_BRS;
 			if (hf->flags & GS_CAN_FLAG_ESI)
 				cfd->flags |= CANFD_ESI;
 
-			memcpy(cfd->data, hf->canfd->data, cfd->len);
+			memcpy(cfd->data, hf->canfd->data, data_length);
 		} else {
 			skb = alloc_can_skb(netdev, &cf);
 			if (!skb)
@@ -643,7 +692,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			cf->can_id = le32_to_cpu(hf->can_id);
 			can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);
 
-			memcpy(cf->data, hf->classic_can->data, 8);
+			memcpy(cf->data, hf->classic_can->data, data_length);
 
 			/* ERROR frames tell us information about the controller */
 			if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)
-- 
2.51.0


