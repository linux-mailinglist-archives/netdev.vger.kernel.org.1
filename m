Return-Path: <netdev+bounces-147999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AB49DFC92
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FEF6B20D44
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FBE1FA171;
	Mon,  2 Dec 2024 09:00:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB3C1F9F6D
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130052; cv=none; b=H+/NL6Tf0hUMVszRvNBjbnDpW/kDg4FqAFWkMhdwX/BEHWlO7hK5NSjNhxfoVid8vTSvmN0iwvTeLfkg7PSUg13VstvMqPWTTb742DQ7mpLlVH9Fj7+AeHwZaGc1WlsljGzrC0keAOenp7XowiBAcpNHrfmAcnEy6CW7JOBb6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130052; c=relaxed/simple;
	bh=gj56lVY3KuiWdL4Vlw6FYJwu958CG5pxeEAd6bqyUV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKYEUr+jYw8sWtJjmBVj1zhZwVGY3F8xacgvUhL+KbFHdW23/lPm/yTTfA9va+XMoijQzmYrRbmLgZTFwKt3q2G0SgQ9/36c3ZtVIxLcvl6Tm1j9ayISMAn8UlJHwzJPxcyCkPM8PNlRXnbuuPIkWwxBV9ciNVYJTgfrazs5RWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IS-0007c6-5T
	for netdev@vger.kernel.org; Mon, 02 Dec 2024 10:00:48 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IQ-001GY2-0i
	for netdev@vger.kernel.org;
	Mon, 02 Dec 2024 10:00:47 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A23EF38334D
	for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 09:00:46 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 87F0B38331C;
	Mon, 02 Dec 2024 09:00:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e767860c;
	Mon, 2 Dec 2024 09:00:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 02/15] can: gs_usb: add usb endpoint address detection at driver probe step
Date: Mon,  2 Dec 2024 09:55:36 +0100
Message-ID: <20241202090040.1110280-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202090040.1110280-1-mkl@pengutronix.de>
References: <20241202090040.1110280-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>

There is an approach made to implement gs_usb firmware/driver based on
Zephyr RTOS. It was found that USB stack of Zephyr RTOS overwrites USB
EP addresses, if they have different last 4 bytes in absence of other
endpoints.

For example in case of gs_usb candlelight firmware EP-IN is 0x81 and
EP-OUT 0x02. If there are no additional USB endpoints, Zephyr RTOS will
overwrite EP-OUT to 0x01. More information can be found in the
discussion with Zephyr RTOS USB stack maintainer here:

https://github.com/zephyrproject-rtos/zephyr/issues/67812

There are already two different gs_usb FW driver implementations based
on Zephyr RTOS:

1. https://github.com/CANnectivity/cannectivity
   (by: https://github.com/henrikbrixandersen)
2. https://github.com/zephyrproject-rtos/zephyr/compare/main...KozhinovAlexander:zephyr:gs_usb
   (by: https://github.com/KozhinovAlexander)

At the moment both Zephyr RTOS implementations use dummy USB endpoint,
to overcome described USB stack behavior from Zephyr itself. Since
Zephyr RTOS is intended to be used on microcontrollers with very
constrained amount of resources (ROM, RAM) and additional endpoint
requires memory, it is more convenient to update the gs_usb driver in
the Linux kernel.

To fix this problem, update the gs_usb driver from using hard coded
endpoint numbers to evaluate the endpoint descriptors and use the
endpoints provided there.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
Link: https://patch.msgid.link/20241018212450.31746-1-ak.alexander.kozhinov@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index bc86e9b329fd..b6f4de375df7 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -43,9 +43,6 @@
 #define USB_XYLANTA_SAINT3_VENDOR_ID 0x16d0
 #define USB_XYLANTA_SAINT3_PRODUCT_ID 0x0f30
 
-#define GS_USB_ENDPOINT_IN 1
-#define GS_USB_ENDPOINT_OUT 2
-
 /* Timestamp 32 bit timer runs at 1 MHz (1 µs tick). Worker accounts
  * for timer overflow (will be after ~71 minutes)
  */
@@ -336,6 +333,9 @@ struct gs_usb {
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+
+	unsigned int pipe_in;
+	unsigned int pipe_out;
 };
 
 /* 'allocate' a tx context.
@@ -687,7 +687,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 resubmit_urb:
 	usb_fill_bulk_urb(urb, parent->udev,
-			  usb_rcvbulkpipe(parent->udev, GS_USB_ENDPOINT_IN),
+			  parent->pipe_in,
 			  hf, dev->parent->hf_size_rx,
 			  gs_usb_receive_bulk_callback, parent);
 
@@ -819,7 +819,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	}
 
 	usb_fill_bulk_urb(urb, dev->udev,
-			  usb_sndbulkpipe(dev->udev, GS_USB_ENDPOINT_OUT),
+			  dev->parent->pipe_out,
 			  hf, dev->hf_size_tx,
 			  gs_usb_xmit_callback, txc);
 
@@ -925,8 +925,7 @@ static int gs_can_open(struct net_device *netdev)
 			/* fill, anchor, and submit rx urb */
 			usb_fill_bulk_urb(urb,
 					  dev->udev,
-					  usb_rcvbulkpipe(dev->udev,
-							  GS_USB_ENDPOINT_IN),
+					  dev->parent->pipe_in,
 					  buf,
 					  dev->parent->hf_size_rx,
 					  gs_usb_receive_bulk_callback, parent);
@@ -1413,6 +1412,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 			const struct usb_device_id *id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
 	struct gs_host_frame *hf;
 	struct gs_usb *parent;
 	struct gs_host_config hconf = {
@@ -1422,6 +1422,13 @@ static int gs_usb_probe(struct usb_interface *intf,
 	unsigned int icount, i;
 	int rc;
 
+	rc = usb_find_common_endpoints(intf->cur_altsetting,
+				       &ep_in, &ep_out, NULL, NULL);
+	if (rc) {
+		dev_err(&intf->dev, "Required endpoints not found\n");
+		return rc;
+	}
+
 	/* send host config */
 	rc = usb_control_msg_send(udev, 0,
 				  GS_USB_BREQ_HOST_FORMAT,
@@ -1466,6 +1473,10 @@ static int gs_usb_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, parent);
 	parent->udev = udev;
 
+	/* store the detected endpoints */
+	parent->pipe_in = usb_rcvbulkpipe(parent->udev, ep_in->bEndpointAddress);
+	parent->pipe_out = usb_sndbulkpipe(parent->udev, ep_out->bEndpointAddress);
+
 	for (i = 0; i < icount; i++) {
 		unsigned int hf_size_rx = 0;
 
-- 
2.45.2



