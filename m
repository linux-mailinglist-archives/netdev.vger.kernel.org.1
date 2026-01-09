Return-Path: <netdev+bounces-248304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E2AD06B01
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 02:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63C5930268C8
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 01:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463761C3C08;
	Fri,  9 Jan 2026 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCvIlRvG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB121C160
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 01:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767920968; cv=none; b=GfycJB7fvauMGG+erv9gzICA/c4z1lidkvD41H1CJrW2N2kLrJPGeRt520P7wdMKqQTTbcakgxVtXOcmkENNq6SZhdDiN5yMZ0o/Vej8xV2P8rXtR7gh1YfHzWJtmxPjGJQ1wIyFiXIZ3n3oJHeaZGjQSCwD3hatzTkPlI26lqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767920968; c=relaxed/simple;
	bh=DINUs9jL5TKmIk4+kfCAhzCWY7V3623SfuiH3VTpJtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpeXvkg2J/0h06CiXPxcVNsbOZnzC+mkGlZ0lePk7r8bc1b1w4+/LOOq1XZ3lehDF1m/Rlk/k6tGJyH9wRnEplOXjw5ByPjGtsmAsQ3CrfgLSKUiAm3je/WZwHrq9afO8yLb2bku20THx9gWKqi8taaSn5QVZYn0UFd1KrBf2bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCvIlRvG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so40587775e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 17:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767920958; x=1768525758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1oxxAqDsxFiAn0HNq4nW3GMd/zFEIkIcOppJPDXUUo=;
        b=fCvIlRvGOJJFE3kJ3L0ZZKYwwtWIQ9xcpHp3bh9KqA+tz6XVT+fKJ9L9WDvcwETAZh
         H6UcrXc1k8nH4ughFbXoAdrpRj51hg8HXHkbhF9S11Y4zZ0YG7ZAoxePb034N1ecy3FF
         m4i8N5gGPimU6wpaPyJfWBOflP96mvYMcPXchvCs2LXKgl1odeLtcR/j9FWhueMixC/o
         azyuFH9WOWFSXQ+Yw4cz4gDTE1+E1Mk7b4OvCkIb7qve6M7hOyR2+aKsa859V/hKrwZ8
         Iv7m0FKQ+egqO8KtXaaplSiCiRRhW/2rX8YECEe9ZsYbuyOeeJydQRiXPlvApKHPiKBZ
         A46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767920958; x=1768525758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K1oxxAqDsxFiAn0HNq4nW3GMd/zFEIkIcOppJPDXUUo=;
        b=VBg2mJ3Uofa4tGiLdsjW4fx3bPyrfDanajb1ZxTiDlBa6pB5T/qbdF5MKOoeIgc1W/
         Q/3MWHLGNEPwXA9LpfFao1NQMej1TPn/T4oZ+WjjGLDjY74hQhsnY9BZeQ+tTyiJb/8N
         XZIV37C/r6OhZwm3JLvF8VTHaHPe8XzqV2brR8rBy17Siqv/rol7NRyArr9TgXG4Toqg
         XHdjqrk9PRzhXwUJgiAtb+oLJKreFJhZ8EiO58peuy1Y5745URUQUx8+D68LjwNZMfH+
         ifbcuhRuBi3VK6fWGngQi38Oyw/S52n0JsjXjtSULesLmX6wrRFkvOW1JIWWetyaf3RK
         DHxw==
X-Forwarded-Encrypted: i=1; AJvYcCUL/rCPJe296K9UiX0hv9ydByVXWnL7qyueDczSw96yxC28PBWezpoLIEi+3EQ9OjJ0hrcQnRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylpFSKT6ehq83/yrM+dRywzkHNtReALpmTNdMjkTuRotHBuE39
	i3Qyd8RieQRMRmvGX/2oTDfDIGUT+ripOM/JsZKUW2wSoEkn2t94mopJ
X-Gm-Gg: AY/fxX63fYSQwu5h2T2K7BFKrwDImzpjPLse+fdloHCofuAQTeYhIwbKZn0Lh92QFi3
	I9lsmsv+B+52y2htpvLKRDt3nCevCDp2oeONz1mIN2YPtJ1hhf7jYe9REcfyZMqUk0Kg+Gq+PTf
	ddt6aSAJNNTjIs4J2NqzDG6hljaZbENY15V5nanT7EfSRSd7C7X15A2mjNFAGXbM8sXt/W5oyFz
	OHglqm1vNTEOZ9fh/lAvjkF+/IThDluCdKUts8bsWr6lxgjNdY8WHfoEV9nR8EQH52NSPwDZpqB
	S9X6lDWmB6bpASaOTArfb4Zyx9hPlGt4mjr5ZDI9uw1OVIhTDd7Fj6e4NN6vMbGbBi8oLC1gOE9
	BDP8PvnaL67X8PrZawZ0Ht+wyDR4WeHA+CSaCbj4FKv+K435a7HNoqOqXDmCNUbMPvPPur3SZ5C
	faICM9rBnLqQ==
X-Google-Smtp-Source: AGHT+IH/l0hUquCDeONatXhvH1rGzs7KgLljr/D7howTWp8jZfjtMC1txiBDy5IYRlUtaaR/iwgMHA==
X-Received: by 2002:a05:600c:4713:b0:477:1af2:f40a with SMTP id 5b1f17b1804b1-47d84b32748mr105611995e9.17.1767920957813;
        Thu, 08 Jan 2026 17:09:17 -0800 (PST)
Received: from rsa-laptop ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm19698214f8f.15.2026.01.08.17.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 17:09:17 -0800 (PST)
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
Subject: [RFC PATCH v5 5/7] net: wwan: add NMEA port support
Date: Fri,  9 Jan 2026 03:09:07 +0200
Message-ID: <20260109010909.4216-6-ryazanov.s.a@gmail.com>
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
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes:
* RFCv2->RFCv5: became 5/7 (was 4/6); add missed gnss field
  documentation
---
 drivers/net/wwan/Kconfig     |   1 +
 drivers/net/wwan/wwan_core.c | 156 +++++++++++++++++++++++++++++++++--
 include/linux/wwan.h         |   2 +
 3 files changed, 154 insertions(+), 5 deletions(-)

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
index 798b7ef0549e..2544caa1ff91 100644
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
@@ -75,6 +80,7 @@ struct wwan_device {
  * @headroom_len: SKB reserved headroom size
  * @frag_len: Length to fragment packet
  * @at_data: AT port specific data
+ * @gnss: Pointer to GNSS device associated with this port
  */
 struct wwan_port {
 	enum wwan_port_type type;
@@ -93,9 +99,16 @@ struct wwan_port {
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
@@ -339,6 +352,7 @@ static const struct {
 		.name = "MIPC",
 		.devsuf = "mipc",
 	},
+	/* WWAN_PORT_NMEA is exported via the GNSS subsystem */
 };
 
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
@@ -489,6 +503,124 @@ static void wwan_port_unregister_wwan(struct wwan_port *port)
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
+	 * then we should dynamically map WWAN port type to GNSS type.
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
@@ -529,7 +661,11 @@ struct wwan_port *wwan_create_port(struct device *parent,
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
 
@@ -559,7 +695,10 @@ void wwan_remove_port(struct wwan_port *port)
 	wake_up_interruptible(&port->waitqueue);
 	skb_queue_purge(&port->rxq);
 
-	wwan_port_unregister_wwan(port);
+	if (port->type == WWAN_PORT_NMEA)
+		wwan_port_unregister_gnss(port);
+	else
+		wwan_port_unregister_wwan(port);
 
 	put_device(&port->dev);
 
@@ -570,8 +709,15 @@ EXPORT_SYMBOL_GPL(wwan_remove_port);
 
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
2.52.0


