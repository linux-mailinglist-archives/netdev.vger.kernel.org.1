Return-Path: <netdev+bounces-228580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00244BCF1A5
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 09:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB52E407E45
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 07:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814F1236453;
	Sat, 11 Oct 2025 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AYyF8OWR"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A9F70810;
	Sat, 11 Oct 2025 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760169268; cv=none; b=J35QOTMpwwgsm1/mO7efKpC2GLenaHp1x5YuLhi55wdjNTWC92Y5tXXms8hKvF95j/5wpoJ6NlLmKXBTRiHV5Bd0vEVW/VcsvQmdVQResL4DAo5gll40ZCVcDl0ZYUlYx8TkHL0zVGlpJeWRYgLNJ2KaZl2WBIm7CaO0i1CiSWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760169268; c=relaxed/simple;
	bh=NoQshtyPyIOrmLvUvsXNS4UezgPud1r9nHRucyle4zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tIYYETF8+o/dzNEBLkDwkPFRsTQ3EPwypqaavuE4e5KFRc5nwyT5U/Fb/jDtFsxqlurHZiHDqeTjf9Th629k4qcJSGT8pcWnkviR6e0SmfqJcw8TKoaTf1Cvon3B7AGv3jigJRMY7kLImCy8qmyqbeTBmtTdoBX/sGPzknTSqos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AYyF8OWR; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bk
	v7o8c4Zo7M92+20h919XZ94Rn5T4Nx5NeYcOEh0xw=; b=AYyF8OWRQNsRFhqvxz
	y3MINYsmPagjc8cYr4C1dhxyh53jbL+hZLkt+Y26A9iBexm1zq3qaArRtwVykJ8j
	jWF8FhSti7NEOTxtyQdWGrhrA6LaHBXLAY8ozBwXOPouL+ok3ktGom7IQ3vpR9px
	u9ZBfV5slo3d8DAd+DLxcHDbg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v+TsDOpoK16yDQ--.50548S4;
	Sat, 11 Oct 2025 15:53:20 +0800 (CST)
From: yicongsrfy@163.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oliver@neukum.org
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver for config selection
Date: Sat, 11 Oct 2025 15:53:13 +0800
Message-Id: <20251011075314.572741-3-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251011075314.572741-1-yicongsrfy@163.com>
References: <20251011075314.572741-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v+TsDOpoK16yDQ--.50548S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4rJFWDGryfKry5Wr13CFg_yoW5KFy8pF
	4jg3s0yry7JFWfJrs3JrWkZFy5uan2kayq9r1ft3ZI9r93A34xta1ktFyYyF1DGrW8XF17
	ta1UKa13WF4UCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxHUgUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBzRjj22jqCTtOSgAAsZ

From: Yi Cong <yicong@kylinos.cn>

A similar reason was raised in commit ec51fbd1b8a2 ("r8152: add USB
device driver for config selection"):
Linux prioritizes probing non-vendor-specific configurations.

Referring to the implementation of this patch, cfgselect is also
used for ax88179 to override the default configuration selection.

Signed-off-by: Yi Cong <yicong@kylinos.cn>

---
v2: fix warning from checkpatch.
v5: 1. use KBUILD_MODNAME to obtain the module name.
    2. add error handling when usb_register fail.
    3. use .choose_configuration instead of .probe.
    4. reorder deregister logic.
---
 drivers/net/usb/ax88179_178a.c | 68 ++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index b034ef8a73ea..b6432d414a38 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1713,6 +1713,14 @@ static int ax88179_stop(struct usbnet *dev)
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
@@ -1941,9 +1949,9 @@ static const struct usb_device_id products[] = {
 MODULE_DEVICE_TABLE(usb, products);
 
 static struct usb_driver ax88179_178a_driver = {
-	.name =		"ax88179_178a",
+	.name =		KBUILD_MODNAME,
 	.id_table =	products,
-	.probe =	usbnet_probe,
+	.probe =	ax88179_probe,
 	.suspend =	ax88179_suspend,
 	.resume =	ax88179_resume,
 	.reset_resume =	ax88179_resume,
@@ -1952,7 +1960,61 @@ static struct usb_driver ax88179_178a_driver = {
 	.disable_hub_initiated_lpm = 1,
 };
 
-module_usb_driver(ax88179_178a_driver);
+static int ax88179_cfgselector_choose_configuration(struct usb_device *udev)
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
+	return c->desc.bConfigurationValue;
+}
+
+static struct usb_device_driver ax88179_cfgselector_driver = {
+	.name =	KBUILD_MODNAME "-cfgselector",
+	.choose_configuration =	ax88179_cfgselector_choose_configuration,
+	.id_table = products,
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
+
+	ret = usb_register(&ax88179_178a_driver);
+	if (ret)
+		usb_deregister_device_driver(&ax88179_cfgselector_driver);
+
+	return 0;
+}
+
+static void __exit ax88179_driver_exit(void)
+{
+	usb_deregister_device_driver(&ax88179_cfgselector_driver);
+	usb_deregister(&ax88179_178a_driver);
+}
+
+module_init(ax88179_driver_init);
+module_exit(ax88179_driver_exit);
 
 MODULE_DESCRIPTION("ASIX AX88179/178A based USB 3.0/2.0 Gigabit Ethernet Devices");
 MODULE_LICENSE("GPL");
-- 
2.25.1


