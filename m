Return-Path: <netdev+bounces-264294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP8EOmRgqWnj6QAAu9opvQ
	(envelope-from <netdev+bounces-264294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:52:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B5E21007E
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F55B30ABF49
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0864378D94;
	Thu,  5 Mar 2026 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5NzB6PS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D12536404A;
	Thu,  5 Mar 2026 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707693; cv=none; b=L1EaQU0JyORYPWNNY9H2FxZh0inz7FRCIgOJBC1bto/CT9wC9qS7euvKo0wx53IkBRjrKFWF+WsyxyCVJZOrNo+rNwGGX9ixpsBM/1Ap8UKH2QwaCHGsV4lFiBxgKk4PVSVlN4PUISIf199BM94nPByr69t/DgISQHJclMaoHY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707693; c=relaxed/simple;
	bh=Z/9hORvgxbNhGbIdVYDvsOkYohGvgtN+sIjCAlZe5fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PpbgmK0d74w0Sh81geVe4Mm5RAqP5XBgGrRN5BmDtANiL3S9wIKdgcZMzBAyiLvC96gyHIR7Q1WcYctNEOPa11F4DetbIgm/Z6UR0+eki6A9YrGaZlXQzod/RrhcKjBIgJmcRO4AUEkmKsRzSW75vWDfN1b4UJfiAeIFVEq0PR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5NzB6PS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F5DC116C6;
	Thu,  5 Mar 2026 10:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707693;
	bh=Z/9hORvgxbNhGbIdVYDvsOkYohGvgtN+sIjCAlZe5fM=;
	h=From:To:Cc:Subject:Date:From;
	b=Z5NzB6PSBTgr9XPyAmfXa47ML/Wywiu4wFi59s92eFynRZvU0FBH7CMsHAH/3I9+t
	 TGyRsdr9seL4e9nl3bXlnQGlFuUMN2D1Rx52kO3CRfx1wjuLqXxpChv1mTjgaYgRET
	 zAOkvi8J7HEg9EPQr66xGoqwCYWdhxtZRnTNHAP6wrhI+wXPJFjfqe+xM5e0VHbOrr
	 9EDGVLxfcCLTILwi1W9T4p0VGhcx0Oo5vyt81iP3GXiA9c1MednbZPXwPgBDBUncwn
	 ptajBadI/G36GtTpQ3ZYwLn13hGqUNcvnooIRXXgyP2YnvQv5HL0dDicSUJZURdxrM
	 RABJuJoIApNxw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy6FX-000000004ET-0MJ7;
	Thu, 05 Mar 2026 11:48:11 +0100
From: Johan Hovold <johan@kernel.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] net: mdio: mvusb: drop redundant device reference
Date: Thu,  5 Mar 2026 11:47:22 +0100
Message-ID: <20260305104722.16217-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 49B5E21007E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264294-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
 drivers/net/mdio/mdio-mvusb.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mdio/mdio-mvusb.c b/drivers/net/mdio/mdio-mvusb.c
index 554837c21e73..f9c16c731c73 100644
--- a/drivers/net/mdio/mdio-mvusb.c
+++ b/drivers/net/mdio/mdio-mvusb.c
@@ -75,7 +75,7 @@ static int mvusb_mdio_probe(struct usb_interface *interface,
 
 	mvusb = mdio->priv;
 	mvusb->mdio = mdio;
-	mvusb->udev = usb_get_dev(interface_to_usbdev(interface));
+	mvusb->udev = interface_to_usbdev(interface);
 
 	/* Reversed from USB PCAPs, no idea what these mean. */
 	mvusb->buf[MVUSB_CMD_PREAMBLE0] = cpu_to_le16(0xe800);
@@ -90,23 +90,17 @@ static int mvusb_mdio_probe(struct usb_interface *interface,
 	usb_set_intfdata(interface, mvusb);
 	ret = of_mdiobus_register(mdio, dev->of_node);
 	if (ret)
-		goto put_dev;
+		return ret;
 
 	return 0;
-
-put_dev:
-	usb_put_dev(mvusb->udev);
-	return ret;
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


