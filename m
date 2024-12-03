Return-Path: <netdev+bounces-148493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ACA9E1D83
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF1C7B25D32
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8D81EE00D;
	Tue,  3 Dec 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="HQ+Q1qIJ"
X-Original-To: netdev@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A38919A297;
	Tue,  3 Dec 2024 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231552; cv=none; b=TMlrqHKbOTMsrtocdcds7Q6jB+SRIoEaU39OLP632dkQTooZdbJaDXfH02MQ76PJKieYkN1g27Z1EbjknS0mTt4FSlfVXbhHbeNuYT6/o/+r0R8HNrY59n3BRDvSxhAP1yQn5QNUJQy7JPYZPwbX93lITSF6LVKo69lg6rIIMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231552; c=relaxed/simple;
	bh=g5hIXz2ZdFqiQ/fjDhOmrfPEjwRDaOZ0QCeYZ3p65as=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SN2Iy6TRXEBcSezuvVIheFpJ3QazHlPlux4EmyarKfALazC2smhgc628vlWpYmjdTx86j0Q4aeYCWrlIgptgI8W30LEm0APqw8L0UALpDZATfgL10fsBsKPB4OZol0cbz85Z4J7Zs6MbyUHWfkWzB+GhcfKQeyXvFnHnhW5yPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=HQ+Q1qIJ; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id DEFF014C1E1;
	Tue,  3 Dec 2024 14:05:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1733231117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XkzHgQVBOQbV299nGM1TYNeg3mTKbniIxeYpdBTzdO8=;
	b=HQ+Q1qIJ43ImBUjy19f+FduPW3HekLc7QhEwJfYqEKmnJxu51fITz/dPokP+VZ/PCelpeX
	o4ujPw7I+AeOrPyzHD8EXGfVQWE+2VlbtgGeUcF2qPP4tCozA9X4WJoxMFws5S/aEiMOgs
	27v9vH+bECgSpIBGaWPH1m+0d5CXWyfiTNX2yX6J2FGXRnXOOuWGO7E7T4aAxwdCLxiyAw
	+7Lk1AS+DXtF1Aao6SrWqeN2U1rmNF+REeafnCv9U7xLPGIf3Nbe1tnGzoI2ljEUHhuewj
	+7yEER7WhLzh3SDfXRLw6SAdhhO+Ura1tXN3Nc4W6w9JyzFwPqCz4Yqe817ywA==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 62ef6977;
	Tue, 3 Dec 2024 13:05:13 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: Oliver Neukum <oneukum@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: usb: usbnet: restore usb%d name exception for local mac addresses
Date: Tue,  3 Dec 2024 22:04:55 +0900
Message-ID: <20241203130457.904325-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

The previous commit assumed that local addresses always came from the
kernel, but some devices hand out local mac addresses so we ended up
with point-to-point devices with a mac set by the driver, renaming to
eth%d when they used to be named usb%d.

Userspace should not rely on device name, but for the sake of stability
restore the local mac address check portion of the naming exception:
point to point devices which either have no mac set by the driver or
have a local mac handed out by the driver will keep the usb%d name.

Fixes: 8a7d12d674ac ("net: usb: usbnet: fix name regression")
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
 drivers/net/usb/usbnet.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 44179f4e807f..d044dc7b7622 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -178,6 +178,17 @@ int usbnet_get_ethernet_addr(struct usbnet *dev, int iMACAddress)
 }
 EXPORT_SYMBOL_GPL(usbnet_get_ethernet_addr);
 
+static bool usbnet_needs_usb_name_format(struct usbnet *dev, struct net_device *net)
+{
+	/* Point to point devices which don't have a real MAC address
+	 * (or report a fake local one) have historically used the usb%d
+	 * naming. Preserve this..
+	 */
+	return (dev->driver_info->flags & FLAG_POINTTOPOINT) != 0 &&
+		(is_zero_ether_addr(net->dev_addr) ||
+		 is_local_ether_addr(net->dev_addr));
+}
+
 static void intr_complete (struct urb *urb)
 {
 	struct usbnet	*dev = urb->context;
@@ -1762,13 +1773,10 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		if (status < 0)
 			goto out1;
 
-		// heuristic:  "usb%d" for links we know are two-host,
-		// else "eth%d" when there's reasonable doubt.  userspace
-		// can rename the link if it knows better.
+		/* heuristic: rename to "eth%d" if we are not sure this link
+		 * is two-host (these links keep "usb%d") */
 		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
-		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
-		     /* somebody touched it*/
-		     !is_zero_ether_addr(net->dev_addr)))
+		    !usbnet_needs_usb_name_format(dev, net))
 			strscpy(net->name, "eth%d", sizeof(net->name));
 		/* WLAN devices should always be named "wlan%d" */
 		if ((dev->driver_info->flags & FLAG_WLAN) != 0)
-- 
2.47.0


