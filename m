Return-Path: <netdev+bounces-246405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 764EFCEB66F
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 07:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 313D230249CB
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 06:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367F530F959;
	Wed, 31 Dec 2025 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Mpm/GyOE"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24F41EA7DB;
	Wed, 31 Dec 2025 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767163945; cv=none; b=WyBlyxYtrlXUPgh2v/lKJwkfdkzQOwLzseZJY3Dbsv0If12DSY+AXndMmTM6GTyiKvhSphZeRcwuTFP09if9iW6zK0bZnsGebhXakuFJYV2uZHZ6QqPoSC/dZFtcFenZabVqSGLrH3eIpXLeVR9ZrxrbJBtLvsYouJMGFtd8fVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767163945; c=relaxed/simple;
	bh=I9JIU3SIGt6FKIY7i03S22dMA4oabfNXX+DC2RnlK48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QqV7/csAHjS5mNLc8h462yhjaYB5nHxQXVzOf+6NQU1RImPMuIgGYMc5/gJQ1sDtHg89FHnjNsiv1omiD5bMiPFrYHvZQV17Fj5Y6upck+TVTU44uaRjC+Q6c5hO8fUEnSlp2PUYmULLZvTQG3mpxcPeV0Z3Ro8sF7+5A72f2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Mpm/GyOE; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5L
	juFc+OGsJqsd6K9ulKKKy+F3uWfNR62IZhQjb+JGc=; b=Mpm/GyOEIAxQcsKdWT
	YUZHkc9KexNa0HkhwM9okBTbF3jsDaXXqTKpsMmmGepuJPRLrc1M29UAKFJcE/zA
	mS34Y415GrT4JOLBRDttbFZLWRfxKQY1hBFbeMGbkchq3E+zAyn1rgmmfM8jL644
	rJCX15j0fCTWm+tu/4l7URFAk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHpCPmx1Rp9FyCDg--.29927S9;
	Wed, 31 Dec 2025 14:51:41 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mani@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [net-next v3 7/8] net: wwan: prevent premature device unregister when NMEA port is present
Date: Wed, 31 Dec 2025 14:51:08 +0800
Message-Id: <20251231065109.43378-8-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251231065109.43378-1-slark_xiao@163.com>
References: <20251231065109.43378-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHpCPmx1Rp9FyCDg--.29927S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr1DXF4fJrWxGw4fCw1xKrg_yoW5Cw4rpa
	n0gas8KrWkGr47ur43tF47XFWrCF4xC3yIvry0g34Skr1DtryFvrZ7CF90vFZ8JFyxCFy5
	urZ8tay8u3y7Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jx6p9UUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvx6gBWlUx-6C3wAA3d

From: Loic Poulain <loic.poulain@oss.qualcomm.com>

The WWAN core unregisters the device when it has no remaining WWAN ops
or child devices. For NMEA port types, the child is registered under
the GNSS class instead of WWAN, so the core incorrectly assumes there
are no children and unregisters the WWAN device too early. This leads
to a second unregister attempt after the NMEA device is removed.

To fix this issue, we register a virtual WWAN port device along the
GNSS device, this ensures the WWAN device remains registered until
all associated ports, including NMEA, are properly removed.

Reported-by: Daniele Palmas <dnlplm@gmail.com>
Closes: https://lore.kernel.org/netdev/CAGRyCJE28yf-rrfkFbzu44ygLEvoUM7fecK1vnrghjG_e9UaRA@mail.gmail.com/
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/net/wwan/wwan_core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 93998b498454..40a57fb0aa0b 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -455,7 +455,7 @@ static int __wwan_port_dev_assign_name(struct wwan_port *port, const char *fmt)
 }
 
 /* Register a regular WWAN port device (e.g. AT, MBIM, etc.) */
-static int wwan_port_register_wwan(struct wwan_port *port)
+static int wwan_port_register_wwan(struct wwan_port *port, bool cdev)
 {
 	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
 	char namefmt[0x20];
@@ -467,7 +467,8 @@ static int wwan_port_register_wwan(struct wwan_port *port)
 		return minor;
 
 	port->dev.class = &wwan_class;
-	port->dev.devt = MKDEV(wwan_major, minor);
+	if (cdev)
+		port->dev.devt = MKDEV(wwan_major, minor);
 
 	/* allocate unique name based on wwan device id, port type and number */
 	snprintf(namefmt, sizeof(namefmt), "wwan%u%s%%d", wwandev->id,
@@ -625,6 +626,7 @@ struct wwan_port *wwan_create_port(struct device *parent,
 				   struct wwan_port_caps *caps,
 				   void *drvdata)
 {
+	bool cdev = (type == WWAN_PORT_NMEA) ? false : true;
 	struct wwan_device *wwandev;
 	struct wwan_port *port;
 	int err;
@@ -659,16 +661,20 @@ struct wwan_port *wwan_create_port(struct device *parent,
 	dev_set_drvdata(&port->dev, drvdata);
 	device_initialize(&port->dev);
 
-	if (port->type == WWAN_PORT_NMEA)
-		err = wwan_port_register_gnss(port);
-	else
-		err = wwan_port_register_wwan(port);
-
+	err = wwan_port_register_wwan(port, cdev);
 	if (err)
 		goto error_put_device;
 
+	if (type == WWAN_PORT_NMEA) {
+		err = wwan_port_register_gnss(port);
+		if (err)
+			goto error_port_unregister;
+	}
+
 	return port;
 
+error_port_unregister:
+	wwan_port_unregister_wwan(port);
 error_put_device:
 	put_device(&port->dev);
 error_wwandev_remove:
@@ -695,8 +701,8 @@ void wwan_remove_port(struct wwan_port *port)
 
 	if (port->type == WWAN_PORT_NMEA)
 		wwan_port_unregister_gnss(port);
-	else
-		wwan_port_unregister_wwan(port);
+
+	wwan_port_unregister_wwan(port);
 
 	put_device(&port->dev);
 
-- 
2.25.1


