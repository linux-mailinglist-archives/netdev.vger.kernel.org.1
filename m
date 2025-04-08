Return-Path: <netdev+bounces-180516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F44A8195F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1883AE310
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE832566FC;
	Tue,  8 Apr 2025 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+GjlfpI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C84256C89
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 23:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744155090; cv=none; b=R1EHdyUQaToxTJbBgrJrvQbkFfhrettVXgePxbAhTI8eee7eleO3onttgYFohCuWZAB/kCFyVJ9fKWr2oClXEdLUuoamQ5tUmjh1GkItckAGABxZD9W4nuaTM2399Hvct0/DiyVEyGBWtoyyL1ZL5FBqqAZvbxsWIDGdHbbkyVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744155090; c=relaxed/simple;
	bh=Yq2F+JhhVS+VEr5i+NNd/c6pMQhHUuV5PM9ZpC8RQ+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJI+l+ZLNQO51qQ3JRIcQWyRTHOaq/F0Ou62btUIaVeHMF7c3/vjGcIA/UuYXW6QZaJ3zLllsGzm8jRrOz96Inhc+Z7MFEH9DpNnK+lwLbz6C59bnwBta/sJ9ecZWvTmW/QYqwkwIJDKXEVcdgY5rcx3Lg2SeR5UkrP5rDALKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+GjlfpI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso35049635e9.3
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 16:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744155087; x=1744759887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MyDJyX1ZQSDfubkwfUus6597VNTaTqeUf1zt8BS+qw=;
        b=m+GjlfpI+jDYlvPValQDij0wiGGhLl2CrcCpEFRExv7SYxIg4h75M77uwWNyIP8QAu
         OcOQZvMkBdmnXI+zGndJS0sz7edtrGUqR60R5i609xZm2aR/+VDNcV7mdkB7hR9FhlxQ
         GvnjTiUzrNkydQHHLpOrxm8tWTil0Mg3MXWFD84Iq+lsORtIo3kQlfKDoVz+GWdAAg3C
         upq3jLhjwNzmhPfhCbrGu0XSmrgRCF1CfzxPDQhXh+VnB07SpkclmwxEJ7RD1kMXkCYD
         +8G/fVrN+BZv4QVRzR/7B3QfCpes2RrQFlqmSohMkIsoUPm3qNyJ7VU/ZdG/OGCRyjhS
         wjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744155087; x=1744759887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MyDJyX1ZQSDfubkwfUus6597VNTaTqeUf1zt8BS+qw=;
        b=UjOOwABQ0DnKHwiX4Evdf1watNV1eRjvoVNqFNmzLM+ND2kkeQVSQVCVg5KbVUGJ6F
         ymCQJWhX0YRAoYO5+KWKtixlpTaQWitAN7dHiOA2Z2eTUTh3uUWZswULdiL04Myo7IbC
         O2G8Y8Mdl9DFU44VYBJrph5qpFEIR922PV0N5ZvO6+pGBpZVB30Ft9SR4mqkcH/94Ys9
         B1nUjlvhHY+E/Db6OTHkeoLwx+AwDWte0j2yP1vrQXI5Zi5fygA6rIr03rGC7aB4ax6T
         Z66lIK5qZNERDaBsUm8HN7WfwVP5Fj5W7Nn19U8hUWfB71bzKa7tb7qG3DVntOIG8sb6
         Hcbg==
X-Forwarded-Encrypted: i=1; AJvYcCWCF2f0Zv4lY4167NbZIALYWpvbsMgWxfRH2aC+SPZDjNC8g9KiXCyUnC2J+hQfQHUWy7KB57k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNR3K4uDbdGN1PePmihPKUmp/2VrAteNGmmXZrz0oJaMBOiAzV
	48ZHpv1KKuqfNnQtz+sanPM5btRJxJZMTJ0wBZDoYi8aNp0zgTDu
X-Gm-Gg: ASbGnct44TrDSTqjNyip5BVp7GxZ+HeNe2oQAcf3jONGmbfu3Lg0qEaIMBXvyABowc3
	IABjk01LhDm81p0tU1RVFXAKh7QBz7OUiF7dHFEGqhlnJe8xs7iPd7pcXwHfOZiiIMjf0nCeW/5
	PkaQhsGKb1q5migQGJezkSLC+umiwRL5o1veAkpX+4ypb/N89SMTvdOvima5i/xgfiuDp85T1zZ
	zZzQ2S1pJMTnf+Uk3QYsCZ3/N8OTAnM7GTDj+rMlL14GLYoWAGarzptRu7KLXV36Z6yI6BeDYqz
	XwJkaP7GbVsJksEoVW5TFwFBsZcUJZilvOi213OOtGGHH0KoE5SBG94VBt8=
X-Google-Smtp-Source: AGHT+IFZpCfBkAx5bBOF8RWA4ZP/B9NzhoLRLi4T7lNzvc7+tl2DKGmnc5yq3Yz4Kog25nV/bl/nWQ==
X-Received: by 2002:a05:600c:1c02:b0:43b:c5a3:2e1a with SMTP id 5b1f17b1804b1-43f1ec7cc9cmr7770385e9.2.1744155086645;
        Tue, 08 Apr 2025 16:31:26 -0700 (PDT)
Received: from localhost.localdomain ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d75ac6d66sm9934565f8f.14.2025.04.08.16.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 16:31:26 -0700 (PDT)
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
Subject: [RFC PATCH 4/6] net: wwan: add NMEA port support
Date: Wed,  9 Apr 2025 02:31:16 +0300
Message-ID: <20250408233118.21452-5-ryazanov.s.a@gmail.com>
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
 drivers/net/wwan/wwan_core.c | 157 ++++++++++++++++++++++++++++++++++-
 include/linux/wwan.h         |   2 +
 3 files changed, 156 insertions(+), 4 deletions(-)

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
index 439a57bc2b9c..a30f0c89aa82 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/termios.h>
+#include <linux/gnss.h>
 #include <linux/wwan.h>
 #include <net/rtnetlink.h>
 #include <uapi/linux/wwan.h>
@@ -89,9 +90,16 @@ struct wwan_port {
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
@@ -340,6 +348,7 @@ static const struct {
 		.name = "MIPC",
 		.devsuf = "mipc",
 	},
+	/* WWAN_PORT_NMEA is exported via the GNSS subsystem */
 };
 
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
@@ -498,6 +507,132 @@ static void wwan_port_unregister_wwan(struct wwan_port *port)
 	device_unregister(&port->dev);
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
+static int wwan_port_register_gnss(struct wwan_port *port)
+{
+	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
+	struct gnss_device *gdev;
+	int err;
+
+	gdev = gnss_allocate_device(&wwandev->dev);
+	if (!gdev) {
+		err = -ENOMEM;
+		goto error_destroy_port;
+	}
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
+		goto error_destroy_port;
+	}
+
+	dev_info(&wwandev->dev, "port %s attached\n", dev_name(&gdev->dev));
+
+	return 0;
+
+error_destroy_port:
+	__wwan_port_destroy(port);
+
+	return err;
+}
+
+static void wwan_port_unregister_gnss(struct wwan_port *port)
+{
+	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
+	struct gnss_device *gdev = port->gnss;
+
+	dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&gdev->dev));
+
+	gnss_deregister_device(gdev);
+	gnss_put_device(gdev);
+
+	__wwan_port_destroy(port);
+}
+#else
+static inline int wwan_port_register_gnss(struct wwan_port *port)
+{
+	__wwan_port_destroy(port);
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
@@ -536,7 +671,11 @@ struct wwan_port *wwan_create_port(struct device *parent,
 	port->dev.parent = &wwandev->dev;
 	dev_set_drvdata(&port->dev, drvdata);
 
-	err = wwan_port_register_wwan(port);
+	if (port->type == WWAN_PORT_NMEA)
+		err = wwan_port_register_gnss(port);
+	else
+		err = wwan_port_register_wwan(port);
+
 	if (err)
 		goto error_wwandev_remove;
 
@@ -564,7 +703,10 @@ void wwan_remove_port(struct wwan_port *port)
 	wake_up_interruptible(&port->waitqueue);
 	skb_queue_purge(&port->rxq);
 
-	wwan_port_unregister_wwan(port);
+	if (port->type == WWAN_PORT_NMEA)
+		wwan_port_unregister_gnss(port);
+	else
+		wwan_port_unregister_wwan(port);
 
 	/* Release related wwan device */
 	wwan_remove_dev(wwandev);
@@ -573,8 +715,15 @@ EXPORT_SYMBOL_GPL(wwan_remove_port);
 
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
2.45.3


