Return-Path: <netdev+bounces-200856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC37AE71A9
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C30317F385
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C1325BEE8;
	Tue, 24 Jun 2025 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeiJSQmY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1546E25B667
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801152; cv=none; b=pp4wfZRl7/wgw6utm6Ij45/A7rsaMM6u5BHpQ1WjVjAVhTd+IcTwvbR2QM6Qjip5eIe6gkG8PaBFa67X2FNbKP6MAejyBzmugrRC4uw7X2Fk94MmCQ4+vApQxs43U5gIkQFv/O68txvjW0iuGg3skJ4vcPdQnAO+7ZFDzs9uizw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801152; c=relaxed/simple;
	bh=4bPLDk+GaI2aSLvVyAOP0dtapbtZvW+PaW1C+Qk65t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bsureu4PwwcRglzK2RD9rH1Y1uqVcZ5BKQP2ZSppfe9hzSua1gOYVBAMa50hzKM2qcHaBgSmqgxo0sS3nVuOMyNc8SVFM5PBQh5Vcnovfiinlq/m3NF21rxfaXABcpj8zSosJV+J5H6okzURZmu0dpV8tQPGzhz2eFCkvs3aCFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeiJSQmY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d3f72391so52808505e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750801146; x=1751405946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ND522FVMw8QhUZuryhwoQlD1ONsRiZruY/zyk38T52w=;
        b=NeiJSQmYMSU19AJb3tn6yCFPCn8VK0dncGeZBE2R0s0Rk40MgHCXKjjNBqKIKjsNUO
         VhYLmABRAvZXuZtAeBAVtwYH3ywC3s1w9Rp+LuMZr5/0oCJ4M/na6Qv8hFN2ZZzj+vOE
         cuV9e/A+ubbJ3iXfMhrd5/9p4fZh91bLCr+Nx2glHpOFIMXQssm61Xl5ZEirwigs+9ht
         GXlI0b0Yneo6UsdQuHzCsIU7Ithjf139gFCySOoMaWtIICUsFAHKN7hFSnrErFETBmMo
         bWIW2GftGYjuFGLQ1ooMePLqE3W9LWSvcRl3bzHeS/WlR5lieQjau285Yz7gCtQ7Zjg/
         /x0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750801146; x=1751405946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ND522FVMw8QhUZuryhwoQlD1ONsRiZruY/zyk38T52w=;
        b=WxbFl3XN8zu1kr6Oqj7/zGSj7SthsnbsLj84uhLK85T9KiyFvHBN4Yd577KOQUrmVl
         MX1wHotBT1Z1rr/7QdVMp5YvjCG3Fjnqc919HIxtqPXby77iFAfPZYnoZm/vR/DOgR1F
         ORpAFbh/XWBbgZGg1t579RxfTGx2SpO/jAlnDV4o7S2pgtGTrWyHtTvJE6tt+YEPmynx
         td7EsQgYiGsoQ1aXhraUkMkCAVhpwfIkSqYWA+too5daXlyEry0KZ19eS2aBYhr2kuR5
         PI2yH97wkC59/KAtBRuJ/0pK/ebvMSh2y0j/FjW+3xz3dXi59HmT4wad10hgJARfGAv/
         1aIw==
X-Forwarded-Encrypted: i=1; AJvYcCX2xZe09GJnkhAwxHm5Eb0SEwS4uKSrIb0gm+1q8bTpG9/zbfEylscIpAze92zbBM0OTZ9VWE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnXWSIOipPROso/8W9RlVkOxxfQXi147O89jknjwVDcpK7RPon
	an/haFW4ke/ZMIxyyTY4s2a6eUP+JyekorytmEmy8nCXDkS1Nkwr8DuD
X-Gm-Gg: ASbGncsYKlBDByDhrWU6Qo2319vrU8veHDqXAZMtpEDTOv/9OWTu2C/+MmS1dyC0FdL
	KUsYFRJq/h6OHbMKwyHd8Yh+y/wEI2PDLzV/5XjKmvPsvsII8Ao0m8mFKhRBrBSB35Q+n5p8wSx
	vSnBANzOXILawzlkIPxVDawO5h7XVCB3On2onfd/xa0yJ8Wp5ymWdb47qcRaUu6a3xzl0aJYk1u
	9PB8RBWf3Y6sTJu8vhJpvfNk99tVyJ+gltinZcHNgBhHJ2q98IS9cmcTVxIQa2WL8IKeJutv0I6
	ZVJc2fze4lD3BksyPxutE/O8Horzq4cJBGYax7N7NqQ1SMqOVQce3dRnwqx6WpupMcKNtbSsHN9
	k
X-Google-Smtp-Source: AGHT+IHyedu7VHB7arpzFasvGeTlzLExvBjnSjtajvQ1FEY7mr2cIw5EgLL1HMmdre/iX9bPh1j0jw==
X-Received: by 2002:a05:600c:680a:b0:442:f8e7:25ef with SMTP id 5b1f17b1804b1-45381aa76bbmr4829635e9.11.1750801146415;
        Tue, 24 Jun 2025 14:39:06 -0700 (PDT)
Received: from localhost.localdomain ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234c9c7sm851415e9.10.2025.06.24.14.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 14:39:05 -0700 (PDT)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>,
	Muhammad Nuzaihan <zaihan@unrealasia.net>,
	Qiang Yu <quic_qianyu@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: [RFC PATCH v2 4/6] net: wwan: add NMEA port support
Date: Wed, 25 Jun 2025 00:37:59 +0300
Message-ID: <20250624213801.31702-5-ryazanov.s.a@gmail.com>
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

Many WWAN modems come with embedded GNSS receiver inside and have a
dedicated port to output geopositioning data. On the one hand, the
GNSS receiver has little in common with WWAN modem and just shares a
host interface and should be exported using the GNSS subsystem. On the
other hand, GNSS receiver is not automatically activated and needs a
generic WWAN control port (AT, MBIM, etc.) to be turned on. And a user
space software needs extra information to find the control port.

Introduce the new type of WWAN port - NMEA. When driver asks to register
a NMEA port, the core allocates common parent WWAN device as usual, but
exports the NMEA port via the GNSS subsystem and acts as a proxy between
the device driver and the GNSS subsystem.

From the WWAN device driver perspective, a NMEA port is registered as a
regular WWAN port without any difference. And the driver interacts only
with the WWAN core. From the user space perspective, the NMEA port is a
GNSS device which parent can be used to enumerate and select the proper
control port for the GNSS receiver management.

CC: Slark Xiao <slark_xiao@163.com>
CC: Muhammad Nuzaihan <zaihan@unrealasia.net>
CC: Qiang Yu <quic_qianyu@quicinc.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Johan Hovold <johan@kernel.org>
Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wwan/Kconfig     |   1 +
 drivers/net/wwan/wwan_core.c | 155 +++++++++++++++++++++++++++++++++--
 include/linux/wwan.h         |   2 +
 3 files changed, 153 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
index 410b0245114e..88df55d78d90 100644
--- a/drivers/net/wwan/Kconfig
+++ b/drivers/net/wwan/Kconfig
@@ -7,6 +7,7 @@ menu "Wireless WAN"
 
 config WWAN
 	tristate "WWAN Driver Core"
+	depends on GNSS || GNSS = n
 	help
 	  Say Y here if you want to use the WWAN driver core. This driver
 	  provides a common framework for WWAN drivers.
diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index c735b9830e6e..93998b498454 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -1,5 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2021, Linaro Ltd <loic.poulain@linaro.org> */
+/* WWAN Driver Core
+ *
+ * Copyright (c) 2021, Linaro Ltd <loic.poulain@linaro.org>
+ * Copyright (c) 2025, Sergey Ryazanov <ryazanov.s.a@gmail.com>
+ */
 
 #include <linux/bitmap.h>
 #include <linux/err.h>
@@ -16,6 +20,7 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/termios.h>
+#include <linux/gnss.h>
 #include <linux/wwan.h>
 #include <net/rtnetlink.h>
 #include <uapi/linux/wwan.h>
@@ -89,9 +94,16 @@ struct wwan_port {
 			struct ktermios termios;
 			int mdmbits;
 		} at_data;
+		struct gnss_device *gnss;
 	};
 };
 
+static int wwan_port_op_start(struct wwan_port *port);
+static void wwan_port_op_stop(struct wwan_port *port);
+static int wwan_port_op_tx(struct wwan_port *port, struct sk_buff *skb,
+			   bool nonblock);
+static int wwan_wait_tx(struct wwan_port *port, bool nonblock);
+
 static ssize_t index_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct wwan_device *wwan = to_wwan_dev(dev);
@@ -340,6 +352,7 @@ static const struct {
 		.name = "MIPC",
 		.devsuf = "mipc",
 	},
+	/* WWAN_PORT_NMEA is exported via the GNSS subsystem */
 };
 
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
@@ -488,6 +501,124 @@ static void wwan_port_unregister_wwan(struct wwan_port *port)
 	device_del(&port->dev);
 }
 
+#if IS_ENABLED(CONFIG_GNSS)
+static int wwan_gnss_open(struct gnss_device *gdev)
+{
+	return wwan_port_op_start(gnss_get_drvdata(gdev));
+}
+
+static void wwan_gnss_close(struct gnss_device *gdev)
+{
+	wwan_port_op_stop(gnss_get_drvdata(gdev));
+}
+
+static int wwan_gnss_write(struct gnss_device *gdev, const unsigned char *buf,
+			   size_t count)
+{
+	struct wwan_port *port = gnss_get_drvdata(gdev);
+	struct sk_buff *skb, *head = NULL, *tail = NULL;
+	size_t frag_len, remain = count;
+	int ret;
+
+	ret = wwan_wait_tx(port, false);
+	if (ret)
+		return ret;
+
+	do {
+		frag_len = min(remain, port->frag_len);
+		skb = alloc_skb(frag_len + port->headroom_len, GFP_KERNEL);
+		if (!skb) {
+			ret = -ENOMEM;
+			goto freeskb;
+		}
+		skb_reserve(skb, port->headroom_len);
+		memcpy(skb_put(skb, frag_len), buf + count - remain, frag_len);
+
+		if (!head) {
+			head = skb;
+		} else {
+			if (!tail)
+				skb_shinfo(head)->frag_list = skb;
+			else
+				tail->next = skb;
+
+			tail = skb;
+			head->data_len += skb->len;
+			head->len += skb->len;
+			head->truesize += skb->truesize;
+		}
+	} while (remain -= frag_len);
+
+	ret = wwan_port_op_tx(port, head, false);
+	if (!ret)
+		return count;
+
+freeskb:
+	kfree_skb(head);
+	return ret;
+}
+
+static struct gnss_operations wwan_gnss_ops = {
+	.open = wwan_gnss_open,
+	.close = wwan_gnss_close,
+	.write_raw = wwan_gnss_write,
+};
+
+/* GNSS port specific device registration */
+static int wwan_port_register_gnss(struct wwan_port *port)
+{
+	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
+	struct gnss_device *gdev;
+	int err;
+
+	gdev = gnss_allocate_device(&wwandev->dev);
+	if (!gdev)
+		return -ENOMEM;
+
+	/* NB: for now we support only NMEA WWAN port type, so hardcode
+	 * the GNSS port type. If more GNSS WWAN port types will be added,
+	 * then we should dynamically mapt WWAN port type to GNSS type.
+	 */
+	gdev->type = GNSS_TYPE_NMEA;
+	gdev->ops = &wwan_gnss_ops;
+	gnss_set_drvdata(gdev, port);
+
+	port->gnss = gdev;
+
+	err = gnss_register_device(gdev);
+	if (err) {
+		gnss_put_device(gdev);
+		return err;
+	}
+
+	dev_info(&wwandev->dev, "port %s attached\n", dev_name(&gdev->dev));
+
+	return 0;
+}
+
+/* GNSS port specific device unregistration */
+static void wwan_port_unregister_gnss(struct wwan_port *port)
+{
+	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
+	struct gnss_device *gdev = port->gnss;
+
+	dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&gdev->dev));
+
+	gnss_deregister_device(gdev);
+	gnss_put_device(gdev);
+}
+#else
+static inline int wwan_port_register_gnss(struct wwan_port *port)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void wwan_port_unregister_gnss(struct wwan_port *port)
+{
+	WARN_ON(1);	/* This handler cannot be called */
+}
+#endif
+
 struct wwan_port *wwan_create_port(struct device *parent,
 				   enum wwan_port_type type,
 				   const struct wwan_port_ops *ops,
@@ -528,7 +659,11 @@ struct wwan_port *wwan_create_port(struct device *parent,
 	dev_set_drvdata(&port->dev, drvdata);
 	device_initialize(&port->dev);
 
-	err = wwan_port_register_wwan(port);
+	if (port->type == WWAN_PORT_NMEA)
+		err = wwan_port_register_gnss(port);
+	else
+		err = wwan_port_register_wwan(port);
+
 	if (err)
 		goto error_put_device;
 
@@ -558,7 +693,10 @@ void wwan_remove_port(struct wwan_port *port)
 	wake_up_interruptible(&port->waitqueue);
 	skb_queue_purge(&port->rxq);
 
-	wwan_port_unregister_wwan(port);
+	if (port->type == WWAN_PORT_NMEA)
+		wwan_port_unregister_gnss(port);
+	else
+		wwan_port_unregister_wwan(port);
 
 	put_device(&port->dev);
 
@@ -569,8 +707,15 @@ EXPORT_SYMBOL_GPL(wwan_remove_port);
 
 void wwan_port_rx(struct wwan_port *port, struct sk_buff *skb)
 {
-	skb_queue_tail(&port->rxq, skb);
-	wake_up_interruptible(&port->waitqueue);
+	if (port->type == WWAN_PORT_NMEA) {
+#if IS_ENABLED(CONFIG_GNSS)
+		gnss_insert_raw(port->gnss, skb->data, skb->len);
+#endif
+		consume_skb(skb);
+	} else {
+		skb_queue_tail(&port->rxq, skb);
+		wake_up_interruptible(&port->waitqueue);
+	}
 }
 EXPORT_SYMBOL_GPL(wwan_port_rx);
 
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index a4d6cc0c9f68..1e0e2cb53579 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -19,6 +19,7 @@
  * @WWAN_PORT_FASTBOOT: Fastboot protocol control
  * @WWAN_PORT_ADB: ADB protocol control
  * @WWAN_PORT_MIPC: MTK MIPC diagnostic interface
+ * @WWAN_PORT_NMEA: embedded GNSS receiver with NMEA output
  *
  * @WWAN_PORT_MAX: Highest supported port types
  * @WWAN_PORT_UNKNOWN: Special value to indicate an unknown port type
@@ -34,6 +35,7 @@ enum wwan_port_type {
 	WWAN_PORT_FASTBOOT,
 	WWAN_PORT_ADB,
 	WWAN_PORT_MIPC,
+	WWAN_PORT_NMEA,
 
 	/* Add new port types above this line */
 
-- 
2.49.0


