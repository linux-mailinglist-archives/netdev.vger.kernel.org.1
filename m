Return-Path: <netdev+bounces-250149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B24D2452D
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BAF593018E9F
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7B73570AF;
	Thu, 15 Jan 2026 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JpyG8zbF"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC737BE95;
	Thu, 15 Jan 2026 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477688; cv=none; b=KXvm2KByo2Ah/DTahqvbT3z3cAj6+Inu2sVuzgtUIRqFNXw5oilckSl2/LZOj08YIhEji12xrqB5O/5iWkzwxWLuBRY1dqjb+1IlnL795ggzsW9LD0ZgBvbCQm2hJebSMWFCcdMMx6spefChfmYTDIwqVNxkUlZwyymDiHROJH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477688; c=relaxed/simple;
	bh=0jJOMxzLsMb17DtgbKdwfIg16N7cV5nNPrbp2xfSBxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gt7gC0Texww5ftqkJUzWU9NygI8YSvh7luN1SYRLn9V6HWeA4mtzkHHQEWc5o704OfvT6rr7GFJwBoaGTK/mhHsvSGBoJWAl2YZIleji1VAzew7nATr4DjElI9uuu3yXHNcNeHOlBH/fvCX7V5GjlpxZ76RVH4pz/cvZT3c9xfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JpyG8zbF; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Lp
	Y+aJmoEhOG44KQ3VdTvnBgg4wtPWt0VenoOwUOBcE=; b=JpyG8zbFdtP0tzb/XE
	+4JGF1d2Mpy6QwjQx0frnOD+Kg5Wvb/VPbq9Ns+PRNnOANM4k43knY/XsMoV5U9B
	Zx//7r8+3+VPYePB8w6VQL+FVjhbrpSZjk55ss16+adTL5AMe2EdkBgf8SwKhZ9Q
	rh5a6SbkCvrUImWSZix5Uim78=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHLGiX02hpr2PzGQ--.4331S7;
	Thu, 15 Jan 2026 19:46:47 +0800 (CST)
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
	slark_xiao@163.com,
	Muhammad Nuzaihan <zaihan@unrealasia.net>,
	Qiang Yu <quic_qianyu@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: [net-next v7 5/8] net: wwan: add NMEA port support
Date: Thu, 15 Jan 2026 19:46:22 +0800
Message-Id: <20260115114625.46991-6-slark_xiao@163.com>
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
X-CM-TRANSID:_____wBHLGiX02hpr2PzGQ--.4331S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxKrW8uF4rWw1kXw17CFW5GFg_yoWfAry3pa
	yqga45KrZ5JF47Wr47JF42vFWY93WxCryxtry8W34Skr1UtryFvaykuFyqyFy5JrZ7uFya
	krZ5KFW09345CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRAHUhUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC5weS9mlo06f82AAA3V

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

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

>From the WWAN device driver perspective, a NMEA port is registered as a
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
index ae91b1cd7142..c50f1fad17a5 100644
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
@@ -336,6 +349,7 @@ static const struct {
 		.name = "MIPC",
 		.devsuf = "mipc",
 	},
+	/* WWAN_PORT_NMEA is exported via the GNSS subsystem */
 };
 
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
@@ -486,6 +500,124 @@ static void wwan_port_unregister_wwan(struct wwan_port *port)
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
@@ -526,7 +658,11 @@ struct wwan_port *wwan_create_port(struct device *parent,
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
 
@@ -556,7 +692,10 @@ void wwan_remove_port(struct wwan_port *port)
 	wake_up_interruptible(&port->waitqueue);
 	skb_queue_purge(&port->rxq);
 
-	wwan_port_unregister_wwan(port);
+	if (port->type == WWAN_PORT_NMEA)
+		wwan_port_unregister_gnss(port);
+	else
+		wwan_port_unregister_wwan(port);
 
 	put_device(&port->dev);
 
@@ -567,8 +706,15 @@ EXPORT_SYMBOL_GPL(wwan_remove_port);
 
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
2.25.1


