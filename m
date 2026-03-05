Return-Path: <netdev+bounces-264295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFMhBFdgqWnj6QAAu9opvQ
	(envelope-from <netdev+bounces-264295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:52:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 758C1210068
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0811E302DE4E
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955FC374730;
	Thu,  5 Mar 2026 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egSWMFSU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EA615A85A;
	Thu,  5 Mar 2026 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707817; cv=none; b=b9OiOeQ6LVCQX99Tk/3W8DCcLE43NgqnJKukxXTAzKQVgin8x3bdaWt+jNK1OYNp0wW5jP18tONIDTGiYi8nyZQ9+uyZft2YvOA/nTNcDwKVesGNjMPdnjiv3ikWKPy5SX/TYYDkRyl201OVaVk6UcMp/E2TUQ2/4D3mPumIgGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707817; c=relaxed/simple;
	bh=e1siPbqwfhp84tL7AdNjCC2wT61NGGtZfvIuP+EVoyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iyRZmw0kyL6DidO1v0TaL31lW9rKHZfvd0G2ivvahi6beuxjrhfQv477R3DP8gpRCgGJkf+2khij9++ibFLmM1OSVoTNgTWwxaLERbWi6r8KpdK/Jd5g9DojXz7xxd2Kn5t6Td4ZzQJOqJLi5BFlzGlS30ubze+8ZJinYdtAFY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egSWMFSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FC0C116C6;
	Thu,  5 Mar 2026 10:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707817;
	bh=e1siPbqwfhp84tL7AdNjCC2wT61NGGtZfvIuP+EVoyM=;
	h=From:To:Cc:Subject:Date:From;
	b=egSWMFSU8n0hqUe+t0gnR1mElZ+qY/icG4RUmNZmUjA5+cp1RCYw3Ri8TxmMALA6F
	 Q54/nS5WURGASrIahvyK1dpzwsdvxkJ8QRvTHZTWxoDzh5jGaKDsSy9AO1QtjlNIdM
	 XQF/E7YY75OE+gkJnK1Pg+td6xgJjlvf07JQfcv28djQnTfmv2jbf9dyKgkAnB/hg9
	 Z+k488bb0z35ZTtUsbq6yYlYJug4UUag5X8In5KjzA1UBoMK5tOvZvya0tgDtx68uW
	 k7BNCdq9pSr4wASzrJaSD6OZFv/zi6xbJ/PSj+ZhAnynzwJ3YQYaMfKya/XpJgGtfQ
	 Gj1PLmzQQs5LQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy6HW-000000004H2-2ekb;
	Thu, 05 Mar 2026 11:50:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] net: usb: lan78xx: drop redundant device reference
Date: Thu,  5 Mar 2026 11:50:06 +0100
Message-ID: <20260305105006.16415-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 758C1210068
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264295-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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
 drivers/net/usb/lan78xx.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a0021df12fde..2b6cb9266945 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -4530,7 +4530,6 @@ static void intr_complete(struct urb *urb)
 static void lan78xx_disconnect(struct usb_interface *intf)
 {
 	struct lan78xx_net *dev;
-	struct usb_device *udev;
 	struct net_device *net;
 
 	dev = usb_get_intfdata(intf);
@@ -4538,7 +4537,6 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 	if (!dev)
 		return;
 
-	udev = interface_to_usbdev(intf);
 	net = dev->net;
 
 	rtnl_lock();
@@ -4567,7 +4565,6 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 	usb_free_urb(dev->urb_intr);
 
 	free_netdev(net);
-	usb_put_dev(udev);
 }
 
 static void lan78xx_tx_timeout(struct net_device *net, unsigned int txqueue)
@@ -4629,13 +4626,11 @@ static int lan78xx_probe(struct usb_interface *intf,
 	u8 *buf = NULL;
 
 	udev = interface_to_usbdev(intf);
-	udev = usb_get_dev(udev);
 
 	netdev = alloc_etherdev(sizeof(struct lan78xx_net));
 	if (!netdev) {
 		dev_err(&intf->dev, "Error: OOM\n");
-		ret = -ENOMEM;
-		goto out1;
+		return -ENOMEM;
 	}
 
 	SET_NETDEV_DEV(netdev, &intf->dev);
@@ -4784,8 +4779,6 @@ static int lan78xx_probe(struct usb_interface *intf,
 	lan78xx_free_tx_resources(dev);
 out2:
 	free_netdev(netdev);
-out1:
-	usb_put_dev(udev);
 
 	return ret;
 }
-- 
2.52.0


