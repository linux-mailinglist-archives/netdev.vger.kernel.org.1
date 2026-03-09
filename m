Return-Path: <netdev+bounces-265409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKQAF3KErmnKFgIAu9opvQ
	(envelope-from <netdev+bounces-265409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:27:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D642357B3
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 186A83009B14
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832B636CDE5;
	Mon,  9 Mar 2026 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYlyUkCG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603023624B2;
	Mon,  9 Mar 2026 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773044821; cv=none; b=AmwnDtz6DNxt4CwRN7dhBQlFMWYjN+3WwbY8K13ryARFMr8FvCD0HNKaokT+PkiDqaVNJwhdIaEWxIEb3bJQUcKmaHDH6TGAvEdoGmuEwYBpgQqTpqI2PQH5CEdxZvcdy86ZQ7Ck+0j7DDJ8tF1Qerdndd3H/s2qs7FxDrs2x6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773044821; c=relaxed/simple;
	bh=nkhRxlSg9kyFVG1AEvMQ0w/ilhipFuBU7NMSyf52418=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=azpAxTX5SxYCRq7di4bgkz/rZs5Azh8QRzl49E68zk+M80lo6dwGbyDLckA075km2WwJCtuRq2g/XhXFNhrTqAr84vcOxn8rX3khNt5AIFYpulm2AYKsPmOqXrYpDJ//ReSgTSTHdgzr9iJoBnZTor+Urtws/7bf/b953CTjdgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYlyUkCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054FCC4CEF7;
	Mon,  9 Mar 2026 08:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773044821;
	bh=nkhRxlSg9kyFVG1AEvMQ0w/ilhipFuBU7NMSyf52418=;
	h=From:To:Cc:Subject:Date:From;
	b=DYlyUkCGDWRRIgtAhmO63QBKdJGOSGRjvKhT6PCeMAFP4i+zS65g+1PRh9T3gAA9K
	 /KbMXhCoDPQXlzDSQm8GAqEBW5NqmmFbPJA0UmWuvpXZ2cHal37j2xM3vz1qNOT+1X
	 psuPqKXxeyJ9tzz0RXLbUhl95tJqeDvQd1WMMBH1A58C/2W9ooFMsvcgifhhuspCjV
	 FrRjLJNKMxQ6Bw0GyaNjO3TPa/BXNYASKiBObTipFxbcKQcDcTp96eYKxqNRbMM4dh
	 lOO6M2ZN2b0sfAQaNdpuK59QUtkMc6wdf554dQjOvnQElA0PsLNDqffTZdeFmiGMYs
	 W5bLtNfMn0Dcw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vzVx4-0000000043e-2287;
	Mon, 09 Mar 2026 09:26:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2] net: mdio: mvusb: drop redundant device reference
Date: Mon,  9 Mar 2026 09:26:41 +0100
Message-ID: <20260309082641.15574-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B2D642357B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265409-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.993];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

Drop the redundant device reference to reduce cargo culting, make it
easier to spot drivers where an extra reference is needed, and reduce
the risk of memory leaks when drivers fail to release it.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/mdio/mdio-mvusb.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mdio/mdio-mvusb.c b/drivers/net/mdio/mdio-mvusb.c
index 554837c21e73..86786ecaa4b1 100644
--- a/drivers/net/mdio/mdio-mvusb.c
+++ b/drivers/net/mdio/mdio-mvusb.c
@@ -67,7 +67,6 @@ static int mvusb_mdio_probe(struct usb_interface *interface,
 	struct device *dev = &interface->dev;
 	struct mvusb_mdio *mvusb;
 	struct mii_bus *mdio;
-	int ret;
 
 	mdio = devm_mdiobus_alloc_size(dev, sizeof(*mvusb));
 	if (!mdio)
@@ -75,7 +74,7 @@ static int mvusb_mdio_probe(struct usb_interface *interface,
 
 	mvusb = mdio->priv;
 	mvusb->mdio = mdio;
-	mvusb->udev = usb_get_dev(interface_to_usbdev(interface));
+	mvusb->udev = interface_to_usbdev(interface);
 
 	/* Reversed from USB PCAPs, no idea what these mean. */
 	mvusb->buf[MVUSB_CMD_PREAMBLE0] = cpu_to_le16(0xe800);
@@ -88,25 +87,16 @@ static int mvusb_mdio_probe(struct usb_interface *interface,
 	mdio->write = mvusb_mdio_write;
 
 	usb_set_intfdata(interface, mvusb);
-	ret = of_mdiobus_register(mdio, dev->of_node);
-	if (ret)
-		goto put_dev;
 
-	return 0;
-
-put_dev:
-	usb_put_dev(mvusb->udev);
-	return ret;
+	return of_mdiobus_register(mdio, dev->of_node);
 }
 
 static void mvusb_mdio_disconnect(struct usb_interface *interface)
 {
 	struct mvusb_mdio *mvusb = usb_get_intfdata(interface);
-	struct usb_device *udev = mvusb->udev;
 
 	mdiobus_unregister(mvusb->mdio);
 	usb_set_intfdata(interface, NULL);
-	usb_put_dev(udev);
 }
 
 static struct usb_driver mvusb_mdio_driver = {
-- 
2.52.0


