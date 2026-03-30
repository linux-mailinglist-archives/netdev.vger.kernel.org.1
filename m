Return-Path: <netdev+bounces-273113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKIVExtSymnq7gUAu9opvQ
	(envelope-from <netdev+bounces-273113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:36:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0221235970D
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BE78305F49E
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899BB3BA24F;
	Mon, 30 Mar 2026 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8TJeq/F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC03876D5;
	Mon, 30 Mar 2026 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866385; cv=none; b=ZND387F7hgMiAX7l+vD2OJCdr64Fb4WQCeiCEKAW7xarg3tplCF/B2DaRFvy18b3ly5OrpjyFwrsr/DuOBS6EVsxskU7eZO9ISa+tDtsvj8cJbtPZL8R2urHqNad1cJovgVCQk2CwNGaLqX79FYzJ7CAP/mBDQNh5+Xd457Pozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866385; c=relaxed/simple;
	bh=rgFKg/d+FUAaOw5JbZeHPHlGozeIL8CU5+819cW2K9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euNh4CNZnMyFwMipv78OHloXzPf5Laui80qbHbknABGA6fCf8RinIbtvsMngrKA4wncrgSt+WzWZ2ZiD/gZsoTIAVTmz0tkehf9pgMODyl/H2ueoa/cZSo9ZlfiQ4UvZwhxSgjihwOIaCj/oMo/MHHHTr6ON3A/NZE7BcRBD0ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8TJeq/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2782AC2BCB2;
	Mon, 30 Mar 2026 10:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774866385;
	bh=rgFKg/d+FUAaOw5JbZeHPHlGozeIL8CU5+819cW2K9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8TJeq/FipNLvABEzeHajmIWnQiJEyS8rETi6plHyLvVpkyF92kSIZutj0v8/9lXL
	 Al+FtJXW9KEKWjA2MgDT1g/+FZ+j5imyWXw54+r1/Q0+MNePfdd1C6tmORb4sT1XMk
	 OSpLn9hUtBN20FyxaWQZsLfJf4Upq5UUsN2d50MmDgHtEHxwHGayoLChSxdneND6MN
	 xef0waIGxnOr4u7xYP7KBXBKIpN7rNGn11L1tLxltDr96l9fuguuEm4m1AXH4trzZU
	 o+/vAmVwhMpIirlAAzx54Ig/KR/jxPAFTTlkvKYPpvC27p8dptCWWlRKc7TH5r9B9F
	 wiSGTtloT2cUQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79p8-000000070qo-3yyK;
	Mon, 30 Mar 2026 12:26:22 +0200
From: Johan Hovold <johan@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] net: hso: refactor endpoint lookup
Date: Mon, 30 Mar 2026 12:26:10 +0200
Message-ID: <20260330102611.1671546-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330102611.1671546-1-johan@kernel.org>
References: <20260330102611.1671546-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273113-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0221235970D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the common USB helpers for looking up bulk and interrupt endpoints
instead of a custom implementation.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/usb/hso.c | 65 +++++++++++--------------------------------
 1 file changed, 17 insertions(+), 48 deletions(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 1825f7cf5dc0..c1aec67688ae 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -298,8 +298,6 @@ static int hso_mux_submit_intr_urb(struct hso_shared_int *mux_int,
 				   struct usb_device *usb, gfp_t gfp);
 static void handle_usb_error(int status, const char *function,
 			     struct hso_device *hso_dev);
-static struct usb_endpoint_descriptor *hso_get_ep(struct usb_interface *intf,
-						  int type, int dir);
 static int hso_get_mux_ports(struct usb_interface *intf, unsigned char *ports);
 static void hso_free_interface(struct usb_interface *intf);
 static int hso_start_serial_device(struct hso_device *hso_dev, gfp_t flags);
@@ -2497,16 +2495,11 @@ static struct hso_device *hso_create_net_device(struct usb_interface *interface,
 	hso_net->net = net;
 	hso_net->parent = hso_dev;
 
-	hso_net->in_endp = hso_get_ep(interface, USB_ENDPOINT_XFER_BULK,
-				      USB_DIR_IN);
-	if (!hso_net->in_endp) {
-		dev_err(&interface->dev, "Can't find BULK IN endpoint\n");
-		goto err_net;
-	}
-	hso_net->out_endp = hso_get_ep(interface, USB_ENDPOINT_XFER_BULK,
-				       USB_DIR_OUT);
-	if (!hso_net->out_endp) {
-		dev_err(&interface->dev, "Can't find BULK OUT endpoint\n");
+	result = usb_find_common_endpoints(interface->cur_altsetting,
+					   &hso_net->in_endp, &hso_net->out_endp,
+					   NULL, NULL);
+	if (result) {
+		dev_err(&interface->dev, "Can't find BULK endpoints\n");
 		goto err_net;
 	}
 	SET_NETDEV_DEV(net, &interface->dev);
@@ -2608,10 +2601,12 @@ static void hso_free_serial_device(struct hso_device *hso_dev)
 static struct hso_device *hso_create_bulk_serial_device(
 			struct usb_interface *interface, int port)
 {
+	struct usb_host_interface *iface_desc = interface->cur_altsetting;
 	struct hso_device *hso_dev;
 	struct hso_serial *serial;
 	int num_urbs;
 	struct hso_tiocmget *tiocmget;
+	int ret;
 
 	hso_dev = hso_create_device(interface, port);
 	if (!hso_dev)
@@ -2634,10 +2629,8 @@ static struct hso_device *hso_create_bulk_serial_device(
 		if (!serial->tiocmget->serial_state_notification)
 			goto exit;
 		tiocmget = serial->tiocmget;
-		tiocmget->endp = hso_get_ep(interface,
-					    USB_ENDPOINT_XFER_INT,
-					    USB_DIR_IN);
-		if (!tiocmget->endp) {
+		ret = usb_find_int_in_endpoint(iface_desc, &tiocmget->endp);
+		if (ret) {
 			dev_err(&interface->dev, "Failed to find INT IN ep\n");
 			goto exit;
 		}
@@ -2656,17 +2649,10 @@ static struct hso_device *hso_create_bulk_serial_device(
 				     BULK_URB_TX_SIZE))
 		goto exit;
 
-	serial->in_endp = hso_get_ep(interface, USB_ENDPOINT_XFER_BULK,
-				     USB_DIR_IN);
-	if (!serial->in_endp) {
-		dev_err(&interface->dev, "Failed to find BULK IN ep\n");
-		goto exit2;
-	}
-
-	if (!
-	    (serial->out_endp =
-	     hso_get_ep(interface, USB_ENDPOINT_XFER_BULK, USB_DIR_OUT))) {
-		dev_err(&interface->dev, "Failed to find BULK OUT ep\n");
+	ret = usb_find_common_endpoints(iface_desc, &serial->in_endp,
+					&serial->out_endp, NULL, NULL);
+	if (ret) {
+		dev_err(&interface->dev, "Failed to find BULK eps\n");
 		goto exit2;
 	}
 
@@ -2754,13 +2740,14 @@ static
 struct hso_shared_int *hso_create_shared_int(struct usb_interface *interface)
 {
 	struct hso_shared_int *mux = kzalloc_obj(*mux);
+	int ret;
 
 	if (!mux)
 		return NULL;
 
-	mux->intr_endp = hso_get_ep(interface, USB_ENDPOINT_XFER_INT,
-				    USB_DIR_IN);
-	if (!mux->intr_endp) {
+	ret = usb_find_int_in_endpoint(interface->cur_altsetting,
+				       &mux->intr_endp);
+	if (ret) {
 		dev_err(&interface->dev, "Can't find INT IN endpoint\n");
 		goto exit;
 	}
@@ -3134,24 +3121,6 @@ static void hso_free_interface(struct usb_interface *interface)
 
 /* Helper functions */
 
-/* Get the endpoint ! */
-static struct usb_endpoint_descriptor *hso_get_ep(struct usb_interface *intf,
-						  int type, int dir)
-{
-	int i;
-	struct usb_host_interface *iface = intf->cur_altsetting;
-	struct usb_endpoint_descriptor *endp;
-
-	for (i = 0; i < iface->desc.bNumEndpoints; i++) {
-		endp = &iface->endpoint[i].desc;
-		if (((endp->bEndpointAddress & USB_ENDPOINT_DIR_MASK) == dir) &&
-		    (usb_endpoint_type(endp) == type))
-			return endp;
-	}
-
-	return NULL;
-}
-
 /* Get the byte that describes which ports are enabled */
 static int hso_get_mux_ports(struct usb_interface *intf, unsigned char *ports)
 {
-- 
2.52.0


