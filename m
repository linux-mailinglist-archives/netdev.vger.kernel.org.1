Return-Path: <netdev+bounces-164644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C928A2E978
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A07D1888148
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECB21B040E;
	Mon, 10 Feb 2025 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pAcJdZXF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6889915624D
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183563; cv=none; b=Xzok/pOv5I+BzNhgo9Y7VfhpRp+vEHbZ9ib6bj3LCb/6BOfcYyS0Y/0E63fViv8TXyUvC1LHIvzlcDyl2Yrk6wZdrhOdj5mb2gK35KqSl+9kU+Cp2JG+cCNOhWnRMs9TdVsM1U7AWbpupQ+Rm21Rhe7JRACPcmpMs2k9dh0PxZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183563; c=relaxed/simple;
	bh=k6S24Di5Cdwbbg6ULAifEixC4TcQWv4S89+Lx7d6IdA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dfawrBHVhdo2zZhnWl6vqztQwnITj5WQaHCGA+5dKsISTtRJo8dQwlgMy1y6NU31xpiGCY0cpLAxPppI4fjtUrABky+kL7E+2yUqyfJuQ2iJ/M4TPvPCVAwo6q1P33TwxiwCYqXXlHqw2Z9Sxq2RwghW2oS8aksLIrYgP4tl/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pAcJdZXF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f6cd48c67so31946585ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 02:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739183561; x=1739788361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cYJwxxQlwIyZkX+HoEtBlpfUCxgrdmdHLu1+dW+gUMk=;
        b=pAcJdZXF3R/aNYbY9bEZxjR4tzoyeNI+a231dY+o5I6xBXHrQn7t+2oM4ea27z6HUG
         FJuuU49q8vwFHQnLs54CWY1vWIAPKZL3Edl9OEYZeFN1Mdk+kCSpof1fxHBqEG9B5WJ7
         PRDEVNSejYC5Jm/bkOt9RVS/1wtHPQCU/Hx2OxIioVApvFRtU3FoqVKVWeTHILDzJ466
         cI3Ll04HrMuj8e0B9dQg99Pev+GNM+J28gzZdRtkQYjhGIC6o854LE62qvTwHbCdEK9F
         uF3zcxmczRc0c/cmrIixV9yQzfRDzNZ+j/hj/oJ2lY/m/6KcgyGZ5EgvGzMRpHISumII
         7Wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739183561; x=1739788361;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYJwxxQlwIyZkX+HoEtBlpfUCxgrdmdHLu1+dW+gUMk=;
        b=KxcBZc9kJGzYqurZIGQBZ1hqjz5SH629nsgZ4OpIf5G0KYoDpV+mEi/4q0AAJWzUcz
         RG5H2JRWhFTFQJZcLwfOBr/mboG1fap+y+0LG4wTNPJIcsdpYXFDHB5sxQdMGuCZcUGV
         WfxEj2N3vi7oxYdJM7HPeet3o2sRz967HoyGFsjPiV5G183CYVbO8pzCYYCOO1WtCHaI
         aEDaZ2Nmp94nP+Pn8vLi5VZR+hNt14rn4KHJPF+90D4XeE60veAxSND8PbjaTqxjy0eo
         CQEUMd43uPYr3mOhmf4nTvSJ3L1l4QeDasBW3YcH1Y+NxMZan1XKlP7iWo4CKQ4cJrDV
         Psrg==
X-Forwarded-Encrypted: i=1; AJvYcCVkneZKHGVCJI4BzoyVk3wFapC43x8G8Gv/zRjMFjO19yFmNPiFdM3ZY69QjAMILHyWm0OfIBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4jYRC5XHenFjutXz5+X5A2JoZXTHnGXHVT7yaxRpheTPXZOPU
	2ZcmPfDO6h1QXdePAe0VFYIdvlyBRE/5RVIJX3uneVL4Hhdq5e5CjaK42JYtJqjzxsAbqD2NGpf
	XvwFnzQ==
X-Google-Smtp-Source: AGHT+IHr9Ul6LuFDhqG7/temf6lJOMuZo29msAazGLl3VQJ6PsAB+BlbP4aMj/SS+SnKlMb6S2LlRIK2wDw3
X-Received: from plaq3.prod.google.com ([2002:a17:903:2043:b0:216:2234:bf3e])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2d0:b0:21f:797f:9f45
 with SMTP id d9443c01a7336-21f797fa86bmr103526125ad.29.1739183560662; Mon, 10
 Feb 2025 02:32:40 -0800 (PST)
Date: Mon, 10 Feb 2025 18:32:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210183224.v3.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Subject: [PATCH v3 1/3] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Use device group to avoid the racing. To reuse the group defined in
hci_sysfs.c, defined 2 callbacks switch_usb_alt_setting and
read_usb_alt_setting which are only registered in btusb.

Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

Changes in v3:
- Make the attribute exported only when the isoc_alt is available.
- In btusb_probe, determine data->isoc before calling hci_alloc_dev_priv
  (which calls hci_init_sysfs).
- Since hci_init_sysfs is called before btusb could modify the hdev,
  add new argument add_isoc_alt_attr for btusb to inform hci_init_sysfs.

 drivers/bluetooth/btintel_pcie.c |  3 +-
 drivers/bluetooth/btusb.c        | 69 +++++++++++---------------------
 drivers/bluetooth/hci_serdev.c   |  2 +-
 include/net/bluetooth/hci_core.h |  8 ++--
 net/bluetooth/hci_core.c         |  4 +-
 net/bluetooth/hci_sysfs.c        | 52 +++++++++++++++++++++++-
 6 files changed, 84 insertions(+), 54 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index b8b241a92bf9..856de070b440 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1514,7 +1514,8 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	int err;
 	struct hci_dev *hdev;
 
-	hdev = hci_alloc_dev_priv(sizeof(struct btintel_data));
+	hdev = hci_alloc_dev_priv(sizeof(struct btintel_data),
+				  /* add_isoc_alt_attr = */ false);
 	if (!hdev)
 		return -ENOMEM;
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1caf7a071a73..a451403c62eb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2247,6 +2247,13 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
 	return 0;
 }
 
+static int btusb_read_alt_setting(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	return data->isoc_altsetting;
+}
+
 static struct usb_host_interface *btusb_find_altsetting(struct btusb_data *data,
 							int alt)
 {
@@ -3676,32 +3683,6 @@ static const struct file_operations force_poll_sync_fops = {
 	.llseek		= default_llseek,
 };
 
-static ssize_t isoc_alt_show(struct device *dev,
-			     struct device_attribute *attr,
-			     char *buf)
-{
-	struct btusb_data *data = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%d\n", data->isoc_altsetting);
-}
-
-static ssize_t isoc_alt_store(struct device *dev,
-			      struct device_attribute *attr,
-			      const char *buf, size_t count)
-{
-	struct btusb_data *data = dev_get_drvdata(dev);
-	int alt;
-	int ret;
-
-	if (kstrtoint(buf, 10, &alt))
-		return -EINVAL;
-
-	ret = btusb_switch_alt_setting(data->hdev, alt);
-	return ret < 0 ? ret : count;
-}
-
-static DEVICE_ATTR_RW(isoc_alt);
-
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -3821,7 +3802,20 @@ static int btusb_probe(struct usb_interface *intf,
 
 	data->recv_acl = hci_recv_frame;
 
-	hdev = hci_alloc_dev_priv(priv_size);
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
+	hdev = hci_alloc_dev_priv(priv_size,
+				  /* add_isoc_alt_attr = */ data->isoc);
 	if (!hdev)
 		return -ENOMEM;
 
@@ -3969,15 +3963,6 @@ static int btusb_probe(struct usb_interface *intf,
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
@@ -4010,9 +3995,6 @@ static int btusb_probe(struct usb_interface *intf,
 			set_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirks);
 	}
 
-	if (id->driver_info & BTUSB_BROKEN_ISOC)
-		data->isoc = NULL;
-
 	if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
@@ -4066,9 +4048,8 @@ static int btusb_probe(struct usb_interface *intf,
 		if (err < 0)
 			goto out_free_dev;
 
-		err = device_create_file(&intf->dev, &dev_attr_isoc_alt);
-		if (err)
-			goto out_free_dev;
+		hdev->switch_usb_alt_setting = btusb_switch_alt_setting;
+		hdev->read_usb_alt_setting = btusb_read_alt_setting;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4115,10 +4096,8 @@ static void btusb_disconnect(struct usb_interface *intf)
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-	if (data->isoc) {
-		device_remove_file(&intf->dev, &dev_attr_isoc_alt);
+	if (data->isoc)
 		usb_set_intfdata(data->isoc, NULL);
-	}
 
 	if (data->diag)
 		usb_set_intfdata(data->diag, NULL);
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 89a22e9b3253..41a4a91be4b8 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -326,7 +326,7 @@ int hci_uart_register_device_priv(struct hci_uart *hu,
 	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 
 	/* Initialize and register HCI device */
-	hdev = hci_alloc_dev_priv(sizeof_priv);
+	hdev = hci_alloc_dev_priv(sizeof_priv, /* add_isoc_alt_attr = */ false);
 	if (!hdev) {
 		BT_ERR("Can't allocate HCI device");
 		err = -ENOMEM;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 05919848ea95..2a596ea40308 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -641,6 +641,8 @@ struct hci_dev {
 				     struct bt_codec *codec, __u8 *vnd_len,
 				     __u8 **vnd_data);
 	u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*switch_usb_alt_setting)(struct hci_dev *hdev, int new_alts);
+	int (*read_usb_alt_setting)(struct hci_dev *hdev);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
@@ -1686,11 +1688,11 @@ static inline void *hci_get_priv(struct hci_dev *hdev)
 struct hci_dev *hci_dev_get(int index);
 struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, u8 src_type);
 
-struct hci_dev *hci_alloc_dev_priv(int sizeof_priv);
+struct hci_dev *hci_alloc_dev_priv(int sizeof_priv, bool add_isoc_alt_attr);
 
 static inline struct hci_dev *hci_alloc_dev(void)
 {
-	return hci_alloc_dev_priv(0);
+	return hci_alloc_dev_priv(0, /* add_isoc_alt_attr = */ false);
 }
 
 void hci_free_dev(struct hci_dev *hdev);
@@ -1843,7 +1845,7 @@ int hci_get_adv_monitor_offload_ext(struct hci_dev *hdev);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
-void hci_init_sysfs(struct hci_dev *hdev);
+void hci_init_sysfs(struct hci_dev *hdev, bool add_isoc_alt_attr);
 void hci_conn_init_sysfs(struct hci_conn *conn);
 void hci_conn_add_sysfs(struct hci_conn *conn);
 void hci_conn_del_sysfs(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e7ec12437c8b..7c90391721ba 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2405,7 +2405,7 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 }
 
 /* Alloc HCI device */
-struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
+struct hci_dev *hci_alloc_dev_priv(int sizeof_priv, bool add_isoc_alt_attr)
 {
 	struct hci_dev *hdev;
 	unsigned int alloc_size;
@@ -2530,7 +2530,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 
 	hci_devcd_setup(hdev);
 
-	hci_init_sysfs(hdev);
+	hci_init_sysfs(hdev, add_isoc_alt_attr);
 	discovery_init(hdev);
 
 	return hdev;
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 041ce9adc378..3242f1ce00b2 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -102,6 +102,38 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(reset);
 
+static ssize_t isoc_alt_show(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct hci_dev *hdev = to_hci_dev(dev);
+
+	if (hdev->read_usb_alt_setting)
+		return sysfs_emit(buf, "%d\n", hdev->read_usb_alt_setting(hdev));
+
+	return -ENODEV;
+}
+
+static ssize_t isoc_alt_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct hci_dev *hdev = to_hci_dev(dev);
+	int alt;
+	int ret;
+
+	if (kstrtoint(buf, 10, &alt))
+		return -EINVAL;
+
+	if (hdev->switch_usb_alt_setting) {
+		ret = hdev->switch_usb_alt_setting(hdev, alt);
+		return ret < 0 ? ret : count;
+	}
+
+	return -ENODEV;
+}
+static DEVICE_ATTR_RW(isoc_alt);
+
 static struct attribute *bt_host_attrs[] = {
 	&dev_attr_reset.attr,
 	NULL,
@@ -114,11 +146,27 @@ static const struct device_type bt_host = {
 	.groups = bt_host_groups,
 };
 
-void hci_init_sysfs(struct hci_dev *hdev)
+static struct attribute *bt_host_isoc_alt_attrs[] = {
+	&dev_attr_reset.attr,
+	&dev_attr_isoc_alt.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(bt_host_isoc_alt);
+
+static const struct device_type bt_host_isoc_alt = {
+	.name    = "host",
+	.release = bt_host_release,
+	.groups  = bt_host_isoc_alt_groups,
+};
+
+void hci_init_sysfs(struct hci_dev *hdev, bool add_isoc_alt_attr)
 {
 	struct device *dev = &hdev->dev;
 
-	dev->type = &bt_host;
+	if (add_isoc_alt_attr)
+		dev->type = &bt_host_isoc_alt;
+	else
+		dev->type = &bt_host;
 	dev->class = &bt_class;
 
 	__module_get(THIS_MODULE);
-- 
2.48.1.502.g6dc24dfdaf-goog


