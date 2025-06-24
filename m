Return-Path: <netdev+bounces-200853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A57DAE71A5
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B925A625A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4925B2EB;
	Tue, 24 Jun 2025 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab8Vj+nG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F02425A33F
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801147; cv=none; b=ICTXJM/fUvkxL1dWhYio5Az9yE1ADYIYfRggPEDPdgkXShd3JdLAiqW4jDNhvKP0aa/5wZZJ0mD2OolLs1xXpCWMwg/bO931tYpuZtxdAlTBZTMuIW+fftv04jgic/5w/clC6QU5CLju9UtcuoRdx4mUzjotEYTog1E483Wsmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801147; c=relaxed/simple;
	bh=VGUrGrFxXTRqYmrGBBGBobKzP5LxayP3Rjoy41oxcaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iu7NCACIdvlcPxcspvfOW2/HQDN2WOGwypZwNSLNkvOxPjw3nsjUmpm0bqneTe1q98BrbnxIfwf4WWYOnNRCgCw30amvXx/2kncvAPmi4vYtJORSbBm7I+Rl37IPoRWYyyAddaiOZp6Ndr8vAUC8WGDTGoxic45rRII+4mX5D8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab8Vj+nG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cf214200so52086705e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750801143; x=1751405943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mh30DF3RJ07PIydV/YO91AGO9fpIFHSelSMlQ5vvK0M=;
        b=Ab8Vj+nG5SPtRAQDtPSpbk3wMaU2nS17guqO4dBzMSW5j4nfxL0zBtA9t3SPsCgQZX
         Oe7oATaboXcsJ6vWyX+k0oF8Q4ug4/Z2bw6TQ3klXl6mRa2T+QdME0FkoSKYIPPDm4eJ
         hJtR9NMGV08ZcMLLZLDgowv09n3xDoMxs4ofi2A0ZMlFl85GipPtvJqZckHm0ItX/YRh
         ePxBojrEw0bbBufppXUWqo+MsdlSqzuQ9qPXGpgxs+axdFRoFcirF+nV7CnsL7JPEsAX
         r2yX268CStzxWy7nT7Cg9YAOEhnGbAeX4s4OC+nQJZqddLEMwleq7WA4dBTuxcQ0ot16
         mmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750801143; x=1751405943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mh30DF3RJ07PIydV/YO91AGO9fpIFHSelSMlQ5vvK0M=;
        b=RhaTzIlFQC2IeqqXXW4mUJ7QhsHXfjpgnSzYNno0ZPbhdCu/qrJYwXYHwZ1kldFQcc
         C4ep7ZBA9/1oDNDHwBZdbu/0CvFK6GgcEJxY3DDqtT12iZGR2MYpiJusjRCC6WHO+HH/
         6TfGQv9hUhmzxZOcwF6aA9OSxRkpERi6h1ujl1h8X+o911TvZzZCnbqtqp37wJbHlm8g
         H9I4OAzjXRU/5NR6RboCKrLgd6bd2YXtJVxJWE8XsSxUjqXimJDLfGdYFSrciR4MtY9W
         wCZXQWkaGrKqcGHpzZzD/7YiR1DPnyZRK3IHREnXBkcf5idOTZ5pSsYq9MhZsiXz3b9Q
         Oz8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXm3tyQLSBeY+vPCN3HRWJHqxbIrb8VIaoPeWK2/2gnfC85vzjdDeKqQ+dVz4zUhFkD6uHq0/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2a78ZFlkQck2kFu0BPfpZUjYHUimtzfMVFnaAph8guGpCe/V6
	8ifzD+0kLvoutouA2NcjsO+Nnw9XIOIxSRuWYRVH/0gaKcGJzzBXscGc
X-Gm-Gg: ASbGncslEwBYYLsRDSCNlzlD6/lTP8Qqoy923jQdncTEg8CcMcve/3HHj2EqmNGKvZ8
	dB0p+Ryux596U6lB/6y926nTHmgp5fzINmLRjAoKZTQaNWo8vFqiAIK64D+iM34HiHfGTGmkCxN
	OHxjp+2ZnGGVKu2fFzIsQYQiamhBU5xSCHphu0PRxrDuHYZCGELyF9tP0A4T6Cg2WMsYrpjDXlD
	Rn1IljRWB67pXFtTPGJ0MCMWrikWx4aKuOxq2CeMWcHJFPhdh/iIrCROeEA+xiaW1zljkaPMd0X
	s1L7nyjN973sRw6yTh8OctrHbR+yOW4hMqCdacHw1e7AtU08VjmXMw662kRk/D7JU7zGeQtgQ6U
	d
X-Google-Smtp-Source: AGHT+IEtFcTV0MqhRN3Ln1V2VlV5nKD9EOYa/5P/DPMkdDDRqyOsZG2eqoev90psC43P8Sr/1wK5/g==
X-Received: by 2002:a05:600c:a410:b0:43c:ea36:9840 with SMTP id 5b1f17b1804b1-45382222aabmr1180085e9.22.1750801143059;
        Tue, 24 Jun 2025 14:39:03 -0700 (PDT)
Received: from localhost.localdomain ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234c9c7sm851415e9.10.2025.06.24.14.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 14:39:02 -0700 (PDT)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH v2 2/6] net: wwan: core: split port creation and registration
Date: Wed, 25 Jun 2025 00:37:57 +0300
Message-ID: <20250624213801.31702-3-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
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

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
Changes:
 RFCv1->RFCv2: break device_register() into device_initialize() and
 device_add() and use put_device() uniformly. Now, in case of error,
 memory is released in wwan_create_port().
---
 drivers/net/wwan/wwan_core.c | 66 ++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ade8bbffc93e..edee5ff48f28 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -361,7 +361,8 @@ static void wwan_port_destroy(struct device *dev)
 {
 	struct wwan_port *port = to_wwan_port(dev);
 
-	ida_free(&minors, MINOR(port->dev.devt));
+	if (dev->class == &wwan_class)
+		ida_free(&minors, MINOR(dev->devt));
 	mutex_destroy(&port->data_lock);
 	mutex_destroy(&port->ops_lock);
 	kfree(port);
@@ -440,6 +441,41 @@ static int __wwan_port_dev_assign_name(struct wwan_port *port, const char *fmt)
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
+	if (err)
+		return err;
+
+	dev_info(&wwandev->dev, "port %s attached\n", dev_name(&port->dev));
+
+	return 0;
+}
+
 struct wwan_port *wwan_create_port(struct device *parent,
 				   enum wwan_port_type type,
 				   const struct wwan_port_ops *ops,
@@ -448,8 +484,7 @@ struct wwan_port *wwan_create_port(struct device *parent,
 {
 	struct wwan_device *wwandev;
 	struct wwan_port *port;
-	char namefmt[0x20];
-	int minor, err;
+	int err;
 
 	if (type > WWAN_PORT_MAX || !ops)
 		return ERR_PTR(-EINVAL);
@@ -461,17 +496,9 @@ struct wwan_port *wwan_create_port(struct device *parent,
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
 
@@ -485,27 +512,14 @@ struct wwan_port *wwan_create_port(struct device *parent,
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
2.49.0


