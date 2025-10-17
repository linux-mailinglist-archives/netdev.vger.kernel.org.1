Return-Path: <netdev+bounces-230283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B17BE62E9
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 05:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E78B1A620F6
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 03:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FB0246BA9;
	Fri, 17 Oct 2025 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FYiIsaIp"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81937DF49;
	Fri, 17 Oct 2025 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760670322; cv=none; b=lDoP7bAZLk9D6uQ4mBnaFxdVRdbyG9M5Mid9AeXU0NKHKplAXUhX7vQMYaSaRBrd3hc/Zk4zWFcHeEX+8QKXNG4kVdAiv3yzC9z9MUZ19ShRzQyy730qqe0GjDFvQiKv8B8AM7VJ85NdoyL354oHlu9CKir9JFiDCXSsiYEze4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760670322; c=relaxed/simple;
	bh=I1xB4VaiyzRINcR1oROgy0/pJujGXcgapvyJ7R0q0WI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uyhwhxD1E+MYK2eYe1oFkJxywUZIS5qKpdHhT4Xno2uhmPxjnctr/BkUqF/olPo0E5qeJG+JQR6cYj/zw0hF/Q8jArjy9yNgSngix4e0ETfKwi9/Q1OzsDuilScE8LFU6ur84ff+5Hrx0YOQNjigrF6CYHpSUgXImIZqouv1xJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FYiIsaIp; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nq
	5YXELsgHQq0CxtBYWvBU4CiQfXeFNf0YlIUX4EB+w=; b=FYiIsaIpJfirMsvGyK
	0Hvs3vQ9qYeBJG3SoWPmKE2fyFN5wazUDrcVK+nN08404GUnTFMvQipwZCEpRQEt
	mReJCaChRE+Mmq3Rcph+iipoGYitRmm+zgpFYzYo52l00EmWSUG+5sdgQUtaJ3YI
	qz8XnaeykEY7jSBnhKjJIqkrw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAn2XPOr_FoPz7CAQ--.949S4;
	Fri, 17 Oct 2025 10:54:10 +0800 (CST)
From: yicongsrfy@163.com
To: michal.pecio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	oliver@neukum.org,
	pabeni@redhat.com
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: [PATCH net v6 2/3] net: usb: ax88179_178a: add USB device driver for config selection
Date: Fri, 17 Oct 2025 10:54:03 +0800
Message-Id: <20251017025404.1962110-3-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017025404.1962110-1-yicongsrfy@163.com>
References: <20251017025404.1962110-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAn2XPOr_FoPz7CAQ--.949S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFy8WFWUCFy3XF18Cw17ZFb_yoW5uFWfpF
	Wjgry5Cr47JrWfJws3J3ykZFy5uan2ka9F9r1xt3Wa9rZ3A34xtw1kKFy5ZF1DGrW8XFy2
	vw4rKF4a9r4DCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIPfQUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiLALp22jxqzyN9AAAsr

From: Yi Cong <yicong@kylinos.cn>

A similar reason was raised in commit ec51fbd1b8a2 ("r8152: add USB
device driver for config selection"):
Linux prioritizes probing non-vendor-specific configurations.

Referring to the implementation of this patch, cfgselect is also
used for ax88179 to override the default configuration selection.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Link: https://lore.kernel.org/all/20251011075314.572741-1-yicongsrfy@163.com/
Link: https://lore.kernel.org/all/20250928014631.2832243-1-yicongsrfy@163.com/

---
v2: fix warning from checkpatch.
v5: 1. use KBUILD_MODNAME to obtain the module name.
    2. add error handling when usb_register fail.
    3. use .choose_configuration instead of .probe.
    4. reorder deregister logic.
v6: 1. modify the registration order.
    2. fix error return value.
    3. delete unuse check in probe.
---
 drivers/net/usb/ax88179_178a.c | 58 ++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index b034ef8a73ea..bad306a68644 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1941,7 +1941,7 @@ static const struct usb_device_id products[] = {
 MODULE_DEVICE_TABLE(usb, products);
 
 static struct usb_driver ax88179_178a_driver = {
-	.name =		"ax88179_178a",
+	.name =		KBUILD_MODNAME,
 	.id_table =	products,
 	.probe =	usbnet_probe,
 	.suspend =	ax88179_suspend,
@@ -1952,7 +1952,61 @@ static struct usb_driver ax88179_178a_driver = {
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
+	ret = usb_register(&ax88179_178a_driver);
+	if (ret)
+		return ret;
+
+	ret = usb_register_device_driver(&ax88179_cfgselector_driver, THIS_MODULE);
+	if (ret)
+		usb_deregister(&ax88179_178a_driver);
+
+	return ret;
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


