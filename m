Return-Path: <netdev+bounces-246976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C98CF2F8C
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 11:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10E5D3090A76
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 10:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3178D3161A6;
	Mon,  5 Jan 2026 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GP557h4p"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AAB315D45;
	Mon,  5 Jan 2026 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608505; cv=none; b=qT5nNicBNP0BpHXkIoi9e+Su/OehsXjrSCWn4y8qcSuy/+s6VaTdFX4J4sV7MqqrFOmLjQISJzWzjuF+3dFH4Xe9c2C999Fhavu9Am7gGujh682wB1+SiCUoG7NyRoNYvxguHoJCnCVZVhSaWp27Ivcm43W8+vh55G4Z02bimaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608505; c=relaxed/simple;
	bh=8oEVsQ/aax8iJBAK9WfweElPheAitLq0tb0cSad4lFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GD//2oYa9b338c/pOGDUI+7tFN7c3RogTtNLgNmX8AOlmKRJniKV4O0FRKobUVUN0jiM7ZZyjkl3mjBihBBWwKwP7Y2RYJCYEgY84FcZ6I+BhMpytsqLdWQvpak1iQFiBi1ZzMOu5Llelk2s/uOE+BTYbkJitLnwxPDoOEjmXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GP557h4p; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eM
	OgPbvGBudF68T2uDGGd26nD1U28CGBg/rUrP+mlVw=; b=GP557h4pVa5cocB6M+
	xMEez3XE3A2A/JVxFjp90LutfS31UcX20Uyg+7kWyKaOLlcAYGQpWp5VfbKlxrwS
	QKyTds3CjgU6X/aq5X0E2CdnzBZVPuEWbQyxmdifI8NJ9u2lkGd/FwozdTNms1CX
	WgBDd83WdVxtO+zS2tJF9f/hc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnrxNrkFtpVWA8KQ--.198S9;
	Mon, 05 Jan 2026 18:21:00 +0800 (CST)
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
Subject: [net-next v4 7/8] net: wwan: prevent premature device unregister when NMEA port is present
Date: Mon,  5 Jan 2026 18:20:17 +0800
Message-Id: <20260105102018.62731-8-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260105102018.62731-1-slark_xiao@163.com>
References: <20260105102018.62731-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnrxNrkFtpVWA8KQ--.198S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr1DXF4fJrWxGw4fCw1xKrg_yoW5Cw4rpa
	1qgas8KrWkJr47ur43tF47XFWruF4xC34Ivry0g34Skr1DtryFvrZ7CF90vFZ8JFyxCFy5
	urZ8tay8uw4UCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOSdgUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvw143GlbkI25AgAA3C

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
index 453ff259809c..df35b188cf6f 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -456,7 +456,7 @@ static int __wwan_port_dev_assign_name(struct wwan_port *port, const char *fmt)
 }
 
 /* Register a regular WWAN port device (e.g. AT, MBIM, etc.) */
-static int wwan_port_register_wwan(struct wwan_port *port)
+static int wwan_port_register_wwan(struct wwan_port *port, bool cdev)
 {
 	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
 	char namefmt[0x20];
@@ -468,7 +468,8 @@ static int wwan_port_register_wwan(struct wwan_port *port)
 		return minor;
 
 	port->dev.class = &wwan_class;
-	port->dev.devt = MKDEV(wwan_major, minor);
+	if (cdev)
+		port->dev.devt = MKDEV(wwan_major, minor);
 
 	/* allocate unique name based on wwan device id, port type and number */
 	snprintf(namefmt, sizeof(namefmt), "wwan%u%s%%d", wwandev->id,
@@ -626,6 +627,7 @@ struct wwan_port *wwan_create_port(struct device *parent,
 				   struct wwan_port_caps *caps,
 				   void *drvdata)
 {
+	bool cdev = (type == WWAN_PORT_NMEA) ? false : true;
 	struct wwan_device *wwandev;
 	struct wwan_port *port;
 	int err;
@@ -660,16 +662,20 @@ struct wwan_port *wwan_create_port(struct device *parent,
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
@@ -696,8 +702,8 @@ void wwan_remove_port(struct wwan_port *port)
 
 	if (port->type == WWAN_PORT_NMEA)
 		wwan_port_unregister_gnss(port);
-	else
-		wwan_port_unregister_wwan(port);
+
+	wwan_port_unregister_wwan(port);
 
 	put_device(&port->dev);
 
-- 
2.25.1


