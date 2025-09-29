Return-Path: <netdev+bounces-227080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACE7BA802F
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 07:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4620F3AFE1F
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 05:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC5C29BD91;
	Mon, 29 Sep 2025 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iUBGJ/BQ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C0C29ACDD;
	Mon, 29 Sep 2025 05:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759124622; cv=none; b=i3dzrkaZCMKIkaV5eSdi9+tycOP7lCKW/EKTmLnKYyXXvElaIXo4OnLCW6zo9ge6RvDMzy9wlv1fpIaIs8b806mcI8XfJwwNuH6P2SaVeTozvrV2LQQnLzSbNWq+etinxGMop8zUtdnX3xvjRi01lznZh60NVYiYC8ENB7P6liI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759124622; c=relaxed/simple;
	bh=A8hSnozwrZ6u84etwYiLlGN46MNAswFgw/kuE4h2a5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VG10wd88l2+T1FodQ5xb83l8sjwXwmHXBTKBaDPHl89Dg73t+TCHezYkXY1nBNHEJuctVP4cXLq30403Kg17mCWppSu0QCmkMb46qvN4wM4SeVjXXdyZ3mDefzxEe8CIZ96UGuuaaUjaUaPXAoaLHlkAxcLmirx8wCWVilDJ8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iUBGJ/BQ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gp
	UbwNbQnfvLoVX63WNhLorivcOQ+ivqwrrVHACGIpM=; b=iUBGJ/BQuvl1XwS7J0
	GwWiZoAT3i3imzqdWG35iiTYU4p8HcStUoyxkP8WpkKkEJh0papldODFEiU7Tvn3
	+qT+PqtTNIIbAMHwvNi2c1Cr/Y7/b0fiGvvu471MeyrCWN0RiWebZgbQ/VxF5nA3
	R1Q7qebH+hqnbtRZEwq3ndeN4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3P+JYHNpoB1inAw--.10708S2;
	Mon, 29 Sep 2025 13:42:50 +0800 (CST)
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
Date: Mon, 29 Sep 2025 13:42:46 +0800
Message-Id: <20250929054246.3118527-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250929053145.3113394-4-yicongsrfy@163.com>
References: <20250929053145.3113394-4-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P+JYHNpoB1inAw--.10708S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw4DWryxGF48tw1rXw18Krg_yoW5Kw47pF
	4qgF90krW7JF4fJrs3JrWkZFy5Zan2k3yv9ryxK3Wa9r93A3s7t3WkKry5AF1DGrW8WF12
	ya1UJa13uF4UGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1BTOUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiUBnX22jaFpuELQAAsT

From: Yi Cong <yicong@kylinos.cn>

A similar reason was raised in commit ec51fbd1b8a2 ("r8152: add USB
device driver for config selection"):
Linux prioritizes probing non-vendor-specific configurations.

Referring to the implementation of this patch, cfgselect is also
used for ax88179 to override the default configuration selection.

v2: fix warning from checkpatch

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/usb/ax88179_178a.c | 70 ++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 29cbe9ddd610..f2e86b9256dc 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -14,6 +14,7 @@
 #include <uapi/linux/mdio.h>
 #include <linux/mdio.h>
 
+#define MODULENAME "ax88179_178a"
 #define AX88179_PHY_ID				0x03
 #define AX_EEPROM_LEN				0x100
 #define AX88179_EEPROM_MAGIC			0x17900b95
@@ -1713,6 +1714,14 @@ static int ax88179_stop(struct usbnet *dev)
 	return 0;
 }
 
+static int ax88179_probe(struct usb_interface *intf, const struct usb_device_id *i)
+{
+	if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
+		return -ENODEV;
+
+	return usbnet_probe(intf, i);
+}
+
 static const struct driver_info ax88179_info = {
 	.description = "ASIX AX88179 USB 3.0 Gigabit Ethernet",
 	.bind = ax88179_bind,
@@ -1941,9 +1950,9 @@ static const struct usb_device_id products[] = {
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
@@ -1952,7 +1961,62 @@ static struct usb_driver ax88179_178a_driver = {
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


