Return-Path: <netdev+bounces-166379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AABA35C4E
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 12:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAEC3A68CC
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 11:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F4625D539;
	Fri, 14 Feb 2025 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yBd5SgQc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C698C245026
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531814; cv=none; b=fXIIGokfC5MvbigFKmfxqlvy5X1jrW5UFReQCPOJF8CF2CZ3XYqZaXMnivrxx8Uie5gR14Ho+sU4GPFZnu6+c5ARY7Rv8XaCCgcQ8PKmEAj/Uu+HXxuCnI4c6LjhARn3msyDcvKij1oFBqzMyF70ZLPJu3JnBbz5BKSwBuP8zUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531814; c=relaxed/simple;
	bh=MaOUxDW/eBvGxamf8FwedgMhuy6X6y2HuT6k6T1h6MU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GFeuk2av5ZBJquQP+zlEsApVESBUZ9C2iy+7QXkbAW5XPl2nRztvx3lKYzZlZsEdW3H+1iBOpKCF27pbXCpcfRmouP3z1tH1YuXR4Qd8b/Ll/yl9WOT7jgRONt6j+4fDOISyrvO6amRMTqZCiuFTZZ0I/ZDgNCPpChx75iipfUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yBd5SgQc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220d8aa893dso27184025ad.3
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 03:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739531812; x=1740136612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=76zcDfZJAShy1uAqpJD+Rqjmc6Ak37f0sv6fSF0nEvQ=;
        b=yBd5SgQcgJjO38tOlyt7Ofg4YKz4LaS3se4Ery82oFK+ED9a+11e7g0G1WVzjRf8Q1
         ziokItAsqNYW4iub6f0ZXJSWeMSuk/sk6dpVPCeXEqpuTaCUueR0WFEMMc5ad7z0Ep5X
         1emMNkjeOS6Me50hiqYLutcW+9lvO0yNFmm1+Wsne+VucakFkXqOpwzSBnlJVAajjmIM
         0vAubXR7yAb4rV8QBB1WuTv6AB/0yhlzCm9K4pjQvEzVuYu0ymzwHVP+BuTAPrsc162n
         vNGTg43Jk9r5vpwZrgXmQS5itRkf5qxwZyOHM0z4sFWQ64T4VtaVDok9HmAAoYEandUH
         yujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739531812; x=1740136612;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76zcDfZJAShy1uAqpJD+Rqjmc6Ak37f0sv6fSF0nEvQ=;
        b=FNuXKc326vL46lki/PoT9Eba0CG6kCiOIYLMP99wTq8JmD0QD8CeRscBL4FcaiCbw3
         2iGOnuuGnn5vaEa1wooaBI4pR5FWnBWQa/JA1kFxzq1m6KH5Gs6f9wdAF5hQy6ZQV8xo
         Bx0RVf+ZqPlzuTdietCBiS5+xIAK5nKwjX11AXWvKBfvMoWHozRMMaWKenF5eIFFLPjU
         xWczq95nKhoVLjSxOOtLdLWrvernzuR/NDe/+yq7rwLMnojBadoctayt7fcCGp4D0Crx
         CQKujYeVd4umHqSjA8fKbmdRrFN67zCcmEVFETYU6LM3R1cigEBYQ0YI4MFqwzu6r74G
         xKJw==
X-Forwarded-Encrypted: i=1; AJvYcCVWjZLzUHS52B1QWU2gUdKY/RiDu23M50WnTSkbWrwWsKDpaUj7Wjcp4KJT8mb01GSJ/N8/slY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo2Fyrl5bK2/fC1xGI7UKHM7tfyrhacQ3ZkkP2QwIhXzx1EPK/
	T2cM3gq/VEVF18ujAlWcpHhJzk+CRVBBdOkpVPuuZSSFLkprfRXI0qNl55CIeaTY8wcSclGdVhG
	X/dCdpg==
X-Google-Smtp-Source: AGHT+IHrd+L+SHgv9Z0BHGYO92JTFuNtoVvwppcXvz6tejven4Ja+Pk8+Ka+Ddl5poJmXJB892jtfhWD/eaW
X-Received: from pfan14.prod.google.com ([2002:aa7:8a4e:0:b0:730:7648:7a74])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7290:b0:1ee:6a20:176f
 with SMTP id adf61e73a8af0-1ee6b401442mr13260153637.39.1739531812084; Fri, 14
 Feb 2025 03:16:52 -0800 (PST)
Date: Fri, 14 Feb 2025 19:16:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214191615.v5.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Subject: [PATCH v5] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	gregkh@linuxfoundation.org
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Expose the isoc_alt attr with device group to avoid the racing.

Now we create a dev node for btusb. The isoc_alt attr belongs to it and
it also becomes the parent device of hci dev.

Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

Changes in v5:
- Merge the ABI doc into this patch
- Manage the driver data with device

Changes in v4:
- Create a dev node for btusb. It's now hci dev's parent and the
  isoc_alt now belongs to it.
- Since the changes is almost limitted in btusb, no need to add the
  callbacks in hdev anymore.

Changes in v3:
- Make the attribute exported only when the isoc_alt is available.
- In btusb_probe, determine data->isoc before calling hci_alloc_dev_priv
  (which calls hci_init_sysfs).
- Since hci_init_sysfs is called before btusb could modify the hdev,
  add new argument add_isoc_alt_attr for btusb to inform hci_init_sysfs.

Changes in v2:
- The patch has been removed from series

 .../ABI/stable/sysfs-class-bluetooth          |  13 ++
 drivers/bluetooth/btusb.c                     | 111 ++++++++++++++----
 include/net/bluetooth/hci_core.h              |   1 +
 net/bluetooth/hci_sysfs.c                     |   3 +-
 4 files changed, 102 insertions(+), 26 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentation/ABI/stable/sysfs-class-bluetooth
index 36be02471174..c1024c7c4634 100644
--- a/Documentation/ABI/stable/sysfs-class-bluetooth
+++ b/Documentation/ABI/stable/sysfs-class-bluetooth
@@ -7,3 +7,16 @@ Description: 	This write-only attribute allows users to trigger the vendor reset
 		The reset may or may not be done through the device transport
 		(e.g., UART/USB), and can also be done through an out-of-band
 		approach such as GPIO.
+
+What:		/sys/class/bluetooth/btusb<usb-intf>/isoc_alt
+Date:		13-Feb-2025
+KernelVersion:	6.13
+Contact:	linux-bluetooth@vger.kernel.org
+Description:	This attribute allows users to configure the USB Alternate setting
+		for the specific HCI device. Reading this attribute returns the
+		current setting, and writing any supported numbers would change
+		the setting. See the USB Alternate setting definition in Bluetooth
+		core spec 5, vol 4, part B, table 2.1.
+		If the HCI device is not yet init-ed, the write fails with -ENODEV.
+		If the data is not a valid number, the write fails with -EINVAL.
+		The other failures are vendor specific.
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1caf7a071a73..e2fb3d08a5ed 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -920,6 +920,8 @@ struct btusb_data {
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
 
 	struct qca_dump_info qca_dump;
+
+	struct device dev;
 };
 
 static void btusb_reset(struct hci_dev *hdev)
@@ -3693,6 +3695,9 @@ static ssize_t isoc_alt_store(struct device *dev,
 	int alt;
 	int ret;
 
+	if (!data->hdev)
+		return -ENODEV;
+
 	if (kstrtoint(buf, 10, &alt))
 		return -EINVAL;
 
@@ -3702,6 +3707,36 @@ static ssize_t isoc_alt_store(struct device *dev,
 
 static DEVICE_ATTR_RW(isoc_alt);
 
+static struct attribute *btusb_sysfs_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(btusb_sysfs);
+
+static void btusb_sysfs_release(struct device *dev)
+{
+	struct btusb_data *data = dev_get_drvdata(dev);
+
+	kfree(data);
+}
+
+static const struct device_type btusb_sysfs = {
+	.name    = "btusb",
+	.release = btusb_sysfs_release,
+	.groups  = btusb_sysfs_groups,
+};
+
+static struct attribute *btusb_sysfs_isoc_alt_attrs[] = {
+	&dev_attr_isoc_alt.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(btusb_sysfs_isoc_alt);
+
+static const struct device_type btusb_sysfs_isoc_alt = {
+	.name    = "btusb",
+	.release = btusb_sysfs_release,
+	.groups  = btusb_sysfs_isoc_alt_groups,
+};
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -3743,7 +3778,7 @@ static int btusb_probe(struct usb_interface *intf,
 			return -ENODEV;
 	}
 
-	data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -3766,8 +3801,10 @@ static int btusb_probe(struct usb_interface *intf,
 		}
 	}
 
-	if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep)
-		return -ENODEV;
+	if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep) {
+		err = -ENODEV;
+		goto out_free_data;
+	}
 
 	if (id->driver_info & BTUSB_AMP) {
 		data->cmdreq_type = USB_TYPE_CLASS | 0x01;
@@ -3821,16 +3858,47 @@ static int btusb_probe(struct usb_interface *intf,
 
 	data->recv_acl = hci_recv_frame;
 
+	if (id->driver_info & BTUSB_AMP) {
+		/* AMP controllers do not support SCO packets */
+		data->isoc = NULL;
+	} else {
+		/* Interface orders are hardcoded in the specification */
+		data->isoc = usb_ifnum_to_if(data->udev, ifnum_base + 1);
+		data->isoc_ifnum = ifnum_base + 1;
+	}
+
+	if (id->driver_info & BTUSB_BROKEN_ISOC)
+		data->isoc = NULL;
+
+	/* Init a dev for btusb. The attr depends on the support of isoc. */
+	if (data->isoc)
+		data->dev.type = &btusb_sysfs_isoc_alt;
+	else
+		data->dev.type = &btusb_sysfs;
+	data->dev.class = &bt_class;
+	data->dev.parent = &intf->dev;
+
+	err = dev_set_name(&data->dev, "btusb%s", dev_name(&intf->dev));
+	if (err)
+		goto out_free_data;
+
+	dev_set_drvdata(&data->dev, data);
+	err = device_register(&data->dev);
+	if (err < 0)
+		goto out_put_sysfs;
+
 	hdev = hci_alloc_dev_priv(priv_size);
-	if (!hdev)
-		return -ENOMEM;
+	if (!hdev) {
+		err = -ENOMEM;
+		goto out_free_sysfs;
+	}
 
 	hdev->bus = HCI_USB;
 	hci_set_drvdata(hdev, data);
 
 	data->hdev = hdev;
 
-	SET_HCIDEV_DEV(hdev, &intf->dev);
+	SET_HCIDEV_DEV(hdev, &data->dev);
 
 	reset_gpio = gpiod_get_optional(&data->udev->dev, "reset",
 					GPIOD_OUT_LOW);
@@ -3969,15 +4037,6 @@ static int btusb_probe(struct usb_interface *intf,
 		hci_set_msft_opcode(hdev, 0xFD70);
 	}
 
-	if (id->driver_info & BTUSB_AMP) {
-		/* AMP controllers do not support SCO packets */
-		data->isoc = NULL;
-	} else {
-		/* Interface orders are hardcoded in the specification */
-		data->isoc = usb_ifnum_to_if(data->udev, ifnum_base + 1);
-		data->isoc_ifnum = ifnum_base + 1;
-	}
-
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
 	    (id->driver_info & BTUSB_REALTEK)) {
 		btrtl_set_driver_name(hdev, btusb_driver.name);
@@ -4010,9 +4069,6 @@ static int btusb_probe(struct usb_interface *intf,
 			set_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirks);
 	}
 
-	if (id->driver_info & BTUSB_BROKEN_ISOC)
-		data->isoc = NULL;
-
 	if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
@@ -4065,10 +4121,6 @@ static int btusb_probe(struct usb_interface *intf,
 						 data->isoc, data);
 		if (err < 0)
 			goto out_free_dev;
-
-		err = device_create_file(&intf->dev, &dev_attr_isoc_alt);
-		if (err)
-			goto out_free_dev;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4099,6 +4151,16 @@ static int btusb_probe(struct usb_interface *intf,
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
 	hci_free_dev(hdev);
+
+out_free_sysfs:
+	device_del(&data->dev);
+
+out_put_sysfs:
+	put_device(&data->dev);
+	return err;
+
+out_free_data:
+	kfree(data);
 	return err;
 }
 
@@ -4115,10 +4177,8 @@ static void btusb_disconnect(struct usb_interface *intf)
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-	if (data->isoc) {
-		device_remove_file(&intf->dev, &dev_attr_isoc_alt);
+	if (data->isoc)
 		usb_set_intfdata(data->isoc, NULL);
-	}
 
 	if (data->diag)
 		usb_set_intfdata(data->diag, NULL);
@@ -4150,6 +4210,7 @@ static void btusb_disconnect(struct usb_interface *intf)
 		gpiod_put(data->reset_gpio);
 
 	hci_free_dev(hdev);
+	device_unregister(&data->dev);
 }
 
 #ifdef CONFIG_PM
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 05919848ea95..776dd6183509 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1843,6 +1843,7 @@ int hci_get_adv_monitor_offload_ext(struct hci_dev *hdev);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
+extern const struct class bt_class;
 void hci_init_sysfs(struct hci_dev *hdev);
 void hci_conn_init_sysfs(struct hci_conn *conn);
 void hci_conn_add_sysfs(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 041ce9adc378..aab3ffaa264c 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -6,9 +6,10 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-static const struct class bt_class = {
+const struct class bt_class = {
 	.name = "bluetooth",
 };
+EXPORT_SYMBOL(bt_class);
 
 static void bt_link_release(struct device *dev)
 {
-- 
2.48.1.601.g30ceb7b040-goog


