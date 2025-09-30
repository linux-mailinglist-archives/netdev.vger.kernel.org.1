Return-Path: <netdev+bounces-227289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A8BABF5B
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D77E16360B
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 08:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8332F3C16;
	Tue, 30 Sep 2025 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FH4LbkZf"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180562E9751;
	Tue, 30 Sep 2025 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219713; cv=none; b=PJaZurhSm64clLfqa4CgH8khTyfBpvcyZ4oZG6PJu5nXkIdSAfz+3eY8cpmyBZVHJ9toK/giucC8upF9a9vU0JFHBA8WZnZQIak2mx8e1koWN0pd9Rb9uNLolsEUGRbdncanR3+2SJTeCLkf3DftjlgDZnK89PZ1WhG5c0g71Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219713; c=relaxed/simple;
	bh=Zl2vQyHXHwEKneFtSe3nmzTPa5fj4Gc5H0bEyI/g58M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmHDyp+XrEhgCIuOzTiX4ro9OFm7tUIO2wm/FW26aPIiv/rOb1m1O/Ha5H9xoWHBWEpFktywpRAhbALZM8qqfiqYfrcF+LBoo3RgZF4nxyQ137e0rVSQEySVpgftu+jy+6Ew0wUZu51dLZpOXq4jEMash1sJC4NNyc8O7dZDBKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FH4LbkZf; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=AJEDwP6GBAKTUpkc+kWWJAcmMiCJ3mfiYjqw7FWgEQg=;
	b=FH4LbkZfmYC7w0Nf/hfsr3ve+5e7B7f1vwxI0qdNzbON1My7jlPDh2XNAZvYeS
	eMi4Z7lxUWOFaA6BHb0bAjTb8hd6Y34NGqjvfvR/ZP4yFuVwP9/Rsuzkcr2AnGrn
	94fGQzZrptKddia3G85V8TQWEo+Uu9twCR4T5MVT2sNgc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgC3N+Gvj9towMZUAg--.26308S3;
	Tue, 30 Sep 2025 16:07:13 +0800 (CST)
From: yicongsrfy@163.com
To: oneukum@suse.com,
	andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-usb@vger.kernel.org,
	marcan@marcan.st,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	yicong@kylinos.cn
Subject: [PATCH v4 2/3] net: usb: support quirks in cdc_ncm
Date: Tue, 30 Sep 2025 16:07:08 +0800
Message-Id: <20250930080709.3408463-2-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250930080709.3408463-1-yicongsrfy@163.com>
References: <5a3b2616-fcfd-483a-81a4-34dd3493a97c@suse.com>
 <20250930080709.3408463-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgC3N+Gvj9towMZUAg--.26308S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFWkXrWDXr1fWr45Ar45GFg_yoW7CFWrpa
	1YkFZYyrsrGw15Ja4xJr48uFWrXw4vy3yUG347GasxZ39ay3Z5tr1Ut3yFvF9rtr4rX3Wa
	vF1UW3yjgr45A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j42NtUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBFBHY22jbjuYa4AAAsn

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
v3: Add checking whether the CONFIG_USB_NET_AX88179_178A is enabled
v4: Move quirks from usbnet.ko to cdc_ncm.ko

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/usb/cdc_ncm.c        | 15 +++++++++++-
 drivers/net/usb/cdc_ncm_quirks.h | 41 ++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/usb/cdc_ncm_quirks.h

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 5d123df0a866..fc8416af3f11 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -54,6 +54,8 @@
 #include <linux/usb/cdc.h>
 #include <linux/usb/cdc_ncm.h>
 
+#include "cdc_ncm_quirks.h"
+
 #if IS_ENABLED(CONFIG_USB_NET_CDC_MBIM)
 static bool prefer_mbim = true;
 #else
@@ -2114,10 +2116,21 @@ static const struct usb_device_id cdc_devs[] = {
 };
 MODULE_DEVICE_TABLE(usb, cdc_devs);
 
+static int cdc_ncm_probe(struct usb_interface *intf, const struct usb_device_id *prod)
+{
+	/* Should it be ignored? */
+	if (unlikely(cdc_ncm_ignore(intf))) {
+		dev_dbg(&intf->dev, "cdc_ncm ignore this device!\n");
+		return -ENODEV;
+	}
+
+	return usbnet_probe(intf, prod);
+}
+
 static struct usb_driver cdc_ncm_driver = {
 	.name = "cdc_ncm",
 	.id_table = cdc_devs,
-	.probe = usbnet_probe,
+	.probe = cdc_ncm_probe,
 	.disconnect = usbnet_disconnect,
 	.suspend = usbnet_suspend,
 	.resume = usbnet_resume,
diff --git a/drivers/net/usb/cdc_ncm_quirks.h b/drivers/net/usb/cdc_ncm_quirks.h
new file mode 100644
index 000000000000..e5ae2265b1d7
--- /dev/null
+++ b/drivers/net/usb/cdc_ncm_quirks.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A collection of chip information to be ignored
+ */
+
+#ifndef __CDC_NCM_IGNORE_H__
+#define __CDC_NCM_IGNORE_H__
+
+#include <linux/usb.h>
+
+/* cdc_ncm_ignore_list:
+ * Chip info which already support int vendor specific driver,
+ * and then should be ignored in generic cdc_ncm
+ */
+static const struct usb_device_id cdc_ncm_ignore_list[] = {
+#if IS_ENABLED(CONFIG_USB_NET_AX88179_178A)
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
+#endif
+
+	{ } /*END*/
+};
+
+static inline bool cdc_ncm_ignore(struct usb_interface *intf)
+{
+	return !!usb_match_id(intf, cdc_ncm_ignore_list);
+}
+#endif
-- 
2.25.1


