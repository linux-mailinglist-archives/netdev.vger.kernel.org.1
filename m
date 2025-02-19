Return-Path: <netdev+bounces-167566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9A0A3AF32
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7BE16770E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 01:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2203313AD3F;
	Wed, 19 Feb 2025 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nNfVzqzX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD531805A
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739930213; cv=none; b=fsLCkShqQV746Jeg+KtZxEhgbSCaE/UGn5I6oJIGZqcOQP7UWG/N60qJ7oOzQaPj9ytvUmIS/pFwHBT4k0Pg+Zhis3+jaXPcdtIRkrPedMsB2yBQYMEwZD269vG/iZq0gvaQsaFsDSPjY9wGRDNHswgvbxfNLgMUihX1sXLtAfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739930213; c=relaxed/simple;
	bh=RjKrX10xAZsxP+Ombn+hnyAS7cjpmMz0tdMYT1rquts=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ifeDQtTIRJq85Bx25NhPtZrU46EEonRAFLkU98y2XvE7SiUq6EJJ+N+dJxU7A4Ps+4nCwnKABajE9q48ZHUxz4WFuQ21mDYkPYoBs4Chu+wYR3zvWEbfyOE1hoNE9PVBdoJNwlxOkfJ1pit6PYJ3XuUawMxOuxO28tuKVXROjjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nNfVzqzX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2210121ac27so84387165ad.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 17:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739930210; x=1740535010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R4sbU8+ghlmDv9NSLmFmB+QprF2d3eMKIHbpFgk53yM=;
        b=nNfVzqzXPiu62zofTd+4gFIQ69Fpbbx0QT2UUL4u3sHDMH7yDhlbJQ7lBMASre3a/U
         qCcyScKbRmAlNvM8a7OrHtIOxCsco5t4YrOAz3ivH/N/nGxwsdz041W4iYQAS1UGczOd
         5gcewlgou78FydbEc2LDTxYGsNtdAoBTeA+Wd3cY6WkqvONn5eDLglvMGhNdghDkv9nZ
         AIc/csosWgm84HXMmkeuOCDbRLUJf6pV5GDFaO0oXO+14ulzdINrTdLhUm6v5tIpk4Tz
         b1qsSEC/0N97+ycqgOUeLyZPhP2b1xUSSOxNVu7drWPbLfbJt+mHZp4dRj5IuUe/d9+u
         rQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739930210; x=1740535010;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R4sbU8+ghlmDv9NSLmFmB+QprF2d3eMKIHbpFgk53yM=;
        b=nVdIzL4A3qzpyA7/ExohA9xPABBbKY0FIFQd3hbqLflfKUgdxdOrR8VVU9LzxlMCBl
         gfOJ/lTtnkFp4+YLP+bbXe7TvzqI/EZ/Bri5y/yAKkvrR8rV9z6xYKyn5wCku8JBoCrZ
         +6G4H8AcYezjoYLBQG1iOdy+HbBoxbxyIfCQs37HX9KYO6E2Boxnla46hwKULI3bfc0P
         8F2NX1zCvTo9PzYJZLUVuxtnQkZCnCNp+zGnqy2iV7uf2zktBHxsXCL3Wl2O6+EwyGws
         QWcLoyEw3mNSOD/Apo4/oMC1GlRWkpC4Eo6WB+p8zSnsCU0nFKY44wXvJqYuPgDSVgMk
         3z8w==
X-Forwarded-Encrypted: i=1; AJvYcCUiWavPSAuL480Cefj9vgSia0oa6feg/CqN/jSkLvslWoj9SHUkykdmF0NBzAFSMtIFSxGmbT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN9ANMbeTmoAQc9nTY5lDiROl1rsn3vzvViIk87Ib7jEIxahT3
	Ja92bmnxvQOqF0xjhbtdlU1Xo4DRdR87JFlhhHrTnhQvtLZX8MSrwjmZObDWX4FqyWvD9YahH4H
	hXXSo/Q==
X-Google-Smtp-Source: AGHT+IHwusq8TvByXS+oObv+tT2CwbzKd+vMm+jfp3nqE0gbGSDmazvjyhpMBkyYiEcGP66gT13ebFdFU0sn
X-Received: from pfra26.prod.google.com ([2002:aa7:8e9a:0:b0:730:b665:d832])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2450:b0:1ee:c390:589a
 with SMTP id adf61e73a8af0-1eed4ed2b90mr3222180637.22.1739930210494; Tue, 18
 Feb 2025 17:56:50 -0800 (PST)
Date: Wed, 19 Feb 2025 09:56:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219095610.v6.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Subject: [PATCH v6] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
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

Changes in v6:
- Fix EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL
- Use container_of() rather than dev_set_drvdata() + dev_get_drvdata()

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
 drivers/bluetooth/btusb.c                     | 114 +++++++++++++-----
 include/net/bluetooth/hci_core.h              |   1 +
 net/bluetooth/hci_sysfs.c                     |   3 +-
 4 files changed, 103 insertions(+), 28 deletions(-)

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
index de3fa725d210..15ea28545756 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -920,6 +920,8 @@ struct btusb_data {
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
 
 	struct qca_dump_info qca_dump;
+
+	struct device dev;
 };
 
 static void btusb_reset(struct hci_dev *hdev)
@@ -3682,7 +3684,7 @@ static ssize_t isoc_alt_show(struct device *dev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	struct btusb_data *data = dev_get_drvdata(dev);
+	struct btusb_data *data = container_of(dev, struct btusb_data, dev);
 
 	return sysfs_emit(buf, "%d\n", data->isoc_altsetting);
 }
@@ -3691,10 +3693,13 @@ static ssize_t isoc_alt_store(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
-	struct btusb_data *data = dev_get_drvdata(dev);
+	struct btusb_data *data = container_of(dev, struct btusb_data, dev);
 	int alt;
 	int ret;
 
+	if (!data->hdev)
+		return -ENODEV;
+
 	if (kstrtoint(buf, 10, &alt))
 		return -EINVAL;
 
@@ -3704,6 +3709,36 @@ static ssize_t isoc_alt_store(struct device *dev,
 
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
@@ -3745,7 +3780,7 @@ static int btusb_probe(struct usb_interface *intf,
 			return -ENODEV;
 	}
 
-	data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -3768,8 +3803,10 @@ static int btusb_probe(struct usb_interface *intf,
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
@@ -3823,16 +3860,46 @@ static int btusb_probe(struct usb_interface *intf,
 
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
@@ -3971,15 +4038,6 @@ static int btusb_probe(struct usb_interface *intf,
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
@@ -4012,9 +4070,6 @@ static int btusb_probe(struct usb_interface *intf,
 			set_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirks);
 	}
 
-	if (id->driver_info & BTUSB_BROKEN_ISOC)
-		data->isoc = NULL;
-
 	if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
@@ -4067,10 +4122,6 @@ static int btusb_probe(struct usb_interface *intf,
 						 data->isoc, data);
 		if (err < 0)
 			goto out_free_dev;
-
-		err = device_create_file(&intf->dev, &dev_attr_isoc_alt);
-		if (err)
-			goto out_free_dev;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4101,6 +4152,16 @@ static int btusb_probe(struct usb_interface *intf,
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
 
@@ -4117,10 +4178,8 @@ static void btusb_disconnect(struct usb_interface *intf)
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-	if (data->isoc) {
-		device_remove_file(&intf->dev, &dev_attr_isoc_alt);
+	if (data->isoc)
 		usb_set_intfdata(data->isoc, NULL);
-	}
 
 	if (data->diag)
 		usb_set_intfdata(data->diag, NULL);
@@ -4152,6 +4211,7 @@ static void btusb_disconnect(struct usb_interface *intf)
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
index 041ce9adc378..f8c2c1c3e887 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -6,9 +6,10 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-static const struct class bt_class = {
+const struct class bt_class = {
 	.name = "bluetooth",
 };
+EXPORT_SYMBOL_GPL(bt_class);
 
 static void bt_link_release(struct device *dev)
 {
-- 
2.48.1.601.g30ceb7b040-goog


