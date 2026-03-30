Return-Path: <netdev+bounces-273121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFTpOrVTymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:43:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57087359938
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A9DF309C3DE
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793483BE155;
	Mon, 30 Mar 2026 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQwefIDK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D123BD640;
	Mon, 30 Mar 2026 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867036; cv=none; b=HqlXIeU5SIWf7vw2paBcTt33mWN/TL9JC78+AzQDBTzxZqf+019DCSPBfZ2pFIbDC29lLDwyfj1306b1cHVSywq5rDoNIZNetOaGgF+ZmUAPHe1rILQPcM7c0lGYlbM94rUX9RmqGHhBW3HbwMxRQzJUIFLz4nm48UV0pI6+uBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867036; c=relaxed/simple;
	bh=p7GepPmyAJRiDLZfTTTE//9a3j+GbLbQyAnUhYl/P3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9/56uQpDaWpx5ArjfdAzREAYM4bntGwQXNxU2ucwHVK5XKjmMwlf4I7wMY539UVqUpxviamfCqa2UHafCou6YeI+yPZgoeVeBP1C5Fft2jht6hlMKv8nm4ezMiMFyvYE1HfAdg3trNOAmMUCdYo0WtZBoG0r+Q/vOPghm1UQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQwefIDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B272C4CEF7;
	Mon, 30 Mar 2026 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774867036;
	bh=p7GepPmyAJRiDLZfTTTE//9a3j+GbLbQyAnUhYl/P3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQwefIDKLKiOyS8VuILVu71Uma+GriTd1FOPfWtSV6XvUwF1LbRgm7H8rH3GgPvq5
	 EyzT7jmKJQNXZnZAfvmwehrBO/jkponb0urWrosfrjoZhftPs+2VVG3IlaWJSmdMaY
	 AqZazHBFK3+wsyOFTTGVXat0hiLcqyCDbFp+hdpe6GiIjDXsqeItuDlqorKKMo1/vE
	 vSIHVDwtJ2YZiW8P644fi1jROB6fd9i3d0yzajOd4WDzLBDZQUDFeMCqzRplrwR9h+
	 BAPb0hZzne1gxYB4KRfWm7+IFPTao9rO+7MfE97JYTRpJ7QCq55d2a+uUU6TWU5Hoz
	 La8eDJl/y1dyw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79ze-0000000713W-05Xj;
	Mon, 30 Mar 2026 12:37:14 +0200
From: Johan Hovold <johan@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] nfc: pn533: refactor endpoint lookup
Date: Mon, 30 Mar 2026 12:36:54 +0200
Message-ID: <20260330103655.1672331-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330103655.1672331-1-johan@kernel.org>
References: <20260330103655.1672331-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273121-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57087359938
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the common USB helpers for looking up bulk and interrupt endpoints
(and determining endpoint numbers) instead of open coding.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/nfc/pn533/usb.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/nfc/pn533/usb.c b/drivers/nfc/pn533/usb.c
index 0ff2f0d7caf4..efb07f944fce 100644
--- a/drivers/nfc/pn533/usb.c
+++ b/drivers/nfc/pn533/usb.c
@@ -476,14 +476,9 @@ static const struct pn533_phy_ops usb_phy_ops = {
 static int pn533_usb_probe(struct usb_interface *interface,
 			const struct usb_device_id *id)
 {
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
 	struct pn533 *priv;
 	struct pn533_usb_phy *phy;
-	struct usb_host_interface *iface_desc;
-	struct usb_endpoint_descriptor *endpoint;
-	int in_endpoint = 0;
-	int out_endpoint = 0;
-	int rc = -ENOMEM;
-	int i;
 	u32 protocols;
 	enum pn533_protocol_type protocol_type = PN533_PROTO_REQ_ACK_RESP;
 	struct pn533_frame_ops *fops = NULL;
@@ -491,6 +486,7 @@ static int pn533_usb_probe(struct usb_interface *interface,
 	int in_buf_len = PN533_EXT_FRAME_HEADER_LEN +
 			 PN533_STD_FRAME_MAX_PAYLOAD_LEN +
 			 PN533_STD_FRAME_TAIL_LEN;
+	int rc;
 
 	phy = devm_kzalloc(&interface->dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
@@ -503,21 +499,11 @@ static int pn533_usb_probe(struct usb_interface *interface,
 	phy->udev = interface_to_usbdev(interface);
 	phy->interface = interface;
 
-	iface_desc = interface->cur_altsetting;
-	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
-		endpoint = &iface_desc->endpoint[i].desc;
-
-		if (!in_endpoint && usb_endpoint_is_bulk_in(endpoint))
-			in_endpoint = endpoint->bEndpointAddress;
-
-		if (!out_endpoint && usb_endpoint_is_bulk_out(endpoint))
-			out_endpoint = endpoint->bEndpointAddress;
-	}
-
-	if (!in_endpoint || !out_endpoint) {
+	rc = usb_find_common_endpoints(interface->cur_altsetting, &ep_in,
+				       &ep_out, NULL, NULL);
+	if (rc) {
 		nfc_err(&interface->dev,
 			"Could not find bulk-in or bulk-out endpoint\n");
-		rc = -ENODEV;
 		goto error;
 	}
 
@@ -525,18 +511,20 @@ static int pn533_usb_probe(struct usb_interface *interface,
 	phy->out_urb = usb_alloc_urb(0, GFP_KERNEL);
 	phy->ack_urb = usb_alloc_urb(0, GFP_KERNEL);
 
-	if (!phy->in_urb || !phy->out_urb || !phy->ack_urb)
+	if (!phy->in_urb || !phy->out_urb || !phy->ack_urb) {
+		rc = -ENOMEM;
 		goto error;
+	}
 
 	usb_fill_bulk_urb(phy->in_urb, phy->udev,
-			  usb_rcvbulkpipe(phy->udev, in_endpoint),
+			  usb_rcvbulkpipe(phy->udev, usb_endpoint_num(ep_in)),
 			  in_buf, in_buf_len, NULL, phy);
 
 	usb_fill_bulk_urb(phy->out_urb, phy->udev,
-			  usb_sndbulkpipe(phy->udev, out_endpoint),
+			  usb_sndbulkpipe(phy->udev, usb_endpoint_num(ep_out)),
 			  NULL, 0, pn533_out_complete, phy);
 	usb_fill_bulk_urb(phy->ack_urb, phy->udev,
-			  usb_sndbulkpipe(phy->udev, out_endpoint),
+			  usb_sndbulkpipe(phy->udev, usb_endpoint_num(ep_out)),
 			  NULL, 0, pn533_ack_complete, phy);
 
 	switch (id->driver_info) {
-- 
2.52.0


