Return-Path: <netdev+bounces-228578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C4BBCF196
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 09:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9DE34E2B22
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 07:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D1123816C;
	Sat, 11 Oct 2025 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RGBuLmWS"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C4F1DF963;
	Sat, 11 Oct 2025 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760169249; cv=none; b=a37zSP/65Hp+mAyZPuQkGT1qjA8VHkq2MDnQ06oOj+gHGQq7oBzOuR3SEbje6h6howeKnvsvwN4FAbVyZkRYlsURMy1Gz1/YXKAFqPX4wM3bFknPJAeqxqUf2OyKm2chXySECyTMw34PbGPyWTZLLVysFF6qr2czxRRsxGcy5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760169249; c=relaxed/simple;
	bh=QCuBG31j7JNxgiRmeVMe7LjlOlUlW8gE0Wk+uZvSL3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOZMaciF05WxPM21jEM7ncXE9r68zCyw8T1fvnBpI1oAmlFx6JZamEP3lWTSoKaLlrdqsmFZbRRcDaYtEKK8JAik1vcR1chl6MqAkNPZdPpcvY96wBHQt+qY5vMQuLvKmA6nwmsbD5MxyB1IsjHbD5p9xH9+0AbQ7znfLA3G/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RGBuLmWS; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=3x5jY4dxpD3e0qjylTqUnYFYx0ZyeNE/xmjdYygE+4Y=;
	b=RGBuLmWSMnE9su+CsCZd51GCmvH4/HemleeG1uJKgfiqVwObMXhsu3JYEBy6as
	1E5hysoy8NhqzkAFskJpxvclcL4Yhp++PWfEh3y+pOWcTtPHwBQVHk19l2JINOev
	B3XGnsXWub4a4ltBHvbRBu35FNb2xE0LDZINNiT3nSrtg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v+TsDOpoK16yDQ--.50548S3;
	Sat, 11 Oct 2025 15:53:18 +0800 (CST)
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
Subject: [PATCH net v5 1/3] net: usb: support quirks in cdc_ncm
Date: Sat, 11 Oct 2025 15:53:12 +0800
Message-Id: <20251011075314.572741-2-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251011075314.572741-1-yicongsrfy@163.com>
References: <20251011075314.572741-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v+TsDOpoK16yDQ--.50548S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF1kWw4DKw4UKrWfWr1xZrb_yoW7JF1Upa
	15KrZYqr4DGw13Ja4fJr48ZFWrXw4vy3y5Gr17Ga43Z3yfA3Z0qr1Ut3yFvF9Fkr4rX3Wa
	vF1UG3yUWr4UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4JPiUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbixwnj22jqDAYVLgAAsF

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

Signed-off-by: Yi Cong <yicong@kylinos.cn>

---
v2: Correct the description of usbnet_quirks.h and modify the code style
v3: Add checking whether the CONFIG_USB_NET_AX88179_178A is enabled
v4: Move quirks from usbnet.ko to cdc_ncm.ko
v5: Move the ignored product information to cdc_ncm.c and delete the
    unlikely call in the if judgement
---
 drivers/net/usb/cdc_ncm.c | 44 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 5d123df0a866..7b68706b8a8a 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -2114,10 +2114,52 @@ static const struct usb_device_id cdc_devs[] = {
 };
 MODULE_DEVICE_TABLE(usb, cdc_devs);
 
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
+
+static int cdc_ncm_probe(struct usb_interface *intf, const struct usb_device_id *prod)
+{
+	/* Should it be ignored? */
+	if (cdc_ncm_ignore(intf)) {
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
-- 
2.25.1


