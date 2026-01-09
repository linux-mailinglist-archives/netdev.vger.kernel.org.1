Return-Path: <netdev+bounces-248299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 116D3D06AF6
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 02:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FAB6300A538
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 01:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544371C862E;
	Fri,  9 Jan 2026 01:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWe5Xty7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616F1632E7
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 01:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767920958; cv=none; b=Lg1QOq5Nn/+J7xXVtCA7q8BGyBo/pue5fIeYE4sNbIo5BYpaPdSrYuU+S5tUnlcolfMGTX4riZlxrlNZYJxNCEE1HJmN0mnLsysOMAXrMY7h6U3ylz8XxFk73er0KA6XDu+DgHAwY1uYQkVcbvzwYGHDs4V2zhatM1q+/LgMCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767920958; c=relaxed/simple;
	bh=90sHoqH4RL5mBcr0BE53mSSntuQmQc+iJiK3UPwFJ5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ee8zYai3/pKoDlaNGQiCbSCuCFQsZRD70VNhS1f8brU3P6bJpivbWg5ASwR2eYZk7vn8obMgKUs/L6oyG8gUJMnSWc0IF8lO1eMLuxrGnXP+h3x5dYkSA4xf8NFoQdWQnaUZ5AJpFHaI5rSwS+8sQQ8ZqFs+F1Mj1gdbIN6jx2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWe5Xty7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so3132489f8f.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 17:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767920955; x=1768525755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SHb5iap/jO9yZCOT+B+wTKv2mx2x7r0hKBUlQThMqk=;
        b=TWe5Xty7v4w3VRZWvtf3FERkXiUZF3/x6ySXOHUQgwfZ3xbXf9dDKgI3hc9brEl1Y5
         bWhLxHQI/fmBAw2K+J75pXeEhzvEXo+fhF/89edWghtmvY0yQvuEltsvW1mhdbQ+clvf
         lQyxyYrCAwdHKxAicezntZVCZjmZ/33DXVOz8Jh8zBMK/iotUlNzOhZcrWl8qjowU42R
         Z3bhxfvbI+BH9NQKzLWDYhZgnl3o2GLeKNRADypEXVsohOLqaFS1HdqvQUzZsVE7BDaD
         ubAf/WtPJT9dJn8sNIOJneshMXZUmoyu7eaij8eGUBm25HtnNwcLZM37/US7OD8ys5eZ
         MOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767920955; x=1768525755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+SHb5iap/jO9yZCOT+B+wTKv2mx2x7r0hKBUlQThMqk=;
        b=NNwFr85RypBPyMPr2m/TL4Q8piF1SqImy13pqW0iT2vLkj/Pp0xwZb2l4y7FHfrCzu
         GdxmIf+0Jt/HS4qwPAg3XqREimNfMo8JGEewHpHAHwTHfCCwQmuPnoaLkvkT60pB2ujR
         mEL4gn3DJmjVKq5cV+TLtAe1Mk0I8rIYSUbu1ef9N+hRE+aOaxVhr7PKXOO9EpeEoMWz
         mF/ysrMcsHDEGdp+saplYKOVzISAvblrwBQnG50TVbmln5LdzL+dIShjux1wolfkdVGj
         6JEEyDc6K8+UBuu4+4CQUnlwJTU5OScltUKk+ssdLA6DXQVBMfU2FWfO/Kh3efqGkGqM
         Uc5w==
X-Forwarded-Encrypted: i=1; AJvYcCUsWOEP+9t0ZiMlqlBAzrIi7De4hHZnoQWCVVNjx9sCLsvbLuvvU5HVWjliFtKP8JEVYRBF9mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJgN79fDGnXTfG/UlRz3DdjJxe5kEu0NCxpDEy+8Za3bPeKnEH
	i/qqlfxv7VtJ0KF72X1Gl+sgktnPW8MxxOq6iFzC6RRoBJOtu4n+C30g
X-Gm-Gg: AY/fxX5R/k9qdXsAb8fk866Ve5BYBmzjZEcx02v7zmZysLqPVlJo/1FlqOtSOg/C0tE
	ieQRLqV7heih8+IGULvi+fAT24ADzxlxs9jRuJ+Z3vyeKHSZGBgrlJsm/rHRE7O60W0WihPmyxM
	jPgyukoye7oftPzKw9V2PMLas2sFbukIbuMTQoABRJji+RmIadz1WUZ9VjA1dsjuxo4lzTWjxPj
	KXM7vggNLLaXt3JxsKponffvfZGf2DWPFymbbfMNKMJpT+SdY02QjtlpYttafvviP+6E8yJV7wX
	nHr9yGNnm7ACRGLqGZ0Bx+Wy2Fz815i4eiGXjdOanMKwZN6LbQgAoykisQGdsg6r3J7gDUTHZED
	og+0v+JTGeDmo3S4Tn2kHRBk1BuR3hzbl8dn2iHjwhudmjO3o/k+pv32rGNQr0ZmIm0602KONVs
	O73uEjT0/2NA==
X-Google-Smtp-Source: AGHT+IGZZl1eOTQKqr3U4roTGY3nttslGtCz+jMNMxC7tfA+9P2eIFxkQ9kKXlfnPAxpeNqHTYGfaw==
X-Received: by 2002:a05:6000:4024:b0:430:f59d:4dfc with SMTP id ffacd0b85a97d-432c378a153mr8428939f8f.9.1767920954609;
        Thu, 08 Jan 2026 17:09:14 -0800 (PST)
Received: from rsa-laptop ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm19698214f8f.15.2026.01.08.17.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 17:09:14 -0800 (PST)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH v5 3/7] net: wwan: core: split port creation and registration
Date: Fri,  9 Jan 2026 03:09:05 +0200
Message-ID: <20260109010909.4216-4-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
References: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Changes:
* RFCv1->RFCv2: break device_register() into device_initialize() and
  device_add() and use put_device() uniformly. Now, in case of error,
  memory is released in wwan_create_port().
* RFCv2->RFCv5: became 3/7 (was 2/6); fix a minor number leak on
  device_add() failure - thanks Sai!
---
 drivers/net/wwan/wwan_core.c | 68 ++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 33f7a140fba9..4c6d315f4847 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -360,7 +360,8 @@ static void wwan_port_destroy(struct device *dev)
 {
 	struct wwan_port *port = to_wwan_port(dev);
 
-	ida_free(&minors, MINOR(port->dev.devt));
+	if (dev->class == &wwan_class)
+		ida_free(&minors, MINOR(dev->devt));
 	mutex_destroy(&port->data_lock);
 	mutex_destroy(&port->ops_lock);
 	kfree(port);
@@ -439,6 +440,43 @@ static int __wwan_port_dev_assign_name(struct wwan_port *port, const char *fmt)
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
@@ -447,8 +485,7 @@ struct wwan_port *wwan_create_port(struct device *parent,
 {
 	struct wwan_device *wwandev;
 	struct wwan_port *port;
-	char namefmt[0x20];
-	int minor, err;
+	int err;
 
 	if (type > WWAN_PORT_MAX || !ops)
 		return ERR_PTR(-EINVAL);
@@ -460,17 +497,9 @@ struct wwan_port *wwan_create_port(struct device *parent,
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
 
@@ -484,27 +513,14 @@ struct wwan_port *wwan_create_port(struct device *parent,
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
2.52.0


