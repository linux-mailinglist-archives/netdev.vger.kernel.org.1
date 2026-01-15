Return-Path: <netdev+bounces-250141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB36D24518
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BFF63024A28
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43670389E0E;
	Thu, 15 Jan 2026 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UBMq8LG9"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C8C38A9B6;
	Thu, 15 Jan 2026 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477643; cv=none; b=GuEv9ubuPktt/S13TOyMX2DCE9ndJsX8Z0+OhXPUm4OlhyuJwlCxS7stGYgr9hXYuTQqNqZRrVIkHiWoclcNIVK0RbLSGByvfgVN0ZqtMYucj1wnCg+C0IwTWN56uJf9mcUDfG6frmPkWp4ZqpYNliXlbFERyXoQDI/MjC3N5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477643; c=relaxed/simple;
	bh=h2aKPbYYSCfPFp+IaCbNK1a2/jGwBhkzQ4eo2a8O6QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iIbHHdHliHW3jS+tULjiCZCn1j3vSqDDYUa5XQf41LFNbGPhFH3kEyn+nNCCq8Qa752qI4ra13L7SZgMDUqolAUZNNGSzQRx0Npd1YjmzWye1q+1VtLs+MJKJvhtL/eJNxY/hVzro8HL4zkpcv6WABaGzyPEGJSJD1kvQYFtPzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UBMq8LG9; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3U
	FBFgL70KdmPe6agoutZjKBWX5ibQPwtUx3H8N2FHE=; b=UBMq8LG9hTsmdHPuU2
	PT/mdryuI1PwSqMITEyqLNjW/7zIlhs7/K0BFvL5oyGeNSkg1cz1Wb5PpdVdAgGV
	AKVLuGuKFmLt00BTRoZ/jWpIPJUCiiKsTsM6qxwiwv01yY2SZRnZ3tziOVcn8XnS
	frFefJ8sRhxnGNoKG/WM+Kapg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHLGiX02hpr2PzGQ--.4331S5;
	Thu, 15 Jan 2026 19:46:43 +0800 (CST)
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
	slark_xiao@163.com
Subject: [net-next v7 3/8] net: wwan: core: split port creation and registration
Date: Thu, 15 Jan 2026 19:46:20 +0800
Message-Id: <20260115114625.46991-4-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260115114625.46991-1-slark_xiao@163.com>
References: <20260115114625.46991-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHLGiX02hpr2PzGQ--.4331S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWkAw45CFWxKFW5Jw1xuFg_yoWrZF4kp3
	W0gas5tFW8Jrnrur43AF47ZF4rua1Ik34IyrW8W34Skrn0qryFvFZY9FyqvFWrGFy7GFy3
	Xrs8ta10ka4UWr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRrhLnUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCwASS9mlo06Tm+gAA3K

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Upcoming GNSS (NMEA) port type support requires exporting it via the
GNSS subsystem. On another hand, we still need to do basic WWAN core
work: find or allocate the WWAN device, make it the port parent, etc. To
reuse as much code as possible, split the port creation function into
the registration of a regular WWAN port device, and basic port struct
initialization.

To be able to use put_device() uniformly, break the device_register()
call into device_initialize() and device_add() and call device
initialization earlier.

While at it, fix a minor number leak upon WWAN port registration
failure.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wwan/wwan_core.c | 68 ++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 1da935e84008..1a9a77d597e6 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -357,7 +357,8 @@ static void wwan_port_destroy(struct device *dev)
 {
 	struct wwan_port *port = to_wwan_port(dev);
 
-	ida_free(&minors, MINOR(port->dev.devt));
+	if (dev->class == &wwan_class)
+		ida_free(&minors, MINOR(dev->devt));
 	mutex_destroy(&port->data_lock);
 	mutex_destroy(&port->ops_lock);
 	kfree(port);
@@ -436,6 +437,43 @@ static int __wwan_port_dev_assign_name(struct wwan_port *port, const char *fmt)
 	return dev_set_name(&port->dev, "%s", buf);
 }
 
+/* Register a regular WWAN port device (e.g. AT, MBIM, etc.) */
+static int wwan_port_register_wwan(struct wwan_port *port)
+{
+	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
+	char namefmt[0x20];
+	int minor, err;
+
+	/* A port is exposed as character device, get a minor */
+	minor = ida_alloc_range(&minors, 0, WWAN_MAX_MINORS - 1, GFP_KERNEL);
+	if (minor < 0)
+		return minor;
+
+	port->dev.class = &wwan_class;
+	port->dev.devt = MKDEV(wwan_major, minor);
+
+	/* allocate unique name based on wwan device id, port type and number */
+	snprintf(namefmt, sizeof(namefmt), "wwan%u%s%%d", wwandev->id,
+		 wwan_port_types[port->type].devsuf);
+
+	/* Serialize ports registration */
+	mutex_lock(&wwan_register_lock);
+
+	__wwan_port_dev_assign_name(port, namefmt);
+	err = device_add(&port->dev);
+
+	mutex_unlock(&wwan_register_lock);
+
+	if (err) {
+		ida_free(&minors, minor);
+		return err;
+	}
+
+	dev_info(&wwandev->dev, "port %s attached\n", dev_name(&port->dev));
+
+	return 0;
+}
+
 struct wwan_port *wwan_create_port(struct device *parent,
 				   enum wwan_port_type type,
 				   const struct wwan_port_ops *ops,
@@ -444,8 +482,7 @@ struct wwan_port *wwan_create_port(struct device *parent,
 {
 	struct wwan_device *wwandev;
 	struct wwan_port *port;
-	char namefmt[0x20];
-	int minor, err;
+	int err;
 
 	if (type > WWAN_PORT_MAX || !ops)
 		return ERR_PTR(-EINVAL);
@@ -457,17 +494,9 @@ struct wwan_port *wwan_create_port(struct device *parent,
 	if (IS_ERR(wwandev))
 		return ERR_CAST(wwandev);
 
-	/* A port is exposed as character device, get a minor */
-	minor = ida_alloc_range(&minors, 0, WWAN_MAX_MINORS - 1, GFP_KERNEL);
-	if (minor < 0) {
-		err = minor;
-		goto error_wwandev_remove;
-	}
-
 	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (!port) {
 		err = -ENOMEM;
-		ida_free(&minors, minor);
 		goto error_wwandev_remove;
 	}
 
@@ -481,27 +510,14 @@ struct wwan_port *wwan_create_port(struct device *parent,
 	mutex_init(&port->data_lock);
 
 	port->dev.parent = &wwandev->dev;
-	port->dev.class = &wwan_class;
 	port->dev.type = &wwan_port_dev_type;
-	port->dev.devt = MKDEV(wwan_major, minor);
 	dev_set_drvdata(&port->dev, drvdata);
+	device_initialize(&port->dev);
 
-	/* allocate unique name based on wwan device id, port type and number */
-	snprintf(namefmt, sizeof(namefmt), "wwan%u%s%%d", wwandev->id,
-		 wwan_port_types[port->type].devsuf);
-
-	/* Serialize ports registration */
-	mutex_lock(&wwan_register_lock);
-
-	__wwan_port_dev_assign_name(port, namefmt);
-	err = device_register(&port->dev);
-
-	mutex_unlock(&wwan_register_lock);
-
+	err = wwan_port_register_wwan(port);
 	if (err)
 		goto error_put_device;
 
-	dev_info(&wwandev->dev, "port %s attached\n", dev_name(&port->dev));
 	return port;
 
 error_put_device:
-- 
2.25.1


