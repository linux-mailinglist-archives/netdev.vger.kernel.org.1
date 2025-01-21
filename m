Return-Path: <netdev+bounces-159969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A61FA17885
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 08:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1397E3ACED6
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 07:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74091B4124;
	Tue, 21 Jan 2025 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIuqSaka"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259551B1D65
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737443843; cv=none; b=lLYUjNrJxaHSM1JWrTPtvg10lpG3GiyFQErfAj4NBbefjHaeeoP3NxYt/Gva6vmT2wxCsS8odIFQkOnVSdv62THp4jhmrUePlbGVZpeCbiGL4WBV+SwqRQxCZT6ftFxQWs0KLrPMhmceGkbNqtg2GHj0IasR/BhkHFe5mE03Zy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737443843; c=relaxed/simple;
	bh=Dwx4RRUwHaqDwEUOrrQiQe9EvqOqneBkX4MudSge/o0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WENGlXQcETLbuVq1z5MBBRvmLv8qPpc89kbjQ0fX1IUiNyFOs9D1f/v0ynubp8G0Xc9Kln/oplhUXvxZICxD2wuEeZ35u/pQqhQadr4V9jwt8ojBTAhsMpE58Y9h8NfTK+vgOQ1N8ohZapFS/g+ecvqUCs2A4WXC9MO42amnDK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZIuqSaka; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-29fd2a9dd35so6457075fac.1
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 23:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737443840; x=1738048640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6POgZu70+PjVYcuU/158CQRyYRKdbK+Oy5JVkfz8x2Q=;
        b=ZIuqSakawIDhYUeC6qAIrofqPqduVd6B3i4auzPah10+Bfc66JMGtjR9HoDxHaN6aV
         xK8rpVAUjCG+dBO8EtYdaSqHd3dOZOIuBci8pvlDMxQ/xKgzybkvDErXyUAcwlHXTryg
         +JRfshzImht+jKbdu9MyLlR5V/27C3b87IQTPjFRP/8tQo1hMU7cFNj/zg+5snWbdsKA
         lF1nExi1pX/ti/r3jKu3xR8hHXhBu+XBDuPrThSzj7EREQZxJJJ3I9MjFqqOeTXS6D3S
         30R46O53NbWmC2xmPl8x1zd8XtNO5o5yofBy8cmWNBKzlmIY5QibdOeWNu6huB86MdM8
         N0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737443840; x=1738048640;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6POgZu70+PjVYcuU/158CQRyYRKdbK+Oy5JVkfz8x2Q=;
        b=EOVpdq2iXwl90gyIw1+pIyFY7rotvFRYee+KO7L7NPV2NyhBmkmLRewtTD9cMXwwc6
         7TkmmYg6Qmbt2KMgsZ1fDm/tqgfbyQEro0kM2rtq7tTbpNQeVWT+Z1QHXqdAhyjRzLky
         79Zf82AnR48udsSkDsJKdKkTwHLRvDQBQTOdBIqk1MQNSkA8Tj748M39TCb5v+faTULR
         ML52LGgb061byDzwPQeCD1eLWtPrgVCM1+NDw+G8Ja9ppHcNVQ+EeuQ1nrj2zQsKc0tw
         GDBQn5gu/CSJVg2LWQwxp1CkKM1EJNPCObKOP08ijxBEbSzL21D4A4K8nHVt84b1Fa3b
         KJdg==
X-Forwarded-Encrypted: i=1; AJvYcCXri9NUTemQQzDFmKMKC5n2/SSTERh2tUQ3O/9wVlFLemuP6EA2bM9FySN+p9dH7rTHUPKHb3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhrC1604YT7qKu+Z07WpE0a/toqHce4POVbVnWrls5248I5KX7
	tRC1QclgNWp6vTP4KOjbq2oh/j82krpbzuWNL/LwfsrvH00wA6nain21yUCxUzSpNjPmDJQh9GU
	0zx9Mtw==
X-Google-Smtp-Source: AGHT+IFM5tQbg1m5rXt6opXiz/QXmmzdu7N9SXAzDLFxdpUEPI/hJNCN2+XN/hDQZTjODt53IgRP6SkBcDmJ
X-Received: from oacpv10.prod.google.com ([2002:a05:6871:3a8a:b0:29d:cb27:3f14])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:ff84:b0:29f:b1d4:7710
 with SMTP id 586e51a60fabf-2b1c0c52266mr8855302fac.24.1737443840160; Mon, 20
 Jan 2025 23:17:20 -0800 (PST)
Date: Tue, 21 Jan 2025 15:15:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250121151532.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Subject: [PATCH 1/2] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
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

 drivers/bluetooth/btusb.c        | 42 ++++++++------------------------
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_sysfs.c        | 33 +++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9aa018d4f6f5..f419d0827ee4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2224,6 +2224,13 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
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
@@ -3646,32 +3653,6 @@ static const struct file_operations force_poll_sync_fops = {
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
@@ -4036,9 +4017,8 @@ static int btusb_probe(struct usb_interface *intf,
 		if (err < 0)
 			goto out_free_dev;
 
-		err = device_create_file(&intf->dev, &dev_attr_isoc_alt);
-		if (err)
-			goto out_free_dev;
+		hdev->switch_usb_alt_setting = btusb_switch_alt_setting;
+		hdev->read_usb_alt_setting = btusb_read_alt_setting;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4085,10 +4065,8 @@ static void btusb_disconnect(struct usb_interface *intf)
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-	if (data->isoc) {
-		device_remove_file(&intf->dev, &dev_attr_isoc_alt);
+	if (data->isoc)
 		usb_set_intfdata(data->isoc, NULL);
-	}
 
 	if (data->diag)
 		usb_set_intfdata(data->diag, NULL);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f756fac95488..5d3ec5ff5adb 100644
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
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 041ce9adc378..887aa1935b1e 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -102,8 +102,41 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
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
+	&dev_attr_isoc_alt.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(bt_host);
-- 
2.48.0.rc2.279.g1de40edade-goog


