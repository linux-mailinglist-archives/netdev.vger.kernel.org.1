Return-Path: <netdev+bounces-250081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6862DD23C77
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D33AE300D281
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A39C35EDB8;
	Thu, 15 Jan 2026 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lb5z514v"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEEB11CBA;
	Thu, 15 Jan 2026 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470925; cv=none; b=GB1X7+9dRT7DAZnm8Y2yPE8ltlZc0nzq03rOD+ULdZjToU1uiCHNko8LFf89UQ85xDNTsEWryIxnfefxIZPUTh6DGUet4FlDv7DCzzc12q6JlzJpal8bI++XRZSpVf3MlGjqI2PK5ZnweuIbxkwfgRWfJ+gl9n74um7AgobDkXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470925; c=relaxed/simple;
	bh=o+ZV1CBPnBmJ/22DsQYCg1Fg1p/UG8Fip+mrHZ3W6FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cQYr/KPHgE9qbeHXmdFhyOKSRHITKktcaBeKm6OG9oRXMZJfLmw5GgKJ6nXIhWG716SzWw66w7xBlRvcQhxZgE4gcO2Nsmtgchmht06lbXRfvae3ihajizpZ7MyO5KK01tp9MgV26YZ2EXZdtSGkh1YOhvoyUI3cu+EYGru/Ix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lb5z514v; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zk
	cIfgJqM1DgtC/a415w75FdCH9Eqg4K1CDOiRCFFPk=; b=lb5z514vpavnDaSbSV
	LXykhEQQGJIAks92U7poufMlMRWzZtVfvL8o/vUxBflQbVnUGbKpQXVCVJssKAJZ
	yh4SvD8iy+wF8XKeUZYHVe/Wdnc7mOMmCyckJBkiC5wq1CqIr2QdYCZK+BzVsA6x
	3+M/6ok2k1XfEWckMBnRMO71g=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAH3axTuWhpe3IgLg--.97S5;
	Thu, 15 Jan 2026 17:54:43 +0800 (CST)
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
Subject: [net-next v6 3/8] net: wwan: core: split port creation and registration
Date: Thu, 15 Jan 2026 17:54:12 +0800
Message-Id: <20260115095417.36975-4-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260115095417.36975-1-slark_xiao@163.com>
References: <20260115095417.36975-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAH3axTuWhpe3IgLg--.97S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWkAw45CFWxKFW5Jw1xuFg_yoWrZF4kp3
	W0gas5tFW8Jrnrur43AF47ZF4rua1Ik34IyrW8W34Skrn0qryFvF9Y9FyqvFWrGFy7GFy3
	Xrs8ta10k3WUGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR1a09UUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCwAP6X2louWMtUQAA3B

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
index e631da58c493..ef8f4cb9279c 100644
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


