Return-Path: <netdev+bounces-165787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1108A33653
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FD5167E1F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 03:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C32205E17;
	Thu, 13 Feb 2025 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QYx3Rq7N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595C204F82
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 03:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418252; cv=none; b=bIyPXseRklW2iQd5sCkQZMAIoV1q8wyWXKKOrt2lduL1zpgNvr5zyunQrliR3/BG1YahaXO+sW3p7HOQ/mgYV3wHs1+Sai+q1X9jt9KoMzLgq57j6VNOh9zD1etM6SKWbFY5owZ7OrA/YTAvZhSlAQmj0UjanZOJVIlGMGwRkHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418252; c=relaxed/simple;
	bh=0BW2M125WsliCB8ED4LdihaF0s69mMeqnQMjcrf6UQk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=niuugkGYFHclePR0eQuKXqgBQ7ki2pvcxAoHVKSTw1BVXYGF048CXu3A793oJvkYv3p0RGmRSVYo/lE64Ar5AVPvM8kZ/B8trobvr4Zz7xYA1MT01P4uaC++o8ZKoEYP/7qDadiVKoUmynk3Cw9/pFcRvoCK60z3Vp9XcF0Sisg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QYx3Rq7N; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa1c093f12so1480943a91.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 19:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739418249; x=1740023049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lsOLf4vzSChByZXaeUeGFRADTpIyzst12ye8nQJf8JM=;
        b=QYx3Rq7NZrkvqFYMRUMVgX5/RP5kpdFjLlWZj1Afh/SoaznCeF7UZBoWbXbDjjDNoH
         Mv8CpCQ8f23bBgyCdls+bWRV/zuzeCoT0Xa1OMCU+AXS65R+bJFbdZXsuvYqd9sK7Pjn
         GKJoUYC2BS1AH/2rZuuwfhvQB71vfkFIC4wNzaKgYg3WaP+xc3V6xtwZ2XP/a1MQXa8h
         1nWTybldaVfL+CknwbSWx0C0TNYQqN/pLmFLt4vBJy/5TCquNN8vTjKc4VC+ljjR18ZP
         +eLX2T4nK2/C8AHFaGO1+wPgfnoclb4Jijaz8oVwoV39obzC8QVcBBxZSPX9MGyc3kk3
         2XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739418249; x=1740023049;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsOLf4vzSChByZXaeUeGFRADTpIyzst12ye8nQJf8JM=;
        b=wmgSNcOuwYZKIHBtQi++Vf/mLFl+MrfMjz47uVmJMOFZF0TxZqaki5XxtzKCtTk+sQ
         ONgmp7MQDsUSwBKcTdwjKSpGXlqTRc8z/nJ2m/sLt8vo5ckUop7lzjrWqAO0cNvhCb6w
         5wvyICcexYiLJKCFrXkbW4TlBJUt//Ibd2wZhiBGXtuPxl/NWfYPRliqk4LB6EfAuwPr
         Hb5dwTZ2RmvqDDsFyuZdXvKGey6prH5dHX6bg7civ7Uh6qTZjQmj0c3TSZDLbUcY7N+j
         VJWuHiVnxOfjtPmbowOIboa/eGrO2QQyQdNiKsED29h5pWsnchBEzqLw36CcDm4fs2jZ
         xMYg==
X-Forwarded-Encrypted: i=1; AJvYcCXqspdkEWRGeMoRApdFxZ7y8olOEWWAHMoJnvFhp5x8HBRd1wEsnEvUo9mAQX8c/bvL58ONbR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+wt3YHbILpVZCDFDIZVuGey/TjIMg9AmpTCNcLt8NqGmFe5da
	2BJmB0QPVVRBKIy21staAEP2tCnMd6/VsIDxvJbUwvXekR1toshZSXr5ihI+ARpnz/RaqfW+4gt
	XHKYViw==
X-Google-Smtp-Source: AGHT+IFPhIYt5Rdxe8/DSnQSNBGl29ADwD9aPL9TkbgNFB6DiQH825XmJfmTGbqIE3tcb89hKtAyOL1xkHWN
X-Received: from pgpf9.prod.google.com ([2002:a65:4009:0:b0:ad5:4620:b05d])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:618f:b0:1e1:9fef:e960
 with SMTP id adf61e73a8af0-1ee5c733361mr10241161637.6.1739418249528; Wed, 12
 Feb 2025 19:44:09 -0800 (PST)
Date: Thu, 13 Feb 2025 11:43:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Subject: [PATCH v4 1/3] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
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

 drivers/bluetooth/btusb.c        | 98 +++++++++++++++++++++++++-------
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_sysfs.c        |  3 +-
 3 files changed, 79 insertions(+), 23 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1caf7a071a73..cb3db18bb72c 100644
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
 
@@ -3702,6 +3707,34 @@ static ssize_t isoc_alt_store(struct device *dev,
 
 static DEVICE_ATTR_RW(isoc_alt);
 
+static struct attribute *btusb_sysfs_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(btusb_sysfs);
+
+static void btusb_sysfs_release(struct device *dev)
+{
+	// Resource release is managed in btusb_disconnect
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
@@ -3821,16 +3854,47 @@ static int btusb_probe(struct usb_interface *intf,
 
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
+		return err;
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
@@ -3969,15 +4033,6 @@ static int btusb_probe(struct usb_interface *intf,
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
@@ -4010,9 +4065,6 @@ static int btusb_probe(struct usb_interface *intf,
 			set_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirks);
 	}
 
-	if (id->driver_info & BTUSB_BROKEN_ISOC)
-		data->isoc = NULL;
-
 	if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
@@ -4065,10 +4117,6 @@ static int btusb_probe(struct usb_interface *intf,
 						 data->isoc, data);
 		if (err < 0)
 			goto out_free_dev;
-
-		err = device_create_file(&intf->dev, &dev_attr_isoc_alt);
-		if (err)
-			goto out_free_dev;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4099,6 +4147,13 @@ static int btusb_probe(struct usb_interface *intf,
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
 	hci_free_dev(hdev);
+
+out_free_sysfs:
+	device_del(&data->dev);
+
+out_put_sysfs:
+	put_device(&data->dev);
+
 	return err;
 }
 
@@ -4115,10 +4170,8 @@ static void btusb_disconnect(struct usb_interface *intf)
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-	if (data->isoc) {
-		device_remove_file(&intf->dev, &dev_attr_isoc_alt);
+	if (data->isoc)
 		usb_set_intfdata(data->isoc, NULL);
-	}
 
 	if (data->diag)
 		usb_set_intfdata(data->diag, NULL);
@@ -4150,6 +4203,7 @@ static void btusb_disconnect(struct usb_interface *intf)
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
2.48.1.502.g6dc24dfdaf-goog


