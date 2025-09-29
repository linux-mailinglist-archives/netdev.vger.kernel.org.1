Return-Path: <netdev+bounces-227078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CB4BA7FFF
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 07:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4813C288C
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 05:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45F729ACF7;
	Mon, 29 Sep 2025 05:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="a93KCOVE"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4CB299949;
	Mon, 29 Sep 2025 05:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759123961; cv=none; b=gvoP7SHSYaAEfKZZiloo6xONIvwYVYgQ4fnyM8q1r7qmLrenxH8yyKhpTPYW/vmR3smgEgFUV+3DZjZsygcuKZgWIFE4hYfebKCVrBX/1NhWX0cn8hTF+wRppKmWrsixYp+vpcsqTLwrSxYzthKCzI3XUUSaxmKUXlqFm6ix1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759123961; c=relaxed/simple;
	bh=1IN+0/WCU+ZzFXUEdEDmlfWREbCjx5cRN/Lb3FMKohg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvBKJ6ihwHqYJ5lb4aRL4DBBr1VOlexV4BIXn4uO/VoZQk+ahk1W+KvY/RmeyxdqlD5d+rjX2tkMW10NnDRjSBLVSI8rj/+uTGsVci1MyXj7hQ4bP1Vt5Z2TPE9FXPlANBFYNHGE0IVnRMqsS62hr634KndEeYQwqqQDt7Q5fwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=a93KCOVE; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=VZAsXZjn9YAWXKssUzLLREhGbgkyyuXB8Rl2wD3YeA4=;
	b=a93KCOVEv6dEP8amW9MVKVSlN10W8DmFtvfLulmVTlUrawsoS5qvohD8X7Gzf3
	dfkWO0OGbHqlEwm3R9ILNJdgFNWX1daO2P5832mWDQnuTzQJ34D6IyaatEr/g82P
	L/IlVCBDfOylWTe4le88mC6gFViqEjlmBRCP1gD01I3V4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgB3p9vDGdpoadHeAQ--.6422S4;
	Mon, 29 Sep 2025 13:31:50 +0800 (CST)
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
Subject: [PATCH v2 2/3] net: usb: support quirks in usbnet
Date: Mon, 29 Sep 2025 13:31:44 +0800
Message-Id: <20250929053145.3113394-3-yicongsrfy@163.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgB3p9vDGdpoadHeAQ--.6422S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFWkXF1UCF15uw1rZF13urg_yoWxWF13pa
	nxKrZayr4DJr45X34fJr48Za45Xw4kA3y7Cry7W3s3X3s7A34qqr1Ut3ySkF9FyrWrG3Wa
	vF1DW3yUWr15J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxa9-UUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBFA3X22jaEB7g0wAFsf

From: Yi Cong <yicong@kylinos.cn>

Some vendors' USB network interface controllers (NICs) may be compatible
with multiple drivers.

I consulted with relevant vendors. Taking the AX88179 chip as an example,
NICs based on this chip may be used across various OS—for instance,
cdc_ncm is used on macOS, while ax88179_178a.ko is the intended driver
on Linux (despite a previous patch having disabled it).
Therefore, the firmware must support multiple protocols.

Currently, both cdc_ncm and ax88179_178a coexist in the Linux kernel.
Supporting both drivers simultaneously leads to the following issues:

1. Inconsistent driver loading order during reboot stress testing:
   The order in which drivers are loaded can vary across reboots,
   potentially resulting in the unintended driver being loaded. For
   example:
[    4.239893] cdc_ncm 2-1:2.0: MAC-Address: c8:a3:62:ef:99:8e
[    4.239897] cdc_ncm 2-1:2.0: setting rx_max = 16384
[    4.240149] cdc_ncm 2-1:2.0: setting tx_max = 16384
[    4.240583] cdc_ncm 2-1:2.0 usb0: register 'cdc_ncm' at usb-
xxxxx:00-1, CDC NCM, c8:a3:62:ef:99:8e
[    4.240627] usbcore: registered new interface driver cdc_ncm
[    4.240908] usbcore: registered new interface driver ax88179_178a

In this case, network connectivity functions, but the cdc_ncm driver is
loaded instead of the expected ax88179_178a.

2. Similar issues during cable plug/unplug testing:
   The same race condition can occur when reconnecting the USB device:
[   79.879922] usb 4-1: new SuperSpeed USB device number 3 using xhci_hcd
[   79.905168] usb 4-1: New USB device found, idVendor=0b95, idProduct=
1790, bcdDevice= 2.00
[   79.905185] usb 4-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[   79.905191] usb 4-1: Product: AX88179B
[   79.905198] usb 4-1: Manufacturer: ASIX
[   79.905201] usb 4-1: SerialNumber: 00EF998E
[   79.915215] ax88179_probe, bConfigurationValue:2
[   79.952638] cdc_ncm 4-1:2.0: MAC-Address: c8:a3:62:ef:99:8e
[   79.952654] cdc_ncm 4-1:2.0: setting rx_max = 16384
[   79.952919] cdc_ncm 4-1:2.0: setting tx_max = 16384
[   79.953598] cdc_ncm 4-1:2.0 eth0: register 'cdc_ncm' at usb-0000:04:
00.2-1, CDC NCM (NO ZLP), c8:a3:62:ef:99:8e
[   79.954029] cdc_ncm 4-1:2.0 eth0: unregister 'cdc_ncm' usb-0000:04:
00.2-1, CDC NCM (NO ZLP)

At this point, the network becomes unusable.

To resolve these issues, introduce a *quirks* mechanism into the usbnet
module. By adding chip-specific identification within the generic usbnet
framework, we can skip the usbnet probe process for devices that require a
dedicated driver.

v2: Correct the description of usbnet_quirks.h and modify the code style

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/usb/cdc_ncm.c       |  2 +-
 drivers/net/usb/usbnet.c        | 14 ++++++++++++
 drivers/net/usb/usbnet_quirks.h | 39 +++++++++++++++++++++++++++++++++
 include/linux/usb/usbnet.h      |  2 ++
 4 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/usb/usbnet_quirks.h

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 5d123df0a866..6fa03e5bd054 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -2117,7 +2117,7 @@ MODULE_DEVICE_TABLE(usb, cdc_devs);
 static struct usb_driver cdc_ncm_driver = {
 	.name = "cdc_ncm",
 	.id_table = cdc_devs,
-	.probe = usbnet_probe,
+	.probe = usbnet_probe_quirks,
 	.disconnect = usbnet_disconnect,
 	.suspend = usbnet_suspend,
 	.resume = usbnet_resume,
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 511c4154cf74..51ba466057f9 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/pm_runtime.h>
 
+#include "usbnet_quirks.h"
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -1697,6 +1698,19 @@ static const struct device_type wwan_type = {
 	.name	= "wwan",
 };
 
+int usbnet_probe_quirks(struct usb_interface *udev,
+			const struct usb_device_id *prod)
+{
+	/* Should it be ignored? */
+	if (unlikely(usbnet_ignore(udev))) {
+		dev_dbg(&udev->dev, "usbnet ignore this device!\n");
+		return -ENODEV;
+	}
+
+	return usbnet_probe(udev, prod);
+}
+EXPORT_SYMBOL_GPL(usbnet_probe_quirks);
+
 int
 usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 {
diff --git a/drivers/net/usb/usbnet_quirks.h b/drivers/net/usb/usbnet_quirks.h
new file mode 100644
index 000000000000..5b0e52f6bf93
--- /dev/null
+++ b/drivers/net/usb/usbnet_quirks.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A collection of chip information to be ignored
+ */
+
+#ifndef __USB_NET_IGNORE_H__
+#define __USB_NET_IGNORE_H__
+
+#include <linux/usb.h>
+
+/* usbnet_ignore_list:
+ * Chip info which already support int vendor specific driver,
+ * and then should be ignored in generic usbnet
+ */
+static const struct usb_device_id usbnet_ignore_list[] = {
+	/* Chips already support in ax88179_178a.c */
+	{ USB_DEVICE(0x0b95, 0x1790) },
+	{ USB_DEVICE(0x0b95, 0x178a) },
+	{ USB_DEVICE(0x04b4, 0x3610) },
+	{ USB_DEVICE(0x2001, 0x4a00) },
+	{ USB_DEVICE(0x0df6, 0x0072) },
+	{ USB_DEVICE(0x04e8, 0xa100) },
+	{ USB_DEVICE(0x17ef, 0x304b) },
+	{ USB_DEVICE(0x050d, 0x0128) },
+	{ USB_DEVICE(0x0930, 0x0a13) },
+	{ USB_DEVICE(0x0711, 0x0179) },
+	{ USB_DEVICE(0x07c9, 0x000e) },
+	{ USB_DEVICE(0x07c9, 0x000f) },
+	{ USB_DEVICE(0x07c9, 0x0010) },
+	/* End of support in ax88179_178a.c */
+
+	{ } /*END*/
+};
+
+static inline bool usbnet_ignore(struct usb_interface *intf)
+{
+	return !!usb_match_id(intf, usbnet_ignore_list);
+}
+#endif
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index a2d54122823d..de198fcaf76d 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -188,6 +188,8 @@ struct driver_info {
  * much everything except custom framing and chip-specific stuff.
  */
 extern int usbnet_probe(struct usb_interface *, const struct usb_device_id *);
+extern int usbnet_probe_quirks(struct usb_interface *udev,
+			       const struct usb_device_id *prod);
 extern int usbnet_suspend(struct usb_interface *, pm_message_t);
 extern int usbnet_resume(struct usb_interface *);
 extern void usbnet_disconnect(struct usb_interface *);
-- 
2.25.1


