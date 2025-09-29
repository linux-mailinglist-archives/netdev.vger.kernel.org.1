Return-Path: <netdev+bounces-227077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16F1BA7FF9
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 07:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD0117F0A6
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 05:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E8729C321;
	Mon, 29 Sep 2025 05:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PYuMaitT"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4488194098;
	Mon, 29 Sep 2025 05:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759123959; cv=none; b=HXeu3bk20PNToq1n+2J10CsIuAHhgjiGZ+TBilsdowllmcTyvYtdNrUX6YLk/NZqzEIGFDWJY46zxPKVeyANFO+COf343L3p5Mse0oxlX3hMfsrmsLwyETFbylHY5Ap1xs8DdU8iOCxnuNOoSeTUb+AOVEytg65Unbq/BZROafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759123959; c=relaxed/simple;
	bh=6HmVmIYuYudlUs40qrk1qodJ1HwKiuOqNO5ENovFmyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jpQ7Is8n14mqWU6bQYGLvSlCbQ1oIDCT0L+i8SiWjHqk3rQ1zg2hF6hi9l6Yu6RLwT0IrkL8vOvUMQxja/iQaj49FkQH9qWdYbbyeE+pcT3TmZXEZ++MVB1HjFznBWQjKXRXS8geXe/JopIuH423dk61KHMVHp04MyUUUIG8t+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PYuMaitT; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=XY
	gf6HrtCahtEEE+sM4mAkh7OK58+m0DKAkOrq+Hjxg=; b=PYuMaitTBVmahfzj0k
	eIb/Doh5SFcgu363B4mUR+moQzZ2g9hg77xgsel5DoD5/gMFD1ctLy0406SW7ZJH
	gfheZCIaHJF5ohAK9xPOJKT7Rqu2g0J+yCwd5dfzJTFnV4Um0oDvFY9jGXNeE42b
	GXmE8ipAZ0wyaLCeoVZR91aN4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgB3p9vDGdpoadHeAQ--.6422S5;
	Mon, 29 Sep 2025 13:31:52 +0800 (CST)
From: yicongsrfy@163.com
To: oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Cc: marcan@marcan.st,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: [PATCH v2 3/3] net: usb: ax88179_178a: add USB device driver for config selection
Date: Mon, 29 Sep 2025 13:31:45 +0800
Message-Id: <20250929053145.3113394-4-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250929053145.3113394-1-yicongsrfy@163.com>
References: <20250928212351.3b5828c2@kernel.org>
 <20250929053145.3113394-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgB3p9vDGdpoadHeAQ--.6422S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4rJFWDGrWUJry3ArW7CFg_yoWrJFykpF
	4qgFy5KrW7Ja1fJrs3JrWkZFy5Zan2kw4v9ryxK3Wa9r93A3s7t3WkKry5ZF4DCrW8WF17
	ta1UJa13WF4UGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jvrWOUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBzR-X22jaEr2o5AAAsP

From: Yi Cong <yicong@kylinos.cn>

A similar reason was raised in ec51fbd1b8a2
(r8152: add USB device driver for config selection):
Linux prioritizes probing non-vendor-specific configurations.

Referring to the implementation of this patch, cfgselect is also
used for ax88179 to override the default configuration selection.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/usb/ax88179_178a.c | 72 ++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 29cbe9ddd610..965d2a66695d 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -14,6 +14,7 @@
 #include <uapi/linux/mdio.h>
 #include <linux/mdio.h>
 
+#define MODULENAME "ax88179_178a"
 #define AX88179_PHY_ID				0x03
 #define AX_EEPROM_LEN				0x100
 #define AX88179_EEPROM_MAGIC			0x17900b95
@@ -1713,6 +1714,16 @@ static int ax88179_stop(struct usbnet *dev)
 	return 0;
 }
 
+static int ax88179_probe(struct usb_interface *intf, const struct usb_device_id *i)
+{
+	if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC) {
+		printk("[YCDBG][%s:%d] bInterfaceClass:%d\n", __func__, __LINE__, intf->cur_altsetting->desc.bInterfaceClass);
+		return -ENODEV;
+	}
+
+	return usbnet_probe(intf, i);
+}
+
 static const struct driver_info ax88179_info = {
 	.description = "ASIX AX88179 USB 3.0 Gigabit Ethernet",
 	.bind = ax88179_bind,
@@ -1941,9 +1952,9 @@ static const struct usb_device_id products[] = {
 MODULE_DEVICE_TABLE(usb, products);
 
 static struct usb_driver ax88179_178a_driver = {
-	.name =		"ax88179_178a",
+	.name =		MODULENAME,
 	.id_table =	products,
-	.probe =	usbnet_probe,
+	.probe =	ax88179_probe,
 	.suspend =	ax88179_suspend,
 	.resume =	ax88179_resume,
 	.reset_resume =	ax88179_resume,
@@ -1952,7 +1963,62 @@ static struct usb_driver ax88179_178a_driver = {
 	.disable_hub_initiated_lpm = 1,
 };
 
-module_usb_driver(ax88179_178a_driver);
+static int ax88179_cfgselector_probe(struct usb_device *udev)
+{
+	struct usb_host_config *c;
+	int i, num_configs;
+
+	/* The vendor mode is not always config #1, so to find it out. */
+	c = udev->config;
+	num_configs = udev->descriptor.bNumConfigurations;
+	for (i = 0; i < num_configs; (i++, c++)) {
+		struct usb_interface_descriptor	*desc = NULL;
+
+		if (!c->desc.bNumInterfaces)
+			continue;
+		desc = &c->intf_cache[0]->altsetting->desc;
+		if (desc->bInterfaceClass == USB_CLASS_VENDOR_SPEC)
+			break;
+	}
+
+	if (i == num_configs)
+		return -ENODEV;
+
+	if (usb_set_configuration(udev, c->desc.bConfigurationValue)) {
+		dev_err(&udev->dev, "Failed to set configuration %d\n",
+			c->desc.bConfigurationValue);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static struct usb_device_driver ax88179_cfgselector_driver = {
+	.name =		MODULENAME "-cfgselector",
+	.probe =	ax88179_cfgselector_probe,
+	.id_table =	products,
+	.generic_subclass = 1,
+	.supports_autosuspend = 1,
+};
+
+static int __init ax88179_driver_init(void)
+{
+	int ret;
+
+	ret = usb_register_device_driver(&ax88179_cfgselector_driver, THIS_MODULE);
+	if (ret)
+		return ret;
+	return usb_register(&ax88179_178a_driver);
+}
+
+static void __exit ax88179_driver_exit(void)
+{
+	usb_deregister(&ax88179_178a_driver);
+	usb_deregister_device_driver(&ax88179_cfgselector_driver);
+}
+
+module_init(ax88179_driver_init);
+module_exit(ax88179_driver_exit);
 
 MODULE_DESCRIPTION("ASIX AX88179/178A based USB 3.0/2.0 Gigabit Ethernet Devices");
 MODULE_LICENSE("GPL");
-- 
2.25.1


