Return-Path: <netdev+bounces-180514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF820A81963
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC13189D312
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F82566F4;
	Tue,  8 Apr 2025 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJmOusFa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D72256C65
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744155086; cv=none; b=qGzIOVuLnfw270H6J7M1gw4de0oE/qTLZAFvV48UpsqmLV+r1CaQ67FfQIS2lLEOfMy4HHYtC+KziIqp+WRL/2lsfV8VgEBm1jPWBR21+08LKCaq5Aws+WIwoeEs7KMKM9YiJpGAWb2D19dOIk8/Z+66MvmxmCX64wutRQBfKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744155086; c=relaxed/simple;
	bh=tYXYPGTsmkGwSHtcnMtnv5No4VmlcuJYo7+tIi/dzJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JR3Otc5BZP/FRLqIu1jap2ZKp1Ouj8p78INEGCliPTCiyv8nZ/jEiQmyNBWxSK6+DfCE7CbWuBawnrX6wIRpk0T9wSPj37RmwmJ2l7AtyDBfXQ57ruYME0PplZ7s/67rakl4txZx8qg5U4jFPyo7XDnbM8AsdReuzzZOLmcVxDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJmOusFa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso60155505e9.1
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 16:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744155082; x=1744759882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmwXSv7RlVya0U10vKAedkVLI4QTTx9fhGxm6P2/Du8=;
        b=OJmOusFaoXdPz2dt7bgSw4h/322AWPILAlyKqPV0JapnZkVVIz+2YpM7qLSstgas9K
         LsdYvPBvgrRc+kBT5RTOpGBFB9wstLBoOdJ8V29dgPPNRRSgolNKoJszo974zxw+Oi03
         Zu24r4P7RGmx5Crw2vj3FJJ3c/F26MeERo1rA6YsdQpwo9RvN/C6V296AGCfb4QSvfy5
         E4pjo2GEOiPheTHu5nkvEpjcckWmp8Pyiy5ZPsAKlVOSHnn74fmO50CIwm+z2oIrXH7r
         oUMI788qXPRKHTyBu8ReJmtSuDnNiTcDkD9SfAJwMwVYb7c1NuLQ4iRuigEGIONokBYV
         VJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744155082; x=1744759882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmwXSv7RlVya0U10vKAedkVLI4QTTx9fhGxm6P2/Du8=;
        b=lzOeOZoQXEVZdwJmgIRp00lHXOaAzThiOigpPDgQAjPZGTBA9ZqoFxgE0UB4b60Lqw
         Xqt3OJJoP/4he3AdpMsCf/fYoNzqlZ3657MGvpxLYLHD4/g4M1Yi4k4dKd7b1AXUa5sw
         ca+fKhdoWiTCv9i0kXfO7OhCfvnH79fwcPNBnOp3+ryxBRd+yjI7F8AqwwRQfeO7tbA9
         UI/9AJJTBBQV+mn81vRRMTdRplpJRaNoKRr6mAZS/bUd1kp5yOHZgr0k6ZNcYA/bTML2
         bPgTkIOaenIkd4I9b6VCvujEKTPHewPUGqAo8Vaz9bW7LLwlOdo87krZ53EhHyPOmaAP
         OJ2w==
X-Forwarded-Encrypted: i=1; AJvYcCXmnzzFab+YxBOVSwb630lPMxYOqjsl49GjPxg36FeSxsD4FzjEoNTOyXaLOMyLg6pYtVQYc0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSYcEDwl49p9u3nIM0OSiN34idndDPuc41eHPLxGm79LtHXZ2y
	QWWt5Hj+lXiHPhYs2FZJiztrhkVDzsIkcj7hzNX+YnZlFBpr/yCU
X-Gm-Gg: ASbGnctw87VtcYzV4fYI5y12zJ86xFbMxuhwN0DmN7c4gkBCMeDJRmJEUCjuzM2fRtx
	mp80YGlm6SpazW26q1aYDmxZOIYScg9gEVPeHcIzXK8247YUNkzOR3kF5ivPg5Ro5coMnrgZzBS
	JtdcjPlgvYBfzbKYWTsJnp3lj9lXT/+2xIwiPOYuOWQgK98dRJRrjiFFqCJ2znrw+PYGW4bC3q2
	Q3m3AJrTq6BaAJoPNGzsSoaqWbPY9N1GOSbgZc4/tvB3fHDw34x5n+Wwf2HtbS89gVPjrNAGh1p
	j61Yf9jZNFfgRHpvp+6eQ3sV4wMq8wC7bwXMyuK2mljQoOMsfhMvdWG7OUU=
X-Google-Smtp-Source: AGHT+IHulfDIQAKiUM9iXBaNQUKY7ldZ5+qJ9kmWpbzjKoZLipqSKoprJl042TWRJB+z9yuFxyRXfA==
X-Received: by 2002:a05:600c:4713:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-43f1ecad5e6mr8646635e9.17.1744155082250;
        Tue, 08 Apr 2025 16:31:22 -0700 (PDT)
Received: from localhost.localdomain ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d75ac6d66sm9934565f8f.14.2025.04.08.16.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 16:31:20 -0700 (PDT)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH 2/6] net: wwan: core: split port creation and registration
Date: Wed,  9 Apr 2025 02:31:14 +0300
Message-ID: <20250408233118.21452-3-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
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

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wwan/wwan_core.c | 86 ++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ade8bbffc93e..045246d7cd50 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -357,16 +357,19 @@ static struct attribute *wwan_port_attrs[] = {
 };
 ATTRIBUTE_GROUPS(wwan_port);
 
-static void wwan_port_destroy(struct device *dev)
+static void __wwan_port_destroy(struct wwan_port *port)
 {
-	struct wwan_port *port = to_wwan_port(dev);
-
-	ida_free(&minors, MINOR(port->dev.devt));
 	mutex_destroy(&port->data_lock);
 	mutex_destroy(&port->ops_lock);
 	kfree(port);
 }
 
+static void wwan_port_destroy(struct device *dev)
+{
+	ida_free(&minors, MINOR(dev->devt));
+	__wwan_port_destroy(to_wwan_port(dev));
+}
+
 static const struct device_type wwan_port_dev_type = {
 	.name = "wwan_port",
 	.release = wwan_port_destroy,
@@ -440,6 +443,49 @@ static int __wwan_port_dev_assign_name(struct wwan_port *port, const char *fmt)
 	return dev_set_name(&port->dev, "%s", buf);
 }
 
+/* Register a regular WWAN port device (e.g. AT, MBIM, etc.)
+ *
+ * NB: in case of error function frees the port memory.
+ */
+static int wwan_port_register_wwan(struct wwan_port *port)
+{
+	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
+	char namefmt[0x20];
+	int minor, err;
+
+	/* A port is exposed as character device, get a minor */
+	minor = ida_alloc_range(&minors, 0, WWAN_MAX_MINORS - 1, GFP_KERNEL);
+	if (minor < 0) {
+		__wwan_port_destroy(port);
+		return minor;
+	}
+
+	port->dev.class = &wwan_class;
+	port->dev.type = &wwan_port_dev_type;
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
+	err = device_register(&port->dev);
+
+	mutex_unlock(&wwan_register_lock);
+
+	if (err) {
+		put_device(&port->dev);
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
@@ -448,8 +494,7 @@ struct wwan_port *wwan_create_port(struct device *parent,
 {
 	struct wwan_device *wwandev;
 	struct wwan_port *port;
-	char namefmt[0x20];
-	int minor, err;
+	int err;
 
 	if (type > WWAN_PORT_MAX || !ops)
 		return ERR_PTR(-EINVAL);
@@ -461,17 +506,9 @@ struct wwan_port *wwan_create_port(struct device *parent,
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
 
@@ -485,31 +522,14 @@ struct wwan_port *wwan_create_port(struct device *parent,
 	mutex_init(&port->data_lock);
 
 	port->dev.parent = &wwandev->dev;
-	port->dev.class = &wwan_class;
-	port->dev.type = &wwan_port_dev_type;
-	port->dev.devt = MKDEV(wwan_major, minor);
 	dev_set_drvdata(&port->dev, drvdata);
 
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
-		goto error_put_device;
+		goto error_wwandev_remove;
 
-	dev_info(&wwandev->dev, "port %s attached\n", dev_name(&port->dev));
 	return port;
 
-error_put_device:
-	put_device(&port->dev);
 error_wwandev_remove:
 	wwan_remove_dev(wwandev);
 
-- 
2.45.3


